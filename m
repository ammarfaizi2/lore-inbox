Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVESLhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVESLhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 07:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVESLhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 07:37:50 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:11931 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262231AbVESLfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 07:35:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=ur2x2pZYoJPNU/dDHVlhHS2E5IinIt8l1Eos1TqReeeXRKzCCjdEJH4hAUyb8emXRUZ8usG+cKZgkiGMQ2I9hg/Wb94cVQhjlDwWwAZaYbdUwKSYxa/2ObYRmIBwe44G7zINdFuIkaBPiO9coR8uF6sJcBPD6dXaNtujpleslSg=
Message-ID: <253818670505190435648367db@mail.gmail.com>
Date: Thu, 19 May 2005 07:35:35 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6.12-rc4-mm2] drivers: (dynamic sysfs callbacks) update device attribute callbacks
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_156_17059740.1116502535960"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_156_17059740.1116502535960
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Greg,

I'm taking two steps here to try and mitigate the pain of a potential -mm m=
erge.

I'm including a patch against 2.4.12-rc4-mm2 to fix the failed hunks
when applying my 2.4.12-rc4 patch and update the callbacks in the new
drivers that exist in -mm2.

In reply to this patch I'll include the latest perl script I'm using
to update callbacks in code which can be used to update any old
callbacks in a single file/source tree to the new callbacks. A warning
along the lines of  "warning: assignment from incompatible pointer
type" when compiling is a good sign of an old callback that needs
updating..

It is important to note that unlike before, updating the callbacks
isn't just removing warnings/good practice. The new device_attribute *
parameter was not added on the end of callback function's parameter
list as the void * parameter was in previous device_attribute patches,
but as the second parameter (mainly because of style and Russell did
it that way). Thus if a device_attribute callback isn't updated it
will very likely be broken...

If you can think of anything else I can do let me know to ease things
let me know.

Yani

---
char/tpm/tpm.c            |    8 ++++----
  char/tpm/tpm.h            |    8 ++++----
 i2c/chips/adm1025.c       |    8 ++++----
 i2c/chips/adm9240.c       |   32 ++++++++++++++++----------------
 i2c/chips/atxp1.c         |   12 ++++++------
 i2c/chips/w83627ehf.c     |   18 +++++++++---------
  input/serio/serio.c       |   12 ++++++------
  message/fusion/mptscsih.c |    2 +-
  message/fusion/mptscsih.h |    2 +-
  pci/pci-sysfs.c           |    2 +-
  pcmcia/ds.c               |    2 +-
  usb/core/sysfs.c          |    2 +-
 12 files changed, 54 insertions(+), 54 deletions(-)
---

------=_Part_156_17059740.1116502535960
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-mm2-sysfsdyncallback-deviceattr-update.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-mm2-sysfsdyncallback-deviceattr-update.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/char/tpm/tpm.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/char/tpm/tpm.c	2005-05-18 20:35:25.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/char/tpm/tpm.c	2005-05-18 20:41:11.000000000 -0400
@@ -216,7 +216,7 @@ static const u8 pcrread[] = {
 	0, 0, 0, 0		/* PCR index */
 };
 
-ssize_t tpm_show_pcrs(struct device *dev, char *buf)
+ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
@@ -268,7 +268,7 @@ static const u8 readpubek[] = {
 	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
 };
 
