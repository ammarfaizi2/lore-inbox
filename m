Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319293AbSHNVaA>; Wed, 14 Aug 2002 17:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319374AbSHNV3x>; Wed, 14 Aug 2002 17:29:53 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:65236 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319293AbSHNUiG>; Wed, 14 Aug 2002 16:38:06 -0400
Date: Wed, 14 Aug 2002 16:41:56 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 12/38: CLIENT: space_used in nfs_fattr
Message-ID: <Pine.SOL.4.44.0208141641320.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the NFS_ATTR_FATTR_V4 flag is set, use the NFSv3 convention for
the 'space_used' part of the fattr.

--- old/fs/nfs/inode.c	Sun Aug 11 20:39:02 2002
+++ new/fs/nfs/inode.c	Sun Aug 11 20:39:39 2002
@@ -727,7 +727,7 @@ __nfs_fhget(struct super_block *sb, stru
 		inode->i_nlink = fattr->nlink;
 		inode->i_uid = fattr->uid;
 		inode->i_gid = fattr->gid;
-		if (fattr->valid & NFS_ATTR_FATTR_V3) {
+		if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 			/*
 			 * report the blocks in 512byte units
 			 */
@@ -1138,7 +1138,7 @@ __nfs_refresh_inode(struct inode *inode,
 	inode->i_uid = fattr->uid;
 	inode->i_gid = fattr->gid;

-	if (fattr->valid & NFS_ATTR_FATTR_V3) {
+	if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 		/*
 		 * report the blocks in 512byte units
 		 */

