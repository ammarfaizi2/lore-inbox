Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbSLKUBh>; Wed, 11 Dec 2002 15:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbSLKUBh>; Wed, 11 Dec 2002 15:01:37 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:49929 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267213AbSLKUAk>; Wed, 11 Dec 2002 15:00:40 -0500
Date: Wed, 11 Dec 2002 14:08:21 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/net
Message-ID: <20021211200821.GC28537@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small patchset for various files in drivers/net that switch
these files to use C99 initializers. The patches are against 2.5.51.

Art Haas

--- linux-2.5.51/drivers/net/e100/e100_main.c.old	2002-12-10 09:33:52.000000000 -0600
+++ linux-2.5.51/drivers/net/e100/e100_main.c	2002-12-10 14:06:42.000000000 -0600
@@ -145,17 +145,17 @@
 static int e100_suspend(struct pci_dev *pcid, u32 state);
 static int e100_resume(struct pci_dev *pcid);
 struct notifier_block e100_notifier_reboot = {
-        notifier_call:  e100_notify_reboot,
-        next:           NULL,
-        priority:       0
+        .notifier_call  = e100_notify_reboot,
+        .next           = NULL,
+        .priority       = 0
 };
 #endif
 static int e100_notify_netdev(struct notifier_block *, unsigned long event, void *ptr);
  
 struct notifier_block e100_notifier_netdev = {
-	notifier_call:  e100_notify_netdev,
-	next:           NULL,
-	priority:       0
+	.notifier_call  = e100_notify_netdev,
+	.next           = NULL,
+	.priority       = 0
 };
 
 static void e100_get_mdix_status(struct e100_private *bdp);
--- linux-2.5.51/drivers/net/irda/irda-usb.c.old	2002-12-10 09:33:52.000000000 -0600
+++ linux-2.5.51/drivers/net/irda/irda-usb.c	2002-12-10 14:06:42.000000000 -0600
@@ -75,16 +75,16 @@
 /* These are the currently known IrDA USB dongles. Add new dongles here */
 static struct usb_device_id dongles[] = {
 	/* ACTiSYS Corp,  ACT-IR2000U FIR-USB Adapter */
-	{ USB_DEVICE(0x9c4, 0x011), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
+	{ USB_DEVICE(0x9c4, 0x011), .driver_info = IUC_SPEED_BUG | IUC_NO_WINDOW },
 	/* KC Technology Inc.,  KC-180 USB IrDA Device */
-	{ USB_DEVICE(0x50f, 0x180), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
+	{ USB_DEVICE(0x50f, 0x180), .driver_info = IUC_SPEED_BUG | IUC_NO_WINDOW },
 	/* Extended Systems, Inc.,  XTNDAccess IrDA USB (ESI-9685) */
-	{ USB_DEVICE(0x8e9, 0x100), driver_info: IUC_SPEED_BUG | IUC_NO_WINDOW },
-	{ match_flags: USB_DEVICE_ID_MATCH_INT_CLASS |
+	{ USB_DEVICE(0x8e9, 0x100), .driver_info = IUC_SPEED_BUG | IUC_NO_WINDOW },
+	{ .match_flags = USB_DEVICE_ID_MATCH_INT_CLASS |
 	               USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	  bInterfaceClass: USB_CLASS_APP_SPEC,
-	  bInterfaceSubClass: USB_CLASS_IRDA,
-	  driver_info: IUC_DEFAULT, },
+	  .bInterfaceClass = USB_CLASS_APP_SPEC,
+	  .bInterfaceSubClass = USB_CLASS_IRDA,
+	  .driver_info = IUC_DEFAULT, },
 	{ }, /* The end */
 };
 
--- linux-2.5.51/drivers/net/irda/vlsi_ir.c.old	2002-11-29 09:24:09.000000000 -0600
+++ linux-2.5.51/drivers/net/irda/vlsi_ir.c	2002-12-10 14:06:42.000000000 -0600
@@ -495,10 +495,10 @@
 }
 
 static struct file_operations vlsi_proc_fops = {
-	open:		vlsi_proc_open,
-	llseek:		vlsi_proc_lseek,
-	read:		vlsi_proc_read,
-	release:	vlsi_proc_release,
+	.open		= vlsi_proc_open,
+	.llseek		= vlsi_proc_lseek,
+	.read		= vlsi_proc_read,
+	.release	= vlsi_proc_release,
 };
 #endif
 
--- linux-2.5.51/drivers/net/irda/toshoboe.c.old	2002-09-28 10:35:04.000000000 -0500
+++ linux-2.5.51/drivers/net/irda/toshoboe.c	2002-12-10 14:06:42.000000000 -0600
@@ -938,12 +938,12 @@
 }
 
 static struct pci_driver toshoboe_pci_driver = {
-  name		: "toshoboe",
-  id_table	: toshoboe_pci_tbl,
-  probe		: toshoboe_probe,
-  remove	: toshoboe_remove,
-  suspend	: toshoboe_suspend,
-  resume	: toshoboe_resume 
+	.name		= "toshoboe",
+	.id_table	= toshoboe_pci_tbl,
+	.probe		= toshoboe_probe,
+	.remove		= toshoboe_remove,
+	.suspend	= toshoboe_suspend,
+	.resume		= toshoboe_resume 
 };
 
 int __init
