Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129396AbRBMJ6j>; Tue, 13 Feb 2001 04:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129377AbRBMJ63>; Tue, 13 Feb 2001 04:58:29 -0500
Received: from mons.uio.no ([129.240.130.14]:41139 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129169AbRBMJ6O>;
	Tue, 13 Feb 2001 04:58:14 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: carlos@fisica.ufpr.br (Carlos Carvalho), linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre10 doesn't compile on alphas (sunrpc)
In-Reply-To: <E14SQqi-0008Bm-00@the-village.bc.nu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 13 Feb 2001 10:56:28 +0100
In-Reply-To: Alan Cox's message of "Mon, 12 Feb 2001 21:49:29 +0000 (GMT)"
Message-ID: <shslmra9a9f.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    >> net/network.a(sunrpc.o): In function `xprt_ping_reserve':
    >> sunrpc.o(.text+0x4b94): undefined reference to `BUG'
    >> sunrpc.o(.text+0x4b98): undefined reference to `BUG'
    >>
    >> Looks like a problem in Trond's patches, also it doesn't happen
    >> with pre9. It links in intel machines. I didn't reboot to test
    >> yet...

     > The ideal solution would be for someone to provide BUG() on the
     > Alpha platform as in 2.4. That would sort things cleanly

Actually, since BUG() only seems to be defined on i386 platforms for
2.2.x, perhaps the easiest thing to do (unless somebody wants to
volunteer to backport all the `safe' definitions from 2.4.x) would be
to add the generic `*(int *)0 = 0' definition for local use by ping()
itself.

Cheers,
  Trond

--- net/sunrpc/ping.c.orig	Tue Feb 13 10:47:20 2001
+++ net/sunrpc/ping.c	Tue Feb 13 10:50:03 2001
@@ -25,6 +25,10 @@
 # define RPCDBG_FACILITY	RPCDBG_XPRT
 #endif
 
+#ifndef BUG
+#define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+#endif
+
 static void ping_call_reserve(struct rpc_task *);
 static void ping_call_allocate(struct rpc_task *);
 static void ping_call_encode(struct rpc_task *);
