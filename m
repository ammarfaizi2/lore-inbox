Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264020AbVBDXTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbVBDXTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbVBDW6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:58:33 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:50194 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S262730AbVBDWLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:11:35 -0500
Message-ID: <4203F3D5.9060605@gentoo.org>
Date: Fri, 04 Feb 2005 22:14:45 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: [-mm PATCH] driver model: PM type conversions in drivers/net
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060601080907040605050201"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CxBfg-000MEb-1e*OXhkEez5uhE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601080907040605050201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes PM driver model type checking for drivers/net.
Acked by Pavel Machek.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------060601080907040605050201
Content-Type: text/x-patch;
 name="net-pm-type-safety.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-pm-type-safety.patch"

diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/8139cp.c linux-dsd/drivers/net/8139cp.c
--- linux-2.6.11-rc2-mm2/drivers/net/8139cp.c	2005-02-02 21:55:22.417771864 +0000
+++ linux-dsd/drivers/net/8139cp.c	2005-02-02 20:52:06.000000000 +0000
@@ -1862,7 +1862,7 @@ static void cp_remove_one (struct pci_de
 }
 
 #ifdef CONFIG_PM
-static int cp_suspend (struct pci_dev *pdev, u32 state)
+static int cp_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev;
 	struct cp_private *cp;
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/bmac.c linux-dsd/drivers/net/bmac.c
--- linux-2.6.11-rc2-mm2/drivers/net/bmac.c	2005-02-02 21:54:17.353663112 +0000
+++ linux-dsd/drivers/net/bmac.c	2005-02-02 20:52:48.000000000 +0000
@@ -455,7 +455,7 @@ static void bmac_init_chip(struct net_de
 }
 
 #ifdef CONFIG_PM
-static int bmac_suspend(struct macio_dev *mdev, u32 state)
+static int bmac_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct net_device* dev = macio_get_drvdata(mdev);	
 	struct bmac_data *bp = netdev_priv(dev);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/irda/sa1100_ir.c linux-dsd/drivers/net/irda/sa1100_ir.c
