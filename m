Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265179AbSJaFyL>; Thu, 31 Oct 2002 00:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265181AbSJaFyL>; Thu, 31 Oct 2002 00:54:11 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:63188 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265179AbSJaFyK>; Thu, 31 Oct 2002 00:54:10 -0500
Message-Id: <200210310657.g9V6vrCA009366@pool-141-150-241-241.delv.east.verizon.net>
Date: Thu, 31 Oct 2002 01:57:49 -0500
From: Skip Ford <skip.ford@verizon.net>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 ipmr.c syntax error
References: <3DC0B586.13DA237D@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC0B586.13DA237D@verizon.net>; from randy.dunlap@verizon.net on Wed, Oct 30, 2002 at 08:45:58PM -0800
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [141.150.241.241] at Thu, 31 Oct 2002 00:00:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
>   gcc -Wp,-MD,net/ipv4/.ipmr.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
> -DKBUILD_BASENAME=ipmr   -c -o net/ipv4/ipmr.o net/ipv4/ipmr.c
> net/ipv4/ipmr.c: In function `ipmr_forward_finish':
> net/ipv4/ipmr.c:1114: structure has no member named `pmtu'
> net/ipv4/ipmr.c: In function `ipmr_queue_xmit':
> net/ipv4/ipmr.c:1170: structure has no member named `pmtu'
> make[2]: *** [net/ipv4/ipmr.o] Error 1
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2


--- linux/net/ipv4/ipmr.c~	Thu Oct 31 01:54:40 2002
+++ linux/net/ipv4/ipmr.c	Thu Oct 31 01:55:31 2002
@@ -1111,7 +1111,7 @@
 {
 	struct dst_entry *dst = skb->dst;
 
-	if (skb->len <= dst->pmtu)
+	if (skb->len <= dst_pmtu(dst))
 		return dst->output(skb);
 	else
 		return ip_fragment(skb, dst->output);
@@ -1167,7 +1167,7 @@
 
 	dev = rt->u.dst.dev;
 
-	if (skb->len+encap > rt->u.dst.pmtu && (ntohs(iph->frag_off) & IP_DF)) {
+	if (skb->len+encap > dst_pmtu(rt->u.dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		   allow to send ICMP, so that packets will disappear
 		   to blackhole.

-- 
Skip
