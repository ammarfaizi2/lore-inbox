Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUI0Un5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUI0Un5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUI0Umv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:42:51 -0400
Received: from peabody.ximian.com ([130.57.169.10]:61607 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267324AbUI0Ukw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:40:52 -0400
Subject: [patch] inotify: don't check private_data
From: Robert Love <rml@ximian.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-5BXWzNMvSGyFQUw8CUE8"
Date: Mon, 27 Sep 2004 16:39:30 -0400
Message-Id: <1096317570.30503.131.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5BXWzNMvSGyFQUw8CUE8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-26 at 22:02 -0400, John McCutchan wrote:

> Announcing the release of inotify 0.10.0. 
> Attached is a patch to 2.6.8.1.

Hey, John.

Any reason we check file->private_data in inotify_release()?

I don't think there is.  Following patch removes the check.

	Robert Love


--=-5BXWzNMvSGyFQUw8CUE8
Content-Disposition: attachment; filename=inotify-rml-file_private-1.patch
Content-Type: text/x-patch; name=inotify-rml-file_private-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

No need to check file->private_data

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-27 16:28:27.989505320 -0400
+++ linux/drivers/char/inotify.c	2004-09-27 16:34:58.269173792 -0400
@@ -822,15 +822,13 @@
 
 static int inotify_release(struct inode *inode, struct file *file)
 {
-	if (file->private_data) {
-		struct inotify_device *dev;
+	struct inotify_device *dev;
 
-		dev = file->private_data;
-		del_timer_sync(&dev->timer);
-		inotify_release_all_watchers(dev);
-		inotify_release_all_events(dev);
-		kfree(dev);
-	}
+	dev = file->private_data;
+	del_timer_sync(&dev->timer);
+	inotify_release_all_watchers(dev);
+	inotify_release_all_events(dev);
+	kfree(dev);
 
 	printk(KERN_ALERT "inotify device released\n");
 

--=-5BXWzNMvSGyFQUw8CUE8--