-ssize_t tpm_show_pubek(struct device *dev, char *buf)
+ssize_t tpm_show_pubek(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	u8 *data;
 	ssize_t len;
@@ -349,7 +349,7 @@ static const u8 cap_manufacturer[] = {
 	0, 0, 1, 3
 };
 
-ssize_t tpm_show_caps(struct device *dev, char *buf)
+ssize_t tpm_show_caps(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	u8 data[sizeof(cap_manufacturer)];
 	ssize_t len;
@@ -385,7 +385,7 @@ ssize_t tpm_show_caps(struct device *dev
 
 EXPORT_SYMBOL_GPL(tpm_show_caps);
 
-ssize_t tpm_store_cancel(struct device * dev, const char *buf,
+ssize_t tpm_store_cancel(struct device * dev, struct device_attribute *attr, const char *buf,
 			 size_t count)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/char/tpm/tpm.h linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/char/tpm/tpm.h
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/char/tpm/tpm.h	2005-05-18 20:31:03.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/char/tpm/tpm.h	2005-05-18 20:41:11.000000000 -0400
@@ -35,10 +35,10 @@ enum tpm_addr {
 	TPM_DATA = 0x4F
 };
 
-extern ssize_t tpm_show_pubek(struct device *, char *);
-extern ssize_t tpm_show_pcrs(struct device *, char *);
-extern ssize_t tpm_show_caps(struct device *, char *);
-extern ssize_t tpm_store_cancel(struct device *, const char *, size_t);
+extern ssize_t tpm_show_pubek(struct device *, struct device_attribute *attr, char *);
+extern ssize_t tpm_show_pcrs(struct device *, struct device_attribute *attr, char *);
+extern ssize_t tpm_show_caps(struct device *, struct device_attribute *attr, char *);
+extern ssize_t tpm_store_cancel(struct device *, struct device_attribute *attr, const char *, size_t);
 
 
 struct tpm_chip;
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/i2c/chips/adm1025.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/i2c/chips/adm1025.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/i2c/chips/adm1025.c	2005-05-18 20:35:25.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/i2c/chips/adm1025.c	2005-05-18 20:40:53.000000000 -0400
@@ -274,14 +274,14 @@ static DEVICE_ATTR(temp##offset##_max, S
 set_temp(1);
 set_temp(2);
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
-static ssize_t show_vid(struct device *dev, char *buf)
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
@@ -290,12 +290,12 @@ static ssize_t show_vid(struct device *d
 static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, char *buf)
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1025_data *data = i2c_get_clientdata(client);
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/i2c/chips/adm9240.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/i2c/chips/adm9240.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/i2c/chips/adm9240.c	2005-05-18 20:30:41.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/i2c/chips/adm9240.c	2005-05-18 20:40:53.000000000 -0400
@@ -185,7 +185,7 @@ static int adm9240_write_value(struct i2
 
 /* temperature */
 #define show_temp(value, scale)					\
-static ssize_t show_##value(struct device *dev, char *buf)	\
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	struct adm9240_data *data = adm9240_update_device(dev);	\
 	return sprintf(buf, "%d\n", data->value * scale);	\
@@ -195,7 +195,7 @@ show_temp(temp_hyst, 1000);
 show_temp(temp, 500);
 
 #define set_temp(value, reg)					\
-static ssize_t set_##value(struct device *dev, const char *buf,	\
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf,	\
 		size_t count)					\
 {								\
 	struct i2c_client *client = to_i2c_client(dev);		\
@@ -266,26 +266,26 @@ static ssize_t set_in_max(struct device 
 }
 
 #define show_in_offset(offset)						\
-static ssize_t show_in##offset(struct device *dev, char *buf)		\
+static ssize_t show_in##offset(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	return show_in(dev, buf, offset);				\
 }									\
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);	\
-static ssize_t show_in##offset##_min(struct device *dev, char *buf)	\
+static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_in_min(dev, buf, offset);				\
 }									\
-static ssize_t show_in##offset##_max(struct device *dev, char *buf)	\
+static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_in_max(dev, buf, offset);				\
 }									\
 static ssize_t								\
-set_in##offset##_min(struct device *dev, const char *buf, size_t count)	\
+set_in##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
 {									\
 	return set_in_min(dev, buf, count, offset);			\
 }									\
 static ssize_t								\
-set_in##offset##_max(struct device *dev, const char *buf, size_t count)	\
+set_in##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
 {									\
 	return set_in_max(dev, buf, count, offset);			\
 }									\
@@ -401,19 +401,19 @@ static ssize_t set_fan_min(struct device
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 return show_fan(dev, buf, offset - 1);					\
 }									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 return show_fan_div(dev, buf, offset - 1);				\
 }									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 return show_fan_min(dev, buf, offset - 1);				\
 }									\
