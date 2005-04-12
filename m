Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVDMFJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVDMFJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 01:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVDLSj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:39:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:2763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262299AbVDLKd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:59 -0400
Message-Id: <200504121033.j3CAXcBW005934@shell0.pdx.osdl.net>
Subject: [patch 193/198] nfsd4: callback create rpc client returns
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, neilb@cse.unsw.edu.au,
       bfields@citi.umich.edu
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: NeilBrown <neilb@cse.unsw.edu.au>

rpc_create_clnt and friends return errors, not NULL, on failure.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/nfsd/nfs4callback.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN fs/nfsd/nfs4callback.c~nfsd4-callback-create-rpc-client-returns fs/nfsd/nfs4callback.c
--- 25/fs/nfsd/nfs4callback.c~nfsd4-callback-create-rpc-client-returns	2005-04-12 03:21:49.376630512 -0700
+++ 25-akpm/fs/nfsd/nfs4callback.c	2005-04-12 03:21:49.379630056 -0700
@@ -405,7 +405,8 @@ nfsd4_probe_callback(struct nfs4_client 
 	timeparms.to_exponential = 1;
 
 	/* Create RPC transport */
-	if (!(xprt = xprt_create_proto(IPPROTO_TCP, &addr, &timeparms))) {
+	xprt = xprt_create_proto(IPPROTO_TCP, &addr, &timeparms);
+	if (IS_ERR(xprt)) {
 		dprintk("NFSD: couldn't create callback transport!\n");
 		goto out_err;
 	}
@@ -426,7 +427,8 @@ nfsd4_probe_callback(struct nfs4_client 
 	 * XXX AUTH_UNIX only - need AUTH_GSS....
 	 */
 	sprintf(hostname, "%u.%u.%u.%u", NIPQUAD(addr.sin_addr.s_addr));
-	if (!(clnt = rpc_create_client(xprt, hostname, program, 1, RPC_AUTH_UNIX))) {
+	clnt = rpc_create_client(xprt, hostname, program, 1, RPC_AUTH_UNIX);
+	if (IS_ERR(clnt)) {
 		dprintk("NFSD: couldn't create callback client\n");
 		goto out_xprt;
 	}
_
