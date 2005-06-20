Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVFUCvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVFUCvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVFUCsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:48:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:20708 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261678AbVFTW7l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:41 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Remove the unused device_find().
In-Reply-To: <11193083653772@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:25 -0700
Message-Id: <11193083653286@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Remove the unused device_find().

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit cb85b6f1cc811ecb9ed4b950206d8941ba710e68
tree f017c851e25078c8445ec7045556eb41e364ffdb
parent 94e7b1c5ff2055571703e38b059afffe17658432
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 10:48:35 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:16 -0700

 drivers/base/core.c    |   19 -------------------
 include/linux/device.h |    1 -
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -401,24 +401,6 @@ int device_for_each_child(struct device 
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
@@ -434,7 +416,6 @@ EXPORT_SYMBOL_GPL(device_del);
 EXPORT_SYMBOL_GPL(device_unregister);
 EXPORT_SYMBOL_GPL(get_device);
 EXPORT_SYMBOL_GPL(put_device);
-EXPORT_SYMBOL_GPL(device_find);
 
 EXPORT_SYMBOL_GPL(device_create_file);
 EXPORT_SYMBOL_GPL(device_remove_file);
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -372,7 +372,6 @@ extern int (*platform_notify_remove)(str
  */
 extern struct device * get_device(struct device * dev);
 extern void put_device(struct device * dev);
-extern struct device *device_find(const char *name, struct bus_type *bus);
 
 
 /* drivers/base/platform.c */

