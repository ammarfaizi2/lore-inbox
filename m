Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272270AbUKAWqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272270AbUKAWqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S378261AbUKAWoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:44:07 -0500
Received: from peabody.ximian.com ([130.57.169.10]:29854 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S315739AbUKAUpL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:45:11 -0500
Subject: [patch] inotify: misc. style cleanup
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1099330316.12182.2.camel@vertex>
References: <1099330316.12182.2.camel@vertex>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 15:42:51 -0500
Message-Id: <1099341771.31022.49.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John!

Misc. style clean up.

	Robert Love


misc. style cleanup

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   46 ++++++++++++++++------------------------------
 1 files changed, 16 insertions(+), 30 deletions(-)

diff -urN linux-2.6.10-rc1-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-2.6.10-rc1-inotify/drivers/char/inotify.c	2004-11-01 15:04:12.039747832 -0500
+++ linux/drivers/char/inotify.c	2004-11-01 15:38:22.277064384 -0500
@@ -80,21 +80,20 @@
 #define inotify_watch_i_list(pos) list_entry((pos), struct inotify_watch, i_list)
 #define inotify_watch_u_list(pos) list_entry((pos), struct inotify_watch, u_list)
 
-static ssize_t show_max_queued_events (struct device *dev, char *buf)
+static ssize_t show_max_queued_events(struct device *dev, char *buf)
 {
 	sprintf(buf, "%d", sysfs_attrib_max_queued_events);
-
-	return strlen(buf)+1;
+	return strlen(buf) + 1;
 }
 
-static ssize_t store_max_queued_events (struct device *dev,
-										const char *buf,
-										size_t count)
+static ssize_t store_max_queued_events(struct device *dev, const char *buf,
+				       size_t count)
 {
 	return 0;
 }
 
-static DEVICE_ATTR(max_queued_events, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH, show_max_queued_events, store_max_queued_events);
+static DEVICE_ATTR(max_queued_events, S_IRUGO | S_IWUSR, show_max_queued_events,
+ store_max_queued_events);
 
 static struct device_attribute *inotify_device_attrs[] = {
 	&dev_attr_max_queued_events,
@@ -203,9 +202,7 @@
 {
 	struct inotify_kernel_event *kevent, *last;
 
-	/*
-	 * Check if the new event is a duplicate of the last event queued.
-	 */
+	/* check if the new event is a duplicate of the last event queued. */
 	last = inotify_dev_get_event(dev);
 	if (dev->event_count && last->event.mask == mask &&
 			last->event.wd == watch->wd) {
@@ -272,17 +269,16 @@
  * This function can sleep.
  */
 static int inotify_dev_get_wd(struct inotify_device *dev,
-				struct inotify_watch *watch)
+			      struct inotify_watch *watch)
 {
 	int ret;
 
-	if (!dev || !watch || dev->nr_watches >= current->signal->rlim[RLIMIT_IWATCHES].rlim_cur)
+	if (dev->nr_watches >= current->rlim[RLIMIT_IWATCHES].rlim_cur)
 		return -1;
 
 repeat:
-	if (!idr_pre_get(&dev->idr, GFP_KERNEL)) {
+	if (!idr_pre_get(&dev->idr, GFP_KERNEL))
 		return -ENOSPC;
-	}
 	spin_lock(&dev->lock);
 	ret = idr_get_new(&dev->idr, watch, &watch->wd);
 	spin_unlock(&dev->lock);
@@ -394,9 +390,8 @@
 	struct inotify_watch *watch;
 
 	list_for_each_entry(watch, &dev->watches, d_list) {
-		if (watch->inode == inode) {
+		if (watch->inode == inode)
 			return 1;
-		}
 	}
 
 	return 0;
@@ -410,9 +405,8 @@
 static int inotify_dev_add_watch(struct inotify_device *dev,
 				 struct inotify_watch *watch)
 {
-	if (!dev || !watch) {
+	if (!dev || !watch)
 		return -EINVAL;
-	}
 
 	list_add(&watch->d_list, &dev->watches);
 	return 0;
@@ -477,9 +471,7 @@
 	}
 
 	if (inode_find_dev (inode, watch->dev))
-	{
 		return -EINVAL;
-	}
 
 	list_add(&watch->i_list, &inode->inotify_data->watches);
 	inode->inotify_data->watch_count++;
@@ -678,7 +670,7 @@
 	if (count < event_size)
 		return -EINVAL;
 
-	while(1) {
+	while (1) {
 		int has_events;
 
 		spin_lock(&dev->lock);
@@ -760,9 +752,8 @@
 {
 	struct inotify_watch *watch,*next;
 
-	list_for_each_entry_safe(watch, next, &dev->watches, d_list) {
+	list_for_each_entry_safe(watch, next, &dev->watches, d_list)
 		ignore_helper(watch, 0);
-	}
 }
 
 /*
@@ -797,9 +788,8 @@
 	int ret;
 
 	inode = find_inode(request->dirname);
-	if (IS_ERR(inode)) {
+	if (IS_ERR(inode))
 		return PTR_ERR(inode);
-	}
 
 	spin_lock(&inode->i_lock);
 	spin_lock(&dev->lock);
@@ -934,9 +924,7 @@
 	sysfs_attrib_max_queued_events = 16384;
 
 	for (i = 0;inotify_device_attrs[i];i++)
-	{
-		device_create_file (inotify_device.dev, inotify_device_attrs[i]);
-	}
+		device_create_file(inotify_device.dev, inotify_device_attrs[i]);
 
 	atomic_set(&watch_count, 0);
 	atomic_set(&inotify_cookie, 0);
@@ -958,6 +946,4 @@
 	return 0;
 }
 
-
-
 module_init(inotify_init);


