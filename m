Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbTFWNML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbTFWNKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:10:38 -0400
Received: from trained-monkey.org ([209.217.122.11]:20498 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S266015AbTFWMxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 08:53:05 -0400
From: Jes Sorensen <jes@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16118.64380.97977.716338@trained-monkey.org>
Date: Mon, 23 Jun 2003 09:07:08 -0400
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@osdl.org>, achim.leubner@intel.com
Subject: [patch] 2.5.72 gdth.c 64 bit fix
X-Mailer: VM 7.13 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While looking through gdth.c in 2.5.72 I noticed a case where it
truncates the dma adress it passes to pci_unmap_single() on 64 bit
+ HIGHMEM archs.

Jes


--- drivers/scsi/gdth.c~	Mon Jun 16 21:20:06 2003
+++ drivers/scsi/gdth.c	Mon Jun 23 05:58:11 2003
@@ -3662,7 +3662,7 @@
             pci_unmap_single(ha->pdev,scp->SCp.dma_handle,
                          scp->request_bufflen,scp->SCp.Message);
         if (scp->SCp.buffer) 
-            pci_unmap_single(ha->pdev,(dma_addr_t)(u32)scp->SCp.buffer,
+            pci_unmap_single(ha->pdev,(dma_addr_t)scp->SCp.buffer,
 						16,PCI_DMA_FROMDEVICE);
 #endif
         if (ha->status == S_OK) {
