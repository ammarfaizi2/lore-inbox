Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWDCFXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWDCFXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWDCFVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:21:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:43676 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964851AbWDCFU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:20:58 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:19:10 +1000
Message-Id: <1060403051910.1881@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 013 of 16] knfsd: nfsd4: nfsd4_probe_callback cleanup
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some obvious cleanup.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4callback.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff ./fs/nfsd/nfs4callback.c~current~ ./fs/nfsd/nfs4callback.c
--- ./fs/nfsd/nfs4callback.c~current~	2006-04-03 15:12:16.000000000 +1000
+++ ./fs/nfsd/nfs4callback.c	2006-04-03 15:12:16.000000000 +1000
@@ -441,8 +441,9 @@ nfsd4_probe_callback(struct nfs4_client 
 		goto out_clnt;
 	}
 
-	/* the task holds a reference to the nfs4_client struct */
 	cb->cb_client = clnt;
+
+	/* the task holds a reference to the nfs4_client struct */
 	atomic_inc(&clp->cl_count);
 
 	msg.rpc_cred = nfsd4_lookupcred(clp,0);
@@ -460,13 +461,12 @@ nfsd4_probe_callback(struct nfs4_client 
 out_rpciod:
 	atomic_dec(&clp->cl_count);
 	rpciod_down();
+	cb->cb_client = NULL;
 out_clnt:
 	rpc_shutdown_client(clnt);
-	goto out_err;
 out_err:
 	dprintk("NFSD: warning: no callback path to client %.*s\n",
 		(int)clp->cl_name.len, clp->cl_name.data);
-	cb->cb_client = NULL;
 }
 
 static void
