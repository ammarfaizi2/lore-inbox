Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVBHIL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVBHIL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 03:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVBHIL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 03:11:57 -0500
Received: from ns.schottelius.org ([213.146.113.242]:39878 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S261478AbVBHILy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 03:11:54 -0500
Date: Tue, 8 Feb 2005 09:10:57 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH] compile error: 2.6.10 / megaraid_mbox
Message-ID: <20050208081057.GC21154@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning!

I was trying to compile Megaraid on 2.6.10 and
noticed that pci_dma_sync_single and pci_dma_sync_sg
are deprecated. Greg seems to tried to patch it in 2.6.9
(http://lkml.org/lkml/2004/10/19/425), but it seems he didn't catch it
all.

A patch against vanialla 2.6.10 is attached.


Greetings,

Nico

--- megaraid_mbox.c.orig	2005-02-07 14:57:16.000000000 +0100
+++ megaraid_mbox.c	2005-02-07 15:03:00.000000000 +0100
@@ -1554,12 +1554,12 @@
 
 	if (scb->dma_direction == PCI_DMA_TODEVICE) {
 		if (!scb->scp->use_sg) {	// sg list not used
-			pci_dma_sync_single(adapter->pdev, ccb->buf_dma_h,
+			pci_dma_sync_single_for_cpu(adapter->pdev, ccb->buf_dma_h,
 					scb->scp->request_bufflen,
 					PCI_DMA_TODEVICE);
 		}
 		else {
-			pci_dma_sync_sg(adapter->pdev, scb->scp->request_buffer,
+			pci_dma_sync_sg_for_cpu(adapter->pdev, scb->scp->request_buffer,
 				scb->scp->use_sg, PCI_DMA_TODEVICE);
 		}
 	}
@@ -2332,7 +2332,7 @@
 
 	case MRAID_DMA_WBUF:
 		if (scb->dma_direction == PCI_DMA_FROMDEVICE) {
-			pci_dma_sync_single(adapter->pdev,
+			pci_dma_sync_single_for_cpu(adapter->pdev,
 					ccb->buf_dma_h,
 					scb->scp->request_bufflen,
 					PCI_DMA_FROMDEVICE);
@@ -2345,7 +2345,7 @@
 
 	case MRAID_DMA_WSG:
 		if (scb->dma_direction == PCI_DMA_FROMDEVICE) {
-			pci_dma_sync_sg(adapter->pdev,
+			pci_dma_sync_sg_for_cpu(adapter->pdev,
 					scb->scp->request_buffer,
 					scb->scp->use_sg, PCI_DMA_FROMDEVICE);
 		}

