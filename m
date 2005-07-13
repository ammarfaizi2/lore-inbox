Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVGMRxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVGMRxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVGMRvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:51:11 -0400
Received: from loon.tech9.net ([69.20.54.92]:15759 "EHLO loon.tech9.net")
	by vger.kernel.org with ESMTP id S261919AbVGMRtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:49:13 -0400
Subject: [patch 3/3] inotify: misc cleanup
From: Robert Love <rlove@rlove.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 13:48:59 -0400
Message-Id: <1121276939.6384.29.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Real simple, basic cleanup.

Please, apply.

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

 fs/inotify.c          |    9 +++------
 include/linux/sched.h |    2 +-
 kernel/user.c         |    2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff -urN linux-inotify/fs/inotify.c linux/fs/inotify.c
--- linux-inotify/fs/inotify.c	2005-07-13 11:26:02.000000000 -0400
+++ linux/fs/inotify.c	2005-07-13 11:41:25.000000000 -0400
@@ -29,8 +29,6 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/poll.h>
-#include <linux/device.h>
-#include <linux/miscdevice.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/writeback.h>
@@ -936,7 +934,7 @@
 
 	dev = filp->private_data;
 
-	ret = find_inode ((const char __user*)path, &nd);
+	ret = find_inode((const char __user*) path, &nd);
 	if (ret)
 		goto fput_and_out;
 
@@ -993,8 +991,9 @@
 	if (!filp)
 		return -EBADF;
 	dev = filp->private_data;
-	ret = inotify_ignore (dev, wd);
+	ret = inotify_ignore(dev, wd);
 	fput(filp);
+
 	return ret;
 }
 
@@ -1034,8 +1033,6 @@
 					 sizeof(struct inotify_kernel_event),
 					 0, SLAB_PANIC, NULL, NULL);
 
-	printk(KERN_INFO "inotify syscall\n");
-
 	return 0;
 }
 


