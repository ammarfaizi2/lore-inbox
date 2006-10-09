Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWJIJNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWJIJNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWJIJNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:13:09 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:24571 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S1751662AbWJIJNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:13:07 -0400
Date: Mon, 9 Oct 2006 18:13:23 +0900
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] driver core: warn unused return value for internal functions
Message-ID: <20061009091323.GA6503@localhost>
Mail-Followup-To: akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: akinobu.mita@gmail.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds __must_check attribute to driver core internal functions
(drivers/base/base.h)

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/base/base.h |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

Index: work-fault-inject/drivers/base/base.h
===================================================================
--- work-fault-inject.orig/drivers/base/base.h	2006-10-09 15:06:23.000000000 +0900
+++ work-fault-inject/drivers/base/base.h	2006-10-09 15:09:30.000000000 +0900
@@ -1,35 +1,36 @@
+#include <linux/compiler.h>
 
 /* initialisation functions */
 
-extern int devices_init(void);
-extern int buses_init(void);
-extern int classes_init(void);
-extern int firmware_init(void);
+extern int __must_check devices_init(void);
+extern int __must_check buses_init(void);
+extern int __must_check classes_init(void);
+extern int __must_check firmware_init(void);
 #ifdef CONFIG_SYS_HYPERVISOR
-extern int hypervisor_init(void);
+extern int __must_check hypervisor_init(void);
 #else
 static inline int hypervisor_init(void) { return 0; }
 #endif
-extern int platform_bus_init(void);
-extern int system_bus_init(void);
-extern int cpu_dev_init(void);
-extern int attribute_container_init(void);
+extern int __must_check platform_bus_init(void);
+extern int __must_check system_bus_init(void);
+extern int __must_check cpu_dev_init(void);
+extern int __must_check attribute_container_init(void);
 
-extern int bus_add_device(struct device * dev);
-extern int bus_attach_device(struct device * dev);
+extern int __must_check bus_add_device(struct device * dev);
+extern int __must_check bus_attach_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 extern struct bus_type *get_bus(struct bus_type * bus);
 extern void put_bus(struct bus_type * bus);
 
-extern int bus_add_driver(struct device_driver *);
+extern int __must_check bus_add_driver(struct device_driver *);
 extern void bus_remove_driver(struct device_driver *);
 
 extern void driver_detach(struct device_driver * drv);
-extern int driver_probe_device(struct device_driver *, struct device *);
+extern int __must_check driver_probe_device(struct device_driver *, struct device *);
 
 extern void sysdev_shutdown(void);
-extern int sysdev_suspend(pm_message_t state);
-extern int sysdev_resume(void);
+extern int __must_check sysdev_suspend(pm_message_t state);
+extern int __must_check sysdev_resume(void);
 
 static inline struct class_device *to_class_dev(struct kobject *obj)
 {
