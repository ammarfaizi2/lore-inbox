Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbUCPBiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbUCPBix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:38:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:29359 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262904AbUCPACf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:35 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913923994@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:32 -0800
Message-Id: <1079391392277@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.16, 2004/02/23 16:42:39-08:00, khali@linux-fr.org

[PATCH] I2C: rename sysfs files, part 1 of 2

Here it is. The associated libsensors patch is here:
http://jdelvare.net1.nerim.net/sensors/libsensors-sysfs-names-1.diff
(not applied yet, on purpose)


 Documentation/i2c/sysfs-interface |   54 ++++++++--------
 drivers/i2c/chips/adm1021.c       |   24 +++----
 drivers/i2c/chips/asb100.c        |   40 +++++------
 drivers/i2c/chips/fscher.c        |   92 +++++++++++++--------------
 drivers/i2c/chips/gl518sm.c       |   88 +++++++++++++-------------
 drivers/i2c/chips/it87.c          |  104 +++++++++++++++---------------
 drivers/i2c/chips/lm75.c          |   12 +--
 drivers/i2c/chips/lm78.c          |   88 +++++++++++++-------------
 drivers/i2c/chips/lm80.c          |  128 +++++++++++++++++++-------------------
 drivers/i2c/chips/lm83.c          |   32 ++++-----
 drivers/i2c/chips/lm85.c          |   88 +++++++++++++-------------
 drivers/i2c/chips/lm90.c          |   40 +++++------
 drivers/i2c/chips/via686a.c       |   78 +++++++++++------------
 drivers/i2c/chips/w83781d.c       |   36 +++++-----
 drivers/i2c/chips/w83l785ts.c     |    8 +-
 15 files changed, 456 insertions(+), 456 deletions(-)


diff -Nru a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-interface
--- a/Documentation/i2c/sysfs-interface	Mon Mar 15 14:36:23 2004
+++ b/Documentation/i2c/sysfs-interface	Mon Mar 15 14:36:23 2004
@@ -50,7 +50,7 @@
 of the values, you should divide by the specified value.
 
 There is only one value per file, unlike the older /proc specification.
-The common scheme for files naming is: <type>_<item><number>. Usual
+The common scheme for files naming is: <type><number>_<item>. Usual
 types for sensor chips are "in" (voltage), "temp" (temperature) and
 "fan" (fan). Usual items are "input" (measured value), "max" (high
 threshold, "min" (low threshold). Numbering usually starts from 1,
@@ -73,17 +73,17 @@
 * Voltages *
 ************
 
-in_min[0-8]	Voltage min value.
+in[0-8]_min	Voltage min value.
 		Fixed point value in form XXXX.  Divide by 1000 to get
 		Volts.
 		Read/Write
 		
-in_max[0-8]	Voltage max value.
+in[0-8]_max	Voltage max value.
 		Fixed point value in form XXXX.  Divide by 1000 to get
 		Volts.
 		Read/Write
 		
-in_input[0-8]	Voltage input value.
+in[0-8]_input	Voltage input value.
 		Fixed point value in form XXXX.  Divide by 1000 to get
 		Volts.
 		Read only
@@ -97,15 +97,15 @@
 		These drivers will output the actual voltage.
 		First two values are read/write and third is read only.
 		Typical usage:
-			in_*0	CPU #1 voltage (not scaled)
-			in_*1	CPU #1 voltage (not scaled)
-			in_*2	3.3V nominal (not scaled)
-			in_*3	5.0V nominal (scaled)
-			in_*4	12.0V nominal (scaled)
-			in_*5	-12.0V nominal (scaled)
-			in_*6	-5.0V nominal (scaled)
-			in_*7	varies
-			in_*8	varies
+			in0_*	CPU #1 voltage (not scaled)
+			in1_*	CPU #1 voltage (not scaled)
+			in2_*	3.3V nominal (not scaled)
+			in3_*	5.0V nominal (scaled)
+			in4_*	12.0V nominal (scaled)
+			in5_*	-12.0V nominal (scaled)
+			in6_*	-5.0V nominal (scaled)
+			in7_*	varies
+			in8_*	varies
 
 vid		CPU core voltage.
 		Read only.
@@ -125,15 +125,15 @@
 * Fans *
 ********
 
-fan_min[1-3]	Fan minimum value
+fan[1-3]_min	Fan minimum value
 		Integer value indicating RPM
 		Read/Write.
 
-fan_input[1-3]	Fan input value.
+fan[1-3]_input	Fan input value.
 		Integer value indicating RPM
 		Read only.
 
-fan_div[1-3]	Fan divisor.
+fan[1-3]_div	Fan divisor.
 		Integers in powers of two (1,2,4,8,16,32,64,128).
 		Some chips only support values 1,2,4,8.
 		See doc/fan-divisors for details.
@@ -144,7 +144,7 @@
 		255 is max or 100%.
 		Corresponds to the fans 1-3.
 
-pwm_enable[1-3] pwm enable
+pwm[1-3]_enable pwm enable
 		not always present even if pwm* is.
 		0 to turn off
 		1 to turn on
@@ -159,23 +159,23 @@
 		Integers 1,2,3, or thermistor Beta value (3435)
 		Read/Write.
 
-temp_max[1-4]	Temperature max value.
+temp[1-4]_max	Temperature max value.
 		Fixed point value in form XXXXX and should be divided by
 		1000 to get degrees Celsius.
 		Read/Write value.
 
-temp_min[1-3]	Temperature min value.
+temp[1-3]_min	Temperature min value.
 		Fixed point value in form XXXXX and should be divided by
 		1000 to get degrees Celsius.
 		Read/Write value.
 
-temp_hyst[1-3]	Temperature hysteresis value.
+temp[1-3]_hyst	Temperature hysteresis value.
 		Fixed point value in form XXXXX and should be divided by
 		1000 to get degrees Celsius.  Must be reported as an
 		absolute temperature, NOT a delta from the max value.
 		Read/Write value.
 
-temp_input[1-4] Temperature input value.
+temp[1-4]_input Temperature input value.
 		Fixed point value in form XXXXX and should be divided by
 		1000 to get degrees Celsius.
 		Read only value.
@@ -187,10 +187,10 @@
 		Common to all temperature channels.
 		Read/Write value.
 
-		If there are multiple temperature sensors, temp_*1 is
+		If there are multiple temperature sensors, temp1_* is
 		generally the sensor inside the chip itself, generally
-		reported as "motherboard temperature".  temp_*2 to
-		temp_*4 are generally sensors external to the chip
+		reported as "motherboard temperature".  temp2_* to
+		temp4_* are generally sensors external to the chip
 		itself, for example the thermal diode inside the CPU or
 		a thermistor nearby.
 
@@ -202,15 +202,15 @@
 Note that no known chip provides current measurements as of writing,
 so this part is theoretical, so to say.
 
-curr_max[1-n]	Current max value
+curr[1-n]_max	Current max value
 		Fixed point XXXXX, divide by 1000 to get Amps.
 		Read/Write.
 
-curr_min[1-n]	Current min value.
+curr[1-n]_min	Current min value.
 		Fixed point XXXXX, divide by 1000 to get Amps.
 		Read/Write.
 
-curr_input[1-n]	Current input value
+curr[1-n]_input	Current input value
 		Fixed point XXXXX, divide by 1000 to get Amps.
 		Read only.
 
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/adm1021.c	Mon Mar 15 14:36:23 2004
@@ -206,12 +206,12 @@
 set(remote_temp_max, ADM1021_REG_REMOTE_TOS_W);
 set(remote_temp_hyst, ADM1021_REG_REMOTE_THYST_W);
 
-static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp_min1, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
-static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input, NULL);
-static DEVICE_ATTR(temp_max2, S_IWUSR | S_IRUGO, show_remote_temp_max, set_remote_temp_max);
-static DEVICE_ATTR(temp_min2, S_IWUSR | S_IRUGO, show_remote_temp_hyst, set_remote_temp_hyst);
-static DEVICE_ATTR(temp_input2, S_IRUGO, show_remote_temp_input, NULL);
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_remote_temp_max, set_remote_temp_max);
+static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_remote_temp_hyst, set_remote_temp_hyst);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote_temp_input, NULL);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 static DEVICE_ATTR(die_code, S_IRUGO, show_die_code, NULL);
 
