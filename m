Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVCYFyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVCYFyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVCYFyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:54:44 -0500
Received: from digitalimplant.org ([64.62.235.95]:64466 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261366AbVCYFyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:35 -0500
Date: Thu, 24 Mar 2005 21:54:28 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [1/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242149310.18863-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2239, 2005-03-24 10:48:35-08:00, mochel@digitalimplant.org
  [driver core] Remove the unused device_find().


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2005-03-24 20:34:00 -08:00
+++ b/drivers/base/core.c	2005-03-24 20:34:00 -08:00
@@ -401,24 +401,6 @@
 	return error;
 }

-/**
- *	device_find - locate device on a bus by name.
- *	@name:	name of the device.
- *	@bus:	bus to scan for the device.
- *
- *	Call kset_find_obj() to iterate over list of devices on
- *	a bus to find device by name. Return device if found.
- *
- *	Note that kset_find_obj increments device's reference count.
- */
-struct device *device_find(const char *name, struct bus_type *bus)
-{
-	struct kobject *k = kset_find_obj(&bus->devices, name);
-	if (k)
-		return to_dev(k);
-	return NULL;
-}
-
 int __init devices_init(void)
 {
 	return subsystem_register(&devices_subsys);
@@ -434,7 +416,6 @@
 EXPORT_SYMBOL_GPL(device_unregister);
 EXPORT_SYMBOL_GPL(get_device);
 EXPORT_SYMBOL_GPL(put_device);
-EXPORT_SYMBOL_GPL(device_find);

 EXPORT_SYMBOL_GPL(device_create_file);
 EXPORT_SYMBOL_GPL(device_remove_file);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-24 20:34:00 -08:00
+++ b/include/linux/device.h	2005-03-24 20:34:00 -08:00
@@ -376,7 +376,6 @@
  */
 extern struct device * get_device(struct device * dev);
 extern void put_device(struct device * dev);
-extern struct device *device_find(const char *name, struct bus_type *bus);


 /* drivers/base/platform.c */
