Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319084AbSHMW5P>; Tue, 13 Aug 2002 18:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319103AbSHMW4e>; Tue, 13 Aug 2002 18:56:34 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:41869 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319084AbSHMWz5>; Tue, 13 Aug 2002 18:55:57 -0400
Date: Tue, 13 Aug 2002 18:59:45 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 09/38: CLIENT: change fsid in 'struct nfs_fattr' 
Message-ID: <Pine.SOL.4.44.0208131859230.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In NFSv4, an fsid is a 64-bit major number together with a 64-bit
minor number.  In previous versions, an fsid is a single number.
This patch changes 'struct nfs_fattr' accordingly.

--- old/include/linux/nfs_xdr.h	Mon Jul 29 22:59:17 2002
+++ new/include/linux/nfs_xdr.h	Mon Jul 29 23:12:45 2002
@@ -22,12 +22,19 @@ struct nfs_fattr {
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
 };
+#define fsid			fsid_u.nfs3

 #define NFS_ATTR_WCC		0x0001		/* pre-op WCC data    */
 #define NFS_ATTR_FATTR		0x0002		/* post-op attributes */

