Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263312AbTC0RFq>; Thu, 27 Mar 2003 12:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263308AbTC0RE6>; Thu, 27 Mar 2003 12:04:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54149
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263307AbTC0REs>; Thu, 27 Mar 2003 12:04:48 -0500
Date: Thu, 27 Mar 2003 18:22:16 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271822.h2RIMGxk019684@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make cramfs compile again

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/fs/cramfs/inode.c linux-2.5.66-ac1/fs/cramfs/inode.c
--- linux-2.5.66-bk3/fs/cramfs/inode.c	2003-03-27 17:13:33.000000000 +0000
+++ linux-2.5.66-ac1/fs/cramfs/inode.c	2003-03-26 20:16:08.000000000 +0000
@@ -43,6 +43,7 @@
 static struct inode *get_cramfs_inode(struct super_block *sb, struct cramfs_inode * cramfs_inode)
 {
 	struct inode * inode = new_inode(sb);
+	static struct timespec zerotime = { 0, 0 };
 
 	if (inode) {
 		inode->i_mode = cramfs_inode->mode;
@@ -51,7 +52,8 @@
 		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
-		inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
+		/* Struct copy intentional */
+		inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
 		inode->i_ino = CRAMINO(cramfs_inode);
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory
