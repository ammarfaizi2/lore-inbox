Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319145AbSHMXID>; Tue, 13 Aug 2002 19:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319137AbSHMXH0>; Tue, 13 Aug 2002 19:07:26 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:61948 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319097AbSHMXGA>; Tue, 13 Aug 2002 19:06:00 -0400
Date: Tue, 13 Aug 2002 19:09:49 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 31/38: SERVER: allow type==0 in nfsd_unlink()
Message-ID: <Pine.SOL.4.44.0208131909190.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If nfsd_unlink() is called with @type equal to 0, then let it do the
right thing regardless of the type of the file being unlinked.  This
is needed for the NFSv4 REMOVE operation, which works for any type of
file, even directories.

--- old/fs/nfsd/vfs.c	Tue Jul 30 23:28:23 2002
+++ new/fs/nfsd/vfs.c	Tue Jul 30 23:59:38 2002
@@ -1329,6 +1329,9 @@ nfsd_unlink(struct svc_rqst *rqstp, stru
 		goto out;
 	}

+	if (!type)
+		type = rdentry->d_inode->i_mode & S_IFMT;
+
 	if (type != S_IFDIR) { /* It's UNLINK */
 #ifdef MSNFS
 		if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&

