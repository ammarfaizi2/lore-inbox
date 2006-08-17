Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWHQIAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWHQIAg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWHQIAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:00:36 -0400
Received: from msr17.hinet.net ([168.95.4.117]:43716 "EHLO msr17.hinet.net")
	by vger.kernel.org with ESMTP id S932255AbWHQIAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:00:35 -0400
Subject: [PATCH 5/7] ip1000: Modify coding style of ipg_config_autoneg()
From: Jesse Huang <jesse@icplus.com.tw>
To: romieu@fr.zoreil.com, penberg@cs.Helsinki.FI, akpm@osdl.org,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:47:41 -0400
Message-Id: <1155844061.5006.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

This is only coding style modify for ipg_config_autoneg(). Thanks for the
suggestion form Francois.

Change Logs:
    Modify coding style of ipg_config_autoneg()

---

 drivers/net/ipg.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

737498ca620437d8179e21be4d5220333066cbbd
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index f859107..be96f93 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -491,11 +491,13 @@ static int ipg_config_autoneg(struct net
 	int fullduplex;
 	int txflowcontrol;
 	int rxflowcontrol;
+	long MacCtrlValue;
 
 	IPG_DEBUG_MSG("_config_autoneg\n");
 
 	asicctrl = ioread32(ioaddr + ASIC_CTRL);
-	phyctrl = ioread32(ioaddr + PHY_CTRL);
+   	phyctrl = ioread8(ioaddr + PHY_CTRL);
+   	MacCtrlValue = ioread32(ioaddr + MAC_CTRL);
 
 	/* Set flags for use in resolving auto-negotation, assuming
 	 * non-1000Mbps, half duplex, no flow control.
@@ -547,22 +549,22 @@ static int ipg_config_autoneg(struct net
 		/* Configure IPG for full duplex operation. */
 		printk(KERN_INFO "setting full duplex, ");
 
-		iowrite32(ioread32(ioaddr + MAC_CTRL) | IPG_MC_DUPLEX_SELECT_FD, ioaddr + MAC_CTRL);
+		MacCtrlValue |= IPG_MC_DUPLEX_SELECT_FD;
 
 		if (txflowcontrol == 1) {
 			printk("TX flow control");
-			iowrite32(ioread32(ioaddr + MAC_CTRL) | IPG_MC_TX_FLOW_CONTROL_ENABLE, ioaddr + MAC_CTRL);
+			MacCtrlValue |= IPG_MC_TX_FLOW_CONTROL_ENABLE;
 		} else {
 			printk("no TX flow control");
-			iowrite32(ioread32(ioaddr + MAC_CTRL) & ~IPG_MC_TX_FLOW_CONTROL_ENABLE, ioaddr + MAC_CTRL);
+			MacCtrlValue &= ~IPG_MC_TX_FLOW_CONTROL_ENABLE;
 		}
 
 		if (rxflowcontrol == 1) {
 			printk(", RX flow control.");
-			iowrite32(ioread32(ioaddr+MAC_CTRL) | IPG_MC_RX_FLOW_CONTROL_ENABLE, ioaddr + MAC_CTRL);
+			MacCtrlValue |= IPG_MC_RX_FLOW_CONTROL_ENABLE;
 		} else {
 			printk(", no RX flow control.");
-			iowrite32(ioread32(ioaddr+MAC_CTRL) & ~IPG_MC_RX_FLOW_CONTROL_ENABLE, ioaddr + MAC_CTRL);
+			MacCtrlValue = MacCtrlValue & ~IPG_MC_RX_FLOW_CONTROL_ENABLE;
 		}
 
 		printk("\n");
@@ -570,8 +572,9 @@ static int ipg_config_autoneg(struct net
 		/* Configure IPG for half duplex operation. */
 	        printk(KERN_INFO "setting half duplex, no TX flow control, no RX flow control.\n");
 
-		iowrite32(ioread32(ioaddr+MAC_CTRL) & ~IPG_MC_DUPLEX_SELECT_FD & ~IPG_MC_TX_FLOW_CONTROL_ENABLE & ~IPG_MC_RX_FLOW_CONTROL_ENABLE, ioaddr + MAC_CTRL);
+		MacCtrlValue &= ~IPG_MC_DUPLEX_SELECT_FD & ~IPG_MC_TX_FLOW_CONTROL_ENABLE & ~IPG_MC_RX_FLOW_CONTROL_ENABLE;
 	}
+	iowrite32(MacCtrlValue , ioaddr+MAC_CTRL);
 	return 0;
 }
 
-- 
1.3.GIT