--- linux-2.5.51/drivers/net/appletalk/cops.c.old	2002-12-10 09:33:51.000000000 -0600
+++ linux-2.5.51/drivers/net/appletalk/cops.c	2002-12-10 14:06:42.000000000 -0600
@@ -1012,7 +1012,7 @@
 }
 
 #ifdef MODULE
-static struct net_device cops0_dev = { init: cops_probe };
+static struct net_device cops0_dev = { .init = cops_probe };
 
 MODULE_LICENSE("GPL");
 MODULE_PARM(io, "i");
--- linux-2.5.51/drivers/net/fc/iph5526_scsi.h.old	2002-07-24 19:42:25.000000000 -0500
+++ linux-2.5.51/drivers/net/fc/iph5526_scsi.h	2002-12-10 14:06:42.000000000 -0600
@@ -3,21 +3,21 @@
 
 #define IPH5526_CAN_QUEUE	32
 #define IPH5526_SCSI_FC { 						 				\
-        name:                   "Interphase 5526 Fibre Channel SCSI Adapter",   \
-        detect:                 iph5526_detect,                  \
-        release:                iph5526_release,                 \
-        info:                   iph5526_info,                    \
-        queuecommand:           iph5526_queuecommand,            \
-		bios_param:				iph5526_biosparam,               \
-        can_queue:              IPH5526_CAN_QUEUE,               \
-        this_id:                -1,                              \
-        sg_tablesize:           255,                             \
-        cmd_per_lun:            8,                               \
-        use_clustering:         DISABLE_CLUSTERING,              \
-        eh_abort_handler:       iph5526_abort,                   \
-        eh_device_reset_handler:NULL,                            \
-        eh_bus_reset_handler:   NULL,                            \
-        eh_host_reset_handler:  NULL,                            \
+        .name                   = "Interphase 5526 Fibre Channel SCSI Adapter",   \
+        .detect                 = iph5526_detect,                  \
+        .release                = iph5526_release,                 \
+        .info                   = iph5526_info,                    \
+        .queuecommand           = iph5526_queuecommand,            \
+	.bios_param		= iph5526_biosparam,               \
+        .can_queue              = IPH5526_CAN_QUEUE,               \
+        .this_id                = -1,                              \
+        .sg_tablesize           = 255,                             \
+        .cmd_per_lun            = 8,                               \
+        .use_clustering         = DISABLE_CLUSTERING,              \
+        .eh_abort_handler       = iph5526_abort,                   \
+        .eh_device_reset_handler = NULL,                            \
+        .eh_bus_reset_handler   = NULL,                            \
+        .eh_host_reset_handler  = NULL,                            \
 }
 
 int iph5526_detect(Scsi_Host_Template *tmpt);
--- linux-2.5.51/drivers/net/e1000/e1000_param.c.old	2002-10-19 11:21:31.000000000 -0500
+++ linux-2.5.51/drivers/net/e1000/e1000_param.c	2002-12-10 14:06:42.000000000 -0600
@@ -310,7 +310,7 @@
 			.name = "Transmit Descriptors",
 			.err  = "using default of " __MODULE_STRING(DEFAULT_TXD),
 			.def  = DEFAULT_TXD,
-			.arg  = { r: { min: MIN_TXD }}
+			.arg  = { .r = { .min = MIN_TXD }}
 		};
 		struct e1000_desc_ring *tx_ring = &adapter->tx_ring;
 		e1000_mac_type mac_type = adapter->hw.mac_type;
@@ -327,7 +327,7 @@
 			.name = "Receive Descriptors",
 			.err  = "using default of " __MODULE_STRING(DEFAULT_RXD),
 			.def  = DEFAULT_RXD,
