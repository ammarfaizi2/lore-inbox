Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVCCLIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVCCLIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVCCLHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:07:48 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:3764 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262525AbVCCKlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:41:53 -0500
Date: Thu, 3 Mar 2005 11:41:38 +0100
Message-Id: <200503031041.j23Afc5A020702@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 4/16] DocBook: update function parameter description in block/fs code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: update function parameter description in block/fs code
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2028  -> 1.2029 
#	drivers/block/ll_rw_blk.c	1.282   -> 1.283  
#	     kernel/sysctl.c	1.96    -> 1.97   
#	    fs/jbd/journal.c	1.79    -> 1.81   
#	fs/jbd/transaction.c	1.91    -> 1.92   
#	          fs/super.c	1.129   -> 1.130  
#	 include/linux/jbd.h	1.48    -> 1.49   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/01/26	tali@admingilde.org	1.2029
# DocBook: update function parameter description in block/fs code
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Thu Mar  3 11:41:42 2005
+++ b/drivers/block/ll_rw_blk.c	Thu Mar  3 11:41:42 2005
@@ -618,6 +618,7 @@
  * blk_queue_init_tags - initialize the queue tag info
  * @q:  the request queue for the device
  * @depth:  the maximum queue depth supported
+ * @tags: the tag to use
  **/
 int blk_queue_init_tags(request_queue_t *q, int depth,
 			struct blk_queue_tag *tags)
