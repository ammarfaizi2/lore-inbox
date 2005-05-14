Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVENJgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVENJgF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 05:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVENJgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 05:36:05 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:8479 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262718AbVENJ1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:27:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=Af4+SH/XbBbYqRbJtaJFYB101xWQemofIaVEU678f5S/Q32CZZKPQan7wzNLBaylCLeHlJ+WoNcsF4LbSp7g59nS+TWHngOYhJF/rT4hgn5i/zjAu/vrsMEVefQUPSBIzmYjb6z1Go/K2gkhHi0acFGr9WZaTfZJXgsR+kvDi5c=
Message-ID: <2538186705051402272f3e2ce1@mail.gmail.com>
Date: Sat, 14 May 2005 05:27:44 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 5/12] drivers/i2c/chips/adm1031.c - lm77.c: (dynamic sysfs callbacks) update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1419_25167547.1116062864306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1419_25167547.1116062864306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_1419_25167547.1116062864306
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.1.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.1.diff.diffstat.txt"

 adm1031.c |   44 ++++++++++++++++++++++----------------------
 asb100.c  |   46 +++++++++++++++++++++++-----------------------
 ds1621.c  |    6 +++---
 fscher.c  |    8 ++++----
 fscpos.c  |   16 ++++++++--------
 gl518sm.c |   12 ++++++------
 gl520sm.c |    8 ++++----
 it87.c    |   50 +++++++++++++++++++++++++-------------------------
 lm63.c    |   24 ++++++++++++------------
 lm75.c    |    4 ++--
 lm77.c    |   14 +++++++-------
 11 files changed, 116 insertions(+), 116 deletions(-)


------=_Part_1419_25167547.1116062864306
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.1.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.1.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/adm1031.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/adm1031.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/adm1031.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/adm1031.c	2005-05-11 00:32:26.000000000 -0400
@@ -292,12 +292,12 @@ set_fan_auto_channel(struct device *dev,
 }
 
 #define fan_auto_channel_offset(offset)						\
-static ssize_t show_fan_auto_channel_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_auto_channel_##offset (struct device *dev, char *buf, void *private)	\
 {										\
 	return show_fan_auto_channel(dev, buf, offset - 1);			\
 }										\
 static ssize_t set_fan_auto_channel_##offset (struct device *dev,		\
-	const char *buf, size_t count)						\
+	const char *buf, size_t count, void *private)						\
 {										\
 	return set_fan_auto_channel(dev, buf, count, offset - 1);		\
 }										\
@@ -357,25 +357,25 @@ set_auto_temp_max(struct device *dev, co
 }
 
 #define auto_temp_reg(offset)							\
-static ssize_t show_auto_temp_##offset##_off (struct device *dev, char *buf)	\
+static ssize_t show_auto_temp_##offset##_off (struct device *dev, char *buf, void *private)	\
 {										\
 	return show_auto_temp_off(dev, buf, offset - 1);			\
 }										\
-static ssize_t show_auto_temp_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_auto_temp_##offset##_min (struct device *dev, char *buf, void *private)	\
 {										\
 	return show_auto_temp_min(dev, buf, offset - 1);			\
 }										\
-static ssize_t show_auto_temp_##offset##_max (struct device *dev, char *buf)	\
+static ssize_t show_auto_temp_##offset##_max (struct device *dev, char *buf, void *private)	\
 {										\
 	return show_auto_temp_max(dev, buf, offset - 1);			\
 }										\
 static ssize_t set_auto_temp_##offset##_min (struct device *dev,		\
-					     const char *buf, size_t count)	\
+					     const char *buf, size_t count, void *private)	\
 {										\
 	return set_auto_temp_min(dev, buf, count, offset - 1);		\
 }										\
 static ssize_t set_auto_temp_##offset##_max (struct device *dev,		\
-					     const char *buf, size_t count)	\
+					     const char *buf, size_t count, void *private)	\
 {										\
 	return set_auto_temp_max(dev, buf, count, offset - 1);		\
 }										\
