Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVENJr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVENJr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 05:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVENJr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 05:47:58 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:57753 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262723AbVENJaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:30:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=pwQIwV6KnziPpCdnYM/Mke8rEmIhpPSn1SaQacucz6ZjAPE4sDv7DF392aru7X0/LW8B5plC4rL8qz2i1jTkbG0C3jEDRy4+n9+LJuLjUxHPvJKm7aSS2k4iUUKdrgMFwUGSIjsQ1SWkrr7FDbEP8Zffk54g4E5Wi2/CmY3PlG8=
Message-ID: <25381867050514023021adad55@mail.gmail.com>
Date: Sat, 14 May 2005 05:30:09 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 7/12] drivers/i2c/chips/pc87360.c - drivers/i2c/i2c-core.c: (dynamic sysfs callbacks) update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1431_17124546.1116063009162"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1431_17124546.1116063009162
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_1431_17124546.1116063009162
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.3.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.3.diff.diffstat.txt"

 chips/pc87360.c    |   68 ++++++++++++++++++++++++++---------------------------
 chips/pcf8574.c    |    6 ++--
 chips/pcf8591.c    |   10 +++----
 chips/sis5595.c    |   34 +++++++++++++-------------
 chips/smsc47b397.c |    4 +--
 chips/smsc47m1.c   |   20 +++++++--------
 chips/via686a.c    |   32 ++++++++++++------------
 chips/w83627hf.c   |   56 +++++++++++++++++++++----------------------
 chips/w83781d.c    |   52 ++++++++++++++++++++--------------------
 chips/w83l785ts.c  |    4 +--
 i2c-core.c         |    4 +--
 11 files changed, 145 insertions(+), 145 deletions(-)

------=_Part_1431_17124546.1116063009162
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.3.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.3.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/pc87360.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/pc87360.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/pc87360.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/pc87360.c	2005-05-11 00:32:27.000000000 -0400
@@ -282,32 +282,32 @@ static ssize_t set_fan_min(struct device
 }
 
 #define show_and_set_fan(offset) \
-static ssize_t show_fan##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_input(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[offset-1], \
 		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
 } \
-static ssize_t show_fan##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_min(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[offset-1], \
 		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
 } \
-static ssize_t show_fan##offset##_div(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_div(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
 		       FAN_DIV_FROM_REG(data->fan_status[offset-1])); \
 } \
-static ssize_t show_fan##offset##_status(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_status(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
 		       FAN_STATUS_FROM_REG(data->fan_status[offset-1])); \
 } \
 static ssize_t set_fan##offset##_min(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	return set_fan_min(dev, buf, count, offset-1); \
 } \
@@ -324,7 +324,7 @@ show_and_set_fan(2)
 show_and_set_fan(3)
 
 #define show_and_set_pwm(offset) \
-static ssize_t show_pwm##offset(struct device *dev, char *buf) \
+static ssize_t show_pwm##offset(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
@@ -333,7 +333,7 @@ static ssize_t show_pwm##offset(struct d
 						      offset-1))); \
 } \
 static ssize_t set_pwm##offset(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
@@ -354,31 +354,31 @@ show_and_set_pwm(2)
 show_and_set_pwm(3)
 
 #define show_and_set_in(offset) \
-static ssize_t show_in##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_input(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_min(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_max(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_max(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_status(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_status(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", data->in_status[offset]); \
 } \
 static ssize_t set_in##offset##_min(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
@@ -392,7 +392,7 @@ static ssize_t set_in##offset##_min(stru
 	return count; \
 } \
 static ssize_t set_in##offset##_max(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
@@ -427,37 +427,37 @@ show_and_set_in(9)
 show_and_set_in(10)
 
 #define show_and_set_therm(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_min(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_max(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_crit(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_crit(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[offset-4], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_status(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_status(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", data->in_status[offset+7]); \
 } \
 static ssize_t set_temp##offset##_min(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
