Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUHKWrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUHKWrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268297AbUHKWrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:47:14 -0400
Received: from holomorphy.com ([207.189.100.168]:391 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268293AbUHKWo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:44:28 -0400
Date: Wed, 11 Aug 2004 15:41:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       davem@redhat.com, netdev@oss.sgi.com
Subject: Re: 2.6: rxrpc compile errors with SYSCTL=n
Message-ID: <20040811224102.GU11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com
References: <20040811223225.GN26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811223225.GN26174@fs.tum.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 12:32:25AM +0200, Adrian Bunk wrote:
> I'm getting tons of the following compile errors in 2.6.8-rc4-mm1 (but 
> it doesn't seem to be specific to -mm) with CONFIG_SYSCTL=n:
> <--  snip  -->
> ...
>   LD      .tmp_vmlinux1
> net/built-in.o(.text+0x154127): In function `__rxrpc_call_acks_timeout':
> : undefined reference to `rxrpc_kdebug'
> net/built-in.o(.text+0x154167): In function `__rxrpc_call_rcv_timeout':
> : undefined reference to `rxrpc_kdebug'

Does this help?


Index: mm1-2.6.8-rc4/include/rxrpc/rxrpc.h
===================================================================
--- mm1-2.6.8-rc4.orig/include/rxrpc/rxrpc.h	2004-08-11 15:27:56.589237088 -0700
+++ mm1-2.6.8-rc4/include/rxrpc/rxrpc.h	2004-08-11 15:28:12.496818768 -0700
@@ -16,10 +16,17 @@
 
 extern uint32_t rxrpc_epoch;
 
+#ifdef CONFIG_SYSCTL
 extern int rxrpc_ktrace;
 extern int rxrpc_kdebug;
 extern int rxrpc_kproto;
 extern int rxrpc_knet;
+#else
+#define rxrpc_ktrace	0
+#define rxrpc_kdebug	0
+#define rxrpc_kproto	0
+#define rxrpc_knet	0
+#endif
 
 extern int rxrpc_sysctl_init(void);
 extern void rxrpc_sysctl_cleanup(void);
