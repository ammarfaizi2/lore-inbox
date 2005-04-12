Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVDLPsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVDLPsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVDLKsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:48:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:61386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262290AbVDLKdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:50 -0400
Message-Id: <200504121033.j3CAXcvN005930@shell0.pdx.osdl.net>
Subject: [patch 192/198] nfsd: clear signals before exiting the nfsd() thread
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, neilb@cse.unsw.edu.au,
       bfields@citi.umich.edu, Trond.Myklebust@netapp.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: NeilBrown <neilb@cse.unsw.edu.au>

Fixes the error "RPC: failed to contact portmap (errno -512)." when the server
later tries to unregister from the portmapper.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/nfsd/nfssvc.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN fs/nfsd/nfssvc.c~nfsd-clear-signals-before-exiting-the-nfsd-thread fs/nfsd/nfssvc.c
--- 25/fs/nfsd/nfssvc.c~nfsd-clear-signals-before-exiting-the-nfsd-thread	2005-04-12 03:21:49.101672312 -0700
+++ 25-akpm/fs/nfsd/nfssvc.c	2005-04-12 03:21:49.104671856 -0700
@@ -258,6 +258,8 @@ nfsd(struct svc_rqst *rqstp)
 				break;
 		err = signo;
 	}
+	/* Clear signals before calling lockd_down() and svc_exit_thread() */
+	flush_signals(current);
 
 	lock_kernel();
 
_
