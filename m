Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVAPISq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVAPISq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 03:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVAPIQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 03:16:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7184 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262457AbVAPIPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 03:15:10 -0500
Date: Sun, 16 Jan 2005 09:15:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christer Weinigel <christer@weinigel.se>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 scx200.c: misc cleanups
Message-ID: <20050116081507.GK4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following cleanups:
- make some needlessly global code static
- #if 0 the following unused global functions:
  - scx200_gpio_dump
- remove the following unneeded EXPORT_SYMBOL's:
  - scx200_gpio_lock
  - scx200_gpio_dump


diffstat output:
 arch/i386/kernel/scx200.c   |    9 ++++-----
 include/linux/scx200_gpio.h |    2 --
 2 files changed, 4 insertions(+), 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/include/linux/scx200_gpio.h.old	2005-01-16 04:45:06.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/linux/scx200_gpio.h	2005-01-16 04:45:20.000000000 +0100
@@ -1,10 +1,8 @@
 #include <linux/spinlock.h>
 
 u32 scx200_gpio_configure(int index, u32 set, u32 clear);
-void scx200_gpio_dump(unsigned index);
 
 extern unsigned scx200_gpio_base;
-extern spinlock_t scx200_gpio_lock;
 extern long scx200_gpio_shadow[2];
 
 #define scx200_gpio_present() (scx200_gpio_base!=0)
--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/scx200.c.old	2005-01-16 04:44:09.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/scx200.c	2005-01-16 04:45:28.000000000 +0100
@@ -37,7 +37,6 @@
 	.probe = scx200_probe,
 };
 
-DEFINE_SPINLOCK(scx200_gpio_lock);
 static DEFINE_SPINLOCK(scx200_gpio_config_lock);
 
 static int __devinit scx200_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -81,6 +80,7 @@
 	return config;
 }
 
+#if 0
 void scx200_gpio_dump(unsigned index)
 {
 	u32 config = scx200_gpio_configure(index, ~0, 0);
@@ -112,15 +112,16 @@
 		printk(" DEBOUNCE"); /* debounce */
 	printk("\n");
 }
+#endif  /*  0  */
 
-int __init scx200_init(void)
+static int __init scx200_init(void)
 {
 	printk(KERN_INFO NAME ": NatSemi SCx200 Driver\n");
 
 	return pci_module_init(&scx200_pci_driver);
 }
 
-void __exit scx200_cleanup(void)
+static void __exit scx200_cleanup(void)
 {
 	pci_unregister_driver(&scx200_pci_driver);
 	release_region(scx200_gpio_base, SCx200_GPIO_SIZE);
@@ -131,9 +132,7 @@
 
 EXPORT_SYMBOL(scx200_gpio_base);
 EXPORT_SYMBOL(scx200_gpio_shadow);
-EXPORT_SYMBOL(scx200_gpio_lock);
 EXPORT_SYMBOL(scx200_gpio_configure);
-EXPORT_SYMBOL(scx200_gpio_dump);
 
 /*
     Local variables:

