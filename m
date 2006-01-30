Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWA3RUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWA3RUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWA3RUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:20:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28174 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964816AbWA3RUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:20:48 -0500
Date: Mon, 30 Jan 2006 18:20:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/e1000/: proper prototypes
Message-ID: <20060130172047.GB3655@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves prototypes of global variables and functions to a 
header file.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/e1000/e1000.h         |   22 ++++++++++++++++++++++
 drivers/net/e1000/e1000_ethtool.c |   13 -------------
 drivers/net/e1000/e1000_main.c    |   14 --------------
 3 files changed, 22 insertions(+), 27 deletions(-)

--- linux-2.6.16-rc1-mm4-full/drivers/net/e1000/e1000.h.old	2006-01-30 02:51:02.000000000 +0100
+++ linux-2.6.16-rc1-mm4-full/drivers/net/e1000/e1000.h	2006-01-30 03:12:13.000000000 +0100
@@ -362,4 +362,26 @@
 	boolean_t have_msi;
 #endif
 };
+
+
+/*  e1000_main.c  */
+extern char e1000_driver_name[];
+extern char e1000_driver_version[];
+int e1000_up(struct e1000_adapter *adapter);
+void e1000_down(struct e1000_adapter *adapter);
+void e1000_reset(struct e1000_adapter *adapter);
+int e1000_setup_all_tx_resources(struct e1000_adapter *adapter);
+void e1000_free_all_tx_resources(struct e1000_adapter *adapter);
+int e1000_setup_all_rx_resources(struct e1000_adapter *adapter);
+void e1000_free_all_rx_resources(struct e1000_adapter *adapter);
+void e1000_update_stats(struct e1000_adapter *adapter);
+int e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx);
+
+/*  e1000_ethtool.c  */
+void e1000_set_ethtool_ops(struct net_device *netdev);
+
+/*  e1000_param.c  */
+void e1000_check_options(struct e1000_adapter *adapter);
+
+
 #endif /* _E1000_H_ */
--- linux-2.6.16-rc1-mm4-full/drivers/net/e1000/e1000_ethtool.c.old	2006-01-30 02:50:11.000000000 +0100
+++ linux-2.6.16-rc1-mm4-full/drivers/net/e1000/e1000_ethtool.c	2006-01-30 02:50:21.000000000 +0100
@@ -32,19 +32,6 @@
 
 #include <asm/uaccess.h>
 
-extern char e1000_driver_name[];
-extern char e1000_driver_version[];
-
-extern int e1000_up(struct e1000_adapter *adapter);
-extern void e1000_down(struct e1000_adapter *adapter);
-extern void e1000_reset(struct e1000_adapter *adapter);
-extern int e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx);
-extern int e1000_setup_all_rx_resources(struct e1000_adapter *adapter);
-extern int e1000_setup_all_tx_resources(struct e1000_adapter *adapter);
-extern void e1000_free_all_rx_resources(struct e1000_adapter *adapter);
-extern void e1000_free_all_tx_resources(struct e1000_adapter *adapter);
-extern void e1000_update_stats(struct e1000_adapter *adapter);
-
 struct e1000_stats {
 	char stat_string[ETH_GSTRING_LEN];
 	int sizeof_stat;
--- linux-2.6.16-rc1-mm4-full/drivers/net/e1000/e1000_main.c.old	2006-01-30 02:51:48.000000000 +0100
+++ linux-2.6.16-rc1-mm4-full/drivers/net/e1000/e1000_main.c	2006-01-30 03:16:55.000000000 +0100
@@ -166,14 +166,6 @@
 
 MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
 
-int e1000_up(struct e1000_adapter *adapter);
-void e1000_down(struct e1000_adapter *adapter);
-void e1000_reset(struct e1000_adapter *adapter);
-int e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx);
-int e1000_setup_all_tx_resources(struct e1000_adapter *adapter);
-int e1000_setup_all_rx_resources(struct e1000_adapter *adapter);
-void e1000_free_all_tx_resources(struct e1000_adapter *adapter);
-void e1000_free_all_rx_resources(struct e1000_adapter *adapter);
 static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
 				    struct e1000_tx_ring *txdr);
 static int e1000_setup_rx_resources(struct e1000_adapter *adapter,
@@ -182,7 +174,6 @@
 				    struct e1000_tx_ring *tx_ring);
 static void e1000_free_rx_resources(struct e1000_adapter *adapter,
 				    struct e1000_rx_ring *rx_ring);
-void e1000_update_stats(struct e1000_adapter *adapter);
 
 /* Local Function Prototypes */
 
@@ -241,7 +232,6 @@
 static int e1000_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
 static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
 			   int cmd);
-void e1000_set_ethtool_ops(struct net_device *netdev);
 static void e1000_enter_82542_rst(struct e1000_adapter *adapter);
 static void e1000_leave_82542_rst(struct e1000_adapter *adapter);
 static void e1000_tx_timeout(struct net_device *dev);
@@ -270,10 +260,6 @@
 void e1000_rx_schedule(void *data);
 #endif
 
-/* Exported from other modules */
-
-extern void e1000_check_options(struct e1000_adapter *adapter);
-
 static struct pci_driver e1000_driver = {
 	.name     = e1000_driver_name,
 	.id_table = e1000_pci_tbl,

