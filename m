Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTIVSwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTIVSwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:52:38 -0400
Received: from waste.org ([209.173.204.2]:13760 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263277AbTIVSwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:52:30 -0400
Date: Mon, 22 Sep 2003 13:52:25 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] netif_carrier_* support for tlan
Message-ID: <20030922185225.GO2414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper netif_carrier_* to tlan driver

 l-mpm/drivers/net/tlan.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/net/tlan.c~tlan-carrier drivers/net/tlan.c
--- l/drivers/net/tlan.c~tlan-carrier	2003-09-22 00:53:06.000000000 -0500
+++ l-mpm/drivers/net/tlan.c	2003-09-22 01:16:15.000000000 -0500
@@ -902,7 +902,9 @@ static int TLan_Init( struct net_device 
 			err );
 	}
 	dev->addr_len = 6;
-	
+
+	netif_carrier_off(dev);
+
 	/* Device methods */
 	dev->open = &TLan_Open;
 	dev->hard_start_xmit = &TLan_StartTx;
@@ -2227,6 +2229,8 @@ TLan_ResetAdapter( struct net_device *de
 
 	priv->tlanFullDuplex = FALSE;
 	priv->phyOnline=0;
+	netif_carrier_off(dev);
+
 /*  1.	Assert reset bit. */
 
 	data = inl(dev->base_addr + TLAN_HOST_CMD);
@@ -2390,6 +2394,7 @@ TLan_FinishReset( struct net_device *dev
 		}
 		outl( priv->rxListDMA, dev->base_addr + TLAN_CH_PARM );
 		outl( TLAN_HC_GO | TLAN_HC_RT, dev->base_addr + TLAN_HOST_CMD );
+		netif_carrier_on(dev);
 	} else {
 		printk( "TLAN: %s: Link inactive, will retry in 10 secs...\n", dev->name );
 		TLan_SetTimer( dev, (10*HZ), TLAN_TIMER_FINISH_RESET );

_


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
