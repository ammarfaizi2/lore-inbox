Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVFUDGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVFUDGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVFUDGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:06:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:8676 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261659AbVFTW7g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:36 -0400
Cc: yani.ioannou@gmail.com
Subject: [PATCH] Driver Core: drivers/i2c/chips/pc87360.c - w83627hf.c: update device attribute callbacks
In-Reply-To: <11193083681043@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:28 -0700
Message-Id: <11193083681837@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: drivers/i2c/chips/pc87360.c - w83627hf.c: update device attribute callbacks

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a5099cfc2e82240b0a3e72ad79a5969d5af1a7dc
tree aca3273e927a4d65f8f5fdf4cf5d8283969a3b43
parent 8627f9ba531269d8850919c62af1b017438e2e79
author Yani Ioannou <yani.ioannou@gmail.com> Tue, 17 May 2005 06:42:25 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:33 -0700

 drivers/i2c/chips/pc87360.c    |   68 ++++++++++++++++++++--------------------
 drivers/i2c/chips/pcf8574.c    |    6 ++--
 drivers/i2c/chips/pcf8591.c    |   10 +++---
 drivers/i2c/chips/sis5595.c    |   34 ++++++++++----------
 drivers/i2c/chips/smsc47b397.c |    4 +-
 drivers/i2c/chips/smsc47m1.c   |   20 ++++++------
 drivers/i2c/chips/via686a.c    |   32 +++++++++----------
 drivers/i2c/chips/w83627hf.c   |   56 ++++++++++++++++-----------------
 8 files changed, 115 insertions(+), 115 deletions(-)

diff --git a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c
+++ b/drivers/i2c/chips/pc87360.c
@@ -282,31 +282,31 @@ static ssize_t set_fan_min(struct device
 }
 
 #define show_and_set_fan(offset) \
-static ssize_t show_fan##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[offset-1], \
 		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
 } \
-static ssize_t show_fan##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[offset-1], \
 		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
 } \
-static ssize_t show_fan##offset##_div(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
 		       FAN_DIV_FROM_REG(data->fan_status[offset-1])); \
 } \
-static ssize_t show_fan##offset##_status(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
 		       FAN_STATUS_FROM_REG(data->fan_status[offset-1])); \
 } \
-static ssize_t set_fan##offset##_min(struct device *dev, const char *buf, \
+static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	return set_fan_min(dev, buf, count, offset-1); \
@@ -324,7 +324,7 @@ show_and_set_fan(2)
 show_and_set_fan(3)
 
 #define show_and_set_pwm(offset) \
-static ssize_t show_pwm##offset(struct device *dev, char *buf) \
+static ssize_t show_pwm##offset(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
@@ -332,7 +332,7 @@ static ssize_t show_pwm##offset(struct d
 				    FAN_CONFIG_INVERT(data->fan_conf, \
 						      offset-1))); \
 } \
-static ssize_t set_pwm##offset(struct device *dev, const char *buf, \
+static ssize_t set_pwm##offset(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -354,30 +354,30 @@ show_and_set_pwm(2)
 show_and_set_pwm(3)
 
 #define show_and_set_in(offset) \
-static ssize_t show_in##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_max(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_status(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", data->in_status[offset]); \
 } \
-static ssize_t set_in##offset##_min(struct device *dev, const char *buf, \
+static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -391,7 +391,7 @@ static ssize_t set_in##offset##_min(stru
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_in##offset##_max(struct device *dev, const char *buf, \
+static ssize_t set_in##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -427,36 +427,36 @@ show_and_set_in(9)
 show_and_set_in(10)
 
 #define show_and_set_therm(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_crit(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[offset-4], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_status(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", data->in_status[offset+7]); \
 } \
-static ssize_t set_temp##offset##_min(struct device *dev, const char *buf, \
+static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -470,7 +470,7 @@ static ssize_t set_temp##offset##_min(st
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_temp##offset##_max(struct device *dev, const char *buf, \
+static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -484,7 +484,7 @@ static ssize_t set_temp##offset##_max(st
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_temp##offset##_crit(struct device *dev, const char *buf, \
+static ssize_t set_temp##offset##_crit(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -512,19 +512,19 @@ show_and_set_therm(4)
 show_and_set_therm(5)
 show_and_set_therm(6)
 
