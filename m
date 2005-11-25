Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVKYTV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVKYTV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbVKYTV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:21:58 -0500
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:18821 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751056AbVKYTV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:21:57 -0500
Date: Fri, 25 Nov 2005 17:24:58 -0200
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] ext3: remove trailing newlines from ext3_warning() calls
Message-ID: <20051125192458.GC19410@br.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: glommer@br.ibm.com (Glauber de Oliveira Costa)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This simple cleanup patch removes the trailing newlines in calls to
ext3_warning(). This function already adds a trailing newline to the end
of messages.

Signed-off-by: Glauber de Oliveira Costa <glommer@br.ibm.com>
---


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ext3-newlines

--- linux-2.6.14.2-orig/fs/ext3/resize.c	2005-11-25 15:47:41.000000000 +0000
+++ linux-2.6.14.2-cleanp/fs/ext3/resize.c	2005-11-25 15:56:23.000000000 +0000
@@ -334,7 +334,7 @@ static int verify_reserved_gdb(struct su
 	while ((grp = ext3_list_backups(sb, &three, &five, &seven)) < end) {
 		if (le32_to_cpu(*p++) != grp * EXT3_BLOCKS_PER_GROUP(sb) + blk){
 			ext3_warning(sb, __FUNCTION__,
-				     "reserved GDT %ld missing grp %d (%ld)\n",
+				     "reserved GDT %ld missing grp %d (%ld)",
 				     blk, grp,
 				     grp * EXT3_BLOCKS_PER_GROUP(sb) + blk);
 			return -EINVAL;
@@ -387,7 +387,7 @@ static int add_new_gdb(handle_t *handle,
 	if (EXT3_SB(sb)->s_sbh->b_blocknr !=
 	    le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block)) {
 		ext3_warning(sb, __FUNCTION__,
-			"won't resize using backup superblock at %llu\n",
+			"won't resize using backup superblock at %llu",
 			(unsigned long long)EXT3_SB(sb)->s_sbh->b_blocknr);
 		return -EPERM;
 	}
@@ -411,7 +411,7 @@ static int add_new_gdb(handle_t *handle,
 	data = (__u32 *)dind->b_data;
 	if (le32_to_cpu(data[gdb_num % EXT3_ADDR_PER_BLOCK(sb)]) != gdblock) {
 		ext3_warning(sb, __FUNCTION__,
-			     "new group %u GDT block %lu not reserved\n",
+			     "new group %u GDT block %lu not reserved",
 			     input->group, gdblock);
 		err = -EINVAL;
 		goto exit_dind;
@@ -534,7 +534,7 @@ static int reserve_backup_gdb(handle_t *
 	for (res = 0; res < reserved_gdb; res++, blk++) {
 		if (le32_to_cpu(*data) != blk) {
 			ext3_warning(sb, __FUNCTION__,
-				     "reserved block %lu not at offset %ld\n",
+				     "reserved block %lu not at offset %ld",
 				     blk, (long)(data - (__u32 *)dind->b_data));
 			err = -EINVAL;
 			goto exit_bh;
@@ -673,7 +673,7 @@ exit_err:
 	if (err) {
 		ext3_warning(sb, __FUNCTION__,
 			     "can't update backup for group %d (err %d), "
-			     "forcing fsck on next reboot\n", group, err);
+			     "forcing fsck on next reboot", group, err);
 		sbi->s_mount_state &= ~EXT3_VALID_FS;
 		sbi->s_es->s_state &= ~cpu_to_le16(EXT3_VALID_FS);
 		mark_buffer_dirty(sbi->s_sbh);
@@ -712,7 +712,7 @@ int ext3_group_add(struct super_block *s
 	if (gdb_off == 0 && !EXT3_HAS_RO_COMPAT_FEATURE(sb,
 					EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER)) {
 		ext3_warning(sb, __FUNCTION__,
-			     "Can't resize non-sparse filesystem further\n");
+			     "Can't resize non-sparse filesystem further");
 		return -EPERM;
 	}
 
@@ -720,13 +720,13 @@ int ext3_group_add(struct super_block *s
 		if (!EXT3_HAS_COMPAT_FEATURE(sb,
 					     EXT3_FEATURE_COMPAT_RESIZE_INODE)){
 			ext3_warning(sb, __FUNCTION__,
-				     "No reserved GDT blocks, can't resize\n");
+				     "No reserved GDT blocks, can't resize");
 			return -EPERM;
 		}
 		inode = iget(sb, EXT3_RESIZE_INO);
 		if (!inode || is_bad_inode(inode)) {
 			ext3_warning(sb, __FUNCTION__,
-				     "Error opening resize inode\n");
+				     "Error opening resize inode");
 			iput(inode);
 			return -ENOENT;
 		}
@@ -756,7 +756,7 @@ int ext3_group_add(struct super_block *s
 	lock_super(sb);
 	if (input->group != EXT3_SB(sb)->s_groups_count) {
 		ext3_warning(sb, __FUNCTION__,
-			     "multiple resizers run on filesystem!\n");
+			     "multiple resizers run on filesystem!");
 		goto exit_journal;
 	}
 
@@ -926,7 +926,7 @@ int ext3_group_extend(struct super_block
 
 	if (last == 0) {
 		ext3_warning(sb, __FUNCTION__,
-			     "need to use ext2online to resize further\n");
+			     "need to use ext2online to resize further");
 		return -EPERM;
 	}
 
@@ -962,7 +962,7 @@ int ext3_group_extend(struct super_block
 	lock_super(sb);
 	if (o_blocks_count != le32_to_cpu(es->s_blocks_count)) {
 		ext3_warning(sb, __FUNCTION__,
-			     "multiple resizers run on filesystem!\n");
+			     "multiple resizers run on filesystem!");
 		err = -EBUSY;
 		goto exit_put;
 	}
--- linux-2.6.14.2-orig/fs/ext3/namei.c	2005-11-11 05:33:12.000000000 +0000
+++ linux-2.6.14.2-cleanp/fs/ext3/namei.c	2005-11-25 16:02:13.000000000 +0000
@@ -1474,7 +1474,7 @@ static int ext3_dx_add_entry(handle_t *h
 		if (levels && (dx_get_count(frames->entries) ==
 			       dx_get_limit(frames->entries))) {
 			ext3_warning(sb, __FUNCTION__,
-				     "Directory index full!\n");
+				     "Directory index full!");
 			err = -ENOSPC;
 			goto cleanup;
 		}
--- linux-2.6.14.2-orig/fs/ext3/ialloc.c	2005-11-11 12:17:39.000000000 +0000
+++ linux-2.6.14.2-cleanp/fs/ext3/ialloc.c	2005-11-25 16:01:19.000000000 +0000
@@ -650,7 +650,7 @@ struct inode *ext3_orphan_get(struct sup
 	/* Error cases - e2fsck has already cleaned up for us */
 	if (ino > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
-			     "bad orphan ino %lu!  e2fsck was run?\n", ino);
+			     "bad orphan ino %lu!  e2fsck was run?", ino);
 		goto out;
 	}
 
@@ -659,7 +659,7 @@ struct inode *ext3_orphan_get(struct sup
 	bitmap_bh = read_inode_bitmap(sb, block_group);
 	if (!bitmap_bh) {
 		ext3_warning(sb, __FUNCTION__,
-			     "inode bitmap error for orphan %lu\n", ino);
+			     "inode bitmap error for orphan %lu", ino);
 		goto out;
 	}
 
@@ -671,7 +671,7 @@ struct inode *ext3_orphan_get(struct sup
 			!(inode = iget(sb, ino)) || is_bad_inode(inode) ||
 			NEXT_ORPHAN(inode) > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
-			     "bad orphan inode %lu!  e2fsck was run?\n", ino);
+			     "bad orphan inode %lu!  e2fsck was run?", ino);
 		printk(KERN_NOTICE "ext3_test_bit(bit=%d, block=%llu) = %d\n",
 		       bit, (unsigned long long)bitmap_bh->b_blocknr,
 		       ext3_test_bit(bit, bitmap_bh->b_data));

--2B/JsCI69OhZNC5r--