@@ -471,7 +471,7 @@ static ssize_t set_temp##offset##_min(st
 	return count; \
 } \
 static ssize_t set_temp##offset##_max(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
@@ -485,7 +485,7 @@ static ssize_t set_temp##offset##_max(st
 	return count; \
 } \
 static ssize_t set_temp##offset##_crit(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
@@ -512,19 +512,19 @@ show_and_set_therm(4)
 show_and_set_therm(5)
 show_and_set_therm(6)
 
-static ssize_t show_vid(struct device *dev, char *buf)
+static ssize_t show_vid(struct device *dev, char *buf, void *private)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, char *buf)
+static ssize_t show_vrm(struct device *dev, char *buf, void *private)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
@@ -533,7 +533,7 @@ static ssize_t set_vrm(struct device *de
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 
-static ssize_t show_in_alarms(struct device *dev, char *buf)
+static ssize_t show_in_alarms(struct device *dev, char *buf, void *private)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->in_alarms);
@@ -541,33 +541,33 @@ static ssize_t show_in_alarms(struct dev
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
 
 #define show_and_set_temp(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_min(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[offset-1])); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_max(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[offset-1])); \
 }\
-static ssize_t show_temp##offset##_crit(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_crit(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[offset-1])); \
 }\
-static ssize_t show_temp##offset##_status(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_status(struct device *dev, char *buf, void *private) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", data->temp_status[offset-1]); \
 }\
 static ssize_t set_temp##offset##_min(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
@@ -581,7 +581,7 @@ static ssize_t set_temp##offset##_min(st
 	return count; \
 } \
 static ssize_t set_temp##offset##_max(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
@@ -595,7 +595,7 @@ static ssize_t set_temp##offset##_max(st
 	return count; \
 } \
 static ssize_t set_temp##offset##_crit(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
@@ -622,7 +622,7 @@ show_and_set_temp(1)
 show_and_set_temp(2)
 show_and_set_temp(3)
 
-static ssize_t show_temp_alarms(struct device *dev, char *buf)
+static ssize_t show_temp_alarms(struct device *dev, char *buf, void *private)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->temp_alarms);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/pcf8574.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/pcf8574.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/pcf8574.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/pcf8574.c	2005-05-11 00:32:26.000000000 -0400
@@ -76,7 +76,7 @@ static struct i2c_driver pcf8574_driver 
 };
 
 /* following are the sysfs callback functions */
-static ssize_t show_read(struct device *dev, char *buf)
+static ssize_t show_read(struct device *dev, char *buf, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8574_data *data = i2c_get_clientdata(client);
@@ -86,14 +86,14 @@ static ssize_t show_read(struct device *
 
 static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);
 
-static ssize_t show_write(struct device *dev, char *buf)
+static ssize_t show_write(struct device *dev, char *buf, void *private)
 {
 	struct pcf8574_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%u\n", data->write);
 }
 
 static ssize_t set_write(struct device *dev, const char *buf,
-			 size_t count)
+			 size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8574_data *data = i2c_get_clientdata(client);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/pcf8591.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/pcf8591.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/pcf8591.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/pcf8591.c	2005-05-11 00:32:26.000000000 -0400
@@ -100,7 +100,7 @@ static struct i2c_driver pcf8591_driver 
 
 /* following are the sysfs callback functions */
 #define show_in_channel(channel)					\
-static ssize_t show_in##channel##_input(struct device *dev, char *buf)	\
+static ssize_t show_in##channel##_input(struct device *dev, char *buf, void *private)	\
 {									\
 	return sprintf(buf, "%d\n", pcf8591_read_channel(dev, channel));\
 }									\
@@ -112,13 +112,13 @@ show_in_channel(1);
 show_in_channel(2);
 show_in_channel(3);
 
-static ssize_t show_out0_ouput(struct device *dev, char *buf)
+static ssize_t show_out0_ouput(struct device *dev, char *buf, void *private)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%d\n", data->aout * 10);
 }
 