-static ssize_t show_vid(struct device *dev, char *buf)
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, char *buf)
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
@@ -533,7 +533,7 @@ static ssize_t set_vrm(struct device *de
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 
-static ssize_t show_in_alarms(struct device *dev, char *buf)
+static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->in_alarms);
@@ -541,32 +541,32 @@ static ssize_t show_in_alarms(struct dev
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
 
 #define show_and_set_temp(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[offset-1])); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[offset-1])); \
 }\
-static ssize_t show_temp##offset##_crit(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[offset-1])); \
 }\
-static ssize_t show_temp##offset##_status(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", data->temp_status[offset-1]); \
 }\
-static ssize_t set_temp##offset##_min(struct device *dev, const char *buf, \
+static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -580,7 +580,7 @@ static ssize_t set_temp##offset##_min(st
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_temp##offset##_max(struct device *dev, const char *buf, \
+static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -594,7 +594,7 @@ static ssize_t set_temp##offset##_max(st
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_temp##offset##_crit(struct device *dev, const char *buf, \
+static ssize_t set_temp##offset##_crit(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -622,7 +622,7 @@ show_and_set_temp(1)
 show_and_set_temp(2)
 show_and_set_temp(3)
 
-static ssize_t show_temp_alarms(struct device *dev, char *buf)
+static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->temp_alarms);
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -76,7 +76,7 @@ static struct i2c_driver pcf8574_driver 
 };
 
 /* following are the sysfs callback functions */
