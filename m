Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265405AbSJSANW>; Fri, 18 Oct 2002 20:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265408AbSJSANW>; Fri, 18 Oct 2002 20:13:22 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:19869 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265405AbSJSANV>; Fri, 18 Oct 2002 20:13:21 -0400
Date: Fri, 18 Oct 2002 20:11:50 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.43 : net/ipv4/ip_forward.c compile error fix
In-Reply-To: <Pine.LNX.4.44.0210181957310.9556-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210182006450.10062-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch seems to fix the error below. Please review for 
inclusion.

Regards,
Frank

--- linux/net/ipv4/ip_forward.c.old	Thu Apr 12 15:11:39 2001
+++ linux/net/ipv4/ip_forward.c	Fri Oct 18 20:05:30 2002
@@ -53,7 +53,7 @@
 
 		if (rt->rt_flags&RTCF_FAST && !netdev_fastroute_obstacles) {
 			struct dst_entry *old_dst;
-			unsigned h = ((*(u8*)&rt->key.dst)^(*(u8*)&rt->key.src))&NETDEV_FASTROUTE_HMASK;
+			unsigned h = ((*(u8*)&rt->fl.fl4_dst)^(*(u8*)&rt->fl.fl4_src))&NETDEV_FASTROUTE_HMASK;
 
 			write_lock_irq(&skb->dev->fastpath_lock);
 			old_dst = skb->dev->fastpath[h];
 

On Fri, 18 Oct 2002, Frank Davis wrote:

> Hello all,
>   I haven't seen this posted on l-k yet (If I missed it, sorry in 
> advance). While a 'make bzImage' on 2.5.43, I received the following 
> error.
> 
> Regards,
> Frank
> 
> net/ipv4/ip_forward.c: In function `ip_forward_finish':
> net/ipv4/ip_forward.c:56: structure has no member named `key'
> net/ipv4/ip_forward.c:56: structure has no member named `key'
> make[2]: *** [net/ipv4/ip_forward.o] Error 1
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2
> 
> 