-static ssize_t set_out0_output(struct device *dev, const char *buf, size_t count)
+static ssize_t set_out0_output(struct device *dev, const char *buf, size_t count, void *private)
 {
 	unsigned int value;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -134,13 +134,13 @@ static ssize_t set_out0_output(struct de
 static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO, 
 		   show_out0_ouput, set_out0_output);
 
-static ssize_t show_out0_enable(struct device *dev, char *buf)
+static ssize_t show_out0_enable(struct device *dev, char *buf, void *private)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%u\n", !(!(data->control & PCF8591_CONTROL_AOEF)));
 }
 
-static ssize_t set_out0_enable(struct device *dev, const char *buf, size_t count)
+static ssize_t set_out0_enable(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/sis5595.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/sis5595.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/sis5595.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/sis5595.c	2005-05-11 00:32:27.000000000 -0400
@@ -256,29 +256,29 @@ static ssize_t set_in_max(struct device 
 
 #define show_in_offset(offset)					\
 static ssize_t							\
-	show_in##offset (struct device *dev, char *buf)		\
+	show_in##offset (struct device *dev, char *buf, void *private)		\
 {								\
 	return show_in(dev, buf, offset);			\
 }								\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
 		show_in##offset, NULL);				\
 static ssize_t							\
-	show_in##offset##_min (struct device *dev, char *buf)	\
+	show_in##offset##_min (struct device *dev, char *buf, void *private)	\
 {								\
 	return show_in_min(dev, buf, offset);			\
 }								\
 static ssize_t							\
-	show_in##offset##_max (struct device *dev, char *buf)	\
+	show_in##offset##_max (struct device *dev, char *buf, void *private)	\
 {								\
 	return show_in_max(dev, buf, offset);			\
 }								\
 static ssize_t set_in##offset##_min (struct device *dev,	\
-		const char *buf, size_t count)			\
+		const char *buf, size_t count, void *private)			\
 {								\
 	return set_in_min(dev, buf, count, offset);		\
 }								\
 static ssize_t set_in##offset##_max (struct device *dev,	\
-		const char *buf, size_t count)			\
+		const char *buf, size_t count, void *private)			\
 {								\
 	return set_in_max(dev, buf, count, offset);		\
 }								\
@@ -294,19 +294,19 @@ show_in_offset(3);
 show_in_offset(4);
 
 /* Temperature */
-static ssize_t show_temp(struct device *dev, char *buf)
+static ssize_t show_temp(struct device *dev, char *buf, void *private)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
-static ssize_t show_temp_over(struct device *dev, char *buf)
+static ssize_t show_temp_over(struct device *dev, char *buf, void *private)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
-static ssize_t set_temp_over(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp_over(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
@@ -319,13 +319,13 @@ static ssize_t set_temp_over(struct devi
 	return count;
 }
 
-static ssize_t show_temp_hyst(struct device *dev, char *buf)
+static ssize_t show_temp_hyst(struct device *dev, char *buf, void *private)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst));
 }
 
