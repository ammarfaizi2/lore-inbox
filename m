Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUCOVun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbUCOVun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:50:43 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:46815 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262813AbUCOVrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:47:41 -0500
Date: Mon, 15 Mar 2004 21:46:59 GMT
Message-Id: <200403152146.i2FLkxSv002936@delerium.codemonkey.org.uk>
To: linux-kernel@vger.kernel.org
From: davej@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [3C509] Whitespace fixes.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No code changes, but lots of trivial whitespace cleaning, and
removal of a bogus set of 'defaults' at the bottom of the file.

		Dave

--- linux-2.6.4/drivers/net/3c509.c~	2004-03-15 20:37:23.000000000 +0000
+++ linux-2.6.4/drivers/net/3c509.c	2004-03-15 20:44:53.000000000 +0000
@@ -355,21 +355,21 @@
 
 static void el3_common_remove (struct net_device *dev)
 {
-		struct el3_private *lp = netdev_priv(dev);
+	struct el3_private *lp = netdev_priv(dev);
 
-		(void) lp;				/* Keep gcc quiet... */
+	(void) lp;				/* Keep gcc quiet... */
 #ifdef CONFIG_PM
-		if (lp->pmdev)
-			pm_unregister(lp->pmdev);
+	if (lp->pmdev)
+		pm_unregister(lp->pmdev);
 #endif
 #if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
-		if (lp->type == EL3_PNP)
-			pnp_device_detach(to_pnp_dev(lp->dev));
+	if (lp->type == EL3_PNP)
+		pnp_device_detach(to_pnp_dev(lp->dev));
 #endif
 
-		unregister_netdev (dev);
-		release_region(dev->base_addr, EL3_IO_EXTENT);
-		free_netdev (dev);
+	unregister_netdev (dev);
+	release_region(dev->base_addr, EL3_IO_EXTENT);
+	free_netdev (dev);
 }
 
 static int __init el3_probe(int card_idx)
@@ -397,9 +397,9 @@
 			if (pnp_device_attach(idev) < 0)
 				continue;
 			if (pnp_activate_dev(idev) < 0) {
-			      __again:
-			      	pnp_device_detach(idev);
-			      	continue;
+__again:
+				pnp_device_detach(idev);
+				continue;
 			}
 			if (!pnp_port_valid(idev, 0) || !pnp_irq_valid(idev, 0))
 				goto __again;
@@ -612,79 +612,80 @@
 }
 
 #ifdef CONFIG_MCA
