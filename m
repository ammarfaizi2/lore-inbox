Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSIIL1K>; Mon, 9 Sep 2002 07:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSIIL1K>; Mon, 9 Sep 2002 07:27:10 -0400
Received: from reload.namesys.com ([212.16.7.75]:5760 "EHLO reload.namesys.com")
	by vger.kernel.org with ESMTP id <S317066AbSIIL1J>;
	Mon, 9 Sep 2002 07:27:09 -0400
To: green@namesys.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [BK] PATCH ReiserFS 2 of 3 RESEND
Message-Id: <20020909113147.C5983A7CE2@reload.namesys.com>
Date: Mon,  9 Sep 2002 15:31:47 +0400 (MSD)
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
