Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265430AbSJaWpi>; Thu, 31 Oct 2002 17:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265436AbSJaWpi>; Thu, 31 Oct 2002 17:45:38 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:65167 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S265430AbSJaWph>; Thu, 31 Oct 2002 17:45:37 -0500
Message-Id: <200210312349.g9VNnMmf001238@pool-141-150-241-241.delv.east.verizon.net>
Date: Thu, 31 Oct 2002 18:49:18 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Jochen Friedrich <jochen@scram.de>
Cc: "Randy.Dunlap" <randy.dunlap@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 ipmr.c syntax error
References: <200210310657.g9V6vrCA009366@pool-141-150-241-241.delv.east.verizon.net> <Pine.LNX.4.44.0210311252540.7997-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210311252540.7997-100000@gfrw1044.bocc.de>; from jochen@scram.de on Thu, Oct 31, 2002 at 12:53:43PM +0100
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Thu, 31 Oct 2002 16:51:55 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Friedrich wrote:
> Hi Skip,
> 
> > -	if (skb->len+encap > rt->u.dst.pmtu && (ntohs(iph->frag_off) & IP_DF)) {
> > +	if (skb->len+encap > dst_pmtu(rt->u.dst) && (ntohs(iph->frag_off) & IP_DF)) {
> 
> Shouldn't that be dst_pmtu(&rt->u.dst)?

Yep, you're right.  Thanks.


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
