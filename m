Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWFBTtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWFBTtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWFBTsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:48:38 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:31440 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932513AbWFBTsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:48:32 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 21:46:59 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 02/18] ohci1394.c: function calls without
 effect
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
Message-ID: <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.261) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ohci1394: Remove superfluous call to free_dma_rcv_ctx,
spotted by Adrian Bunk. Also remove some superfluous comments.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/ohci1394.c	2006-06-01 20:55:05.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/ohci1394.c	2006-06-01 20:55:39.000000000 +0200
@@ -3463,24 +3463,13 @@ static void ohci1394_pci_remove(struct p
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


