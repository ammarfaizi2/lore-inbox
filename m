Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVDBVss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVDBVss (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVDBVQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:16:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26090 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261290AbVDBVM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:12:29 -0500
Date: Sat, 2 Apr 2005 23:12:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: u32 vs. pm_message_t fixes for drivers/net
Message-ID: <20050402211201.GA2056@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes remaining u32s in drivers/ net. [These patches are
independend].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/drivers/net/8139cp.c	2005-01-16 22:27:04.000000000 +0100
+++ linux-cvs/drivers/net/8139cp.c	2005-03-31 23:54:46.000000000 +0200
@@ -1824,7 +1824,7 @@
 }
 
 #ifdef CONFIG_PM
-static int cp_suspend (struct pci_dev *pdev, u32 state)
+static int cp_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev;
 	struct cp_private *cp;
--- clean-cvs/drivers/net/bmac.c	2005-01-21 23:03:20.000000000 +0100
+++ linux-cvs/drivers/net/bmac.c	2005-03-31 23:54:46.000000000 +0200
@@ -455,7 +455,7 @@
 }
 
 #ifdef CONFIG_PM
-static int bmac_suspend(struct macio_dev *mdev, u32 state)
+static int bmac_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct net_device* dev = macio_get_drvdata(mdev);	
 	struct bmac_data *bp = netdev_priv(dev);
--- clean-cvs/drivers/net/irda/sa1100_ir.c	2004-12-14 20:42:26.000000000 +0100
+++ linux-cvs/drivers/net/irda/sa1100_ir.c	2005-03-31 23:54:46.000000000 +0200
@@ -291,7 +291,7 @@
 /*
  * Suspend the IrDA interface.
  */
-static int sa1100_irda_suspend(struct device *_dev, u32 state, u32 level)
+static int sa1100_irda_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
 	struct net_device *dev = dev_get_drvdata(_dev);
 	struct sa1100_irda *si;
--- clean-cvs/drivers/net/irda/stir4200.c	2005-03-29 13:30:09.000000000 +0200
+++ linux-cvs/drivers/net/irda/stir4200.c	2005-03-31 23:54:46.000000000 +0200
@@ -1129,7 +1129,7 @@
 
 #ifdef CONFIG_PM
 /* Power management suspend, so power off the transmitter/receiver */
-static int stir_suspend(struct usb_interface *intf, u32 state)
+static int stir_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct stir_cb *stir = usb_get_intfdata(intf);
 
--- clean-cvs/drivers/net/irda/vlsi_ir.c	2005-03-29 13:30:09.000000000 +0200
+++ linux-cvs/drivers/net/irda/vlsi_ir.c	2005-03-31 23:54:46.000000000 +0200
@@ -1744,7 +1744,7 @@
  */
 
 
-static int vlsi_irda_suspend(struct pci_dev *pdev, u32 state)
+static int vlsi_irda_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
 	vlsi_irda_dev_t *idev;
--- clean-cvs/drivers/net/pci-skeleton.c	2005-01-16 22:27:11.000000000 +0100
+++ linux-cvs/drivers/net/pci-skeleton.c	2005-03-31 23:54:46.000000000 +0200
@@ -1897,7 +1897,7 @@
 
 #ifdef CONFIG_PM
 
-static int netdrv_suspend (struct pci_dev *pdev, u32 state)
+static int netdrv_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdrv_private *tp = dev->priv;
--- clean-cvs/drivers/net/r8169.c	2005-03-29 13:30:03.000000000 +0200
+++ linux-cvs/drivers/net/r8169.c	2005-03-31 23:54:46.000000000 +0200
@@ -1449,7 +1449,7 @@
 
 #ifdef CONFIG_PM
 
-static int rtl8169_suspend(struct pci_dev *pdev, u32 state)
+static int rtl8169_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct rtl8169_private *tp = netdev_priv(dev);
--- clean-cvs/drivers/net/smc91x.c	2005-03-29 13:30:04.000000000 +0200
+++ linux-cvs/drivers/net/smc91x.c	2005-03-31 23:54:46.000000000 +0200
@@ -2278,7 +2278,7 @@
 	return 0;
 }
 
-static int smc_drv_suspend(struct device *dev, u32 state, u32 level)
+static int smc_drv_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 
--- clean-cvs/drivers/net/tulip/de2104x.c	2005-03-29 13:30:11.000000000 +0200
+++ linux-cvs/drivers/net/tulip/de2104x.c	2005-03-31 23:54:46.000000000 +0200
@@ -2102,7 +2102,7 @@
 
 #ifdef CONFIG_PM
 
