Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVEQKs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVEQKs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 06:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVEQKs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 06:48:57 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:31218 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261364AbVEQKlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:41:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=Xke3IivfM+OS5b0Wxkm/gT91UL0WMSehbwt7xGqvus6TctEMqpQ9lIT4q7rl45G9lccRP6rTWGj+PB8YRGO3Gd5U3IZI/o8bCE/6q2riLq6759s28PmOJLAZzJb1Izr+YgnB/JGfvNVpTYAQlZW4o1/tpKu8WcaVknKtiPFG8gI=
Message-ID: <2538186705051703411ef34f38@mail.gmail.com>
Date: Tue, 17 May 2005 06:41:12 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [PATCH 2.6.12-rc4 5/15] drivers/base - drivers/i2c/chips/adm1026.c: update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_264_2162443.1116326472088"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_264_2162443.1116326472088
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_264_2162443.1116326472088
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.0.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.0.diff.diffstat.txt"

 base/dmapool.c       |    2 -
 base/interface.c     |    4 +-
 base/power/sysfs.c   |    4 +-
 block/ub.c           |    2 -
 char/hvcs.c          |   14 +++----
 char/mbcs.c          |    4 +-
 char/mwave/mwavedd.c |    2 -
 char/tpm/tpm.c       |    6 +--
 dio/dio-sysfs.c      |   10 ++---
 eisa/eisa-bus.c      |    4 +-
 i2c/chips/adm1021.c  |    6 +--
 i2c/chips/adm1025.c  |   28 +++++++-------
 i2c/chips/adm1026.c  |   98 +++++++++++++++++++++++++--------------------------
 13 files changed, 92 insertions(+), 92 deletions(-)



------=_Part_264_2162443.1116326472088
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.0.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.0.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/dmapool.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/base/dmapool.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/dmapool.c	2005-05-16 20:35:47.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/base/dmapool.c	2005-05-16 23:45:52.000000000 -0400
@@ -41,7 +41,7 @@ struct dma_page {	/* cacheable header fo
 static DECLARE_MUTEX (pools_lock);
 
 static ssize_t
-show_pools (struct device *dev, char *buf)
+show_pools (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	unsigned temp;
 	unsigned size;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/interface.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/base/interface.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/interface.c	2005-05-16 20:35:47.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/base/interface.c	2005-05-16 23:45:52.000000000 -0400
@@ -27,12 +27,12 @@
  *	driver's suspend method.
  */
 
-static ssize_t detach_show(struct device * dev, char * buf)
+static ssize_t detach_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
 	return sprintf(buf, "%u\n", dev->detach_state);
 }
 
-static ssize_t detach_store(struct device * dev, const char * buf, size_t n)
+static ssize_t detach_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
 {
 	u32 state;
 	state = simple_strtoul(buf, NULL, 10);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/power/sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/base/power/sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/power/sysfs.c	2005-05-16 20:35:47.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/base/power/sysfs.c	2005-05-16 23:45:52.000000000 -0400
@@ -24,12 +24,12 @@
  *	low-power state.
  */
 
-static ssize_t state_show(struct device * dev, char * buf)
+static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
 	return sprintf(buf, "%u\n", dev->power.power_state);
 }
 
-static ssize_t state_store(struct device * dev, const char * buf, size_t n)
+static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
 {
 	u32 state;
 	char * rest;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/block/ub.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/block/ub.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/block/ub.c	2005-05-16 20:35:57.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/block/ub.c	2005-05-16 23:45:52.000000000 -0400
@@ -402,7 +402,7 @@ static void ub_cmdtr_sense(struct ub_dev
 	}
 }
 
-static ssize_t ub_diag_show(struct device *dev, char *page)
+static ssize_t ub_diag_show(struct device *dev, struct device_attribute *attr, char *page)
 {
 	struct usb_interface *intf;
 	struct ub_dev *sc;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/char/hvcs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/char/hvcs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/char/hvcs.c	2005-05-16 20:35:49.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/char/hvcs.c	2005-05-16 23:45:52.000000000 -0400
@@ -1466,7 +1466,7 @@ static inline struct hvcs_struct *from_v
 }
 /* The sysfs interface for the driver and devices */
 