-			.arg  = { r: { min: MIN_RXD }}
+			.arg  = { .r = { .min = MIN_RXD }}
 		};
 		struct e1000_desc_ring *rx_ring = &adapter->rx_ring;
 		e1000_mac_type mac_type = adapter->hw.mac_type;
@@ -363,7 +363,7 @@
 			.name = "Flow Control",
 			.err  = "reading default settings from EEPROM",
 			.def  = e1000_fc_default,
-			.arg  = { l: { nr: ARRAY_SIZE(fc_list), p: fc_list }}
+			.arg  = { .l = { .nr = ARRAY_SIZE(fc_list), .p = fc_list }}
 		};
 
 		int fc = FlowControl[bd];
@@ -375,7 +375,7 @@
 		struct e1000_option opt = {
 			.type = range_option,
 			.name = "Transmit Interrupt Delay",
-			.arg  = { r: { min: MIN_TXDELAY, max: MAX_TXDELAY }}
+			.arg  = { .r = { .min = MIN_TXDELAY, .max = MAX_TXDELAY }}
 		};
 		opt.def = DEFAULT_TIDV;
 		opt.err = tidv;
@@ -388,7 +388,7 @@
 		struct e1000_option opt = {
 			.type = range_option,
 			.name = "Transmit Absolute Interrupt Delay",
-			.arg  = { r: { min: MIN_TXABSDELAY, max: MAX_TXABSDELAY }}
+			.arg  = { .r = { .min = MIN_TXABSDELAY, .max = MAX_TXABSDELAY }}
 		};
 		opt.def = DEFAULT_TADV;
 		opt.err = tadv;
@@ -401,7 +401,7 @@
 		struct e1000_option opt = {
 			.type = range_option,
 			.name = "Receive Interrupt Delay",
-			.arg  = { r: { min: MIN_RXDELAY, max: MAX_RXDELAY }}
+			.arg  = { .r = { .min = MIN_RXDELAY, .max = MAX_RXDELAY }}
 		};
 		opt.def = DEFAULT_RDTR;
 		opt.err = rdtr;
@@ -414,7 +414,7 @@
 		struct e1000_option opt = {
 			.type = range_option,
 			.name = "Receive Absolute Interrupt Delay",
-			.arg  = { r: { min: MIN_RXABSDELAY, max: MAX_RXABSDELAY }}
+			.arg  = { .r = { .min = MIN_RXABSDELAY, .max = MAX_RXABSDELAY }}
 		};
 		opt.def = DEFAULT_RADV;
 		opt.err = radv;
@@ -486,7 +486,7 @@
 			.name = "Speed",
 			.err  = "parameter ignored",
 			.def  = 0,
-			.arg  = { l: { nr: ARRAY_SIZE(speed_list), p: speed_list }}
+			.arg  = { .l = { .nr = ARRAY_SIZE(speed_list), .p = speed_list }}
 		};
 
 		speed = Speed[bd];
@@ -501,7 +501,7 @@
 			.name = "Duplex",
 			.err  = "parameter ignored",
 			.def  = 0,
-			.arg  = { l: { nr: ARRAY_SIZE(dplx_list), p: dplx_list }}
+			.arg  = { .l = { .nr = ARRAY_SIZE(dplx_list), .p = dplx_list }}
 		};
 
 		dplx = Duplex[bd];
@@ -553,7 +553,7 @@
 			.name = "AutoNeg",
 			.err  = "parameter ignored",
 			.def  = AUTONEG_ADV_DEFAULT,
-			.arg  = { l: { nr: ARRAY_SIZE(an_list), p: an_list }}
+			.arg  = { .l = { .nr = ARRAY_SIZE(an_list), .p = an_list }}
 		};
 
 		int an = AutoNeg[bd];
