

##
## Coursera/Johns Hopkins Data Science/4. Exploratory Data Analysis/Assignment 1
##
## plot3.R - creates third plot graphic


## variables
wd <- getwd() # ExData_Plotting1 is not working directory.  It is one of several
              # directories for the class, all managed as a single repository
subdir              <- "ExData_Plotting1"
data_zipfilename    <- "household_power_consumption.zip"
data_filename       <- "household_power_consumption.txt"
data_url            <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data_zipfilepath    <- file.path(wd,subdir,data_zipfilename)
data_filepath       <- file.path(wd,subdir,data_filename)
days                <- (c("1/2/2007","2/2/2007"))
plot_filepath       <- file.path(wd,subdir,"plot3.png")

## download and unzip data file

# to avoid repeated downloads, do not download if zip file already exists locally
if (!file.exists(data_zipfilepath)){
  download.file(data_url,data_zipfilepath)
}

# to avoid repeated downloads, do not download if txt file already exists locally
if (!file.exists(data_filepath)){
  unzip(data_zipfilepath, data_filename, exdir = subdir)  
}


## read data file.  
data  <- read.table(data_filepath, 
                    header = TRUE, 
                    sep=";", 
                    na.string = "?", 
                    colClasses = c("character", "character", "numeric",
                                   "numeric","numeric","numeric",
                                   "numeric","numeric","numeric"))

## subset dataframe to just the two days under analysis
data_subset <- data[data$Date %in% days, 1:ncol(data)]

## add column with date and time combined as POSIXct
data_subset$datetime <- as.POSIXct(paste(data_subset$Date,data_subset$Time), 
                                   format = "%d/%m/%Y %H:%M:%S")

## create plot
png(filename=plot_filepath)
plot(data_subset$datetime,
     data_subset$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")
lines(data_subset$datetime,
      data_subset$Sub_metering_2,
      col="red")
lines(data_subset$datetime,
      data_subset$Sub_metering_3,
      col="blue")
legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"))
dev.off()
