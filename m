Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbTL3WIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTL3WG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:06:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:44993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265832AbTL3WG0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:26 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219722179@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:13 -0800
Message-Id: <10728219731748@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.9.3, 2003/12/04 13:41:40-08:00, khali@linux-fr.org

[PATCH] I2C: sysfs interface documentation

1* No more current hysteresis value. I don't think we ever saw a chip
   which monitors current, and if we ever do, I would be very, very
   surprised if it would have an hysteresis value.
2* Temperature input and max can have 4 values. [from the previous
   patch]
3* Split temperature min and hysteresis into two separate files.
4* New file temp_crit. [from previous patch]

The new file temp_crit is subject to change later as we decide more
precisely how we want to handle values that are common to more than one
temperature channels.


 Documentation/i2c/sysfs-interface |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)


diff -Nru a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-interface
--- a/Documentation/i2c/sysfs-interface	Tue Dec 30 12:32:18 2003
+++ b/Documentation/i2c/sysfs-interface	Tue Dec 30 12:32:18 2003
@@ -68,9 +68,7 @@
 		Fixed point XXXXX, divide by 1000 to get Amps.
 		Read/Write.
 
-curr_min[1-n]	Current min or hysteresis value.
-		Preferably a hysteresis value, reported as a absolute
-		current, NOT a delta from the max value.
+curr_min[1-n]	Current min value.
 		Fixed point XXXXX, divide by 1000 to get Amps.
 		Read/Write.
 
@@ -144,25 +142,38 @@
 		Integers 1,2,3, or thermistor Beta value (3435)
 		Read/Write.
 
-temp_max[1-3]	Temperature max value.
+temp_max[1-4]	Temperature max value.
 		Fixed point value in form XXXXX and should be divided by
 		1000 to get degrees Celsius.
 		Read/Write value.
 
-temp_min[1-3]	Temperature min or hysteresis value.
+temp_min[1-3]	Temperature min value.
 		Fixed point value in form XXXXX and should be divided by
-		1000 to get degrees Celsius.  This is preferably a
-		hysteresis value, reported as a absolute temperature,
-		NOT a delta from the max value.
+		1000 to get degrees Celsius.
 		Read/Write value.
 
-temp_input[1-3] Temperature input value.
+temp_hyst[1-3]	Temperature hysteresis value.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.  Must be reported as an
+		absolute temperature, NOT a delta from the max value.
+		Read/Write value.
+
+temp_input[1-4] Temperature input value.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.
 		Read only value.
 
+temp_crit	Temperature critical value, typically greater than all
+		temp_max values.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.
+		Common to all temperature channels.
+		Read/Write value.
+
 		If there are multiple temperature sensors, temp_*1 is
 		generally the sensor inside the chip itself, generally
-		reported as "motherboard temperature".  temp_*2 and
-		temp_*3 are generally sensors external to the chip
+		reported as "motherboard temperature".  temp_*2 to
+		temp_*4 are generally sensors external to the chip
 		itself, for example the thermal diode inside the CPU or
 		a thermistor nearby.
 

