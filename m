Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWF3AUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWF3AUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWF3ATn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:19:43 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:1236 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964790AbWF3ATb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:19:31 -0400
Subject: [RFC][Update][Patch 16/16]Update ext3 superblock definition
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:19:29 -0700
Message-Id: <1151626769.6601.87.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ext3 on-disk superblock definition in the kernel is lagging
behind some e2fsprogs-only fields (the backup of the journal inode,
and the mkfs timestamp), leading to the high bits of the fs size
being declared in a field already reserved by e2fsprogs.  Bring them
back in sync.

Signed-off-by: Stephen Tweedie <sct@redhat.com>


---

 linux-2.6.17-ming/include/linux/ext3_fs.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -puN include/linux/ext3_fs.h~ext3-sb-struc-sync-with-e2fsprog include/linux/ext3_fs.h
--- linux-2.6.17/include/linux/ext3_fs.h~ext3-sb-struc-sync-with-e2fsprog	2006-06-28 16:47:18.377462723 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs.h	2006-06-28 16:47:18.381462264 -0700
@@ -532,13 +532,15 @@ struct ext3_super_block {
 	__u8	s_def_hash_version;	/* Default hash version to use */
 	__u8	s_reserved_char_pad;
 	__u16	s_reserved_word_pad;
-	__le32	s_default_mount_opts;
+/*100*/	__le32	s_default_mount_opts;
 	__le32	s_first_meta_bg; 	/* First metablock block group */
+	__le32	s_mkfs_time;		/* When the filesystem was created */
+	__le32	s_jnl_blocks[17]; 	/* Backup of the journal inode */
 	/* 64bit support valid if EXT3_FEATURE_COMPAT_64BIT */
-	__le32	s_blocks_count_hi;	/* Blocks count */
-/*100*/	__le32	s_r_blocks_count_hi;	/* Reserved blocks count */
+/*150*/	__le32	s_blocks_count_hi;	/* Blocks count */
+	__le32	s_r_blocks_count_hi;	/* Reserved blocks count */
 	__le32	s_free_blocks_count_hi;	/* Free blocks count */
-	__u32	s_reserved[187];	/* Padding to the end of the block */
+	__u32	s_reserved[169];	/* Padding to the end of the block */
 };
 
 

_