-static ssize_t hvcs_partner_vtys_show(struct device *dev, char *buf)
+static ssize_t hvcs_partner_vtys_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct vio_dev *viod = to_vio_dev(dev);
 	struct hvcs_struct *hvcsd = from_vio_dev(viod);
@@ -1480,7 +1480,7 @@ static ssize_t hvcs_partner_vtys_show(st
 }
 static DEVICE_ATTR(partner_vtys, S_IRUGO, hvcs_partner_vtys_show, NULL);
 
-static ssize_t hvcs_partner_clcs_show(struct device *dev, char *buf)
+static ssize_t hvcs_partner_clcs_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct vio_dev *viod = to_vio_dev(dev);
 	struct hvcs_struct *hvcsd = from_vio_dev(viod);
@@ -1494,7 +1494,7 @@ static ssize_t hvcs_partner_clcs_show(st
 }
 static DEVICE_ATTR(partner_clcs, S_IRUGO, hvcs_partner_clcs_show, NULL);
 
-static ssize_t hvcs_current_vty_store(struct device *dev, const char * buf,
+static ssize_t hvcs_current_vty_store(struct device *dev, struct device_attribute *attr, const char * buf,
 		size_t count)
 {
 	/*
@@ -1505,7 +1505,7 @@ static ssize_t hvcs_current_vty_store(st
 	return -EPERM;
 }
 
-static ssize_t hvcs_current_vty_show(struct device *dev, char *buf)
+static ssize_t hvcs_current_vty_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct vio_dev *viod = to_vio_dev(dev);
 	struct hvcs_struct *hvcsd = from_vio_dev(viod);
@@ -1521,7 +1521,7 @@ static ssize_t hvcs_current_vty_show(str
 static DEVICE_ATTR(current_vty,
 	S_IRUGO | S_IWUSR, hvcs_current_vty_show, hvcs_current_vty_store);
 
-static ssize_t hvcs_vterm_state_store(struct device *dev, const char *buf,
+static ssize_t hvcs_vterm_state_store(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct vio_dev *viod = to_vio_dev(dev);
@@ -1559,7 +1559,7 @@ static ssize_t hvcs_vterm_state_store(st
 	return count;
 }
 
-static ssize_t hvcs_vterm_state_show(struct device *dev, char *buf)
+static ssize_t hvcs_vterm_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct vio_dev *viod = to_vio_dev(dev);
 	struct hvcs_struct *hvcsd = from_vio_dev(viod);
@@ -1574,7 +1574,7 @@ static ssize_t hvcs_vterm_state_show(str
 static DEVICE_ATTR(vterm_state, S_IRUGO | S_IWUSR,
 		hvcs_vterm_state_show, hvcs_vterm_state_store);
 
-static ssize_t hvcs_index_show(struct device *dev, char *buf)
+static ssize_t hvcs_index_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct vio_dev *viod = to_vio_dev(dev);
 	struct hvcs_struct *hvcsd = from_vio_dev(viod);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/char/mbcs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/char/mbcs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/char/mbcs.c	2005-05-16 20:35:49.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/char/mbcs.c	2005-05-16 23:45:52.000000000 -0400
@@ -699,7 +699,7 @@ static inline int mbcs_hw_init(struct mb
 	return 0;
 }
 
-static ssize_t show_algo(struct device *dev, char *buf)
+static ssize_t show_algo(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct cx_dev *cx_dev = to_cx_dev(dev);
 	struct mbcs_soft *soft = cx_dev->soft;
@@ -715,7 +715,7 @@ static ssize_t show_algo(struct device *
 		       (debug0 >> 32), (debug0 & 0xffffffff));
 }
 
-static ssize_t store_algo(struct device *dev, const char *buf, size_t count)
+static ssize_t store_algo(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	int n;
 	struct cx_dev *cx_dev = to_cx_dev(dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/char/mwave/mwavedd.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/char/mwave/mwavedd.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/char/mwave/mwavedd.c	2005-05-16 20:35:48.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/char/mwave/mwavedd.c	2005-05-16 23:45:52.000000000 -0400
@@ -472,7 +472,7 @@ struct device mwave_device;
 
 /* Prevent code redundancy, create a macro for mwave_show_* functions. */
 #define mwave_show_function(attr_name, format_string, field)		\
-static ssize_t mwave_show_##attr_name(struct device *dev, char *buf)	\
+static ssize_t mwave_show_##attr_name(struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	DSP_3780I_CONFIG_SETTINGS *pSettings =				\
 		&mwave_s_mdd.rBDData.rDspSettings;			\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/char/tpm/tpm.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/char/tpm/tpm.c	2005-05-16 20:35:48.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/char/tpm/tpm.c	2005-05-16 23:45:52.000000000 -0400
@@ -212,7 +212,7 @@ static u8 pcrread[] = {
 	0, 0, 0, 0		/* PCR index */
 };
 
-static ssize_t show_pcrs(struct device *dev, char *buf)
+static ssize_t show_pcrs(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
@@ -255,7 +255,7 @@ static u8 readpubek[] = {
 	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
 };
 
-static ssize_t show_pubek(struct device *dev, char *buf)
+static ssize_t show_pubek(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	u8 data[READ_PUBEK_RESULT_SIZE];
 	ssize_t len;
@@ -330,7 +330,7 @@ static u8 cap_manufacturer[] = {
 	0, 0, 1, 3
 };
 
-static ssize_t show_caps(struct device *dev, char *buf)
+static ssize_t show_caps(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	u8 data[READ_PUBEK_RESULT_SIZE];
 	ssize_t len;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/dio/dio-sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/dio/dio-sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/dio/dio-sysfs.c	2005-05-16 20:35:33.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/dio/dio-sysfs.c	2005-05-16 23:45:52.000000000 -0400
@@ -17,7 +17,7 @@
 
 /* show configuration fields */
 
-static ssize_t dio_show_id(struct device *dev, char *buf)
+static ssize_t dio_show_id(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dio_dev *d;
 
@@ -26,7 +26,7 @@ static ssize_t dio_show_id(struct device
 }
 static DEVICE_ATTR(id, S_IRUGO, dio_show_id, NULL);
 
-static ssize_t dio_show_ipl(struct device *dev, char *buf)
+static ssize_t dio_show_ipl(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dio_dev *d;
 
@@ -35,7 +35,7 @@ static ssize_t dio_show_ipl(struct devic
 }
 static DEVICE_ATTR(ipl, S_IRUGO, dio_show_ipl, NULL);
 
-static ssize_t dio_show_secid(struct device *dev, char *buf)
+static ssize_t dio_show_secid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dio_dev *d;
 
@@ -44,7 +44,7 @@ static ssize_t dio_show_secid(struct dev
 }
 static DEVICE_ATTR(secid, S_IRUGO, dio_show_secid, NULL);
 
-static ssize_t dio_show_name(struct device *dev, char *buf)
+static ssize_t dio_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dio_dev *d;
 
@@ -53,7 +53,7 @@ static ssize_t dio_show_name(struct devi
 }
 static DEVICE_ATTR(name, S_IRUGO, dio_show_name, NULL);
 
-static ssize_t dio_show_resource(struct device *dev, char *buf)
+static ssize_t dio_show_resource(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dio_dev *d = to_dio_dev(dev);
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/eisa/eisa-bus.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/eisa/eisa-bus.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/eisa/eisa-bus.c	2005-05-16 20:35:49.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/eisa/eisa-bus.c	2005-05-16 23:45:52.000000000 -0400
@@ -149,7 +149,7 @@ void eisa_driver_unregister (struct eisa
 	driver_unregister (&edrv->driver);
 }
 
-static ssize_t eisa_show_sig (struct device *dev, char *buf)
+static ssize_t eisa_show_sig (struct device *dev, struct device_attribute *attr, char *buf)
 {
         struct eisa_device *edev = to_eisa_device (dev);
         return sprintf (buf,"%s\n", edev->id.sig);
@@ -157,7 +157,7 @@ static ssize_t eisa_show_sig (struct dev
 
 static DEVICE_ATTR(signature, S_IRUGO, eisa_show_sig, NULL);
 
-static ssize_t eisa_show_state (struct device *dev, char *buf)
+static ssize_t eisa_show_state (struct device *dev, struct device_attribute *attr, char *buf)
 {
         struct eisa_device *edev = to_eisa_device (dev);
         return sprintf (buf,"%d\n", edev->state & EISA_CONFIG_ENABLED);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/adm1021.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/adm1021.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/adm1021.c	2005-05-16 20:35:33.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/adm1021.c	2005-05-16 23:45:52.000000000 -0400
@@ -137,7 +137,7 @@ static struct i2c_driver adm1021_driver 
 };
 
 #define show(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)		\
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct adm1021_data *data = adm1021_update_device(dev);		\
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value));	\
@@ -150,7 +150,7 @@ show(remote_temp_hyst);
 show(remote_temp_input);
 
 #define show2(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)		\
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct adm1021_data *data = adm1021_update_device(dev);		\
 	return sprintf(buf, "%d\n", data->value);			\
@@ -159,7 +159,7 @@ show2(alarms);
 show2(die_code);
 
 #define set(value, reg)	\
-static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
 {								\
 	struct i2c_client *client = to_i2c_client(dev);		\
 	struct adm1021_data *data = i2c_get_clientdata(client);	\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/adm1025.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/adm1025.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/adm1025.c	2005-05-16 20:35:33.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/adm1025.c	2005-05-16 23:45:52.000000000 -0400
@@ -153,19 +153,19 @@ struct adm1025_data {
  */
 
 #define show_in(offset) \
-static ssize_t show_in##offset(struct device *dev, char *buf) \
+static ssize_t show_in##offset(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct adm1025_data *data = adm1025_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
 		       in_scale[offset])); \
 } \
-static ssize_t show_in##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct adm1025_data *data = adm1025_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
 		       in_scale[offset])); \
 } \
-static ssize_t show_in##offset##_max(struct device *dev, char *buf) \
+static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct adm1025_data *data = adm1025_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
@@ -180,17 +180,17 @@ show_in(4);
 show_in(5);
 
 #define show_temp(offset) \
-static ssize_t show_temp##offset(struct device *dev, char *buf) \
+static ssize_t show_temp##offset(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct adm1025_data *data = adm1025_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct adm1025_data *data = adm1025_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[offset-1])); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, char *buf) \
+static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct adm1025_data *data = adm1025_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[offset-1])); \
@@ -200,7 +200,7 @@ show_temp(1);
 show_temp(2);
 
 #define set_in(offset) \
-static ssize_t set_in##offset##_min(struct device *dev, const char *buf, \
+static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -214,7 +214,7 @@ static ssize_t set_in##offset##_min(stru
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_in##offset##_max(struct device *dev, const char *buf, \
+static ssize_t set_in##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -240,7 +240,7 @@ set_in(4);
 set_in(5);
 
 #define set_temp(offset) \
-static ssize_t set_temp##offset##_min(struct device *dev, const char *buf, \
+static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -254,7 +254,7 @@ static ssize_t set_temp##offset##_min(st
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_temp##offset##_max(struct device *dev, const char *buf, \
+static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -275,26 +275,26 @@ static DEVICE_ATTR(temp##offset##_max, S
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
 }
 static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
 
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
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/adm1026.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/adm1026.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/i2c/chips/adm1026.c	2005-05-16 20:35:33.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/drivers/i2c/chips/adm1026.c	2005-05-16 23:45:52.000000000 -0400
@@ -754,24 +754,24 @@ static ssize_t set_in_max(struct device 
 }
 
 #define in_reg(offset)                                                    \
-static ssize_t show_in##offset (struct device *dev, char *buf)            \
+static ssize_t show_in##offset (struct device *dev, struct device_attribute *attr, char *buf)            \
 {                                                                         \
 	return show_in(dev, buf, offset);                                 \
 }                                                                         \
-static ssize_t show_in##offset##_min (struct device *dev, char *buf)      \
+static ssize_t show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)      \
 {                                                                         \
 	return show_in_min(dev, buf, offset);                             \
 }                                                                         \
-static ssize_t set_in##offset##_min (struct device *dev,                  \
+static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr,                  \
 	const char *buf, size_t count)                                    \
 {                                                                         \
 	return set_in_min(dev, buf, count, offset);                       \
 }                                                                         \