--- linux-2.6.11-rc2-mm2/drivers/net/irda/sa1100_ir.c	2004-12-24 21:35:50.000000000 +0000
+++ linux-dsd/drivers/net/irda/sa1100_ir.c	2005-02-02 20:59:28.000000000 +0000
@@ -291,7 +291,7 @@ static void sa1100_irda_shutdown(struct 
 /*
  * Suspend the IrDA interface.
  */
-static int sa1100_irda_suspend(struct device *_dev, u32 state, u32 level)
+static int sa1100_irda_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
 	struct net_device *dev = dev_get_drvdata(_dev);
 	struct sa1100_irda *si;
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/irda/stir4200.c linux-dsd/drivers/net/irda/stir4200.c
--- linux-2.6.11-rc2-mm2/drivers/net/irda/stir4200.c	2005-02-02 21:54:17.000000000 +0000
+++ linux-dsd/drivers/net/irda/stir4200.c	2005-02-02 20:58:41.000000000 +0000
@@ -1128,7 +1128,7 @@ static void stir_disconnect(struct usb_i
 
 #ifdef CONFIG_PM
 /* Power management suspend, so power off the transmitter/receiver */
-static int stir_suspend(struct usb_interface *intf, u32 state)
+static int stir_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct stir_cb *stir = usb_get_intfdata(intf);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/irda/vlsi_ir.c linux-dsd/drivers/net/irda/vlsi_ir.c
--- linux-2.6.11-rc2-mm2/drivers/net/irda/vlsi_ir.c	2005-02-02 21:54:17.000000000 +0000
+++ linux-dsd/drivers/net/irda/vlsi_ir.c	2005-02-02 21:19:25.000000000 +0000
@@ -1737,7 +1737,7 @@ static void __devexit vlsi_irda_remove(s
  */
 
 
-static int vlsi_irda_suspend(struct pci_dev *pdev, u32 state)
+static int vlsi_irda_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
 	vlsi_irda_dev_t *idev;
@@ -1755,7 +1755,7 @@ static int vlsi_irda_suspend(struct pci_
 	down(&idev->sem);
 	if (pdev->current_state != 0) {			/* already suspended */
 		if (state > pdev->current_state) {	/* simply go deeper */
-			pci_set_power_state(pdev,state);
+			pci_set_power_state(pdev, pci_choose_state(pdev, state));
 			pdev->current_state = state;
 		}
 		else
@@ -1774,7 +1774,7 @@ static int vlsi_irda_suspend(struct pci_
 			idev->new_baud = idev->baud;
 	}
 
-	pci_set_power_state(pdev,state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	pdev->current_state = state;
 	idev->resume_ok = 1;
 	up(&idev->sem);
@@ -1798,7 +1798,7 @@ static int vlsi_irda_resume(struct pci_d
 		return 0;
 	}
 	
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pdev->current_state = 0;
 
 	if (!idev->resume_ok) {
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/ixgb/ixgb_main.c linux-dsd/drivers/net/ixgb/ixgb_main.c
--- linux-2.6.11-rc2-mm2/drivers/net/ixgb/ixgb_main.c	2005-02-02 21:54:18.000000000 +0000
+++ linux-dsd/drivers/net/ixgb/ixgb_main.c	2005-02-02 21:20:34.000000000 +0000
@@ -2101,7 +2101,7 @@ ixgb_notify_reboot(struct notifier_block
  * @param state power state to enter 
  **/
 static int
-ixgb_suspend(struct pci_dev *pdev, uint32_t state)
+ixgb_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct ixgb_adapter *adapter = netdev->priv;
@@ -2113,7 +2113,7 @@ ixgb_suspend(struct pci_dev *pdev, uint3
 
 	pci_save_state(pdev);
 
-	state = (state > 0) ? 3 : 0;
+	state = (state > 0) ? PCI_D3hot : PCI_D0;
 	pci_set_power_state(pdev, state);
 	msec_delay(200);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/ne2k-pci.c linux-dsd/drivers/net/ne2k-pci.c
--- linux-2.6.11-rc2-mm2/drivers/net/ne2k-pci.c	2005-02-02 21:55:22.999683400 +0000
+++ linux-dsd/drivers/net/ne2k-pci.c	2005-02-02 21:20:52.000000000 +0000
@@ -669,7 +669,7 @@ static int ne2k_pci_resume (struct pci_d
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	NS8390_init(dev, 1);
 	netif_device_attach(dev);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/pci-skeleton.c linux-dsd/drivers/net/pci-skeleton.c
--- linux-2.6.11-rc2-mm2/drivers/net/pci-skeleton.c	2005-02-02 21:54:18.000000000 +0000
+++ linux-dsd/drivers/net/pci-skeleton.c	2005-02-02 20:54:04.000000000 +0000
@@ -1897,7 +1897,7 @@ static void netdrv_set_rx_mode (struct n
 
 #ifdef CONFIG_PM
 
-static int netdrv_suspend (struct pci_dev *pdev, u32 state)
+static int netdrv_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdrv_private *tp = dev->priv;
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/r8169.c linux-dsd/drivers/net/r8169.c
--- linux-2.6.11-rc2-mm2/drivers/net/r8169.c	2005-02-02 21:54:18.000000000 +0000
+++ linux-dsd/drivers/net/r8169.c	2005-02-02 20:54:35.000000000 +0000
@@ -1411,7 +1411,7 @@ rtl8169_remove_one(struct pci_dev *pdev)
 
 #ifdef CONFIG_PM
 
-static int rtl8169_suspend(struct pci_dev *pdev, u32 state)
+static int rtl8169_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct rtl8169_private *tp = netdev_priv(dev);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/skge.c linux-dsd/drivers/net/skge.c
--- linux-2.6.11-rc2-mm2/drivers/net/skge.c	2005-02-02 21:55:23.229648440 +0000
+++ linux-dsd/drivers/net/skge.c	2005-02-02 20:55:04.000000000 +0000
@@ -3264,7 +3264,7 @@ static void __devexit skge_remove(struct
 }
 
 #ifdef CONFIG_PM
-static int skge_suspend(struct pci_dev *pdev, u32 state)
+static int skge_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct skge_hw *hw  = pci_get_drvdata(pdev);
 	int i, wol = 0;
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/smc91x.c linux-dsd/drivers/net/smc91x.c
--- linux-2.6.11-rc2-mm2/drivers/net/smc91x.c	2005-02-02 21:55:23.394623360 +0000
+++ linux-dsd/drivers/net/smc91x.c	2005-02-02 20:56:22.000000000 +0000
@@ -2258,7 +2258,7 @@ static int smc_drv_remove(struct device 
 	return 0;
 }
 
-static int smc_drv_suspend(struct device *dev, u32 state, u32 level)
+static int smc_drv_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/tulip/de2104x.c linux-dsd/drivers/net/tulip/de2104x.c
--- linux-2.6.11-rc2-mm2/drivers/net/tulip/de2104x.c	2005-02-02 21:55:23.440616368 +0000
+++ linux-dsd/drivers/net/tulip/de2104x.c	2005-02-02 21:01:39.000000000 +0000
@@ -2102,7 +2102,7 @@ static void __exit de_remove_one (struct
 
 #ifdef CONFIG_PM
 
-static int de_suspend (struct pci_dev *pdev, u32 state)
+static int de_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct de_private *de = dev->priv;
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/tulip/winbond-840.c linux-dsd/drivers/net/tulip/winbond-840.c
--- linux-2.6.11-rc2-mm2/drivers/net/tulip/winbond-840.c	2005-02-02 21:54:18.000000000 +0000
+++ linux-dsd/drivers/net/tulip/winbond-840.c	2005-02-02 21:02:03.000000000 +0000
@@ -1620,7 +1620,7 @@ static void __devexit w840_remove1 (stru
  * Detach must occur under spin_unlock_irq(), interrupts from a detached
  * device would cause an irq storm.
  */
-static int w840_suspend (struct pci_dev *pdev, u32 state)
+static int w840_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/tulip/xircom_tulip_cb.c linux-dsd/drivers/net/tulip/xircom_tulip_cb.c
--- linux-2.6.11-rc2-mm2/drivers/net/tulip/xircom_tulip_cb.c	2005-02-02 21:54:18.000000000 +0000
+++ linux-dsd/drivers/net/tulip/xircom_tulip_cb.c	2005-02-02 21:21:31.000000000 +0000
@@ -1655,7 +1655,7 @@ MODULE_DEVICE_TABLE(pci, xircom_pci_tabl
 
 
 #ifdef CONFIG_PM
-static int xircom_suspend(struct pci_dev *pdev, u32 state)
+static int xircom_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct xircom_private *tp = netdev_priv(dev);
@@ -1665,7 +1665,7 @@ static int xircom_suspend(struct pci_dev
 
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, 3);
+	pci_set_power_state(pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -1677,7 +1677,7 @@ static int xircom_resume(struct pci_dev 
 	struct xircom_private *tp = netdev_priv(dev);
 	printk(KERN_INFO "xircom_resume(%s)\n", dev->name);
 
-	pci_set_power_state(pdev,0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_enable_device(pdev);
 	pci_restore_state(pdev);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/wireless/airo.c linux-dsd/drivers/net/wireless/airo.c
--- linux-2.6.11-rc2-mm2/drivers/net/wireless/airo.c	2005-02-02 21:55:23.000000000 +0000
+++ linux-dsd/drivers/net/wireless/airo.c	2005-02-02 21:07:22.000000000 +0000
@@ -61,7 +61,7 @@ MODULE_DEVICE_TABLE(pci, card_ids);
 
 static int airo_pci_probe(struct pci_dev *, const struct pci_device_id *);
 static void airo_pci_remove(struct pci_dev *);
-static int airo_pci_suspend(struct pci_dev *pdev, u32 state);
+static int airo_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 static int airo_pci_resume(struct pci_dev *pdev);
 
 static struct pci_driver airo_driver = {
@@ -1206,7 +1206,7 @@ struct airo_info {
 	unsigned char		__iomem *pciaux;
 	unsigned char		*shared;
 	dma_addr_t		shared_dma;
-	int			power;
+	pm_message_t		power;
 	SsidRid			*SSID;
 	APListRid		*APList;
 #define	PCI_SHARED_LEN		2*MPI_MAX_FIDS*PKTSIZE+RIDSIZE
@@ -5464,7 +5464,7 @@ static void __devexit airo_pci_remove(st
 {
 }
 
-static int airo_pci_suspend(struct pci_dev *pdev, u32 state)
+static int airo_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct airo_info *ai = dev->priv;
@@ -5489,9 +5489,9 @@ static int airo_pci_suspend(struct pci_d
 	cmd.cmd=HOSTSLEEP;
 	issuecommand(ai, &cmd, &rsp);
 
-	pci_enable_wake(pdev, state, 1);
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), 1);
 	pci_save_state(pdev);
-	return pci_set_power_state(pdev, state);
+	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
 }
 
 static int airo_pci_resume(struct pci_dev *pdev)
@@ -5500,7 +5500,7 @@ static int airo_pci_resume(struct pci_de
 	struct airo_info *ai = dev->priv;
 	Resp rsp;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_enable_wake(pdev, ai->power, 0);
 
@@ -5531,7 +5531,7 @@ static int airo_pci_resume(struct pci_de
 	}
 	writeConfigRid(ai, 0);
 	enable_MAC(ai, &rsp, 0);
-	ai->power = 0;
+	ai->power = PCI_D0;
 	netif_device_attach(dev);
 	netif_wake_queue(dev);
 	enable_interrupts(ai);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/wireless/airport.c linux-dsd/drivers/net/wireless/airport.c
--- linux-2.6.11-rc2-mm2/drivers/net/wireless/airport.c	2005-02-02 21:55:23.000000000 +0000
+++ linux-dsd/drivers/net/wireless/airport.c	2005-02-02 21:02:38.000000000 +0000
@@ -51,7 +51,7 @@ struct airport {
 };
 
 static int
-airport_suspend(struct macio_dev *mdev, u32 state)
+airport_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	struct net_device *dev = dev_get_drvdata(&mdev->ofdev.dev);
 	struct orinoco_private *priv = netdev_priv(dev);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/wireless/hostap/hostap_pci.c linux-dsd/drivers/net/wireless/hostap/hostap_pci.c
--- linux-2.6.11-rc2-mm2/drivers/net/wireless/hostap/hostap_pci.c	2005-02-02 21:55:23.000000000 +0000
+++ linux-dsd/drivers/net/wireless/hostap/hostap_pci.c	2005-02-02 21:09:07.000000000 +0000
@@ -384,7 +384,7 @@ static void prism2_pci_remove(struct pci
 
 
 #ifdef CONFIG_PM
-static int prism2_pci_suspend(struct pci_dev *pdev, u32 state)
+static int prism2_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -395,7 +395,7 @@ static int prism2_pci_suspend(struct pci
 	prism2_hw_shutdown(dev, 0);
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, 3);
+	pci_set_power_state(pdev, PCI_D3hot);
 
 	return 0;
 }
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/wireless/orinoco_pci.c linux-dsd/drivers/net/wireless/orinoco_pci.c
--- linux-2.6.11-rc2-mm2/drivers/net/wireless/orinoco_pci.c	2005-02-02 21:55:23.000000000 +0000
+++ linux-dsd/drivers/net/wireless/orinoco_pci.c	2005-02-02 21:08:37.000000000 +0000
@@ -297,7 +297,7 @@ static void __devexit orinoco_pci_remove
 	pci_disable_device(pdev);
 }
 
-static int orinoco_pci_suspend(struct pci_dev *pdev, u32 state)
+static int orinoco_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct orinoco_private *priv = netdev_priv(dev);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/net/wireless/prism54/islpci_hotplug.c linux-dsd/drivers/net/wireless/prism54/islpci_hotplug.c
--- linux-2.6.11-rc2-mm2/drivers/net/wireless/prism54/islpci_hotplug.c	2005-02-02 21:54:19.000000000 +0000
+++ linux-dsd/drivers/net/wireless/prism54/islpci_hotplug.c	2005-02-02 21:10:06.000000000 +0000
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

--------------060601080907040605050201--
