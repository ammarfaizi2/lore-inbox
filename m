Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVAJRnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVAJRnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVAJRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:43:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:22161 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262346AbVAJRVB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:01 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776582129@kroah.com>
Date: Mon, 10 Jan 2005 09:20:58 -0800
Message-Id: <110537765824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.15, 2004/12/21 16:47:28-08:00, pavel@ucw.cz

[PATCH] PCI: fix sparse warnings in drivers/net/* and bttv

This should fix sparse warnings in drivers/net/* and bttv.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/media/video/bttv-driver.c |    4 ++--
 drivers/net/3c59x.c               |    8 ++++----
 drivers/net/8139cp.c              |    6 +++---
 drivers/net/8139too.c             |    4 ++--
 drivers/net/amd8111e.c            |   16 ++++++++--------
 drivers/net/e100.c                |    4 ++--
 drivers/net/eepro100.c            |    8 ++++----
 drivers/net/pci-skeleton.c        |    4 ++--
 drivers/net/sis900.c              |    4 ++--
 drivers/net/starfire.c            |    2 +-
 drivers/net/typhoon.c             |    6 +++---
 drivers/net/via-rhine.c           |    2 +-
 drivers/net/via-velocity.c        |   32 ++++++++++++++++----------------
 13 files changed, 50 insertions(+), 50 deletions(-)


diff -Nru a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
--- a/drivers/media/video/bttv-driver.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/media/video/bttv-driver.c	2005-01-10 09:00:13 -08:00
@@ -3942,7 +3942,7 @@
 
 	/* save pci state */
 	pci_save_state(pci_dev);
-	if (0 != pci_set_power_state(pci_dev, state)) {
+	if (0 != pci_set_power_state(pci_dev, device_to_pci_power(pci_dev, state))) {
 		pci_disable_device(pci_dev);
 		btv->state.disabled = 1;
 	}
@@ -3961,7 +3961,7 @@
 		pci_enable_device(pci_dev);
 		btv->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
 	/* restore bt878 state */
diff -Nru a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/3c59x.c	2005-01-10 09:00:13 -08:00
@@ -1549,7 +1549,7 @@
 	int i;
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
 		pci_restore_state(VORTEX_PCI(vp));
 	}
 
@@ -2941,7 +2941,7 @@
 	/* The kernel core really should have pci_get_power_state() */
 
 	if(state != 0)
-		pci_set_power_state(VORTEX_PCI(vp), 0);
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);
 	err = vortex_do_ioctl(dev, rq, cmd);
 	if(state != 0)
 		pci_set_power_state(VORTEX_PCI(vp), state);
@@ -3140,7 +3140,7 @@
 
 	/* Change the power state to D3; RxEnable doesn't take effect. */
 	pci_enable_wake(VORTEX_PCI(vp), 0, 1);
-	pci_set_power_state(VORTEX_PCI(vp), 3);
+	pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
 }
 
 
@@ -3163,7 +3163,7 @@
 	unregister_netdev(dev);
 
 	if (VORTEX_PCI(vp) && vp->enable_wol) {
-		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
 		if (vp->pm_state_valid)
 			pci_restore_state(VORTEX_PCI(vp));
 	}
diff -Nru a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/8139cp.c	2005-01-10 09:00:13 -08:00
@@ -1623,7 +1623,7 @@
 static void cp_set_d3_state (struct cp_private *cp)
 {
 	pci_enable_wake (cp->pdev, 0, 1); /* Enable PME# generation */
-	pci_set_power_state (cp->pdev, 3);
+	pci_set_power_state (cp->pdev, PCI_D3hot);
 }
 
 static int cp_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1813,7 +1813,7 @@
 		BUG();
 	unregister_netdev(dev);
 	iounmap(cp->regs);
-	if (cp->wol_enabled) pci_set_power_state (pdev, 0);
+	if (cp->wol_enabled) pci_set_power_state (pdev, PCI_D0);
 	pci_release_regions(pdev);
 	pci_clear_mwi(pdev);
 	pci_disable_device(pdev);
@@ -1863,7 +1863,7 @@
 	netif_device_attach (dev);
 	
 	if (cp->pdev && cp->wol_enabled) {
-		pci_set_power_state (cp->pdev, 0);
+		pci_set_power_state (cp->pdev, PCI_D0);
 		pci_restore_state (cp->pdev);
 	}
 	
diff -Nru a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/8139too.c	2005-01-10 09:00:13 -08:00
@@ -2607,7 +2607,7 @@
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -2620,7 +2620,7 @@
 	pci_restore_state (pdev);
 	if (!netif_running (dev))
 		return 0;
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
 	netif_device_attach (dev);
diff -Nru a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
--- a/drivers/net/amd8111e.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/amd8111e.c	2005-01-10 09:00:13 -08:00
@@ -1826,17 +1826,17 @@
 		if(lp->options & OPTION_WAKE_PHY_ENABLE)
 			amd8111e_enable_link_change(lp);	
 		
