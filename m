Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266237AbSKLG1c>; Tue, 12 Nov 2002 01:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbSKLG11>; Tue, 12 Nov 2002 01:27:27 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:12178 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266237AbSKLG01>;
	Tue, 12 Nov 2002 01:26:27 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2/4]: Ext2/3 updates: Cleanup: Eliminate EXT3/2_DEF_RES[UG]ID
From: tytso@mit.edu
Message-Id: <E18BUbr-0005iz-00@snap.thunk.org>
Date: Tue, 12 Nov 2002 01:33:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup: Eliminate EXT3/2_DEF_RES[UG]ID

Remove dead code.  Resuid and resgid (the user and group that is allowed
to allocate the last reserved_blocks worth of blocks on the filesystem)
can never be specified at compile time; the value in the superblock is
used, unless overidden by a mount option.  EXT3_DEF_RES[UG]ID is vestigal,
and should have been removed when the corresponding fields were added
to the superblock.  (In ext2fs, the code was removed in an earlier
cleanup, but the header file definitions weren't cleaned up.)

fs/ext3/super.c         |    3 ---
include/linux/ext2_fs.h |    6 ------
include/linux/ext3_fs.h |    6 ------
3 files changed, 15 deletions(-)

diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Tue Nov 12 01:12:30 2002
+++ b/fs/ext3/super.c	Tue Nov 12 01:12:30 2002
@@ -1018,9 +1018,6 @@
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(*sbi));
-	sbi->s_mount_opt = 0;
-	sbi->s_resuid = EXT3_DEF_RESUID;
-	sbi->s_resgid = EXT3_DEF_RESGID;
 	setup_ro_after(sb);
 
 	blocksize = sb_min_blocksize(sb, EXT3_MIN_BLOCK_SIZE);
diff -Nru a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
--- a/include/linux/ext2_fs.h	Tue Nov 12 01:12:30 2002
+++ b/include/linux/ext2_fs.h	Tue Nov 12 01:12:30 2002
@@ -478,12 +478,6 @@
 #define EXT2_FEATURE_INCOMPAT_UNSUPPORTED	~EXT2_FEATURE_INCOMPAT_SUPP
 
 /*
- * Default values for user and/or group using reserved blocks
- */
-#define	EXT2_DEF_RESUID		0
-#define	EXT2_DEF_RESGID		0
-
-/*
  * Default mount options
  */
 #define EXT2_DEFM_DEBUG		0x0001
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Tue Nov 12 01:12:30 2002
+++ b/include/linux/ext3_fs.h	Tue Nov 12 01:12:30 2002
@@ -521,12 +521,6 @@
 					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
 
 /*
- * Default values for user and/or group using reserved blocks
- */
-#define	EXT3_DEF_RESUID		0
-#define	EXT3_DEF_RESGID		0
-
-/*
  * Default mount options
  */
 #define EXT3_DEFM_DEBUG		0x0001