-static ssize_t set_fan_##offset##_min (struct device *dev, 		\
+static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
 const char *buf, size_t count)						\
 {									\
 return set_fan_min(dev, buf, count, offset - 1);			\
@@ -429,7 +429,7 @@ show_fan_offset(1);
 show_fan_offset(2);
 
 /* alarms */
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -437,7 +437,7 @@ static ssize_t show_alarms(struct device
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /* vid */
-static ssize_t show_vid(struct device *dev, char *buf)
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -445,13 +445,13 @@ static ssize_t show_vid(struct device *d
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* analog output */
-static ssize_t show_aout(struct device *dev, char *buf)
+static ssize_t show_aout(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
 
-static ssize_t set_aout(struct device *dev, const char *buf, size_t count)
+static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
@@ -466,7 +466,7 @@ static ssize_t set_aout(struct device *d
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
 
 /* chassis_clear */
-static ssize_t chassis_clear(struct device *dev, const char *buf, size_t count)
+static ssize_t chassis_clear(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned long val = simple_strtol(buf, NULL, 10);
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/i2c/chips/atxp1.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/i2c/chips/atxp1.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/i2c/chips/atxp1.c	2005-05-18 20:30:41.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/i2c/chips/atxp1.c	2005-05-18 20:40:53.000000000 -0400
@@ -99,7 +99,7 @@ static struct atxp1_data * atxp1_update_
 }
 
 /* sys file functions for cpu0_vid */
-static ssize_t atxp1_showvcore(struct device *dev, char *buf)
+static ssize_t atxp1_showvcore(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -111,7 +111,7 @@ static ssize_t atxp1_showvcore(struct de
 	return size;
 }
 
-static ssize_t atxp1_storevcore(struct device *dev, const char* buf, size_t count)
+static ssize_t atxp1_storevcore(struct device *dev, struct device_attribute *attr, const char* buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
@@ -169,7 +169,7 @@ static ssize_t atxp1_storevcore(struct d
 static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore, atxp1_storevcore);
 
 /* sys file functions for GPIO1 */
-static ssize_t atxp1_showgpio1(struct device *dev, char *buf)
+static ssize_t atxp1_showgpio1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -181,7 +181,7 @@ static ssize_t atxp1_showgpio1(struct de
 	return size;
 }
 
-static ssize_t atxp1_storegpio1(struct device *dev, const char* buf, size_t count)
+static ssize_t atxp1_storegpio1(struct device *dev, struct device_attribute *attr, const char* buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
@@ -211,7 +211,7 @@ static ssize_t atxp1_storegpio1(struct d
 static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);
 
 /* sys file functions for GPIO2 */
-static ssize_t atxp1_showgpio2(struct device *dev, char *buf)
+static ssize_t atxp1_showgpio2(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -223,7 +223,7 @@ static ssize_t atxp1_showgpio2(struct de
 	return size;
 }
 
-static ssize_t atxp1_storegpio2(struct device *dev, const char* buf, size_t count)
+static ssize_t atxp1_storegpio2(struct device *dev, struct device_attribute *attr, const char* buf, size_t count)
 {
 	struct atxp1_data *data;
 	struct i2c_client *client;
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/i2c/chips/w83627ehf.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/i2c/chips/w83627ehf.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/i2c/chips/w83627ehf.c	2005-05-18 20:30:41.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/i2c/chips/w83627ehf.c	2005-05-18 20:40:53.000000000 -0400
@@ -486,7 +486,7 @@ store_fan_min(struct device *dev, const 
 
 #define sysfs_fan_offset(offset) \
 static ssize_t \
-show_reg_fan_##offset(struct device *dev, char *buf) \
+show_reg_fan_##offset(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan(dev, buf, offset-1); \
 } \
@@ -495,12 +495,12 @@ static DEVICE_ATTR(fan##offset##_input, 
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t \
-show_reg_fan##offset##_min(struct device *dev, char *buf) \
+show_reg_fan##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan_min(dev, buf, offset-1); \
 } \
 static ssize_t \
-store_reg_fan##offset##_min(struct device *dev, const char *buf, \
+store_reg_fan##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
 			    size_t count) \
 { \
 	return store_fan_min(dev, buf, count, offset-1); \
@@ -511,7 +511,7 @@ static DEVICE_ATTR(fan##offset##_min, S_
 
 #define sysfs_fan_div_offset(offset) \
 static ssize_t \
-show_reg_fan##offset##_div(struct device *dev, char *buf) \
+show_reg_fan##offset##_div(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan_div(dev, buf, offset - 1); \
 } \
@@ -536,7 +536,7 @@ sysfs_fan_div_offset(5);
 
 #define show_temp1_reg(reg) \
 static ssize_t \
-show_##reg(struct device *dev, char *buf) \
+show_##reg(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
 	return sprintf(buf, "%d\n", temp1_from_reg(data->reg)); \
@@ -547,7 +547,7 @@ show_temp1_reg(temp1_max_hyst);
 
 #define store_temp1_reg(REG, reg) \
 static ssize_t \
-store_temp1_##reg(struct device *dev, const char *buf, size_t count) \
+store_temp1_##reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct w83627ehf_data *data = i2c_get_clientdata(client); \
@@ -601,7 +601,7 @@ store_temp_reg(HYST, temp_max_hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
-show_reg_temp##offset (struct device *dev, char *buf) \
+show_reg_temp##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp(dev, buf, offset - 2); \
 } \
@@ -610,12 +610,12 @@ static DEVICE_ATTR(temp##offset##_input,
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t \
-show_reg_temp##offset##_##reg(struct device *dev, char *buf) \
+show_reg_temp##offset##_##reg(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp_##reg(dev, buf, offset - 2); \
 } \
 static ssize_t \
-store_reg_temp##offset##_##reg(struct device *dev, const char *buf, \
+store_reg_temp##offset##_##reg(struct device *dev, struct device_attribute *attr, const char *buf, \
 			       size_t count) \
 { \
 	return store_temp_##reg(dev, buf, count, offset - 2); \
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/input/serio/serio.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/input/serio/serio.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/input/serio/serio.c	2005-05-18 20:35:26.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/input/serio/serio.c	2005-05-18 20:41:24.000000000 -0400
@@ -358,31 +358,31 @@ static int serio_thread(void *nothing)
  * Serio port operations
  */
 
-static ssize_t serio_show_description(struct device *dev, char *buf)
+static ssize_t serio_show_description(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%s\n", serio->name);
 }
 
-static ssize_t serio_show_id_type(struct device *dev, char *buf)
+static ssize_t serio_show_id_type(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.type);
 }
 
-static ssize_t serio_show_id_proto(struct device *dev, char *buf)
+static ssize_t serio_show_id_proto(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.proto);
 }
 
-static ssize_t serio_show_id_id(struct device *dev, char *buf)
+static ssize_t serio_show_id_id(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.id);
 }
 
-static ssize_t serio_show_id_extra(struct device *dev, char *buf)
+static ssize_t serio_show_id_extra(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.extra);
@@ -406,7 +406,7 @@ static struct attribute_group serio_id_a
 	.attrs	= serio_device_id_attrs,
 };
 
-static ssize_t serio_rebind_driver(struct device *dev, const char *buf, size_t count)
+static ssize_t serio_rebind_driver(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct serio *serio = to_serio_port(dev);
 	struct device_driver *drv;
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/message/fusion/mptscsih.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/message/fusion/mptscsih.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/message/fusion/mptscsih.c	2005-05-18 20:35:26.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/message/fusion/mptscsih.c	2005-05-18 20:41:31.000000000 -0400
@@ -2352,7 +2352,7 @@ slave_configure_exit:
 }
 
 ssize_t
-mptscsih_store_queue_depth(struct device *dev, const char *buf, size_t count)
+mptscsih_store_queue_depth(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	int			 depth;
 	struct scsi_device	*sdev = to_scsi_device(dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/message/fusion/mptscsih.h linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/message/fusion/mptscsih.h
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/message/fusion/mptscsih.h	2005-05-18 20:31:19.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/message/fusion/mptscsih.h	2005-05-18 20:41:31.000000000 -0400
@@ -103,5 +103,5 @@ extern int mptscsih_taskmgmt_complete(MP
 extern int mptscsih_scandv_complete(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf, MPT_FRAME_HDR *r);
 extern int mptscsih_event_process(MPT_ADAPTER *ioc, EventNotificationReply_t *pEvReply);
 extern int mptscsih_ioc_reset(MPT_ADAPTER *ioc, int post_reset);
-extern ssize_t mptscsih_store_queue_depth(struct device *dev, const char *buf, size_t count);
+extern ssize_t mptscsih_store_queue_depth(struct device *dev, struct device_attribute *attr, const char *buf, size_t count);
 extern void mptscsih_timer_expired(unsigned long data);
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/pci/pci-sysfs.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/pci/pci-sysfs.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/pci/pci-sysfs.c	2005-05-18 20:35:26.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/pci/pci-sysfs.c	2005-05-18 20:41:03.000000000 -0400
@@ -76,7 +76,7 @@ resource_show(struct device * dev, struc
 	return (str - buf);
 }
 
-static ssize_t modalias_show(struct device *dev, char *buf)
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/pcmcia/ds.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/pcmcia/ds.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/pcmcia/ds.c	2005-05-18 20:35:26.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/pcmcia/ds.c	2005-05-18 20:41:32.000000000 -0400
@@ -848,7 +848,7 @@ pcmcia_device_stringattr(prod_id3, prod_
 pcmcia_device_stringattr(prod_id4, prod_id[3]);
 
 
-static ssize_t pcmcia_store_allow_func_id_match (struct device * dev, const char * buf, size_t count)
+static ssize_t pcmcia_store_allow_func_id_match (struct device * dev, struct device_attribute *attr, const char * buf, size_t count)
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
         if (!count)
diff -uprN -X dontdiff linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/usb/core/sysfs.c linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/usb/core/sysfs.c
--- linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr.old/drivers/usb/core/sysfs.c	2005-05-18 20:35:27.000000000 -0400
+++ linux-2.6.12-rc4-mm2-sysfsdyncallback-devattr/drivers/usb/core/sysfs.c	2005-05-18 20:41:04.000000000 -0400
@@ -286,7 +286,7 @@ static ssize_t show_interface_string(str
 }
 static DEVICE_ATTR(interface, S_IRUGO, show_interface_string, NULL);
 
-static ssize_t show_modalias(struct device *dev, char *buf)
+static ssize_t show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_interface *intf;
 	struct usb_device *udev;


------=_Part_156_17059740.1116502535960--
