Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbTGDB4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265668AbTGDBy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:54:57 -0400
Received: from granite.he.net ([216.218.226.66]:23310 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265638AbTGDByt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845553725@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845541853@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:15 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1376, 2003/07/03 17:43:49-07:00, greg@kroah.com

[PATCH] driver core: added class_device_rename()
Based on a patch written by Dan Aloni <da-x@gmx.net>


 drivers/base/class.c   |   18 ++++++++++++++++++
 include/linux/device.h |    2 ++
 2 files changed, 20 insertions(+)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Thu Jul  3 18:15:38 2003
+++ b/drivers/base/class.c	Thu Jul  3 18:15:38 2003
@@ -339,6 +339,24 @@
 	class_device_put(class_dev);
 }
 
+int class_device_rename(struct class_device *class_dev, char *new_name)
+{
+	class_dev = class_device_get(class_dev);
+	if (!class_dev)
+		return -EINVAL;
+
+	pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
+		 new_name);
+
+	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
+
+	kobject_rename(&class_dev->kobj, new_name);
+
+	class_device_put(class_dev);
+
+	return 0;
+}
+
 struct class_device * class_device_get(struct class_device *class_dev)
 {
 	if (class_dev)
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu Jul  3 18:15:38 2003
+++ b/include/linux/device.h	Thu Jul  3 18:15:38 2003
@@ -216,6 +216,8 @@
 extern int class_device_add(struct class_device *);
 extern void class_device_del(struct class_device *);
 
+extern int class_device_rename(struct class_device *, char *);
+
 extern struct class_device * class_device_get(struct class_device *);
 extern void class_device_put(struct class_device *);
 