-static ssize_t show_read(struct device *dev, char *buf)
+static ssize_t show_read(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8574_data *data = i2c_get_clientdata(client);
@@ -86,13 +86,13 @@ static ssize_t show_read(struct device *
 
 static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);
 
-static ssize_t show_write(struct device *dev, char *buf)
+static ssize_t show_write(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pcf8574_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%u\n", data->write);
 }
 
-static ssize_t set_write(struct device *dev, const char *buf,
+static ssize_t set_write(struct device *dev, struct device_attribute *attr, const char *buf,
 			 size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
diff --git a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c
+++ b/drivers/i2c/chips/pcf8591.c
@@ -100,7 +100,7 @@ static struct i2c_driver pcf8591_driver 
 
 /* following are the sysfs callback functions */
 #define show_in_channel(channel)					\
-static ssize_t show_in##channel##_input(struct device *dev, char *buf)	\
+static ssize_t show_in##channel##_input(struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return sprintf(buf, "%d\n", pcf8591_read_channel(dev, channel));\
 }									\
@@ -112,13 +112,13 @@ show_in_channel(1);
 show_in_channel(2);
 show_in_channel(3);
 
-static ssize_t show_out0_ouput(struct device *dev, char *buf)
+static ssize_t show_out0_ouput(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%d\n", data->aout * 10);
 }
 
-static ssize_t set_out0_output(struct device *dev, const char *buf, size_t count)
+static ssize_t set_out0_output(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned int value;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -134,13 +134,13 @@ static ssize_t set_out0_output(struct de
 static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO, 
 		   show_out0_ouput, set_out0_output);
 
-static ssize_t show_out0_enable(struct device *dev, char *buf)
+static ssize_t show_out0_enable(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%u\n", !(!(data->control & PCF8591_CONTROL_AOEF)));
 }
 
-static ssize_t set_out0_enable(struct device *dev, const char *buf, size_t count)
+static ssize_t set_out0_enable(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
diff --git a/drivers/i2c/chips/sis5595.c b/drivers/i2c/chips/sis5595.c
--- a/drivers/i2c/chips/sis5595.c
+++ b/drivers/i2c/chips/sis5595.c
@@ -256,28 +256,28 @@ static ssize_t set_in_max(struct device 
 
 #define show_in_offset(offset)					\
 static ssize_t							\
-	show_in##offset (struct device *dev, char *buf)		\
+	show_in##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
 {								\
 	return show_in(dev, buf, offset);			\
 }								\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
 		show_in##offset, NULL);				\
 static ssize_t							\
-	show_in##offset##_min (struct device *dev, char *buf)	\
+	show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	return show_in_min(dev, buf, offset);			\
 }								\
 static ssize_t							\
-	show_in##offset##_max (struct device *dev, char *buf)	\
+	show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	return show_in_max(dev, buf, offset);			\
 }								\
-static ssize_t set_in##offset##_min (struct device *dev,	\
+static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr,	\
 		const char *buf, size_t count)			\
 {								\
 	return set_in_min(dev, buf, count, offset);		\
 }								\
-static ssize_t set_in##offset##_max (struct device *dev,	\
+static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr,	\
 		const char *buf, size_t count)			\
 {								\
 	return set_in_max(dev, buf, count, offset);		\
@@ -294,19 +294,19 @@ show_in_offset(3);
 show_in_offset(4);
 
 /* Temperature */
-static ssize_t show_temp(struct device *dev, char *buf)
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
-static ssize_t show_temp_over(struct device *dev, char *buf)
+static ssize_t show_temp_over(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
-static ssize_t set_temp_over(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp_over(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
@@ -319,13 +319,13 @@ static ssize_t set_temp_over(struct devi
 	return count;
 }
 
-static ssize_t show_temp_hyst(struct device *dev, char *buf)
+static ssize_t show_temp_hyst(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst));
 }
 
-static ssize_t set_temp_hyst(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sis5595_data *data = i2c_get_clientdata(client);
@@ -426,19 +426,19 @@ static ssize_t set_fan_div(struct device
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan_div(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_fan_##offset##_min (struct device *dev,		\
+static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr,		\
 		const char *buf, size_t count)				\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
@@ -450,13 +450,13 @@ static DEVICE_ATTR(fan##offset##_min, S_
 show_fan_offset(1);
 show_fan_offset(2);
 
-static ssize_t set_fan_1_div(struct device *dev, const char *buf,
+static ssize_t set_fan_1_div(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	return set_fan_div(dev, buf, count, 0) ;
 }
 
-static ssize_t set_fan_2_div(struct device *dev, const char *buf,
+static ssize_t set_fan_2_div(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	return set_fan_div(dev, buf, count, 1) ;
@@ -467,7 +467,7 @@ static DEVICE_ATTR(fan2_div, S_IRUGO | S
 		show_fan_2_div, set_fan_2_div);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
diff --git a/drivers/i2c/chips/smsc47b397.c b/drivers/i2c/chips/smsc47b397.c
--- a/drivers/i2c/chips/smsc47b397.c
+++ b/drivers/i2c/chips/smsc47b397.c
@@ -172,7 +172,7 @@ static ssize_t show_temp(struct device *
 }
 
 #define sysfs_temp(num) \
-static ssize_t show_temp##num(struct device *dev, char *buf) \
+static ssize_t show_temp##num(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp(dev, buf, num-1); \
 } \
@@ -201,7 +201,7 @@ static ssize_t show_fan(struct device *d
 }
 
 #define sysfs_fan(num) \
-static ssize_t show_fan##num(struct device *dev, char *buf) \
+static ssize_t show_fan##num(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan(dev, buf, num-1); \
 } \
diff --git a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c
+++ b/drivers/i2c/chips/smsc47m1.c
@@ -184,7 +184,7 @@ static ssize_t get_pwm_en(struct device 
 	return sprintf(buf, "%d\n", PWM_EN_FROM_REG(data->pwm[nr]));
 }
 
-static ssize_t get_alarms(struct device *dev, char *buf)
+static ssize_t get_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
 	return sprintf(buf, "%d\n", data->alarms);
@@ -298,42 +298,42 @@ static ssize_t set_pwm_en(struct device 
 }
 
 #define fan_present(offset)						\
-static ssize_t get_fan##offset (struct device *dev, char *buf)		\
+static ssize_t get_fan##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	return get_fan(dev, buf, offset - 1);				\
 }									\
-static ssize_t get_fan##offset##_min (struct device *dev, char *buf)	\
+static ssize_t get_fan##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return get_fan_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_fan##offset##_min (struct device *dev,		\
+static ssize_t set_fan##offset##_min (struct device *dev, struct device_attribute *attr,		\
 		const char *buf, size_t count)				\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t get_fan##offset##_div (struct device *dev, char *buf)	\
+static ssize_t get_fan##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return get_fan_div(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_fan##offset##_div (struct device *dev,		\
+static ssize_t set_fan##offset##_div (struct device *dev, struct device_attribute *attr,		\
 		const char *buf, size_t count)				\
 {									\
 	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t get_pwm##offset (struct device *dev, char *buf)		\
+static ssize_t get_pwm##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	return get_pwm(dev, buf, offset - 1);				\
 }									\
-static ssize_t set_pwm##offset (struct device *dev,			\
+static ssize_t set_pwm##offset (struct device *dev, struct device_attribute *attr,			\
 		const char *buf, size_t count)				\
 {									\
 	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
-static ssize_t get_pwm##offset##_en (struct device *dev, char *buf)	\
+static ssize_t get_pwm##offset##_en (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return get_pwm_en(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_pwm##offset##_en (struct device *dev,		\
+static ssize_t set_pwm##offset##_en (struct device *dev, struct device_attribute *attr,		\
 		const char *buf, size_t count)				\
 {									\
 	return set_pwm_en(dev, buf, count, offset - 1);			\
diff --git a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c
+++ b/drivers/i2c/chips/via686a.c
@@ -386,26 +386,26 @@ static ssize_t set_in_max(struct device 
 }
 #define show_in_offset(offset)					\
 static ssize_t 							\
-	show_in##offset (struct device *dev, char *buf)		\
+	show_in##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
 {								\
 	return show_in(dev, buf, offset);			\
 }								\
 static ssize_t 							\
-	show_in##offset##_min (struct device *dev, char *buf)	\
+	show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	return show_in_min(dev, buf, offset);		\
 }								\
 static ssize_t 							\
-	show_in##offset##_max (struct device *dev, char *buf)	\
+	show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	return show_in_max(dev, buf, offset);		\
 }								\
-static ssize_t set_in##offset##_min (struct device *dev, 	\
+static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr, 	\
 		const char *buf, size_t count) 			\
 {								\
 	return set_in_min(dev, buf, count, offset);		\
 }								\
-static ssize_t set_in##offset##_max (struct device *dev,	\
+static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr,	\
 			const char *buf, size_t count)		\
 {								\
 	return set_in_max(dev, buf, count, offset);		\
@@ -460,26 +460,26 @@ static ssize_t set_temp_hyst(struct devi
 	return count;
 }
 #define show_temp_offset(offset)					\
-static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
+static ssize_t show_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t								\
-show_temp_##offset##_over (struct device *dev, char *buf)		\
+show_temp_##offset##_over (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	return show_temp_over(dev, buf, offset - 1);			\
 }									\
 static ssize_t								\
