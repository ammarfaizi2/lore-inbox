Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319294AbSHNUiH>; Wed, 14 Aug 2002 16:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319287AbSHNUhO>; Wed, 14 Aug 2002 16:37:14 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:24793 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319280AbSHNUgE>; Wed, 14 Aug 2002 16:36:04 -0400
Date: Wed, 14 Aug 2002 16:39:55 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 08/38: CLIENT: change fsid in 'struct nfs_fattr' 
Message-ID: <Pine.SOL.4.44.0208141639310.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In NFSv4, an fsid is a 64-bit major number together with a 64-bit
minor number.  In previous versions, an fsid is a single number.
This patch changes 'struct nfs_fattr' accordingly.

--- old/include/linux/nfs_xdr.h	Sun Aug 11 20:27:40 2002
+++ new/include/linux/nfs_xdr.h	Sun Aug 11 20:28:56 2002
@@ -22,13 +22,20 @@ struct nfs_fattr {
 		} nfs3;
 	} du;
 	__u32			rdev;
-	__u64			fsid;
+	union {
+		__u64		nfs3;		/* also nfs2 */
+		struct {
+			__u64	major;
+			__u64	minor;
+		} nfs4;
+	} fsid_u;
 	__u64			fileid;
 	__u64			atime;
 	__u64			mtime;
 	__u64			ctime;
 	unsigned long		timestamp;
 };
+#define fsid			fsid_u.nfs3

 #define NFS_ATTR_WCC		0x0001		/* pre-op WCC data    */
 #define NFS_ATTR_FATTR		0x0002		/* post-op attributes */

