Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTFOR3S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTFOR3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:29:18 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:63250 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S262431AbTFOR3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:29:16 -0400
Date: Sun, 15 Jun 2003 18:44:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: James Morris <jmorris@intercode.com.au>
cc: Andrew Morton <akpm@digeo.com>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove superfluous inode superblock check from shmem_mmap
In-Reply-To: <Mutt.LNX.4.44.0306160211380.8018-100000@excalibur.intercode.com.au>
Message-ID: <Pine.LNX.4.44.0306151823070.2176-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, James Morris wrote:
> This patch against current 2.5 bk removes a (now) unecessary check for an 
> inode superblock in shmem_mmap().  In the current kernel, all inodes must 
> be associated with a superblock.

Thanks, looks good to me.  I don't believe an inode with NULL i_sb
could ever have got to shmem_mmap - it's just a check copied over
from an old generic_file_mmap.

Andrew, please apply: thank you.
Hugh

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

