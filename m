Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSHTK4w>; Tue, 20 Aug 2002 06:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSHTK4v>; Tue, 20 Aug 2002 06:56:51 -0400
Received: from reload.namesys.com ([212.16.7.75]:10880 "EHLO
	reload.namesys.com") by vger.kernel.org with ESMTP
	id <S316853AbSHTK4u>; Tue, 20 Aug 2002 06:56:50 -0400
To: torvalds@transmeta.com, reiser@namesys.com, green@namesys.com,
       linux-kernel@vger.kernel.org
Subject: [BK] [2.5] reiserfs changeset 2 of 3
Message-Id: <20020820110050.9E3E4A8C49@reload.namesys.com>
Date: Tue, 20 Aug 2002 15:00:50 +0400 (MSD)
From: reiser@reload.namesys.com (Hans Reiser)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This changeset corrects logic in reiserfs code that calculates amount
   of blocks file will take. Please apply.
   You can get it from bk://thebsh.namesys.com/reiser3-linux-2.5

Diffstat:
 inode.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.500   -> 1.501  
#	 fs/reiserfs/inode.c	1.63    -> 1.64   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/20	green@angband.namesys.com	1.501
# Corrected calculation of amount of blocks that file occupies on reiserfs.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Tue Aug 20 13:58:51 2002
+++ b/fs/reiserfs/inode.c	Tue Aug 20 13:58:51 2002
@@ -919,7 +919,7 @@
 	inode->i_blocks = sd_v1_blocks(sd);
 	inode->i_generation = le32_to_cpu (INODE_PKEY (inode)->k_dir_id);
 	blocks = (inode->i_size + 511) >> 9;
-	blocks = _ROUND_UP (blocks, inode->i_blksize >> 9);
+	blocks = _ROUND_UP (blocks, inode->i_sb->s_blocksize >> 9);
 	if (inode->i_blocks > blocks) {
 	    // there was a bug in <=3.5.23 when i_blocks could take negative
 	    // values. Starting from 3.5.17 this value could even be stored in
