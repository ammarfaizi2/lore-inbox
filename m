Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVB0R23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVB0R23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVB0R0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:26:47 -0500
Received: from cantor.suse.de ([195.135.220.2]:17571 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261472AbVB0RXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:23:06 -0500
Message-Id: <20050227170315.379115000@blunzn.suse.de>
References: <20050227165954.566746000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 18:00:05 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [nfsacl v2 11/16] Solaris nfsacl workaround
Content-Disposition: inline; filename=nfsacl-solaris-nfsacl-workaround.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the nfs_acl program is available, Solaris clients expect both version
2 and version 3 to be available; RPC_PROG_MISMATCH leads to a mount
failure.  Fake RPC_PROG_UNAVAIL when asked for nfs_acl version 2.

Trond has rejected this patch. I'm not sure how to deal with it in a
truly clean way, so probably I won't care and still use this as a vendor
patch.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc5/net/sunrpc/svc.c
===================================================================
--- linux-2.6.11-rc5.orig/net/sunrpc/svc.c
+++ linux-2.6.11-rc5/net/sunrpc/svc.c
@@ -455,6 +455,13 @@ err_bad_prog:
 	goto sendit;
 
 err_bad_vers:
+	if (prog == 100227 && vers == 2) {
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

