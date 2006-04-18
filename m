Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWDRWNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWDRWNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWDRWNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:13:55 -0400
Received: from mx1.suse.de ([195.135.220.2]:37803 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750759AbWDRWNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:13:54 -0400
Date: Tue, 18 Apr 2006 15:12:42 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.8
Message-ID: <20060418221242.GB506@kroah.com>
References: <20060418221134.GA506@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418221134.GA506@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 06a8926..6346bb6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .7
+EXTRAVERSION = .8
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fca5fe0..a67955e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2750,7 +2750,10 @@ int inet_rtm_getroute(struct sk_buff *in
 	/* Reserve room for dummy headers, this skb can pass
 	   through good chunk of routing engine.
 	 */
-	skb->mac.raw = skb->data;
+	skb->mac.raw = skb->nh.raw = skb->data;
+
+	/* Bugfix: need to give ip_route_input enough of an IP header to not gag. */
+	skb->nh.iph->protocol = IPPROTO_ICMP;
 	skb_reserve(skb, MAX_HEADER + sizeof(struct iphdr));
 
 	if (rta[RTA_SRC - 1])