-show_temp_##offset##_hyst (struct device *dev, char *buf)		\
+show_temp_##offset##_hyst (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	return show_temp_hyst(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_temp_##offset##_over (struct device *dev, 		\
+static ssize_t set_temp_##offset##_over (struct device *dev, struct device_attribute *attr, 		\
 		const char *buf, size_t count) 				\
 {									\
 	return set_temp_over(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t set_temp_##offset##_hyst (struct device *dev, 		\
+static ssize_t set_temp_##offset##_hyst (struct device *dev, struct device_attribute *attr, 		\
 		const char *buf, size_t count) 				\
 {									\
 	return set_temp_hyst(dev, buf, count, offset - 1);		\
@@ -538,24 +538,24 @@ static ssize_t set_fan_div(struct device
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan(dev, buf, offset - 1);				\
 }									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan_div(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_fan_##offset##_min (struct device *dev, 		\
+static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
 	const char *buf, size_t count) 					\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t set_fan_##offset##_div (struct device *dev, 		\
+static ssize_t set_fan_##offset##_div (struct device *dev, struct device_attribute *attr, 		\
 		const char *buf, size_t count) 				\
 {									\
 	return set_fan_div(dev, buf, count, offset - 1);		\
@@ -570,7 +570,7 @@ show_fan_offset(1);
 show_fan_offset(2);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, char *buf) {
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf) {
 	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
 }
diff --git a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c
+++ b/drivers/i2c/chips/w83627hf.c
@@ -368,19 +368,19 @@ store_in_reg(MAX, max)
 
 #define sysfs_in_offset(offset) \
 static ssize_t \
-show_regs_in_##offset (struct device *dev, char *buf) \
+show_regs_in_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
         return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
-static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_in_##reg (dev, buf, offset); \
 } \
 static ssize_t \
-store_regs_in_##reg##offset (struct device *dev, \
+store_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, \
 			    const char *buf, size_t count) \
 { \
 	return store_in_##reg (dev, buf, count, offset); \
@@ -419,25 +419,25 @@ static ssize_t show_in_0(struct w83627hf
 	return sprintf(buf,"%ld\n", in0);
 }
 
-static ssize_t show_regs_in_0(struct device *dev, char *buf)
+static ssize_t show_regs_in_0(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in[0]);
 }
 
