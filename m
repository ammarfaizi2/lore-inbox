Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbSKACKz>; Thu, 31 Oct 2002 21:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSKACKy>; Thu, 31 Oct 2002 21:10:54 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:6804 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S265608AbSKACKx>; Thu, 31 Oct 2002 21:10:53 -0500
Message-Id: <200211010314.gA13EfuJ000349@pool-141-150-241-241.delv.east.verizon.net>
Date: Thu, 31 Oct 2002 22:14:39 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Miles Lane <miles.lane@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 ipmr.c syntax error
References: <3DC1D85A.2020102@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC1D85A.2020102@attbi.com>; from miles.lane@attbi.com on Thu, Oct 31, 2002 at 05:26:50PM -0800
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Thu, 31 Oct 2002 20:17:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> Skip, I tried your patch from:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103604415923099&w=2

I goofed with that patch.  This is the correct one.  Sorry about that.


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
+	if (skb->len+encap > dst_pmtu(&rt->u.dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		   allow to send ICMP, so that packets will disappear
 		   to blackhole.

-- 
Skip
