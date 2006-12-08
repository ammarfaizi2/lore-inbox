Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164335AbWLHBNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164335AbWLHBNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164242AbWLHBNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:13:32 -0500
Received: from ns2.suse.de ([195.135.220.15]:47155 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164335AbWLHBN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:29 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:13:41 +1100
Message-Id: <1061208011341.30603@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 18] knfsd: nfsd: make exp_rootfh handle exp_parent errors
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Since exp_parent can fail by returning an error (-EAGAIN) in addition 
to by returning NULL, we should check for that case in exp_rootfh.

(TODO: we should check that userland handles these errors too.)

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |    4 ++++
 1 file changed, 4 insertions(+)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-12-08 12:07:28.000000000 +1100
+++ ./fs/nfsd/export.c	2006-12-08 12:08:20.000000000 +1100
@@ -1104,6 +1104,10 @@ exp_rootfh(svc_client *clp, char *path, 
 		 path, nd.dentry, clp->name,
 		 inode->i_sb->s_id, inode->i_ino);
 	exp = exp_parent(clp, nd.mnt, nd.dentry, NULL);
+	if (IS_ERR(exp)) {
+		err = PTR_ERR(exp);
+		goto out;
+	}
 	if (!exp) {
 		dprintk("nfsd: exp_rootfh export not found.\n");
 		goto out;
