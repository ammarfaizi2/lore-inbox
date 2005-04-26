Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVDZHgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVDZHgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVDZHfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:35:25 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:43425 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261397AbVDZHeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:34:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] kset_hotplug_ops->name shoudl return const char *
Date: Tue, 26 Apr 2005 02:32:54 -0500
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>
References: <200504260229.03866.dtor_core@ameritech.net>
In-Reply-To: <200504260229.03866.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504260232.55130.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject: change name() method in kset_hotplug_ops return const char *
	 since users shoudl not try to modify returned data.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/base/class.c    |    2 +-
 drivers/base/core.c     |    2 +-
 include/linux/kobject.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: dtor/drivers/base/class.c
===================================================================
--- dtor.orig/drivers/base/class.c
+++ dtor/drivers/base/class.c
@@ -262,7 +262,7 @@ static int class_hotplug_filter(struct k
 	return 0;
 }
 
-static char *class_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *class_hotplug_name(struct kset *kset, struct kobject *kobj)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 
Index: dtor/include/linux/kobject.h
===================================================================
--- dtor.orig/include/linux/kobject.h
+++ dtor/include/linux/kobject.h
@@ -94,7 +94,7 @@ struct kobj_type {
  */
 struct kset_hotplug_ops {
 	int (*filter)(struct kset *kset, struct kobject *kobj);
-	char *(*name)(struct kset *kset, struct kobject *kobj);
+	const char *(*name)(struct kset *kset, struct kobject *kobj);
 	int (*hotplug)(struct kset *kset, struct kobject *kobj, char **envp,
 			int num_envp, char *buffer, int buffer_size);
 };
Index: dtor/drivers/base/core.c
===================================================================
--- dtor.orig/drivers/base/core.c
+++ dtor/drivers/base/core.c
@@ -105,7 +105,7 @@ static int dev_hotplug_filter(struct kse
 	return 0;
 }
 
-static char *dev_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *dev_hotplug_name(struct kset *kset, struct kobject *kobj)
 {
 	struct device *dev = to_dev(kobj);
 
