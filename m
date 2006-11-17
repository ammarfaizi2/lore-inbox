Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755965AbWKQWal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965AbWKQWal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755962AbWKQWak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:30:40 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46524 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755795AbWKQWaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:30:39 -0500
Date: Fri, 17 Nov 2006 16:30:22 -0600
To: akpm@osdl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, James K Lewis <jklewis@us.ibm.com>
Subject: [PATCH]: spidernet poor network performance
Message-ID: <20061117223022.GO23600@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, 

Please apply.

--linas


This patch corrects a problem seen on later kernels running 
the NetPIPE application.  Specifically, NetPIPE would begin 
running very slowly at the 1533 packet size. It was
determined that Spidernet slowed with an idle DMA 
engine.

Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/spider_net.c |    2 +-
 drivers/net/spider_net.h |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.19-rc4-git3/drivers/net/spider_net.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/net/spider_net.c	2006-11-01 19:14:34.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/net/spider_net.c	2006-11-17 13:33:44.000000000 -0600
@@ -1606,7 +1606,7 @@ spider_net_enable_card(struct spider_net
 			     SPIDER_NET_INT2_MASK_VALUE);
 
 	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
-			     SPIDER_NET_GDTBSTA | SPIDER_NET_GDTDCEIDIS);
+			     SPIDER_NET_GDTBSTA);
 }
 
 /**
Index: linux-2.6.19-rc4-git3/drivers/net/spider_net.h
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/net/spider_net.h	2006-11-01 19:14:34.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/net/spider_net.h	2006-11-17 16:19:30.000000000 -0600
@@ -24,7 +24,7 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
-#define VERSION "1.1 A"
+#define VERSION "1.6 A"
 
 #include "sungem_phy.h"
 
@@ -217,8 +217,7 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_GDTBSTA             0x00000300
 #define SPIDER_NET_GDTDCEIDIS          0x00000002
 #define SPIDER_NET_DMA_TX_VALUE        SPIDER_NET_TX_DMA_EN | \
-                                       SPIDER_NET_GDTBSTA | \
-                                       SPIDER_NET_GDTDCEIDIS
+                                       SPIDER_NET_GDTBSTA
 
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
 
@@ -328,7 +327,8 @@ enum spider_net_int2_status {
 	SPIDER_NET_GRISPDNGINT
 };
 
-#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) )
+#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) | \
+                             (1 << SPIDER_NET_GDTDCEINT) )
 
 /* We rely on flagged descriptor interrupts */
 #define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) )
