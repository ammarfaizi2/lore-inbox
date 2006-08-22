Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWHVLB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWHVLB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWHVLB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:01:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22983 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S932164AbWHVLB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:01:56 -0400
Date: Tue, 22 Aug 2006 13:01:45 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200608221101.k7MB1jm20630@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: ext2 fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mounting an ext2 filesystem with zero s_inodes_per_group
will cause a divide error. Below a patch against 2.6.17.8.

Andries

diff -uprN -X /linux/dontdiff a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	2006-08-07 16:01:12.000000000 +0200
+++ b/fs/ext2/super.c	2006-08-22 12:36:45.682620352 +0200
@@ -776,7 +776,7 @@ static int ext2_fill_super(struct super_
 	if (EXT2_INODE_SIZE(sb) == 0)
 		goto cantfind_ext2;
 	sbi->s_inodes_per_block = sb->s_blocksize / EXT2_INODE_SIZE(sb);
-	if (sbi->s_inodes_per_block == 0)
+	if (sbi->s_inodes_per_block == 0 || sbi->s_inodes_per_group == 0)
 		goto cantfind_ext2;
 	sbi->s_itb_per_group = sbi->s_inodes_per_group /
 					sbi->s_inodes_per_block;