-static ssize_t set_temp_hyst(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp_hyst(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
@@ -426,20 +426,20 @@ static ssize_t set_fan_div(struct device
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_fan(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_min (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_fan_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_div (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev,		\
-		const char *buf, size_t count)				\
+		const char *buf, size_t count, void *private)				\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
@@ -451,13 +451,13 @@ show_fan_offset(1);
 show_fan_offset(2);
 
 static ssize_t set_fan_1_div(struct device *dev, const char *buf,
-		size_t count)
+		size_t count, void *private)
 {
 	return set_fan_div(dev, buf, count, 0) ;
 }
 
 static ssize_t set_fan_2_div(struct device *dev, const char *buf,
-		size_t count)
+		size_t count, void *private)
 {
 	return set_fan_div(dev, buf, count, 1) ;
 }
@@ -467,7 +467,7 @@ static DEVICE_ATTR(fan2_div, S_IRUGO | S
 		show_fan_2_div, set_fan_2_div);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/smsc47b397.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/smsc47b397.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/smsc47b397.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/smsc47b397.c	2005-05-11 00:32:25.000000000 -0400
@@ -172,7 +172,7 @@ static ssize_t show_temp(struct device *
 }
 
 #define sysfs_temp(num) \
-static ssize_t show_temp##num(struct device *dev, char *buf) \
+static ssize_t show_temp##num(struct device *dev, char *buf, void *private) \
 { \
 	return show_temp(dev, buf, num-1); \
 } \
@@ -201,7 +201,7 @@ static ssize_t show_fan(struct device *d
 }
 
 #define sysfs_fan(num) \
-static ssize_t show_fan##num(struct device *dev, char *buf) \
+static ssize_t show_fan##num(struct device *dev, char *buf, void *private) \
 { \
 	return show_fan(dev, buf, num-1); \
 } \
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/smsc47m1.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/smsc47m1.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/smsc47m1.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/smsc47m1.c	2005-05-11 00:32:24.000000000 -0400
@@ -184,7 +184,7 @@ static ssize_t get_pwm_en(struct device 
 	return sprintf(buf, "%d\n", PWM_EN_FROM_REG(data->pwm[nr]));
 }
 
-static ssize_t get_alarms(struct device *dev, char *buf)
+static ssize_t get_alarms(struct device *dev, char *buf, void *private)
 {
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
 	return sprintf(buf, "%d\n", data->alarms);
@@ -298,43 +298,43 @@ static ssize_t set_pwm_en(struct device 
 }
 
 #define fan_present(offset)						\
-static ssize_t get_fan##offset (struct device *dev, char *buf)		\
+static ssize_t get_fan##offset (struct device *dev, char *buf, void *private)		\
 {									\
 	return get_fan(dev, buf, offset - 1);				\
 }									\
-static ssize_t get_fan##offset##_min (struct device *dev, char *buf)	\
+static ssize_t get_fan##offset##_min (struct device *dev, char *buf, void *private)	\
 {									\
 	return get_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan##offset##_min (struct device *dev,		\
-		const char *buf, size_t count)				\
+		const char *buf, size_t count, void *private)				\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t get_fan##offset##_div (struct device *dev, char *buf)	\
+static ssize_t get_fan##offset##_div (struct device *dev, char *buf, void *private)	\
 {									\
 	return get_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan##offset##_div (struct device *dev,		\
-		const char *buf, size_t count)				\
+		const char *buf, size_t count, void *private)				\
 {									\
 	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t get_pwm##offset (struct device *dev, char *buf)		\
+static ssize_t get_pwm##offset (struct device *dev, char *buf, void *private)		\
 {									\
 	return get_pwm(dev, buf, offset - 1);				\
 }									\
 static ssize_t set_pwm##offset (struct device *dev,			\
-		const char *buf, size_t count)				\
+		const char *buf, size_t count, void *private)				\
 {									\
 	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
-static ssize_t get_pwm##offset##_en (struct device *dev, char *buf)	\
+static ssize_t get_pwm##offset##_en (struct device *dev, char *buf, void *private)	\
 {									\
 	return get_pwm_en(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_pwm##offset##_en (struct device *dev,		\
-		const char *buf, size_t count)				\
+		const char *buf, size_t count, void *private)				\
 {									\
 	return set_pwm_en(dev, buf, count, offset - 1);			\
 }									\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/via686a.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/via686a.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/via686a.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/via686a.c	2005-05-11 00:32:27.000000000 -0400
@@ -386,27 +386,27 @@ static ssize_t set_in_max(struct device 
 }
 #define show_in_offset(offset)					\
 static ssize_t 							\
-	show_in##offset (struct device *dev, char *buf)		\
+	show_in##offset (struct device *dev, char *buf, void *private)		\
 {								\
 	return show_in(dev, buf, offset);			\
 }								\
 static ssize_t 							\
-	show_in##offset##_min (struct device *dev, char *buf)	\
+	show_in##offset##_min (struct device *dev, char *buf, void *private)	\
 {								\
 	return show_in_min(dev, buf, offset);		\
 }								\
 static ssize_t 							\
-	show_in##offset##_max (struct device *dev, char *buf)	\
+	show_in##offset##_max (struct device *dev, char *buf, void *private)	\
 {								\
 	return show_in_max(dev, buf, offset);		\
 }								\
 static ssize_t set_in##offset##_min (struct device *dev, 	\
-		const char *buf, size_t count) 			\
+		const char *buf, size_t count, void *private) 			\
 {								\
 	return set_in_min(dev, buf, count, offset);		\
 }								\
 static ssize_t set_in##offset##_max (struct device *dev,	\