-		pci_enable_wake(pci_dev, 3, 1);
-		pci_enable_wake(pci_dev, 4, 1); /* D3 cold */
+		pci_enable_wake(pci_dev, PCI_D3hot, 1);
+		pci_enable_wake(pci_dev, PCI_D3cold, 1);
 
 	}
 	else{		
-		pci_enable_wake(pci_dev, 3, 0);
-		pci_enable_wake(pci_dev, 4, 0); /* 4 == D3 cold */
+		pci_enable_wake(pci_dev, PCI_D3hot, 0);
+		pci_enable_wake(pci_dev, PCI_D3cold, 0);
 	}
 	
 	pci_save_state(pci_dev);
-	pci_set_power_state(pci_dev, 3);
+	pci_set_power_state(pci_dev, PCI_D3hot);
 
 	return 0;
 }
@@ -1848,11 +1848,11 @@
 	if (!netif_running(dev))
 		return 0;
 
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
-	pci_enable_wake(pci_dev, 3, 0);
-	pci_enable_wake(pci_dev, 4, 0); /* D3 cold */
+	pci_enable_wake(pci_dev, PCI_D3hot, 0);
+	pci_enable_wake(pci_dev, PCI_D3cold, 0); /* D3 cold */
 
 	netif_device_attach(dev);
 
diff -Nru a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/e100.c	2005-01-10 09:00:13 -08:00
@@ -2326,7 +2326,7 @@
 	pci_save_state(pdev);
 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
@@ -2336,7 +2336,7 @@
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	e100_hw_init(nic);
 
diff -Nru a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/eepro100.c	2005-01-10 09:00:13 -08:00
@@ -1014,7 +1014,7 @@
 	if (netif_msg_ifup(sp))
 		printk(KERN_DEBUG "%s: speedo_open() irq %d.\n", dev->name, dev->irq);
 
-	pci_set_power_state(sp->pdev, 0);
+	pci_set_power_state(sp->pdev, PCI_D0);
 
 	/* Set up the Tx queue early.. */
 	sp->cur_tx = 0;
@@ -1963,7 +1963,7 @@
 	if (netif_msg_ifdown(sp))
 		printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n", dev->name, i);
 
-	pci_set_power_state(sp->pdev, 2);
+	pci_set_power_state(sp->pdev, PCI_D2);
 
 	return 0;
 }
@@ -2088,7 +2088,7 @@
 		   access from the timeout handler.
 		   They are currently serialized only with MDIO access from the
 		   timer routine.  2000/05/09 SAW */
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = pci_set_power_state(sp->pdev, PCI_D0);
 		t = del_timer_sync(&sp->timer);
 		data->val_out = mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1f);
 		if (t)
@@ -2099,7 +2099,7 @@
 	case SIOCSMIIREG:		/* Write MII PHY register. */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = pci_set_power_state(sp->pdev, PCI_D0);
 		t = del_timer_sync(&sp->timer);
 		mdio_write(dev, data->phy_id, data->reg_num, data->val_in);
 		if (t)
diff -Nru a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
--- a/drivers/net/pci-skeleton.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/pci-skeleton.c	2005-01-10 09:00:13 -08:00
@@ -1921,7 +1921,7 @@
 	spin_unlock_irqrestore (&tp->lock, flags);
 
 	pci_save_state (pdev);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -1934,7 +1934,7 @@
 
 	if (!netif_running(dev))
 		return 0;
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	pci_restore_state (pdev);
 	netif_device_attach (dev);
 	netdrv_hw_start (dev);
diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/sis900.c	2005-01-10 09:00:13 -08:00
@@ -2238,7 +2238,7 @@
 	/* Stop the chip's Tx and Rx Status Machine */
 	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
 
-	pci_set_power_state(pci_dev, 3);
+	pci_set_power_state(pci_dev, PCI_D3);
 	pci_save_state(pci_dev);
 
 	return 0;
@@ -2253,7 +2253,7 @@
 	if(!netif_running(net_dev))
 		return 0;
 	pci_restore_state(pci_dev);
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 
 	sis900_init_rxfilter(net_dev);
 
diff -Nru a/drivers/net/starfire.c b/drivers/net/starfire.c
--- a/drivers/net/starfire.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/starfire.c	2005-01-10 09:00:13 -08:00
@@ -2159,7 +2159,7 @@
 
 
 	/* XXX: add wakeup code -- requires firmware for MagicPacket */
-	pci_set_power_state(pdev, 3);	/* go to sleep in D3 mode */
+	pci_set_power_state(pdev, PCI_D3hot);	/* go to sleep in D3 mode */
 	pci_disable_device(pdev);
 
 	iounmap((char *)dev->base_addr);
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/typhoon.c	2005-01-10 09:00:13 -08:00
@@ -1890,7 +1890,7 @@
 
 	pci_enable_wake(tp->pdev, state, 1);
 	pci_disable_device(pdev);