--- linux-2.5.51/drivers/net/wireless/orinoco_cs.c.old	2002-11-22 19:45:14.000000000 -0600
+++ linux-2.5.51/drivers/net/wireless/orinoco_cs.c	2002-12-10 14:06:42.000000000 -0600
@@ -369,7 +369,7 @@
 	CS_CHECK(GetFirstTuple, handle, &tuple);
 	while (1) {
 		cistpl_cftable_entry_t *cfg = &(parse.cftable_entry);
-		cistpl_cftable_entry_t dflt = { index: 0 };
+		cistpl_cftable_entry_t dflt = { .index = 0 };
 
 		CFG_CHECK(GetTupleData, handle, &tuple);
 		CFG_CHECK(ParseTuple, handle, &tuple, &parse);
--- linux-2.5.51/drivers/net/sungem.c.old	2002-12-10 09:33:54.000000000 -0600
+++ linux-2.5.51/drivers/net/sungem.c	2002-12-10 14:06:42.000000000 -0600
@@ -2557,7 +2557,7 @@
 		
 	switch(ecmd.cmd) {
         case ETHTOOL_GDRVINFO: {
-		struct ethtool_drvinfo info = { cmd: ETHTOOL_GDRVINFO };
+		struct ethtool_drvinfo info = { .cmd = ETHTOOL_GDRVINFO };
 
 		strncpy(info.driver, DRV_NAME, ETHTOOL_BUSINFO_LEN);
 		strncpy(info.version, DRV_VERSION, ETHTOOL_BUSINFO_LEN);
@@ -2652,7 +2652,7 @@
 
 	/* get link status */
 	case ETHTOOL_GLINK: {
-		struct ethtool_value edata = { cmd: ETHTOOL_GLINK };
+		struct ethtool_value edata = { .cmd = ETHTOOL_GLINK };
 
 		edata.data = (gp->lstate == link_up);
 		if (copy_to_user(ep_user, &edata, sizeof(edata)))
@@ -2662,7 +2662,7 @@
 
 	/* get message-level */
 	case ETHTOOL_GMSGLVL: {
-		struct ethtool_value edata = { cmd: ETHTOOL_GMSGLVL };
+		struct ethtool_value edata = { .cmd = ETHTOOL_GMSGLVL };
 
 		edata.data = gp->msg_enable;
 		if (copy_to_user(ep_user, &edata, sizeof(edata)))
--- linux-2.5.51/drivers/net/ni65.c.old	2002-12-10 09:33:52.000000000 -0600
+++ linux-2.5.51/drivers/net/ni65.c	2002-12-10 14:06:42.000000000 -0600
@@ -1210,7 +1210,7 @@
 }
 
 #ifdef MODULE
-static struct net_device dev_ni65 = { base_addr: 0x360, irq: 9, init: ni65_probe };
+static struct net_device dev_ni65 = { .base_addr = 0x360, .irq = 9, .init = ni65_probe };
 
 /* set: io,irq,dma or set it when calling insmod */
 static int irq;
--- linux-2.5.51/drivers/net/seeq8005.c.old	2002-11-22 19:45:09.000000000 -0600
+++ linux-2.5.51/drivers/net/seeq8005.c	2002-12-10 14:06:42.000000000 -0600
@@ -707,7 +707,7 @@
 	
 #ifdef MODULE
 
-static struct net_device dev_seeq = { init: seeq8005_probe };
+static struct net_device dev_seeq = { .init = seeq8005_probe };
 static int io = 0x320;
 static int irq = 10;
 MODULE_LICENSE("GPL");
--- linux-2.5.51/drivers/net/82596.c.old	2002-11-22 19:45:03.000000000 -0600
+++ linux-2.5.51/drivers/net/82596.c	2002-12-10 14:06:42.000000000 -0600
@@ -1525,7 +1525,7 @@
 }
 
 #ifdef MODULE
-static struct net_device dev_82596 = { init: i82596_probe };
+static struct net_device dev_82596 = { .init = i82596_probe };
 
 #ifdef ENABLE_APRICOT
 static int io = 0x300;
--- linux-2.5.51/drivers/net/sunhme.c.old	2002-12-10 09:33:54.000000000 -0600
+++ linux-2.5.51/drivers/net/sunhme.c	2002-12-10 14:06:42.000000000 -0600
@@ -181,10 +181,10 @@
 
 struct pci_device_id happymeal_pci_ids[] __initdata = {
 	{
-	  vendor: PCI_VENDOR_ID_SUN,
-	  device: PCI_DEVICE_ID_SUN_HAPPYMEAL,
-	  subvendor: PCI_ANY_ID,
-	  subdevice: PCI_ANY_ID,
+	  .vendor	= PCI_VENDOR_ID_SUN,
+	  .device	= PCI_DEVICE_ID_SUN_HAPPYMEAL,
+	  .subvendor	= PCI_ANY_ID,
+	  .subdevice	= PCI_ANY_ID,
 	},
 	{ }			/* Terminating entry */
 };
--- linux-2.5.51/drivers/net/pcnet32.c.old	2002-11-22 19:45:09.000000000 -0600
+++ linux-2.5.51/drivers/net/pcnet32.c	2002-12-10 14:06:42.000000000 -0600
@@ -392,13 +392,13 @@
 }
 
 static struct pcnet32_access pcnet32_wio = {
-    read_csr:	pcnet32_wio_read_csr,
-    write_csr:	pcnet32_wio_write_csr,
-    read_bcr:	pcnet32_wio_read_bcr,
-    write_bcr:	pcnet32_wio_write_bcr,
-    read_rap:	pcnet32_wio_read_rap,
-    write_rap:	pcnet32_wio_write_rap,
-    reset:	pcnet32_wio_reset
+    .read_csr	= pcnet32_wio_read_csr,
+    .write_csr	= pcnet32_wio_write_csr,
+    .read_bcr	= pcnet32_wio_read_bcr,
+    .write_bcr	= pcnet32_wio_write_bcr,
+    .read_rap	= pcnet32_wio_read_rap,
+    .write_rap	= pcnet32_wio_write_rap,
+    .reset	= pcnet32_wio_reset
 };
 
 static u16 pcnet32_dwio_read_csr (unsigned long addr, int index)
@@ -447,13 +447,13 @@
 }
 
 static struct pcnet32_access pcnet32_dwio = {
-    read_csr:	pcnet32_dwio_read_csr,
-    write_csr:	pcnet32_dwio_write_csr,
-    read_bcr:	pcnet32_dwio_read_bcr,
-    write_bcr:	pcnet32_dwio_write_bcr,
-    read_rap:	pcnet32_dwio_read_rap,
-    write_rap:	pcnet32_dwio_write_rap,
-    reset:	pcnet32_dwio_reset
+    .read_csr	= pcnet32_dwio_read_csr,
+    .write_csr	= pcnet32_dwio_write_csr,
+    .read_bcr	= pcnet32_dwio_read_bcr,
+    .write_bcr	= pcnet32_dwio_write_bcr,
+    .read_rap	= pcnet32_dwio_read_rap,
+    .write_rap	= pcnet32_dwio_write_rap,
+    .reset	= pcnet32_dwio_reset
 };
 
 
@@ -1682,9 +1682,9 @@
 }
 
 static struct pci_driver pcnet32_driver = {
-    name:	DRV_NAME,
-    probe:	pcnet32_probe_pci,
-    id_table:	pcnet32_pci_tbl,
+    .name	= DRV_NAME,
+    .probe	= pcnet32_probe_pci,
+    .id_table	= pcnet32_pci_tbl,
 };
 
 MODULE_PARM(debug, "i");