-			const char *buf, size_t count)		\
+			const char *buf, size_t count, void *private)		\
 {								\
 	return set_in_max(dev, buf, count, offset);		\
 }								\
@@ -460,27 +460,27 @@ static ssize_t set_temp_hyst(struct devi
 	return count;
 }
 #define show_temp_offset(offset)					\
-static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
+static ssize_t show_temp_##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t								\
-show_temp_##offset##_over (struct device *dev, char *buf)		\
+show_temp_##offset##_over (struct device *dev, char *buf, void *private)		\
 {									\
 	return show_temp_over(dev, buf, offset - 1);			\
 }									\
 static ssize_t								\
-show_temp_##offset##_hyst (struct device *dev, char *buf)		\
+show_temp_##offset##_hyst (struct device *dev, char *buf, void *private)		\
 {									\
 	return show_temp_hyst(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_over (struct device *dev, 		\
-		const char *buf, size_t count) 				\
+		const char *buf, size_t count, void *private) 				\
 {									\
 	return set_temp_over(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_hyst (struct device *dev, 		\
-		const char *buf, size_t count) 				\
+		const char *buf, size_t count, void *private) 				\
 {									\
 	return set_temp_hyst(dev, buf, count, offset - 1);		\
 }									\
@@ -538,25 +538,25 @@ static ssize_t set_fan_div(struct device
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_fan(dev, buf, offset - 1);				\
 }									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_min (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_fan_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_div (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
-	const char *buf, size_t count) 					\
+	const char *buf, size_t count, void *private) 					\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_fan_##offset##_div (struct device *dev, 		\
-		const char *buf, size_t count) 				\
+		const char *buf, size_t count, void *private) 				\
 {									\
 	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
@@ -570,7 +570,7 @@ show_fan_offset(1);
 show_fan_offset(2);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, char *buf) {
+static ssize_t show_alarms(struct device *dev, char *buf, void *private) {
 	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83627hf.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/w83627hf.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83627hf.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/w83627hf.c	2005-05-11 00:47:04.000000000 -0400
@@ -368,20 +368,20 @@ store_in_reg(MAX, max)
 
 #define sysfs_in_offset(offset) \
 static ssize_t \
-show_regs_in_##offset (struct device *dev, char *buf) \
+show_regs_in_##offset (struct device *dev, char *buf, void *private) \
 { \
         return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
-static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_in_##reg (dev, buf, offset); \
 } \
 static ssize_t \
 store_regs_in_##reg##offset (struct device *dev, \
-			    const char *buf, size_t count) \
+			    const char *buf, size_t count, void *private) \
 { \
 	return store_in_##reg (dev, buf, count, offset); \
 } \
@@ -419,26 +419,26 @@ static ssize_t show_in_0(struct w83627hf
 	return sprintf(buf,"%ld\n", in0);
 }
 
-static ssize_t show_regs_in_0(struct device *dev, char *buf)
+static ssize_t show_regs_in_0(struct device *dev, char *buf, void *private)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in[0]);
 }
 
-static ssize_t show_regs_in_min0(struct device *dev, char *buf)
+static ssize_t show_regs_in_min0(struct device *dev, char *buf, void *private)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in_min[0]);
 }
 
