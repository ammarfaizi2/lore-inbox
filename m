Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbTDMUpX (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 16:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbTDMUpX (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 16:45:23 -0400
Received: from [12.47.58.73] ([12.47.58.73]:54789 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261924AbTDMUpW (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 16:45:22 -0400
Date: Sun, 13 Apr 2003 13:57:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm2: multiple definition of `ipip_err'
Message-Id: <20030413135713.79f9cb25.akpm@digeo.com>
In-Reply-To: <20030413201643.GP9640@fs.tum.de>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
	<20030413201643.GP9640@fs.tum.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2003 20:57:05.0283 (UTC) FILETIME=[3D469530:01C301FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> Besides the ipip_err that was already in net/ipv4/ipip.c there's now a 
> second one in net/ipv4/xfrm4_tunnel.c .

Seems pretty straightforward.

diff -puN net/ipv4/ipip.c~ipip_err-compile-fix net/ipv4/ipip.c
--- 25/net/ipv4/ipip.c~ipip_err-compile-fix	2003-04-13 13:55:21.000000000 -0700
+++ 25-akpm/net/ipv4/ipip.c	2003-04-13 13:55:31.000000000 -0700
@@ -286,7 +286,7 @@ static void ipip_tunnel_uninit(struct ne
 	dev_put(dev);
 }
 
-void ipip_err(struct sk_buff *skb, void *__unused)
+static void ipip_err(struct sk_buff *skb, void *__unused)
 {
 #ifndef I_WISH_WORLD_WERE_PERFECT
 
diff -puN net/ipv4/xfrm4_tunnel.c~ipip_err-compile-fix net/ipv4/xfrm4_tunnel.c
--- 25/net/ipv4/xfrm4_tunnel.c~ipip_err-compile-fix	2003-04-13 13:55:21.000000000 -0700
+++ 25-akpm/net/ipv4/xfrm4_tunnel.c	2003-04-13 13:55:35.000000000 -0700
@@ -163,7 +163,7 @@ out:
 	return 0;
 }
 
-void ipip_err(struct sk_buff *skb, u32 info)
+static void ipip_err(struct sk_buff *skb, u32 info)
 {
 	struct xfrm_tunnel *handler = ipip_handler;
 	u32 arg = info;

_

