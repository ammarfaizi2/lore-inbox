Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266283AbSKGCAn>; Wed, 6 Nov 2002 21:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266284AbSKGCAn>; Wed, 6 Nov 2002 21:00:43 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:40580 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266283AbSKGCAk>;
	Wed, 6 Nov 2002 21:00:40 -0500
Date: Wed, 6 Nov 2002 21:10:39 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Convert Gameport Driver - 2.5.46 (5/6)
Message-ID: <20021106211039.GP316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the gameport driver to the pnp changes.  It has been tested.

Thanks,
Adam



--- a/drivers/input/gameport/ns558.c	Thu Oct 31 00:43:38 2002
+++ b/drivers/input/gameport/ns558.c	Sun Nov  3 10:13:38 2002
@@ -37,7 +37,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/slab.h>
-#include <linux/isapnp.h>
+#include <linux/pnp.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Classic gameport (ISA/PnP) driver");
@@ -52,7 +52,7 @@
 struct ns558 {
 	int type;
 	int size;
-	struct pci_dev *dev;
+	struct pnp_dev *dev;
 	struct list_head node;
 	struct gameport gameport;
 	char phys[32];
@@ -159,67 +159,55 @@
 	list_add(&port->node, &ns558_list);
 }
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 
-#define NS558_DEVICE(a,b,c,d)\
-	.card_vendor = ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,\
-	.vendor = ISAPNP_VENDOR(a,b,c), function: ISAPNP_DEVICE(d)
-
-static struct isapnp_device_id pnp_devids[] = {
-	{ NS558_DEVICE('@','P','@',0x0001) }, /* ALS 100 */
-	{ NS558_DEVICE('@','P','@',0x0020) }, /* ALS 200 */
-	{ NS558_DEVICE('@','P','@',0x1001) }, /* ALS 100+ */
-	{ NS558_DEVICE('@','P','@',0x2001) }, /* ALS 120 */
-	{ NS558_DEVICE('A','S','B',0x16fd) }, /* AdLib NSC16 */
-	{ NS558_DEVICE('A','Z','T',0x3001) }, /* AZT1008 */
-	{ NS558_DEVICE('C','D','C',0x0001) }, /* Opl3-SAx */
-	{ NS558_DEVICE('C','S','C',0x0001) }, /* CS4232 */
-	{ NS558_DEVICE('C','S','C',0x000f) }, /* CS4236 */
-	{ NS558_DEVICE('C','S','C',0x0101) }, /* CS4327 */
-	{ NS558_DEVICE('C','T','L',0x7001) }, /* SB16 */
-	{ NS558_DEVICE('C','T','L',0x7002) }, /* AWE64 */
-	{ NS558_DEVICE('C','T','L',0x7005) }, /* Vibra16 */
-	{ NS558_DEVICE('E','N','S',0x2020) }, /* SoundscapeVIVO */
-	{ NS558_DEVICE('E','S','S',0x0001) }, /* ES1869 */
-	{ NS558_DEVICE('E','S','S',0x0005) }, /* ES1878 */
-	{ NS558_DEVICE('E','S','S',0x6880) }, /* ES688 */
-	{ NS558_DEVICE('I','B','M',0x0012) }, /* CS4232 */
-	{ NS558_DEVICE('O','P','T',0x0001) }, /* OPTi Audio16 */
-	{ NS558_DEVICE('Y','M','H',0x0006) }, /* Opl3-SA */
-	{ NS558_DEVICE('Y','M','H',0x0022) }, /* Opl3-SAx */
-	{ NS558_DEVICE('P','N','P',0xb02f) }, /* Generic */
-	{ 0, },
+static struct pnp_id pnp_devids[] = {
+	{ .id = "@P@0001", .driver_data = 0 }, /* ALS 100 */
+	{ .id = "@P@0020", .driver_data = 0 }, /* ALS 200 */
+	{ .id = "@P@1001", .driver_data = 0 }, /* ALS 100+ */
+	{ .id = "@P@2001", .driver_data = 0 }, /* ALS 120 */
+	{ .id = "ASB16fd", .driver_data = 0 }, /* AdLib NSC16 */
+	{ .id = "AZT3001", .driver_data = 0 }, /* AZT1008 */
+	{ .id = "CDC0001", .driver_data = 0 }, /* Opl3-SAx */
+	{ .id = "CSC0001", .driver_data = 0 }, /* CS4232 */
+	{ .id = "CSC000f", .driver_data = 0 }, /* CS4236 */
+	{ .id = "CSC0101", .driver_data = 0 }, /* CS4327 */
+	{ .id = "CTL7001", .driver_data = 0 }, /* SB16 */
+	{ .id = "CTL7002", .driver_data = 0 }, /* AWE64 */
+	{ .id = "CTL7005", .driver_data = 0 }, /* Vibra16 */
+	{ .id = "ENS2020", .driver_data = 0 }, /* SoundscapeVIVO */
+	{ .id = "ESS0001", .driver_data = 0 }, /* ES1869 */
+	{ .id = "ESS0005", .driver_data = 0 }, /* ES1878 */
+	{ .id = "ESS6880", .driver_data = 0 }, /* ES688 */
+	{ .id = "IBM0012", .driver_data = 0 }, /* CS4232 */
+	{ .id = "OPT0001", .driver_data = 0 }, /* OPTi Audio16 */
+	{ .id = "YMH0006", .driver_data = 0 }, /* Opl3-SA */
+	{ .id = "YMH0022", .driver_data = 0 }, /* Opl3-SAx */
+	{ .id = "PNPb02f", .driver_data = 0 }, /* Generic */
+	{ .id = "", },
 };
 
-MODULE_DEVICE_TABLE(isapnp, pnp_devids);
+MODULE_DEVICE_TABLE(pnp, pnp_devids);
 
-static void ns558_pnp_probe(struct pci_dev *dev)
+static int ns558_pnp_probe(struct pnp_dev *dev, const struct pnp_id *cid, const struct pnp_id *did)
 {
 	int ioport, iolen;
 	struct ns558 *port;
 
-	if (dev->prepare && dev->prepare(dev) < 0)
-		return;
-
 	if (!(dev->resource[0].flags & IORESOURCE_IO)) {
 		printk(KERN_WARNING "ns558: No i/o ports on a gameport? Weird\n");
-		return;
+		return -ENODEV;
 	}
 
-	if (dev->activate && dev->activate(dev) < 0) {
-		printk(KERN_ERR "ns558: PnP resource allocation failed\n");
-		return;
-	}
-	
-	ioport = pci_resource_start(dev, 0);
-	iolen = pci_resource_len(dev, 0);
+	ioport = pnp_port_start(dev,0);
+	iolen = pnp_port_len(dev,0);
 
 	if (!request_region(ioport, iolen, "ns558-pnp"))
-		goto deactivate;
+		return -EBUSY;
 
 	if (!(port = kmalloc(sizeof(struct ns558), GFP_KERNEL))) {
 		printk(KERN_ERR "ns558: Memory allocation failed.\n");
-		goto deactivate;
+		return -ENOMEM;
 	}
 	memset(port, 0, sizeof(struct ns558));
 
@@ -231,36 +219,38 @@
 	port->gameport.phys = port->phys;
 	port->gameport.name = port->name;
 	port->gameport.id.bustype = BUS_ISAPNP;
-	port->gameport.id.vendor = dev->vendor;
-	port->gameport.id.product = dev->device;
 	port->gameport.id.version = 0x100;
 
-	sprintf(port->phys, "isapnp%d.%d/gameport0", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	sprintf(port->phys, "pnp node %x/gameport0", dev->number);
 	sprintf(port->name, "%s", dev->name[0] ? dev->name : "NS558 PnP Gameport");
 
 	gameport_register_port(&port->gameport);
 
-	printk(KERN_INFO "gameport: NS558 PnP at isapnp%d.%d io %#x",
-		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn), port->gameport.io);
+	printk(KERN_INFO "gameport: NS558 PnP at PnP node %x io %#x",
+		dev->number, port->gameport.io);
 	if (iolen > 1) printk(" size %d", iolen);
 	printk(" speed %d kHz\n", port->gameport.speed);
 
 	list_add_tail(&port->node, &ns558_list);
-	return;
-
-deactivate:
-	if (dev->deactivate)
-		dev->deactivate(dev);
+	return 0;
 }
+
+static struct pnp_driver ns558_pnp_driver = {
+	.name		= "ns558",
+	.card_id_table	= NULL,
+	.id_table	= pnp_devids,
+	.probe		= ns558_pnp_probe,
+};
+
+#else
+
+static const struct pnp_driver ns558_pnp_driver;
+
 #endif
 
 int __init ns558_init(void)
 {
 	int i = 0;
-#ifdef __ISAPNP__
-	struct isapnp_device_id *devid;
-	struct pci_dev *dev = NULL;
-#endif
 
 /*
  * Probe for ISA ports.
@@ -268,17 +258,8 @@
 
 	while (ns558_isa_portlist[i]) 
 		ns558_isa_probe(ns558_isa_portlist[i++]);
-
-/*
- * Probe for PnP ports.
- */
-
-#ifdef __ISAPNP__
-	for (devid = pnp_devids; devid->vendor; devid++)
-		while ((dev = isapnp_find_dev(NULL, devid->vendor, devid->function, dev)))
-			ns558_pnp_probe(dev);
-#endif
-
+		
+	pnp_register_driver(&ns558_pnp_driver);
 	return list_empty(&ns558_list) ? -ENODEV : 0;
 }
 
@@ -290,13 +271,10 @@
 		gameport_unregister_port(&port->gameport);
 		switch (port->type) {
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 			case NS558_PNP:
-				if (port->dev->deactivate)
-					port->dev->deactivate(port->dev);
 				/* fall through */
 #endif
-
 			case NS558_ISA:
 				release_region(port->gameport.io, port->size);
 				break;
@@ -305,6 +283,7 @@
 				break;
 		}
 	}
+	pnp_unregister_driver(&ns558_pnp_driver);
 }
 
 module_init(ns558_init);
