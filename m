Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUF1FnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUF1FnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbUF1Fmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:42:36 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:14458 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264723AbUF1F0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:26:36 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 18/19] add driver_find
Date: Mon, 28 Jun 2004 00:26:33 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280024.53717.dtor_core@ameritech.net> <200406280025.54154.dtor_core@ameritech.net>
In-Reply-To: <200406280025.54154.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280026.35503.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1792, 2004-06-27 20:49:01-05:00, dtor_core@ameritech.net
  Driver core: add driver_find helper to find a driver by its name
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/driver.c  |   16 ++++++++++++++++
 include/linux/device.h |    1 +
 2 files changed, 17 insertions(+)


===================================================================



diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2004-06-27 21:24:06 -05:00
+++ b/drivers/base/driver.c	2004-06-27 21:24:06 -05:00
@@ -111,10 +111,26 @@
 	up(&drv->unload_sem);
 }
 
+/**
+ *	driver_find - find driver on a given bus by its name.
+ *	@name:	name of the driver.
+ *	@bus:	bus to seatch for the driver
+ */
+
+struct device_driver *driver_find(const char *name, struct bus_type *bus)
+{
+	struct kobject *k = kset_find_obj(&bus->drivers, name);
+	if (k)
+		return to_drv(k);
+	return NULL;
+}
+
+
 EXPORT_SYMBOL(driver_register);
 EXPORT_SYMBOL(driver_unregister);
 EXPORT_SYMBOL(get_driver);
 EXPORT_SYMBOL(put_driver);
+EXPORT_SYMBOL(driver_find);
 
 EXPORT_SYMBOL(driver_create_file);
 EXPORT_SYMBOL(driver_remove_file);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-06-27 21:24:06 -05:00
+++ b/include/linux/device.h	2004-06-27 21:24:06 -05:00
@@ -120,6 +120,7 @@
 
 extern struct device_driver * get_driver(struct device_driver * drv);
 extern void put_driver(struct device_driver * drv);
+extern struct device_driver *driver_find(const char *name, struct bus_type *bus);
 
 
 /* driverfs interface for exporting driver attributes */
