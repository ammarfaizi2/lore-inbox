Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWJMH5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWJMH5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWJMH5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:57:43 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:49598 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751622AbWJMH5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:57:43 -0400
Date: Fri, 13 Oct 2006 10:57:41 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, mhalcrow@us.ibm.com,
       phillip@hellewell.homeip.net
Subject: [PATCH] ecryptfs: use special_file
Message-ID: <Pine.LNX.4.64.0610131057040.18353@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

Use the special_file() macro to check whether an inode is special instead of
open-coding it.

Cc: Mike Halcrow <mhalcrow@us.ibm.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/ecryptfs/main.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: 2.6/fs/ecryptfs/main.c
===================================================================
--- 2.6.orig/fs/ecryptfs/main.c
+++ 2.6/fs/ecryptfs/main.c
@@ -104,10 +104,7 @@ int ecryptfs_interpose(struct dentry *lo
 		inode->i_op = &ecryptfs_dir_iops;
 	if (S_ISDIR(lower_inode->i_mode))
 		inode->i_fop = &ecryptfs_dir_fops;
-	/* TODO: Is there a better way to identify if the inode is
-	 * special? */
-	if (S_ISBLK(lower_inode->i_mode) || S_ISCHR(lower_inode->i_mode) ||
-	    S_ISFIFO(lower_inode->i_mode) || S_ISSOCK(lower_inode->i_mode))
+	if (special_file(lower_inode->i_mode))
 		init_special_inode(inode, lower_inode->i_mode,
 				   lower_inode->i_rdev);
 	dentry->d_op = &ecryptfs_dops;