-static ssize_t show_regs_in_max0(struct device *dev, char *buf)
+static ssize_t show_regs_in_max0(struct device *dev, char *buf, void *private)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in_max[0]);
 }
 
 static ssize_t store_regs_in_min0(struct device *dev,
-	const char *buf, size_t count)
+	const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83627hf_data *data = i2c_get_clientdata(client);
@@ -463,7 +463,7 @@ static ssize_t store_regs_in_min0(struct
 }
 
 static ssize_t store_regs_in_max0(struct device *dev,
-	const char *buf, size_t count)
+	const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83627hf_data *data = i2c_get_clientdata(client);
@@ -531,19 +531,19 @@ store_fan_min(struct device *dev, const 
 }
 
 #define sysfs_fan_offset(offset) \
-static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_fan(dev, buf, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
-static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_fan_min(dev, buf, offset); \
 } \
 static ssize_t \
-store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
+store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	return store_fan_min(dev, buf, count, offset); \
 } \
@@ -608,20 +608,20 @@ store_temp_reg(HYST, max_hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
-show_regs_temp_##offset (struct device *dev, char *buf) \
+show_regs_temp_##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_temp(dev, buf, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
-static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_temp_##reg (dev, buf, offset); \
 } \
 static ssize_t \
 store_regs_temp_##reg##offset (struct device *dev, \
-			      const char *buf, size_t count) \
+			      const char *buf, size_t count, void *private) \
 { \
 	return store_temp_##reg (dev, buf, count, offset); \
 } \
@@ -645,7 +645,7 @@ device_create_file(&client->dev, &dev_at
 } while (0)
 
 static ssize_t
-show_vid_reg(struct device *dev, char *buf)
+show_vid_reg(struct device *dev, char *buf, void *private)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
@@ -655,13 +655,13 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 static ssize_t
-show_vrm_reg(struct device *dev, char *buf)
+show_vrm_reg(struct device *dev, char *buf, void *private)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 static ssize_t
-store_vrm_reg(struct device *dev, const char *buf, size_t count)
+store_vrm_reg(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83627hf_data *data = i2c_get_clientdata(client);
@@ -677,7 +677,7 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUS
 device_create_file(&client->dev, &dev_attr_vrm)
 
 static ssize_t
-show_alarms_reg(struct device *dev, char *buf)
+show_alarms_reg(struct device *dev, char *buf, void *private)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->alarms);
@@ -687,7 +687,7 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
 device_create_file(&client->dev, &dev_attr_alarms)
 
 #define show_beep_reg(REG, reg) \
-static ssize_t show_beep_##reg (struct device *dev, char *buf) \
+static ssize_t show_beep_##reg (struct device *dev, char *buf, void *private) \
 { \
 	struct w83627hf_data *data = w83627hf_update_device(dev); \
 	return sprintf(buf,"%ld\n", \
@@ -732,12 +732,12 @@ store_beep_reg(struct device *dev, const
 }
 
 #define sysfs_beep(REG, reg) \
-static ssize_t show_regs_beep_##reg (struct device *dev, char *buf) \
+static ssize_t show_regs_beep_##reg (struct device *dev, char *buf, void *private) \
 { \
-	return show_beep_##reg(dev, buf); \
+	return show_beep_##reg(dev, buf, private); \
 } \
 static ssize_t \
-store_regs_beep_##reg (struct device *dev, const char *buf, size_t count) \
+store_regs_beep_##reg (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	return store_beep_reg(dev, buf, count, BEEP_##REG); \
 } \
@@ -801,13 +801,13 @@ store_fan_div_reg(struct device *dev, co
 }
 
 #define sysfs_fan_div(offset) \
-static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_fan_div_reg(dev, buf, offset); \
 } \
 static ssize_t \
 store_regs_fan_div_##offset (struct device *dev, \
-			    const char *buf, size_t count) \
+			    const char *buf, size_t count, void *private) \
 { \
 	return store_fan_div_reg(dev, buf, count, offset - 1); \
 } \
