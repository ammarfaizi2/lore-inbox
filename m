Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbUBJGYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 01:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbUBJGYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 01:24:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:15248 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265652AbUBJGYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 01:24:41 -0500
Subject: Re: [PATCH] Export OF device path for PCI devices take 2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1076390374.894.22.camel@gaston>
References: <1076390374.894.22.camel@gaston>
Content-Type: text/plain
Message-Id: <1076394225.894.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 17:23:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-10 at 16:19, Benjamin Herrenschmidt wrote:
> Hi !
> 
> Here's a new version of the patch according to our discussion.

Argh.. flu is no good with me... Here's one without a typo
preventing build on ppc ;)

diff -urN linux-2.5/drivers/pci/pci-sysfs.c linuxppc-2.5-benh/drivers/pci/pci-sysfs.c
--- linux-2.5/drivers/pci/pci-sysfs.c	2004-02-02 13:09:08.000000000 +1100
+++ linuxppc-2.5-benh/drivers/pci/pci-sysfs.c	2004-02-10 15:55:42.407476200 +1100
@@ -180,4 +180,7 @@
 	device_create_file (dev, &dev_attr_irq);
 	device_create_file (dev, &dev_attr_resource);
 	sysfs_create_bin_file(&dev->kobj, &pci_config_attr);
+
+	/* add platform-specific attributes */
+	pcibios_add_platform_entries(pdev);
 }
diff -urN linux-2.5/include/asm-alpha/pci.h linuxppc-2.5-benh/include/asm-alpha/pci.h
--- linux-2.5/include/asm-alpha/pci.h	2004-02-05 13:35:05.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-alpha/pci.h	2004-02-10 15:58:44.076858256 +1100
@@ -208,6 +208,10 @@
 	return 0;
 }
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __KERNEL__ */
 
 /* Values for the `which' argument to sys_pciconfig_iobase.  */
diff -urN linux-2.5/include/asm-arm/pci.h linuxppc-2.5-benh/include/asm-arm/pci.h
--- linux-2.5/include/asm-arm/pci.h	2004-02-09 10:20:17.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-arm/pci.h	2004-02-10 15:59:20.529316640 +1100
@@ -186,6 +186,10 @@
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			 struct resource *res);
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __KERNEL__ */
  
 #endif
diff -urN linux-2.5/include/asm-h8300/pci.h linuxppc-2.5-benh/include/asm-h8300/pci.h
--- linux-2.5/include/asm-h8300/pci.h	2004-02-05 13:35:05.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-h8300/pci.h	2004-02-10 16:00:24.097652784 +1100
@@ -22,4 +22,8 @@
 
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* _ASM_H8300_PCI_H */
diff -urN linux-2.5/include/asm-i386/pci.h linuxppc-2.5-benh/include/asm-i386/pci.h
--- linux-2.5/include/asm-i386/pci.h	2004-02-05 13:35:05.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-i386/pci.h	2004-02-10 15:58:39.897493616 +1100
@@ -89,6 +89,11 @@
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
 
+
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __KERNEL__ */
 
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
diff -urN linux-2.5/include/asm-ia64/pci.h linuxppc-2.5-benh/include/asm-ia64/pci.h
--- linux-2.5/include/asm-ia64/pci.h	2004-02-05 13:35:05.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-ia64/pci.h	2004-02-10 16:01:02.408828600 +1100
@@ -112,6 +112,10 @@
 	return 0;
 }
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
diff -urN linux-2.5/include/asm-m68k/pci.h linuxppc-2.5-benh/include/asm-m68k/pci.h
--- linux-2.5/include/asm-m68k/pci.h	2004-02-05 13:35:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-m68k/pci.h	2004-02-10 16:01:19.610213592 +1100
@@ -54,4 +54,8 @@
  */
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* _ASM_M68K_PCI_H */
diff -urN linux-2.5/include/asm-m68knommu/pci.h linuxppc-2.5-benh/include/asm-m68knommu/pci.h
--- linux-2.5/include/asm-m68knommu/pci.h	2004-02-05 13:35:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-m68knommu/pci.h	2004-02-10 16:01:42.259770336 +1100
@@ -30,6 +30,10 @@
  */
 #define pci_dac_dma_supported(pci_dev, mask) (0)
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* CONFIG_COMEMPCI */
 
 #endif /* M68KNOMMU_PCI_H */
diff -urN linux-2.5/include/asm-mips/pci.h linuxppc-2.5-benh/include/asm-mips/pci.h
--- linux-2.5/include/asm-mips/pci.h	2004-02-05 13:35:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-mips/pci.h	2004-02-10 16:03:19.036058104 +1100
@@ -120,6 +120,10 @@
 	dma_cache_wback_inv(addr, len);
 }
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __KERNEL__ */
 
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
diff -urN linux-2.5/include/asm-parisc/pci.h linuxppc-2.5-benh/include/asm-parisc/pci.h
--- linux-2.5/include/asm-parisc/pci.h	2004-02-09 10:20:17.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-parisc/pci.h	2004-02-10 16:03:35.249593272 +1100
@@ -196,4 +196,8 @@
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			 struct resource *res);
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __ASM_PARISC_PCI_H */
diff -urN linux-2.5/include/asm-ppc/pci.h linuxppc-2.5-benh/include/asm-ppc/pci.h
--- linux-2.5/include/asm-ppc/pci.h	2004-02-05 13:35:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-ppc/pci.h	2004-02-10 16:04:01.747564968 +1100
@@ -282,6 +282,8 @@
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			struct resource *res);
 
