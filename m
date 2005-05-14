Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVENJlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVENJlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 05:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVENJlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 05:41:44 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:33428 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262715AbVENJ3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:29:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=K6O/B0nLwpYaIrQgOW75Akn4yIcYcQdGib66dpDhL3Nj3xJn8RhQCY3jMJxKVRVbufB/B1XFEpwop6C8ObKM0MlGG5QVOVVQayzNaBELvAOldxAu74gqB5R9n/TkdyYVE8hhs9r63+8ixAvKG6tPHxK0cdwGeq1Kfb4W+VnBF1Y=
Message-ID: <253818670505140229b2310e0@mail.gmail.com>
Date: Sat, 14 May 2005 05:29:20 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 6/12] drivers/i2c/chips/lm78.c - max1619.c: (dynamic sysfs callbacks) update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1427_27889255.1116062960518"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1427_27889255.1116062960518
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_1427_27889255.1116062960518
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.2.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.2.diff.diffstat.txt"

 lm78.c    |   36 +++++++++++++++----------------
 lm80.c    |   20 ++++++++---------
 lm83.c    |    6 ++---
 lm85.c    |   72 +++++++++++++++++++++++++++++++-------------------------------
 lm87.c    |   46 +++++++++++++++++++--------------------
 lm90.c    |   12 +++++-----
 lm92.c    |   14 ++++++------
 max1619.c |    6 ++---
 8 files changed, 106 insertions(+), 106 deletions(-)



------=_Part_1427_27889255.1116062960518
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.2.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.2.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm78.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm78.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm78.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm78.c	2005-05-11 00:32:26.000000000 -0400
@@ -224,29 +224,29 @@ static ssize_t set_in_max(struct device 
 	
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
-	show_in##offset##_min (struct device *dev, char *buf)   \
+	show_in##offset##_min (struct device *dev, char *buf, void *private)   \
 {								\
 	return show_in_min(dev, buf, offset);			\
 }								\
 static ssize_t							\
-	show_in##offset##_max (struct device *dev, char *buf)   \
+	show_in##offset##_max (struct device *dev, char *buf, void *private)   \
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
@@ -264,19 +264,19 @@ show_in_offset(5);
 show_in_offset(6);
 
 /* Temperature */
-static ssize_t show_temp(struct device *dev, char *buf)
+static ssize_t show_temp(struct device *dev, char *buf, void *private)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
-static ssize_t show_temp_over(struct device *dev, char *buf)
+static ssize_t show_temp_over(struct device *dev, char *buf, void *private)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
-static ssize_t set_temp_over(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp_over(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
@@ -289,13 +289,13 @@ static ssize_t set_temp_over(struct devi
 	return count;
 }
 
-static ssize_t show_temp_hyst(struct device *dev, char *buf)
+static ssize_t show_temp_hyst(struct device *dev, char *buf, void *private)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst));
 }
 
