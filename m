Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTI1Xct (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTI1Xbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:31:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:26095 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262803AbTI1XbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:31:15 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:31:12 +0200 (MEST)
Message-Id: <UTC200309282331.h8SNVC705517.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] hpfs sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/hpfs/file.c b/fs/hpfs/file.c
--- a/fs/hpfs/file.c	Mon Sep 29 01:05:41 2003
+++ b/fs/hpfs/file.c	Mon Sep 29 01:13:23 2003
@@ -124,7 +124,8 @@
 	.bmap = _hpfs_bmap
 };
 
-ssize_t hpfs_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+ssize_t hpfs_file_write(struct file *file, const char __user *buf,
+			size_t count, loff_t *ppos)
 {
 	ssize_t retval;
 
diff -u --recursive --new-file -X /linux/dontdiff a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
--- a/fs/hpfs/hpfs_fn.h	Mon Sep 29 01:05:41 2003
+++ b/fs/hpfs/hpfs_fn.h	Mon Sep 29 01:13:23 2003
@@ -249,7 +249,7 @@
 secno hpfs_bmap(struct inode *, unsigned);
 void hpfs_truncate(struct inode *);
 int hpfs_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create);
-ssize_t hpfs_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos);
+ssize_t hpfs_file_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos);
 
 /* inode.c */
 
