Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUERWfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUERWfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUERWfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:35:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:12440 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S263702AbUERWfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:35:43 -0400
Date: Tue, 18 May 2004 15:35:38 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       scott.feldman@intel.com
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix e100 for non coherent arches
Message-ID: <20040518153538.A2660@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corrects pci_map_single() direction arg.

-Matt

===== drivers/net/e100.c 1.11 vs edited =====
--- 1.11/drivers/net/e100.c	Tue Apr 20 15:55:32 2004
+++ edited/drivers/net/e100.c	Tue May 18 15:25:01 2004
@@ -1397,7 +1397,7 @@
 	skb_reserve(rx->skb, rx_offset);
 	memcpy(rx->skb->data, &nic->blank_rfd, sizeof(struct rfd));
 	rx->dma_addr = pci_map_single(nic->pdev, rx->skb->data,
-		RFD_BUF_LEN, PCI_DMA_FROMDEVICE);
+		RFD_BUF_LEN, PCI_DMA_BIDIRECTIONAL);
 
 	/* Link the RFD to end of RFA by linking previous RFD to
 	 * this one, and clearing EL bit of previous.  */