-static ssize_t set_temp_hyst(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp_hyst(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm78_data *data = i2c_get_clientdata(client);
@@ -398,20 +398,20 @@ static ssize_t set_fan_div(struct device
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_fan(dev, buf, offset - 1);				\
 }									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)  \
+static ssize_t show_fan_##offset##_min (struct device *dev, char *buf, void *private)  \
 {									\
 	return show_fan_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)  \
+static ssize_t show_fan_##offset##_div (struct device *dev, char *buf, void *private)  \
 {									\
 	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev,		\
-		const char *buf, size_t count)				\
+		const char *buf, size_t count, void *private)				\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
@@ -420,13 +420,13 @@ static DEVICE_ATTR(fan##offset##_min, S_
 		show_fan_##offset##_min, set_fan_##offset##_min);
 
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
@@ -443,7 +443,7 @@ static DEVICE_ATTR(fan2_div, S_IRUGO | S
 static DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_3_div, NULL);
 
 /* VID */
-static ssize_t show_vid(struct device *dev, char *buf)
+static ssize_t show_vid(struct device *dev, char *buf, void *private)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
@@ -451,7 +451,7 @@ static ssize_t show_vid(struct device *d
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm80.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm80.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm80.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm80.c	2005-05-11 00:32:26.000000000 -0400
@@ -156,7 +156,7 @@ static struct i2c_driver lm80_driver = {
  */
 
 #define show_in(suffix, value) \
-static ssize_t show_in_##suffix(struct device *dev, char *buf) \
+static ssize_t show_in_##suffix(struct device *dev, char *buf, void *private) \
 { \
 	struct lm80_data *data = lm80_update_device(dev); \
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->value)); \
@@ -185,7 +185,7 @@ show_in(input6, in[6]);
 
 #define set_in(suffix, value, reg) \
 static ssize_t set_in_##suffix(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
@@ -213,7 +213,7 @@ set_in(max5, in_max[5], LM80_REG_IN_MAX(
 set_in(max6, in_max[6], LM80_REG_IN_MAX(6));
 
 #define show_fan(suffix, value, div) \
-static ssize_t show_fan_##suffix(struct device *dev, char *buf) \
+static ssize_t show_fan_##suffix(struct device *dev, char *buf, void *private) \
 { \
 	struct lm80_data *data = lm80_update_device(dev); \
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value, \
@@ -225,7 +225,7 @@ show_fan(input1, fan[0], fan_div[0]);
 show_fan(input2, fan[1], fan_div[1]);
 
 #define show_fan_div(suffix, value) \
-static ssize_t show_fan_div##suffix(struct device *dev, char *buf) \
+static ssize_t show_fan_div##suffix(struct device *dev, char *buf, void *private) \
 { \
 	struct lm80_data *data = lm80_update_device(dev); \
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->value)); \
@@ -235,7 +235,7 @@ show_fan_div(2, fan_div[1]);
 
 #define set_fan(suffix, value, reg, div) \
 static ssize_t set_fan_##suffix(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
@@ -293,21 +293,21 @@ static ssize_t set_fan_div(struct device
 
 #define set_fan_div(number) \
 static ssize_t set_fan_div##number(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	return set_fan_div(dev, buf, count, number - 1); \
 }
 set_fan_div(1);
 set_fan_div(2);
 
-static ssize_t show_temp_input1(struct device *dev, char *buf)
+static ssize_t show_temp_input1(struct device *dev, char *buf, void *private)
 {
 	struct lm80_data *data = lm80_update_device(dev);
 	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp));
 }
 
 #define show_temp(suffix, value) \
-static ssize_t show_temp_##suffix(struct device *dev, char *buf) \
+static ssize_t show_temp_##suffix(struct device *dev, char *buf, void *private) \
 { \
 	struct lm80_data *data = lm80_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_LIMIT_FROM_REG(data->value)); \
@@ -319,7 +319,7 @@ show_temp(os_hyst, temp_os_hyst);
 
 #define set_temp(suffix, value, reg) \
 static ssize_t set_temp_##suffix(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
@@ -336,7 +336,7 @@ set_temp(hot_hyst, temp_hot_hyst, LM80_R
 set_temp(os_max, temp_os_max, LM80_REG_TEMP_OS_MAX);
 set_temp(os_hyst, temp_os_hyst, LM80_REG_TEMP_OS_HYST);
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct lm80_data *data = lm80_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm83.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm83.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm83.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm83.c	2005-05-11 00:32:26.000000000 -0400
@@ -155,7 +155,7 @@ struct lm83_data {
  */
 
 #define show_temp(suffix, value) \
-static ssize_t show_temp_##suffix(struct device *dev, char *buf) \
+static ssize_t show_temp_##suffix(struct device *dev, char *buf, void *private) \
 { \
 	struct lm83_data *data = lm83_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
@@ -172,7 +172,7 @@ show_temp(crit, temp_crit);
 
 #define set_temp(suffix, value, reg) \
 static ssize_t set_temp_##suffix(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm83_data *data = i2c_get_clientdata(client); \
@@ -190,7 +190,7 @@ set_temp(high3, temp_high[2], LM83_REG_W
 set_temp(high4, temp_high[3], LM83_REG_W_REMOTE3_HIGH);
 set_temp(crit, temp_crit, LM83_REG_W_TCRIT);
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct lm83_data *data = lm83_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm85.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm85.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm85.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm85.c	2005-05-11 00:32:26.000000000 -0400
@@ -426,16 +426,16 @@ static ssize_t set_fan_min(struct device
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
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
-	const char *buf, size_t count) 					\
+	const char *buf, size_t count, void *private) 					\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
@@ -451,7 +451,7 @@ show_fan_offset(4);
 
 /* vid, vrm, alarms */
 
-static ssize_t show_vid_reg(struct device *dev, char *buf)
+static ssize_t show_vid_reg(struct device *dev, char *buf, void *private)
 {
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
@@ -459,13 +459,13 @@ static ssize_t show_vid_reg(struct devic
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
-static ssize_t show_vrm_reg(struct device *dev, char *buf)
+static ssize_t show_vrm_reg(struct device *dev, char *buf, void *private)
 {
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 
-static ssize_t store_vrm_reg(struct device *dev, const char *buf, size_t count)
+static ssize_t store_vrm_reg(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
@@ -478,7 +478,7 @@ static ssize_t store_vrm_reg(struct devi
 
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 
-static ssize_t show_alarms_reg(struct device *dev, char *buf)
+static ssize_t show_alarms_reg(struct device *dev, char *buf, void *private)
 {
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
@@ -516,16 +516,16 @@ static ssize_t show_pwm_enable(struct de
 }
 
 #define show_pwm_reg(offset)						\
-static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
+static ssize_t show_pwm_##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_pwm(dev, buf, offset - 1);				\
 }									\
 static ssize_t set_pwm_##offset (struct device *dev,			\
-				 const char *buf, size_t count)		\
+				 const char *buf, size_t count, void *private)		\
 {									\
 	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
-static ssize_t show_pwm_enable##offset (struct device *dev, char *buf)	\
+static ssize_t show_pwm_enable##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_pwm_enable(dev, buf, offset - 1);			\
 }									\
@@ -585,25 +585,25 @@ static ssize_t set_in_max(struct device 
 	return count;
 }
 #define show_in_reg(offset)						\
-static ssize_t show_in_##offset (struct device *dev, char *buf)		\
+static ssize_t show_in_##offset (struct device *dev, char *buf, void *private)		\
 {									\
 	return show_in(dev, buf, offset);				\
 }									\
-static ssize_t show_in_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_in_##offset##_min (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_in_min(dev, buf, offset);				\
 }									\
-static ssize_t show_in_##offset##_max (struct device *dev, char *buf)	\
+static ssize_t show_in_##offset##_max (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_in_max(dev, buf, offset);				\
 }									\
 static ssize_t set_in_##offset##_min (struct device *dev, 		\
-	const char *buf, size_t count) 					\
+	const char *buf, size_t count, void *private) 					\
 {									\
 	return set_in_min(dev, buf, count, offset);			\
 }									\
 static ssize_t set_in_##offset##_max (struct device *dev, 		\
-	const char *buf, size_t count) 					\
+	const char *buf, size_t count, void *private) 					\
 {									\
 	return set_in_max(dev, buf, count, offset);			\
 }									\
@@ -666,25 +666,25 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }
 #define show_temp_reg(offset)						\
-static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
+static ssize_t show_temp_##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_temp(dev, buf, offset - 1);				\
 }									\
