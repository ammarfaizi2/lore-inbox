Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUJDS45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUJDS45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUJDS45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:56:57 -0400
Received: from peabody.ximian.com ([130.57.169.10]:59094 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268425AbUJDSzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:55:32 -0400
Subject: [patch] inotify: more misc stuff
From: Robert Love <rml@ximian.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096865816.3827.1.camel@vertex>
References: <1096865816.3827.1.camel@vertex>
Content-Type: multipart/mixed; boundary="=-ApmQ5/dJd4UXQktaOmKu"
Date: Mon, 04 Oct 2004 14:54:00 -0400
Message-Id: <1096916040.17426.44.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ApmQ5/dJd4UXQktaOmKu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Really, really trivial bits.

	Robert Love


--=-ApmQ5/dJd4UXQktaOmKu
Content-Disposition: attachment; filename=inotify-0.12-rml-more-misc-1.patch
Content-Type: text/x-patch; name=inotify-0.12-rml-more-misc-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-10-04 14:23:58.282706352 -0400
+++ linux/drivers/char/inotify.c	2004-10-04 14:52:43.393449656 -0400
@@ -22,7 +22,6 @@
  * use slab cache for inotify_inode_data structures
  */
 
-#include <linux/bitops.h>
 #include <linux/bitmap.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -33,11 +32,7 @@
 #include <linux/namei.h>
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
-#include <linux/device.h>
 #include <linux/init.h>
-#include <linux/types.h>
-#include <linux/stddef.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/writeback.h>
 #include <linux/inotify.h>
@@ -353,7 +348,7 @@
  * Caller must hold dev->lock.
  */
 static void delete_watch(struct inotify_device *dev,
-			   struct inotify_watch *watch)
+			 struct inotify_watch *watch)
 {
 	inotify_dev_put_wd(dev, watch->wd);
 	iprintk(INOTIFY_DEBUG_ALLOC, "free'd watch %p\n", watch);
@@ -406,8 +401,13 @@
 	return 0;
 }
 
+/*
+ * inotify_dev_add_watcher - add the given watcher to the given device instance
+ *
+ * Caller must hold dev->lock.
+ */
 static int inotify_dev_add_watch(struct inotify_device *dev,
-				   struct inotify_watch *watch)
+				 struct inotify_watch *watch)
 {
 	if (!dev || !watch)
 		return -EINVAL;
@@ -428,7 +428,7 @@
  * Caller must hold dev->lock because we call inotify_dev_queue_event().
  */
 static int inotify_dev_rm_watch(struct inotify_device *dev,
-				  struct inotify_watch *watch)
+				struct inotify_watch *watch)
 {
 	if (!watch)
 		return -EINVAL;
@@ -460,7 +460,7 @@
  * Callers must hold dev->lock, because we call inode_find_dev().
  */
 static int inode_add_watch(struct inode *inode,
-			     struct inotify_watch *watch)
+			   struct inotify_watch *watch)
 {
 	if (!inode || !watch || inode_find_dev(inode, watch->dev))
 		return -EINVAL;
@@ -483,7 +483,7 @@
 }
 
 static int inode_rm_watch(struct inode *inode,
-			     struct inotify_watch *watch)
+			  struct inotify_watch *watch)
 {
 	if (!inode || !watch || !inode->inotify_data)
 		return -EINVAL;
@@ -539,12 +539,12 @@
 	struct inotify_device *dev;
 	struct inode *inode;
 
-	spin_lock(&watch->inode->i_lock);
-	spin_lock(&watch->dev->lock);
-
 	inode = watch->inode;
 	dev = watch->dev;
 
+	spin_lock(&inode->i_lock);
+	spin_lock(&dev->lock);
+
 	if (event)
 		inotify_dev_queue_event(dev, watch, event, NULL);
 
@@ -588,7 +588,8 @@
 
 		spin_lock(&inode->i_lock);
 
-		list_for_each_entry(watch, &inode->inotify_data->watches, i_list)
+		list_for_each_entry(watch, &inode->inotify_data->watches,
+				    i_list)
 			list_add(&watch->u_list, umount);
 
 		spin_unlock(&inode->i_lock);

--=-ApmQ5/dJd4UXQktaOmKu--