@@ -421,12 +421,12 @@ set_pwm(struct device *dev, const char *
 }
 
 #define pwm_reg(offset)							\
-static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
+static ssize_t show_pwm_##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_pwm(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_pwm_##offset (struct device *dev,			\
-				 const char *buf, size_t count)		\
+				 const char *buf, size_t count, void *private)		\
 {									\
 	return set_pwm(dev, buf, count, offset - 1);		\
 }									\
@@ -557,25 +557,25 @@ set_fan_div(struct device *dev, const ch
 }
 
 #define fan_offset(offset)						\
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
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_fan_##offset##_div (struct device *dev,		\
-	const char *buf, size_t count)					\
+	const char *buf, size_t count, void *private)					\
 {									\
 	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
@@ -667,34 +667,34 @@ set_temp_crit(struct device *dev, const 
 }
 
 #define temp_reg(offset)							\
-static ssize_t show_temp_##offset (struct device *dev, char *buf)		\
+static ssize_t show_temp_##offset (struct device *dev, char *buf, void *private)		\
 {										\
 	return show_temp(dev, buf, offset - 1);				\
 }										\
-static ssize_t show_temp_##offset##_min (struct device *dev, char *buf)		\
+static ssize_t show_temp_##offset##_min (struct device *dev, char *buf, void *private)		\
 {										\
 	return show_temp_min(dev, buf, offset - 1);				\
 }										\
-static ssize_t show_temp_##offset##_max (struct device *dev, char *buf)		\
+static ssize_t show_temp_##offset##_max (struct device *dev, char *buf, void *private)		\
 {										\
 	return show_temp_max(dev, buf, offset - 1);				\
 }										\
-static ssize_t show_temp_##offset##_crit (struct device *dev, char *buf)	\
+static ssize_t show_temp_##offset##_crit (struct device *dev, char *buf, void *private)	\
 {										\
 	return show_temp_crit(dev, buf, offset - 1);			\
 }										\
 static ssize_t set_temp_##offset##_min (struct device *dev,			\
-					const char *buf, size_t count)		\
+					const char *buf, size_t count, void *private)		\
 {										\
 	return set_temp_min(dev, buf, count, offset - 1);			\
 }										\
 static ssize_t set_temp_##offset##_max (struct device *dev,			\
-					const char *buf, size_t count)		\
+					const char *buf, size_t count, void *private)		\
 {										\
 	return set_temp_max(dev, buf, count, offset - 1);			\
 }										\
 static ssize_t set_temp_##offset##_crit (struct device *dev,			\
-					 const char *buf, size_t count)		\
+					 const char *buf, size_t count, void *private)		\
 {										\
 	return set_temp_crit(dev, buf, count, offset - 1);			\
 }										\
@@ -712,7 +712,7 @@ temp_reg(2);
 temp_reg(3);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarm);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/asb100.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/asb100.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/asb100.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/asb100.c	2005-05-11 00:32:26.000000000 -0400
@@ -260,29 +260,29 @@ set_in_reg(MAX, max)
 
 #define sysfs_in(offset) \
 static ssize_t \
-	show_in##offset (struct device *dev, char *buf) \
+	show_in##offset (struct device *dev, char *buf, void *private) \
 { \
 	return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
 		show_in##offset, NULL); \
 static ssize_t \
-	show_in##offset##_min (struct device *dev, char *buf) \
+	show_in##offset##_min (struct device *dev, char *buf, void *private) \
 { \
 	return show_in_min(dev, buf, offset); \
 } \
 static ssize_t \
-	show_in##offset##_max (struct device *dev, char *buf) \
+	show_in##offset##_max (struct device *dev, char *buf, void *private) \
 { \
 	return show_in_max(dev, buf, offset); \
 } \
 static ssize_t set_in##offset##_min (struct device *dev, \
-		const char *buf, size_t count) \
+		const char *buf, size_t count, void *private) \
 { \
 	return set_in_min(dev, buf, count, offset); \
 } \
 static ssize_t set_in##offset##_max (struct device *dev, \