-	return pci_set_power_state(pdev, state);
+	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
 }
 
 static int
@@ -1899,7 +1899,7 @@
 	struct pci_dev *pdev = tp->pdev;
 	void __iomem *ioaddr = tp->ioaddr;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 
 	/* Post 2.x.x versions of the Sleep Image require a reset before
@@ -2553,7 +2553,7 @@
 	struct typhoon *tp = netdev_priv(dev);
 
 	unregister_netdev(dev);
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	typhoon_reset(tp->ioaddr, NoWait);
 	iounmap(tp->ioaddr);
diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/via-rhine.c	2005-01-10 09:00:13 -08:00
@@ -1974,7 +1974,7 @@
         if (request_irq(dev->irq, rhine_interrupt, SA_SHIRQ, dev->name, dev))
 		printk(KERN_ERR "via-rhine %s: request_irq failed\n", dev->name);
 
-	ret = pci_set_power_state(pdev, 0);
+	ret = pci_set_power_state(pdev, PCI_D0);
 	if (debug > 1)
 		printk(KERN_INFO "%s: Entering power state D0 %s (%d).\n",
 			dev->name, ret ? "failed" : "succeeded", ret);
diff -Nru a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
--- a/drivers/net/via-velocity.c	2005-01-10 09:00:13 -08:00
+++ b/drivers/net/via-velocity.c	2005-01-10 09:00:13 -08:00
@@ -804,7 +804,7 @@
 	
 	/* and leave the chip powered down */
 	
-	pci_set_power_state(pdev, 3);
+	pci_set_power_state(pdev, PCI_D3hot);
 #ifdef CONFIG_PM
 	{
 		unsigned long flags;
@@ -1742,7 +1742,7 @@
 		goto err_free_rd_ring;
 	
 	/* Ensure chip is running */	
-	pci_set_power_state(vptr->pdev, 0);
+	pci_set_power_state(vptr->pdev, PCI_D0);
 	
 	velocity_init_registers(vptr, VELOCITY_INIT_COLD);
 
@@ -1750,7 +1750,7 @@
 			  dev->name, dev);
 	if (ret < 0) {
 		/* Power down the chip */
-		pci_set_power_state(vptr->pdev, 3);
+		pci_set_power_state(vptr->pdev, PCI_D3hot);
 		goto err_free_td_ring;
 	}
 
@@ -1868,7 +1868,7 @@
 		free_irq(dev->irq, dev);
 		
 	/* Power down the chip */
-	pci_set_power_state(vptr->pdev, 3);
+	pci_set_power_state(vptr->pdev, PCI_D3hot);
 	
 	/* Free the resources */
 	velocity_free_td_ring(vptr);
@@ -2194,8 +2194,8 @@
 	/* If we are asked for information and the device is power
 	   saving then we need to bring the device back up to talk to it */
 	   	
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 0);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D0);
 		
 	switch (cmd) {
 	case SIOCGMIIPHY:	/* Get address of MII PHY in use. */
@@ -2207,8 +2207,8 @@
 	default:
 		ret = -EOPNOTSUPP;
 	}
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 3);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D3hot);
 		
 		
 	return ret;
@@ -2818,8 +2818,8 @@
 static int velocity_ethtool_up(struct net_device *dev)
 {
 	struct velocity_info *vptr = dev->priv;
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 0);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D0);
 	return 0;
 }	
 
@@ -2834,8 +2834,8 @@
 static void velocity_ethtool_down(struct net_device *dev)
 {
 	struct velocity_info *vptr = dev->priv;
-	if(!netif_running(dev))
-		pci_set_power_state(vptr->pdev, 3);
+	if (!netif_running(dev))
+		pci_set_power_state(vptr->pdev, PCI_D3hot);
 }
 
 static int velocity_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
@@ -3229,15 +3229,15 @@
 		velocity_shutdown(vptr);
 		velocity_set_wol(vptr);
 		pci_enable_wake(pdev, 3, 1);
-		pci_set_power_state(pdev, 3);
+		pci_set_power_state(pdev, PCI_D3hot);
 	} else {
 		velocity_save_context(vptr, &vptr->context);
 		velocity_shutdown(vptr);
 		pci_disable_device(pdev);
-		pci_set_power_state(pdev, state);
+		pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	}
 #else
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 #endif
 	spin_unlock_irqrestore(&vptr->lock, flags);
 	return 0;
@@ -3252,7 +3252,7 @@
 	if(!netif_running(vptr->dev))
 		return 0;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_enable_wake(pdev, 0, 0);
 	pci_restore_state(pdev);
 

