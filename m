Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTFOQBD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTFOQBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:01:03 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:12563 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262320AbTFOQBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:01:01 -0400
Date: Mon, 16 Jun 2003 02:14:37 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove superfluous inode superblock check from shmem_mmap
Message-ID: <Mutt.LNX.4.44.0306160211380.8018-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against current 2.5 bk removes a (now) unecessary check for an 
inode superblock in shmem_mmap().  In the current kernel, all inodes must 
be associated with a superblock.

- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -purN -X dontdiff bk.pending/mm/shmem.c bk.w1/mm/shmem.c
--- bk.pending/mm/shmem.c	2003-06-16 00:56:13.000000000 +1000
+++ bk.w1/mm/shmem.c	2003-06-16 02:06:55.142303751 +1000
@@ -1010,7 +1010,7 @@ static int shmem_mmap(struct file *file,
 	struct inode *inode = file->f_dentry->d_inode;
 
 	ops = &shmem_vm_ops;
-	if (!inode->i_sb || !S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode))
 		return -EACCES;
 	update_atime(inode);
 	vma->vm_ops = ops;

