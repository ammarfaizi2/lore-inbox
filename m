Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUB0VcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUB0VcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:32:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13501 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263138AbUB0Vb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:31:28 -0500
Date: Fri, 27 Feb 2004 16:31:40 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: trond.myklebust@fys.uio.no
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [NFS SUNRPC] fix
Message-ID: <Xine.LNX.4.44.0402271627190.13899-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a bug in the error handling code of 
xprt_create_socket().  If sock_create() fails, we should not try and 
release the non existent socket.

This fix is by James Carter <jwcart2@epoch.ncsc.mil>.

Please apply.


- James
-- 
James Morris
<jmorris@redhat.com>


diff -urN -X dontdiff linux-2.6.3-mm4.o/net/sunrpc/xprt.c linux-2.6.3-mm4.w/net/sunrpc/xprt.c
--- linux-2.6.3-mm4.o/net/sunrpc/xprt.c	2004-02-25 22:42:16.000000000 -0500
+++ linux-2.6.3-mm4.w/net/sunrpc/xprt.c	2004-02-27 16:13:34.230834288 -0500
@@ -1581,7 +1581,7 @@
 
 	if ((err = sock_create(PF_INET, type, proto, &sock)) < 0) {
 		printk("RPC: can't create socket (%d).\n", -err);
-		goto failed;
+		return NULL;
 	}
 
 	/* If the caller has the capability, bind to a reserved port */