-static ssize_t show_temp_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_temp_##offset##_min (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_temp_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_temp_##offset##_max (struct device *dev, char *buf)	\
+static ssize_t show_temp_##offset##_max (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_temp_max(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_min (struct device *dev, 		\
-	const char *buf, size_t count) 					\
+	const char *buf, size_t count, void *private) 					\
 {									\
 	return set_temp_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_max (struct device *dev, 		\
-	const char *buf, size_t count) 					\
+	const char *buf, size_t count, void *private) 					\
 {									\
 	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
@@ -787,42 +787,42 @@ static ssize_t set_pwm_auto_pwm_freq(str
 }
 #define pwm_auto(offset)						\
 static ssize_t show_pwm##offset##_auto_channels (struct device *dev,	\
-	char *buf)							\
+	char *buf, void *private)							\
 {									\
 	return show_pwm_auto_channels(dev, buf, offset - 1);		\
 }									\
 static ssize_t set_pwm##offset##_auto_channels (struct device *dev,	\
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_pwm_auto_channels(dev, buf, count, offset - 1);	\
 }									\
 static ssize_t show_pwm##offset##_auto_pwm_min (struct device *dev,	\
-	char *buf)							\
+	char *buf, void *private)							\
 {									\
 	return show_pwm_auto_pwm_min(dev, buf, offset - 1);		\
 }									\
 static ssize_t set_pwm##offset##_auto_pwm_min (struct device *dev,	\
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_pwm_auto_pwm_min(dev, buf, count, offset - 1);	\
 }									\
 static ssize_t show_pwm##offset##_auto_pwm_minctl (struct device *dev,	\
