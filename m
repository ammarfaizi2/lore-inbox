Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUATBSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUATBRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:17:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:25033 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265334AbUATBMh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:37 -0500
Subject: Re: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <10745611583988@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:39 -0800
Message-Id: <1074561159715@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496, 2004/01/19 16:31:36-08:00, hollisb@us.ibm.com

[PATCH] Driver Core: add device_find() function

Greg KH wrote:
>
> How about just adding a device_find() function to the driver core, where
> you pass in a name and a type, so that others can use it?

Something like this?


 drivers/base/core.c    |    9 +++++++++
 include/linux/device.h |    1 +
 2 files changed, 10 insertions(+)


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Mon Jan 19 17:05:19 2004
+++ b/drivers/base/core.c	Mon Jan 19 17:05:19 2004
@@ -400,6 +400,14 @@
 	return error;
 }
 
+struct device *device_find(const char *name, struct bus_type *bus)
+{
+	struct kobject *k = kset_find_obj(&bus->devices, name);
+	if (k)
+		return to_dev(k);
+	return NULL;
+}
+
 int __init devices_init(void)
 {
 	return subsystem_register(&devices_subsys);
@@ -416,6 +424,7 @@
 EXPORT_SYMBOL(device_unregister_wait);
 EXPORT_SYMBOL(get_device);
 EXPORT_SYMBOL(put_device);
+EXPORT_SYMBOL(device_find);
 
 EXPORT_SYMBOL(device_create_file);
 EXPORT_SYMBOL(device_remove_file);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Mon Jan 19 17:05:19 2004
+++ b/include/linux/device.h	Mon Jan 19 17:05:19 2004
@@ -354,6 +354,7 @@
  */
 extern struct device * get_device(struct device * dev);
 extern void put_device(struct device * dev);
+extern struct device *device_find(const char *name, struct bus_type *bus);
 
 
 /* drivers/base/platform.c */

