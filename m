Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030727AbWF0HTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030727AbWF0HTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030730AbWF0HTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:19:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:11653 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030727AbWF0HTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:19:50 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:19:39 +1000
Message-Id: <1060627071939.26600@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 001 of 14] knfsd: Improve the test for cross-device-rename in nfsd
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just testing the i_sb isn't really enough, at least
the vfsmnt must be the same.  Thanks Al.

Cc: Al Viro <viro@ftp.linux.org.uk>

### Diffstat output
 ./fs/nfsd/vfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/fs/nfsd/vfs.c ./fs/nfsd/vfs.c
--- .prev/fs/nfsd/vfs.c	2006-06-27 12:15:18.000000000 +1000
+++ ./fs/nfsd/vfs.c	2006-06-27 12:15:21.000000000 +1000
@@ -1556,7 +1556,7 @@ nfsd_rename(struct svc_rqst *rqstp, stru
 	tdir = tdentry->d_inode;
 
 	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
-	if (fdir->i_sb != tdir->i_sb)
+	if (ffhp->fh_export != tfhp->fh_export)
 		goto out;
 
 	err = nfserr_perm;
