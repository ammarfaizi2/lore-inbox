Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVDLTM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVDLTM3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVDLTLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:11:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:47049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262208AbVDLKcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:35 -0400
Message-Id: <200504121032.j3CAWL2K005565@shell0.pdx.osdl.net>
Subject: [patch 107/198] u32 vs. pm_message_t fixes for drivers/net
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This fixes remaining u32s in drivers/ net.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/net/8139cp.c                          |    2 +-
 25-akpm/drivers/net/bmac.c                            |    2 +-
 25-akpm/drivers/net/irda/sa1100_ir.c                  |    2 +-
 25-akpm/drivers/net/irda/vlsi_ir.c                    |    2 +-
 25-akpm/drivers/net/pci-skeleton.c                    |    2 +-
 25-akpm/drivers/net/r8169.c                           |    2 +-
 25-akpm/drivers/net/smc91x.c                          |    2 +-
 25-akpm/drivers/net/tulip/de2104x.c                   |    2 +-
 25-akpm/drivers/net/tulip/winbond-840.c               |    2 +-
 25-akpm/drivers/net/tulip/xircom_tulip_cb.c           |    2 +-
 25-akpm/drivers/net/typhoon.c                         |    4 ++--
 25-akpm/drivers/net/wireless/airo.c                   |    4 ++--
 25-akpm/drivers/net/wireless/airport.c                |    2 +-
 25-akpm/drivers/net/wireless/orinoco_pci.c            |    4 ++--
 25-akpm/drivers/net/wireless/prism54/islpci_hotplug.c |    4 ++--
 15 files changed, 19 insertions(+), 19 deletions(-)

diff -puN drivers/net/8139cp.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/8139cp.c
--- 25/drivers/net/8139cp.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.783761104 -0700
+++ 25-akpm/drivers/net/8139cp.c	2005-04-12 03:21:28.813756544 -0700
@@ -1824,7 +1824,7 @@ static void cp_remove_one (struct pci_de
 }
 
 #ifdef CONFIG_PM
-static int cp_suspend (struct pci_dev *pdev, u32 state)
+static int cp_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev;
 	struct cp_private *cp;
diff -puN drivers/net/bmac.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/bmac.c
--- 25/drivers/net/bmac.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.784760952 -0700
+++ 25-akpm/drivers/net/bmac.c	2005-04-12 03:21:28.815756240 -0700
@@ -455,7 +455,7 @@ static void bmac_init_chip(struct net_de
 }
 
 #ifdef CONFIG_PM
-static int bmac_suspend(struct macio_dev *mdev, u32 state)
+static int bmac_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct net_device* dev = macio_get_drvdata(mdev);	
 	struct bmac_data *bp = netdev_priv(dev);
