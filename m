Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSJ1WNG>; Mon, 28 Oct 2002 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJ1WLa>; Mon, 28 Oct 2002 17:11:30 -0500
Received: from mail.scram.de ([195.226.127.117]:3536 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261570AbSJ1WLB>;
	Mon, 28 Oct 2002 17:11:01 -0500
Date: Mon, 28 Oct 2002 23:11:41 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] IPv6 on Token Ring
Message-ID: <Pine.LNX.4.44.0210282310060.774-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while most parts for IPv6 on Token Ring are already in the kernel, one
small patch is still missing.

--jochen

diff -u -r linux-2.5.44.orig/net/802/tr.c linux-2.5.44/net/802/tr.c
--- linux-2.5.44.orig/net/802/tr.c	2002-10-19 06:01:09.000000000 +0200
+++ linux-2.5.44/net/802/tr.c	2002-10-26 10:32:28.000000000 +0200
@@ -91,10 +91,10 @@
 	int hdr_len;

 	/*
-	 * Add the 802.2 SNAP header if IP as the IPv4 code calls
+	 * Add the 802.2 SNAP header if IP as the IPv4/IPv6 code calls
 	 * dev->hard_header directly.
 	 */
-	if (type == ETH_P_IP || type == ETH_P_ARP)
+	if (type == ETH_P_IP || type == ETH_P_IPV6 || type == ETH_P_ARP)
 	{
 		struct trllc *trllc=(struct trllc *)(trh+1);

@@ -216,6 +216,7 @@

 	if (trllc->dsap == EXTENDED_SAP &&
 	    (trllc->ethertype == ntohs(ETH_P_IP) ||
+	     trllc->ethertype == ntohs(ETH_P_IPV6) ||
 	     trllc->ethertype == ntohs(ETH_P_ARP)))
 	{
 		skb_pull(skb, sizeof(struct trllc));