@@ -331,12 +331,12 @@
 	adm1021_init_client(new_client);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_min1);
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max2);
-	device_create_file(&new_client->dev, &dev_attr_temp_min2);
-	device_create_file(&new_client->dev, &dev_attr_temp_input2);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_min);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_min);
+	device_create_file(&new_client->dev, &dev_attr_temp2_input);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	if (data->type == adm1021)
 		device_create_file(&new_client->dev, &dev_attr_die_code);
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/asb100.c	Mon Mar 15 14:36:23 2004
@@ -274,7 +274,7 @@
 { \
 	return show_in(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(in_input##offset, S_IRUGO, \
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
 		show_in##offset, NULL) \
 static ssize_t \
 	show_in##offset##_min (struct device *dev, char *buf) \
@@ -296,9 +296,9 @@
 { \
 	return set_in_max(dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
 		show_in##offset##_min, set_in##offset##_min) \
-static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, \
 		show_in##offset##_max, set_in##offset##_max)
 
 sysfs_in(0)
@@ -310,9 +310,9 @@
 sysfs_in(6)
 
 #define device_create_file_in(client, offset) do { \
-	device_create_file(&client->dev, &dev_attr_in_input##offset); \
-	device_create_file(&client->dev, &dev_attr_in_min##offset); \
-	device_create_file(&client->dev, &dev_attr_in_max##offset); \
+	device_create_file(&client->dev, &dev_attr_in##offset##_input); \
+	device_create_file(&client->dev, &dev_attr_in##offset##_min); \
+	device_create_file(&client->dev, &dev_attr_in##offset##_max); \
 } while (0)
 
 /* 3 Fans */
@@ -412,11 +412,11 @@
 { \
 	return set_fan_div(dev, buf, count, offset - 1); \
 } \
-static DEVICE_ATTR(fan_input##offset, S_IRUGO, \
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
 		show_fan##offset, NULL) \
-static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
 		show_fan##offset##_min, set_fan##offset##_min) \
-static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
 		show_fan##offset##_div, set_fan##offset##_div)
 
 sysfs_fan(1)
@@ -424,9 +424,9 @@
 sysfs_fan(3)
 
 #define device_create_file_fan(client, offset) do { \
-	device_create_file(&client->dev, &dev_attr_fan_input##offset); \
-	device_create_file(&client->dev, &dev_attr_fan_min##offset); \
-	device_create_file(&client->dev, &dev_attr_fan_div##offset); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
 } while (0)
 
 /* 4 Temp. Sensors */
@@ -484,7 +484,7 @@
 { \
 	return show_temp(dev, buf, num-1); \
 } \
-static DEVICE_ATTR(temp_input##num, S_IRUGO, show_temp##num, NULL) \
+static DEVICE_ATTR(temp##num##_input, S_IRUGO, show_temp##num, NULL) \
 static ssize_t show_temp_max##num(struct device *dev, char *buf) \
 { \
 	return show_temp_max(dev, buf, num-1); \
@@ -494,7 +494,7 @@
 { \
 	return set_temp_max(dev, buf, count, num-1); \
 } \
-static DEVICE_ATTR(temp_max##num, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(temp##num##_max, S_IRUGO | S_IWUSR, \
 		show_temp_max##num, set_temp_max##num) \
 static ssize_t show_temp_hyst##num(struct device *dev, char *buf) \
 { \
@@ -505,7 +505,7 @@
 { \
 	return set_temp_hyst(dev, buf, count, num-1); \
 } \
-static DEVICE_ATTR(temp_hyst##num, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(temp##num##_hyst, S_IRUGO | S_IWUSR, \
 		show_temp_hyst##num, set_temp_hyst##num)
 
 sysfs_temp(1)
@@ -515,9 +515,9 @@
 
 /* VID */
 #define device_create_file_temp(client, num) do { \
-	device_create_file(&client->dev, &dev_attr_temp_input##num); \
-	device_create_file(&client->dev, &dev_attr_temp_max##num); \
-	device_create_file(&client->dev, &dev_attr_temp_hyst##num); \
+	device_create_file(&client->dev, &dev_attr_temp##num##_input); \
+	device_create_file(&client->dev, &dev_attr_temp##num##_max); \
+	device_create_file(&client->dev, &dev_attr_temp##num##_hyst); \
 } while (0)
 
 static ssize_t show_vid(struct device *dev, char *buf)
@@ -598,11 +598,11 @@
 }
 
 static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1)
-static DEVICE_ATTR(pwm_enable1, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 		show_pwm_enable1, set_pwm_enable1)
 #define device_create_file_pwm1(client) do { \
 	device_create_file(&new_client->dev, &dev_attr_pwm1); \
-	device_create_file(&new_client->dev, &dev_attr_pwm_enable1); \
+	device_create_file(&new_client->dev, &dev_attr_pwm1_enable); \
 } while (0)
 
 /* This function is called when:
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/fscher.c	Mon Mar 15 14:36:23 2004
@@ -165,71 +165,71 @@
  * Sysfs stuff
  */
 
-#define sysfs_r(kind, offset, reg) \
-static ssize_t show_##kind (struct fscher_data *, char *, int); \
-static ssize_t show_##kind##offset (struct device *, char *); \
-static ssize_t show_##kind##offset (struct device *dev, char *buf) \
+#define sysfs_r(kind, sub, offset, reg) \
+static ssize_t show_##kind##sub (struct fscher_data *, char *, int); \
+static ssize_t show_##kind##offset##sub (struct device *, char *); \
+static ssize_t show_##kind##offset##sub (struct device *dev, char *buf) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct fscher_data *data = i2c_get_clientdata(client); \
 	fscher_update_client(client); \
-	return show_##kind(data, buf, (offset)); \
+	return show_##kind##sub(data, buf, (offset)); \
 }
 
-#define sysfs_w(kind, offset, reg) \
-static ssize_t set_##kind (struct i2c_client *, struct fscher_data *, const char *, size_t, int, int); \
-static ssize_t set_##kind##offset (struct device *, const char *, size_t); \
-static ssize_t set_##kind##offset (struct device *dev, const char *buf, size_t count) \
+#define sysfs_w(kind, sub, offset, reg) \
+static ssize_t set_##kind##sub (struct i2c_client *, struct fscher_data *, const char *, size_t, int, int); \
+static ssize_t set_##kind##offset##sub (struct device *, const char *, size_t); \
+static ssize_t set_##kind##offset##sub (struct device *dev, const char *buf, size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct fscher_data *data = i2c_get_clientdata(client); \
-	return set_##kind(client, data, buf, count, (offset), reg); \
+	return set_##kind##sub(client, data, buf, count, (offset), reg); \
 }
 
-#define sysfs_rw_n(kind, offset, reg) \
-sysfs_r(kind, offset, reg) \
-sysfs_w(kind, offset, reg) \
-static DEVICE_ATTR(kind##offset, S_IRUGO | S_IWUSR, show_##kind##offset, set_##kind##offset);
-
-#define sysfs_rw(kind, reg) \
-sysfs_r(kind, 0, reg) \
-sysfs_w(kind, 0, reg) \
-static DEVICE_ATTR(kind, S_IRUGO | S_IWUSR, show_##kind##0, set_##kind##0);
-
-#define sysfs_ro_n(kind, offset, reg) \
-sysfs_r(kind, offset, reg) \
-static DEVICE_ATTR(kind##offset, S_IRUGO, show_##kind##offset, NULL);
-
-#define sysfs_ro(kind, reg) \
-sysfs_r(kind, 0, reg) \
-static DEVICE_ATTR(kind, S_IRUGO, show_##kind##0, NULL);
+#define sysfs_rw_n(kind, sub, offset, reg) \
+sysfs_r(kind, sub, offset, reg) \
+sysfs_w(kind, sub, offset, reg) \
+static DEVICE_ATTR(kind##offset##sub, S_IRUGO | S_IWUSR, show_##kind##offset##sub, set_##kind##offset##sub);
+
+#define sysfs_rw(kind, sub, reg) \
+sysfs_r(kind, sub, 0, reg) \
+sysfs_w(kind, sub, 0, reg) \
+static DEVICE_ATTR(kind##sub, S_IRUGO | S_IWUSR, show_##kind##0##sub, set_##kind##0##sub);
+
+#define sysfs_ro_n(kind, sub, offset, reg) \
+sysfs_r(kind, sub, offset, reg) \
+static DEVICE_ATTR(kind##offset##sub, S_IRUGO, show_##kind##offset##sub, NULL);
+
+#define sysfs_ro(kind, sub, reg) \
+sysfs_r(kind, sub, 0, reg) \
+static DEVICE_ATTR(kind, S_IRUGO, show_##kind##0##sub, NULL);
 
 #define sysfs_fan(offset, reg_status, reg_min, reg_ripple, reg_act) \
-sysfs_rw_n(pwm       , offset, reg_min) \
-sysfs_rw_n(fan_status, offset, reg_status) \
-sysfs_rw_n(fan_div   , offset, reg_ripple) \
-sysfs_ro_n(fan_input , offset, reg_act)
+sysfs_rw_n(pwm,        , offset, reg_min) \
+sysfs_rw_n(fan, _status, offset, reg_status) \
+sysfs_rw_n(fan, _div   , offset, reg_ripple) \
+sysfs_ro_n(fan, _input , offset, reg_act)
 
 #define sysfs_temp(offset, reg_status, reg_act) \
-sysfs_rw_n(temp_status, offset, reg_status) \
-sysfs_ro_n(temp_input , offset, reg_act)
+sysfs_rw_n(temp, _status, offset, reg_status) \
+sysfs_ro_n(temp, _input , offset, reg_act)
     
 #define sysfs_in(offset, reg_act) \
-sysfs_ro_n(in_input, offset, reg_act)
+sysfs_ro_n(in, _input, offset, reg_act)
 
 #define sysfs_revision(reg_revision) \
-sysfs_ro(revision, reg_revision)
+sysfs_ro(revision, , reg_revision)
 
 #define sysfs_alarms(reg_events) \
-sysfs_ro(alarms, reg_events)
+sysfs_ro(alarms, , reg_events)
 
 #define sysfs_control(reg_control) \
-sysfs_rw(control, reg_control)
+sysfs_rw(control, , reg_control)
 
 #define sysfs_watchdog(reg_control, reg_status, reg_preset) \
-sysfs_rw(watchdog_control, reg_control) \
-sysfs_rw(watchdog_status , reg_status) \
-sysfs_rw(watchdog_preset , reg_preset)
+sysfs_rw(watchdog, _control, reg_control) \
+sysfs_rw(watchdog, _status , reg_status) \
+sysfs_rw(watchdog, _preset , reg_preset)
 
 sysfs_fan(1, FSCHER_REG_FAN0_STATE, FSCHER_REG_FAN0_MIN,
 	     FSCHER_REG_FAN0_RIPPLE, FSCHER_REG_FAN0_ACT)
@@ -253,21 +253,21 @@
   
 #define device_create_file_fan(client, offset) \
 do { \
-	device_create_file(&client->dev, &dev_attr_fan_status##offset); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_status); \
 	device_create_file(&client->dev, &dev_attr_pwm##offset); \
-	device_create_file(&client->dev, &dev_attr_fan_div##offset); \
-	device_create_file(&client->dev, &dev_attr_fan_input##offset); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
 } while (0)
 
 #define device_create_file_temp(client, offset) \
 do { \
-	device_create_file(&client->dev, &dev_attr_temp_status##offset); \
-	device_create_file(&client->dev, &dev_attr_temp_input##offset); \
+	device_create_file(&client->dev, &dev_attr_temp##offset##_status); \
+	device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
 } while (0)
 
 #define device_create_file_in(client, offset) \
 do { \
-	device_create_file(&client->dev, &dev_attr_in_input##offset); \
+	device_create_file(&client->dev, &dev_attr_in##offset##_input); \
 } while (0)
 
 #define device_create_file_revision(client) \
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/gl518sm.c	Mon Mar 15 14:36:23 2004
@@ -307,29 +307,29 @@
 	return count;
 }
 
-static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input1, NULL);
-static DEVICE_ATTR(temp_max1, S_IWUSR|S_IRUGO, show_temp_max1, set_temp_max1);
-static DEVICE_ATTR(temp_hyst1, S_IWUSR|S_IRUGO,
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
+static DEVICE_ATTR(temp1_max, S_IWUSR|S_IRUGO, show_temp_max1, set_temp_max1);
+static DEVICE_ATTR(temp1_hyst, S_IWUSR|S_IRUGO,
 	show_temp_hyst1, set_temp_hyst1);
-static DEVICE_ATTR(fan_auto1, S_IWUSR|S_IRUGO, show_fan_auto1, set_fan_auto1);
-static DEVICE_ATTR(fan_input1, S_IRUGO, show_fan_input1, NULL);
-static DEVICE_ATTR(fan_input2, S_IRUGO, show_fan_input2, NULL);
-static DEVICE_ATTR(fan_min1, S_IWUSR|S_IRUGO, show_fan_min1, set_fan_min1);
-static DEVICE_ATTR(fan_min2, S_IWUSR|S_IRUGO, show_fan_min2, set_fan_min2);
-static DEVICE_ATTR(fan_div1, S_IWUSR|S_IRUGO, show_fan_div1, set_fan_div1);
-static DEVICE_ATTR(fan_div2, S_IWUSR|S_IRUGO, show_fan_div2, set_fan_div2);
-static DEVICE_ATTR(in_input0, S_IRUGO, show_in_input0, NULL);
-static DEVICE_ATTR(in_input1, S_IRUGO, show_in_input1, NULL);
-static DEVICE_ATTR(in_input2, S_IRUGO, show_in_input2, NULL);
-static DEVICE_ATTR(in_input3, S_IRUGO, show_in_input3, NULL);
-static DEVICE_ATTR(in_min0, S_IWUSR|S_IRUGO, show_in_min0, set_in_min0);
-static DEVICE_ATTR(in_min1, S_IWUSR|S_IRUGO, show_in_min1, set_in_min1);
-static DEVICE_ATTR(in_min2, S_IWUSR|S_IRUGO, show_in_min2, set_in_min2);
-static DEVICE_ATTR(in_min3, S_IWUSR|S_IRUGO, show_in_min3, set_in_min3);
-static DEVICE_ATTR(in_max0, S_IWUSR|S_IRUGO, show_in_max0, set_in_max0);
-static DEVICE_ATTR(in_max1, S_IWUSR|S_IRUGO, show_in_max1, set_in_max1);
-static DEVICE_ATTR(in_max2, S_IWUSR|S_IRUGO, show_in_max2, set_in_max2);
-static DEVICE_ATTR(in_max3, S_IWUSR|S_IRUGO, show_in_max3, set_in_max3);
+static DEVICE_ATTR(fan1_auto, S_IWUSR|S_IRUGO, show_fan_auto1, set_fan_auto1);
+static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input1, NULL);
+static DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input2, NULL);
+static DEVICE_ATTR(fan1_min, S_IWUSR|S_IRUGO, show_fan_min1, set_fan_min1);
+static DEVICE_ATTR(fan2_min, S_IWUSR|S_IRUGO, show_fan_min2, set_fan_min2);
+static DEVICE_ATTR(fan1_div, S_IWUSR|S_IRUGO, show_fan_div1, set_fan_div1);
+static DEVICE_ATTR(fan2_div, S_IWUSR|S_IRUGO, show_fan_div2, set_fan_div2);
+static DEVICE_ATTR(in0_input, S_IRUGO, show_in_input0, NULL);
+static DEVICE_ATTR(in1_input, S_IRUGO, show_in_input1, NULL);
+static DEVICE_ATTR(in2_input, S_IRUGO, show_in_input2, NULL);
+static DEVICE_ATTR(in3_input, S_IRUGO, show_in_input3, NULL);
+static DEVICE_ATTR(in0_min, S_IWUSR|S_IRUGO, show_in_min0, set_in_min0);
+static DEVICE_ATTR(in1_min, S_IWUSR|S_IRUGO, show_in_min1, set_in_min1);
+static DEVICE_ATTR(in2_min, S_IWUSR|S_IRUGO, show_in_min2, set_in_min2);
+static DEVICE_ATTR(in3_min, S_IWUSR|S_IRUGO, show_in_min3, set_in_min3);
+static DEVICE_ATTR(in0_max, S_IWUSR|S_IRUGO, show_in_max0, set_in_max0);
+static DEVICE_ATTR(in1_max, S_IWUSR|S_IRUGO, show_in_max1, set_in_max1);
+static DEVICE_ATTR(in2_max, S_IWUSR|S_IRUGO, show_in_max2, set_in_max2);
+static DEVICE_ATTR(in3_max, S_IWUSR|S_IRUGO, show_in_max3, set_in_max3);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 static DEVICE_ATTR(beep_enable, S_IWUSR|S_IRUGO,
 	show_beep_enable, set_beep_enable);
@@ -424,28 +424,28 @@
 	gl518_init_client((struct i2c_client *) new_client);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_in_input0);
-	device_create_file(&new_client->dev, &dev_attr_in_input1);
-	device_create_file(&new_client->dev, &dev_attr_in_input2);
-	device_create_file(&new_client->dev, &dev_attr_in_input3);
-	device_create_file(&new_client->dev, &dev_attr_in_min0);
-	device_create_file(&new_client->dev, &dev_attr_in_min1);
-	device_create_file(&new_client->dev, &dev_attr_in_min2);
-	device_create_file(&new_client->dev, &dev_attr_in_min3);
-	device_create_file(&new_client->dev, &dev_attr_in_max0);
-	device_create_file(&new_client->dev, &dev_attr_in_max1);
-	device_create_file(&new_client->dev, &dev_attr_in_max2);
-	device_create_file(&new_client->dev, &dev_attr_in_max3);
-	device_create_file(&new_client->dev, &dev_attr_fan_auto1);
-	device_create_file(&new_client->dev, &dev_attr_fan_input1);
-	device_create_file(&new_client->dev, &dev_attr_fan_input2);
-	device_create_file(&new_client->dev, &dev_attr_fan_min1);
-	device_create_file(&new_client->dev, &dev_attr_fan_min2);
-	device_create_file(&new_client->dev, &dev_attr_fan_div1);
-	device_create_file(&new_client->dev, &dev_attr_fan_div2);
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_fan1_auto);
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_div);
+	device_create_file(&new_client->dev, &dev_attr_fan2_div);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_beep_enable);
 	device_create_file(&new_client->dev, &dev_attr_beep_mask);
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/it87.c	Mon Mar 15 14:36:23 2004
@@ -287,7 +287,7 @@
 {								\
 	return show_in(dev, buf, 0x##offset);			\
 }								\
-static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL)
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL)
 
 #define limit_in_offset(offset)					\
 static ssize_t							\
@@ -310,9 +310,9 @@
 {								\
 	return set_in_max(dev, buf, count, 0x##offset);		\
 }								\
-static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
 		show_in##offset##_min, set_in##offset##_min)	\
-static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 	\
 		show_in##offset##_max, set_in##offset##_max)
 
 show_in_offset(0);
@@ -400,10 +400,10 @@
 {									\
 	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_temp_##offset, NULL) \
-static DEVICE_ATTR(temp_max##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL) \
+static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_max, set_temp_##offset##_max) 	\
-static DEVICE_ATTR(temp_min##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_min, set_temp_##offset##_min)	
 
 show_temp_offset(1);
@@ -551,10 +551,10 @@
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_fan_##offset, NULL) \
-static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_min, set_fan_##offset##_min) 	\
-static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_div, set_fan_##offset##_div)
 
 show_fan_offset(1);
@@ -703,52 +703,52 @@
 	it87_init_client(new_client, data);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_in_input0);
-	device_create_file(&new_client->dev, &dev_attr_in_input1);
-	device_create_file(&new_client->dev, &dev_attr_in_input2);
-	device_create_file(&new_client->dev, &dev_attr_in_input3);
-	device_create_file(&new_client->dev, &dev_attr_in_input4);
-	device_create_file(&new_client->dev, &dev_attr_in_input5);
-	device_create_file(&new_client->dev, &dev_attr_in_input6);
-	device_create_file(&new_client->dev, &dev_attr_in_input7);
-	device_create_file(&new_client->dev, &dev_attr_in_input8);
-	device_create_file(&new_client->dev, &dev_attr_in_min0);
-	device_create_file(&new_client->dev, &dev_attr_in_min1);
-	device_create_file(&new_client->dev, &dev_attr_in_min2);
-	device_create_file(&new_client->dev, &dev_attr_in_min3);
-	device_create_file(&new_client->dev, &dev_attr_in_min4);
-	device_create_file(&new_client->dev, &dev_attr_in_min5);
-	device_create_file(&new_client->dev, &dev_attr_in_min6);
-	device_create_file(&new_client->dev, &dev_attr_in_min7);
-	device_create_file(&new_client->dev, &dev_attr_in_max0);
-	device_create_file(&new_client->dev, &dev_attr_in_max1);
-	device_create_file(&new_client->dev, &dev_attr_in_max2);
-	device_create_file(&new_client->dev, &dev_attr_in_max3);
-	device_create_file(&new_client->dev, &dev_attr_in_max4);
-	device_create_file(&new_client->dev, &dev_attr_in_max5);
-	device_create_file(&new_client->dev, &dev_attr_in_max6);
-	device_create_file(&new_client->dev, &dev_attr_in_max7);
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_input2);
-	device_create_file(&new_client->dev, &dev_attr_temp_input3);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max2);
-	device_create_file(&new_client->dev, &dev_attr_temp_max3);
-	device_create_file(&new_client->dev, &dev_attr_temp_min1);
-	device_create_file(&new_client->dev, &dev_attr_temp_min2);
-	device_create_file(&new_client->dev, &dev_attr_temp_min3);
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in4_input);
+	device_create_file(&new_client->dev, &dev_attr_in5_input);
+	device_create_file(&new_client->dev, &dev_attr_in6_input);
+	device_create_file(&new_client->dev, &dev_attr_in7_input);
+	device_create_file(&new_client->dev, &dev_attr_in8_input);
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in4_min);
+	device_create_file(&new_client->dev, &dev_attr_in5_min);
+	device_create_file(&new_client->dev, &dev_attr_in6_min);
+	device_create_file(&new_client->dev, &dev_attr_in7_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_in4_max);
+	device_create_file(&new_client->dev, &dev_attr_in5_max);
+	device_create_file(&new_client->dev, &dev_attr_in6_max);
+	device_create_file(&new_client->dev, &dev_attr_in7_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp2_input);
+	device_create_file(&new_client->dev, &dev_attr_temp3_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_temp3_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_min);
+	device_create_file(&new_client->dev, &dev_attr_temp2_min);
+	device_create_file(&new_client->dev, &dev_attr_temp3_min);
 	device_create_file(&new_client->dev, &dev_attr_sensor1);
 	device_create_file(&new_client->dev, &dev_attr_sensor2);
 	device_create_file(&new_client->dev, &dev_attr_sensor3);
-	device_create_file(&new_client->dev, &dev_attr_fan_input1);
-	device_create_file(&new_client->dev, &dev_attr_fan_input2);
-	device_create_file(&new_client->dev, &dev_attr_fan_input3);
-	device_create_file(&new_client->dev, &dev_attr_fan_min1);
-	device_create_file(&new_client->dev, &dev_attr_fan_min2);
-	device_create_file(&new_client->dev, &dev_attr_fan_min3);
-	device_create_file(&new_client->dev, &dev_attr_fan_div1);
-	device_create_file(&new_client->dev, &dev_attr_fan_div2);
-	device_create_file(&new_client->dev, &dev_attr_fan_div3);
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan3_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_fan3_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_div);
+	device_create_file(&new_client->dev, &dev_attr_fan2_div);
+	device_create_file(&new_client->dev, &dev_attr_fan3_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/lm75.c	Mon Mar 15 14:36:23 2004
@@ -104,9 +104,9 @@
 set(temp_max, LM75_REG_TEMP_OS);
 set(temp_hyst, LM75_REG_TEMP_HYST);
 
-static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp_hyst1, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
-static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp1_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -197,9 +197,9 @@
 	lm75_init_client(new_client);
 	
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 
 	return 0;
 
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/lm78.c	Mon Mar 15 14:36:23 2004
@@ -289,7 +289,7 @@
 {								\
 	return show_in(dev, buf, 0x##offset);			\
 }								\
-static DEVICE_ATTR(in_input##offset, S_IRUGO, 			\
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
 		show_in##offset, NULL)				\
 static ssize_t							\
 	show_in##offset##_min (struct device *dev, char *buf)   \
@@ -311,9 +311,9 @@
 {								\
 	return set_in_max(dev, buf, count, 0x##offset);		\
 }								\
-static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR,		\
+static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,		\
 		show_in##offset##_min, set_in##offset##_min)    \
-static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR,		\
+static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,		\
 		show_in##offset##_max, set_in##offset##_max)
 
 show_in_offset(0);
@@ -369,10 +369,10 @@
 	return count;
 }
 
-static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp, NULL)
-static DEVICE_ATTR(temp_max1, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL)
+static DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
 		show_temp_over, set_temp_over)
-static DEVICE_ATTR(temp_hyst1, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(temp1_hyst, S_IRUGO | S_IWUSR,
 		show_temp_hyst, set_temp_hyst)
 
 /* 3 Fans */
@@ -460,8 +460,8 @@
 {									\
 	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_fan_##offset, NULL) \
-static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR,			\
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
 		show_fan_##offset##_min, set_fan_##offset##_min)
 
 static ssize_t set_fan_1_div(struct device *dev, const char *buf,
@@ -481,11 +481,11 @@
 show_fan_offset(3);
 
 /* Fan 3 divisor is locked in H/W */
-static DEVICE_ATTR(fan_div1, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
 		show_fan_1_div, set_fan_1_div)
-static DEVICE_ATTR(fan_div2, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
 		show_fan_2_div, set_fan_2_div)
-static DEVICE_ATTR(fan_div3, S_IRUGO, show_fan_3_div, NULL)
+static DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_3_div, NULL)
 
 /* VID */
 static ssize_t show_vid(struct device *dev, char *buf)
@@ -657,39 +657,39 @@
 	lm78_init_client(new_client);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_in_input0);
-	device_create_file(&new_client->dev, &dev_attr_in_min0);
-	device_create_file(&new_client->dev, &dev_attr_in_max0);
-	device_create_file(&new_client->dev, &dev_attr_in_input1);
-	device_create_file(&new_client->dev, &dev_attr_in_min1);
-	device_create_file(&new_client->dev, &dev_attr_in_max1);
-	device_create_file(&new_client->dev, &dev_attr_in_input2);
-	device_create_file(&new_client->dev, &dev_attr_in_min2);
-	device_create_file(&new_client->dev, &dev_attr_in_max2);
-	device_create_file(&new_client->dev, &dev_attr_in_input3);
-	device_create_file(&new_client->dev, &dev_attr_in_min3);
-	device_create_file(&new_client->dev, &dev_attr_in_max3);
-	device_create_file(&new_client->dev, &dev_attr_in_input4);
-	device_create_file(&new_client->dev, &dev_attr_in_min4);
-	device_create_file(&new_client->dev, &dev_attr_in_max4);
-	device_create_file(&new_client->dev, &dev_attr_in_input5);
-	device_create_file(&new_client->dev, &dev_attr_in_min5);
-	device_create_file(&new_client->dev, &dev_attr_in_max5);
-	device_create_file(&new_client->dev, &dev_attr_in_input6);
-	device_create_file(&new_client->dev, &dev_attr_in_min6);
-	device_create_file(&new_client->dev, &dev_attr_in_max6);
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
-	device_create_file(&new_client->dev, &dev_attr_fan_input1);
-	device_create_file(&new_client->dev, &dev_attr_fan_min1);
-	device_create_file(&new_client->dev, &dev_attr_fan_div1);
-	device_create_file(&new_client->dev, &dev_attr_fan_input2);
-	device_create_file(&new_client->dev, &dev_attr_fan_min2);
-	device_create_file(&new_client->dev, &dev_attr_fan_div2);
-	device_create_file(&new_client->dev, &dev_attr_fan_input3);
-	device_create_file(&new_client->dev, &dev_attr_fan_min3);
-	device_create_file(&new_client->dev, &dev_attr_fan_div3);
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_in4_input);
+	device_create_file(&new_client->dev, &dev_attr_in4_min);
+	device_create_file(&new_client->dev, &dev_attr_in4_max);
+	device_create_file(&new_client->dev, &dev_attr_in5_input);
+	device_create_file(&new_client->dev, &dev_attr_in5_min);
+	device_create_file(&new_client->dev, &dev_attr_in5_max);
+	device_create_file(&new_client->dev, &dev_attr_in6_input);
+	device_create_file(&new_client->dev, &dev_attr_in6_min);
+	device_create_file(&new_client->dev, &dev_attr_in6_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_div);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_div);
+	device_create_file(&new_client->dev, &dev_attr_fan3_input);
+	device_create_file(&new_client->dev, &dev_attr_fan3_min);
+	device_create_file(&new_client->dev, &dev_attr_fan3_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_vid);
 
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/lm80.c	Mon Mar 15 14:36:23 2004
@@ -308,43 +308,43 @@
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
 }
 
-static DEVICE_ATTR(in_min0, S_IWUSR | S_IRUGO, show_in_min0, set_in_min0);
-static DEVICE_ATTR(in_min1, S_IWUSR | S_IRUGO, show_in_min1, set_in_min1);
-static DEVICE_ATTR(in_min2, S_IWUSR | S_IRUGO, show_in_min2, set_in_min2);
-static DEVICE_ATTR(in_min3, S_IWUSR | S_IRUGO, show_in_min3, set_in_min3);
-static DEVICE_ATTR(in_min4, S_IWUSR | S_IRUGO, show_in_min4, set_in_min4);
-static DEVICE_ATTR(in_min5, S_IWUSR | S_IRUGO, show_in_min5, set_in_min5);
-static DEVICE_ATTR(in_min6, S_IWUSR | S_IRUGO, show_in_min6, set_in_min6);
-static DEVICE_ATTR(in_max0, S_IWUSR | S_IRUGO, show_in_max0, set_in_max0);
-static DEVICE_ATTR(in_max1, S_IWUSR | S_IRUGO, show_in_max1, set_in_max1);
-static DEVICE_ATTR(in_max2, S_IWUSR | S_IRUGO, show_in_max2, set_in_max2);
-static DEVICE_ATTR(in_max3, S_IWUSR | S_IRUGO, show_in_max3, set_in_max3);
-static DEVICE_ATTR(in_max4, S_IWUSR | S_IRUGO, show_in_max4, set_in_max4);
-static DEVICE_ATTR(in_max5, S_IWUSR | S_IRUGO, show_in_max5, set_in_max5);
-static DEVICE_ATTR(in_max6, S_IWUSR | S_IRUGO, show_in_max6, set_in_max6);
-static DEVICE_ATTR(in_input0, S_IRUGO, show_in_input0, NULL);
-static DEVICE_ATTR(in_input1, S_IRUGO, show_in_input1, NULL);
-static DEVICE_ATTR(in_input2, S_IRUGO, show_in_input2, NULL);
-static DEVICE_ATTR(in_input3, S_IRUGO, show_in_input3, NULL);
-static DEVICE_ATTR(in_input4, S_IRUGO, show_in_input4, NULL);
-static DEVICE_ATTR(in_input5, S_IRUGO, show_in_input5, NULL);
-static DEVICE_ATTR(in_input6, S_IRUGO, show_in_input6, NULL);
-static DEVICE_ATTR(fan_min1, S_IWUSR | S_IRUGO, show_fan_min1,
+static DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min0, set_in_min0);
+static DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO, show_in_min1, set_in_min1);
+static DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO, show_in_min2, set_in_min2);
+static DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO, show_in_min3, set_in_min3);
+static DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO, show_in_min4, set_in_min4);
+static DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO, show_in_min5, set_in_min5);
+static DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO, show_in_min6, set_in_min6);
+static DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO, show_in_max0, set_in_max0);
+static DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO, show_in_max1, set_in_max1);
+static DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO, show_in_max2, set_in_max2);
+static DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO, show_in_max3, set_in_max3);
+static DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO, show_in_max4, set_in_max4);
+static DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO, show_in_max5, set_in_max5);
+static DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO, show_in_max6, set_in_max6);
+static DEVICE_ATTR(in0_input, S_IRUGO, show_in_input0, NULL);
+static DEVICE_ATTR(in1_input, S_IRUGO, show_in_input1, NULL);
+static DEVICE_ATTR(in2_input, S_IRUGO, show_in_input2, NULL);
+static DEVICE_ATTR(in3_input, S_IRUGO, show_in_input3, NULL);
+static DEVICE_ATTR(in4_input, S_IRUGO, show_in_input4, NULL);
+static DEVICE_ATTR(in5_input, S_IRUGO, show_in_input5, NULL);
+static DEVICE_ATTR(in6_input, S_IRUGO, show_in_input6, NULL);
+static DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min1,
     set_fan_min1);
-static DEVICE_ATTR(fan_min2, S_IWUSR | S_IRUGO, show_fan_min2,
+static DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min2,
     set_fan_min2);
-static DEVICE_ATTR(fan_input1, S_IRUGO, show_fan_input1, NULL);
-static DEVICE_ATTR(fan_input2, S_IRUGO, show_fan_input2, NULL);
-static DEVICE_ATTR(fan_div1, S_IRUGO, show_fan_div1, NULL);
-static DEVICE_ATTR(fan_div2, S_IRUGO, show_fan_div2, NULL);
-static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input1, NULL);
-static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_hot_max,
+static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input1, NULL);
+static DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input2, NULL);
+static DEVICE_ATTR(fan1_div, S_IRUGO, show_fan_div1, NULL);
+static DEVICE_ATTR(fan2_div, S_IRUGO, show_fan_div2, NULL);
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_hot_max,
     set_temp_hot_max);
-static DEVICE_ATTR(temp_max1_hyst, S_IWUSR | S_IRUGO, show_temp_hot_hyst,
+static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_hot_hyst,
     set_temp_hot_hyst);
-static DEVICE_ATTR(temp_crit1, S_IWUSR | S_IRUGO, show_temp_os_max,
+static DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_os_max,
     set_temp_os_max);
-static DEVICE_ATTR(temp_crit1_hyst, S_IWUSR | S_IRUGO, show_temp_os_hyst,
+static DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_os_hyst,
     set_temp_os_hyst);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
@@ -418,38 +418,38 @@
 	lm80_init_client(new_client);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_in_min0);
-	device_create_file(&new_client->dev, &dev_attr_in_min1);
-	device_create_file(&new_client->dev, &dev_attr_in_min2);
-	device_create_file(&new_client->dev, &dev_attr_in_min3);
-	device_create_file(&new_client->dev, &dev_attr_in_min4);
-	device_create_file(&new_client->dev, &dev_attr_in_min5);
-	device_create_file(&new_client->dev, &dev_attr_in_min6);
-	device_create_file(&new_client->dev, &dev_attr_in_max0);
-	device_create_file(&new_client->dev, &dev_attr_in_max1);
-	device_create_file(&new_client->dev, &dev_attr_in_max2);
-	device_create_file(&new_client->dev, &dev_attr_in_max3);
-	device_create_file(&new_client->dev, &dev_attr_in_max4);
-	device_create_file(&new_client->dev, &dev_attr_in_max5);
-	device_create_file(&new_client->dev, &dev_attr_in_max6);
-	device_create_file(&new_client->dev, &dev_attr_in_input0);
-	device_create_file(&new_client->dev, &dev_attr_in_input1);
-	device_create_file(&new_client->dev, &dev_attr_in_input2);
-	device_create_file(&new_client->dev, &dev_attr_in_input3);
-	device_create_file(&new_client->dev, &dev_attr_in_input4);
-	device_create_file(&new_client->dev, &dev_attr_in_input5);
-	device_create_file(&new_client->dev, &dev_attr_in_input6);
-	device_create_file(&new_client->dev, &dev_attr_fan_min1);
-	device_create_file(&new_client->dev, &dev_attr_fan_min2);
-	device_create_file(&new_client->dev, &dev_attr_fan_input1);
-	device_create_file(&new_client->dev, &dev_attr_fan_input2);
-	device_create_file(&new_client->dev, &dev_attr_fan_div1);
-	device_create_file(&new_client->dev, &dev_attr_fan_div2);
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp_crit1);
-	device_create_file(&new_client->dev, &dev_attr_temp_crit1_hyst);
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in4_min);
+	device_create_file(&new_client->dev, &dev_attr_in5_min);
+	device_create_file(&new_client->dev, &dev_attr_in6_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_in4_max);
+	device_create_file(&new_client->dev, &dev_attr_in5_max);
+	device_create_file(&new_client->dev, &dev_attr_in6_max);
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in4_input);
+	device_create_file(&new_client->dev, &dev_attr_in5_input);
+	device_create_file(&new_client->dev, &dev_attr_in6_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_div);
+	device_create_file(&new_client->dev, &dev_attr_fan2_div);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp1_crit_hyst);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/lm83.c	Mon Mar 15 14:36:23 2004
@@ -201,17 +201,17 @@
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
-static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input1, NULL);
-static DEVICE_ATTR(temp_input2, S_IRUGO, show_temp_input2, NULL);
-static DEVICE_ATTR(temp_input3, S_IRUGO, show_temp_input3, NULL);
-static DEVICE_ATTR(temp_input4, S_IRUGO, show_temp_input4, NULL);
-static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_high1,
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
+static DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input3, NULL);
+static DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input4, NULL);
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_high1,
     set_temp_high1);
