Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164341AbWLHBOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164341AbWLHBOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164338AbWLHBNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:13:47 -0500
Received: from cantor.suse.de ([195.135.220.2]:58445 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164317AbWLHBNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:34 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:13:46 +1100
Message-Id: <1061208011346.30615@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 18] knfsd: nfsd: simplify exp_pseudoroot
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Note there's no need for special handling of -EAGAIN here; nfserrno() does
what we want already.  So this is a pure cleanup with no change in
functionality.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-12-08 12:08:20.000000000 +1100
+++ ./fs/nfsd/export.c	2006-12-08 12:08:25.000000000 +1100
@@ -1163,12 +1163,10 @@ exp_pseudoroot(struct auth_domain *clp, 
 	mk_fsid_v1(fsidv, 0);
 
 	exp = exp_find(clp, 1, fsidv, creq);
-	if (IS_ERR(exp) && PTR_ERR(exp) == -EAGAIN)
-		return nfserr_dropit;
+	if (IS_ERR(exp))
+		return nfserrno(PTR_ERR(exp));
 	if (exp == NULL)
 		return nfserr_perm;
-	else if (IS_ERR(exp))
-		return nfserrno(PTR_ERR(exp));
 	rv = fh_compose(fhp, exp, exp->ex_dentry, NULL);
 	exp_put(exp);
 	return rv;
