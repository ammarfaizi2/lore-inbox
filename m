Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030741AbWF0HXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030741AbWF0HXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030732AbWF0HUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:32 -0400
Received: from ns1.suse.de ([195.135.220.2]:17541 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030737AbWF0HUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:17 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:12 +1000
Message-Id: <1060627072012.26673@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 14] knfsd: nfsd4: remove superfluous grace period checks
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@citi.umich.edu>


We're checking nfs_in_grace here a few times when there isn't really any
reason to--bad_stateid is probably the more sensible return value anyway.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./fs/nfsd/nfs4state.c |    4 ----
 1 file changed, 4 deletions(-)

diff .prev/fs/nfsd/nfs4state.c ./fs/nfsd/nfs4state.c
--- .prev/fs/nfsd/nfs4state.c	2006-06-27 14:36:03.000000000 +1000
+++ ./fs/nfsd/nfs4state.c	2006-06-27 14:44:03.000000000 +1000
@@ -2070,16 +2070,12 @@ nfs4_preprocess_stateid_op(struct svc_fh
 	if (!stateid->si_fileid) { /* delegation stateid */
 		if(!(dp = find_delegation_stateid(ino, stateid))) {
 			dprintk("NFSD: delegation stateid not found\n");
-			if (nfs4_in_grace())
-				status = nfserr_grace;
 			goto out;
 		}
 		stidp = &dp->dl_stateid;
 	} else { /* open or lock stateid */
 		if (!(stp = find_stateid(stateid, flags))) {
 			dprintk("NFSD: open or lock stateid not found\n");
-			if (nfs4_in_grace())
-				status = nfserr_grace;
 			goto out;
 		}
 		if ((flags & CHECK_FH) && nfs4_check_fh(current_fh, stp))