-static DEVICE_ATTR(temp_max2, S_IWUSR | S_IRUGO, show_temp_high2,
+static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_high2,
     set_temp_high2);
-static DEVICE_ATTR(temp_max3, S_IWUSR | S_IRUGO, show_temp_high3,
+static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp_high3,
     set_temp_high3);
-static DEVICE_ATTR(temp_max4, S_IWUSR | S_IRUGO, show_temp_high4,
+static DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_high4,
     set_temp_high4);
 static DEVICE_ATTR(temp_crit, S_IWUSR | S_IRUGO, show_temp_crit,
     set_temp_crit);
@@ -320,14 +320,14 @@
 	 */
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_input2);
-	device_create_file(&new_client->dev, &dev_attr_temp_input3);
-	device_create_file(&new_client->dev, &dev_attr_temp_input4);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max2);
-	device_create_file(&new_client->dev, &dev_attr_temp_max3);
-	device_create_file(&new_client->dev, &dev_attr_temp_max4);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp2_input);
+	device_create_file(&new_client->dev, &dev_attr_temp3_input);
+	device_create_file(&new_client->dev, &dev_attr_temp4_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_temp3_max);
+	device_create_file(&new_client->dev, &dev_attr_temp4_max);
 	device_create_file(&new_client->dev, &dev_attr_temp_crit);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/lm85.c	Mon Mar 15 14:36:23 2004