@@ -861,12 +861,12 @@ store_pwm_reg(struct device *dev, const 
 }
 
 #define sysfs_pwm(offset) \
-static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_pwm_reg(dev, buf, offset); \
 } \
 static ssize_t \
-store_regs_pwm_##offset (struct device *dev, const char *buf, size_t count) \
+store_regs_pwm_##offset (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
@@ -937,12 +937,12 @@ store_sensor_reg(struct device *dev, con
 }
 
 #define sysfs_sensor(offset) \
-static ssize_t show_regs_sensor_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_sensor_##offset (struct device *dev, char *buf, void *private) \
 { \
     return show_sensor_reg(dev, buf, offset); \
 } \
 static ssize_t \
-store_regs_sensor_##offset (struct device *dev, const char *buf, size_t count) \
+store_regs_sensor_##offset (struct device *dev, const char *buf, size_t count, void *private) \
 { \
     return store_sensor_reg(dev, buf, count, offset); \
 } \
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83781d.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/w83781d.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83781d.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/w83781d.c	2005-05-11 00:47:32.000000000 -0400
@@ -309,18 +309,18 @@ store_in_reg(MAX, max);
 
 #define sysfs_in_offset(offset) \
 static ssize_t \
-show_regs_in_##offset (struct device *dev, char *buf) \
+show_regs_in_##offset (struct device *dev, char *buf, void *private) \
 { \
         return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
-static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_in_##reg (dev, buf, offset); \
 } \
-static ssize_t store_regs_in_##reg##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_in_##reg##offset (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	return store_in_##reg (dev, buf, count, offset); \
 } \
@@ -378,18 +378,18 @@ store_fan_min(struct device *dev, const 
 }
 
 #define sysfs_fan_offset(offset) \
-static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_fan(dev, buf, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
-static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_fan_min(dev, buf, offset); \
 } \
-static ssize_t store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	return store_fan_min(dev, buf, count, offset); \
 } \
@@ -452,18 +452,18 @@ store_temp_reg(HYST, max_hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
-show_regs_temp_##offset (struct device *dev, char *buf) \
+show_regs_temp_##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_temp(dev, buf, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
-static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_temp_##reg (dev, buf, offset); \
 } \
-static ssize_t store_regs_temp_##reg##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_temp_##reg##offset (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	return store_temp_##reg (dev, buf, count, offset); \
 } \
@@ -486,7 +486,7 @@ device_create_file(&client->dev, &dev_at
 } while (0)
 
 static ssize_t
-show_vid_reg(struct device *dev, char *buf)
+show_vid_reg(struct device *dev, char *buf, void *private)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
@@ -497,14 +497,14 @@ DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_
 #define device_create_file_vid(client) \
 device_create_file(&client->dev, &dev_attr_cpu0_vid);
 static ssize_t
-show_vrm_reg(struct device *dev, char *buf)
+show_vrm_reg(struct device *dev, char *buf, void *private)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 
 static ssize_t
-store_vrm_reg(struct device *dev, const char *buf, size_t count)
+store_vrm_reg(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
@@ -521,7 +521,7 @@ DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show
 #define device_create_file_vrm(client) \
 device_create_file(&client->dev, &dev_attr_vrm);
 static ssize_t
-show_alarms_reg(struct device *dev, char *buf)
+show_alarms_reg(struct device *dev, char *buf, void *private)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
@@ -531,13 +531,13 @@ static
 DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 #define device_create_file_alarms(client) \
 device_create_file(&client->dev, &dev_attr_alarms);
-static ssize_t show_beep_mask (struct device *dev, char *buf)
+static ssize_t show_beep_mask (struct device *dev, char *buf, void *private)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n",
 		       (long)BEEP_MASK_FROM_REG(data->beep_mask, data->type));
 }
-static ssize_t show_beep_enable (struct device *dev, char *buf)
+static ssize_t show_beep_enable (struct device *dev, char *buf, void *private)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n",
@@ -583,11 +583,11 @@ store_beep_reg(struct device *dev, const
 }
 
 #define sysfs_beep(REG, reg) \
