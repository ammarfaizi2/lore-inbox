Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319312AbSHNUr2>; Wed, 14 Aug 2002 16:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319320AbSHNUq5>; Wed, 14 Aug 2002 16:46:57 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:62166 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319310AbSHNUpR>; Wed, 14 Aug 2002 16:45:17 -0400
Date: Wed, 14 Aug 2002 16:49:08 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 26/38: SERVER: new routine fh_dup2()
Message-ID: <Pine.SOL.4.44.0208141648380.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Define fh_dup2(), which copies a _verified_ filehandle, taking care
of refcounts accordingly.  (This will be used by RESTOREFH/SAVEFH and
a few other places.)

--- old/include/linux/nfsd/nfsfh.h	Thu Aug  1 16:16:29 2002
+++ new/include/linux/nfsd/nfsfh.h	Sun Aug 11 22:56:12 2002
@@ -238,6 +238,14 @@ fh_copy(struct svc_fh *dst, struct svc_f
 	return dst;
 }

+static __inline__ void
+fh_dup2(struct svc_fh *dst, struct svc_fh *src)
+{
+	fh_put(dst);
+	dget(src->fh_dentry);
+	*dst = *src;
+}
+
 static __inline__ struct svc_fh *
 fh_init(struct svc_fh *fhp, int maxsize)
 {

