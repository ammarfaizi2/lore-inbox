Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVAVUyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVAVUyG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVAVUv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:51:56 -0500
Received: from cantor.suse.de ([195.135.220.2]:50640 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262742AbVAVUeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:34:31 -0500
Message-Id: <20050122203619.889966000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
Date: Sat, 22 Jan 2005 21:34:10 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 10/13] Solaris nfsacl workaround
Content-Disposition: inline; filename=patches.suse/nfsd-acl-v2-solaris
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the nfs_acl program is available, Solaris clients expect both
version 2 and version 3 to be available; RPC_PROG_MISMATCH leads to a
mount failure. Fake RPC_PROG_UNAVAIL when asked for nfs_acl version 2.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc2/net/sunrpc/svc.c
===================================================================
--- linux-2.6.11-rc2.orig/net/sunrpc/svc.c
+++ linux-2.6.11-rc2/net/sunrpc/svc.c
@@ -458,6 +458,13 @@ err_bad_prog:
 	goto sendit;
 
 err_bad_vers:
+	if (prog == NFSACL_PROGRAM && vers == 2) {
+		/* If the nfs_acl program is available, Solaris clients expect
+		   both version 2 and version 3 to be available;
+		   RPC_PROG_MISMATCH leads to a mount failure. Fake
+		   RPC_PROG_UNAVAIL when asked for nfs_acl version 2. */
+		goto err_bad_prog;
+	}
 #ifdef RPC_PARANOIA
 	printk("svc: unknown version (%d)\n", vers);
 #endif

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

