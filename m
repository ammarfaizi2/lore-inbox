Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbWJCU7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbWJCU7c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbWJCU7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 16:59:32 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:38833 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030429AbWJCU73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 16:59:29 -0400
Date: Tue, 3 Oct 2006 15:59:22 -0500
To: akpm@osdl.org, jeff@garzik.org
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4]: Spidernet fix register field definitions
Message-ID: <20061003205922.GG4381@austin.ibm.com>
References: <20061003205240.GE4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003205240.GE4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the names of a few fields in the DMA control 
register. There is no functional change.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----

 drivers/net/spider_net.c |    2 +-
 drivers/net/spider_net.h |   14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-02 18:59:43.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-02 19:06:55.000000000 -0500
@@ -1639,7 +1639,7 @@ spider_net_enable_card(struct spider_net
 			     SPIDER_NET_INT2_MASK_VALUE);
 
 	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
-			     SPIDER_NET_GDTDCEIDIS);
+			     SPIDER_NET_GDTBSTA);
 }
 
 /**
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-10-02 18:58:11.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-02 19:06:55.000000000 -0500
@@ -191,7 +191,9 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_MACMODE_VALUE	0x00000001
 #define SPIDER_NET_BURSTLMT_VALUE	0x00000200 /* about 16 us */
 
-/* 1(0)					enable r/tx dma
+/* DMAC control register GDMACCNTR
+ *
+ * 1(0)				enable r/tx dma
  *  0000000				fixed to 0
  *
  *         000000			fixed to 0
@@ -200,6 +202,7 @@ extern char spider_net_driver_name[];
  *
  *                 000000		fixed to 0
  *                       00		burst alignment: 128 bytes
+ *                       11		burst alignment: 1024 bytes
  *
  *                         00000	fixed to 0
  *                              0	descr writeback size 32 bytes
@@ -210,10 +213,11 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_DMA_RX_VALUE		0x80000000
 #define SPIDER_NET_DMA_RX_FEND_VALUE	0x00030003
 /* to set TX_DMA_EN */
-#define SPIDER_NET_TX_DMA_EN		0x80000000
-#define SPIDER_NET_GDTDCEIDIS		0x00000300
-#define SPIDER_NET_DMA_TX_VALUE		SPIDER_NET_TX_DMA_EN | \
-					SPIDER_NET_GDTDCEIDIS
+#define SPIDER_NET_TX_DMA_EN           0x80000000
+#define SPIDER_NET_GDTBSTA             0x00000300
+#define SPIDER_NET_GDTDCEIDIS          0x00000002
+#define SPIDER_NET_DMA_TX_VALUE        SPIDER_NET_TX_DMA_EN | \
+                                       SPIDER_NET_GDTBSTA
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
 
 /* SPIDER_NET_UA_DESCR_VALUE is OR'ed with the unicast address */
