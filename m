Return-Path: <linux-kernel-owner+w=401wt.eu-S932310AbXAQOTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbXAQOTe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbXAQOTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:19:34 -0500
Received: from ns1.suse.de ([195.135.220.2]:55778 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbXAQOTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:19:33 -0500
Date: Wed, 17 Jan 2007 15:19:32 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compile warnings in r8169
Message-ID: <20070117141932.GA20534@strauss.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compile warnings in r8169. It doesn't fix "real" bugs, only that
the driver compiles cleanly without warnings.

Signed-off-by: Bernhard Walle <bwalle@suse.de>

---

 r8169.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.20-rc4.orig/drivers/net/r8169.c	2007-01-07 06:45:51.000000000 +0100
+++ linux-2.6.20-rc4/drivers/net/r8169.c	2007-01-17 11:39:13.792309228 +0100
@@ -2016,7 +2016,7 @@ static int rtl8169_alloc_rx_skb(struct p
 	if (!skb)
 		goto err_out;
 
-	skb_reserve(skb, (align - 1) & (u32)skb->data);
+	skb_reserve(skb, (align - 1) & (long)skb->data);
 	*sk_buff = skb;
 
 	mapping = pci_map_single(pdev, skb->data, rx_buf_sz,
@@ -2227,7 +2227,7 @@ static int rtl8169_xmit_frags(struct rtl
 {
 	struct skb_shared_info *info = skb_shinfo(skb);
 	unsigned int cur_frag, entry;
-	struct TxDesc *txd;
+	struct TxDesc *txd = NULL;
 
 	entry = tp->cur_tx;
 	for (cur_frag = 0; cur_frag < info->nr_frags; cur_frag++) {
@@ -2487,7 +2487,7 @@ static inline int rtl8169_try_rx_copy(st
 
 		skb = dev_alloc_skb(pkt_size + align);
 		if (skb) {
-			skb_reserve(skb, (align - 1) & (u32)skb->data);
+			skb_reserve(skb, (align - 1) & (long)skb->data);
 			eth_copy_and_sum(skb, sk_buff[0]->data, pkt_size, 0);
 			*sk_buff = skb;
 			rtl8169_mark_to_asic(desc, rx_buf_sz);
