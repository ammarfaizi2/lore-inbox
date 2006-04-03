Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWDCFUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWDCFUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWDCFUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:20:21 -0400
Received: from mail.suse.de ([195.135.220.2]:36277 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751414AbWDCFT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:19:59 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:18:11 +1000
Message-Id: <1060403051811.1739@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 16] knfsd: nfsd4: Wrong error handling in nfs4acl
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



this fixes coverity id #3. Coverity detected dead code,
since the == -1 comparison only returns 0 or 1 to error.
Therefore the if ( error < 0 ) statement was always false.
Seems that this was an if( error = nfs4... ) statement some time
ago, which got broken during cleanup.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4acl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./fs/nfsd/nfs4acl.c~current~ ./fs/nfsd/nfs4acl.c
--- ./fs/nfsd/nfs4acl.c~current~	2006-04-03 15:12:05.000000000 +1000
+++ ./fs/nfsd/nfs4acl.c	2006-04-03 15:12:05.000000000 +1000
@@ -790,7 +790,7 @@ nfs4_acl_split(struct nfs4_acl *acl, str
 			continue;
 
 		error = nfs4_acl_add_ace(dacl, ace->type, ace->flag,
-				ace->access_mask, ace->whotype, ace->who) == -1;
+				ace->access_mask, ace->whotype, ace->who);
 		if (error < 0)
 			goto out;
 