diff -puN drivers/net/irda/sa1100_ir.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/irda/sa1100_ir.c
--- 25/drivers/net/irda/sa1100_ir.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.786760648 -0700
+++ 25-akpm/drivers/net/irda/sa1100_ir.c	2005-04-12 03:21:28.816756088 -0700
@@ -291,7 +291,7 @@ static void sa1100_irda_shutdown(struct 
 /*
  * Suspend the IrDA interface.
  */
-static int sa1100_irda_suspend(struct device *_dev, u32 state, u32 level)
+static int sa1100_irda_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
 	struct net_device *dev = dev_get_drvdata(_dev);
 	struct sa1100_irda *si;
diff -puN drivers/net/irda/vlsi_ir.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/irda/vlsi_ir.c
--- 25/drivers/net/irda/vlsi_ir.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.787760496 -0700
+++ 25-akpm/drivers/net/irda/vlsi_ir.c	2005-04-12 03:21:28.817755936 -0700
@@ -1744,7 +1744,7 @@ static void __devexit vlsi_irda_remove(s
  */
 
 
-static int vlsi_irda_suspend(struct pci_dev *pdev, u32 state)
+static int vlsi_irda_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
 	vlsi_irda_dev_t *idev;
diff -puN drivers/net/pci-skeleton.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/pci-skeleton.c
--- 25/drivers/net/pci-skeleton.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.789760192 -0700
+++ 25-akpm/drivers/net/pci-skeleton.c	2005-04-12 03:21:28.819755632 -0700
@@ -1897,7 +1897,7 @@ static void netdrv_set_rx_mode (struct n
 
 #ifdef CONFIG_PM
 
-static int netdrv_suspend (struct pci_dev *pdev, u32 state)
+static int netdrv_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdrv_private *tp = dev->priv;
diff -puN drivers/net/r8169.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/r8169.c
--- 25/drivers/net/r8169.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.790760040 -0700
+++ 25-akpm/drivers/net/r8169.c	2005-04-12 03:21:28.821755328 -0700
@@ -1449,7 +1449,7 @@ rtl8169_remove_one(struct pci_dev *pdev)
 
 #ifdef CONFIG_PM
 
-static int rtl8169_suspend(struct pci_dev *pdev, u32 state)
+static int rtl8169_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct rtl8169_private *tp = netdev_priv(dev);
diff -puN drivers/net/smc91x.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/smc91x.c
--- 25/drivers/net/smc91x.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.792759736 -0700
+++ 25-akpm/drivers/net/smc91x.c	2005-04-12 03:21:28.823755024 -0700
@@ -2278,7 +2278,7 @@ static int smc_drv_remove(struct device 
 	return 0;
 }
 
-static int smc_drv_suspend(struct device *dev, u32 state, u32 level)
+static int smc_drv_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 
diff -puN drivers/net/tulip/de2104x.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/tulip/de2104x.c
--- 25/drivers/net/tulip/de2104x.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.794759432 -0700
+++ 25-akpm/drivers/net/tulip/de2104x.c	2005-04-12 03:21:28.824754872 -0700
@@ -2102,7 +2102,7 @@ static void __exit de_remove_one (struct
 
 #ifdef CONFIG_PM
 
-static int de_suspend (struct pci_dev *pdev, u32 state)
+static int de_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct de_private *de = dev->priv;
diff -puN drivers/net/tulip/winbond-840.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/tulip/winbond-840.c
--- 25/drivers/net/tulip/winbond-840.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.796759128 -0700
+++ 25-akpm/drivers/net/tulip/winbond-840.c	2005-04-12 03:21:28.832753656 -0700
@@ -1620,7 +1620,7 @@ static void __devexit w840_remove1 (stru
  * Detach must occur under spin_unlock_irq(), interrupts from a detached
  * device would cause an irq storm.
  */
-static int w840_suspend (struct pci_dev *pdev, u32 state)
+static int w840_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
diff -puN drivers/net/tulip/xircom_tulip_cb.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/tulip/xircom_tulip_cb.c
--- 25/drivers/net/tulip/xircom_tulip_cb.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.797758976 -0700
+++ 25-akpm/drivers/net/tulip/xircom_tulip_cb.c	2005-04-12 03:21:28.833753504 -0700
@@ -1655,7 +1655,7 @@ MODULE_DEVICE_TABLE(pci, xircom_pci_tabl
 
 
 #ifdef CONFIG_PM
-static int xircom_suspend(struct pci_dev *pdev, u32 state)
+static int xircom_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct xircom_private *tp = netdev_priv(dev);
diff -puN drivers/net/typhoon.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/typhoon.c
--- 25/drivers/net/typhoon.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.799758672 -0700
+++ 25-akpm/drivers/net/typhoon.c	2005-04-12 03:21:28.835753200 -0700
@@ -1906,7 +1906,7 @@ typhoon_sleep(struct typhoon *tp, pci_po
 	 */
 	netif_carrier_off(tp->dev);
 
-	pci_enable_wake(tp->pdev, state, 1);
+	pci_enable_wake(tp->pdev, pci_choose_state(pdev, state), 1);
 	pci_disable_device(pdev);
 	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
 }
@@ -2287,7 +2287,7 @@ need_resume:
 }
 
 static int
-typhoon_enable_wake(struct pci_dev *pdev, u32 state, int enable)
+typhoon_enable_wake(struct pci_dev *pdev, pci_power_t state, int enable)
 {
 	return pci_enable_wake(pdev, state, enable);
 }
diff -puN drivers/net/wireless/airo.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/wireless/airo.c
--- 25/drivers/net/wireless/airo.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.801758368 -0700
+++ 25-akpm/drivers/net/wireless/airo.c	2005-04-12 03:21:28.841752288 -0700
@@ -61,7 +61,7 @@ MODULE_DEVICE_TABLE(pci, card_ids);
 
 static int airo_pci_probe(struct pci_dev *, const struct pci_device_id *);
 static void airo_pci_remove(struct pci_dev *);
-static int airo_pci_suspend(struct pci_dev *pdev, u32 state);
+static int airo_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 static int airo_pci_resume(struct pci_dev *pdev);
 
 static struct pci_driver airo_driver = {
@@ -5464,7 +5464,7 @@ static void __devexit airo_pci_remove(st
 {
 }
 
-static int airo_pci_suspend(struct pci_dev *pdev, u32 state)
+static int airo_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct airo_info *ai = dev->priv;
diff -puN drivers/net/wireless/airport.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/wireless/airport.c
--- 25/drivers/net/wireless/airport.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.802758216 -0700
+++ 25-akpm/drivers/net/wireless/airport.c	2005-04-12 03:21:28.842752136 -0700
@@ -50,7 +50,7 @@ struct airport {
 };
 
 static int
-airport_suspend(struct macio_dev *mdev, u32 state)
+airport_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct net_device *dev = dev_get_drvdata(&mdev->ofdev.dev);
 	struct orinoco_private *priv = netdev_priv(dev);
diff -puN drivers/net/wireless/orinoco_pci.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/wireless/orinoco_pci.c
--- 25/drivers/net/wireless/orinoco_pci.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.804757912 -0700
+++ 25-akpm/drivers/net/wireless/orinoco_pci.c	2005-04-12 03:21:28.843751984 -0700
@@ -294,7 +294,7 @@ static void __devexit orinoco_pci_remove
 	pci_disable_device(pdev);
 }
 
-static int orinoco_pci_suspend(struct pci_dev *pdev, u32 state)
+static int orinoco_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct orinoco_private *priv = netdev_priv(dev);
@@ -323,7 +323,7 @@ static int orinoco_pci_suspend(struct pc
 	orinoco_unlock(priv, &flags);
 
 	pci_save_state(pdev);
-	pci_set_power_state(pdev, 3);
+	pci_set_power_state(pdev, PCI_D3hot);
 
 	return 0;
 }
diff -puN drivers/net/wireless/prism54/islpci_hotplug.c~u32-vs-pm_message_t-fixes-for-drivers-net drivers/net/wireless/prism54/islpci_hotplug.c
--- 25/drivers/net/wireless/prism54/islpci_hotplug.c~u32-vs-pm_message_t-fixes-for-drivers-net	2005-04-12 03:21:28.805757760 -0700
+++ 25-akpm/drivers/net/wireless/prism54/islpci_hotplug.c	2005-04-12 03:21:28.843751984 -0700
@@ -81,7 +81,7 @@ MODULE_DEVICE_TABLE(pci, prism54_id_tbl)
 
 static int prism54_probe(struct pci_dev *, const struct pci_device_id *);
 static void prism54_remove(struct pci_dev *);
-static int prism54_suspend(struct pci_dev *, u32 state);
+static int prism54_suspend(struct pci_dev *, pm_message_t state);
 static int prism54_resume(struct pci_dev *);
 
 static struct pci_driver prism54_driver = {
@@ -261,7 +261,7 @@ prism54_remove(struct pci_dev *pdev)
 }
 
 int
-prism54_suspend(struct pci_dev *pdev, u32 state)
+prism54_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
 	islpci_private *priv = ndev ? netdev_priv(ndev) : NULL;
_