-	char *buf)							\
+	char *buf, void *private)							\
 {									\
 	return show_pwm_auto_pwm_minctl(dev, buf, offset - 1);		\
 }									\
 static ssize_t set_pwm##offset##_auto_pwm_minctl (struct device *dev,	\
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_pwm_auto_pwm_minctl(dev, buf, count, offset - 1);	\
 }									\
 static ssize_t show_pwm##offset##_auto_pwm_freq (struct device *dev,	\
-	char *buf)							\
+	char *buf, void *private)							\
 {									\
 	return show_pwm_auto_pwm_freq(dev, buf, offset - 1);		\
 }									\
 static ssize_t set_pwm##offset##_auto_pwm_freq(struct device *dev,	\
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_pwm_auto_pwm_freq(dev, buf, count, offset - 1);	\
 }									\
@@ -963,42 +963,42 @@ static ssize_t set_temp_auto_temp_crit(s
 }
 #define temp_auto(offset)						\
 static ssize_t show_temp##offset##_auto_temp_off (struct device *dev,	\
-	char *buf)							\
+	char *buf, void *private)							\
 {									\
 	return show_temp_auto_temp_off(dev, buf, offset - 1);		\
 }									\
 static ssize_t set_temp##offset##_auto_temp_off (struct device *dev,	\
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_temp_auto_temp_off(dev, buf, count, offset - 1);	\
 }									\
 static ssize_t show_temp##offset##_auto_temp_min (struct device *dev,	\
-	char *buf)							\
+	char *buf, void *private)							\
 {									\
 	return show_temp_auto_temp_min(dev, buf, offset - 1);		\
 }									\
 static ssize_t set_temp##offset##_auto_temp_min (struct device *dev,	\
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_temp_auto_temp_min(dev, buf, count, offset - 1);	\
 }									\
 static ssize_t show_temp##offset##_auto_temp_max (struct device *dev,	\
-	char *buf)							\
+	char *buf, void *private)							\
 {									\
 	return show_temp_auto_temp_max(dev, buf, offset - 1);		\
 }									\
 static ssize_t set_temp##offset##_auto_temp_max (struct device *dev,	\
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_temp_auto_temp_max(dev, buf, count, offset - 1);	\
 }									\
 static ssize_t show_temp##offset##_auto_temp_crit (struct device *dev,	\
-	char *buf)							\
+	char *buf, void *private)							\
 {									\
 	return show_temp_auto_temp_crit(dev, buf, offset - 1);		\
 }									\
 static ssize_t set_temp##offset##_auto_temp_crit (struct device *dev,	\
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_temp_auto_temp_crit(dev, buf, count, offset - 1);	\
 }									\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm87.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm87.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm87.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm87.c	2005-05-11 00:32:26.000000000 -0400
@@ -218,19 +218,19 @@ static inline int lm87_write_value(struc
 }
 
 #define show_in(offset) \
-static ssize_t show_in##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_input(struct device *dev, char *buf, void *private) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
 		       data->in_scale[offset])); \
 } \
-static ssize_t show_in##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_min(struct device *dev, char *buf, void *private) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
 		       data->in_scale[offset])); \
 } \
-static ssize_t show_in##offset##_max(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_max(struct device *dev, char *buf, void *private) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
@@ -275,13 +275,13 @@ static void set_in_max(struct device *de
 
 #define set_in(offset) \
 static ssize_t set_in##offset##_min(struct device *dev, \
-		const char *buf, size_t count) \
+		const char *buf, size_t count, void *private) \
 { \
 	set_in_min(dev, buf, offset); \
 	return count; \
 } \
 static ssize_t set_in##offset##_max(struct device *dev, \