-		const char *buf, size_t count) \
+		const char *buf, size_t count, void *private) \
 { \
 	return set_in_max(dev, buf, count, offset); \
 } \
@@ -389,25 +389,25 @@ static ssize_t set_fan_div(struct device
 }
 
 #define sysfs_fan(offset) \
-static ssize_t show_fan##offset(struct device *dev, char *buf) \
+static ssize_t show_fan##offset(struct device *dev, char *buf, void *private) \
 { \
 	return show_fan(dev, buf, offset - 1); \
 } \
-static ssize_t show_fan##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_min(struct device *dev, char *buf, void *private) \
 { \
 	return show_fan_min(dev, buf, offset - 1); \
 } \
-static ssize_t show_fan##offset##_div(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_div(struct device *dev, char *buf, void *private) \
 { \
 	return show_fan_div(dev, buf, offset - 1); \
 } \
 static ssize_t set_fan##offset##_min(struct device *dev, const char *buf, \
-					size_t count) \
+					size_t count, void *private) \
 { \
 	return set_fan_min(dev, buf, count, offset - 1); \
 } \
 static ssize_t set_fan##offset##_div(struct device *dev, const char *buf, \
-					size_t count) \
+					size_t count, void *private) \
 { \
 	return set_fan_div(dev, buf, count, offset - 1); \
 } \
@@ -482,28 +482,28 @@ set_temp_reg(MAX, temp_max);
 set_temp_reg(HYST, temp_hyst);
 
 #define sysfs_temp(num) \
-static ssize_t show_temp##num(struct device *dev, char *buf) \
+static ssize_t show_temp##num(struct device *dev, char *buf, void *private) \
 { \
 	return show_temp(dev, buf, num-1); \
 } \
 static DEVICE_ATTR(temp##num##_input, S_IRUGO, show_temp##num, NULL); \
-static ssize_t show_temp_max##num(struct device *dev, char *buf) \
+static ssize_t show_temp_max##num(struct device *dev, char *buf, void *private) \
 { \
 	return show_temp_max(dev, buf, num-1); \
 } \
 static ssize_t set_temp_max##num(struct device *dev, const char *buf, \
-					size_t count) \
+					size_t count, void *private) \
 { \
 	return set_temp_max(dev, buf, count, num-1); \
 } \
 static DEVICE_ATTR(temp##num##_max, S_IRUGO | S_IWUSR, \
 		show_temp_max##num, set_temp_max##num); \
-static ssize_t show_temp_hyst##num(struct device *dev, char *buf) \
+static ssize_t show_temp_hyst##num(struct device *dev, char *buf, void *private) \
 { \
 	return show_temp_hyst(dev, buf, num-1); \
 } \
 static ssize_t set_temp_hyst##num(struct device *dev, const char *buf, \
-					size_t count) \
+					size_t count, void *private) \
 { \
 	return set_temp_hyst(dev, buf, count, num-1); \
 } \
@@ -522,7 +522,7 @@ sysfs_temp(4);
 	device_create_file(&client->dev, &dev_attr_temp##num##_max_hyst); \
 } while (0)
 
-static ssize_t show_vid(struct device *dev, char *buf)
+static ssize_t show_vid(struct device *dev, char *buf, void *private)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -533,13 +533,13 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 /* VRM */
-static ssize_t show_vrm(struct device *dev, char *buf)
+static ssize_t show_vrm(struct device *dev, char *buf, void *private)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
 
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
@@ -553,7 +553,7 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUS
 #define device_create_file_vrm(client) \
 device_create_file(&client->dev, &dev_attr_vrm);
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
@@ -564,13 +564,13 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
 device_create_file(&client->dev, &dev_attr_alarms)
 
 /* 1 PWM */
-static ssize_t show_pwm1(struct device *dev, char *buf)
+static ssize_t show_pwm1(struct device *dev, char *buf, void *private)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", ASB100_PWM_FROM_REG(data->pwm & 0x0f));
 }
 
