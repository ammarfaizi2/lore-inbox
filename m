Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270312AbUJTCkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270312AbUJTCkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270229AbUJTAiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:38:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:16820 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267979AbUJTATe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:34 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <1098231505400@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:26 -0700
Message-Id: <10982315061566@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1939.9.7, 2004/09/29 13:41:52-07:00, mhoffman@lightlink.com

[PATCH] i2c: kill some sensors driver macro abuse

This patch kills a specific kind of ugly and ultimately useless macro
abuse found in many sensors chip drivers.  Compile tested only.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1031.c  |   42 +++++++++++++++++++++---------------------
 drivers/i2c/chips/asb100.c   |   10 +++++-----
 drivers/i2c/chips/it87.c     |   34 +++++++++++++++++-----------------
 drivers/i2c/chips/lm78.c     |   18 +++++++++---------
 drivers/i2c/chips/lm85.c     |   32 ++++++++++++++++----------------
 drivers/i2c/chips/smsc47m1.c |   18 +++++++++---------
 drivers/i2c/chips/via686a.c  |   30 +++++++++++++++---------------
 drivers/i2c/chips/w83627hf.c |   18 +++++++++---------
 drivers/i2c/chips/w83781d.c  |   18 +++++++++---------
 9 files changed, 110 insertions(+), 110 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c	2004-10-19 16:54:25 -07:00
