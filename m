Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUFVX2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUFVX2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUFVR5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:57:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:50869 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265086AbUFVRni convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:38 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261092064@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:49 -0700
Message-Id: <10879261092729@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.48, 2004/06/03 11:42:20-07:00, greg@kroah.com

Driver Model: Cleanup the i2c driver silly use of the *ATTR macros which just broke

 
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/asb100.c    |   66 ++++++++++++++--------------
 drivers/i2c/chips/it87.c      |   22 ++++-----
 drivers/i2c/chips/lm78.c      |   22 ++++-----
 drivers/i2c/chips/lm85.c      |   26 +++++------
 drivers/i2c/chips/via686a.c   |   18 +++----
 drivers/i2c/chips/w83627hf.c  |   98 +++++++++++++++++++++---------------------
 drivers/i2c/chips/w83781d.c   |   30 ++++++------
 drivers/i2c/chips/w83l785ts.c |    4 -
 8 files changed, 143 insertions(+), 143 deletions(-)


diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Tue Jun 22 09:48:50 2004
+++ b/drivers/i2c/chips/asb100.c	Tue Jun 22 09:48:50 2004
@@ -272,7 +272,7 @@
 	return show_in(dev, buf, 0x##offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
-		show_in##offset, NULL) \
+		show_in##offset, NULL); \
 static ssize_t \
 	show_in##offset##_min (struct device *dev, char *buf) \
 { \
@@ -294,17 +294,17 @@
 	return set_in_max(dev, buf, count, 0x##offset); \
 } \
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
-		show_in##offset##_min, set_in##offset##_min) \
+		show_in##offset##_min, set_in##offset##_min); \
 static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, \
-		show_in##offset##_max, set_in##offset##_max)
+		show_in##offset##_max, set_in##offset##_max);
 
-sysfs_in(0)
-sysfs_in(1)
-sysfs_in(2)
-sysfs_in(3)
-sysfs_in(4)
-sysfs_in(5)
-sysfs_in(6)
+sysfs_in(0);
+sysfs_in(1);
+sysfs_in(2);
+sysfs_in(3);
+sysfs_in(4);
+sysfs_in(5);
+sysfs_in(6);
 
 #define device_create_file_in(client, offset) do { \
 	device_create_file(&client->dev, &dev_attr_in##offset##_input); \
@@ -410,15 +410,15 @@
 	return set_fan_div(dev, buf, count, offset - 1); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
-		show_fan##offset, NULL) \
+		show_fan##offset, NULL); \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
-		show_fan##offset##_min, set_fan##offset##_min) \
+		show_fan##offset##_min, set_fan##offset##_min); \
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
-		show_fan##offset##_div, set_fan##offset##_div)
+		show_fan##offset##_div, set_fan##offset##_div);
 
-sysfs_fan(1)
-sysfs_fan(2)
-sysfs_fan(3)
+sysfs_fan(1);
+sysfs_fan(2);
+sysfs_fan(3);
 
 #define device_create_file_fan(client, offset) do { \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
@@ -449,9 +449,9 @@
 	return sprintf_temp_from_reg(data->reg[nr], buf, nr); \
 }
 
-show_temp_reg(temp)
-show_temp_reg(temp_max)
-show_temp_reg(temp_hyst)
+show_temp_reg(temp);
+show_temp_reg(temp_max);
+show_temp_reg(temp_hyst);
 
 #define set_temp_reg(REG, reg) \
 static ssize_t set_##reg(struct device *dev, const char *buf, \
@@ -473,15 +473,15 @@
 	return count; \
 }
 
-set_temp_reg(MAX, temp_max)
-set_temp_reg(HYST, temp_hyst)
+set_temp_reg(MAX, temp_max);
+set_temp_reg(HYST, temp_hyst);
 
 #define sysfs_temp(num) \
 static ssize_t show_temp##num(struct device *dev, char *buf) \
 { \
 	return show_temp(dev, buf, num-1); \
 } \
-static DEVICE_ATTR(temp##num##_input, S_IRUGO, show_temp##num, NULL) \
+static DEVICE_ATTR(temp##num##_input, S_IRUGO, show_temp##num, NULL); \
 static ssize_t show_temp_max##num(struct device *dev, char *buf) \
 { \
 	return show_temp_max(dev, buf, num-1); \
@@ -492,7 +492,7 @@
 	return set_temp_max(dev, buf, count, num-1); \
 } \
 static DEVICE_ATTR(temp##num##_max, S_IRUGO | S_IWUSR, \
-		show_temp_max##num, set_temp_max##num) \
+		show_temp_max##num, set_temp_max##num); \
 static ssize_t show_temp_hyst##num(struct device *dev, char *buf) \
 { \
 	return show_temp_hyst(dev, buf, num-1); \
@@ -503,12 +503,12 @@
 	return set_temp_hyst(dev, buf, count, num-1); \
 } \
 static DEVICE_ATTR(temp##num##_max_hyst, S_IRUGO | S_IWUSR, \
-		show_temp_hyst##num, set_temp_hyst##num)
+		show_temp_hyst##num, set_temp_hyst##num);
 
-sysfs_temp(1)
-sysfs_temp(2)
-sysfs_temp(3)
-sysfs_temp(4)
+sysfs_temp(1);
+sysfs_temp(2);
+sysfs_temp(3);
+sysfs_temp(4);
 
 /* VID */
 #define device_create_file_temp(client, num) do { \
@@ -523,7 +523,7 @@
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL)
+static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL);
 #define device_create_file_vid(client) \
 device_create_file(&client->dev, &dev_attr_in0_ref)
 
@@ -544,7 +544,7 @@
 }
 
 /* Alarms */
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm)
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 #define device_create_file_vrm(client) \
 device_create_file(&client->dev, &dev_attr_vrm);
 
@@ -554,7 +554,7 @@
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
 }
 
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL)
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 #define device_create_file_alarms(client) \
 device_create_file(&client->dev, &dev_attr_alarms)
 
