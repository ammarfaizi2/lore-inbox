Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUDNX31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUDNW1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:27:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:43679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261969AbUDNWZD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:03 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814502649@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:10 -0700
Message-Id: <10819814502077@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.9, 2004/03/30 14:26:52-08:00, khali@linux-fr.org

[PATCH] I2C: i2c documentation update (2/2)

Here is a patch to Documentation/i2c/sysfs-interface. This is mostly my
intent to make the document more readable. There are also a few
incorrectnesses fixed, and some comments added.


 Documentation/i2c/sysfs-interface |   78 ++++++++++++++++++--------------------
 1 files changed, 37 insertions(+), 41 deletions(-)


diff -Nru a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-interface
--- a/Documentation/i2c/sysfs-interface	Wed Apr 14 15:14:16 2004
+++ b/Documentation/i2c/sysfs-interface	Wed Apr 14 15:14:16 2004
@@ -74,18 +74,15 @@
 ************
 
 in[0-8]_min	Voltage min value.
-		Fixed point value in form XXXX.  Divide by 1000 to get
-		Volts.
+		Unit: millivolt
 		Read/Write
 		
 in[0-8]_max	Voltage max value.
-		Fixed point value in form XXXX.  Divide by 1000 to get
-		Volts.
+		Unit: millivolt
 		Read/Write
 		
 in[0-8]_input	Voltage input value.
-		Fixed point value in form XXXX.  Divide by 1000 to get
-		Volts.
+		Unit: millivolt
 		Read only
 		Actual voltage depends on the scaling resistors on the
 		motherboard, as recommended in the chip datasheet.
@@ -95,10 +92,10 @@
 		However, some drivers (notably lm87 and via686a)
 		do scale, with various degrees of success.
 		These drivers will output the actual voltage.
-		First two values are read/write and third is read only.
+
 		Typical usage:
 			in0_*	CPU #1 voltage (not scaled)
-			in1_*	CPU #1 voltage (not scaled)
+			in1_*	CPU #2 voltage (not scaled)
 			in2_*	3.3V nominal (not scaled)
 			in3_*	5.0V nominal (scaled)
 			in4_*	12.0V nominal (scaled)
@@ -108,17 +105,16 @@
 			in8_*	varies
 
 in0_ref		CPU core reference voltage.
+		Unit: millivolt
 		Read only.
-		Fixed point value in form XXXX corresponding to CPU core
-		voltage as told to the sensor chip.  Divide by 1000 to
-		get Volts.  Not always correct.
+		Not always correct.
 
 vrm		Voltage Regulator Module version number. 
 		Read only.
-		Two digit number (XX), first is major version, second is
+		Two digit number, first is major version, second is
 		minor version.
-		Affects the way the driver calculates the core voltage from
-		the vid pins. See doc/vid for details.
+		Affects the way the driver calculates the CPU core reference
+		voltage from the vid pins.
 
 
 ********
@@ -126,23 +122,23 @@
 ********
 
 fan[1-3]_min	Fan minimum value
-		Integer value indicating RPM
+		Unit: revolution/min (RPM)
 		Read/Write.
 
 fan[1-3]_input	Fan input value.
-		Integer value indicating RPM
+		Unit: revolution/min (RPM)
 		Read only.
 
 fan[1-3]_div	Fan divisor.
-		Integers in powers of two (1,2,4,8,16,32,64,128).
-		Some chips only support values 1,2,4,8.
-		See doc/fan-divisors for details.
+		Integer value in powers of two (1, 2, 4, 8, 16, 32, 64, 128).
+		Some chips only support values 1, 2, 4 and 8.
+		Note that this is actually an internal clock divisor, which
+		affects the measurable speed range, not the read value.
 
 fan[1-3]_pwm	Pulse width modulation fan control.
-		Integer 0 - 255
+		Integer value in the range 0 to 255
 		Read/Write
 		255 is max or 100%.
-		Corresponds to the fans 1-3.
 
 fan[1-3]_pwm_enable
 		Switch PWM on and off.
@@ -157,46 +153,46 @@
 ****************
 
 temp[1-3]_type	Sensor type selection.
-		Integers 1,2,3, or thermistor Beta value (3435)
+		Integers 1, 2, 3 or thermistor Beta value (3435)
 		Read/Write.
+		1: PII/Celeron Diode
+		2: 3904 transistor
+		3: thermal diode
+		Not all types are supported by all chips
 
 temp[1-4]_max	Temperature max value.
-		Fixed point value in form XXXXX and should be divided by
-		1000 to get degrees Celsius.
+		Unit: millidegree Celcius
 		Read/Write value.
 
 temp[1-3]_min	Temperature min value.
-		Fixed point value in form XXXXX and should be divided by
-		1000 to get degrees Celsius.
+		Unit: millidegree Celcius
 		Read/Write value.
 
 temp[1-3]_max_hyst
 		Temperature hysteresis value for max limit.
-		Fixed point value in form XXXXX and should be divided by
-		1000 to get degrees Celsius.  Must be reported as an
-		absolute temperature, NOT a delta from the max value.
+		Unit: millidegree Celcius
+		Must be reported as an absolute temperature, NOT a delta
+		from the max value.
 		Read/Write value.
 
 temp[1-4]_input Temperature input value.
-		Fixed point value in form XXXXX and should be divided by
-		1000 to get degrees Celsius.
+		Unit: millidegree Celcius
 		Read only value.
 
 temp[1-4]_crit	Temperature critical value, typically greater than
 		corresponding temp_max values.
-		Fixed point value in form XXXXX and should be divided by
-		1000 to get degrees Celsius.
+		Unit: millidegree Celcius
 		Read/Write value.
 
 temp[1-2]_crit_hyst
 		Temperature hysteresis value for critical limit.
-		Fixed point value in form XXXXX and should be divided by
-		1000 to get degrees Celsius.  Must be reported as an
-		absolute temperature, NOT a delta from the critical value.
+		Unit: millidegree Celcius
+		Must be reported as an absolute temperature, NOT a delta
+		from the critical value.
 		Read/Write value.
 
 		If there are multiple temperature sensors, temp1_* is
-		generally the sensor inside the chip itself, generally
+		generally the sensor inside the chip itself,
 		reported as "motherboard temperature".  temp2_* to
 		temp4_* are generally sensors external to the chip
 		itself, for example the thermal diode inside the CPU or
@@ -211,15 +207,15 @@
 so this part is theoretical, so to say.
 
 curr[1-n]_max	Current max value
-		Fixed point XXXXX, divide by 1000 to get Amps.
+		Unit: milliampere
 		Read/Write.
 
 curr[1-n]_min	Current min value.
-		Fixed point XXXXX, divide by 1000 to get Amps.
+		Unit: milliampere
 		Read/Write.
 
 curr[1-n]_input	Current input value
-		Fixed point XXXXX, divide by 1000 to get Amps.
+		Unit: milliampere
 		Read only.
 
 
@@ -246,7 +242,7 @@
 
 beep_mask	Bitmask for beep.
 		Same format as 'alarms' with the same bit locations.
-		Read only.
+		Read/Write
 
 eeprom		Raw EEPROM data in binary form.
 		Read only.

