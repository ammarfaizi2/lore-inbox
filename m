Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVFUC7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVFUC7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVFUC5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:57:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:10724 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261664AbVFTW7h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:37 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] sysfs: (driver/base) if show/store is missing return -EIO
In-Reply-To: <11193083612312@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:21 -0700
Message-Id: <11193083611546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs: (driver/base) if show/store is missing return -EIO

sysfs: fix drivers/base so if an attribute doesn't implement
       show or store method read/write will return -EIO
       instead of 0.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4a0c20bf8c0fe2116f8fd7d3da6122bf8a01f026
tree 48b6108a889f7cc007633c4d7d6f2c9fafe18082
parent c76d0abd07a9c9cf72bbb5b641e1e97f92ea8f3e
author Dmitry Torokhov <dtor_core@ameritech.net> Fri, 29 Apr 2005 01:23:47 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:02 -0700

 drivers/base/bus.c   |    4 ++--
 drivers/base/class.c |    4 ++--
 drivers/base/core.c  |    4 ++--
 drivers/base/sys.c   |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
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
diff --git a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
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
diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -36,7 +36,7 @@ dev_attr_show(struct kobject * kobj, str
 {
 	struct device_attribute * dev_attr = to_dev_attr(attr);
 	struct device * dev = to_dev(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (dev_attr->show)
 		ret = dev_attr->show(dev, buf);
@@ -49,7 +49,7 @@ dev_attr_store(struct kobject * kobj, st
 {
 	struct device_attribute * dev_attr = to_dev_attr(attr);
 	struct device * dev = to_dev(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (dev_attr->store)
 		ret = dev_attr->store(dev, buf, count);
diff --git a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c
+++ b/drivers/base/sys.c
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

