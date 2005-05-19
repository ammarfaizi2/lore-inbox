Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVESXRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVESXRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVESXOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:14:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59298 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261295AbVESW5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:57:06 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFR][PATCH] namei fixes (18/19)
Cc: akpm@osdl.org
Message-Id: <E1DYtxL-0007tl-MH@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:57:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(18/19)

Cosmetical cleanups - __follow_mount() calls in __link_path_walk() absorbed
into do_lookup().

Obviously equivalent transformation.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc4-17/fs/namei.c RC12-rc4-18/fs/namei.c
--- RC12-rc4-17/fs/namei.c	2005-05-19 16:39:46.911156004 -0400
+++ RC12-rc4-18/fs/namei.c	2005-05-19 16:39:48.010936857 -0400
@@ -682,6 +682,7 @@
 done:
 	path->mnt = mnt;
 	path->dentry = dentry;
+	__follow_mount(path);
 	return 0;
 
 need_lookup:
@@ -789,8 +790,6 @@
 		err = do_lookup(nd, &this, &next);
 		if (err)
 			break;
-		/* Check mountpoints.. */
-		__follow_mount(&next);
 
 		err = -ENOENT;
 		inode = next.dentry->d_inode;
@@ -850,7 +849,6 @@
 		err = do_lookup(nd, &this, &next);
 		if (err)
 			break;
-		__follow_mount(&next);
 		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
