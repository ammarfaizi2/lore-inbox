Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVCCJ5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVCCJ5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVCCJ5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:57:36 -0500
Received: from router.activetools.si ([213.250.28.33]:60823 "EHLO vafel.at.lan")
	by vger.kernel.org with ESMTP id S262075AbVCCJ5K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:57:10 -0500
Subject: [PATCH] trivial fix for 2.6.11, initializing a few spin locks
From: Jaka =?iso-8859-2?Q?Mo=E8nik?= <jaka@activetools.si>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Mar 2005 10:57:05 +0100
Message-Id: <1109843825.29455.17.camel@x.at.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch for 2.6.11 simply initializes a few spin locks that are being
reported as accessed prior to initalization on an embedded ppc system.

--- cut here ---
--- linux-2.6.11/drivers/serial/cpm_uart/cpm_uart_core.c	2004-12-24 22:35:27.000000000 +0100
+++ linux-2.6.11-sgn/drivers/serial/cpm_uart/cpm_uart_core.c	2005-03-03 10:08:02.000000000 +0100
@@ -864,11 +864,12 @@
 			.irq		= SMC1_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = smc1_lineif,
 	},
@@ -877,11 +878,12 @@
 			.irq		= SMC2_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = smc2_lineif,
 #ifdef CONFIG_SERIAL_CPM_ALT_SMC2
@@ -893,10 +895,11 @@
 			.irq		= SCC1_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc1_lineif,
 	},
@@ -905,10 +908,11 @@
 			.irq		= SCC2_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc2_lineif,
 	},
@@ -917,10 +921,11 @@
 			.irq		= SCC3_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc3_lineif,
 	},
@@ -929,10 +934,11 @@
 			.irq		= SCC4_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO, 
+		.rx_nrfifos = RX_NUM_FIFO,
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc4_lineif,
 	},
--- linux-2.6.11/drivers/net/gianfar.c	2005-03-03 10:36:51.000000000 +0100
+++ linux-2.6.11-sgn/drivers/net/gianfar.c	2005-03-03 10:36:38.822996013 +0100
@@ -377,6 +377,8 @@
 			ADVERTISED_1000baseT_Full);
 	mii_info->autoneg = 1;
 
+	spin_lock_init(&mii_info->mdio_lock);
+
 	mii_info->mii_id = priv->einfo->phyid;
 
 	mii_info->dev = dev;
--- cut here ---

Signed-off-by: Jaka Močnik <jaka@activetools.si>

regards,
	jaKa

-- 

w3: http://fish.homeunix.org/people/jaka
email: jaka@activetools.si