-static ssize_t show_in##offset##_max (struct device *dev, char *buf)      \
+static ssize_t show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)      \
 {                                                                         \
 	return show_in_max(dev, buf, offset);                             \
 }                                                                         \
-static ssize_t set_in##offset##_max (struct device *dev,                  \
+static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr,                  \
 	const char *buf, size_t count)                                    \
 {                                                                         \
 	return set_in_max(dev, buf, count, offset);                       \
@@ -800,19 +800,19 @@ in_reg(13);
 in_reg(14);
 in_reg(15);
 
-static ssize_t show_in16(struct device *dev, char *buf)
+static ssize_t show_in16(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(16, data->in[16]) -
 		NEG12_OFFSET);
 }
-static ssize_t show_in16_min(struct device *dev, char *buf) 
+static ssize_t show_in16_min(struct device *dev, struct device_attribute *attr, char *buf) 
 {
 	struct adm1026_data *data = adm1026_update_device(dev); 
 	return sprintf(buf,"%d\n", INS_FROM_REG(16, data->in_min[16])
 		- NEG12_OFFSET);
 }
-static ssize_t set_in16_min(struct device *dev, const char *buf, size_t count)
+static ssize_t set_in16_min(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
@@ -824,13 +824,13 @@ static ssize_t set_in16_min(struct devic
 	up(&data->update_lock);
 	return count; 
 }
-static ssize_t show_in16_max(struct device *dev, char *buf)
+static ssize_t show_in16_max(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", INS_FROM_REG(16, data->in_max[16])
 			- NEG12_OFFSET);
 }
