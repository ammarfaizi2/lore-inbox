Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbTDGXNV (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbTDGXMC (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:12:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61056
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263825AbTDGXGs (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:06:48 -0400
Date: Tue, 8 Apr 2003 01:25:38 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080025.h380PcBh009119@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix macmace get_free_pages parameters
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Matthew Wilcox)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/macmace.c linux-2.5.67-ac1/drivers/net/macmace.c
--- linux-2.5.67/drivers/net/macmace.c	2003-03-26 19:59:52.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/macmace.c	2003-04-03 23:37:41.000000000 +0100
@@ -319,8 +319,8 @@
 
 	/* Allocate the DMA ring buffers */
 
-	mp->rx_ring = (void *) __get_free_pages(GFP_DMA, N_RX_PAGES);
-	mp->tx_ring = (void *) __get_free_pages(GFP_DMA, 0);
+	mp->rx_ring = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, N_RX_PAGES);
+	mp->tx_ring = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, 0);
 	
 	if (mp->tx_ring==NULL || mp->rx_ring==NULL) {
 		if (mp->rx_ring) free_pages((u32) mp->rx_ring, N_RX_PAGES);
