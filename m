Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319144AbSHMXFr>; Tue, 13 Aug 2002 19:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319130AbSHMXFS>; Tue, 13 Aug 2002 19:05:18 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:28924 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319168AbSHMXC4>; Tue, 13 Aug 2002 19:02:56 -0400
Date: Tue, 13 Aug 2002 19:06:40 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 25/38: SERVER: return err_nofilehandle if missing fh in
 fh_verify()
Message-ID: <Pine.SOL.4.44.0208131906180.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Return nfserr_nofilehandle (v4 only) in fh_verify() if the filehandle
has not been set.

--- old/fs/nfsd/nfsfh.c	Tue Jul 30 22:20:35 2002
+++ new/fs/nfsd/nfsfh.c	Mon Jul 29 12:39:43 2002
@@ -109,6 +109,8 @@ fh_verify(struct svc_rqst *rqstp, struct
 		error = nfserr_stale;
 		if (rqstp->rq_vers > 2)
 			error = nfserr_badhandle;
+		if (rqstp->rq_vers == 4 && fh->fh_size == 0)
+			return nfserr_nofilehandle;

 		if (fh->fh_version == 1) {
 			datap = fh->fh_auth;

