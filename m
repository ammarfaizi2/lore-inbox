Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261246AbVCEXop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVCEXop (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVCEXnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:43:02 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:42220 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261242AbVCEXhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:37:45 -0500
Date: Sat, 05 Mar 2005 17:37:44 -0600 (CST)
Date-warning: Date header was inserted by vms042.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 6/13] pxa27x-ohci: Clean up printk()'s in
 drivers/usb/host/ohci-pxa27x.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233744.7648.92629.50033@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add KERN_ constants to printk()s missing them, and add driver prefixes in
drivers/usb/host/ohci-pxa27x.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/host/ohci-pxa27x.c linux-2.6.11-mm1/drivers/usb/host/ohci-pxa27x.c
--- linux-2.6.11-mm1-original/drivers/usb/host/ohci-pxa27x.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/host/ohci-pxa27x.c	2005-03-05 15:30:00.000000000 -0500
@@ -24,6 +24,7 @@
 #include <asm/hardware.h>
 #include <asm/arch/pxa-regs.h>
 
+#define PFX "pxa27x-ohci: "
 
 #define PMM_NPS_MODE           1
 #define PMM_GLOBAL_MODE        2
@@ -64,8 +65,8 @@ static int pxa27x_ohci_select_pmm( int m
 		UHCRHDB |= (0x7<<17);
 		break;
 	default:
-		printk( KERN_ERR
-			"Invalid mode %d, set to non-power switch mode.\n", 
+		printk( KERN_ERR PFX
+			"invalid mode %d, set to non-power switch mode\n", 
 			mode );
 
 		pxa27x_ohci_pmm_state = PMM_NPS_MODE;
@@ -172,7 +173,7 @@ int usb_hcd_pxa27x_probe (const struct h
 	struct usb_hcd *hcd;
 
 	if (dev->resource[1].flags != IORESOURCE_IRQ) {
-		pr_debug ("resource[1] is not IORESOURCE_IRQ");
+		pr_debug (PFX "resource[1] is not IORESOURCE_IRQ\n");
 		return -ENOMEM;
 	}
 
@@ -183,14 +184,14 @@ int usb_hcd_pxa27x_probe (const struct h
 	hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
 
 	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
-		pr_debug("request_mem_region failed");
+		pr_debug(PFX "request_mem_region failed\n");
 		retval = -EBUSY;
 		goto err1;
 	}
 
 	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
 	if (!hcd->regs) {
-		pr_debug("ioremap failed");
+		pr_debug(PFX "ioremap failed\n");
 		retval = -ENOMEM;
 		goto err2;
 	}
@@ -202,13 +203,13 @@ int usb_hcd_pxa27x_probe (const struct h
 
 	/* If choosing PMM_PERPORT_MODE, we should set the port power before we use it. */
 	if (pxa27x_ohci_set_port_power(1) < 0)
-		printk(KERN_ERR "Setting port 1 power failed.\n");
+		printk(KERN_ERR PFX "setting port 1 power failed\n");
 
 	if (pxa27x_ohci_clear_port_power(2) < 0)
-		printk(KERN_ERR "Setting port 2 power failed.\n");
+		printk(KERN_ERR PFX "setting port 2 power failed\n");
 
 	if (pxa27x_ohci_clear_port_power(3) < 0)
-		printk(KERN_ERR "Setting port 3 power failed.\n");
+		printk(KERN_ERR PFX"etting port 3 power failed\n");
 
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
@@ -319,7 +320,7 @@ static int ohci_hcd_pxa27x_drv_probe(str
 	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 
-	pr_debug ("In ohci_hcd_pxa27x_drv_probe");
+	pr_debug (PFX "%s(): start\n", __FUNCTION__);
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -341,7 +342,7 @@ static int ohci_hcd_pxa27x_drv_suspend(s
 {
 //	struct platform_device *pdev = to_platform_device(dev);
 //	struct usb_hcd *hcd = dev_get_drvdata(dev);
-	printk("%s: not implemented yet\n", __FUNCTION__);
+	printk(KERN_ERR "%s: not implemented yet\n", __FUNCTION__);
 
 	return 0;
 }
@@ -350,7 +351,7 @@ static int ohci_hcd_pxa27x_drv_resume(st
 {
 //	struct platform_device *pdev = to_platform_device(dev);
 //	struct usb_hcd *hcd = dev_get_drvdata(dev);
-	printk("%s: not implemented yet\n", __FUNCTION__);
+	printk(KERN_ERR "%s: not implemented yet\n", __FUNCTION__);
 
 	return 0;
 }
@@ -368,7 +369,7 @@ static struct device_driver ohci_hcd_pxa
 static int __init ohci_hcd_pxa27x_init (void)
 {
 	pr_debug (DRIVER_INFO " (pxa27x)");
-	pr_debug ("block sizes: ed %d td %d\n",
+	pr_debug (PFX "block sizes: ed %d td %d\n",
 		sizeof (struct ed), sizeof (struct td));
 
 	return driver_register(&ohci_hcd_pxa27x_driver);
