Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTCFE4q>; Wed, 5 Mar 2003 23:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbTCFE4q>; Wed, 5 Mar 2003 23:56:46 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:2565 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S264644AbTCFE4p>; Wed, 5 Mar 2003 23:56:45 -0500
Date: Thu, 6 Mar 2003 16:06:46 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Niels den Otter <otter@surfnet.nl>
cc: Brian Litzinger <brian@top.worldcontrol.com>,
       "David S. Miller" <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Booting 2.5.63 vs 2.4.20 I can't read multicast data
In-Reply-To: <20030304223953.GA3114@pangsit>
Message-ID: <Pine.LNX.4.44.0303061605001.27962-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Niels den Otter wrote:

> You appear to be strugling with the same problem I have. What I find is
> that the multicast application binds to the loopback instead of ethernet
> interface (also no IGMP joins are send out on the ethernet interface).

Please try the patch below.


- James
-- 
James Morris
<jmorris@intercode.com.au>


diff -urN -X dontdiff linux-2.5.64.orig/net/ipv4/igmp.c linux-2.5.64.w1/net/ipv4/igmp.c
--- linux-2.5.64.orig/net/ipv4/igmp.c	Tue Feb 25 15:03:26 2003
+++ linux-2.5.64.w1/net/ipv4/igmp.c	Thu Mar  6 15:55:37 2003
@@ -606,7 +606,7 @@
 static struct in_device * ip_mc_find_dev(struct ip_mreqn *imr)
 {
 	struct flowi fl = { .nl_u = { .ip4_u =
-				      { .daddr = imr->imr_address.s_addr } } };
+				      { .daddr = imr->imr_multiaddr.s_addr } } };
 	struct rtable *rt;
 	struct net_device *dev = NULL;
 	struct in_device *idev = NULL;