-static ssize_t set_in16_max(struct device *dev, const char *buf, size_t count)
+static ssize_t set_in16_max(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
@@ -880,15 +880,15 @@ static ssize_t set_fan_min(struct device
 }
 
 #define fan_offset(offset)                                                  \
-static ssize_t show_fan_##offset (struct device *dev, char *buf)            \
+static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)            \
 {                                                                           \
 	return show_fan(dev, buf, offset - 1);                              \
 }                                                                           \
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)      \
+static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)      \
 {                                                                           \
 	return show_fan_min(dev, buf, offset - 1);                          \
 }                                                                           \
-static ssize_t set_fan_##offset##_min (struct device *dev,                  \
+static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr,                  \
 	const char *buf, size_t count)                                      \
 {                                                                           \
 	return set_fan_min(dev, buf, count, offset - 1);                    \
@@ -967,11 +967,11 @@ static ssize_t set_fan_div(struct device
 }
 
 #define fan_offset_div(offset)                                          \
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)  \
+static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)  \
 {                                                                       \
 	return show_fan_div(dev, buf, offset - 1);                      \
 }                                                                       \
-static ssize_t set_fan_##offset##_div (struct device *dev,              \
+static ssize_t set_fan_##offset##_div (struct device *dev, struct device_attribute *attr,              \
 	const char *buf, size_t count)                                  \
 {                                                                       \
 	return set_fan_div(dev, buf, count, offset - 1);                \
@@ -1033,24 +1033,24 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }
 #define temp_reg(offset)                                                      \
