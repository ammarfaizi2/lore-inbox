Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbULNNst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbULNNst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbULNNst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:48:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24071 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261509AbULNNsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:48:47 -0500
Date: Tue, 14 Dec 2004 14:48:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/ethernet/eth.c: make a function static
Message-ID: <20041214134842.GD23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


diffstat output:
 include/linux/etherdevice.h |    2 --
 net/ethernet/eth.c          |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/linux/etherdevice.h.old	2004-12-14 03:38:12.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/etherdevice.h	2004-12-14 03:38:20.000000000 +0100
@@ -37,8 +37,6 @@
 						unsigned char * haddr);
 extern int		eth_header_cache(struct neighbour *neigh,
 					 struct hh_cache *hh);
-extern int		eth_header_parse(struct sk_buff *skb,
-					 unsigned char *haddr);
 
 extern struct net_device *alloc_etherdev(int sizeof_priv);
 static inline void eth_copy_and_sum (struct sk_buff *dest, 
--- linux-2.6.10-rc3-mm1-full/net/ethernet/eth.c.old	2004-12-14 03:38:29.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/ethernet/eth.c	2004-12-14 03:38:34.000000000 +0100
@@ -208,7 +208,7 @@
 	return htons(ETH_P_802_2);
 }
 
-int eth_header_parse(struct sk_buff *skb, unsigned char *haddr)
+static int eth_header_parse(struct sk_buff *skb, unsigned char *haddr)
 {
 	struct ethhdr *eth = eth_hdr(skb);
 	memcpy(haddr, eth->h_source, ETH_ALEN);