@@ -460,8 +460,8 @@
 {									\
 	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_fan_##offset, NULL) \
-static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_min, set_fan_##offset##_min)
 
 show_fan_offset(1);
@@ -566,7 +566,7 @@
 }									\
 static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, 			\
 		show_pwm_##offset, set_pwm_##offset)			\
-static DEVICE_ATTR(pwm_enable##offset, S_IRUGO, show_pwm_enable##offset, NULL)
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO, show_pwm_enable##offset, NULL)
 
 show_pwm_reg(1);
 show_pwm_reg(2);
@@ -649,10 +649,10 @@
 {									\
 	return set_in_max(dev, buf, count, 0x##offset);			\
 }									\
-static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in_##offset, NULL)	\
-static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in_##offset, NULL)	\
+static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_in_##offset##_min, set_in_##offset##_min)		\
-static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 		\
 		show_in_##offset##_max, set_in_##offset##_max)
 
 show_in_reg(0);
@@ -738,10 +738,10 @@
 {									\
 	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_temp_##offset, NULL)	\
-static DEVICE_ATTR(temp_min##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL)	\
+static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_min, set_temp_##offset##_min)	\
-static DEVICE_ATTR(temp_max##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_max, set_temp_##offset##_max)
 
 show_temp_reg(1);
@@ -886,44 +886,44 @@
 	lm85_init_client(new_client);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_fan_input1);
-	device_create_file(&new_client->dev, &dev_attr_fan_input2);
-	device_create_file(&new_client->dev, &dev_attr_fan_input3);
-	device_create_file(&new_client->dev, &dev_attr_fan_input4);
-	device_create_file(&new_client->dev, &dev_attr_fan_min1);
-	device_create_file(&new_client->dev, &dev_attr_fan_min2);
-	device_create_file(&new_client->dev, &dev_attr_fan_min3);
-	device_create_file(&new_client->dev, &dev_attr_fan_min4);
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan3_input);
+	device_create_file(&new_client->dev, &dev_attr_fan4_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_fan3_min);
+	device_create_file(&new_client->dev, &dev_attr_fan4_min);
 	device_create_file(&new_client->dev, &dev_attr_pwm1);
 	device_create_file(&new_client->dev, &dev_attr_pwm2);
 	device_create_file(&new_client->dev, &dev_attr_pwm3);
-	device_create_file(&new_client->dev, &dev_attr_pwm_enable1);
-	device_create_file(&new_client->dev, &dev_attr_pwm_enable2);
-	device_create_file(&new_client->dev, &dev_attr_pwm_enable3);
-	device_create_file(&new_client->dev, &dev_attr_in_input0);
-	device_create_file(&new_client->dev, &dev_attr_in_input1);
-	device_create_file(&new_client->dev, &dev_attr_in_input2);
-	device_create_file(&new_client->dev, &dev_attr_in_input3);
-	device_create_file(&new_client->dev, &dev_attr_in_input4);
-	device_create_file(&new_client->dev, &dev_attr_in_min0);
-	device_create_file(&new_client->dev, &dev_attr_in_min1);
-	device_create_file(&new_client->dev, &dev_attr_in_min2);
-	device_create_file(&new_client->dev, &dev_attr_in_min3);
-	device_create_file(&new_client->dev, &dev_attr_in_min4);
-	device_create_file(&new_client->dev, &dev_attr_in_max0);
-	device_create_file(&new_client->dev, &dev_attr_in_max1);
-	device_create_file(&new_client->dev, &dev_attr_in_max2);
-	device_create_file(&new_client->dev, &dev_attr_in_max3);
-	device_create_file(&new_client->dev, &dev_attr_in_max4);
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_input2);
-	device_create_file(&new_client->dev, &dev_attr_temp_input3);
-	device_create_file(&new_client->dev, &dev_attr_temp_min1);
-	device_create_file(&new_client->dev, &dev_attr_temp_min2);
-	device_create_file(&new_client->dev, &dev_attr_temp_min3);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max2);
-	device_create_file(&new_client->dev, &dev_attr_temp_max3);
+	device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
+	device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in4_input);
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in4_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_in4_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp2_input);
+	device_create_file(&new_client->dev, &dev_attr_temp3_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_min);
+	device_create_file(&new_client->dev, &dev_attr_temp2_min);
+	device_create_file(&new_client->dev, &dev_attr_temp3_min);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_temp3_max);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_vid);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/lm90.c	Mon Mar 15 14:36:23 2004
@@ -245,23 +245,23 @@
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
-static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input1, NULL);
-static DEVICE_ATTR(temp_input2, S_IRUGO, show_temp_input2, NULL);
-static DEVICE_ATTR(temp_min1, S_IWUSR | S_IRUGO, show_temp_low1,
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input2, NULL);
+static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_low1,
 	set_temp_low1);
