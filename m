Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWBTWg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWBTWg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWBTWg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:36:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62732 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932694AbWBTWgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:36:19 -0500
Date: Mon, 20 Feb 2006 23:36:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] remove kernel/power/pm.c:pm_unregister()
Message-ID: <20060220223617.GM4661@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the last user is removed in -mm, we can now remove this long 
deprecated function.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/pm_legacy.h |    7 -------
 kernel/power/pm.c         |   20 --------------------
 2 files changed, 27 deletions(-)

--- linux-2.6.16-rc4-mm1-full/include/linux/pm_legacy.h.old	2006-02-20 19:40:14.000000000 +0100
+++ linux-2.6.16-rc4-mm1-full/include/linux/pm_legacy.h	2006-02-20 19:40:24.000000000 +0100
@@ -16,11 +16,6 @@
 pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
 
 /*
- * Unregister a device with power management
- */
-void __deprecated pm_unregister(struct pm_dev *dev);
-
-/*
  * Unregister all devices with matching callback
  */
 void __deprecated pm_unregister_all(pm_callback callback);
@@ -41,8 +36,6 @@
 	return NULL;
 }
 
-static inline void pm_unregister(struct pm_dev *dev) {}
-
 static inline void pm_unregister_all(pm_callback callback) {}
 
 static inline int pm_send_all(pm_request_t rqst, void *data)
--- linux-2.6.16-rc4-mm1-full/kernel/power/pm.c.old	2006-02-20 19:40:32.000000000 +0100
+++ linux-2.6.16-rc4-mm1-full/kernel/power/pm.c	2006-02-20 19:40:50.000000000 +0100
@@ -75,25 +75,6 @@
 	return dev;
 }
 
-/**
- *	pm_unregister -  unregister a device with power management
- *	@dev: device to unregister
- *
- *	Remove a device from the power management notification lists. The
- *	dev passed must be a handle previously returned by pm_register.
- */
- 
-void pm_unregister(struct pm_dev *dev)
-{
-	if (dev) {
-		mutex_lock(&pm_devs_lock);
-		list_del(&dev->entry);
-		mutex_unlock(&pm_devs_lock);
-
-		kfree(dev);
-	}
-}
-
 static void __pm_unregister(struct pm_dev *dev)
 {
 	if (dev) {
@@ -258,7 +239,6 @@
 }
 
 EXPORT_SYMBOL(pm_register);
-EXPORT_SYMBOL(pm_unregister);
 EXPORT_SYMBOL(pm_unregister_all);
 EXPORT_SYMBOL(pm_send_all);
 EXPORT_SYMBOL(pm_active);

