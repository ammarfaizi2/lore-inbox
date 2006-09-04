Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWIDXQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWIDXQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWIDXQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:16:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:28877 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932238AbWIDXPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:15:53 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:15:48 +1000
Message-Id: <1060904231548.23112@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 9] knfsd: nfsd4: clean up exp_pseudoroot
References: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

The previous patch enables some minor simplification here.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-09-04 17:18:25.000000000 +1000
+++ ./fs/nfsd/export.c	2006-09-04 17:20:22.000000000 +1000
@@ -1058,14 +1058,11 @@ exp_pseudoroot(struct auth_domain *clp, 
 	if (IS_ERR(exp) && PTR_ERR(exp) == -EAGAIN)
 		return nfserr_dropit;
 	if (exp == NULL)
-		rv = nfserr_perm;
+		return nfserr_perm;
 	else if (IS_ERR(exp))
-		rv = nfserrno(PTR_ERR(exp));
-	else {
-		rv = fh_compose(fhp, exp,
-				exp->ex_dentry, NULL);
-		exp_put(exp);
-	}
+		return nfserrno(PTR_ERR(exp));
+	rv = fh_compose(fhp, exp, exp->ex_dentry, NULL);
+	exp_put(exp);
 	return rv;
 }
 
