Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTEODTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTEODSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:50 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:13804 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263787AbTEODSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:21 -0400
Date: Thu, 15 May 2003 04:31:09 +0100
Message-Id: <200305150331.h4F3V918000648@deviant.impure.org.uk>
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: fix tlan 64bit check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/tlan.c linux-2.5/drivers/net/tlan.c
--- bk-linus/drivers/net/tlan.c	2003-04-22 00:40:43.000000000 +0100
+++ linux-2.5/drivers/net/tlan.c	2003-04-22 01:23:14.000000000 +0100
@@ -1536,7 +1536,7 @@ u32 TLan_HandleRxEOF( struct net_device 
 				t = (void *) skb_put( new_skb, TLAN_MAX_FRAME_SIZE );
 				head_list->buffer[0].address = pci_map_single(priv->pciDev, new_skb->data, TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
 				head_list->buffer[8].address = (u32) t;
-#ifdef __LP64__
+#if BITS_PER_LONG==64
 #error "Not 64bit clean"
 #endif				
 				head_list->buffer[9].address = (u32) new_skb;
