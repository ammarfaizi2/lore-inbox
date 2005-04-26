Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVDZHgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVDZHgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVDZHfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:35:44 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:44705 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261400AbVDZHeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:34:18 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] make driver's name be const char *
Date: Tue, 26 Apr 2005 02:34:05 -0500
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>
References: <200504260229.03866.dtor_core@ameritech.net>
In-Reply-To: <200504260229.03866.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504260234.05750.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver core:
  change driver's, bus's, class's and platform device's names
  to be const char * so one can use
            const char *drv_name = "asdfg";
  when initializing structures.
  Also kill couple of whitespaces.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/core/devices.c |    2 +-
 include/linux/device.h     |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

Index: dtor/include/linux/device.h
===================================================================
--- dtor.orig/include/linux/device.h
+++ dtor/include/linux/device.h
@@ -47,7 +47,7 @@ struct class_device;
 struct class_simple;
 
 struct bus_type {
-	char			* name;
+	const char		* name;
 
 	struct subsystem	subsys;
 	struct kset		drivers;
@@ -98,17 +98,17 @@ extern int bus_create_file(struct bus_ty
 extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
 
 struct device_driver {
-	char			* name;
+	const char		* name;
 	struct bus_type		* bus;
 
 	struct completion	unloaded;
 	struct kobject		kobj;
 	struct list_head	devices;
 
-	struct module 		* owner;
+	struct module		* owner;
 
 	int	(*probe)	(struct device * dev);
-	int 	(*remove)	(struct device * dev);
+	int	(*remove)	(struct device * dev);
 	void	(*shutdown)	(struct device * dev);
 	int	(*suspend)	(struct device * dev, pm_message_t state, u32 level);
 	int	(*resume)	(struct device * dev, u32 level);
@@ -142,7 +142,7 @@ extern void driver_remove_file(struct de
  * device classes
  */
 struct class {
-	char			* name;
+	const char		* name;
 
 	struct subsystem	subsys;
 	struct list_head	children;
@@ -369,7 +369,7 @@ extern struct device *device_find(const 
 /* drivers/base/platform.c */
 
 struct platform_device {
-	char		* name;
+	const char	* name;
 	u32		id;
 	struct device	dev;
 	u32		num_resources;
Index: dtor/drivers/usb/core/devices.c
===================================================================
--- dtor.orig/drivers/usb/core/devices.c
+++ dtor/drivers/usb/core/devices.c
@@ -239,7 +239,7 @@ static char *usb_dump_interface_descript
 	int setno)
 {
 	const struct usb_interface_descriptor *desc = &intfc->altsetting[setno].desc;
-	char *driver_name = "";
+	const char *driver_name = "";
 
 	if (start > end)
 		return start;
