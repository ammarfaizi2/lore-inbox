Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWD0UUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWD0UUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWD0UUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:20:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:19095 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965073AbWD0UUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:20:19 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 4/5] Kobject: possible cleanups
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 27 Apr 2006 13:18:44 -0700
Message-Id: <11461691263127-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.1
In-Reply-To: <1146169126913-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

This patch contains the following possible cleanups:
- #if 0 the following unused global function:
  - subsys_remove_file()
- remove the following unused EXPORT_SYMBOL's:
  - kset_find_obj
  - subsystem_init
- remove the following unused EXPORT_SYMBOL_GPL:
  - kobject_add_dir

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 include/linux/kobject.h |    1 -
 lib/kobject.c           |    7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

5b3ef14e3e9d745a512d65fcb4ef9be541226d80
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index e38bb35..c187c53 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -257,7 +257,6 @@ struct subsys_attribute {
 };
 
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
-extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
 #if defined(CONFIG_HOTPLUG)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
diff --git a/lib/kobject.c b/lib/kobject.c
index 01d9575..b46350c 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -422,7 +422,6 @@ struct kobject *kobject_add_dir(struct k
 
 	return k;
 }
-EXPORT_SYMBOL_GPL(kobject_add_dir);
 
 /**
  *	kset_init - initialize a kset for use
@@ -569,7 +568,7 @@ int subsys_create_file(struct subsystem 
  *	@s:	subsystem.
  *	@a:	attribute desciptor.
  */
-
+#if 0
 void subsys_remove_file(struct subsystem * s, struct subsys_attribute * a)
 {
 	if (subsys_get(s)) {
@@ -577,6 +576,7 @@ void subsys_remove_file(struct subsystem
 		subsys_put(s);
 	}
 }
+#endif  /*  0  */
 
 EXPORT_SYMBOL(kobject_init);
 EXPORT_SYMBOL(kobject_register);
@@ -588,10 +588,7 @@ EXPORT_SYMBOL(kobject_del);
 
 EXPORT_SYMBOL(kset_register);
 EXPORT_SYMBOL(kset_unregister);
-EXPORT_SYMBOL(kset_find_obj);
 
-EXPORT_SYMBOL(subsystem_init);
 EXPORT_SYMBOL(subsystem_register);
 EXPORT_SYMBOL(subsystem_unregister);
 EXPORT_SYMBOL(subsys_create_file);
-EXPORT_SYMBOL(subsys_remove_file);
-- 
1.3.1

