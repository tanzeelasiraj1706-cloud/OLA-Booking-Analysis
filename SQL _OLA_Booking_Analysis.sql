create Database ola;


DROP TABLE IF EXISTS bookings;

CREATE TABLE bookings (
    date DATE,
    time TIME,
    booking_id VARCHAR(50),
    booking_status VARCHAR(50),
    customer_id VARCHAR(50),
    vehicle_type VARCHAR(50),
    pickup_location VARCHAR(100),
    drop_location VARCHAR(100),
    canceled_rides_by_customer VARCHAR(100),
    canceled_rides_by_driver VARCHAR(100),
    booking_value NUMERIC(10,2)
);

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'bookings'
ORDER BY ordinal_position;


ALTER TABLE bookings
DROP COLUMN incomplete_rides;

SELECT COUNT(*) FROM bookings;


#1. Retrieve all successful bookings;
Create View Successful_Bookings As
SELECT * FROM bookings
WHERE Booking_Status = 'Success';

SELECT * FROM successful_bookings;

#2. Get the total number of cancelled rides by customers;

Create View cancelled_rides_by_customers As
SELECT COUNT(*) FROM bookings
WHERE Booking_Status = 'cancelled by Customer';

SELECT * FROM cancelled_rides_by_customers;

#3. List the top 5 customers who booked the highest number of rides;

Create View Top_5_Customers As
SELECT Customer_ID, COUNT(Booking_ID) as total_rides FROM bookings
GROUP BY Customer_ID
ORDER BY total_rides DESC LIMIT 5;

SELECT * FROM top_5_customers;

#4. Get the number of rides cancelled by drivers due to personal and car-related issues;

CREATE VIEW driver_cancelled_rides AS SELECT
    canceled_rides_by_driver,
    COUNT(*) AS total_rides FROM bookings
WHERE canceled_rides_by_driver IS NOT NULL
GROUP BY canceled_rides_by_driver
ORDER BY total_rides DESC;

SELECT * FROM driver_cancelled_rides;

#5.Find the average booking value for each vehicle type;

CREATE VIEW avg_booking_value_by_vehicle AS
SELECT vehicle_type,
    AVG(booking_value) AS average_booking_value FROM bookings
GROUP BY vehicle_type
ORDER BY average_booking_value DESC;

SELECT * FROM avg_booking_value_by_vehicle;

#6. Calculate the total booking value of successfully completed rides for each vehicle type.”

CREATE VIEW successful_revenue_by_vehicle AS
SELECT
    vehicle_type, SUM(booking_value) AS total_booking_value
FROM bookings WHERE booking_status = 'Success'
GROUP BY vehicle_type ORDER BY total_booking_value DESC;

SELECT * FROM successful_revenue_by_vehicle;

#7.Average booking value of successful rides;

CREATE VIEW avg_booking_value_successful AS
SELECT AVG(booking_value) AS average_booking_value
FROM bookings
WHERE booking_status = 'Success';

SELECT * FROM avg_booking_value_successful;

#8Find the top 5 customers with the highest total booking value;

CREATE VIEW top_5_customers_by_revenue AS
SELECT
    customer_id, SUM(booking_value) AS total_booking_value
FROM bookings GROUP BY customer_id
ORDER BY total_booking_value DESC LIMIT 5;

SELECT * FROM top_5_customers_by_revenue;