-static ssize_t set_pwm1(struct device *dev, const char *buf, size_t count)
+static ssize_t set_pwm1(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
@@ -584,14 +584,14 @@ static ssize_t set_pwm1(struct device *d
 	return count;
 }
 
-static ssize_t show_pwm_enable1(struct device *dev, char *buf)
+static ssize_t show_pwm_enable1(struct device *dev, char *buf, void *private)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", (data->pwm & 0x80) ? 1 : 0);
 }
 
 static ssize_t set_pwm_enable1(struct device *dev, const char *buf,
-				size_t count)
+				size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/ds1621.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/ds1621.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/ds1621.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/ds1621.c	2005-05-11 00:32:27.000000000 -0400
@@ -137,7 +137,7 @@ static void ds1621_init_client(struct i2
 }
 
 #define show(value)							\
-static ssize_t show_##value(struct device *dev, char *buf)		\
+static ssize_t show_##value(struct device *dev, char *buf, void *private)		\
 {									\
 	struct ds1621_data *data = ds1621_update_client(dev);		\
 	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
@@ -149,7 +149,7 @@ show(temp_max);
 
 #define set_temp(suffix, value, reg)					\
 static ssize_t set_temp_##suffix(struct device *dev, const char *buf,	\
-				 size_t count)				\
+				 size_t count, void *private)				\
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct ds1621_data *data = ds1621_update_client(dev);		\
@@ -165,7 +165,7 @@ static ssize_t set_temp_##suffix(struct 
 set_temp(min, temp_min, DS1621_REG_TEMP_MIN);
 set_temp(max, temp_max, DS1621_REG_TEMP_MAX);
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct ds1621_data *data = ds1621_update_client(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->conf));
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/fscher.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/fscher.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/fscher.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/fscher.c	2005-05-11 00:32:26.000000000 -0400
@@ -157,8 +157,8 @@ struct fscher_data {
 
 #define sysfs_r(kind, sub, offset, reg) \
 static ssize_t show_##kind##sub (struct fscher_data *, char *, int); \
-static ssize_t show_##kind##offset##sub (struct device *, char *); \
-static ssize_t show_##kind##offset##sub (struct device *dev, char *buf) \
+static ssize_t show_##kind##offset##sub (struct device *, char *, void *private); \
+static ssize_t show_##kind##offset##sub (struct device *dev, char *buf, void *private) \
 { \
 	struct fscher_data *data = fscher_update_device(dev); \
 	return show_##kind##sub(data, buf, (offset)); \
@@ -166,8 +166,8 @@ static ssize_t show_##kind##offset##sub 
 
 #define sysfs_w(kind, sub, offset, reg) \
 static ssize_t set_##kind##sub (struct i2c_client *, struct fscher_data *, const char *, size_t, int, int); \
-static ssize_t set_##kind##offset##sub (struct device *, const char *, size_t); \
-static ssize_t set_##kind##offset##sub (struct device *dev, const char *buf, size_t count) \
+static ssize_t set_##kind##offset##sub (struct device *, const char *, size_t, void *private); \
+static ssize_t set_##kind##offset##sub (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct fscher_data *data = i2c_get_clientdata(client); \
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/fscpos.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/fscpos.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/fscpos.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/fscpos.c	2005-05-11 00:32:26.000000000 -0400
@@ -245,19 +245,19 @@ static void reset_fan_alarm(struct i2c_c
 /* Volts */
 #define VOLT_FROM_REG(val, mult)	((val) * (mult) / 255)
 
-static ssize_t show_volt_12(struct device *dev, char *buf)
+static ssize_t show_volt_12(struct device *dev, char *buf, void *private)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
 	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 14200));
 }
 
-static ssize_t show_volt_5(struct device *dev, char *buf)
+static ssize_t show_volt_5(struct device *dev, char *buf, void *private)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
 	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 6600));
 }
 
-static ssize_t show_volt_batt(struct device *dev, char *buf)
+static ssize_t show_volt_batt(struct device *dev, char *buf, void *private)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
 	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 3300));
