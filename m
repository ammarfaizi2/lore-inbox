Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbSJQB1P>; Wed, 16 Oct 2002 21:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSJQB1P>; Wed, 16 Oct 2002 21:27:15 -0400
Received: from packet.digeo.com ([12.110.80.53]:25748 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261614AbSJQB1O>;
	Wed, 16 Oct 2002 21:27:14 -0400
Message-ID: <3DAE1351.EDC2DA0A@digeo.com>
Date: Wed, 16 Oct 2002 18:33:05 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] fix 3c59x for current 2.5-bk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 01:33:05.0645 (UTC) FILETIME=[241409D0:01C2757D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The networking guys have been doing stuff, and the following
patch from Alexey is needed to make the 3c59x ethernet driver
work with udp.  It teaches driver to add hardware checksums to
outgoing UDP frames.


--- 2.5.43/drivers/net/3c59x.c~3c59x-udp-csum	Wed Oct 16 11:59:43 2002
+++ 2.5.43-akpm/drivers/net/3c59x.c	Wed Oct 16 11:59:43 2002
@@ -2052,7 +2052,7 @@ boomerang_start_xmit(struct sk_buff *skb
 	if (skb->ip_summed != CHECKSUM_HW)
 			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded);
 	else
-			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded | AddTCPChksum);
+			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded | AddTCPChksum | AddUDPChksum);
 
 	if (!skb_shinfo(skb)->nr_frags) {
 		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data,

.