-static int de_suspend (struct pci_dev *pdev, u32 state)
+static int de_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct de_private *de = dev->priv;
--- clean-cvs/drivers/net/tulip/winbond-840.c	2005-01-21 23:03:30.000000000 +0100
+++ linux-cvs/drivers/net/tulip/winbond-840.c	2005-03-31 23:54:46.000000000 +0200
@@ -1620,7 +1620,7 @@
  * Detach must occur under spin_unlock_irq(), interrupts from a detached
  * device would cause an irq storm.
  */
-static int w840_suspend (struct pci_dev *pdev, u32 state)
+static int w840_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
--- clean-cvs/drivers/net/tulip/xircom_tulip_cb.c	2005-01-11 01:37:17.000000000 +0100
+++ linux-cvs/drivers/net/tulip/xircom_tulip_cb.c	2005-03-31 23:54:46.000000000 +0200
@@ -1655,7 +1655,7 @@
 
 
 #ifdef CONFIG_PM
-static int xircom_suspend(struct pci_dev *pdev, u32 state)
+static int xircom_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct xircom_private *tp = netdev_priv(dev);
--- clean-cvs/drivers/net/typhoon.c	2005-03-29 13:30:05.000000000 +0200
+++ linux-cvs/drivers/net/typhoon.c	2005-03-31 23:54:46.000000000 +0200
@@ -1906,7 +1906,7 @@
 	 */
 	netif_carrier_off(tp->dev);
 
-	pci_enable_wake(tp->pdev, state, 1);
+	pci_enable_wake(tp->pdev, pci_choose_state(pdev, state), 1);
 	pci_disable_device(pdev);
 	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
 }
@@ -2287,7 +2287,7 @@
 }
 
 static int
-typhoon_enable_wake(struct pci_dev *pdev, u32 state, int enable)
+typhoon_enable_wake(struct pci_dev *pdev, pci_power_t state, int enable)
 {
 	return pci_enable_wake(pdev, state, enable);
 }
--- clean-cvs/drivers/net/wireless/airo.c	2005-03-31 23:33:58.000000000 +0200
+++ linux-cvs/drivers/net/wireless/airo.c	2005-03-31 23:54:46.000000000 +0200
@@ -61,7 +61,7 @@
 
 static int airo_pci_probe(struct pci_dev *, const struct pci_device_id *);
 static void airo_pci_remove(struct pci_dev *);
-static int airo_pci_suspend(struct pci_dev *pdev, u32 state);
+static int airo_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 static int airo_pci_resume(struct pci_dev *pdev);
 
 static struct pci_driver airo_driver = {
@@ -5464,7 +5464,7 @@
 {
 }
 
-static int airo_pci_suspend(struct pci_dev *pdev, u32 state)
+static int airo_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct airo_info *ai = dev->priv;
--- clean-cvs/drivers/net/wireless/airport.c	2005-03-29 13:30:14.000000000 +0200
+++ linux-cvs/drivers/net/wireless/airport.c	2005-03-31 23:54:46.000000000 +0200
@@ -50,7 +50,7 @@
 };
 
 static int
-airport_suspend(struct macio_dev *mdev, u32 state)
+airport_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct net_device *dev = dev_get_drvdata(&mdev->ofdev.dev);
 	struct orinoco_private *priv = netdev_priv(dev);
--- clean-cvs/drivers/net/wireless/orinoco_pci.c	2005-03-29 13:30:15.000000000 +0200
+++ linux-cvs/drivers/net/wireless/orinoco_pci.c	2005-03-31 23:54:46.000000000 +0200
@@ -294,7 +294,7 @@
 	pci_disable_device(pdev);
 }
 
-static int orinoco_pci_suspend(struct pci_dev *pdev, u32 state)
+static int orinoco_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct orinoco_private *priv = netdev_priv(dev);
@@ -323,7 +323,7 @@
 	orinoco_unlock(priv, &flags);
 
 	pci_save_state(pdev);
-	pci_set_power_state(pdev, 3);
+	pci_set_power_state(pdev, PCI_D3hot);
 
 	return 0;
 }
--- clean-cvs/drivers/net/wireless/prism54/islpci_hotplug.c	2005-03-29 13:30:15.000000000 +0200
+++ linux-cvs/drivers/net/wireless/prism54/islpci_hotplug.c	2005-03-31 23:54:46.000000000 +0200
@@ -81,7 +81,7 @@
 
 static int prism54_probe(struct pci_dev *, const struct pci_device_id *);
 static void prism54_remove(struct pci_dev *);
-static int prism54_suspend(struct pci_dev *, u32 state);
+static int prism54_suspend(struct pci_dev *, pm_message_t state);
 static int prism54_resume(struct pci_dev *);
 
 static struct pci_driver prism54_driver = {
@@ -261,7 +261,7 @@
 }
 
 int
-prism54_suspend(struct pci_dev *pdev, u32 state)
+prism54_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
 	islpci_private *priv = ndev ? netdev_priv(ndev) : NULL;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
