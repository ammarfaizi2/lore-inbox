Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTI1XYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbTI1XYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:24:22 -0400
Received: from hera.cwi.nl ([192.16.191.8]:42221 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262772AbTI1XYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:24:20 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:24:16 +0200 (MEST)
Message-Id: <UTC200309282324.h8SNOG318793.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] affs sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/affs/file.c b/fs/affs/file.c
--- a/fs/affs/file.c	Mon Sep 29 01:05:41 2003
+++ b/fs/affs/file.c	Mon Sep 29 01:07:14 2003
@@ -39,7 +39,7 @@
 static struct buffer_head *affs_alloc_extblock(struct inode *inode, struct buffer_head *bh, u32 ext);
 static inline struct buffer_head *affs_get_extblock(struct inode *inode, u32 ext);
 static struct buffer_head *affs_get_extblock_slow(struct inode *inode, u32 ext);
-static ssize_t affs_file_write(struct file *filp, const char *buf, size_t count, loff_t *ppos);
+static ssize_t affs_file_write(struct file *filp, const char __user *buf, size_t count, loff_t *ppos);
 static int affs_file_open(struct inode *inode, struct file *filp);
 static int affs_file_release(struct inode *inode, struct file *filp);
 
@@ -491,7 +491,8 @@
 }
 
 static ssize_t
-affs_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+affs_file_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *ppos)
 {
 	ssize_t retval;
 