-static ssize_t show_temp_##offset (struct device *dev, char *buf)             \
+static ssize_t show_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf)             \
 {                                                                             \
 	return show_temp(dev, buf, offset - 1);                               \
 }                                                                             \
-static ssize_t show_temp_##offset##_min (struct device *dev, char *buf)       \
+static ssize_t show_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)       \
 {                                                                             \
 	return show_temp_min(dev, buf, offset - 1);                           \
 }                                                                             \
-static ssize_t show_temp_##offset##_max (struct device *dev, char *buf)       \
+static ssize_t show_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)       \
 {                                                                             \
 	return show_temp_max(dev, buf, offset - 1);                           \
 }                                                                             \
-static ssize_t set_temp_##offset##_min (struct device *dev,                   \
+static ssize_t set_temp_##offset##_min (struct device *dev, struct device_attribute *attr,                   \
 	const char *buf, size_t count)                                        \
 {                                                                             \
 	return set_temp_min(dev, buf, count, offset - 1);                     \
 }                                                                             \
-static ssize_t set_temp_##offset##_max (struct device *dev,                   \
+static ssize_t set_temp_##offset##_max (struct device *dev, struct device_attribute *attr,                   \
 	const char *buf, size_t count)                                        \
 {                                                                             \
 	return set_temp_max(dev, buf, count, offset - 1);                     \
@@ -1087,11 +1087,11 @@ static ssize_t set_temp_offset(struct de
 }
 
 #define temp_offset_reg(offset)                                             \
-static ssize_t show_temp_##offset##_offset (struct device *dev, char *buf)  \
+static ssize_t show_temp_##offset##_offset (struct device *dev, struct device_attribute *attr, char *buf)  \
 {                                                                           \
 	return show_temp_offset(dev, buf, offset - 1);                      \
 }                                                                           \
-static ssize_t set_temp_##offset##_offset (struct device *dev,              \
+static ssize_t set_temp_##offset##_offset (struct device *dev, struct device_attribute *attr,              \
 	const char *buf, size_t count)                                      \
 {                                                                           \
 	return set_temp_offset(dev, buf, count, offset - 1);                \
@@ -1139,22 +1139,22 @@ static ssize_t set_temp_auto_point1_temp
 }
 
 #define temp_auto_point(offset)                                             \
