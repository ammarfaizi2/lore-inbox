Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUI3NYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUI3NYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUI3NX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:23:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12696 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269256AbUI3NXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:23:53 -0400
Date: Thu, 30 Sep 2004 14:23:24 +0100
Message-Id: <200409301323.i8UDNOSw004765@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 2/10]: ext3 online resize: printk debug level
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emit debugging printks at KERN_DEBUG loglevel.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc2-mm4/fs/ext3/resize.c.=K0001=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/resize.c
@@ -44,7 +44,7 @@ static int verify_group_input(struct sup
 		input->blocks_count - 2 - overhead - sbi->s_itb_per_group;
 
 	if (test_opt(sb, DEBUG))
-		printk("EXT3-fs: adding %s group %u: %u blocks "
+		printk(KERN_DEBUG "EXT3-fs: adding %s group %u: %u blocks "
 		       "(%d free, %u reserved)\n",
 		       ext3_bg_has_super(sb, input->group) ? "normal" :
 		       "no-super", input->group, input->blocks_count,
@@ -373,7 +373,8 @@ static int add_new_gdb(handle_t *handle,
 	int err;
 
 	if (test_opt(sb, DEBUG))
-		printk("EXT3-fs: ext3_add_new_gdb: adding group block %lu\n",
+		printk(KERN_DEBUG 
+		       "EXT3-fs: ext3_add_new_gdb: adding group block %lu\n",
 		       gdb_num);
 
 	/*
@@ -851,7 +852,7 @@ int ext3_group_extend(struct super_block
 	o_groups_count = EXT3_SB(sb)->s_groups_count;
 
 	if (test_opt(sb, DEBUG))
-		printk("EXT3-fs: extending last group from %lu to %lu blocks\n",
+		printk(KERN_DEBUG "EXT3-fs: extending last group from %lu to %lu blocks\n",
 		       o_blocks_count, n_blocks_count);
 
 	if (n_blocks_count == 0 || n_blocks_count == o_blocks_count)
@@ -940,7 +941,7 @@ int ext3_group_extend(struct super_block
 	if ((err = ext3_journal_stop(handle)))
 		goto exit_put;
 	if (test_opt(sb, DEBUG))
-		printk("EXT3-fs: extended group to %u blocks\n",
+		printk(KERN_DEBUG "EXT3-fs: extended group to %u blocks\n",
 		       le32_to_cpu(es->s_blocks_count));
 	update_backups(sb, inode, EXT3_SB(sb)->s_sbh->b_blocknr, (char *)es,
 		       sizeof(struct ext3_super_block));