@@ -594,9 +594,9 @@
 	return count;
 }
 
-static DEVICE_ATTR(fan1_pwm, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1)
+static DEVICE_ATTR(fan1_pwm, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1);
 static DEVICE_ATTR(fan1_pwm_enable, S_IRUGO | S_IWUSR,
-		show_pwm_enable1, set_pwm_enable1)
+		show_pwm_enable1, set_pwm_enable1);
 #define device_create_file_pwm1(client) do { \
 	device_create_file(&new_client->dev, &dev_attr_fan1_pwm); \
 	device_create_file(&new_client->dev, &dev_attr_fan1_pwm_enable); \
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue Jun 22 09:48:50 2004
+++ b/drivers/i2c/chips/it87.c	Tue Jun 22 09:48:50 2004
@@ -275,7 +275,7 @@
 {								\
 	return show_in(dev, buf, 0x##offset);			\
 }								\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL)
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);
 
 #define limit_in_offset(offset)					\
 static ssize_t							\
@@ -299,9 +299,9 @@
 	return set_in_max(dev, buf, count, 0x##offset);		\
 }								\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_min, set_in##offset##_min)	\
+		show_in##offset##_min, set_in##offset##_min);	\
 static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_max, set_in##offset##_max)
+		show_in##offset##_max, set_in##offset##_max);
 
 show_in_offset(0);
 limit_in_offset(0);
@@ -382,11 +382,11 @@
 {									\
 	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL) \
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL); \
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_max, set_temp_##offset##_max) 	\
+		show_temp_##offset##_max, set_temp_##offset##_max); 	\
 static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_min, set_temp_##offset##_min)	
+		show_temp_##offset##_min, set_temp_##offset##_min);	
 
 show_temp_offset(1);
 show_temp_offset(2);
