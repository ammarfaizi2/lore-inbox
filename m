Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWHXGgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWHXGgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWHXGgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:36:33 -0400
Received: from ns1.suse.de ([195.135.220.2]:33478 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030336AbWHXGgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:36:32 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 16:36:34 +1000
Message-Id: <1060824063634.4913@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 11] knfsd: nfsd: lockdep annotation fix
References: <20060824162917.3600.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nfsv2 needs the I_MUTEX_PARENT on the directory when creating 
a file too.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsproc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/fs/nfsd/nfsproc.c ./fs/nfsd/nfsproc.c
--- .prev/fs/nfsd/nfsproc.c	2006-08-24 16:21:23.000000000 +1000
+++ ./fs/nfsd/nfsproc.c	2006-08-24 16:21:35.000000000 +1000
@@ -225,7 +225,7 @@ nfsd_proc_create(struct svc_rqst *rqstp,
 	nfserr = nfserr_exist;
 	if (isdotent(argp->name, argp->len))
 		goto done;
-	fh_lock(dirfhp);
+	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
 	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
 	if (IS_ERR(dchild)) {
 		nfserr = nfserrno(PTR_ERR(dchild));