-static DEVICE_ATTR(temp_min2, S_IWUSR | S_IRUGO, show_temp_low2,
+static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_low2,
 	set_temp_low2);
-static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_high1,
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_high1,
 	set_temp_high1);
-static DEVICE_ATTR(temp_max2, S_IWUSR | S_IRUGO, show_temp_high2,
+static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_high2,
 	set_temp_high2);
-static DEVICE_ATTR(temp_crit1, S_IWUSR | S_IRUGO, show_temp_crit1,
+static DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_crit1,
 	set_temp_crit1);
-static DEVICE_ATTR(temp_crit2, S_IWUSR | S_IRUGO, show_temp_crit2,
+static DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit2,
 	set_temp_crit2);
-static DEVICE_ATTR(temp_hyst1, S_IWUSR | S_IRUGO, show_temp_hyst1,
+static DEVICE_ATTR(temp1_hyst, S_IWUSR | S_IRUGO, show_temp_hyst1,
 	set_temp_hyst1);
-static DEVICE_ATTR(temp_hyst2, S_IRUGO, show_temp_hyst2, NULL);
+static DEVICE_ATTR(temp2_hyst, S_IRUGO, show_temp_hyst2, NULL);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /*
@@ -381,16 +381,16 @@
 	lm90_init_client(new_client);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_input2);
-	device_create_file(&new_client->dev, &dev_attr_temp_min1);
-	device_create_file(&new_client->dev, &dev_attr_temp_min2);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max2);
-	device_create_file(&new_client->dev, &dev_attr_temp_crit1);
-	device_create_file(&new_client->dev, &dev_attr_temp_crit2);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst2);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp2_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_min);
+	device_create_file(&new_client->dev, &dev_attr_temp2_min);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp2_hyst);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/via686a.c	Mon Mar 15 14:36:23 2004
@@ -482,10 +482,10 @@
 {								\
 	return set_in_max(dev, buf, count, 0x##offset);		\
 }								\
-static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL) 	\
-static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL) 	\
+static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
 		show_in##offset##_min, set_in##offset##_min)	\
-static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 	\
 		show_in##offset##_max, set_in##offset##_max)
 
 show_in_offset(0);
@@ -556,10 +556,10 @@
 {									\
 	return set_temp_hyst(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_temp_##offset, NULL) \
-static DEVICE_ATTR(temp_max##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL) \
+static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_over, set_temp_##offset##_over) 	\
-static DEVICE_ATTR(temp_hyst##offset, S_IRUGO | S_IWUSR, 		\
+static DEVICE_ATTR(temp##offset##_hyst, S_IRUGO | S_IWUSR, 		\
 		show_temp_##offset##_hyst, set_temp_##offset##_hyst)	
 
 show_temp_offset(1);
@@ -631,10 +631,10 @@
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_fan_##offset, NULL) \
-static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_min, set_fan_##offset##_min) 	\
-static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, 			\
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
 		show_fan_##offset##_div, set_fan_##offset##_div)
 
 show_fan_offset(1);
@@ -742,36 +742,36 @@
 	via686a_init_client(new_client);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_in_input0);
-	device_create_file(&new_client->dev, &dev_attr_in_input1);
-	device_create_file(&new_client->dev, &dev_attr_in_input2);
-	device_create_file(&new_client->dev, &dev_attr_in_input3);
-	device_create_file(&new_client->dev, &dev_attr_in_input4);
-	device_create_file(&new_client->dev, &dev_attr_in_min0);
-	device_create_file(&new_client->dev, &dev_attr_in_min1);
-	device_create_file(&new_client->dev, &dev_attr_in_min2);
-	device_create_file(&new_client->dev, &dev_attr_in_min3);
-	device_create_file(&new_client->dev, &dev_attr_in_min4);
-	device_create_file(&new_client->dev, &dev_attr_in_max0);
-	device_create_file(&new_client->dev, &dev_attr_in_max1);
-	device_create_file(&new_client->dev, &dev_attr_in_max2);
-	device_create_file(&new_client->dev, &dev_attr_in_max3);
-	device_create_file(&new_client->dev, &dev_attr_in_max4);
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_input2);
-	device_create_file(&new_client->dev, &dev_attr_temp_input3);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max2);
-	device_create_file(&new_client->dev, &dev_attr_temp_max3);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst2);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst3);
-	device_create_file(&new_client->dev, &dev_attr_fan_input1);
-	device_create_file(&new_client->dev, &dev_attr_fan_input2);
-	device_create_file(&new_client->dev, &dev_attr_fan_min1);
-	device_create_file(&new_client->dev, &dev_attr_fan_min2);
-	device_create_file(&new_client->dev, &dev_attr_fan_div1);
-	device_create_file(&new_client->dev, &dev_attr_fan_div2);
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in4_input);
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in4_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_in4_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp2_input);
+	device_create_file(&new_client->dev, &dev_attr_temp3_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_temp3_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp2_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp3_hyst);
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_fan1_div);
+	device_create_file(&new_client->dev, &dev_attr_fan2_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:36:23 2004
@@ -330,7 +330,7 @@
 { \
         return show_in(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(in_input##offset, S_IRUGO, show_regs_in_##offset, NULL)
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL)
 
 #define sysfs_in_reg_offset(reg, offset) \
 static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
@@ -341,7 +341,7 @@
 { \
 	return store_in_##reg (dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(in_##reg##offset, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset)
+static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset)
 
 #define sysfs_in_offsets(offset) \
 sysfs_in_offset(offset); \
@@ -360,9 +360,9 @@
 
 #define device_create_file_in(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_in_input##offset); \
-device_create_file(&client->dev, &dev_attr_in_min##offset); \
-device_create_file(&client->dev, &dev_attr_in_max##offset); \
+device_create_file(&client->dev, &dev_attr_in##offset##_input); \
+device_create_file(&client->dev, &dev_attr_in##offset##_min); \
+device_create_file(&client->dev, &dev_attr_in##offset##_max); \
 } while (0)
 
 #define show_fan_reg(reg) \
@@ -400,7 +400,7 @@
 { \
 	return show_fan(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_regs_fan_##offset, NULL)
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL)
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
@@ -411,7 +411,7 @@
 { \
 	return store_fan_min(dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, show_regs_fan_min##offset, store_regs_fan_min##offset)
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, show_regs_fan_min##offset, store_regs_fan_min##offset)
 
 sysfs_fan_offset(1);
 sysfs_fan_min_offset(1);
@@ -422,8 +422,8 @@
 
 #define device_create_file_fan(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan_input##offset); \
-device_create_file(&client->dev, &dev_attr_fan_min##offset); \
+device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
+device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
 } while (0)
 
 #define show_temp_reg(reg) \
@@ -484,7 +484,7 @@
 { \
 	return show_temp(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_regs_temp_##offset, NULL)
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL)
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
@@ -495,7 +495,7 @@
 { \
 	return store_temp_##reg (dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(temp_##reg##offset, S_IRUGO| S_IWUSR, show_regs_temp_##reg##offset, store_regs_temp_##reg##offset)
+static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_temp_##reg##offset, store_regs_temp_##reg##offset)
 
 #define sysfs_temp_offsets(offset) \
 sysfs_temp_offset(offset); \
@@ -508,9 +508,9 @@
 
 #define device_create_file_temp(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_temp_input##offset); \
-device_create_file(&client->dev, &dev_attr_temp_max##offset); \
-device_create_file(&client->dev, &dev_attr_temp_hyst##offset); \
+device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
+device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
+device_create_file(&client->dev, &dev_attr_temp##offset##_hyst); \
 } while (0)
 
 static ssize_t
@@ -707,7 +707,7 @@
 { \
 	return store_fan_div_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset)
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset)
 
 sysfs_fan_div(1);
 sysfs_fan_div(2);
@@ -715,7 +715,7 @@
 
 #define device_create_file_fan_div(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan_div##offset); \
+device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
 } while (0)
 
 /* w83697hf only has two fans */
@@ -819,7 +819,7 @@
 { \
 	return store_pwmenable_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(pwm_enable##offset, S_IRUGO | S_IWUSR, show_regs_pwmenable_##offset, store_regs_pwmenable_##offset)
+static DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR, show_regs_pwmenable_##offset, store_regs_pwmenable_##offset)
 
 sysfs_pwm(1);
 sysfs_pwm(2);
@@ -834,7 +834,7 @@
 
 #define device_create_file_pwmenable(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_pwm_enable##offset); \
+device_create_file(&client->dev, &dev_attr_pwm##offset##_enable); \
 } while (0)
 
 static ssize_t
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:36:23 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:36:23 2004
@@ -144,8 +144,8 @@
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
-static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp, NULL)
-static DEVICE_ATTR(temp_max1, S_IRUGO, show_temp_over, NULL)
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL)
+static DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_over, NULL)
 
 /*
  * Real code
@@ -259,8 +259,8 @@
 	 */
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp_input1);
-	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 
 	return 0;
 

