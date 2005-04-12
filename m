Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVDMCLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVDMCLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVDLTub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:50:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:61384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262170AbVDLKcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:01 -0400
Message-Id: <200504121031.j3CAVoC3005419@shell0.pdx.osdl.net>
Subject: [patch 073/198] x86_64: Make IRDA devices are not really ISA devices not depend on CONFIG_ISA
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

This allows to use them on x86-64

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/net/irda/Kconfig       |   10 +++++-----
 25-akpm/include/net/irda/irda_device.h |    2 --
 25-akpm/net/irda/irda_device.c         |    4 +---
 3 files changed, 6 insertions(+), 10 deletions(-)

diff -puN drivers/net/irda/Kconfig~x86_64-make-irda-devices-are-not-really-isa-devices-not drivers/net/irda/Kconfig
--- 25/drivers/net/irda/Kconfig~x86_64-make-irda-devices-are-not-really-isa-devices-not	2005-04-12 03:21:20.901959320 -0700
+++ 25-akpm/drivers/net/irda/Kconfig	2005-04-12 03:21:20.907958408 -0700
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
diff -puN include/net/irda/irda_device.h~x86_64-make-irda-devices-are-not-really-isa-devices-not include/net/irda/irda_device.h
--- 25/include/net/irda/irda_device.h~x86_64-make-irda-devices-are-not-really-isa-devices-not	2005-04-12 03:21:20.902959168 -0700
+++ 25-akpm/include/net/irda/irda_device.h	2005-04-12 03:21:20.907958408 -0700
@@ -235,9 +235,7 @@ int  irda_device_register_dongle(struct 
 dongle_t *irda_device_dongle_init(struct net_device *dev, int type);
 int irda_device_dongle_cleanup(dongle_t *dongle);
 
-#ifdef CONFIG_ISA
 void irda_setup_dma(int channel, dma_addr_t buffer, int count, int mode);
-#endif
 
 void irda_task_delete(struct irda_task *task);
 struct irda_task *irda_task_execute(void *instance, 
diff -puN net/irda/irda_device.c~x86_64-make-irda-devices-are-not-really-isa-devices-not net/irda/irda_device.c
--- 25/net/irda/irda_device.c~x86_64-make-irda-devices-are-not-really-isa-devices-not	2005-04-12 03:21:20.903959016 -0700
+++ 25-akpm/net/irda/irda_device.c	2005-04-12 03:21:20.908958256 -0700
@@ -470,11 +470,10 @@ void irda_device_unregister_dongle(struc
 }
 EXPORT_SYMBOL(irda_device_unregister_dongle);
 
-#ifdef CONFIG_ISA
 /*
  * Function setup_dma (idev, buffer, count, mode)
  *
- *    Setup the DMA channel. Commonly used by ISA FIR drivers
+ *    Setup the DMA channel. Commonly used by LPC FIR drivers
  *
  */
 void irda_setup_dma(int channel, dma_addr_t buffer, int count, int mode)
@@ -493,4 +492,3 @@ void irda_setup_dma(int channel, dma_add
 	release_dma_lock(flags);
 }
 EXPORT_SYMBOL(irda_setup_dma);
-#endif
_
