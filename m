Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVCJAtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVCJAtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVCJAt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:49:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:58271 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262630AbVCJAmd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:33 -0500
Cc: gregkh@suse.de
Subject: [PATCH] sysdev: fix the name of the list of drivers to be a sane name
In-Reply-To: <11104148863225@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:46 -0800
Message-Id: <1110414886525@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2053, 2005/03/09 15:35:31-08:00, gregkh@suse.de

[PATCH] sysdev: fix the name of the list of drivers to be a sane name

Heh, "global_drivers" as a static...

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/base/sys.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	2005-03-09 16:28:17 -08:00
+++ b/drivers/base/sys.c	2005-03-09 16:28:17 -08:00
@@ -102,7 +102,7 @@
 EXPORT_SYMBOL_GPL(sysdev_class_unregister);
 
 
-static LIST_HEAD(global_drivers);
+static LIST_HEAD(sysdev_drivers);
 
 /**
  *	sysdev_driver_register - Register auxillary driver
@@ -112,7 +112,7 @@
  *	If @cls is valid, then @drv is inserted into @cls->drivers to be
  *	called on each operation on devices of that class. The refcount
  *	of @cls is incremented.
- *	Otherwise, @drv is inserted into global_drivers, and called for
+ *	Otherwise, @drv is inserted into sysdev_drivers, and called for
  *	each device.
  */
 
@@ -130,7 +130,7 @@
 				drv->add(dev);
 		}
 	} else
-		list_add_tail(&drv->entry, &global_drivers);
+		list_add_tail(&drv->entry, &sysdev_drivers);
 	up_write(&system_subsys.rwsem);
 	return 0;
 }
@@ -199,7 +199,7 @@
 		 */
 
 		/* Notify global drivers */
-		list_for_each_entry(drv, &global_drivers, entry) {
+		list_for_each_entry(drv, &sysdev_drivers, entry) {
 			if (drv->add)
 				drv->add(sysdev);
 		}
@@ -219,7 +219,7 @@
 	struct sysdev_driver * drv;
 
 	down_write(&system_subsys.rwsem);
-	list_for_each_entry(drv, &global_drivers, entry) {
+	list_for_each_entry(drv, &sysdev_drivers, entry) {
 		if (drv->remove)
 			drv->remove(sysdev);
 	}
@@ -268,7 +268,7 @@
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
-			list_for_each_entry(drv, &global_drivers, entry) {
+			list_for_each_entry(drv, &sysdev_drivers, entry) {
 				if (drv->shutdown)
 					drv->shutdown(sysdev);
 			}
@@ -319,7 +319,7 @@
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
-			list_for_each_entry(drv, &global_drivers, entry) {
+			list_for_each_entry(drv, &sysdev_drivers, entry) {
 				if (drv->suspend)
 					drv->suspend(sysdev, state);
 			}
@@ -375,7 +375,7 @@
 			}
 
 			/* Call global drivers. */
-			list_for_each_entry(drv, &global_drivers, entry) {
+			list_for_each_entry(drv, &sysdev_drivers, entry) {
 				if (drv->resume)
 					drv->resume(sysdev);
 			}