-static ssize_t show_temp##offset##_auto_point1_temp (struct device *dev,    \
+static ssize_t show_temp##offset##_auto_point1_temp (struct device *dev, struct device_attribute *attr,    \
 	char *buf)                                                          \
 {                                                                           \
 	return show_temp_auto_point1_temp(dev, buf, offset - 1);            \
 }                                                                           \
-static ssize_t set_temp##offset##_auto_point1_temp (struct device *dev,     \
+static ssize_t set_temp##offset##_auto_point1_temp (struct device *dev, struct device_attribute *attr,     \
 	const char *buf, size_t count)                                      \
 {                                                                           \
 	return set_temp_auto_point1_temp(dev, buf, count, offset - 1);      \
 }                                                                           \
 static ssize_t show_temp##offset##_auto_point1_temp_hyst (struct device     \
-	*dev, char *buf)                                                    \
+	*dev, struct device_attribute *attr, char *buf)                                                    \
 {                                                                           \
 	return show_temp_auto_point1_temp_hyst(dev, buf, offset - 1);       \
 }                                                                           \
-static ssize_t show_temp##offset##_auto_point2_temp (struct device *dev,    \
+static ssize_t show_temp##offset##_auto_point2_temp (struct device *dev, struct device_attribute *attr,    \
 	 char *buf)                                                         \
 {                                                                           \
 	return show_temp_auto_point2_temp(dev, buf, offset - 1);            \
@@ -1171,12 +1171,12 @@ temp_auto_point(1);
 temp_auto_point(2);
 temp_auto_point(3);
 
-static ssize_t show_temp_crit_enable(struct device *dev, char *buf)
+static ssize_t show_temp_crit_enable(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", (data->config1 & CFG1_THERM_HOT) >> 4);
 }
-static ssize_t set_temp_crit_enable(struct device *dev, const char *buf,
+static ssize_t set_temp_crit_enable(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1224,11 +1224,11 @@ static ssize_t set_temp_crit(struct devi
 }
 
 #define temp_crit_reg(offset)                                             \
-static ssize_t show_temp_##offset##_crit (struct device *dev, char *buf)  \
+static ssize_t show_temp_##offset##_crit (struct device *dev, struct device_attribute *attr, char *buf)  \
 {                                                                         \
 	return show_temp_crit(dev, buf, offset - 1);                      \
 }                                                                         \
-static ssize_t set_temp_##offset##_crit (struct device *dev,              \
+static ssize_t set_temp_##offset##_crit (struct device *dev, struct device_attribute *attr,              \
 	const char *buf, size_t count)                                    \
 {                                                                         \
 	return set_temp_crit(dev, buf, count, offset - 1);                \
@@ -1240,12 +1240,12 @@ temp_crit_reg(1);
 temp_crit_reg(2);
 temp_crit_reg(3);
 
-static ssize_t show_analog_out_reg(struct device *dev, char *buf)
+static ssize_t show_analog_out_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", DAC_FROM_REG(data->analog_out));
 }
-static ssize_t set_analog_out_reg(struct device *dev, const char *buf,
+static ssize_t set_analog_out_reg(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1262,7 +1262,7 @@ static ssize_t set_analog_out_reg(struct
 static DEVICE_ATTR(analog_out, S_IRUGO | S_IWUSR, show_analog_out_reg, 
 	set_analog_out_reg);
 
-static ssize_t show_vid_reg(struct device *dev, char *buf)
+static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
@@ -1270,12 +1270,12 @@ static ssize_t show_vid_reg(struct devic
 
 static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
 
-static ssize_t show_vrm_reg(struct device *dev, char *buf)
+static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", data->vrm);
 }
-static ssize_t store_vrm_reg(struct device *dev, const char *buf,
+static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1287,7 +1287,7 @@ static ssize_t store_vrm_reg(struct devi
 
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 
-static ssize_t show_alarms_reg(struct device *dev, char *buf)
+static ssize_t show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) (data->alarms));
@@ -1295,12 +1295,12 @@ static ssize_t show_alarms_reg(struct de
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 
-static ssize_t show_alarm_mask(struct device *dev, char *buf)
+static ssize_t show_alarm_mask(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%ld\n", data->alarm_mask);
 }
-static ssize_t set_alarm_mask(struct device *dev, const char *buf,
+static ssize_t set_alarm_mask(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1331,12 +1331,12 @@ static DEVICE_ATTR(alarm_mask, S_IRUGO |
 	set_alarm_mask);
 
 
-static ssize_t show_gpio(struct device *dev, char *buf)
+static ssize_t show_gpio(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%ld\n", data->gpio);
 }
-static ssize_t set_gpio(struct device *dev, const char *buf,
+static ssize_t set_gpio(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1359,12 +1359,12 @@ static ssize_t set_gpio(struct device *d
 static DEVICE_ATTR(gpio, S_IRUGO | S_IWUSR, show_gpio, set_gpio);
 
 
-static ssize_t show_gpio_mask(struct device *dev, char *buf)
+static ssize_t show_gpio_mask(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%ld\n", data->gpio_mask);
 }
-static ssize_t set_gpio_mask(struct device *dev, const char *buf,
+static ssize_t set_gpio_mask(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1386,12 +1386,12 @@ static ssize_t set_gpio_mask(struct devi
 
 static DEVICE_ATTR(gpio_mask, S_IRUGO | S_IWUSR, show_gpio_mask, set_gpio_mask);
 
-static ssize_t show_pwm_reg(struct device *dev, char *buf)
+static ssize_t show_pwm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", PWM_FROM_REG(data->pwm1.pwm));
 }
-static ssize_t set_pwm_reg(struct device *dev, const char *buf,
+static ssize_t set_pwm_reg(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1407,12 +1407,12 @@ static ssize_t set_pwm_reg(struct device
 	}
 	return count;
 }
-static ssize_t show_auto_pwm_min(struct device *dev, char *buf)
+static ssize_t show_auto_pwm_min(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", data->pwm1.auto_pwm_min);
 }
-static ssize_t set_auto_pwm_min(struct device *dev, const char *buf,
+static ssize_t set_auto_pwm_min(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1429,16 +1429,16 @@ static ssize_t set_auto_pwm_min(struct d
 	up(&data->update_lock);
 	return count;
 }
-static ssize_t show_auto_pwm_max(struct device *dev, char *buf)
+static ssize_t show_auto_pwm_max(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf,"%d\n", ADM1026_PWM_MAX);
 }
-static ssize_t show_pwm_enable(struct device *dev, char *buf)
+static ssize_t show_pwm_enable(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", data->pwm1.enable);
 }
-static ssize_t set_pwm_enable(struct device *dev, const char *buf,
+static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);



------=_Part_264_2162443.1116326472088--
