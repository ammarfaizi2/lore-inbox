Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263310AbUJ2NJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUJ2NJC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263313AbUJ2NJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:09:01 -0400
Received: from cantor.suse.de ([195.135.220.2]:59292 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263310AbUJ2NIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:08:47 -0400
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Drop IRDA ISA dependency
Message-Id: <20041029130846.3D6639DF0EA9@verdi.suse.de>
Date: Fri, 29 Oct 2004 15:08:46 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make IRDA devices are not really ISA devices not depend on CONFIG_ISA.
This allows to use them on x86-64

Signed-off-by: Andi Kleen <ak@suse.de>

diff -urpN -X ../KDIFX linux/drivers/net/irda/Kconfig linux-2.6.8-amd64/drivers/net/irda/Kconfig
--- linux/drivers/net/irda/Kconfig	2004-08-15 19:45:26.000000000 +0200
+++ linux-2.6.8-amd64/drivers/net/irda/Kconfig	2004-08-05 04:23:51.000000000 +0200
@@ -310,7 +310,7 @@ config SIGMATEL_FIR
 
 config NSC_FIR
 	tristate "NSC PC87108/PC87338"
-	depends on IRDA && ISA
+	depends on IRDA
 	help
 	  Say Y here if you want to build support for the NSC PC87108 and
 	  PC87338 IrDA chipsets.  This driver supports SIR,
@@ -321,7 +321,7 @@ config NSC_FIR
 
 config WINBOND_FIR
 	tristate "Winbond W83977AF (IR)"
-	depends on IRDA && ISA
+	depends on IRDA
 	help
 	  Say Y here if you want to build IrDA support for the Winbond
 	  W83977AF super-io chipset.  This driver should be used for the IrDA
@@ -347,7 +347,7 @@ config AU1000_FIR
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && IRDA && ISA
+	depends on EXPERIMENTAL && IRDA
 	help
 	  Say Y here if you want to build support for the SMC Infrared
 	  Communications Controller.  It is used in a wide variety of
@@ -357,7 +357,7 @@ config SMC_IRCC_FIR
 
 config ALI_FIR
 	tristate "ALi M5123 FIR (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && IRDA && ISA
+	depends on EXPERIMENTAL && IRDA
 	help
 	  Say Y here if you want to build support for the ALi M5123 FIR
 	  Controller.  The ALi M5123 FIR Controller is embedded in ALi M1543C,
@@ -385,7 +385,7 @@ config SA1100_FIR
 
 config VIA_FIR
 	tristate "VIA VT8231/VT1211 SIR/MIR/FIR"
-	depends on IRDA && ISA && PCI
+	depends on IRDA
 	help
 	  Say Y here if you want to build support for the VIA VT8231
 	  and VIA VT1211 IrDA controllers, found on the motherboards using
diff -urpN -X ../KDIFX linux/include/net/irda/irda_device.h linux-2.6.8-amd64/include/net/irda/irda_device.h
--- linux/include/net/irda/irda_device.h	2004-08-15 19:45:52.000000000 +0200
+++ linux-2.6.8-amd64/include/net/irda/irda_device.h	2004-07-27 15:11:57.000000000 +0200
@@ -237,9 +237,7 @@ int  irda_device_register_dongle(struct 
 dongle_t *irda_device_dongle_init(struct net_device *dev, int type);
 int irda_device_dongle_cleanup(dongle_t *dongle);
 
-#ifdef CONFIG_ISA
 void irda_setup_dma(int channel, dma_addr_t buffer, int count, int mode);
-#endif
 
 void irda_task_delete(struct irda_task *task);
 struct irda_task *irda_task_execute(void *instance, 
diff -urpN -X ../KDIFX linux/net/irda/irda_device.c linux-2.6.8-amd64/net/irda/irda_device.c
--- linux/net/irda/irda_device.c	2004-08-15 19:45:58.000000000 +0200
+++ linux-2.6.8-amd64/net/irda/irda_device.c	2004-07-27 15:11:57.000000000 +0200
@@ -529,11 +529,10 @@ int irda_device_set_mode(struct net_devi
 	return ret;
 }
 
-#ifdef CONFIG_ISA
 /*
  * Function setup_dma (idev, buffer, count, mode)
  *
- *    Setup the DMA channel. Commonly used by ISA FIR drivers
+ *    Setup the DMA channel. Commonly used by LPC FIR drivers
  *
  */
 void irda_setup_dma(int channel, dma_addr_t buffer, int count, int mode)
@@ -552,4 +551,3 @@ void irda_setup_dma(int channel, dma_add
 	release_dma_lock(flags);
 }
 EXPORT_SYMBOL(irda_setup_dma);
-#endif
