Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319352AbSHNVV2>; Wed, 14 Aug 2002 17:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319360AbSHNVU0>; Wed, 14 Aug 2002 17:20:26 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:28631 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319305AbSHNUrW>; Wed, 14 Aug 2002 16:47:22 -0400
Date: Wed, 14 Aug 2002 16:51:12 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 30/38: SERVER: allow type==0 in nfsd_unlink()
Message-ID: <Pine.SOL.4.44.0208141650500.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If nfsd_unlink() is called with @type equal to 0, then let it do the
right thing regardless of the type of the file being unlinked.  This
is needed for the NFSv4 REMOVE operation, which works for any type of
file, even directories.

--- old/fs/nfsd/vfs.c	Sun Aug 11 23:08:03 2002
+++ new/fs/nfsd/vfs.c	Sun Aug 11 23:08:24 2002
@@ -1329,6 +1329,9 @@ nfsd_unlink(struct svc_rqst *rqstp, stru
 		goto out;
 	}

+	if (!type)
+		type = rdentry->d_inode->i_mode & S_IFMT;
+
 	if (type != S_IFDIR) { /* It's UNLINK */
 #ifdef MSNFS
 		if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&

