Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVFUCDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVFUCDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVFTX6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:58:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:56036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261746AbVFTXAB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:01 -0400
Cc: yani.ioannou@gmail.com
Subject: [PATCH] Driver core: change device_attribute callbacks
In-Reply-To: <1119308367186@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:28 -0700
Message-Id: <11193083681028@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: change device_attribute callbacks

This patch adds the device_attribute paramerter to the
device_attribute store and show sysfs callback functions, and passes a
reference to the attribute when the callbacks are called.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 54b6f35c99974e99e64c05c2895718355123c55f
tree 321d08c397bc26b49c706ca5b86de7003c2329c0
parent ca2b94ba12f3c36fd3d6ed9d38b3798d4dad0d8b
author Yani Ioannou <yani.ioannou@gmail.com> Tue, 17 May 2005 06:39:34 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:31 -0700

 drivers/base/core.c    |    4 ++--
 include/linux/device.h |    6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -39,7 +39,7 @@ dev_attr_show(struct kobject * kobj, str
 	ssize_t ret = -EIO;
 
 	if (dev_attr->show)
-		ret = dev_attr->show(dev, buf);
+		ret = dev_attr->show(dev, dev_attr, buf);
 	return ret;
 }
 
@@ -52,7 +52,7 @@ dev_attr_store(struct kobject * kobj, st
 	ssize_t ret = -EIO;
 
 	if (dev_attr->store)
-		ret = dev_attr->store(dev, buf, count);
+		ret = dev_attr->store(dev, dev_attr, buf, count);
 	return ret;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -335,8 +335,10 @@ extern void driver_attach(struct device_
 
 struct device_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct device * dev, char * buf);
-	ssize_t (*store)(struct device * dev, const char * buf, size_t count);
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count);
 };
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \

