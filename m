Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbSJ1NK5>; Mon, 28 Oct 2002 08:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSJ1NK5>; Mon, 28 Oct 2002 08:10:57 -0500
Received: from shockwave.systems.pipex.net ([62.241.160.9]:46535 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S262454AbSJ1NK4>; Mon, 28 Oct 2002 08:10:56 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Angus Sawyer <angus.sawyer@dsl.pipex.com>
Reply-To: angus.sawyer@dsl.pipex.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] EXT3 fs divide by 0 in ext3_fill_super (2.5.44)
Date: Mon, 28 Oct 2002 13:17:16 +0000
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210281317.16268.angus.sawyer@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

problem:

attempting to mount an ext3 fs on a stopped md/raid1 array caused a divide by 
0 error in ext3_fill_super.

Fix duplicates check already in ext2.

patch:

--- linux-2.5.44/fs/ext3/super.c	Wed Oct 23 16:19:08 2002
+++ linux/fs/ext3/super.c	Mon Oct 28 11:29:33 2002
@@ -986,6 +986,10 @@
 		goto out_fail;
 
 	blocksize = sb_min_blocksize(sb, EXT3_MIN_BLOCK_SIZE);
+	if (!blocksize) {
+		printk(KERN_ERR "EXT3-fs: unable to set blocksize\n");
+		goto out_fail;
+	}
 
 	/*
 	 * The ext3 superblock will not be buffer aligned for other than 1kB

