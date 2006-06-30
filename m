Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWF3AVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWF3AVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWF3ATe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:19:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:56486 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964789AbWF3ATX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:19:23 -0400
Subject: [RFC][Update][Patch 15/16] compile warning fix and change 64bit to
	INCOMPAT feature
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:19:21 -0700
Message-Id: <1151626761.6601.85.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the 64bit to INCOMPAT feature, and fixed compile warning in the 64bit_metadata patch.

Signed-off-by: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.17-ming/include/linux/ext3_fs.h |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff -puN include/linux/ext3_fs.h~64bit-incompat-flag-change include/linux/ext3_fs.h
--- linux-2.6.17/include/linux/ext3_fs.h~64bit-incompat-flag-change	2006-06-28 16:47:16.224709734 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs.h	2006-06-28 16:49:17.471797610 -0700
@@ -136,6 +136,9 @@ struct ext3_group_desc
 	__le32	bg_reserved[3];
 };
 
+#ifdef __KERNEL__
+#include <linux/ext3_fs_i.h>
+#include <linux/ext3_fs_sb.h>
 static inline u32 EXT3_RELATIVE_ENCODE(ext3_fsblk_t group_base,
 				       ext3_fsblk_t fs_block)
 {
@@ -183,7 +186,7 @@ static inline ext3_fsblk_t EXT3_RELATIVE
 	((bg)->bg_inode_bitmap != 0)
 #define EXT3_IS_USED_INODE_TABLE(bg)	\
 	((bg)->bg_inode_table != 0)
-
+#endif
 /*
  * Macro-instructions used to manage group descriptors
  */
@@ -564,8 +567,6 @@ struct ext3_super_block {
 } while (0)
 
 #ifdef __KERNEL__
-#include <linux/ext3_fs_i.h>
-#include <linux/ext3_fs_sb.h>
 static inline struct ext3_sb_info * EXT3_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -636,7 +637,6 @@ static inline struct ext3_inode_info *EX
 #define EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT3_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
 #define EXT3_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
-#define EXT3_FEATURE_RO_COMPAT_64BIT		0x0010
 
 #define EXT3_FEATURE_INCOMPAT_COMPRESSION	0x0001
 #define EXT3_FEATURE_INCOMPAT_FILETYPE		0x0002
@@ -644,16 +644,17 @@ static inline struct ext3_inode_info *EX
 #define EXT3_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
 #define EXT3_FEATURE_INCOMPAT_META_BG		0x0010
 #define EXT3_FEATURE_INCOMPAT_EXTENTS		0x0040 /* extents support */
+#define EXT3_FEATURE_INCOMPAT_64BIT		0x0080
 
 #define EXT3_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT3_FEATURE_INCOMPAT_SUPP	(EXT3_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT3_FEATURE_INCOMPAT_RECOVER| \
 					 EXT3_FEATURE_INCOMPAT_META_BG| \
-					 EXT3_FEATURE_INCOMPAT_EXTENTS)
+					 EXT3_FEATURE_INCOMPAT_EXTENTS| \
+					 EXT3_FEATURE_INCOMPAT_64BIT)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
-					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR| \
-					 EXT3_FEATURE_RO_COMPAT_64BIT)
+					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
 
 /*
  * Default values for user and/or group using reserved blocks

_