--- linux-2.5.51/drivers/net/sundance.c.old	2002-11-11 07:14:41.000000000 -0600
+++ linux-2.5.51/drivers/net/sundance.c	2002-12-10 14:06:42.000000000 -0600
@@ -1753,10 +1753,10 @@
 }
 
 static struct pci_driver sundance_driver = {
-	name:		DRV_NAME,
-	id_table:	sundance_pci_tbl,
-	probe:		sundance_probe1,
-	remove:		__devexit_p(sundance_remove1),
+	.name		= DRV_NAME,
+	.id_table	= sundance_pci_tbl,
+	.probe		= sundance_probe1,
+	.remove		= __devexit_p(sundance_remove1),
 };
 
 static int __init sundance_init(void)
--- linux-2.5.51/drivers/net/rrunner.c.old	2002-11-18 01:02:01.000000000 -0600
+++ linux-2.5.51/drivers/net/rrunner.c	2002-12-10 14:06:42.000000000 -0600
@@ -1761,10 +1761,10 @@
 MODULE_DEVICE_TABLE(pci, rr_pci_tbl);
 
 static struct pci_driver rr_driver = {
-	name:		"rrunner",
-	id_table:	rr_pci_tbl,
-	probe:		rr_init_one,
-	remove:		rr_remove_one,
+	.name		= "rrunner",
+	.id_table	= rr_pci_tbl,
+	.probe		= rr_init_one,
+	.remove		= rr_remove_one,
 };
 
 static int __init rr_init_module(void)
--- linux-2.5.51/drivers/net/lasi_82596.c.old	2002-11-22 19:45:07.000000000 -0600
+++ linux-2.5.51/drivers/net/lasi_82596.c	2002-12-10 14:06:42.000000000 -0600
@@ -1565,9 +1565,9 @@
 MODULE_DEVICE_TABLE(parisc, lan_tbl);
 
 static struct parisc_driver lan_driver = {
-	name:		"Apricot",
-	id_table:	lan_tbl,
-	probe:		lan_init_chip,
+	.name		= "Apricot",
+	.id_table	= lan_tbl,
+	.probe		= lan_init_chip,
 };
 
 static int __devinit lasi_82596_init(void)
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
