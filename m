Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWGCBCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWGCBCh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWGCBCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:02:36 -0400
Received: from thunk.org ([69.25.196.29]:7108 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750980AbWGCBA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:00:26 -0400
Message-Id: <20060703010023.959783000@candygram.thunk.org>
References: <20060703005333.706556000@candygram.thunk.org>
Date: Sun, 02 Jul 2006 20:53:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 8/8] inode-diet: Fix size of i_blkbits, i_version, and i_dnotify_mask
Content-Disposition: inline; filename=inode-slim-8
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i_blkbits stores the log n of the blocksize; there is no reason for it
to take more than 16 bits, so change it to be a short and put it next
to i_mode.

i_version and i_dnotify_mask need to be 32 bits, but there is no
reason for them to be 64-bit values on 64-bit architectures, so make
them be unsigned int's instead of unsigned long's.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6.17-mm5/include/linux/fs.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/fs.h	2006-07-02 20:29:52.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/fs.h	2006-07-02 20:29:55.000000000 -0400
@@ -498,6 +498,7 @@
 	unsigned long		i_ino;
 	atomic_t		i_count;
 	umode_t			i_mode;
+	unsigned short		i_blkbits;
 	unsigned int		i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
@@ -505,8 +506,7 @@
 	struct timespec		i_atime;
 	struct timespec		i_mtime;
 	struct timespec		i_ctime;
-	unsigned int		i_blkbits;
-	unsigned long		i_version;
+	unsigned int		i_version;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct mutex		i_mutex;
 	struct rw_semaphore	i_alloc_sem;
@@ -538,7 +538,7 @@
 	__u32			i_generation;
 
 #ifdef CONFIG_DNOTIFY
-	unsigned long		i_dnotify_mask; /* Directory notify events */
+	unsigned int		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 #endif
 

--
