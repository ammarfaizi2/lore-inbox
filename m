Return-Path: <linux-kernel-owner+w=401wt.eu-S932187AbXAFUsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbXAFUsj (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbXAFUsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:48:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4204 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932187AbXAFUsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:48:38 -0500
Date: Sat, 6 Jan 2007 21:48:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de, rth@twiddle.net
Cc: ink@jurassic.park.msu.ru, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] make isa_bridge Alpha-only
Message-ID: <20070106204841.GX20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since isa_bridge is neither assigned any value !NULL nor used on !Alpha, 
there's no reason for providing it.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/alpha/kernel/pci.c |    4 ++++
 drivers/pci/pci.c       |    6 ------
 include/asm-alpha/pci.h |    2 ++
 include/linux/pci.h     |    6 ------
 4 files changed, 6 insertions(+), 12 deletions(-)

--- linux-2.6.20-rc3-mm1/include/linux/pci.h.old	2007-01-06 18:07:12.000000000 +0100
+++ linux-2.6.20-rc3-mm1/include/linux/pci.h	2007-01-06 18:11:45.000000000 +0100
@@ -620,10 +620,6 @@
 				   strategy_parameter byte boundaries */
 };
 
-#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
-extern struct pci_dev *isa_bridge;
-#endif
-
 struct msix_entry {
 	u16 	vector;	/* kernel uses to write allocated vector */
 	u16	entry;	/* driver uses to specify entry, OS writes */
@@ -731,8 +727,6 @@
 static inline pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state) { return PCI_D0; }
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable) { return 0; }
 
-#define	isa_bridge	((struct pci_dev *)NULL)
-
 #define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)
 
 static inline void pci_block_user_cfg_access(struct pci_dev *dev) { }
--- linux-2.6.20-rc3-mm1/include/asm-alpha/pci.h.old	2007-01-06 18:07:42.000000000 +0100
+++ linux-2.6.20-rc3-mm1/include/asm-alpha/pci.h	2007-01-06 18:14:33.000000000 +0100
@@ -293,4 +293,6 @@
 #define IOBASE_ROOT_BUS		5
 #define IOBASE_FROM_HOSE	0x10000
 
+extern struct pci_dev *isa_bridge;
+
 #endif /* __ALPHA_PCI_H */
--- linux-2.6.20-rc3-mm1/drivers/pci/pci.c.old	2007-01-06 18:12:48.000000000 +0100
+++ linux-2.6.20-rc3-mm1/drivers/pci/pci.c	2007-01-06 18:13:17.000000000 +0100
@@ -1223,12 +1223,6 @@
 
 device_initcall(pci_init);
 
-#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
-/* FIXME: Some boxes have multiple ISA bridges! */
-struct pci_dev *isa_bridge;
-EXPORT_SYMBOL(isa_bridge);
-#endif
-
 EXPORT_SYMBOL_GPL(pci_restore_bars);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
--- linux-2.6.20-rc3-mm1/arch/alpha/kernel/pci.c.old	2007-01-06 18:12:15.000000000 +0100
+++ linux-2.6.20-rc3-mm1/arch/alpha/kernel/pci.c	2007-01-06 18:14:03.000000000 +0100
@@ -575,3 +575,7 @@
 
 EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
+
+/* FIXME: Some boxes have multiple ISA bridges! */
+struct pci_dev *isa_bridge;
+EXPORT_SYMBOL(isa_bridge);

