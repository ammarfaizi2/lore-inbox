Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264286AbTCXREa>; Mon, 24 Mar 2003 12:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264287AbTCXQtn>; Mon, 24 Mar 2003 11:49:43 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:49642 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264286AbTCXQa7>; Mon, 24 Mar 2003 11:30:59 -0500
Message-Id: <200303241642.h2OGg935008314@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:56 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Add missing time initialisation to get_cramfs_inode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/cramfs/inode.c linux-2.5/fs/cramfs/inode.c
--- bk-linus/fs/cramfs/inode.c	2003-03-08 09:57:39.000000000 +0000
+++ linux-2.5/fs/cramfs/inode.c	2003-03-22 12:49:42.000000000 +0000
@@ -51,6 +51,7 @@ static struct inode *get_cramfs_inode(st
 		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
+		inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
 		inode->i_ino = CRAMINO(cramfs_inode);
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory
