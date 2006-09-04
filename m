Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWIDXQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWIDXQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWIDXPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:15:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:25805 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932238AbWIDXPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:15:43 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:15:38 +1000
Message-Id: <1060904231538.23086@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 9] knfsd: svcrpc: use consistent variable name for the reply state
References: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

The rpc reply has multiple levels of error returns.  The code here
contributes to the confusion by using "accept_statp" for a pointer to what
the rfc (and wireshark, etc.) refer to as the "reply_stat".  (The confusion
is compounded by the fact that the rfc also has an "accept_stat" which
follows the reply_stat in the succesful case.)

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-09-04 17:09:50.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-09-04 17:15:35.000000000 +1000
@@ -699,7 +699,7 @@ svc_process(struct svc_rqst *rqstp)
 	u32			dir, prog, vers, proc,
 				auth_stat, rpc_stat;
 	int			auth_res;
-	u32			*accept_statp;
+	u32			*reply_statp;
 
 	rpc_stat = rpc_success;
 
@@ -740,7 +740,7 @@ svc_process(struct svc_rqst *rqstp)
 		goto err_bad_rpc;
 
 	/* Save position in case we later decide to reject: */
-	accept_statp = resv->iov_base + resv->iov_len;
+	reply_statp = resv->iov_base + resv->iov_len;
 
 	svc_putu32(resv, xdr_zero);		/* ACCEPT */
 
@@ -888,7 +888,7 @@ err_bad_auth:
 	dprintk("svc: authentication failed (%d)\n", ntohl(auth_stat));
 	serv->sv_stats->rpcbadauth++;
 	/* Restore write pointer to location of accept status: */
-	xdr_ressize_check(rqstp, accept_statp);
+	xdr_ressize_check(rqstp, reply_statp);
 	svc_putu32(resv, xdr_one);	/* REJECT */
 	svc_putu32(resv, xdr_one);	/* AUTH_ERROR */
 	svc_putu32(resv, auth_stat);	/* status */
