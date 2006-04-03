Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWDCFXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWDCFXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWDCFUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:20:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:37276 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964844AbWDCFU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:28 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:18:41 +1000
Message-Id: <1060403051841.1809@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 16] knfsd: nfsd4: remove nfsd_setuser from putrootfh
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Since nfsd_setuser() is already called from any operation that uses the
current filehandle (because it's called from fh_verify), there's no reason
to call it from putrootfh.

Signed-off-by: Andy Adamson <andros@citi.umich.edu>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c |    2 --
 1 file changed, 2 deletions(-)

diff ./fs/nfsd/nfs4proc.c~current~ ./fs/nfsd/nfs4proc.c
--- ./fs/nfsd/nfs4proc.c~current~	2006-04-03 15:12:10.000000000 +1000
+++ ./fs/nfsd/nfs4proc.c	2006-04-03 15:12:10.000000000 +1000
@@ -288,8 +288,6 @@ nfsd4_putrootfh(struct svc_rqst *rqstp, 
 	fh_put(current_fh);
 	status = exp_pseudoroot(rqstp->rq_client, current_fh,
 			      &rqstp->rq_chandle);
-	if (!status)
-		status = nfserrno(nfsd_setuser(rqstp, current_fh->fh_export));
 	return status;
 }
 