-static int __init el3_mca_probe(struct device *device) {
-		/* Based on Erik Nygren's (nygren@mit.edu) 3c529 patch,
-		 * heavily modified by Chris Beauregard
-		 * (cpbeaure@csclub.uwaterloo.ca) to support standard MCA
-		 * probing.
-		 *
-		 * redone for multi-card detection by ZP Gu (zpg@castle.net)
-		 * now works as a module */
-
-		struct el3_private *lp;
-		short i;
-		int ioaddr, irq, if_port;
-		u16 phys_addr[3];
-		struct net_device *dev = NULL;
-		u_char pos4, pos5;
-		struct mca_device *mdev = to_mca_device(device);
-		int slot = mdev->slot;
-		int err;
-
-		pos4 = mca_device_read_stored_pos(mdev, 4);
-		pos5 = mca_device_read_stored_pos(mdev, 5);
-
-		ioaddr = ((short)((pos4&0xfc)|0x02)) << 8;
-		irq = pos5 & 0x0f;
-
-
-		printk("3c529: found %s at slot %d\n",
-			   el3_mca_adapter_names[mdev->index], slot + 1);
-
-		/* claim the slot */
-		strncpy(mdev->name, el3_mca_adapter_names[mdev->index],
-				sizeof(mdev->name));
-		mca_device_set_claim(mdev, 1);
-
-		if_port = pos4 & 0x03;
-
-		irq = mca_device_transform_irq(mdev, irq);
-		ioaddr = mca_device_transform_ioport(mdev, ioaddr); 
-		if (el3_debug > 2) {
-				printk("3c529: irq %d  ioaddr 0x%x  ifport %d\n", irq, ioaddr, if_port);
-		}
-		EL3WINDOW(0);
-		for (i = 0; i < 3; i++) {
-				phys_addr[i] = htons(read_eeprom(ioaddr, i));
-		}
+static int __init el3_mca_probe(struct device *device)
+{
+	/* Based on Erik Nygren's (nygren@mit.edu) 3c529 patch,
+	 * heavily modified by Chris Beauregard
+	 * (cpbeaure@csclub.uwaterloo.ca) to support standard MCA
+	 * probing.
+	 *
+	 * redone for multi-card detection by ZP Gu (zpg@castle.net)
+	 * now works as a module */
 
-		dev = alloc_etherdev(sizeof (struct el3_private));
-		if (dev == NULL) {
-				release_region(ioaddr, EL3_IO_EXTENT);
-				return -ENOMEM;
-		}
+	struct el3_private *lp;
+	short i;
+	int ioaddr, irq, if_port;
+	u16 phys_addr[3];
+	struct net_device *dev = NULL;
+	u_char pos4, pos5;
+	struct mca_device *mdev = to_mca_device(device);
+	int slot = mdev->slot;
+	int err;
+
+	pos4 = mca_device_read_stored_pos(mdev, 4);
+	pos5 = mca_device_read_stored_pos(mdev, 5);
 
-		SET_MODULE_OWNER(dev);
-		netdev_boot_setup_check(dev);
+	ioaddr = ((short)((pos4&0xfc)|0x02)) << 8;
+	irq = pos5 & 0x0f;
 
-		memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
-		dev->base_addr = ioaddr;
-		dev->irq = irq;
-		dev->if_port = if_port;
-		lp = netdev_priv(dev);
-		lp->dev = device;
-		lp->type = EL3_MCA;
-		device->driver_data = dev;
-		err = el3_common_init(dev);
-
-		if (err) {
-			device->driver_data = NULL;
-			free_netdev(dev);
+
+	printk("3c529: found %s at slot %d\n",
+		   el3_mca_adapter_names[mdev->index], slot + 1);
+
+	/* claim the slot */
+	strncpy(mdev->name, el3_mca_adapter_names[mdev->index],
+			sizeof(mdev->name));
+	mca_device_set_claim(mdev, 1);
+
+	if_port = pos4 & 0x03;
+
+	irq = mca_device_transform_irq(mdev, irq);
+	ioaddr = mca_device_transform_ioport(mdev, ioaddr); 
+	if (el3_debug > 2) {
+			printk("3c529: irq %d  ioaddr 0x%x  ifport %d\n", irq, ioaddr, if_port);
+	}
+	EL3WINDOW(0);
+	for (i = 0; i < 3; i++) {
+			phys_addr[i] = htons(read_eeprom(ioaddr, i));
+	}
+
+	dev = alloc_etherdev(sizeof (struct el3_private));
+	if (dev == NULL) {
+			release_region(ioaddr, EL3_IO_EXTENT);
 			return -ENOMEM;
-		}
+	}
 
-		el3_cards++;
-		return 0;
+	SET_MODULE_OWNER(dev);
+	netdev_boot_setup_check(dev);
+
+	memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
+	dev->base_addr = ioaddr;
+	dev->irq = irq;
+	dev->if_port = if_port;
+	lp = netdev_priv(dev);
+	lp->dev = device;
+	lp->type = EL3_MCA;
+	device->driver_data = dev;
+	err = el3_common_init(dev);
+
+	if (err) {
+		device->driver_data = NULL;
+		free_netdev(dev);
+		return -ENOMEM;
+	}
+
+	el3_cards++;
+	return 0;
 }
 		
 #endif /* CONFIG_MCA */
@@ -713,15 +714,15 @@
 	irq = inw(ioaddr + WN0_IRQ) >> 12;
 	if_port = inw(ioaddr + 6)>>14;
 	for (i = 0; i < 3; i++)
-			phys_addr[i] = htons(read_eeprom(ioaddr, i));
+		phys_addr[i] = htons(read_eeprom(ioaddr, i));
 
 	/* Restore the "Product ID" to the EEPROM read register. */
 	read_eeprom(ioaddr, 3);
 
 	dev = alloc_etherdev(sizeof (struct el3_private));
 	if (dev == NULL) {
-			release_region(ioaddr, EL3_IO_EXTENT);
-			return -ENOMEM;
+		release_region(ioaddr, EL3_IO_EXTENT);
+		return -ENOMEM;
 	}
 
 	SET_MODULE_OWNER(dev);
@@ -755,12 +756,12 @@
  * The net dev must be stored in the driver_data field */
 static int __devexit el3_device_remove (struct device *device)
 {
-		struct net_device *dev;
+	struct net_device *dev;
 
-		dev  = device->driver_data;
+	dev  = device->driver_data;
 
-		el3_common_remove (dev);
-		return 0;
+	el3_common_remove (dev);
+	return 0;
 }
 #endif
 
@@ -810,7 +811,8 @@
 	outw(SetStatusEnb | 0x00, ioaddr + EL3_CMD);
 
 	i = request_irq(dev->irq, &el3_interrupt, 0, dev->name, dev);
-	if (i) return i;
+	if (i)
+		return i;
 
 	EL3WINDOW(0);
 	if (el3_debug > 3)
@@ -891,8 +893,8 @@
 	 *	time sensitive devices.
 	 */
 
-    	spin_lock_irqsave(&lp->lock, flags);
-	    
+	spin_lock_irqsave(&lp->lock, flags);
+
 	/* Put out the doubleword header... */
 	outw(skb->len, ioaddr + TX_FIFO);
 	outw(0x00, ioaddr + TX_FIFO);
@@ -1164,7 +1166,7 @@
 		outw(SetRxFilter | RxStation | RxMulticast | RxBroadcast, ioaddr + EL3_CMD);
 	}
 	else
-                outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
+		outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
 	spin_unlock_irqrestore(&lp->lock, flags);
 }
 
@@ -1183,10 +1185,10 @@
 	/* Switching back to window 0 disables the IRQ. */
 	EL3WINDOW(0);
 	if (lp->type != EL3_EISA) {
-	    /* But we explicitly zero the IRQ line select anyway. Don't do
-	     * it on EISA cards, it prevents the module from getting an
-	     * IRQ after unload+reload... */
-	    outw(0x0f00, ioaddr + WN0_IRQ);
+		/* But we explicitly zero the IRQ line select anyway. Don't do
+		 * it on EISA cards, it prevents the module from getting an
+		 * IRQ after unload+reload... */
+		outw(0x0f00, ioaddr + WN0_IRQ);
 	}
 
 	return 0;
@@ -1654,7 +1656,7 @@
 
 #ifdef CONFIG_EISA
 	if (eisa_driver_register (&el3_eisa_driver) < 0) {
-			eisa_driver_unregister (&el3_eisa_driver);
+		eisa_driver_unregister (&el3_eisa_driver);
 	}
 #endif
 #ifdef CONFIG_MCA
@@ -1686,11 +1688,3 @@
 module_init (el3_init_module);
 module_exit (el3_cleanup_module);
 
-/*
- * Local variables:
- *  compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -c 3c509.c"
- *  version-control: t
- *  kept-new-versions: 5
- *  tab-width: 4
- * End:
- */

