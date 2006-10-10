Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWJJDNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWJJDNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWJJDNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:13:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25773 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964920AbWJJDNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:13:01 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 15/25] xdr annotations: nfsd_dispatch()
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX83B-0004FD-6U@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:13:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfssvc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 013b389..8067118 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -495,8 +495,8 @@ nfsd_dispatch(struct svc_rqst *rqstp, u3
 {
 	struct svc_procedure	*proc;
 	kxdrproc_t		xdr;
-	u32			nfserr;
-	u32			*nfserrp;
+	__be32			nfserr;
+	__be32			*nfserrp;
 
 	dprintk("nfsd_dispatch: vers %d proc %d\n",
 				rqstp->rq_vers, rqstp->rq_proc);
@@ -515,7 +515,7 @@ nfsd_dispatch(struct svc_rqst *rqstp, u3
 
 	/* Decode arguments */
 	xdr = proc->pc_decode;
-	if (xdr && !xdr(rqstp, (u32*)rqstp->rq_arg.head[0].iov_base,
+	if (xdr && !xdr(rqstp, (__be32*)rqstp->rq_arg.head[0].iov_base,
 			rqstp->rq_argp)) {
 		dprintk("nfsd: failed to decode arguments!\n");
 		nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
@@ -528,7 +528,7 @@ nfsd_dispatch(struct svc_rqst *rqstp, u3
 	 */
 	nfserrp = rqstp->rq_res.head[0].iov_base
 		+ rqstp->rq_res.head[0].iov_len;
-	rqstp->rq_res.head[0].iov_len += sizeof(u32);
+	rqstp->rq_res.head[0].iov_len += sizeof(__be32);
 
 	/* Now call the procedure handler, and encode NFS status. */
 	nfserr = proc->pc_func(rqstp, rqstp->rq_argp, rqstp->rq_resp);
-- 
1.4.2.GIT


