Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWHQHVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWHQHVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWHQHVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:21:08 -0400
Received: from msr37.hinet.net ([168.95.4.137]:39914 "EHLO msr37.hinet.net")
	by vger.kernel.org with ESMTP id S932123AbWHQHVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:21:06 -0400
Subject: [PATCH 5/6] IP100A correct init and close step
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:08:32 -0400
Message-Id: <1155841712.4532.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

correct init and close step

Change Logs:
    correct init and close step

---

 drivers/net/sundance.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

b5e343a17f5d70d1cc9a4ba20d366bab355f64a6
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index f63871a..c7c22f0 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -830,6 +830,11 @@ #endif
 		iowrite8(0x01, ioaddr + DebugCtrl1);
 	netif_start_queue(dev);
 
+	// 04/19/2005 Jesse fix for complete initial step
+	spin_lock(&np->lock);
+	reset_tx(dev);
+	spin_unlock(&np->lock);
+
 	iowrite16 (StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
 
 	if (netif_msg_ifup(np))
@@ -1654,7 +1659,10 @@ static int netdev_close(struct net_devic
 
 	/* Disable interrupts by clearing the interrupt mask. */
 	iowrite16(0x0000, ioaddr + IntrEnable);
-
+	
+	// 04/19/2005 Jesse fix for complete initial step
+	writew(0x500, ioaddr + DMACtrl);
+	
 	/* Stop the chip's Tx and Rx processes. */
 	iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
 
-- 
1.3.GIT



