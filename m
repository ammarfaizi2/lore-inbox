Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWFSPcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWFSPcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWFSPbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:31:38 -0400
Received: from thunk.org ([69.25.196.29]:7562 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932521AbWFSPbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:31:15 -0400
Message-Id: <20060619153110.629047000@candygram.thunk.org>
References: <20060619152003.830437000@candygram.thunk.org>
Date: Mon, 19 Jun 2006 11:20:11 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH 8/8] inode-diet: Fix size of i_blkbits, i_version, and i_dnotify_mask
Content-Disposition: inline; filename=inode-slim-8
From: Theodore Tso <tytso@thunk.org>
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

Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-06-19 07:29:36.000000000 -0400
+++ linux-2.6.17/include/linux/fs.h	2006-06-19 07:48:02.000000000 -0400
@@ -483,6 +483,7 @@
 	unsigned long		i_ino;
 	atomic_t		i_count;
 	umode_t			i_mode;
+	unsigned short		i_blkbits;
 	unsigned int		i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
@@ -490,8 +491,7 @@
 	struct timespec		i_atime;
 	struct timespec		i_mtime;
 	struct timespec		i_ctime;
-	unsigned int		i_blkbits;
-	unsigned long		i_version;
+	unsigned int		i_version;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct mutex		i_mutex;
 	struct rw_semaphore	i_alloc_sem;
@@ -523,7 +523,7 @@
 	__u32			i_generation;
 
 #ifdef CONFIG_DNOTIFY
-	unsigned long		i_dnotify_mask; /* Directory notify events */
+	unsigned int		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 #endif
 

--