-static ssize_t show_regs_in_min0(struct device *dev, char *buf)
+static ssize_t show_regs_in_min0(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in_min[0]);
 }
 
-static ssize_t show_regs_in_max0(struct device *dev, char *buf)
+static ssize_t show_regs_in_max0(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in_max[0]);
 }
 
-static ssize_t store_regs_in_min0(struct device *dev,
+static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -462,7 +462,7 @@ static ssize_t store_regs_in_min0(struct
 	return count;
 }
 
-static ssize_t store_regs_in_max0(struct device *dev,
+static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -531,19 +531,19 @@ store_fan_min(struct device *dev, const 
 }
 
 #define sysfs_fan_offset(offset) \
-static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan(dev, buf, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
-static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_min##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan_min(dev, buf, offset); \
 } \
 static ssize_t \
-store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
+store_regs_fan_min##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	return store_fan_min(dev, buf, count, offset); \
 } \
@@ -608,19 +608,19 @@ store_temp_reg(HYST, max_hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
-show_regs_temp_##offset (struct device *dev, char *buf) \
+show_regs_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp(dev, buf, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
-static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp_##reg (dev, buf, offset); \
 } \
 static ssize_t \
-store_regs_temp_##reg##offset (struct device *dev, \
+store_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, \
 			      const char *buf, size_t count) \
 { \
 	return store_temp_##reg (dev, buf, count, offset); \
@@ -645,7 +645,7 @@ device_create_file(&client->dev, &dev_at
 } while (0)
 
 static ssize_t
-show_vid_reg(struct device *dev, char *buf)
+show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
@@ -655,13 +655,13 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 static ssize_t
-show_vrm_reg(struct device *dev, char *buf)
+show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 static ssize_t
-store_vrm_reg(struct device *dev, const char *buf, size_t count)
+store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83627hf_data *data = i2c_get_clientdata(client);
@@ -677,7 +677,7 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUS
 device_create_file(&client->dev, &dev_attr_vrm)
 
 static ssize_t
-show_alarms_reg(struct device *dev, char *buf)
+show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->alarms);
@@ -687,7 +687,7 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
 device_create_file(&client->dev, &dev_attr_alarms)
 
 #define show_beep_reg(REG, reg) \
-static ssize_t show_beep_##reg (struct device *dev, char *buf) \
+static ssize_t show_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct w83627hf_data *data = w83627hf_update_device(dev); \
 	return sprintf(buf,"%ld\n", \
@@ -732,12 +732,12 @@ store_beep_reg(struct device *dev, const
 }
 
 #define sysfs_beep(REG, reg) \
-static ssize_t show_regs_beep_##reg (struct device *dev, char *buf) \
+static ssize_t show_regs_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
-	return show_beep_##reg(dev, buf); \
+	return show_beep_##reg(dev, attr, buf); \
 } \
 static ssize_t \
-store_regs_beep_##reg (struct device *dev, const char *buf, size_t count) \
+store_regs_beep_##reg (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	return store_beep_reg(dev, buf, count, BEEP_##REG); \
 } \
@@ -801,12 +801,12 @@ store_fan_div_reg(struct device *dev, co
 }
 
 #define sysfs_fan_div(offset) \
-static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan_div_reg(dev, buf, offset); \
 } \
 static ssize_t \
-store_regs_fan_div_##offset (struct device *dev, \
+store_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, \
 			    const char *buf, size_t count) \
 { \
 	return store_fan_div_reg(dev, buf, count, offset - 1); \
@@ -861,12 +861,12 @@ store_pwm_reg(struct device *dev, const 
 }
 
 #define sysfs_pwm(offset) \
-static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_pwm_reg(dev, buf, offset); \
 } \
 static ssize_t \
-store_regs_pwm_##offset (struct device *dev, const char *buf, size_t count) \
+store_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
@@ -937,12 +937,12 @@ store_sensor_reg(struct device *dev, con
 }
 
 #define sysfs_sensor(offset) \
-static ssize_t show_regs_sensor_##offset (struct device *dev, char *buf) \
+static ssize_t show_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
     return show_sensor_reg(dev, buf, offset); \
 } \
 static ssize_t \
-store_regs_sensor_##offset (struct device *dev, const char *buf, size_t count) \
+store_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
     return store_sensor_reg(dev, buf, count, offset); \
 } \

