Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267908AbTBLWg5>; Wed, 12 Feb 2003 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267899AbTBLWg5>; Wed, 12 Feb 2003 17:36:57 -0500
Received: from fmr02.intel.com ([192.55.52.25]:18636 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267914AbTBLWg4>; Wed, 12 Feb 2003 17:36:56 -0500
Subject: [PATCH][2.5.60 Trivial] Sysfs not handling show errors
From: Rusty Lynch <rusty@linux.co.intel.com>
To: mochel@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Feb 2003 14:37:35 -0800
Message-Id: <1045089456.1150.6.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to cat a sysfs file that returns an error will result in an
endless dump of garbage to the screen because the result of the specific
show operation was being saved to a size_t (unsigned) and then later
checked for a negative value.

Here is a trivial patch to fix the error.

    --rustyl

--- fs/sysfs/inode.c.orig	2003-02-12 14:38:04.000000000 -0800
+++ fs/sysfs/inode.c	2003-02-12 14:38:39.000000000 -0800
@@ -210,7 +210,7 @@
 	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
 	struct sysfs_ops * ops = buffer->ops;
 	int ret = 0;
-	size_t count;
+	ssize_t count;
 
 	if (!buffer->page)
 		buffer->page = (char *) __get_free_page(GFP_KERNEL);



