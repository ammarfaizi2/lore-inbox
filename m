Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319161AbSHMW7w>; Tue, 13 Aug 2002 18:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319160AbSHMW7U>; Tue, 13 Aug 2002 18:59:20 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:13051 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319106AbSHMW5e>; Tue, 13 Aug 2002 18:57:34 -0400
Date: Tue, 13 Aug 2002 19:01:22 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 13/38: CLIENT: space_used in nfs_fattr
Message-ID: <Pine.SOL.4.44.0208131901030.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the NFS_ATTR_FATTR_V4 flag is set, use the NFSv3 convention for
the 'space_used' part of the fattr.

--- old/fs/nfs/inode.c	Tue Jul 30 10:28:00 2002
+++ new/fs/nfs/inode.c	Tue Jul 30 10:32:49 2002
@@ -714,7 +714,7 @@ __nfs_fhget(struct super_block *sb, stru
 		inode->i_nlink = fattr->nlink;
 		inode->i_uid = fattr->uid;
 		inode->i_gid = fattr->gid;
-		if (fattr->valid & NFS_ATTR_FATTR_V3) {
+		if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 			/*
 			 * report the blocks in 512byte units
 			 */
@@ -1103,7 +1103,7 @@ __nfs_refresh_inode(struct inode *inode,
 	inode->i_uid = fattr->uid;
 	inode->i_gid = fattr->gid;

-	if (fattr->valid & NFS_ATTR_FATTR_V3) {
+	if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 		/*
 		 * report the blocks in 512byte units
 		 */