+++ b/drivers/i2c/chips/adm1031.c	2004-10-19 16:54:25 -07:00
@@ -298,12 +298,12 @@
 #define fan_auto_channel_offset(offset)						\
 static ssize_t show_fan_auto_channel_##offset (struct device *dev, char *buf)	\
 {										\
-	return show_fan_auto_channel(dev, buf, 0x##offset - 1);			\
+	return show_fan_auto_channel(dev, buf, offset - 1);			\
 }										\
 static ssize_t set_fan_auto_channel_##offset (struct device *dev,		\
 	const char *buf, size_t count)						\
 {										\
-	return set_fan_auto_channel(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_auto_channel(dev, buf, count, offset - 1);		\
 }										\
 static DEVICE_ATTR(auto_fan##offset##_channel, S_IRUGO | S_IWUSR,		\
 		   show_fan_auto_channel_##offset,				\
@@ -365,25 +365,25 @@
 #define auto_temp_reg(offset)							\
 static ssize_t show_auto_temp_##offset##_off (struct device *dev, char *buf)	\
 {										\
-	return show_auto_temp_off(dev, buf, 0x##offset - 1);			\
+	return show_auto_temp_off(dev, buf, offset - 1);			\
 }										\
 static ssize_t show_auto_temp_##offset##_min (struct device *dev, char *buf)	\
 {										\
-	return show_auto_temp_min(dev, buf, 0x##offset - 1);			\
+	return show_auto_temp_min(dev, buf, offset - 1);			\
 }										\
 static ssize_t show_auto_temp_##offset##_max (struct device *dev, char *buf)	\
 {										\
-	return show_auto_temp_max(dev, buf, 0x##offset - 1);			\
+	return show_auto_temp_max(dev, buf, offset - 1);			\
 }										\
 static ssize_t set_auto_temp_##offset##_min (struct device *dev,		\
 					     const char *buf, size_t count)	\
 {										\
-	return set_auto_temp_min(dev, buf, count, 0x##offset - 1);		\
+	return set_auto_temp_min(dev, buf, count, offset - 1);		\
 }										\
 static ssize_t set_auto_temp_##offset##_max (struct device *dev,		\
 					     const char *buf, size_t count)	\
 {										\
-	return set_auto_temp_max(dev, buf, count, 0x##offset - 1);		\
+	return set_auto_temp_max(dev, buf, count, offset - 1);		\
 }										\
 static DEVICE_ATTR(auto_temp##offset##_off, S_IRUGO,				\
 		   show_auto_temp_##offset##_off, NULL);			\
@@ -429,12 +429,12 @@
 #define pwm_reg(offset)							\
 static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_pwm(dev, buf, 0x##offset - 1);			\
+	return show_pwm(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_pwm_##offset (struct device *dev,			\
 				 const char *buf, size_t count)		\
 {									\
-	return set_pwm(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,			\
 		   show_pwm_##offset, set_pwm_##offset)
@@ -565,25 +565,25 @@
 #define fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
 {									\
-	return show_fan_div(dev, buf, 0x##offset - 1);			\
+	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev,		\
 	const char *buf, size_t count)					\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_fan_##offset##_div (struct device *dev,		\
 	const char *buf, size_t count)					\
 {									\
-	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset,	\
 		   NULL);						\
@@ -675,34 +675,34 @@
 #define temp_reg(offset)							\
 static ssize_t show_temp_##offset (struct device *dev, char *buf)		\
 {										\
-	return show_temp(dev, buf, 0x##offset - 1);				\
+	return show_temp(dev, buf, offset - 1);				\
 }										\
 static ssize_t show_temp_##offset##_min (struct device *dev, char *buf)		\
 {										\
-	return show_temp_min(dev, buf, 0x##offset - 1);				\
+	return show_temp_min(dev, buf, offset - 1);				\
 }										\
 static ssize_t show_temp_##offset##_max (struct device *dev, char *buf)		\
 {										\
-	return show_temp_max(dev, buf, 0x##offset - 1);				\
+	return show_temp_max(dev, buf, offset - 1);				\
 }										\
 static ssize_t show_temp_##offset##_crit (struct device *dev, char *buf)	\
 {										\
-	return show_temp_crit(dev, buf, 0x##offset - 1);			\
+	return show_temp_crit(dev, buf, offset - 1);			\
 }										\
 static ssize_t set_temp_##offset##_min (struct device *dev,			\
 					const char *buf, size_t count)		\
 {										\
-	return set_temp_min(dev, buf, count, 0x##offset - 1);			\
+	return set_temp_min(dev, buf, count, offset - 1);			\
 }										\
 static ssize_t set_temp_##offset##_max (struct device *dev,			\
 					const char *buf, size_t count)		\
 {										\
-	return set_temp_max(dev, buf, count, 0x##offset - 1);			\
+	return set_temp_max(dev, buf, count, offset - 1);			\
 }										\
 static ssize_t set_temp_##offset##_crit (struct device *dev,			\
 					 const char *buf, size_t count)		\
 {										\
-	return set_temp_crit(dev, buf, count, 0x##offset - 1);			\
+	return set_temp_crit(dev, buf, count, offset - 1);			\
 }										\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset,		\
 		   NULL);							\
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2004-10-19 16:54:25 -07:00
+++ b/drivers/i2c/chips/asb100.c	2004-10-19 16:54:25 -07:00
@@ -266,29 +266,29 @@
 static ssize_t \
 	show_in##offset (struct device *dev, char *buf) \
 { \
-	return show_in(dev, buf, 0x##offset); \
+	return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
 		show_in##offset, NULL); \
 static ssize_t \
 	show_in##offset##_min (struct device *dev, char *buf) \
 { \
-	return show_in_min(dev, buf, 0x##offset); \
+	return show_in_min(dev, buf, offset); \
 } \
 static ssize_t \
 	show_in##offset##_max (struct device *dev, char *buf) \
 { \
-	return show_in_max(dev, buf, 0x##offset); \
+	return show_in_max(dev, buf, offset); \
 } \
 static ssize_t set_in##offset##_min (struct device *dev, \
 		const char *buf, size_t count) \
 { \
-	return set_in_min(dev, buf, count, 0x##offset); \
+	return set_in_min(dev, buf, count, offset); \
 } \
 static ssize_t set_in##offset##_max (struct device *dev, \
 		const char *buf, size_t count) \
 { \
-	return set_in_max(dev, buf, count, 0x##offset); \
+	return set_in_max(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
 		show_in##offset##_min, set_in##offset##_min); \
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-10-19 16:54:25 -07:00
+++ b/drivers/i2c/chips/it87.c	2004-10-19 16:54:25 -07:00
@@ -273,7 +273,7 @@
 static ssize_t							\
 	show_in##offset (struct device *dev, char *buf)		\
 {								\
-	return show_in(dev, buf, 0x##offset);			\
+	return show_in(dev, buf, offset);			\
 }								\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);
 
@@ -281,22 +281,22 @@
 static ssize_t							\
 	show_in##offset##_min (struct device *dev, char *buf)	\
 {								\
-	return show_in_min(dev, buf, 0x##offset);		\
+	return show_in_min(dev, buf, offset);			\
 }								\
 static ssize_t							\
 	show_in##offset##_max (struct device *dev, char *buf)	\
 {								\
-	return show_in_max(dev, buf, 0x##offset);		\
+	return show_in_max(dev, buf, offset);			\
 }								\
 static ssize_t set_in##offset##_min (struct device *dev, 	\
 		const char *buf, size_t count) 			\
 {								\
-	return set_in_min(dev, buf, count, 0x##offset);		\
+	return set_in_min(dev, buf, count, offset);		\
 }								\
 static ssize_t set_in##offset##_max (struct device *dev,	\
 			const char *buf, size_t count)		\
 {								\
-	return set_in_max(dev, buf, count, 0x##offset);		\
+	return set_in_max(dev, buf, count, offset);		\
 }								\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
 		show_in##offset##_min, set_in##offset##_min);	\
@@ -360,27 +360,27 @@
 #define show_temp_offset(offset)					\
 static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_temp(dev, buf, 0x##offset - 1);			\
+	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t								\
 show_temp_##offset##_max (struct device *dev, char *buf)		\
 {									\
-	return show_temp_max(dev, buf, 0x##offset - 1);			\
+	return show_temp_max(dev, buf, offset - 1);			\
 }									\
 static ssize_t								\
 show_temp_##offset##_min (struct device *dev, char *buf)		\
 {									\
-	return show_temp_min(dev, buf, 0x##offset - 1);			\
+	return show_temp_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_max (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_min (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_min(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL); \
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
@@ -423,12 +423,12 @@
 #define show_sensor_offset(offset)					\
 static ssize_t show_sensor_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_sensor(dev, buf, 0x##offset - 1);			\
+	return show_sensor(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_sensor_##offset (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_sensor(dev, buf, count, 0x##offset - 1);		\
+	return set_sensor(dev, buf, count, offset - 1);			\
 }									\
 static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, 		\
 		show_sensor_##offset, set_sensor_##offset);
@@ -505,25 +505,25 @@
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
 {									\
-	return show_fan_div(dev, buf, 0x##offset - 1);			\
+	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_fan_##offset##_div (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL); \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2004-10-19 16:54:25 -07:00
+++ b/drivers/i2c/chips/lm78.c	2004-10-19 16:54:25 -07:00
@@ -229,29 +229,29 @@
 static ssize_t							\
 	show_in##offset (struct device *dev, char *buf)		\
 {								\
-	return show_in(dev, buf, 0x##offset);			\
+	return show_in(dev, buf, offset);			\
 }								\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
 		show_in##offset, NULL);				\
 static ssize_t							\
 	show_in##offset##_min (struct device *dev, char *buf)   \
 {								\
-	return show_in_min(dev, buf, 0x##offset);		\
+	return show_in_min(dev, buf, offset);			\
 }								\
 static ssize_t							\
 	show_in##offset##_max (struct device *dev, char *buf)   \
 {								\
-	return show_in_max(dev, buf, 0x##offset);		\
+	return show_in_max(dev, buf, offset);			\
 }								\
 static ssize_t set_in##offset##_min (struct device *dev,	\
 		const char *buf, size_t count)			\
 {								\
-	return set_in_min(dev, buf, count, 0x##offset);		\
+	return set_in_min(dev, buf, count, offset);		\
 }								\
 static ssize_t set_in##offset##_max (struct device *dev,	\
 		const char *buf, size_t count)			\
 {								\
-	return set_in_max(dev, buf, count, 0x##offset);		\
+	return set_in_max(dev, buf, count, offset);		\
 }								\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,		\
 		show_in##offset##_min, set_in##offset##_min);	\
@@ -375,20 +375,20 @@
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)  \
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)  \
 {									\
-	return show_fan_div(dev, buf, 0x##offset - 1);			\
+	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-10-19 16:54:25 -07:00
+++ b/drivers/i2c/chips/lm85.c	2004-10-19 16:54:25 -07:00
@@ -437,16 +437,16 @@
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
@@ -527,16 +527,16 @@
 #define show_pwm_reg(offset)						\
 static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_pwm(dev, buf, 0x##offset - 1);			\
+	return show_pwm(dev, buf, offset - 1);				\
 }									\
 static ssize_t set_pwm_##offset (struct device *dev,			\
 				 const char *buf, size_t count)		\
 {									\
-	return set_pwm(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
 static ssize_t show_pwm_enable##offset (struct device *dev, char *buf)	\
 {									\
-	return show_pwm_enable(dev, buf, 0x##offset - 1);			\
+	return show_pwm_enable(dev, buf, offset - 1);			\
 }									\
 static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, 			\
 		show_pwm_##offset, set_pwm_##offset);			\
@@ -595,25 +595,25 @@
 #define show_in_reg(offset)						\
 static ssize_t show_in_##offset (struct device *dev, char *buf)		\
 {									\
-	return show_in(dev, buf, 0x##offset);				\
+	return show_in(dev, buf, offset);				\
 }									\
 static ssize_t show_in_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_in_min(dev, buf, 0x##offset);			\
+	return show_in_min(dev, buf, offset);				\
 }									\
 static ssize_t show_in_##offset##_max (struct device *dev, char *buf)	\
 {									\
-	return show_in_max(dev, buf, 0x##offset);			\
+	return show_in_max(dev, buf, offset);				\
 }									\
 static ssize_t set_in_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_in_min(dev, buf, count, 0x##offset);			\
+	return set_in_min(dev, buf, count, offset);			\
 }									\
 static ssize_t set_in_##offset##_max (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_in_max(dev, buf, count, 0x##offset);			\
+	return set_in_max(dev, buf, count, offset);			\
 }									\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in_##offset, NULL);	\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 		\
@@ -675,25 +675,25 @@
 #define show_temp_reg(offset)						\
 static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_temp(dev, buf, 0x##offset - 1);			\
+	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_temp_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_temp_min(dev, buf, 0x##offset - 1);			\
+	return show_temp_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_temp_##offset##_max (struct device *dev, char *buf)	\
 {									\
-	return show_temp_max(dev, buf, 0x##offset - 1);			\
+	return show_temp_max(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_max (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);	\
 static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2004-10-19 16:54:25 -07:00
+++ b/drivers/i2c/chips/smsc47m1.c	2004-10-19 16:54:25 -07:00
@@ -298,43 +298,43 @@
 #define fan_present(offset)						\
 static ssize_t get_fan##offset (struct device *dev, char *buf)		\
 {									\
-	return get_fan(dev, buf, 0x##offset - 1);			\
+	return get_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t get_fan##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return get_fan_min(dev, buf, 0x##offset - 1);			\
+	return get_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan##offset##_min (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t get_fan##offset##_div (struct device *dev, char *buf)	\
 {									\
-	return get_fan_div(dev, buf, 0x##offset - 1);			\
+	return get_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan##offset##_div (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t get_pwm##offset (struct device *dev, char *buf)		\
 {									\
-	return get_pwm(dev, buf, 0x##offset - 1);			\
+	return get_pwm(dev, buf, offset - 1);				\
 }									\
 static ssize_t set_pwm##offset (struct device *dev,			\
 		const char *buf, size_t count)				\
 {									\
-	return set_pwm(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm(dev, buf, count, offset - 1);			\
 }									\
 static ssize_t get_pwm##offset##_en (struct device *dev, char *buf)	\
 {									\
-	return get_pwm_en(dev, buf, 0x##offset - 1);			\
+	return get_pwm_en(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_pwm##offset##_en (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_pwm_en(dev, buf, count, 0x##offset - 1);		\
+	return set_pwm_en(dev, buf, count, offset - 1);			\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, get_fan##offset,	\
 		NULL);							\
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2004-10-19 16:54:25 -07:00
+++ b/drivers/i2c/chips/via686a.c	2004-10-19 16:54:25 -07:00
@@ -383,27 +383,27 @@
 static ssize_t 							\
 	show_in##offset (struct device *dev, char *buf)		\
 {								\
-	return show_in(dev, buf, 0x##offset);			\
+	return show_in(dev, buf, offset);			\
 }								\
 static ssize_t 							\
 	show_in##offset##_min (struct device *dev, char *buf)	\
 {								\
-	return show_in_min(dev, buf, 0x##offset);		\
+	return show_in_min(dev, buf, offset);		\
 }								\
 static ssize_t 							\
 	show_in##offset##_max (struct device *dev, char *buf)	\
 {								\
-	return show_in_max(dev, buf, 0x##offset);		\
+	return show_in_max(dev, buf, offset);		\
 }								\
 static ssize_t set_in##offset##_min (struct device *dev, 	\
 		const char *buf, size_t count) 			\
 {								\
-	return set_in_min(dev, buf, count, 0x##offset);		\
+	return set_in_min(dev, buf, count, offset);		\
 }								\
 static ssize_t set_in##offset##_max (struct device *dev,	\
 			const char *buf, size_t count)		\
 {								\
-	return set_in_max(dev, buf, count, 0x##offset);		\
+	return set_in_max(dev, buf, count, offset);		\
 }								\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
@@ -451,27 +451,27 @@
 #define show_temp_offset(offset)					\
 static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_temp(dev, buf, 0x##offset - 1);			\
+	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t								\
 show_temp_##offset##_over (struct device *dev, char *buf)		\
 {									\
-	return show_temp_over(dev, buf, 0x##offset - 1);			\
+	return show_temp_over(dev, buf, offset - 1);			\
 }									\
 static ssize_t								\
 show_temp_##offset##_hyst (struct device *dev, char *buf)		\
 {									\
-	return show_temp_hyst(dev, buf, 0x##offset - 1);			\
+	return show_temp_hyst(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp_##offset##_over (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_over(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_over(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp_##offset##_hyst (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_temp_hyst(dev, buf, count, 0x##offset - 1);		\
+	return set_temp_hyst(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL);\
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
@@ -522,25 +522,25 @@
 #define show_fan_offset(offset)						\
 static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
 {									\
-	return show_fan(dev, buf, 0x##offset - 1);			\
+	return show_fan(dev, buf, offset - 1);				\
 }									\
 static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
 {									\
-	return show_fan_min(dev, buf, 0x##offset - 1);			\
+	return show_fan_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
 {									\
-	return show_fan_div(dev, buf, 0x##offset - 1);			\
+	return show_fan_div(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_fan_##offset##_min (struct device *dev, 		\
 	const char *buf, size_t count) 					\
 {									\
-	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_fan_##offset##_div (struct device *dev, 		\
 		const char *buf, size_t count) 				\
 {									\
-	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+	return set_fan_div(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2004-10-19 16:54:25 -07:00
+++ b/drivers/i2c/chips/w83627hf.c	2004-10-19 16:54:25 -07:00
@@ -369,20 +369,20 @@
 static ssize_t \
 show_regs_in_##offset (struct device *dev, char *buf) \
 { \
-        return show_in(dev, buf, 0x##offset); \
+        return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
 static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
 { \
-	return show_in_##reg (dev, buf, 0x##offset); \
+	return show_in_##reg (dev, buf, offset); \
 } \
 static ssize_t \
 store_regs_in_##reg##offset (struct device *dev, \
 			    const char *buf, size_t count) \
 { \
-	return store_in_##reg (dev, buf, count, 0x##offset); \
+	return store_in_##reg (dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, \
 		  show_regs_in_##reg##offset, store_regs_in_##reg##offset);
@@ -521,19 +521,19 @@
 #define sysfs_fan_offset(offset) \
 static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
 { \
-	return show_fan(dev, buf, 0x##offset); \
+	return show_fan(dev, buf, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
 { \
-	return show_fan_min(dev, buf, 0x##offset); \
+	return show_fan_min(dev, buf, offset); \
 } \
 static ssize_t \
 store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
 { \
-	return store_fan_min(dev, buf, count, 0x##offset); \
+	return store_fan_min(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
 		  show_regs_fan_min##offset, store_regs_fan_min##offset);
@@ -595,20 +595,20 @@
 static ssize_t \
 show_regs_temp_##offset (struct device *dev, char *buf) \
 { \
-	return show_temp(dev, buf, 0x##offset); \
+	return show_temp(dev, buf, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
 { \
-	return show_temp_##reg (dev, buf, 0x##offset); \
+	return show_temp_##reg (dev, buf, offset); \
 } \
 static ssize_t \
 store_regs_temp_##reg##offset (struct device *dev, \
 			      const char *buf, size_t count) \
 { \
-	return store_temp_##reg (dev, buf, count, 0x##offset); \
+	return store_temp_##reg (dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, \
 		  show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2004-10-19 16:54:25 -07:00
+++ b/drivers/i2c/chips/w83781d.c	2004-10-19 16:54:25 -07:00
@@ -318,18 +318,18 @@
 static ssize_t \
 show_regs_in_##offset (struct device *dev, char *buf) \
 { \
-        return show_in(dev, buf, 0x##offset); \
+        return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
 static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
 { \
-	return show_in_##reg (dev, buf, 0x##offset); \
+	return show_in_##reg (dev, buf, offset); \
 } \
 static ssize_t store_regs_in_##reg##offset (struct device *dev, const char *buf, size_t count) \
 { \
-	return store_in_##reg (dev, buf, count, 0x##offset); \
+	return store_in_##reg (dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset);
 
@@ -384,18 +384,18 @@
 #define sysfs_fan_offset(offset) \
 static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
 { \
-	return show_fan(dev, buf, 0x##offset); \
+	return show_fan(dev, buf, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
 { \
-	return show_fan_min(dev, buf, 0x##offset); \
+	return show_fan_min(dev, buf, offset); \
 } \
 static ssize_t store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
 { \
-	return store_fan_min(dev, buf, count, 0x##offset); \
+	return store_fan_min(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, show_regs_fan_min##offset, store_regs_fan_min##offset);
 
@@ -464,18 +464,18 @@
 static ssize_t \
 show_regs_temp_##offset (struct device *dev, char *buf) \
 { \
-	return show_temp(dev, buf, 0x##offset); \
+	return show_temp(dev, buf, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
 { \
-	return show_temp_##reg (dev, buf, 0x##offset); \
+	return show_temp_##reg (dev, buf, offset); \
 } \
 static ssize_t store_regs_temp_##reg##offset (struct device *dev, const char *buf, size_t count) \
 { \
-	return store_temp_##reg (dev, buf, count, 0x##offset); \
+	return store_temp_##reg (dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
 

