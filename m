Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267343AbSLKWdb>; Wed, 11 Dec 2002 17:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbSLKWcQ>; Wed, 11 Dec 2002 17:32:16 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7172 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267343AbSLKWcC>;
	Wed, 11 Dec 2002 17:32:02 -0500
Date: Tue, 10 Dec 2002 22:56:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Kill TRUE/FALSE from hp100.c
Message-ID: <20021210215612.GA514@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernel coding style does not like TRUE/FALSE, AFAICS. Please apply,


								Pavel

--- clean/drivers/net/hp100.c	2002-11-23 19:55:22.000000000 +0100
+++ linux-swsusp/drivers/net/hp100.c	2002-12-09 21:19:48.000000000 +0100
@@ -889,7 +887,7 @@
 		wait();
 	} else {
 		hp100_outw(HP100_INT_EN | HP100_RESET_LB, OPTION_LSW);
-		hp100_cascade_reset(dev, TRUE);
+		hp100_cascade_reset(dev, 1);
 		hp100_page(MAC_CTRL);
 		hp100_andb(~(HP100_RX_EN | HP100_TX_EN), MAC_CFG_1);
 	}
@@ -900,7 +898,7 @@
 	wait();
 
 	/* Go into reset again. */
-	hp100_cascade_reset(dev, TRUE);
+	hp100_cascade_reset(dev, 1);
 
 	/* Set Option Registers to a safe state  */
 	hp100_outw(HP100_DEBUG_EN |
@@ -943,13 +941,13 @@
 	wait();			/* TODO: Do we really need this? */
 
 	/* Enable Hardware (e.g. unreset) */
-	hp100_cascade_reset(dev, FALSE);
+	hp100_cascade_reset(dev, 0);
 
 	/* ------- initialisation complete ----------- */
 
 	/* Finally try to log in the Hub if there may be a VG connection. */
 	if (lp->lan_type != HP100_LAN_10)
 		hp100_login_to_vg_hub(dev, FALSE);	/* relogin */
 }
 
 
@@ -1191,7 +1189,7 @@
 	hp100_stop_interface(dev);
 
 	if (lp->lan_type == HP100_LAN_100)
-		lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+		lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 
 	netif_stop_queue(dev);
 
@@ -1508,13 +1506,13 @@
 			hp100_andb(~HP100_BM_MASTER, BM);
 		}	/* end of shutdown procedure for non-etr parts */
 
-		hp100_cascade_reset(dev, TRUE);
+		hp100_cascade_reset(dev, 1);
 	}
 	hp100_page(PERFORMANCE);
 	/* hp100_outw( HP100_BM_READ | HP100_BM_WRITE | HP100_RESET_HB, OPTION_LSW ); */
 	/* Busmaster mode should be shut down now. */
 }
 
 /* 
  *  transmit functions
  */
@@ -1577,18 +1584,18 @@
 			if (i == HP100_LAN_ERR)
 				printk("hp100: %s: link down detected\n", dev->name);
 			else if (lp->lan_type != i) {	/* cable change! */
-				/* it's very hard - all network setting must be changed!!! */
+				/* it's very hard - all network settings must be changed!!! */
 				printk("hp100: %s: cable change 10Mb/s <-> 100Mb/s detected\n", dev->name);
 				lp->lan_type = i;
 				hp100_stop_interface(dev);
 				if (lp->lan_type == HP100_LAN_100)
-					lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+					lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 				hp100_start_interface(dev);
 			} else {
 				printk("hp100: %s: interface reset\n", dev->name);
 				hp100_stop_interface(dev);
 				if (lp->lan_type == HP100_LAN_100)
-					lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+					lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 				hp100_start_interface(dev);
 			}
 		}
@@ -1729,7 +1727,7 @@
 			/* we have a 100Mb/s adapter but it isn't connected to hub */
 			printk("hp100: %s: login to 100Mb/s hub retry\n", dev->name);
 			hp100_stop_interface(dev);
-			lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+			lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 			hp100_start_interface(dev);
 		} else {
 			spin_lock_irqsave(&lp->lock, flags);
@@ -1745,13 +1743,13 @@
 				lp->lan_type = i;
 				hp100_stop_interface(dev);
 				if (lp->lan_type == HP100_LAN_100)
-					lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+					lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 				hp100_start_interface(dev);
 			} else {
 				printk("hp100: %s: interface reset\n", dev->name);
 				hp100_stop_interface(dev);
 				if (lp->lan_type == HP100_LAN_100)
-					lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+					lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 				hp100_start_interface(dev);
 				mdelay(1);
 			}
@@ -2220,7 +2219,7 @@
 #ifdef HP100_DEBUG
 			printk("hp100: %s: 100VG MAC settings have changed - relogin.\n", dev->name);
 #endif
-			lp->hub_status = hp100_login_to_vg_hub(dev, TRUE);	/* force a relogin to the hub */
+			lp->hub_status = hp100_login_to_vg_hub(dev, 1);	/* force a relogin to the hub */
 		}
 	} else {
 		int i;
@@ -2245,7 +2244,7 @@
 #ifdef HP100_DEBUG
 				printk("hp100: %s: 100VG MAC settings have changed - relogin.\n", dev->name);
 #endif
-				lp->hub_status = hp100_login_to_vg_hub(dev, TRUE);	/* force a relogin to the hub */
+				lp->hub_status = hp100_login_to_vg_hub(dev, 1);	/* force a relogin to the hub */
 			}
 		}
 	}
@@ -2685,7 +2689,7 @@
 	 */
 	hp100_page(MAC_CTRL);
 	startst = hp100_inb(VG_LAN_CFG_1);
-	if ((force_relogin == TRUE) || (hp100_inb(MAC_CFG_4) & HP100_MAC_SEL_ST)) {
+	if ((force_relogin == 1) || (hp100_inb(MAC_CFG_4) & HP100_MAC_SEL_ST)) {
 #ifdef HP100_DEBUG_TRAINING
 		printk("hp100: %s: Start training\n", dev->name);
 #endif
@@ -2847,7 +2851,7 @@
 	printk("hp100: %s: cascade_reset\n", dev->name);
 #endif
 
-	if (enable == TRUE) {
+	if (enable) {
 		hp100_outw(HP100_HW_RST | HP100_RESET_LB, OPTION_LSW);
 		if (lp->chip == HP100_CHIPID_LASSEN) {
 			/* Lassen requires a PCI transmit fifo reset */

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
