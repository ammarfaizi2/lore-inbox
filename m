Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSCMBNF>; Tue, 12 Mar 2002 20:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291625AbSCMBM4>; Tue, 12 Mar 2002 20:12:56 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:40148 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S291620AbSCMBMp>; Tue, 12 Mar 2002 20:12:45 -0500
Message-ID: <3C8EA775.3000306@didntduck.org>
Date: Tue, 12 Mar 2002 20:12:21 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] correction to super_block cleanups
Content-Type: multipart/mixed;
 boundary="------------030508020701050200070404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030508020701050200070404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I forgot to zero out the newly allocated memory in the previous patches. 
  First patch is for the changes included in 2.5.7-pre1, second is 
incremental to the ext2 and ncp patches.

-- 

						Brian Gerst

--------------030508020701050200070404
Content-Type: text/plain;
 name="sb-zeroing-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-zeroing-1"

diff -ruN linux/fs/cramfs/inode.c linux2/fs/cramfs/inode.c
--- linux/fs/cramfs/inode.c	Tue Mar 12 17:35:10 2002
+++ linux2/fs/cramfs/inode.c	Tue Mar 12 20:01:37 2002
@@ -201,6 +201,7 @@
 	if (!sbi)
 		return -ENOMEM;
 	sb->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(struct cramfs_sb_info));
 
 	sb_set_blocksize(sb, PAGE_CACHE_SIZE);
 
diff -ruN linux/fs/minix/inode.c linux2/fs/minix/inode.c
--- linux/fs/minix/inode.c	Tue Mar 12 17:35:10 2002
+++ linux2/fs/minix/inode.c	Tue Mar 12 20:01:10 2002
@@ -178,6 +178,7 @@
 	if (!sbi)
 		return -ENOMEM;
 	s->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(struct minix_sb_info));
 
 	/* N.B. These should be compile-time tests.
 	   Unfortunately that is impossible. */

--------------030508020701050200070404
Content-Type: text/plain;
 name="sb-zeroing-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-zeroing-2"

diff -ruN linux/fs/ext2/super.c linux2/fs/ext2/super.c
--- linux/fs/ext2/super.c	Tue Mar 12 19:59:57 2002
+++ linux2/fs/ext2/super.c	Tue Mar 12 20:03:16 2002
@@ -469,6 +469,7 @@
 	if (!sbi)
 		return -ENOMEM;
 	sb->u.generic_sbp = sbi;
+	memset(sbi, 0, sizeof(struct ext2_super_block));
 
 	/*
 	 * See what the current blocksize for the device is, and
diff -ruN linux/fs/ncpfs/inode.c linux2/fs/ncpfs/inode.c
--- linux/fs/ncpfs/inode.c	Tue Mar 12 19:59:51 2002
+++ linux2/fs/ncpfs/inode.c	Tue Mar 12 20:04:09 2002
@@ -319,6 +319,8 @@
 	if (!server)
 		return -ENOMEM;
 	sb->u.generic_sbp = server;
+	memset(server, 0, sizeof(struct ncp_server));
+
 	error = -EFAULT;
 	if (raw_data == NULL)
 		goto out;

--------------030508020701050200070404--

