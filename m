Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319302AbSHNUrV>; Wed, 14 Aug 2002 16:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319297AbSHNUqq>; Wed, 14 Aug 2002 16:46:46 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:50390 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319306AbSHNUoY>; Wed, 14 Aug 2002 16:44:24 -0400
Date: Wed, 14 Aug 2002 16:48:15 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 24/38: SERVER: return err_nofilehandle if missing fh
 in fh_verify()
Message-ID: <Pine.SOL.4.44.0208141647520.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Return nfserr_nofilehandle (v4 only) in fh_verify() if the filehandle
has not been set.

--- old/fs/nfsd/nfsfh.c	Sun Aug 11 22:53:39 2002
+++ new/fs/nfsd/nfsfh.c	Sun Aug 11 22:54:13 2002
@@ -109,6 +109,8 @@ fh_verify(struct svc_rqst *rqstp, struct
 		error = nfserr_stale;
 		if (rqstp->rq_vers > 2)
 			error = nfserr_badhandle;
+		if (rqstp->rq_vers == 4 && fh->fh_size == 0)
+			return nfserr_nofilehandle;

 		if (fh->fh_version == 1) {
 			datap = fh->fh_auth;

