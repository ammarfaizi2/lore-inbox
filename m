Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbTEWKmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 06:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTEWKmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 06:42:04 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:11933 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S264012AbTEWKmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 06:42:03 -0400
Date: Fri, 23 May 2003 12:55:03 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: davem@caip.rutgers.edu
Cc: Eric.Schenk@dna.lth.se, linux-kernel@vger.kernel.org
Subject: [PATCH] make icmp.c be more verbose on broadcast icmp errors
Message-ID: <Pine.LNX.4.51.0305231222450.8169@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed today in my logs something like:
1.2.3.4 sent an invalid ICMP error to a broadcast address.

And i though that it would be nice to make it report what code/type was
it. So here goes:

2.5 version:

diff -Nru linux-2.5.69.bak/net/ipv4/icmp.c linux-2.5.68/net/ipv4/icmp.c
--- linux-2.5.69.bak/net/ipv4/icmp.c	2003-05-17 14:56:11.000000000 +0200
+++ linux-2.5.69/net/ipv4/icmp.c	2003-05-23 12:15:45.000000000 +0200
@@ -663,8 +659,10 @@
 	    inet_addr_type(iph->daddr) == RTN_BROADCAST) {
 		if (net_ratelimit())
 			printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP "
+					    "type %u, code %u "
 					    "error to a broadcast.\n",
-			       NIPQUAD(skb->nh.iph->saddr));
+			       NIPQUAD(skb->nh.iph->saddr),
+			       icmph->type, icmph->code);
 		goto out;
 	}


2.4 Version:
diff -Nru linux.bak/net/ipv4/icmp.c linux/net/ipv4/icmp.c
--- linux.bak/net/ipv4/icmp.c	2003-04-30 15:57:40.000000000 +0200
+++ linux/net/ipv4/icmp.c	2003-05-23 12:20:46.000000000 +0200
@@ -625,8 +595,9 @@
 		if (inet_addr_type(iph->daddr) == RTN_BROADCAST)
 		{
 			if (net_ratelimit())
-				printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP error to a broadcast.\n",
-			       	NIPQUAD(skb->nh.iph->saddr));
+				printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP type %u, code %u error to a broadcast.\n",
+			       	NIPQUAD(skb->nh.iph->saddr),
+			       	icmph->type, icmph->code);
 			goto out;
 		}
 	}
