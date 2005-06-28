Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVF1FlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVF1FlR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVF1Fjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:39:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:7660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261606AbVF1Fdd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:33 -0400
Cc: akpm@osdl.org
Subject: [PATCH] PCI: fix up errors after dma bursting patch and CONFIG_PCI=n
In-Reply-To: <11199367752569@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:55 -0700
Message-Id: <11199367753992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: fix up errors after dma bursting patch and CONFIG_PCI=n

With CONFIG_PCI=n:

In file included from include/linux/pci.h:917,
                 from lib/iomap.c:6:
include/asm/pci.h:104: warning: `enum pci_dma_burst_strategy' declared inside parameter list
include/asm/pci.h:104: warning: its scope is only this definition or declaration, which is probably not what you want.
include/asm/pci.h: In function `pci_dma_burst_advice':
include/asm/pci.h:106: dereferencing pointer to incomplete type
include/asm/pci.h:106: `PCI_DMA_BURST_INFINITY' undeclared (first use in this function)
include/asm/pci.h:106: (Each undeclared identifier is reported only once
include/asm/pci.h:106: for each function it appears in.)
make[1]: *** [lib/iomap.o] Error 1

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit bb4a61b6eaee01707f24deeefc5d7136f25f75c5
tree 8d353d7b04addad950de8ae24eda7cdfe6fbea85
parent e24c2d963a604d9eaa560c90371fa387d3eec8f1
author Andrew Morton <akpm@osdl.org> Mon, 06 Jun 2005 23:07:46 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:46 -0700

 include/asm-alpha/pci.h   |    2 ++
 include/asm-arm/pci.h     |    2 ++
 include/asm-frv/pci.h     |    2 ++
 include/asm-i386/pci.h    |    2 ++
 include/asm-ia64/pci.h    |    2 ++
 include/asm-mips/pci.h    |    2 ++
 include/asm-parisc/pci.h  |    2 ++
 include/asm-ppc/pci.h     |    2 ++
 include/asm-ppc64/pci.h   |    2 ++
 include/asm-sh/pci.h      |    2 ++
 include/asm-sh64/pci.h    |    2 ++
 include/asm-sparc/pci.h   |    2 ++
 include/asm-sparc64/pci.h |    2 ++
 include/asm-v850/pci.h    |    2 ++
 include/asm-x86_64/pci.h  |    2 ++
 include/linux/pci.h       |    2 ++
 16 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/include/asm-alpha/pci.h b/include/asm-alpha/pci.h
--- a/include/asm-alpha/pci.h
+++ b/include/asm-alpha/pci.h
@@ -223,6 +223,7 @@ pci_dac_dma_sync_single_for_device(struc
 	/* Nothing to do. */
 }
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -239,6 +240,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_BOUNDARY;
 	*strategy_parameter = cacheline_size;
 }
+#endif
 
 /* TODO: integrate with include/asm-generic/pci.h ? */
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
diff --git a/include/asm-arm/pci.h b/include/asm-arm/pci.h
--- a/include/asm-arm/pci.h
+++ b/include/asm-arm/pci.h
@@ -42,6 +42,7 @@ static inline void pcibios_penalize_isa_
 #define pci_unmap_len(PTR, LEN_NAME)		((PTR)->LEN_NAME)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	(((PTR)->LEN_NAME) = (VAL))
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -49,6 +50,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
diff --git a/include/asm-frv/pci.h b/include/asm-frv/pci.h
--- a/include/asm-frv/pci.h
+++ b/include/asm-frv/pci.h
@@ -57,6 +57,7 @@ extern void pci_free_consistent(struct p
  */
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -64,6 +65,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 /*
  *	These are pretty much arbitary with the CoMEM implementation.
diff --git a/include/asm-i386/pci.h b/include/asm-i386/pci.h
--- a/include/asm-i386/pci.h
+++ b/include/asm-i386/pci.h
@@ -99,6 +99,7 @@ static inline void pcibios_add_platform_
 {
 }
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -106,6 +107,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 #endif /* __KERNEL__ */
 
diff --git a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h
+++ b/include/asm-ia64/pci.h
@@ -82,6 +82,7 @@ extern int pcibios_prep_mwi (struct pci_
 #define sg_dma_len(sg)		((sg)->dma_length)
 #define sg_dma_address(sg)	((sg)->dma_address)
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -98,6 +99,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_MULTIPLE;
 	*strategy_parameter = cacheline_size;
 }
+#endif
 
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
diff --git a/include/asm-mips/pci.h b/include/asm-mips/pci.h
--- a/include/asm-mips/pci.h
+++ b/include/asm-mips/pci.h
@@ -130,6 +130,7 @@ extern void pci_dac_dma_sync_single_for_
 extern void pci_dac_dma_sync_single_for_device(struct pci_dev *pdev,
 	dma64_addr_t dma_addr, size_t len, int direction);
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -137,6 +138,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 extern void pcibios_resource_to_bus(struct pci_dev *dev,
 	struct pci_bus_region *region, struct resource *res);
diff --git a/include/asm-parisc/pci.h b/include/asm-parisc/pci.h
--- a/include/asm-parisc/pci.h
+++ b/include/asm-parisc/pci.h
@@ -230,6 +230,7 @@ extern inline void pcibios_register_hba(
 /* export the pci_ DMA API in terms of the dma_ one */
 #include <asm-generic/pci-dma-compat.h>
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -246,6 +247,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_MULTIPLE;
 	*strategy_parameter = cacheline_size;
 }
+#endif
 
 extern void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
diff --git a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
--- a/include/asm-ppc/pci.h
+++ b/include/asm-ppc/pci.h
@@ -69,6 +69,7 @@ extern unsigned long pci_bus_to_phys(uns
 #define pci_unmap_len(PTR, LEN_NAME)		(0)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -76,6 +77,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 /*
  * At present there are very few 32-bit PPC machines that can have
diff --git a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h
+++ b/include/asm-ppc64/pci.h
@@ -78,6 +78,7 @@ static inline int pci_dac_dma_supported(
 	return 0;
 }
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -94,6 +95,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_MULTIPLE;
 	*strategy_parameter = cacheline_size;
 }
+#endif
 
 extern int pci_domain_nr(struct pci_bus *bus);
 
diff --git a/include/asm-sh/pci.h b/include/asm-sh/pci.h
--- a/include/asm-sh/pci.h
+++ b/include/asm-sh/pci.h
@@ -96,6 +96,7 @@ static inline void pcibios_penalize_isa_
 #define sg_dma_address(sg)	(virt_to_bus((sg)->dma_address))
 #define sg_dma_len(sg)		((sg)->length)
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -103,6 +104,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 /* Board-specific fixup routines. */
 extern void pcibios_fixup(void);
diff --git a/include/asm-sh64/pci.h b/include/asm-sh64/pci.h
--- a/include/asm-sh64/pci.h
+++ b/include/asm-sh64/pci.h
@@ -86,6 +86,7 @@ static inline void pcibios_penalize_isa_
 #define sg_dma_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -93,6 +94,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 /* Board-specific fixup routines. */
 extern void pcibios_fixup(void);
diff --git a/include/asm-sparc/pci.h b/include/asm-sparc/pci.h
--- a/include/asm-sparc/pci.h
+++ b/include/asm-sparc/pci.h
@@ -144,6 +144,7 @@ extern inline int pci_dma_supported(stru
 
 #define pci_dac_dma_supported(dev, mask)	(0)
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -151,6 +152,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
diff --git a/include/asm-sparc64/pci.h b/include/asm-sparc64/pci.h
--- a/include/asm-sparc64/pci.h
+++ b/include/asm-sparc64/pci.h
@@ -220,6 +220,7 @@ static inline int pci_dma_mapping_error(
 	return (dma_addr == PCI_DMA_ERROR_CODE);
 }
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -236,6 +237,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_BOUNDARY;
 	*strategy_parameter = cacheline_size;
 }
+#endif
 
 /* Return the index of the PCI controller for device PDEV. */
 
diff --git a/include/asm-v850/pci.h b/include/asm-v850/pci.h
--- a/include/asm-v850/pci.h
+++ b/include/asm-v850/pci.h
@@ -81,6 +81,7 @@ extern void
 pci_free_consistent (struct pci_dev *pdev, size_t size, void *cpu_addr,
 		     dma_addr_t dma_addr);
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -88,6 +89,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
 {
diff --git a/include/asm-x86_64/pci.h b/include/asm-x86_64/pci.h
--- a/include/asm-x86_64/pci.h
+++ b/include/asm-x86_64/pci.h
@@ -123,6 +123,7 @@ pci_dac_dma_sync_single_for_device(struc
 	flush_write_buffers();
 }
 
+#ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
 					unsigned long *strategy_parameter)
@@ -130,6 +131,7 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+#endif
 
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -985,6 +985,8 @@ static inline int pci_proc_domain(struct
 }
 #endif
 
+#define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)
+
 #endif /* !CONFIG_PCI */
 
 /* these helpers provide future and backwards compatibility

