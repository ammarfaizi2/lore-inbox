Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTHJLKS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTHJLKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:10:17 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:35340 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263590AbTHJLJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:09:56 -0400
Date: Sun, 10 Aug 2003 20:10:05 +0900 (JST)
Message-Id: <20030810.201005.44972660.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] convert drivers/net to virt_to_pageoff()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030810020444.48cb740b.davem@redhat.com>
References: <20030810013041.679ddc4c.davem@redhat.com>
	<20030810090556.GY31810@waste.org>
	<20030810020444.48cb740b.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[6/9] convert drivers/net to virt_to_pageoff().

Index: linux-2.6/drivers/net/acenic.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/acenic.c,v
retrieving revision 1.36
diff -u -r1.36 acenic.c
--- linux-2.6/drivers/net/acenic.c	1 Aug 2003 22:07:01 -0000	1.36
+++ linux-2.6/drivers/net/acenic.c	10 Aug 2003 08:40:52 -0000
@@ -1960,7 +1960,7 @@
 		 */
 		skb_reserve(skb, 2 + 16);
 		mapping = pci_map_page(ap->pdev, virt_to_page(skb->data),
-				       ((unsigned long)skb->data & ~PAGE_MASK),
+				       virt_to_pageoff(skb->data),
 				       ACE_STD_BUFSIZE - (2 + 16),
 				       PCI_DMA_FROMDEVICE);
 		ap->skb->rx_std_skbuff[idx].skb = skb;
@@ -2026,7 +2026,7 @@
 		 */
 		skb_reserve(skb, 2 + 16);
 		mapping = pci_map_page(ap->pdev, virt_to_page(skb->data),
-				       ((unsigned long)skb->data & ~PAGE_MASK),
+				       virt_to_pageoff(skb->data),
 				       ACE_MINI_BUFSIZE - (2 + 16),
 				       PCI_DMA_FROMDEVICE);
 		ap->skb->rx_mini_skbuff[idx].skb = skb;
@@ -2087,7 +2087,7 @@
 		 */
 		skb_reserve(skb, 2 + 16);
 		mapping = pci_map_page(ap->pdev, virt_to_page(skb->data),
-				       ((unsigned long)skb->data & ~PAGE_MASK),
+				       virt_to_pageoff(skb->data),
 				       ACE_JUMBO_BUFSIZE - (2 + 16),
 				       PCI_DMA_FROMDEVICE);
 		ap->skb->rx_jumbo_skbuff[idx].skb = skb;
@@ -2743,7 +2743,7 @@
 	struct tx_ring_info *info;
 
 	mapping = pci_map_page(ap->pdev, virt_to_page(skb->data),
-			       ((unsigned long) skb->data & ~PAGE_MASK),
+			       virt_to_pageoff(skb->data),
 			       skb->len, PCI_DMA_TODEVICE);
 
 	info = ap->skb->tx_skbuff + idx;
Index: linux-2.6/drivers/net/sungem.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/sungem.c,v
retrieving revision 1.40
diff -u -r1.40 sungem.c
--- linux-2.6/drivers/net/sungem.c	3 Aug 2003 18:34:10 -0000	1.40
+++ linux-2.6/drivers/net/sungem.c	10 Aug 2003 08:40:53 -0000
@@ -725,8 +725,7 @@
 			skb_put(new_skb, (ETH_FRAME_LEN + RX_OFFSET));
 			rxd->buffer = cpu_to_le64(pci_map_page(gp->pdev,
 							       virt_to_page(new_skb->data),
-							       ((unsigned long) new_skb->data &
-								~PAGE_MASK),
+							       virt_to_pageoff(new_skb->data),
 							       RX_BUF_ALLOC_SIZE(gp),
 							       PCI_DMA_FROMDEVICE));
 			skb_reserve(new_skb, RX_OFFSET);
@@ -873,8 +872,7 @@
 		len = skb->len;
 		mapping = pci_map_page(gp->pdev,
 				       virt_to_page(skb->data),
-				       ((unsigned long) skb->data &
-					~PAGE_MASK),
+				       virt_to_pageoff(skb->data),
 				       len, PCI_DMA_TODEVICE);
 		ctrl |= TXDCTRL_SOF | TXDCTRL_EOF | len;
 		if (gem_intme(entry))
@@ -898,7 +896,7 @@
 		 */
 		first_len = skb_headlen(skb);
 		first_mapping = pci_map_page(gp->pdev, virt_to_page(skb->data),
-					     ((unsigned long) skb->data & ~PAGE_MASK),
+					     virt_to_pageoff(skb->data),
 					     first_len, PCI_DMA_TODEVICE);
 		entry = NEXT_TX(entry);
 
@@ -1464,8 +1462,7 @@
 		skb_put(skb, (ETH_FRAME_LEN + RX_OFFSET));
 		dma_addr = pci_map_page(gp->pdev,
 					virt_to_page(skb->data),
-					((unsigned long) skb->data &
-					 ~PAGE_MASK),
+					virt_to_pageoff(skb->data),
 					RX_BUF_ALLOC_SIZE(gp),
 					PCI_DMA_FROMDEVICE);
 		rxd->buffer = cpu_to_le64(dma_addr);
Index: linux-2.6/drivers/net/sk98lin/skge.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/sk98lin/skge.c,v
retrieving revision 1.24
diff -u -r1.24 skge.c
--- linux-2.6/drivers/net/sk98lin/skge.c	1 Aug 2003 19:02:34 -0000	1.24
+++ linux-2.6/drivers/net/sk98lin/skge.c	10 Aug 2003 08:40:53 -0000
@@ -2142,7 +2142,7 @@
 	*/
 	PhysAddr = (SK_U64) pci_map_page(pAC->PciDev,
 					virt_to_page(pMessage->data),
-					((unsigned long) pMessage->data & ~PAGE_MASK),
+					virt_to_pageoff(pMessage->data),
 					pMessage->len,
 					PCI_DMA_TODEVICE);
 	pTxd->VDataLow  = (SK_U32) (PhysAddr & 0xffffffff);
@@ -2259,7 +2259,7 @@
 	*/
 	PhysAddr = (SK_U64) pci_map_page(pAC->PciDev,
 			virt_to_page(pMessage->data),
-			((unsigned long) pMessage->data & ~PAGE_MASK),
+			virt_to_pageoff(pMessage->data),
 			skb_headlen(pMessage),
 			PCI_DMA_TODEVICE);
 
@@ -2518,8 +2518,7 @@
 	Length = pAC->RxBufSize;
 	PhysAddr = (SK_U64) pci_map_page(pAC->PciDev,
 		virt_to_page(pMsgBlock->data),
-		((unsigned long) pMsgBlock->data &
-		~PAGE_MASK),
+		virt_to_pageoff(pMsgBlock->data),
 		pAC->RxBufSize - 2,
 		PCI_DMA_FROMDEVICE);
 

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
