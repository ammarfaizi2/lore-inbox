Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273463AbRJDLCS>; Thu, 4 Oct 2001 07:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273487AbRJDLCI>; Thu, 4 Oct 2001 07:02:08 -0400
Received: from mons.uio.no ([129.240.130.14]:39346 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S273463AbRJDLBs>;
	Thu, 4 Oct 2001 07:01:48 -0400
To: Nicolas Mailhot <Nicolas.Mailhot@one2team.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Symlinks broken on 2.4.10-ac[3-4] nfs
In-Reply-To: <20011004115236.A9373@ulysse.olympe.o2t>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Oct 2001 13:02:14 +0200
In-Reply-To: Nicolas Mailhot's message of "Thu, 4 Oct 2001 11:52:36 +0200"
Message-ID: <shshetfvfbd.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's a known bug in the 2.4.10 NFS server code. The following patch
fixes it...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.10/fs/nfsd/nfs3xdr.c linux-2.4.10-symlinks/fs/nfsd/nfs3xdr.c
--- linux-2.4.10/fs/nfsd/nfs3xdr.c	Mon Sep 24 00:33:20 2001
+++ linux-2.4.10-symlinks/fs/nfsd/nfs3xdr.c	Thu Oct  4 12:59:49 2001
@@ -99,7 +99,7 @@
 	char		*name;
 	int		i;
 
-	if ((p = xdr_decode_string_inplace(p, namp, lenp, NFS3_MAXPATHLEN)) != NULL) {
+	if ((p = xdr_decode_string(p, namp, lenp, NFS3_MAXPATHLEN)) != NULL) {
 		for (i = 0, name = *namp; i < *lenp; i++, name++) {
 			if (*name == '\0')
 				return NULL;

