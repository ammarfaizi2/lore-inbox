Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVD2G15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVD2G15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 02:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVD2G15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 02:27:57 -0400
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:12895 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262436AbVD2G1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 02:27:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5 (take 2)] sysfs: (driver/base) if show/store is missing return -EIO
Date: Fri, 29 Apr 2005 01:23:47 -0500
User-Agent: KMail/1.8
Cc: Robert Love <rml@novell.com>, Greg KH <gregkh@suse.de>,
       Jean Delvare <khali@linux-fr.org>
References: <200504280030.10214.dtor_core@ameritech.net> <1114710135.6682.60.camel@betsy> <200504290122.00679.dtor_core@ameritech.net>
In-Reply-To: <200504290122.00679.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504290123.47820.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs: fix drivers/base so if an attribute doesn't implement
       show or store method read/write will return -EIO
       instead of 0.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 bus.c   |    4 ++--
 class.c |    4 ++--
 core.c  |    4 ++--
 sys.c   |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

Index: dtor/drivers/base/class.c
===================================================================
--- dtor.orig/drivers/base/class.c
+++ dtor/drivers/base/class.c
@@ -26,7 +26,7 @@ class_attr_show(struct kobject * kobj, s
 {
 	struct class_attribute * class_attr = to_class_attr(attr);
 	struct class * dc = to_class(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (class_attr->show)
 		ret = class_attr->show(dc, buf);
@@ -39,7 +39,7 @@ class_attr_store(struct kobject * kobj, 
 {
 	struct class_attribute * class_attr = to_class_attr(attr);
 	struct class * dc = to_class(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (class_attr->store)
 		ret = class_attr->store(dc, buf, count);
Index: dtor/drivers/base/sys.c
===================================================================
--- dtor.orig/drivers/base/sys.c
+++ dtor/drivers/base/sys.c
@@ -37,7 +37,7 @@ sysdev_show(struct kobject * kobj, struc
 
 	if (sysdev_attr->show)
 		return sysdev_attr->show(sysdev, buffer);
-	return 0;
+	return -EIO;
 }
 
 
@@ -50,7 +50,7 @@ sysdev_store(struct kobject * kobj, stru
 
 	if (sysdev_attr->store)
 		return sysdev_attr->store(sysdev, buffer, count);
-	return 0;
+	return -EIO;
 }
 
 static struct sysfs_ops sysfs_ops = {
Index: dtor/drivers/base/bus.c
===================================================================
--- dtor.orig/drivers/base/bus.c
+++ dtor/drivers/base/bus.c
@@ -36,7 +36,7 @@ drv_attr_show(struct kobject * kobj, str
 {
 	struct driver_attribute * drv_attr = to_drv_attr(attr);
 	struct device_driver * drv = to_driver(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (drv_attr->show)
 		ret = drv_attr->show(drv, buf);
@@ -49,7 +49,7 @@ drv_attr_store(struct kobject * kobj, st
 {
 	struct driver_attribute * drv_attr = to_drv_attr(attr);
 	struct device_driver * drv = to_driver(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (drv_attr->store)
 		ret = drv_attr->store(drv, buf, count);
Index: dtor/drivers/base/core.c
===================================================================
--- dtor.orig/drivers/base/core.c
+++ dtor/drivers/base/core.c
@@ -38,7 +38,7 @@ dev_attr_show(struct kobject * kobj, str
 {
 	struct device_attribute * dev_attr = to_dev_attr(attr);
 	struct device * dev = to_dev(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (dev_attr->show)
 		ret = dev_attr->show(dev, buf);
@@ -51,7 +51,7 @@ dev_attr_store(struct kobject * kobj, st
 {
 	struct device_attribute * dev_attr = to_dev_attr(attr);
 	struct device * dev = to_dev(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (dev_attr->store)
 		ret = dev_attr->store(dev, buf, count);
