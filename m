Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTFJQqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTFJQqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:46:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:16392 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263451AbTFJQq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:46:29 -0400
Date: Tue, 10 Jun 2003 18:02:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 3/3 little bits
In-Reply-To: <Pine.LNX.4.44.0306101757150.2432-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101801020.2432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove shmem_nrpages, no use is made of it (even 2.4-ac, though it
counts it, does nothing with it): reintroduce if it becomes useful.
Replace GPL oneliner by the block from 2.4-ac, extend Copyright to
2003, remove two white spaces.

--- tmpfs2/include/linux/shmem_fs.h	Tue Dec 10 02:46:16 2002
+++ tmpfs3/include/linux/shmem_fs.h	Fri Jun  6 16:10:09 2003
@@ -7,8 +7,6 @@
 
 #define SHMEM_NR_DIRECT 16
 
-extern atomic_t shmem_nrpages;
-
 struct shmem_inode_info {
 	spinlock_t		lock;
 	unsigned long		next_index;
--- tmpfs2/mm/shmem.c	Fri Jun  6 19:24:34 2003
+++ tmpfs3/mm/shmem.c	Fri Jun  6 19:26:37 2003
@@ -6,8 +6,22 @@
  *		 2000-2001 Christoph Rohland
  *		 2000-2001 SAP AG
  *		 2002 Red Hat Inc.
+ * Copyright (C) 2002-2003 Hugh Dickins.
+ * Copyright (C) 2002-2003 VERITAS Software Corporation.
  *
- * This file is released under the GPL.
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 /*
@@ -128,9 +142,8 @@
 	.memory_backed	= 1,	/* Does not contribute to dirty memory */
 };
 
-LIST_HEAD (shmem_inodes);
+LIST_HEAD(shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
-atomic_t shmem_nrpages = ATOMIC_INIT(0); /* Not used right now */
 
 static void shmem_free_block(struct inode *inode)
 {
@@ -965,7 +978,7 @@
 	size = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	if (pgoff >= size || pgoff + (len >> PAGE_SHIFT) > size)
 		return -EINVAL;
-	
+
 	while ((long) len > 0) {
 		struct page *page = NULL;
 		int err;

