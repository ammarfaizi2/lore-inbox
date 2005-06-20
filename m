Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVFUC1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVFUC1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFUCS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:18:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:31972 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261727AbVFTW7s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:48 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] kset_hotplug_ops->name shoudl return const char *
In-Reply-To: <11193083603640@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:21 -0700
Message-Id: <1119308361783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kset_hotplug_ops->name shoudl return const char *

kobject: change name() method in kset_hotplug_ops return const char *
	 since users shoudl not try to modify returned data.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 419cab3fc69588ebe35b845cc3a584ae172463de
tree 7886076bcc4970005cbd39c886eb414bb61242a4
parent f3b4f3c6dec04c6c8261fe22645f07b39976595a
author Dmitry Torokhov <dtor_core@ameritech.net> Tue, 26 Apr 2005 02:32:54 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:01 -0700

 drivers/base/class.c    |    2 +-
 drivers/base/core.c     |    2 +-
 include/linux/kobject.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -262,7 +262,7 @@ static int class_hotplug_filter(struct k
 	return 0;
 }
 
-static char *class_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *class_hotplug_name(struct kset *kset, struct kobject *kobj)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -102,7 +102,7 @@ static int dev_hotplug_filter(struct kse
 	return 0;
 }
 
-static char *dev_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *dev_hotplug_name(struct kset *kset, struct kobject *kobj)
 {
 	struct device *dev = to_dev(kobj);
 
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -94,7 +94,7 @@ struct kobj_type {
  */
 struct kset_hotplug_ops {
 	int (*filter)(struct kset *kset, struct kobject *kobj);
-	char *(*name)(struct kset *kset, struct kobject *kobj);
+	const char *(*name)(struct kset *kset, struct kobject *kobj);
 	int (*hotplug)(struct kset *kset, struct kobject *kobj, char **envp,
 			int num_envp, char *buffer, int buffer_size);
 };