-		const char *buf, size_t count) \
+		const char *buf, size_t count, void *private) \
 { \
 	set_in_max(dev, buf, offset); \
 	return count; \
@@ -300,17 +300,17 @@ set_in(6);
 set_in(7);
 
 #define show_temp(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, char *buf, void *private) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
 } \
-static ssize_t show_temp##offset##_low(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_low(struct device *dev, char *buf, void *private) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[offset-1])); \
 } \
-static ssize_t show_temp##offset##_high(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_high(struct device *dev, char *buf, void *private) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[offset-1])); \
@@ -347,13 +347,13 @@ static void set_temp_high(struct device 
 
 #define set_temp(offset) \
 static ssize_t set_temp##offset##_low(struct device *dev, \
-		const char *buf, size_t count) \
+		const char *buf, size_t count, void *private) \
 { \
 	set_temp_low(dev, buf, offset-1); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_high(struct device *dev, \
-		const char *buf, size_t count) \
+		const char *buf, size_t count, void *private) \
 { \
 	set_temp_high(dev, buf, offset-1); \
 	return count; \
@@ -366,13 +366,13 @@ set_temp(1);
 set_temp(2);
 set_temp(3);
 
-static ssize_t show_temp_crit_int(struct device *dev, char *buf)
+static ssize_t show_temp_crit_int(struct device *dev, char *buf, void *private)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit_int));
 }
 
-static ssize_t show_temp_crit_ext(struct device *dev, char *buf)
+static ssize_t show_temp_crit_ext(struct device *dev, char *buf, void *private)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit_ext));
@@ -383,19 +383,19 @@ static DEVICE_ATTR(temp2_crit, S_IRUGO, 
 static DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit_ext, NULL);
 
 #define show_fan(offset) \
-static ssize_t show_fan##offset##_input(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_input(struct device *dev, char *buf, void *private) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[offset-1], \
 		       FAN_DIV_FROM_REG(data->fan_div[offset-1]))); \
 } \
-static ssize_t show_fan##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_min(struct device *dev, char *buf, void *private) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[offset-1], \
 		       FAN_DIV_FROM_REG(data->fan_div[offset-1]))); \
 } \
-static ssize_t show_fan##offset##_div(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_div(struct device *dev, char *buf, void *private) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%d\n", FAN_DIV_FROM_REG(data->fan_div[offset-1])); \
@@ -466,13 +466,13 @@ static ssize_t set_fan_div(struct device
 
 #define set_fan(offset) \
 static ssize_t set_fan##offset##_min(struct device *dev, const char *buf, \
-		size_t count) \
+		size_t count, void *private) \
 { \
 	set_fan_min(dev, buf, offset-1); \
 	return count; \
 } \
 static ssize_t set_fan##offset##_div(struct device *dev, const char *buf, \
-		size_t count) \
+		size_t count, void *private) \
 { \
 	return set_fan_div(dev, buf, count, offset-1); \
 } \
