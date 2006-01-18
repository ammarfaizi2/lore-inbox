Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWARIFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWARIFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWARIFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:05:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50964 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932408AbWARIFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:05:45 -0500
Date: Wed, 18 Jan 2006 09:07:40 +0100
From: Jens Axboe <axboe@suse.de>
To: jeffrey.t.kirsher@intel.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] e1000 C style badness
Message-ID: <20060118080738.GD3945@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recent e1000 updates introduced variable declarations after code. Fix
those up again.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index d0a5d16..ca68a04 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -2142,9 +2142,11 @@ e1000_leave_82542_rst(struct e1000_adapt
 		e1000_pci_set_mwi(&adapter->hw);
 
 	if(netif_running(netdev)) {
+		struct e1000_rx_ring *ring;
+
 		e1000_configure_rx(adapter);
 		/* No need to loop, because 82542 supports only 1 queue */
-		struct e1000_rx_ring *ring = &adapter->rx_ring[0];
+		ring = &adapter->rx_ring[0];
 		adapter->alloc_rx_buf(adapter, ring, E1000_DESC_UNUSED(ring));
 	}
 }
@@ -3583,8 +3585,8 @@ e1000_clean_rx_irq(struct e1000_adapter 
 	rx_desc = E1000_RX_DESC(*rx_ring, i);
 
 	while(rx_desc->status & E1000_RXD_STAT_DD) {
-		buffer_info = &rx_ring->buffer_info[i];
 		u8 status;
+		buffer_info = &rx_ring->buffer_info[i];
 #ifdef CONFIG_E1000_NAPI
 		if(*work_done >= work_to_do)
 			break;

-- 
Jens Axboe

