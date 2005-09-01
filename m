Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbVIATiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbVIATiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVIATit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:38:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35063 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965186AbVIATia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:38:30 -0400
Subject: [PATCH 2.6.13] Warning in the e1000 driver
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 01 Sep 2005 12:38:28 -0700
Message-Id: <1125603508.4867.24.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should fix a small warning in the e1000 driver. It casts to the
largest possible type dma field. This was found while compiling for
X86_64 .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.13.orig/drivers/net/e1000/e1000_main.c	2005-08-30 18:28:41.000000000 +0000
+++ linux-2.6.13/drivers/net/e1000/e1000_main.c	2005-08-30 19:42:45.000000000 +0000
@@ -2767,7 +2767,7 @@ e1000_clean_tx_irq(struct e1000_adapter 
 					"  next_to_use          <%x>\n"
 					"  next_to_clean        <%x>\n"
 					"buffer_info[next_to_clean]\n"
-					"  dma                  <%zx>\n"
+					"  dma                  <%llx>\n"
 					"  time_stamp           <%lx>\n"
 					"  next_to_watch        <%x>\n"
 					"  jiffies              <%lx>\n"
@@ -2776,7 +2776,7 @@ e1000_clean_tx_irq(struct e1000_adapter 
 				E1000_READ_REG(&adapter->hw, TDT),
 				tx_ring->next_to_use,
 				i,
-				tx_ring->buffer_info[i].dma,
+				(unsigned long long)tx_ring->buffer_info[i].dma,
 				tx_ring->buffer_info[i].time_stamp,
 				eop,
 				jiffies,


