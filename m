Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319317AbSHNUr3>; Wed, 14 Aug 2002 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319321AbSHNUq7>; Wed, 14 Aug 2002 16:46:59 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:57558 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319309AbSHNUoy>; Wed, 14 Aug 2002 16:44:54 -0400
Date: Wed, 14 Aug 2002 16:48:35 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 25/38: SERVER: wipe out all evidence in fh_put()
Message-ID: <Pine.SOL.4.44.0208141648180.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a filehandle is cleared with fh_put(), wipe out all traces by
clearing ->fh_pre_saved and ->fh_post_saved.  This prevents
fill_post_wcc() from complaining if the filehandle is later reused.
(This could happen to CURRENT_FH if, for example, LOOKUP LOOKUP
occurs in a COMPOUND.)

--- old/fs/nfsd/nfsfh.c	Sun Aug 11 22:54:17 2002
+++ new/fs/nfsd/nfsfh.c	Sun Aug 11 22:55:44 2002
@@ -438,6 +438,10 @@ fh_put(struct svc_fh *fhp)
 		fh_unlock(fhp);
 		fhp->fh_dentry = NULL;
 		dput(dentry);
+#ifdef CONFIG_NFSD_V3
+		fhp->fh_pre_saved = 0;
+		fhp->fh_post_saved = 0;
+#endif
 		nfsd_nr_put++;
 	}
 	return;

