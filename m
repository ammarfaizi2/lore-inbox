Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVENKBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVENKBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVENKBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:01:25 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:51874 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262725AbVENJd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:33:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=qCnJeVLtqIhaU2bR0DC+24akkRY72HBJ40L0Syd9OUR5ee4F4f5dq2GK1gDyXaZv3MKqb+Fw3FoDv6M6rdZB9qwNuA1fiTWNmm/gOYc9jyzcWbxxTOhVY1BZBVLilvc9wgZG8+lYS7HQsFEPYzKDJSBhlsVQQoomG/umqPqj0vA=
Message-ID: <253818670505140233fb87650@mail.gmail.com>
Date: Sat, 14 May 2005 05:33:26 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 11/12] drivers/usb/misc/cytherm.c - drivers/zorro/zorro-sysfs.c: (dynamic sysfs callbacks) update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1451_3438471.1116063206441"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1451_3438471.1116063206441
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_1451_3438471.1116063206441
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.7.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.7.diff.diffstat.txt"

 usb/misc/cytherm.c      |   20 ++++++++++----------
 usb/misc/phidgetkit.c   |   14 +++++++-------
 usb/misc/phidgetservo.c |    4 ++--
 usb/misc/usbled.c       |    4 ++--
 usb/serial/ftdi_sio.c   |    6 +++---
 usb/storage/scsiglue.c  |    4 ++--
 video/gbefb.c           |    4 ++--
 video/w100fb.c          |   12 ++++++------
 w1/w1.c                 |   16 ++++++++--------
 w1/w1_family.h          |    4 ++--
 w1/w1_smem.c            |    8 ++++----
 w1/w1_therm.c           |    8 ++++----
 zorro/zorro-sysfs.c     |    4 ++--
 13 files changed, 54 insertions(+), 54 deletions(-)

