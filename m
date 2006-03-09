Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWCINWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWCINWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWCINWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:22:14 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59114 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751771AbWCINWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:22:14 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Thu, 9 Mar 2006 14:18:28 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] drivers/ieee1394/ohci1394.c: function calls without effect
To: linux1394-devel@lists.sourceforge.net
cc: Adrian Bunk <bunk@stusta.de>, bcollins@debian.org, scjody@modernduck.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060309114138.GA21864@stusta.de>
Message-ID: <tkrat.be39a8854a3c82c0@s5r6.in-berlin.de>
References: <20060309114138.GA21864@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.154) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ohci1394: Remove superfluous call to free_dma_rcv_ctx,
spotted by Adrian Bunk. Also remove some superfluous comments.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c     2006-03-06 20:04:10.000000000 +0100
+++ linux/drivers/ieee1394/ohci1394.c  2006-03-09 14:09:21.000000000 +0100
@@ -3462,24 +3462,13 @@ static void ohci1394_pci_remove(struct p
 	case OHCI_INIT_HAVE_TXRX_BUFFERS__MAYBE:
 		/* The ohci_soft_reset() stops all DMA contexts, so we
 		 * dont need to do this.  */
-		/* Free AR dma */
 		free_dma_rcv_ctx(&ohci->ar_req_context);
 		free_dma_rcv_ctx(&ohci->ar_resp_context);
-
-		/* Free AT dma */
 		free_dma_trm_ctx(&ohci->at_req_context);
 		free_dma_trm_ctx(&ohci->at_resp_context);
-
-		/* Free IR dma */
 		free_dma_rcv_ctx(&ohci->ir_legacy_context);
-
-		/* Free IT dma */
 		free_dma_trm_ctx(&ohci->it_legacy_context);
 
-		/* Free IR legacy dma */
-		free_dma_rcv_ctx(&ohci->ir_legacy_context);
-
-
 	case OHCI_INIT_HAVE_SELFID_BUFFER:
 		pci_free_consistent(ohci->dev, OHCI1394_SI_DMA_BUF_SIZE,
 				    ohci->selfid_buf_cpu,


