Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSJ2TaB>; Tue, 29 Oct 2002 14:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbSJ2T3q>; Tue, 29 Oct 2002 14:29:46 -0500
Received: from steve.prima.de ([62.72.84.2]:44981 "HELO steve.prima.de")
	by vger.kernel.org with SMTP id <S262207AbSJ2T2f>;
	Tue, 29 Oct 2002 14:28:35 -0500
Date: Tue, 29 Oct 2002 20:34:03 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: coreteam@netfilter.org
Subject: Compile fix for 2.5 BK current
Message-ID: <20021029193403.GA19754@oscar.homelinux.net>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo List,

I need the following two patches to make BK 2.5 current compile.
Hope it's OK to Cc the netfilter core team ?

Please apply,
Patrick

--- net/ipv4/netfilter/ip_conntrack_standalone.c	2002-10-29 20:27:56.000000000 +0100
+++ net/ipv4/netfilter/ip_conntrack_standalone.c.new	2002-10-29 20:23:06.000000000 +0100
@@ -201,7 +201,7 @@
 	/* Local packets are never produced too large for their
 	   interface.  We degfragment them at LOCAL_OUT, however,
 	   so we have to refragment them here. */
-	if ((*pskb)->len > rt->u.dst.pmtu) {
+	if ((*pskb)->len > dst_pmtu(&rt->u.dst)) {
 		/* No hook can be after us, so this should be OK. */
 		ip_fragment(*pskb, okfn);
 		return NF_STOLEN;


--- net/ipv4/netfilter/ipt_REJECT.c	2002-10-29 20:27:56.000000000 +0100
+++ net/ipv4/netfilter/ipt_REJECT.c.new	2002-10-29 20:26:45.000000000 +0100
@@ -148,7 +148,7 @@
 	nskb->dst = &rt->u.dst;
 
 	/* "Never happens" */
-	if (nskb->len > nskb->dst->pmtu)
+	if (nskb->len > dst_pmtu(nskb->dst))
 		goto free_nskb;
 
 	connection_attach(nskb, oldskb->nfct);
@@ -225,8 +225,8 @@
 	/* RFC says return as much as we can without exceeding 576 bytes. */
 	length = skb_in->len + sizeof(struct iphdr) + sizeof(struct icmphdr);
 
-	if (length > rt->u.dst.pmtu)
-		length = rt->u.dst.pmtu;
+	if (length > dst_pmtu(&rt->u.dst))
+		length = dst_pmtu(&rt->u.dst);
 	if (length > 576)
 		length = 576;
 

