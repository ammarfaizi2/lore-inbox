Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRBMKeY>; Tue, 13 Feb 2001 05:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129256AbRBMKeP>; Tue, 13 Feb 2001 05:34:15 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:9726 "EHLO
	hoggar.fisica.ufpr.br") by vger.kernel.org with ESMTP
	id <S129162AbRBMKeE>; Tue, 13 Feb 2001 05:34:04 -0500
From: Carlos Carvalho <carlos@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14985.3468.421839.320568@hoggar.fisica.ufpr.br>
Date: Tue, 13 Feb 2001 08:33:48 -0200
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre10 doesn't compile on alphas (sunrpc)
In-Reply-To: <shslmra9a9f.fsf@charged.uio.no>
In-Reply-To: <E14SQqi-0008Bm-00@the-village.bc.nu>
	<shslmra9a9f.fsf@charged.uio.no>
X-Mailer: VM 6.90 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust (trond.myklebust@fys.uio.no) wrote on 13 February 2001 10:56:
 >--- net/sunrpc/ping.c.orig	Tue Feb 13 10:47:20 2001
 >+++ net/sunrpc/ping.c	Tue Feb 13 10:50:03 2001
                 ******

Oops, the BUG() call appears in xprt.c! Here's a patch that makes it
compile. Let's see if it runs...

--- linux/net/sunrpc/xprt.c.orig	Tue Feb 13 08:30:20 2001
+++ linux/net/sunrpc/xprt.c	Tue Feb 13 08:29:43 2001
@@ -81,6 +81,10 @@
 # define MIN(a, b)	((a) < (b)? (a) : (b))
 #endif
 
+#ifndef BUG
+#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+#endif
+
 /*
  * Local functions
  */
