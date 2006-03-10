Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752248AbWCJXEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbWCJXEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 18:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbWCJXEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 18:04:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29444 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751257AbWCJXEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 18:04:15 -0500
Date: Sat, 11 Mar 2006 00:04:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: [2.6 patch] net/sunrpc/clnt.c: fix a NULL pointer dereference
Message-ID: <20060310230414.GC21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this possible NULL pointer dereference in 
rpc_new_client().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/net/sunrpc/clnt.c.old	2006-03-10 23:39:20.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/net/sunrpc/clnt.c	2006-03-10 23:40:03.000000000 +0100
@@ -112,7 +112,7 @@ rpc_new_client(struct rpc_xprt *xprt, ch
 
 	err = -EINVAL;
 	if (!xprt)
-		goto out_err;
+		goto out_no_xprt;
 	if (vers >= program->nrvers || !(version = program->version[vers]))
 		goto out_err;
 
@@ -182,6 +182,7 @@ out_no_path:
 	kfree(clnt);
 out_err:
 	xprt_destroy(xprt);
+out_no_xprt:
 	return ERR_PTR(err);
 }
 