@@ -430,8 +430,8 @@
 {									\
 	return set_sensor(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR,	 		\
-		show_sensor_##offset, set_sensor_##offset)
+static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, 		\
+		show_sensor_##offset, set_sensor_##offset);
 
 show_sensor_offset(1);
 show_sensor_offset(2);
@@ -525,11 +525,11 @@
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL); \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_min, set_fan_##offset##_min) 	\
+		show_fan_##offset##_min, set_fan_##offset##_min); 	\
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_div, set_fan_##offset##_div)
+		show_fan_##offset##_div, set_fan_##offset##_div);
 
 show_fan_offset(1);
 show_fan_offset(2);
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Tue Jun 22 09:48:50 2004
+++ b/drivers/i2c/chips/lm78.c	Tue Jun 22 09:48:50 2004
@@ -281,7 +281,7 @@
 	return show_in(dev, buf, 0x##offset);			\
 }								\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
-		show_in##offset, NULL)				\
+		show_in##offset, NULL);				\
 static ssize_t							\
 	show_in##offset##_min (struct device *dev, char *buf)   \
 {								\
@@ -303,9 +303,9 @@
 	return set_in_max(dev, buf, count, 0x##offset);		\
 }								\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,		\
-		show_in##offset##_min, set_in##offset##_min)    \
+		show_in##offset##_min, set_in##offset##_min);	\
 static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,		\
-		show_in##offset##_max, set_in##offset##_max)
+		show_in##offset##_max, set_in##offset##_max);
 
 show_in_offset(0);
 show_in_offset(1);
@@ -354,11 +354,11 @@
 	return count;
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL)
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
 static DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
-		show_temp_over, set_temp_over)
+		show_temp_over, set_temp_over);
 static DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
-		show_temp_hyst, set_temp_hyst)
+		show_temp_hyst, set_temp_hyst);
 
 /* 3 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
@@ -439,9 +439,9 @@
 {									\
 	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
-		show_fan_##offset##_min, set_fan_##offset##_min)
+		show_fan_##offset##_min, set_fan_##offset##_min);
 
 static ssize_t set_fan_1_div(struct device *dev, const char *buf,
 		size_t count)
@@ -461,10 +461,10 @@
 
 /* Fan 3 divisor is locked in H/W */
 static DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
-		show_fan_1_div, set_fan_1_div)
+		show_fan_1_div, set_fan_1_div);
 static DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
-		show_fan_2_div, set_fan_2_div)
-static DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_3_div, NULL)
+		show_fan_2_div, set_fan_2_div);
+static DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_3_div, NULL);
 
 /* VID */
 static ssize_t show_vid(struct device *dev, char *buf)
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Tue Jun 22 09:48:50 2004
+++ b/drivers/i2c/chips/lm85.c	Tue Jun 22 09:48:50 2004
@@ -451,9 +451,9 @@
 {									\
 	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_min, set_fan_##offset##_min)
+		show_fan_##offset##_min, set_fan_##offset##_min);
 
 show_fan_offset(1);
 show_fan_offset(2);
@@ -468,7 +468,7 @@
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
 
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL)
+static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
@@ -487,7 +487,7 @@
 	return count;
 }
 
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg)
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 
 static ssize_t show_alarms_reg(struct device *dev, char *buf)
 {
@@ -495,7 +495,7 @@
 	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
 }
 
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL)
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 
 /* pwm */
 
@@ -542,8 +542,8 @@
 	return show_pwm_enable(dev, buf, 0x##offset - 1);			\
 }									\
 static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, 			\
-		show_pwm_##offset, set_pwm_##offset)			\
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO, show_pwm_enable##offset, NULL)
+		show_pwm_##offset, set_pwm_##offset);			\
+static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO, show_pwm_enable##offset, NULL);
 
 show_pwm_reg(1);
 show_pwm_reg(2);
@@ -617,11 +617,11 @@
 {									\
 	return set_in_max(dev, buf, count, 0x##offset);			\
 }									\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in_##offset, NULL)	\
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in_##offset, NULL);	\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_in_##offset##_min, set_in_##offset##_min)		\
+		show_in_##offset##_min, set_in_##offset##_min);		\
 static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 		\
-		show_in_##offset##_max, set_in_##offset##_max)
+		show_in_##offset##_max, set_in_##offset##_max);
 
 show_in_reg(0);
 show_in_reg(1);
@@ -697,11 +697,11 @@
 {									\
 	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL)	\
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);	\
 static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_min, set_temp_##offset##_min)	\