@@ -483,26 +483,26 @@ static DEVICE_ATTR(fan##offset##_div, S_
 set_fan(1);
 set_fan(2);
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
-static ssize_t show_vid(struct device *dev, char *buf)
+static ssize_t show_vid(struct device *dev, char *buf, void *private)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, char *buf)
+static ssize_t show_vrm(struct device *dev, char *buf, void *private)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
@@ -511,12 +511,12 @@ static ssize_t set_vrm(struct device *de
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 
-static ssize_t show_aout(struct device *dev, char *buf)
+static ssize_t show_aout(struct device *dev, char *buf, void *private)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
-static ssize_t set_aout(struct device *dev, const char *buf, size_t count)
+static ssize_t set_aout(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm90.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm90.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm90.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm90.c	2005-05-11 00:32:26.000000000 -0400
@@ -218,7 +218,7 @@ struct lm90_data {
  */
 
 #define show_temp(value, converter) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, char *buf, void *private) \
 { \
 	struct lm90_data *data = lm90_update_device(dev); \
 	return sprintf(buf, "%d\n", converter(data->value)); \
@@ -234,7 +234,7 @@ show_temp(temp_crit2, TEMP1_FROM_REG);
 
 #define set_temp1(value, reg) \
 static ssize_t set_##value(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
@@ -251,7 +251,7 @@ static ssize_t set_##value(struct device
 }
 #define set_temp2(value, regh, regl) \
 static ssize_t set_##value(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
@@ -275,7 +275,7 @@ set_temp1(temp_crit1, LM90_REG_W_LOCAL_C
 set_temp1(temp_crit2, LM90_REG_W_REMOTE_CRIT);
 
 #define show_temp_hyst(value, basereg) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, char *buf, void *private) \
 { \
 	struct lm90_data *data = lm90_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->basereg) \
@@ -285,7 +285,7 @@ show_temp_hyst(temp_hyst1, temp_crit1);
 show_temp_hyst(temp_hyst2, temp_crit2);
 
 static ssize_t set_temp_hyst1(struct device *dev, const char *buf,
-	size_t count)
+	size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm90_data *data = i2c_get_clientdata(client);
@@ -300,7 +300,7 @@ static ssize_t set_temp_hyst1(struct dev
 	return count;
 }
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct lm90_data *data = lm90_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm92.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm92.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm92.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm92.c	2005-05-11 00:32:26.000000000 -0400
@@ -140,7 +140,7 @@ static struct lm92_data *lm92_update_dev
 }
 
 #define show_temp(value) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, char *buf, void *private) \
 { \
 	struct lm92_data *data = lm92_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
@@ -152,7 +152,7 @@ show_temp(temp1_max);
 
 #define set_temp(value, reg) \
 static ssize_t set_##value(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm92_data *data = i2c_get_clientdata(client); \
@@ -168,19 +168,19 @@ set_temp(temp1_crit, LM92_REG_TEMP_CRIT)
 set_temp(temp1_min, LM92_REG_TEMP_LOW);
 set_temp(temp1_max, LM92_REG_TEMP_HIGH);
 
-static ssize_t show_temp1_crit_hyst(struct device *dev, char *buf)
+static ssize_t show_temp1_crit_hyst(struct device *dev, char *buf, void *private)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_crit)
 		       - TEMP_FROM_REG(data->temp1_hyst));
 }
-static ssize_t show_temp1_max_hyst(struct device *dev, char *buf)
+static ssize_t show_temp1_max_hyst(struct device *dev, char *buf, void *private)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_max)
 		       - TEMP_FROM_REG(data->temp1_hyst));
 }
-static ssize_t show_temp1_min_hyst(struct device *dev, char *buf)
+static ssize_t show_temp1_min_hyst(struct device *dev, char *buf, void *private)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_min)
@@ -188,7 +188,7 @@ static ssize_t show_temp1_min_hyst(struc
 }
 
 static ssize_t set_temp1_crit_hyst(struct device *dev, const char *buf,
-	size_t count)
+	size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm92_data *data = i2c_get_clientdata(client);
@@ -202,7 +202,7 @@ static ssize_t set_temp1_crit_hyst(struc
 	return count;
 }
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->temp1_input));
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/max1619.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/max1619.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/max1619.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/max1619.c	2005-05-11 00:32:24.000000000 -0400
@@ -122,7 +122,7 @@ struct max1619_data {
  */
 
 #define show_temp(value) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, char *buf, void *private) \
 { \
 	struct max1619_data *data = max1619_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
@@ -136,7 +136,7 @@ show_temp(temp_hyst2);
 
 #define set_temp2(value, reg) \
 static ssize_t set_##value(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct max1619_data *data = i2c_get_clientdata(client); \
@@ -154,7 +154,7 @@ set_temp2(temp_high2, MAX1619_REG_W_REMO
 set_temp2(temp_crit2, MAX1619_REG_W_REMOTE_CRIT);
 set_temp2(temp_hyst2, MAX1619_REG_W_TCRIT_HYST);
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct max1619_data *data = max1619_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);



------=_Part_1427_27889255.1116062960518--
