Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270104AbTGPDco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 23:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270108AbTGPDco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 23:32:44 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:55545 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S270104AbTGPDcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 23:32:43 -0400
Date: Tue, 15 Jul 2003 20:47:17 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trongd Myklebust <trond.myklebust@fys.uio.no>, torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] rpcsec_gss compatibility
Message-ID: <20030715204717.A9016@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a data point, Solaris 9 client uses initial seq. no. 2.

/fc

	start gss seq no at 1; netapp doesn't accept seq no 0.

--- linux-2.5.75.0/net/sunrpc/auth_gss/auth_gss.c
+++ linux-2.5.75.1/net/sunrpc/auth_gss/auth_gss.c
@@ -236,7 +236,7 @@
 		goto err;
 	}
 	ctx->gc_proc = RPC_GSS_PROC_DATA;
-	ctx->gc_seq = 0;
+	ctx->gc_seq = 1;	/* NetApp 6.4R1 doesn't accept seq. no. 0 */
 	spin_lock_init(&ctx->gc_seq_lock);
 	atomic_set(&ctx->count,1);
 
