Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319151AbSHMXFp>; Tue, 13 Aug 2002 19:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319147AbSHMXFY>; Tue, 13 Aug 2002 19:05:24 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:44796 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319097AbSHMXEM>; Tue, 13 Aug 2002 19:04:12 -0400
Date: Tue, 13 Aug 2002 19:08:00 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 27/38: SERVER: new routine fh_dup2()
Message-ID: <Pine.SOL.4.44.0208131907310.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Define fh_dup2(), which copies a _verified_ filehandle, taking care
of refcounts accordingly.  (This will be used by RESTOREFH/SAVEFH and
a few other places.)

--- old/include/linux/nfsd/nfsfh.h	Tue Jul 30 22:12:36 2002
+++ new/include/linux/nfsd/nfsfh.h	Mon Jul 29 11:50:09 2002
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