------=_Part_1451_3438471.1116063206441
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.7.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-drivers.diff.7.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/misc/cytherm.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/misc/cytherm.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/misc/cytherm.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/misc/cytherm.c	2005-05-11 00:32:50.000000000 -0400
@@ -85,7 +85,7 @@ static int vendor_command(struct usb_dev
 #define BRIGHTNESS 0x2c     /* RAM location for brightness value */
 #define BRIGHTNESS_SEM 0x2b /* RAM location for brightness semaphore */
 
-static ssize_t show_brightness(struct device *dev, char *buf)
+static ssize_t show_brightness(struct device *dev, char *buf, void *private)
 {
 	struct usb_interface *intf = to_usb_interface(dev);    
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);     
@@ -94,7 +94,7 @@ static ssize_t show_brightness(struct de
 }
 
 static ssize_t set_brightness(struct device *dev, const char *buf, 
-			      size_t count)
+			      size_t count, void *private)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
@@ -138,7 +138,7 @@ static DEVICE_ATTR(brightness, S_IRUGO |
 #define TEMP 0x33 /* RAM location for temperature */
 #define SIGN 0x34 /* RAM location for temperature sign */
 
-static ssize_t show_temp(struct device *dev, char *buf)
+static ssize_t show_temp(struct device *dev, char *buf, void *private)
 {
 
 	struct usb_interface *intf = to_usb_interface(dev);
@@ -174,7 +174,7 @@ static ssize_t show_temp(struct device *
 }
 
 
-static ssize_t set_temp(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp(struct device *dev, const char *buf, size_t count, void *private)
 {
 	return count;
 }
@@ -184,7 +184,7 @@ static DEVICE_ATTR(temp, S_IRUGO, show_t
 
 #define BUTTON 0x7a
 
-static ssize_t show_button(struct device *dev, char *buf)
+static ssize_t show_button(struct device *dev, char *buf, void *private)
 {
 
 	struct usb_interface *intf = to_usb_interface(dev);
@@ -215,7 +215,7 @@ static ssize_t show_button(struct device
 }
 
 
-static ssize_t set_button(struct device *dev, const char *buf, size_t count)
+static ssize_t set_button(struct device *dev, const char *buf, size_t count, void *private)
 {
 	return count;
 }
@@ -223,7 +223,7 @@ static ssize_t set_button(struct device 
 static DEVICE_ATTR(button, S_IRUGO, show_button, set_button);
 
 
-static ssize_t show_port0(struct device *dev, char *buf)
+static ssize_t show_port0(struct device *dev, char *buf, void *private)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
@@ -249,7 +249,7 @@ static ssize_t show_port0(struct device 
 }
 
 
-static ssize_t set_port0(struct device *dev, const char *buf, size_t count)
+static ssize_t set_port0(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
@@ -283,7 +283,7 @@ static ssize_t set_port0(struct device *
 
 static DEVICE_ATTR(port0, S_IRUGO | S_IWUSR | S_IWGRP, show_port0, set_port0);
 
-static ssize_t show_port1(struct device *dev, char *buf)
+static ssize_t show_port1(struct device *dev, char *buf, void *private)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
@@ -309,7 +309,7 @@ static ssize_t show_port1(struct device 
 }
 
 
-static ssize_t set_port1(struct device *dev, const char *buf, size_t count)
+static ssize_t set_port1(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/misc/phidgetkit.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/misc/phidgetkit.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/misc/phidgetkit.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/misc/phidgetkit.c	2005-05-11 00:32:50.000000000 -0400
@@ -173,7 +173,7 @@ exit:
 }
 
 #define set_lcd_line(number)	\
-static ssize_t lcd_line_##number(struct device *dev, const char *buf, size_t count)	\
+static ssize_t lcd_line_##number(struct device *dev, const char *buf, size_t count, void *private)	\
 {											\
 	struct usb_interface *intf = to_usb_interface(dev);				\
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);			\
@@ -184,7 +184,7 @@ static DEVICE_ATTR(lcd_line_##number, S_
 set_lcd_line(1);
 set_lcd_line(2);
 
-static ssize_t set_backlight(struct device *dev, const char *buf, size_t count)
+static ssize_t set_backlight(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);
@@ -232,7 +232,7 @@ static void remove_lcd_files(struct phid
 	}
 }
 
-static ssize_t enable_lcd_files(struct device *dev, const char *buf, size_t count)
+static ssize_t enable_lcd_files(struct device *dev, const char *buf, size_t count, void *private)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);
@@ -308,7 +308,7 @@ resubmit:
 
 #define show_set_output(value)		\
 static ssize_t set_output##value(struct device *dev, const char *buf, 	\
-							size_t count)	\
+							size_t count, void *private)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);	\
@@ -324,7 +324,7 @@ static ssize_t set_output##value(struct 
 	return retval ? retval : count;					\
 }									\
 									\
-static ssize_t show_output##value(struct device *dev, char *buf)	\
+static ssize_t show_output##value(struct device *dev, char *buf, void *private)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);	\
@@ -343,7 +343,7 @@ show_set_output(7);
 show_set_output(8);	/* should be MAX_INTERFACES - 1 */
 
 #define show_input(value)	\
-static ssize_t show_input##value(struct device *dev, char *buf)	\
+static ssize_t show_input##value(struct device *dev, char *buf, void *private)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);	\
@@ -362,7 +362,7 @@ show_input(7);
 show_input(8);		/* should be MAX_INTERFACES - 1 */
 
 #define show_sensor(value)	\
-static ssize_t show_sensor##value(struct device *dev, char *buf)	\
+static ssize_t show_sensor##value(struct device *dev, char *buf, void *private)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);	\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/misc/phidgetservo.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/misc/phidgetservo.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/misc/phidgetservo.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/misc/phidgetservo.c	2005-05-11 00:32:51.000000000 -0400
@@ -208,7 +208,7 @@ change_position_v20(struct phidget_servo
 
 #define show_set(value)	\
 static ssize_t set_servo##value (struct device *dev,			\
-					const char *buf, size_t count)	\
+					const char *buf, size_t count, void *private)	\
 {									\
 	int degrees, minutes, retval;					\
 	struct usb_interface *intf = to_usb_interface (dev);		\
@@ -233,7 +233,7 @@ static ssize_t set_servo##value (struct 
 	return retval < 0 ? retval : count;				\
 }									\
 									\
-static ssize_t show_servo##value (struct device *dev, char *buf) 	\
+static ssize_t show_servo##value (struct device *dev, char *buf, void *private) 	\
 {									\
 	struct usb_interface *intf = to_usb_interface (dev);		\
 	struct phidget_servo *servo = usb_get_intfdata (intf);		\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/misc/usbled.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/misc/usbled.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/misc/usbled.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/misc/usbled.c	2005-05-11 00:32:51.000000000 -0400
@@ -81,14 +81,14 @@ static void change_color(struct usb_led 
 }
 
 #define show_set(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)		\
+static ssize_t show_##value(struct device *dev, char *buf, void *private)		\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct usb_led *led = usb_get_intfdata(intf);			\
 									\
 	return sprintf(buf, "%d\n", led->value);			\
 }									\
-static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+static ssize_t set_##value(struct device *dev, const char *buf, size_t count, void *private)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct usb_led *led = usb_get_intfdata(intf);			\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/serial/ftdi_sio.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/serial/ftdi_sio.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/serial/ftdi_sio.c	2005-05-11 00:32:57.000000000 -0400
@@ -1213,7 +1213,7 @@ check_and_exit:
  * ***************************************************************************
  */
 
-static ssize_t show_latency_timer(struct device *dev, char *buf)
+static ssize_t show_latency_timer(struct device *dev, char *buf, void *private)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -1241,7 +1241,7 @@ static ssize_t show_latency_timer(struct
 
 /* Write a new value of the latency timer, in units of milliseconds. */
 static ssize_t store_latency_timer(struct device *dev, const char *valbuf,
-				   size_t count)
+				   size_t count, void *private)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -1272,7 +1272,7 @@ static ssize_t store_latency_timer(struc
 /* Write an event character directly to the FTDI register.  The ASCII
    value is in the low 8 bits, with the enable bit in the 9th bit. */
 static ssize_t store_event_char(struct device *dev, const char *valbuf,
-				size_t count)
+				size_t count, void *private)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/storage/scsiglue.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/storage/scsiglue.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/usb/storage/scsiglue.c	2005-05-11 00:28:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/usb/storage/scsiglue.c	2005-05-11 00:32:55.000000000 -0400
@@ -407,7 +407,7 @@ US_DO_ALL_FLAGS
  ***********************************************************************/
 
 /* Output routine for the sysfs max_sectors file */
-static ssize_t show_max_sectors(struct device *dev, char *buf)
+static ssize_t show_max_sectors(struct device *dev, char *buf, void *private)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 
@@ -416,7 +416,7 @@ static ssize_t show_max_sectors(struct d
 
 /* Input routine for the sysfs max_sectors file */
 static ssize_t store_max_sectors(struct device *dev, const char *buf,
-		size_t count)
+		size_t count, void *private)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	unsigned short ms;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/video/gbefb.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/video/gbefb.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/video/gbefb.c	2005-05-11 00:28:12.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/video/gbefb.c	2005-05-11 00:33:41.000000000 -0400
@@ -1045,14 +1045,14 @@ static struct fb_ops gbefb_ops = {
  * sysfs
  */
 
-static ssize_t gbefb_show_memsize(struct device *dev, char *buf)
+static ssize_t gbefb_show_memsize(struct device *dev, char *buf, void *private)
 {
 	return snprintf(buf, PAGE_SIZE, "%d\n", gbe_mem_size);
 }
 
 static DEVICE_ATTR(size, S_IRUGO, gbefb_show_memsize, NULL);
 
-static ssize_t gbefb_show_rev(struct device *device, char *buf)
+static ssize_t gbefb_show_rev(struct device *device, char *buf, void *private)
 {
 	return snprintf(buf, PAGE_SIZE, "%d\n", gbe_revision);
 }
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/video/w100fb.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/video/w100fb.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/video/w100fb.c	2005-05-11 00:28:12.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/video/w100fb.c	2005-05-11 00:33:42.000000000 -0400
@@ -101,7 +101,7 @@ static void(*w100fb_ssp_send)(u8 adrs, u
  * Sysfs functions
  */
 
-static ssize_t rotation_show(struct device *dev, char *buf)
+static ssize_t rotation_show(struct device *dev, char *buf, void *private)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
@@ -109,7 +109,7 @@ static ssize_t rotation_show(struct devi
 	return sprintf(buf, "%d\n",par->rotation_flag);
 }
 
-static ssize_t rotation_store(struct device *dev, const char *buf, size_t count)
+static ssize_t rotation_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	unsigned int rotate;
 	struct fb_info *info = dev_get_drvdata(dev);
@@ -134,7 +134,7 @@ static ssize_t rotation_store(struct dev
 
 static DEVICE_ATTR(rotation, 0644, rotation_show, rotation_store);
 
-static ssize_t w100fb_reg_read(struct device *dev, const char *buf, size_t count)
+static ssize_t w100fb_reg_read(struct device *dev, const char *buf, size_t count, void *private)
 {
 	unsigned long param;
 	unsigned long regs;
@@ -146,7 +146,7 @@ static ssize_t w100fb_reg_read(struct de
 
 static DEVICE_ATTR(reg_read, 0200, NULL, w100fb_reg_read);
 
-static ssize_t w100fb_reg_write(struct device *dev, const char *buf, size_t count)
+static ssize_t w100fb_reg_write(struct device *dev, const char *buf, size_t count, void *private)
 {
 	unsigned long regs;
 	unsigned long param;
@@ -163,7 +163,7 @@ static ssize_t w100fb_reg_write(struct d
 static DEVICE_ATTR(reg_write, 0200, NULL, w100fb_reg_write);
 
 
-static ssize_t fastsysclk_show(struct device *dev, char *buf)
+static ssize_t fastsysclk_show(struct device *dev, char *buf, void *private)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
@@ -171,7 +171,7 @@ static ssize_t fastsysclk_show(struct de
 	return sprintf(buf, "%d\n",par->fastsysclk_mode);
 }
 
-static ssize_t fastsysclk_store(struct device *dev, const char *buf, size_t count)
+static ssize_t fastsysclk_store(struct device *dev, const char *buf, size_t count, void *private)
 {
 	int param;
 	struct fb_info *info = dev_get_drvdata(dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/w1/w1.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/w1/w1.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/w1/w1.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/w1/w1.c	2005-05-11 00:32:21.000000000 -0400
@@ -88,7 +88,7 @@ static void w1_slave_release(struct devi
 	complete(&sl->dev_released);
 }
 
-static ssize_t w1_default_read_name(struct device *dev, char *buf)
+static ssize_t w1_default_read_name(struct device *dev, char *buf, void *private)
 {
 	return sprintf(buf, "No family registered.\n");
 }
@@ -137,7 +137,7 @@ static struct device_attribute w1_slave_
 	.show = &w1_default_read_name,
 };
 
-static ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_name(struct device *dev, char *buf, void *private)
 {
 	struct w1_master *md = container_of (dev, struct w1_master, dev);
 	ssize_t count;
@@ -152,7 +152,7 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf, void *private)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -166,14 +166,14 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf, void *private)
 {
 	ssize_t count;
 	count = sprintf(buf, "%d\n", w1_timeout);
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf, void *private)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -187,7 +187,7 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf, void *private)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -201,7 +201,7 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *buf, void *private)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -215,7 +215,7 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf, void *private)
 
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/w1/w1_family.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/w1/w1_family.h
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/w1/w1_family.h	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/w1/w1_family.h	2005-05-11 00:45:26.000000000 -0400
@@ -34,10 +34,10 @@
 
 struct w1_family_ops
 {
-	ssize_t (* rname)(struct device *, char *);
+	ssize_t (* rname)(struct device *, char *, void *);
 	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
 	
-	ssize_t (* rval)(struct device *, char *);
+	ssize_t (* rval)(struct device *, char *, void *);
 	unsigned char rvalname[MAXNAMELEN];
 };
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/w1/w1_smem.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/w1/w1_smem.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/w1/w1_smem.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/w1/w1_smem.c	2005-05-11 00:32:22.000000000 -0400
@@ -36,8 +36,8 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit memory family.");
 
-static ssize_t w1_smem_read_name(struct device *, char *);
-static ssize_t w1_smem_read_val(struct device *, char *);
+static ssize_t w1_smem_read_name(struct device *, char *, void *private);
+static ssize_t w1_smem_read_val(struct device *, char *, void *private);
 static ssize_t w1_smem_read_bin(struct kobject *, char *, loff_t, size_t);
 
 static struct w1_family_ops w1_smem_fops = {
@@ -47,14 +47,14 @@ static struct w1_family_ops w1_smem_fops
 	.rvalname = "id",
 };
 
-static ssize_t w1_smem_read_name(struct device *dev, char *buf)
+static ssize_t w1_smem_read_name(struct device *dev, char *buf, void *private)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 
 	return sprintf(buf, "%s\n", sl->name);
 }
 
-static ssize_t w1_smem_read_val(struct device *dev, char *buf)
+static ssize_t w1_smem_read_val(struct device *dev, char *buf, void *private)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 	int i;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/w1/w1_therm.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/w1/w1_therm.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/w1/w1_therm.c	2005-05-11 00:28:08.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/w1/w1_therm.c	2005-05-11 00:32:22.000000000 -0400
@@ -42,8 +42,8 @@ static u8 bad_roms[][9] = {
 				{}
 			};
 
-static ssize_t w1_therm_read_name(struct device *, char *);
-static ssize_t w1_therm_read_temp(struct device *, char *);
+static ssize_t w1_therm_read_name(struct device *, char *, void *private);
+static ssize_t w1_therm_read_temp(struct device *, char *, void *private);
 static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
 
 static struct w1_family_ops w1_therm_fops = {
@@ -53,7 +53,7 @@ static struct w1_family_ops w1_therm_fop
 	.rvalname = "temp1_input",
 };
 
-static ssize_t w1_therm_read_name(struct device *dev, char *buf)
+static ssize_t w1_therm_read_name(struct device *dev, char *buf, void *private)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 
@@ -77,7 +77,7 @@ static inline int w1_convert_temp(u8 rom
 	return t;
 }
 
-static ssize_t w1_therm_read_temp(struct device *dev, char *buf)
+static ssize_t w1_therm_read_temp(struct device *dev, char *buf, void *private)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/zorro/zorro-sysfs.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/zorro/zorro-sysfs.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/zorro/zorro-sysfs.c	2005-05-11 00:28:12.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/drivers/zorro/zorro-sysfs.c	2005-05-11 00:33:43.000000000 -0400
@@ -21,7 +21,7 @@
 /* show configuration fields */
 #define zorro_config_attr(name, field, format_string)			\
 static ssize_t								\
-show_##name(struct device *dev, char *buf)				\
+show_##name(struct device *dev, char *buf, void *private)				\
 {									\
 	struct zorro_dev *z;						\
 									\
@@ -36,7 +36,7 @@ zorro_config_attr(serial, rom.er_SerialN
 zorro_config_attr(slotaddr, slotaddr, "0x%04x\n");
 zorro_config_attr(slotsize, slotsize, "0x%04x\n");
 
-static ssize_t zorro_show_resource(struct device *dev, char *buf)
+static ssize_t zorro_show_resource(struct device *dev, char *buf, void *private)
 {
 	struct zorro_dev *z = to_zorro_dev(dev);
 

------=_Part_1451_3438471.1116063206441--