-static ssize_t show_regs_beep_##reg (struct device *dev, char *buf) \
+static ssize_t show_regs_beep_##reg (struct device *dev, char *buf, void *private) \
 { \
-	return show_beep_##reg(dev, buf); \
+	return show_beep_##reg(dev, buf, private); \
 } \
-static ssize_t store_regs_beep_##reg (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_beep_##reg (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	return store_beep_reg(dev, buf, count, BEEP_##REG); \
 } \
@@ -653,11 +653,11 @@ store_fan_div_reg(struct device *dev, co
 }
 
 #define sysfs_fan_div(offset) \
-static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_fan_div_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_fan_div_##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_fan_div_##offset (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	return store_fan_div_reg(dev, buf, count, offset - 1); \
 } \
@@ -737,12 +737,12 @@ store_pwmenable_reg(struct device *dev, 
 }
 
 #define sysfs_pwm(offset) \
-static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_pwm_reg(dev, buf, offset); \
 } \
 static ssize_t store_regs_pwm_##offset (struct device *dev, \
-		const char *buf, size_t count) \
+		const char *buf, size_t count, void *private) \
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
@@ -750,12 +750,12 @@ static DEVICE_ATTR(pwm##offset, S_IRUGO 
 		show_regs_pwm_##offset, store_regs_pwm_##offset);
 
 #define sysfs_pwmenable(offset) \
-static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_pwmenable_reg(dev, buf, offset); \
 } \
 static ssize_t store_regs_pwmenable_##offset (struct device *dev, \
-		const char *buf, size_t count) \
+		const char *buf, size_t count, void *private) \
 { \
 	return store_pwmenable_reg(dev, buf, count, offset); \
 } \
@@ -832,11 +832,11 @@ store_sensor_reg(struct device *dev, con
 }
 
 #define sysfs_sensor(offset) \
-static ssize_t show_regs_sensor_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_sensor_##offset (struct device *dev, char *buf, void *private) \
 { \
     return show_sensor_reg(dev, buf, offset); \
 } \
-static ssize_t store_regs_sensor_##offset (struct device *dev, const char *buf, size_t count) \
+static ssize_t store_regs_sensor_##offset (struct device *dev, const char *buf, size_t count, void *private) \
 { \
     return store_sensor_reg(dev, buf, count, offset); \
 } \
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83l785ts.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/w83l785ts.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/w83l785ts.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/w83l785ts.c	2005-05-11 00:32:24.000000000 -0400
@@ -118,13 +118,13 @@ struct w83l785ts_data {
  * Sysfs stuff
  */
 
-static ssize_t show_temp(struct device *dev, char *buf)
+static ssize_t show_temp(struct device *dev, char *buf, void *private)
 {
 	struct w83l785ts_data *data = w83l785ts_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
-static ssize_t show_temp_over(struct device *dev, char *buf)
+static ssize_t show_temp_over(struct device *dev, char *buf, void *private)
 {
 	struct w83l785ts_data *data = w83l785ts_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/i2c-core.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/i2c-core.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/i2c-core.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/i2c-core.c	2005-05-11 00:32:23.000000000 -0400
@@ -103,7 +103,7 @@ static struct class i2c_adapter_class = 
 	.release =	&i2c_adapter_class_dev_release,
 };
 
-static ssize_t show_adapter_name(struct device *dev, char *buf)
+static ssize_t show_adapter_name(struct device *dev, char *buf, void *private)
 {
 	struct i2c_adapter *adap = dev_to_i2c_adapter(dev);
 	return sprintf(buf, "%s\n", adap->name);
@@ -117,7 +117,7 @@ static void i2c_client_release(struct de
 	complete(&client->released);
 }
 
-static ssize_t show_client_name(struct device *dev, char *buf)
+static ssize_t show_client_name(struct device *dev, char *buf, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	return sprintf(buf, "%s\n", client->name);

------=_Part_1431_17124546.1116063009162--