@@ -327,7 +327,7 @@ static ssize_t set_wdog_preset(struct i2
 }
 
 /* Event */
-static ssize_t show_event(struct device *dev, char *buf)
+static ssize_t show_event(struct device *dev, char *buf, void *private)
 {
 	/* bits 5..7 reserved => mask with 0x1f */
 	struct fscpos_data *data = fscpos_update_device(dev);
@@ -338,7 +338,7 @@ static ssize_t show_event(struct device 
  * Sysfs stuff
  */
 #define create_getter(kind, sub) \
-	static ssize_t sysfs_show_##kind##sub(struct device *dev, char *buf) \
+	static ssize_t sysfs_show_##kind##sub(struct device *dev, char *buf, void *private) \
 	{ \
 		struct fscpos_data *data = fscpos_update_device(dev); \
 		return show_##kind##sub(data, buf); \
@@ -346,7 +346,7 @@ static ssize_t show_event(struct device 
 
 #define create_getter_n(kind, offset, sub) \
 	static ssize_t sysfs_show_##kind##offset##sub(struct device *dev, char\
-								 	*buf) \
+								 	*buf, void *private) \
 	{ \
 		struct fscpos_data *data = fscpos_update_device(dev); \
 		return show_##kind##sub(data, buf, offset); \
@@ -354,7 +354,7 @@ static ssize_t show_event(struct device 
 
 #define create_setter(kind, sub, reg) \
 	static ssize_t sysfs_set_##kind##sub (struct device *dev, const char \
-							*buf, size_t count) \
+							*buf, size_t count, void *private) \
 	{ \
 		struct i2c_client *client = to_i2c_client(dev); \
 		struct fscpos_data *data = i2c_get_clientdata(client); \
@@ -363,7 +363,7 @@ static ssize_t show_event(struct device 
 
 #define create_setter_n(kind, offset, sub, reg) \
 	static ssize_t sysfs_set_##kind##offset##sub (struct device *dev, \
-					const char *buf, size_t count) \
+					const char *buf, size_t count, void *private) \
 	{ \
 		struct i2c_client *client = to_i2c_client(dev); \
 		struct fscpos_data *data = i2c_get_clientdata(client); \
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/gl518sm.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/gl518sm.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/gl518sm.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/gl518sm.c	2005-05-11 00:32:26.000000000 -0400
@@ -164,14 +164,14 @@ static struct i2c_driver gl518_driver = 
  */
 
 #define show(type, suffix, value)					\
-static ssize_t show_##suffix(struct device *dev, char *buf)		\
+static ssize_t show_##suffix(struct device *dev, char *buf, void *private)		\
 {									\
 	struct gl518_data *data = gl518_update_device(dev);		\
 	return sprintf(buf, "%d\n", type##_FROM_REG(data->value));	\
 }
 
 #define show_fan(suffix, value, index)					\
-static ssize_t show_##suffix(struct device *dev, char *buf)		\
+static ssize_t show_##suffix(struct device *dev, char *buf, void *private)		\
 {									\
 	struct gl518_data *data = gl518_update_device(dev);		\
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value[index],	\
@@ -206,7 +206,7 @@ show(BEEP_MASK, beep_mask, beep_mask);
 
 #define set(type, suffix, value, reg)					\
 static ssize_t set_##suffix(struct device *dev, const char *buf,	\
-	size_t count)							\
+	size_t count, void *private)							\
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
@@ -221,7 +221,7 @@ static ssize_t set_##suffix(struct devic
 
 #define set_bits(type, suffix, value, reg, mask, shift)			\
 static ssize_t set_##suffix(struct device *dev, const char *buf,	\
-	size_t count)							\
+	size_t count, void *private)							\
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
@@ -258,7 +258,7 @@ set_high(IN, in_max3, voltage_max[3], GL
 set_bits(BOOL, beep_enable, beep_enable, GL518_REG_CONF, 0x04, 2);
 set(BEEP_MASK, beep_mask, beep_mask, GL518_REG_ALARM);
 
-static ssize_t set_fan_min1(struct device *dev, const char *buf, size_t count)
+static ssize_t set_fan_min1(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
@@ -284,7 +284,7 @@ static ssize_t set_fan_min1(struct devic
 	return count;
 }
 
-static ssize_t set_fan_min2(struct device *dev, const char *buf, size_t count)
+static ssize_t set_fan_min2(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/gl520sm.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/gl520sm.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/gl520sm.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/gl520sm.c	2005-05-11 00:32:26.000000000 -0400
@@ -148,8 +148,8 @@ struct gl520_data {
 
 #define sysfs_r(type, n, item, reg) \
 static ssize_t get_##type##item (struct gl520_data *, char *, int); \
-static ssize_t get_##type##n##item (struct device *, char *); \
-static ssize_t get_##type##n##item (struct device *dev, char *buf) \
+static ssize_t get_##type##n##item (struct device *, char *, void *private); \
+static ssize_t get_##type##n##item (struct device *dev, char *buf, void *private) \
 { \
 	struct gl520_data *data = gl520_update_device(dev); \
 	return get_##type##item(data, buf, (n)); \
@@ -157,8 +157,8 @@ static ssize_t get_##type##n##item (stru
 
 #define sysfs_w(type, n, item, reg) \
 static ssize_t set_##type##item (struct i2c_client *, struct gl520_data *, const char *, size_t, int, int); \
-static ssize_t set_##type##n##item (struct device *, const char *, size_t); \
-static ssize_t set_##type##n##item (struct device *dev, const char *buf, size_t count) \
+static ssize_t set_##type##n##item (struct device *, const char *, size_t, void *private); \
+static ssize_t set_##type##n##item (struct device *dev, const char *buf, size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct gl520_data *data = i2c_get_clientdata(client); \
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/it87.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/it87.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/it87.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/it87.c	2005-05-11 00:32:25.000000000 -0400
@@ -290,7 +290,7 @@ static ssize_t set_in_max(struct device 
 
 #define show_in_offset(offset)					\
 static ssize_t							\
-	show_in##offset (struct device *dev, char *buf)		\
+	show_in##offset (struct device *dev, char *buf, void *private)		\
 {								\
 	return show_in(dev, buf, offset);			\
 }								\
@@ -298,22 +298,22 @@ static DEVICE_ATTR(in##offset##_input, S
 
 #define limit_in_offset(offset)					\
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
@@ -383,27 +383,27 @@ static ssize_t set_temp_min(struct devic
 	return count;
 }
 #define show_temp_offset(offset)					\
-static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
+static ssize_t show_temp_##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t								\
-show_temp_##offset##_max (struct device *dev, char *buf)		\
+show_temp_##offset##_max (struct device *dev, char *buf, void *private)		\
 {									\
 	return show_temp_max(dev, buf, offset - 1);			\
 }									\
 static ssize_t								\
-show_temp_##offset##_min (struct device *dev, char *buf)		\
+show_temp_##offset##_min (struct device *dev, char *buf, void *private)		\
 {									\
 	return show_temp_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_max (struct device *dev, 		\
-		const char *buf, size_t count) 				\
+		const char *buf, size_t count, void *private) 				\
 {									\
 	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_min (struct device *dev, 		\
-		const char *buf, size_t count) 				\
+		const char *buf, size_t count, void *private) 				\
 {									\
 	return set_temp_min(dev, buf, count, offset - 1);		\
 }									\
@@ -453,12 +453,12 @@ static ssize_t set_sensor(struct device 
 	return count;
 }
 #define show_sensor_offset(offset)					\
-static ssize_t show_sensor_##offset (struct device *dev, char *buf)	\
+static ssize_t show_sensor_##offset (struct device *dev, char *buf, void *private)	\
 {									\
 	return show_sensor(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_sensor_##offset (struct device *dev, 		\
-		const char *buf, size_t count) 				\
+		const char *buf, size_t count, void *private) 				\
 {									\
 	return set_sensor(dev, buf, count, offset - 1);			\
 }									\
@@ -600,25 +600,25 @@ static ssize_t set_pwm(struct device *de
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
@@ -634,21 +634,21 @@ show_fan_offset(3);
 
 #define show_pwm_offset(offset)						\
 static ssize_t show_pwm##offset##_enable (struct device *dev,		\
-	char *buf)							\
+	char *buf, void *private)							\
 {									\
 	return show_pwm_enable(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_pwm##offset (struct device *dev, char *buf)		\
+static ssize_t show_pwm##offset (struct device *dev, char *buf, void *private)		\
 {									\
 	return show_pwm(dev, buf, offset - 1);				\
 }									\
 static ssize_t set_pwm##offset##_enable (struct device *dev,		\
-		const char *buf, size_t count)				\
+		const char *buf, size_t count, void *private)				\
 {									\
 	return set_pwm_enable(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_pwm##offset (struct device *dev,			\
-		const char *buf, size_t count)				\
+		const char *buf, size_t count, void *private)				\
 {									\
 	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
@@ -663,7 +663,7 @@ show_pwm_offset(2);
 show_pwm_offset(3);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
@@ -671,13 +671,13 @@ static ssize_t show_alarms(struct device
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 static ssize_t
-show_vrm_reg(struct device *dev, char *buf)
+show_vrm_reg(struct device *dev, char *buf, void *private)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 static ssize_t
-store_vrm_reg(struct device *dev, const char *buf, size_t count)
+store_vrm_reg(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
@@ -693,7 +693,7 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUS
 device_create_file(&client->dev, &dev_attr_vrm)
 
 static ssize_t
-show_vid_reg(struct device *dev, char *buf)
+show_vid_reg(struct device *dev, char *buf, void *private)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm63.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm63.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm63.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm63.c	2005-05-11 00:32:25.000000000 -0400
@@ -177,7 +177,7 @@ struct lm63_data {
  */
 
 #define show_fan(value) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, char *buf, void *private) \
 { \
 	struct lm63_data *data = lm63_update_device(dev); \
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value)); \
@@ -186,7 +186,7 @@ show_fan(fan1_input);
 show_fan(fan1_low);
 
 static ssize_t set_fan1_low(struct device *dev, const char *buf,
-	size_t count)
+	size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
@@ -202,7 +202,7 @@ static ssize_t set_fan1_low(struct devic
 	return count;
 }
 
-static ssize_t show_pwm1(struct device *dev, char *buf)
+static ssize_t show_pwm1(struct device *dev, char *buf, void *private)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1_value >= 2 * data->pwm1_freq ?
@@ -210,7 +210,7 @@ static ssize_t show_pwm1(struct device *
 		       (2 * data->pwm1_freq));
 }
 
-static ssize_t set_pwm1(struct device *dev, const char *buf, size_t count)
+static ssize_t set_pwm1(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
@@ -229,20 +229,20 @@ static ssize_t set_pwm1(struct device *d
 	return count;
 }
 
-static ssize_t show_pwm1_enable(struct device *dev, char *buf)
+static ssize_t show_pwm1_enable(struct device *dev, char *buf, void *private)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", data->config_fan & 0x20 ? 1 : 2);
 }
 
 #define show_temp8(value) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, char *buf, void *private) \
 { \
 	struct lm63_data *data = lm63_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->value)); \
 }
 #define show_temp11(value) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, char *buf, void *private) \
 { \
 	struct lm63_data *data = lm63_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->value)); \
@@ -256,7 +256,7 @@ show_temp8(temp2_crit);
 
 #define set_temp8(value, reg) \
 static ssize_t set_##value(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm63_data *data = i2c_get_clientdata(client); \
@@ -270,7 +270,7 @@ static ssize_t set_##value(struct device
 }
 #define set_temp11(value, reg_msb, reg_lsb) \
 static ssize_t set_##value(struct device *dev, const char *buf, \
-	size_t count) \
+	size_t count, void *private) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm63_data *data = i2c_get_clientdata(client); \
@@ -289,7 +289,7 @@ set_temp11(temp2_low, LM63_REG_REMOTE_LO
 
 /* Hysteresis register holds a relative value, while we want to present
    an absolute to user-space */
-static ssize_t show_temp2_crit_hyst(struct device *dev, char *buf)
+static ssize_t show_temp2_crit_hyst(struct device *dev, char *buf, void *private)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->temp2_crit)
@@ -299,7 +299,7 @@ static ssize_t show_temp2_crit_hyst(stru
 /* And now the other way around, user-space provides an absolute
    hysteresis value and we have to store a relative one */
 static ssize_t set_temp2_crit_hyst(struct device *dev, const char *buf,
-	size_t count)
+	size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
@@ -314,7 +314,7 @@ static ssize_t set_temp2_crit_hyst(struc
 	return count;
 }
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, char *buf, void *private)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm75.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm75.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm75.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm75.c	2005-05-11 00:32:25.000000000 -0400
@@ -75,7 +75,7 @@ static struct i2c_driver lm75_driver = {
 };
 
 #define show(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)		\
+static ssize_t show_##value(struct device *dev, char *buf, void *private)		\
 {									\
 	struct lm75_data *data = lm75_update_device(dev);		\
 	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
@@ -85,7 +85,7 @@ show(temp_hyst);
 show(temp_input);
 
 #define set(value, reg)	\
-static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+static ssize_t set_##value(struct device *dev, const char *buf, size_t count, void *private)	\
 {								\
 	struct i2c_client *client = to_i2c_client(dev);		\
 	struct lm75_data *data = i2c_get_clientdata(client);	\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm77.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm77.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/lm77.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/i2c/chips/lm77.c	2005-05-11 00:32:26.000000000 -0400
@@ -103,7 +103,7 @@ static inline int LM77_TEMP_FROM_REG(u16
 
 /* read routines for temperature limits */
 #define show(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)	\
+static ssize_t show_##value(struct device *dev, char *buf, void *private)	\
 {								\
 	struct lm77_data *data = lm77_update_device(dev);	\
 	return sprintf(buf, "%d\n", data->value);		\
@@ -116,17 +116,17 @@ show(temp_max);
 show(alarms);
 
 /* read routines for hysteresis values */
-static ssize_t show_temp_crit_hyst(struct device *dev, char *buf)
+static ssize_t show_temp_crit_hyst(struct device *dev, char *buf, void *private)
 {
 	struct lm77_data *data = lm77_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp_crit - data->temp_hyst);
 }
-static ssize_t show_temp_min_hyst(struct device *dev, char *buf)
+static ssize_t show_temp_min_hyst(struct device *dev, char *buf, void *private)
 {
 	struct lm77_data *data = lm77_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp_min + data->temp_hyst);
 }
-static ssize_t show_temp_max_hyst(struct device *dev, char *buf)
+static ssize_t show_temp_max_hyst(struct device *dev, char *buf, void *private)
 {
 	struct lm77_data *data = lm77_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp_max - data->temp_hyst);
@@ -134,7 +134,7 @@ static ssize_t show_temp_max_hyst(struct
 
 /* write routines */
 #define set(value, reg)	\
-static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+static ssize_t set_##value(struct device *dev, const char *buf, size_t count, void *private)	\
 {										\
 	struct i2c_client *client = to_i2c_client(dev);				\
 	struct lm77_data *data = i2c_get_clientdata(client);			\
@@ -152,7 +152,7 @@ set(temp_max, LM77_REG_TEMP_MAX);
 
 /* hysteresis is stored as a relative value on the chip, so it has to be
    converted first */
-static ssize_t set_temp_crit_hyst(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp_crit_hyst(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm77_data *data = i2c_get_clientdata(client);
@@ -167,7 +167,7 @@ static ssize_t set_temp_crit_hyst(struct
 }
 
 /* preserve hysteresis when setting T_crit */
-static ssize_t set_temp_crit(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp_crit(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm77_data *data = i2c_get_clientdata(client);


------=_Part_1419_25167547.1116062864306--
