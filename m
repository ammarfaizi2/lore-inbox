Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWDVUsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWDVUsF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWDVUsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:48:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:5330 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751167AbWDVUsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:48:04 -0400
Date: Sat, 22 Apr 2006 12:14:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] lib/kobject.c: possible cleanups
Message-ID: <20060422101444.GN19754@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- #if 0 the following unused global function:
  - subsys_remove_file()
- remove the following unused EXPORT_SYMBOL's:
  - kset_find_obj
  - subsystem_init
- remove the following unused EXPORT_SYMBOL_GPL:
  - kobject_add_dir

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/kobject.h |    1 -
 lib/kobject.c           |    7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

--- linux-2.6.17-rc1-mm3-full/include/linux/kobject.h.old	2006-04-21 21:35:34.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/kobject.h	2006-04-21 21:35:49.000000000 +0200
@@ -257,7 +257,6 @@
 };
 
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
-extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
 #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
--- linux-2.6.17-rc1-mm3-full/lib/kobject.c.old	2006-04-21 21:31:59.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/lib/kobject.c	2006-04-21 21:35:01.000000000 +0200
@@ -422,7 +422,6 @@
 
 	return k;
 }
-EXPORT_SYMBOL_GPL(kobject_add_dir);
 
 /**
  *	kset_init - initialize a kset for use
@@ -569,7 +568,7 @@
  *	@s:	subsystem.
  *	@a:	attribute desciptor.
  */
-
+#if 0
 void subsys_remove_file(struct subsystem * s, struct subsys_attribute * a)
 {
 	if (subsys_get(s)) {
@@ -577,6 +576,7 @@
 		subsys_put(s);
 	}
 }
+#endif  /*  0  */
 
 EXPORT_SYMBOL(kobject_init);
 EXPORT_SYMBOL(kobject_register);
@@ -588,10 +588,7 @@
 
 EXPORT_SYMBOL(kset_register);
 EXPORT_SYMBOL(kset_unregister);
-EXPORT_SYMBOL(kset_find_obj);
 
-EXPORT_SYMBOL(subsystem_init);
 EXPORT_SYMBOL(subsystem_register);
 EXPORT_SYMBOL(subsystem_unregister);
 EXPORT_SYMBOL(subsys_create_file);
-EXPORT_SYMBOL(subsys_remove_file);

