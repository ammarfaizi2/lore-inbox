Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVFUByV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVFUByV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVFTX7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:59:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:53988 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261783AbVFTXAA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:00 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] make driver's name be const char *
In-Reply-To: <1119308361783@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:21 -0700
Message-Id: <11193083613036@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] make driver's name be const char *

Driver core:
  change driver's, bus's, class's and platform device's names
  to be const char * so one can use
            const char *drv_name = "asdfg";
  when initializing structures.
  Also kill couple of whitespaces.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8d790d74085833ba2a3e84b5bcd683be4981c29a
tree fe3be944882cb1ec272e4fb6782c6caa404a6187
parent 419cab3fc69588ebe35b845cc3a584ae172463de
author Dmitry Torokhov <dtor_core@ameritech.net> Tue, 26 Apr 2005 02:34:05 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:01 -0700

 drivers/usb/core/devices.c |    2 +-
 include/linux/device.h     |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -239,7 +239,7 @@ static char *usb_dump_interface_descript
 	int setno)
 {
 	const struct usb_interface_descriptor *desc = &intfc->altsetting[setno].desc;
-	char *driver_name = "";
+	const char *driver_name = "";
 
 	if (start > end)
 		return start;
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
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
@@ -366,7 +366,7 @@ extern struct device *device_find(const 
 /* drivers/base/platform.c */
 
 struct platform_device {
-	char		* name;
+	const char	* name;
 	u32		id;
 	struct device	dev;
 	u32		num_resources;