+		show_temp_##offset##_min, set_temp_##offset##_min);	\
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_max, set_temp_##offset##_max)
+		show_temp_##offset##_max, set_temp_##offset##_max);
 
 show_temp_reg(1);
 show_temp_reg(2);
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Tue Jun 22 09:48:50 2004
+++ b/drivers/i2c/chips/via686a.c	Tue Jun 22 09:48:50 2004
@@ -405,11 +405,11 @@
 {								\
 	return set_in_max(dev, buf, count, 0x##offset);		\
 }								\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL) 	\
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_min, set_in##offset##_min)	\
+		show_in##offset##_min, set_in##offset##_min);	\
 static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_max, set_in##offset##_max)
+		show_in##offset##_max, set_in##offset##_max);
 
 show_in_offset(0);
 show_in_offset(1);
@@ -473,11 +473,11 @@
 {									\
 	return set_temp_hyst(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL) \
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);\
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_over, set_temp_##offset##_over) 	\
+		show_temp_##offset##_over, set_temp_##offset##_over);	\
 static DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_hyst, set_temp_##offset##_hyst)	
+		show_temp_##offset##_hyst, set_temp_##offset##_hyst);	
 
 show_temp_offset(1);
 show_temp_offset(2);
@@ -542,11 +542,11 @@
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_min, set_fan_##offset##_min) 	\
+		show_fan_##offset##_min, set_fan_##offset##_min);	\
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_div, set_fan_##offset##_div)
+		show_fan_##offset##_div, set_fan_##offset##_div);
 
 show_fan_offset(1);
 show_fan_offset(2);
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:48:50 2004
+++ b/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:48:50 2004
@@ -370,7 +370,7 @@
 { \
         return show_in(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL)
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
 static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
@@ -384,22 +384,22 @@
 	return store_in_##reg (dev, buf, count, 0x##offset); \
 } \
 static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, \
-		  show_regs_in_##reg##offset, store_regs_in_##reg##offset)
+		  show_regs_in_##reg##offset, store_regs_in_##reg##offset);
 
 #define sysfs_in_offsets(offset) \
 sysfs_in_offset(offset) \
 sysfs_in_reg_offset(min, offset) \
 sysfs_in_reg_offset(max, offset)
 