+extern void pcibios_add_platform_entries(struct pci_dev *dev);
+
 #endif	/* __KERNEL__ */
 
 #endif /* __PPC_PCI_H */
diff -urN linux-2.5/include/asm-ppc64/pci.h linuxppc-2.5-benh/include/asm-ppc64/pci.h
--- linux-2.5/include/asm-ppc64/pci.h	2004-02-06 10:51:38.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-ppc64/pci.h	2004-02-10 16:04:41.338546224 +1100
@@ -152,6 +152,8 @@
 
 extern int pci_read_irq_line(struct pci_dev *dev);
 
+extern void pcibios_add_platform_entries(struct pci_dev *dev);
+
 #endif	/* __KERNEL__ */
 
 #endif /* __PPC64_PCI_H */
diff -urN linux-2.5/include/asm-sh/pci.h linuxppc-2.5-benh/include/asm-sh/pci.h
--- linux-2.5/include/asm-sh/pci.h	2004-02-05 13:35:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-sh/pci.h	2004-02-10 16:05:04.957955528 +1100
@@ -256,6 +256,10 @@
 extern int pciauto_assign_resources(int busno, struct pci_channel *hose);
 #endif
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
diff -urN linux-2.5/include/asm-sparc/pci.h linuxppc-2.5-benh/include/asm-sparc/pci.h
--- linux-2.5/include/asm-sparc/pci.h	2004-02-05 13:35:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-sparc/pci.h	2004-02-10 16:05:17.711016768 +1100
@@ -141,6 +141,10 @@
 
 #define pci_dac_dma_supported(dev, mask)	(0)
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
diff -urN linux-2.5/include/asm-sparc64/pci.h linuxppc-2.5-benh/include/asm-sparc64/pci.h
--- linux-2.5/include/asm-sparc64/pci.h	2004-02-05 13:35:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-sparc64/pci.h	2004-02-10 16:07:01.904177000 +1100
@@ -215,6 +215,10 @@
 pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			struct pci_bus_region *region);
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* __SPARC64_PCI_H */
diff -urN linux-2.5/include/asm-v850/pci.h linuxppc-2.5-benh/include/asm-v850/pci.h
--- linux-2.5/include/asm-v850/pci.h	2004-02-05 13:35:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-v850/pci.h	2004-02-10 16:07:44.602685840 +1100
@@ -76,4 +76,8 @@
 pci_free_consistent (struct pci_dev *pdev, size_t size, void *cpu_addr,
 		     dma_addr_t dma_addr);
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __V850_PCI_H__ */
diff -urN linux-2.5/include/asm-x86_64/pci.h linuxppc-2.5-benh/include/asm-x86_64/pci.h
--- linux-2.5/include/asm-x86_64/pci.h	2004-02-05 13:35:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-x86_64/pci.h	2004-02-10 16:07:56.957807576 +1100
@@ -263,6 +263,10 @@
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
 
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
diff -urN linux-2.5/arch/ppc/kernel/pci.c linuxppc-2.5-benh/arch/ppc/kernel/pci.c
--- linux-2.5/arch/ppc/kernel/pci.c	2004-02-06 17:16:25.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/pci.c	2004-02-10 17:20:40.946380472 +1100
@@ -1022,8 +1022,31 @@
 		prom_add_property(find_path_device("/"), of_prop);
 	}
 }
+
+static ssize_t pci_show_devspec(struct device *dev, char *buf)
+{
+	struct pci_dev *pdev;
+	struct device_node *np;
+
+	pdev = to_pci_dev (dev);
+	np = pci_device_to_OF_node(pdev);
+	if (np == NULL || np->full_name == NULL)
+		return 0;
+	return sprintf(buf, "%s", np->full_name);
+}
+static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
+
 #endif /* CONFIG_PPC_OF */
 
+/* Add sysfs properties */
+void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+#ifdef CONFIG_PPC_OF
+	device_create_file(&pdev->dev, &dev_attr_devspec);
+#endif /* CONFIG_PPC_OF */
+}
+
+
 #ifdef CONFIG_PPC_PMAC
 /*
  * This set of routines checks for PCI<->PCI bridges that have closed
diff -urN linux-2.5/arch/ppc64/kernel/pci.c linuxppc-2.5-benh/arch/ppc64/kernel/pci.c
--- linux-2.5/arch/ppc64/kernel/pci.c	2004-01-22 11:18:47.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc64/kernel/pci.c	2004-02-10 17:21:00.795362968 +1100
@@ -540,3 +540,25 @@
 
 	return ret;
 }
+
+#ifdef CONFIG_PPC_PSERIES
+static ssize_t pci_show_devspec(struct device *dev, char *buf)
+{
+	struct pci_dev *pdev;
+	struct device_node *np;
+
+	pdev = to_pci_dev (dev);
+	np = pci_device_to_OF_node(pdev);
+	if (np == NULL || np->full_name == NULL)
+		return 0;
+	return sprintf(buf, "%s", np->full_name);
+}
+static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
+#endif /* CONFIG_PPC_PSERIES */
+
+void pcibios_add_platform_entries(struct pci_dev *pdev)
+{
+#ifdef CONFIG_PPC_PSERIES
+	device_create_file(&pdev->dev, &dev_attr_devspec);
+#endif /* CONFIG_PPC_PSERIES */
+}
 