@@ -1963,7 +1964,7 @@
 /**
  * blk_rq_unmap_user - unmap a request with user data
  * @rq:		request to be unmapped
- * @ubuf:	user buffer
+ * @bio:	bio for the request
  * @ulen:	length of user buffer
  *
  * Description:
diff -Nru a/fs/jbd/journal.c b/fs/jbd/journal.c
--- a/fs/jbd/journal.c	Thu Mar  3 11:41:42 2005
+++ b/fs/jbd/journal.c	Thu Mar  3 11:41:42 2005
@@ -1147,6 +1147,10 @@
 
 /**
  *int journal_check_used_features () - Check if features specified are used.
+ * @journal: Journal to check.
+ * @compat: bitmask of compatible features
+ * @ro: bitmask of features that force read-only mount
+ * @incompat: bitmask of incompatible features
  * 
  * Check whether the journal uses all of a given set of
  * features.  Return true (non-zero) if it does. 
@@ -1174,6 +1178,10 @@
 
 /**
  * int journal_check_available_features() - Check feature set in journalling layer
+ * @journal: Journal to check.
+ * @compat: bitmask of compatible features
+ * @ro: bitmask of features that force read-only mount
+ * @incompat: bitmask of incompatible features
  * 
  * Check whether the journaling code supports the use of
  * all of a given set of features on this journal.  Return true
@@ -1206,6 +1214,10 @@
 
 /**
  * int journal_set_features () - Mark a given journal feature in the superblock
+ * @journal: Journal to act on.
+ * @compat: bitmask of compatible features
+ * @ro: bitmask of features that force read-only mount
+ * @incompat: bitmask of incompatible features
  *
  * Mark a given journal feature as present on the
  * superblock.  Returns true if the requested features could be set. 
@@ -1238,6 +1250,7 @@
 
 /**
  * int journal_update_format () - Update on-disk journal structure.
+ * @journal: Journal to act on.
  *
  * Given an initialised but unloaded journal struct, poke about in the
  * on-disk structure to update it to the most recent supported version.
@@ -1538,6 +1551,7 @@
 
 /** 
  * int journal_clear_err () - clears the journal's error state
+ * @journal: journal to act on.
  *
  * An error must be cleared or Acked to take a FS out of readonly
  * mode.
@@ -1557,6 +1571,7 @@
 
 /** 
  * void journal_ack_err() - Ack journal err.
+ * @journal: journal to act on.
  *
  * An error must be cleared or Acked to take a FS out of readonly
  * mode.
@@ -1574,10 +1589,6 @@
 	return 1 << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
 }
 
-/*
- * Simple support for retying memory allocations.  Introduced to help to
- * debug different VM deadlock avoidance strategies. 
- */
 /*
  * Simple support for retying memory allocations.  Introduced to help to
  * debug different VM deadlock avoidance strategies. 
diff -Nru a/fs/jbd/transaction.c b/fs/jbd/transaction.c
--- a/fs/jbd/transaction.c	Thu Mar  3 11:41:43 2005
+++ b/fs/jbd/transaction.c	Thu Mar  3 11:41:43 2005
@@ -742,6 +742,7 @@
  * int journal_get_write_access() - notify intent to modify a buffer for metadata (not data) update.
  * @handle: transaction to add buffer modifications to
  * @bh:     bh to be used for metadata writes
+ * @credits: variable that will receive credits for the buffer
  *
  * Returns an error code or 0 on success.
  *
@@ -1578,7 +1579,7 @@
  * int journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
  * @page: to try and free
- * @gfp_mask: 'IO' mode for try_to_free_buffers()
+ * @unused_gfp_mask: unused
  *
  * 
  * For all the buffers on this page,
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Thu Mar  3 11:41:43 2005
+++ b/fs/super.c	Thu Mar  3 11:41:43 2005
@@ -143,7 +143,7 @@
 
 /**
  *	put_super	-	drop a temporary reference to superblock
- *	@s: superblock in question
+ *	@sb: superblock in question
  *
  *	Drops a temporary reference, frees superblock if there's no
  *	references left.
diff -Nru a/include/linux/jbd.h b/include/linux/jbd.h
--- a/include/linux/jbd.h	Thu Mar  3 11:41:43 2005
+++ b/include/linux/jbd.h	Thu Mar  3 11:41:43 2005
@@ -562,6 +562,7 @@
  * @j_sb_buffer: First part of superblock buffer
  * @j_superblock: Second part of superblock buffer
  * @j_format_version: Version of the superblock format
+ * @j_state_lock: Protect the various scalars in the journal
  * @j_barrier_count:  Number of processes waiting to create a barrier lock
  * @j_barrier: The barrier lock itself
  * @j_running_transaction: The current running transaction..
@@ -589,6 +590,7 @@
  * @j_fs_dev: Device which holds the client fs.  For internal journal this will
  *     be equal to j_dev
  * @j_maxlen: Total maximum capacity of the journal region on disk.
+ * @j_list_lock: Protects the buffer lists and internal buffer state.
  * @j_inode: Optional inode where we store the journal.  If present, all journal
  *     block numbers are mapped into this inode via bmap().
  * @j_tail_sequence:  Sequence number of the oldest transaction in the log 
@@ -604,8 +606,11 @@
  * @j_commit_interval: What is the maximum transaction lifetime before we begin
  *  a commit?
  * @j_commit_timer:  The timer used to wakeup the commit thread
+ * @j_revoke_lock: Protect the revoke table
  * @j_revoke: The revoke table - maintains the list of revoked blocks in the
  *     current transaction.
+ * @j_revoke_table: alternate revoke tables for j_revoke
+ * @j_private: An opaque pointer to fs-private information.
  */
 
 struct journal_s
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Thu Mar  3 11:41:42 2005
+++ b/kernel/sysctl.c	Thu Mar  3 11:41:42 2005
@@ -1368,6 +1368,7 @@
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes a string from/to the user buffer. If the kernel
  * buffer provided is not large enough to hold the string, the
@@ -1584,6 +1585,7 @@
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
@@ -1688,6 +1690,7 @@
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string.
@@ -1820,6 +1823,7 @@
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string.
@@ -1842,6 +1846,7 @@
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
  * values from/to the user buffer, treated as an ASCII string. The values
@@ -1911,6 +1916,7 @@
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
@@ -1933,6 +1939,7 @@
  * @filp: the file structure
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
+ * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string. 