-sysfs_in_offsets(0)
-sysfs_in_offsets(1)
-sysfs_in_offsets(2)
-sysfs_in_offsets(3)
-sysfs_in_offsets(4)
-sysfs_in_offsets(5)
-sysfs_in_offsets(6)
-sysfs_in_offsets(7)
-sysfs_in_offsets(8)
+sysfs_in_offsets(0);
+sysfs_in_offsets(1);
+sysfs_in_offsets(2);
+sysfs_in_offsets(3);
+sysfs_in_offsets(4);
+sysfs_in_offsets(5);
+sysfs_in_offsets(6);
+sysfs_in_offsets(7);
+sysfs_in_offsets(8);
 
 #define device_create_file_in(client, offset) \
 do { \
@@ -416,8 +416,8 @@
 		FAN_FROM_REG(data->reg[nr-1], \
 			    (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
 }
-show_fan_reg(fan)
-show_fan_reg(fan_min)
+show_fan_reg(fan);
+show_fan_reg(fan_min);
 
 static ssize_t
 store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
@@ -440,7 +440,7 @@
 { \
 	return show_fan(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL)
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
@@ -453,14 +453,14 @@
 	return store_fan_min(dev, buf, count, 0x##offset); \
 } \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
-		  show_regs_fan_min##offset, store_regs_fan_min##offset)
+		  show_regs_fan_min##offset, store_regs_fan_min##offset);
 
-sysfs_fan_offset(1)
-sysfs_fan_min_offset(1)
-sysfs_fan_offset(2)
-sysfs_fan_min_offset(2)
-sysfs_fan_offset(3)
-sysfs_fan_min_offset(3)
+sysfs_fan_offset(1);
+sysfs_fan_min_offset(1);
+sysfs_fan_offset(2);
+sysfs_fan_min_offset(2);
+sysfs_fan_offset(3);
+sysfs_fan_min_offset(3);
 
 #define device_create_file_fan(client, offset) \
 do { \
@@ -479,9 +479,9 @@
 		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
 	} \
 }
-show_temp_reg(temp)
-show_temp_reg(temp_max)
-show_temp_reg(temp_max_hyst)
+show_temp_reg(temp);
+show_temp_reg(temp_max);
+show_temp_reg(temp_max_hyst);
 
 #define store_temp_reg(REG, reg) \
 static ssize_t \
@@ -505,8 +505,8 @@
 	 \
 	return count; \
 }
-store_temp_reg(OVER, max)
-store_temp_reg(HYST, max_hyst)
+store_temp_reg(OVER, max);
+store_temp_reg(HYST, max_hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
@@ -514,7 +514,7 @@
 { \
 	return show_temp(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL)
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
@@ -528,16 +528,16 @@
 	return store_temp_##reg (dev, buf, count, 0x##offset); \
 } \
 static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, \
-		  show_regs_temp_##reg##offset, store_regs_temp_##reg##offset)
+		  show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
 
 #define sysfs_temp_offsets(offset) \
 sysfs_temp_offset(offset) \
 sysfs_temp_reg_offset(max, offset) \
 sysfs_temp_reg_offset(max_hyst, offset)
 
-sysfs_temp_offsets(1)
-sysfs_temp_offsets(2)
-sysfs_temp_offsets(3)
+sysfs_temp_offsets(1);
+sysfs_temp_offsets(2);
+sysfs_temp_offsets(3);
 
 #define device_create_file_temp(client, offset) \
 do { \
@@ -552,7 +552,7 @@
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL)
+static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
 device_create_file(&client->dev, &dev_attr_in0_ref)
 
@@ -574,7 +574,7 @@
 
 	return count;
 }
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg)
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 #define device_create_file_vrm(client) \
 device_create_file(&client->dev, &dev_attr_vrm)
 
@@ -584,7 +584,7 @@
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL)
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 #define device_create_file_alarms(client) \
 device_create_file(&client->dev, &dev_attr_alarms)
 
@@ -641,10 +641,10 @@
 	return store_beep_reg(dev, buf, count, BEEP_##REG); \
 } \
 static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR, \
-		  show_regs_beep_##reg, store_regs_beep_##reg)
+		  show_regs_beep_##reg, store_regs_beep_##reg);
 
-sysfs_beep(ENABLE, enable)
-sysfs_beep(MASK, mask)
+sysfs_beep(ENABLE, enable);
+sysfs_beep(MASK, mask);
 
 #define device_create_file_beep(client) \
 do { \
@@ -707,11 +707,11 @@
 	return store_fan_div_reg(dev, buf, count, offset - 1); \
 } \
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
-		  show_regs_fan_div_##offset, store_regs_fan_div_##offset)
+		  show_regs_fan_div_##offset, store_regs_fan_div_##offset);
 
