Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUGTSsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUGTSsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUGTSsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:48:21 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:26422 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S266173AbUGTSow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:44:52 -0400
Date: Tue, 20 Jul 2004 20:39:46 +0200
Message-Id: <200407201839.i6KIdk9t015525@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       kkeil@suse.de, kai.germaschewski@gmx.de
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] !PCI warnings: Hisax ISDN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill warnings in Hisax ISDN drivers when !PCI.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/isdn/hisax/avm_pci.c	2004-02-29 09:31:42.000000000 +0100
+++ linux-m68k-2.6.8-rc2/drivers/isdn/hisax/avm_pci.c	2004-07-19 18:22:57.000000000 +0200
@@ -729,7 +729,9 @@
 	return(0);
 }
 
+#ifdef CONFIG_PCI
 static struct pci_dev *dev_avm __initdata = NULL;
+#endif
 #ifdef __ISAPNP__
 static struct pnp_card *pnp_avm_c __initdata = NULL;
 #endif
@@ -788,7 +790,7 @@
 			printk(KERN_INFO "FritzPnP: no ISA PnP present\n");
 		}
 #endif
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 		if ((dev_avm = pci_find_device(PCI_VENDOR_ID_AVM,
 			PCI_DEVICE_ID_AVM_A1,  dev_avm))) {
 			cs->irq = dev_avm->irq;
--- linux-2.6.8-rc2/drivers/isdn/hisax/config.c	2004-07-18 15:55:15.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/isdn/hisax/config.c	2004-07-19 23:13:25.000000000 +0200
@@ -1878,6 +1878,7 @@
 	}
 }
 
+#ifdef CONFIG_PCI
 #include <linux/pci.h>
 
 static struct pci_device_id hisax_pci_tbl[] __initdata = {
@@ -1946,6 +1947,7 @@
 };
 
 MODULE_DEVICE_TABLE(pci, hisax_pci_tbl);
+#endif /* CONFIG_PCI */
 
 module_init(HiSax_init);
 module_exit(HiSax_exit);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