-sysfs_fan_div(1)
-sysfs_fan_div(2)
-sysfs_fan_div(3)
+sysfs_fan_div(1);
+sysfs_fan_div(2);
+sysfs_fan_div(3);
 
 #define device_create_file_fan_div(client, offset) \
 do { \
@@ -763,11 +763,11 @@
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, \
-		  show_regs_pwm_##offset, store_regs_pwm_##offset)
+		  show_regs_pwm_##offset, store_regs_pwm_##offset);
 
-sysfs_pwm(1)
-sysfs_pwm(2)
-sysfs_pwm(3)
+sysfs_pwm(1);
+sysfs_pwm(2);
+sysfs_pwm(3);
 
 #define device_create_file_pwm(client, offset) \
 do { \
@@ -836,11 +836,11 @@
     return store_sensor_reg(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, \
-		  show_regs_sensor_##offset, store_regs_sensor_##offset)
+		  show_regs_sensor_##offset, store_regs_sensor_##offset);
 
-sysfs_sensor(1)
-sysfs_sensor(2)
-sysfs_sensor(3)
+sysfs_sensor(1);
+sysfs_sensor(2);
+sysfs_sensor(3);
 
 #define device_create_file_sensor(client, offset) \
 do { \
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Tue Jun 22 09:48:50 2004
+++ b/drivers/i2c/chips/w83781d.c	Tue Jun 22 09:48:50 2004
@@ -320,7 +320,7 @@
 { \
         return show_in(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL)
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
 static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
@@ -331,7 +331,7 @@
 { \
 	return store_in_##reg (dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset)
+static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset);
 
 #define sysfs_in_offsets(offset) \
 sysfs_in_offset(offset); \
@@ -386,7 +386,7 @@
 { \
 	return show_fan(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL)
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
@@ -397,7 +397,7 @@
 { \
 	return store_fan_min(dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, show_regs_fan_min##offset, store_regs_fan_min##offset)
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, show_regs_fan_min##offset, store_regs_fan_min##offset);
 
 sysfs_fan_offset(1);
 sysfs_fan_min_offset(1);
@@ -466,7 +466,7 @@
 { \
 	return show_temp(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL)
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
@@ -477,7 +477,7 @@
 { \
 	return store_temp_##reg (dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_temp_##reg##offset, store_regs_temp_##reg##offset)
+static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
 
 #define sysfs_temp_offsets(offset) \
 sysfs_temp_offset(offset); \
@@ -503,7 +503,7 @@
 }
 
 static
-DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL)
+DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
 device_create_file(&client->dev, &dev_attr_in0_ref);
 static ssize_t
@@ -527,7 +527,7 @@
 }
 
 static
-DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg)
+DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 #define device_create_file_vrm(client) \
 device_create_file(&client->dev, &dev_attr_vrm);
 static ssize_t
@@ -538,7 +538,7 @@
 }
 
 static
-DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL)
+DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 #define device_create_file_alarms(client) \
 device_create_file(&client->dev, &dev_attr_alarms);
 static ssize_t show_beep_mask (struct device *dev, char *buf)
@@ -598,7 +598,7 @@
 { \
 	return store_beep_reg(dev, buf, count, BEEP_##REG); \
 } \
-static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR, show_regs_beep_##reg, store_regs_beep_##reg)
+static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR, show_regs_beep_##reg, store_regs_beep_##reg);
 
 sysfs_beep(ENABLE, enable);
 sysfs_beep(MASK, mask);
@@ -665,7 +665,7 @@
 { \
 	return store_fan_div_reg(dev, buf, count, offset - 1); \
 } \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset)
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset);
 
 sysfs_fan_div(1);
 sysfs_fan_div(2);
@@ -744,7 +744,7 @@
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, show_regs_pwm_##offset, store_regs_pwm_##offset)
+static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, show_regs_pwm_##offset, store_regs_pwm_##offset);
 
 #define sysfs_pwmenable(offset) \
 static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf) \
@@ -755,7 +755,7 @@
 { \
 	return store_pwmenable_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO | S_IWUSR, show_regs_pwmenable_##offset, store_regs_pwmenable_##offset)
+static DEVICE_ATTR(fan##offset##_pwm_enable, S_IRUGO | S_IWUSR, show_regs_pwmenable_##offset, store_regs_pwmenable_##offset);
 
 sysfs_pwm(1);
 sysfs_pwm(2);
@@ -833,7 +833,7 @@
 { \
     return store_sensor_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, show_regs_sensor_##offset, store_regs_sensor_##offset)
+static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, show_regs_sensor_##offset, store_regs_sensor_##offset);
 
 sysfs_sensor(1);
 sysfs_sensor(2);
@@ -891,7 +891,7 @@
 { \
     return store_rt_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(rt##offset, S_IRUGO | S_IWUSR, show_regs_rt_##offset, store_regs_rt_##offset)
+static DEVICE_ATTR(rt##offset, S_IRUGO | S_IWUSR, show_regs_rt_##offset, store_regs_rt_##offset);
 
 sysfs_rt(1);
 sysfs_rt(2);
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Tue Jun 22 09:48:50 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Tue Jun 22 09:48:50 2004
@@ -137,8 +137,8 @@
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL)
-static DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_over, NULL)
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
+static DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_over, NULL);
 
 /*
  * Real code

