Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWEERer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWEERer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWEERer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:34:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:65434 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750839AbWEEReq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:34:46 -0400
Date: Fri, 5 May 2006 13:34:34 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Morton Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH 5/6] kconfigurable resources arch dependent changes (arch/[j-p]*)
Message-ID: <20060505173434.GG6450@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060505172847.GC6450@in.ibm.com> <20060505173002.GD6450@in.ibm.com> <20060505173102.GE6450@in.ibm.com> <20060505173326.GF6450@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505173326.GF6450@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes to arch specific code for  kconfigurable resources. This
  patch contains changes for arch/[j-p]*

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/m32r/Kconfig                  |    7 +++++++
 arch/m68k/Kconfig                  |    7 +++++++
 arch/m68knommu/Kconfig             |    7 +++++++
 arch/m68knommu/kernel/comempci.c   |    3 ++-
 arch/mips/Kconfig                  |    8 ++++++++
 arch/mips/pci/pci.c                |    4 ++--
 arch/mips/pmc-sierra/yosemite/ht.c |    4 ++--
 arch/parisc/Kconfig                |    8 ++++++++
 arch/parisc/kernel/pci.c           |    2 +-
 arch/powerpc/Kconfig               |    8 ++++++++
 arch/powerpc/kernel/pci_32.c       |   10 +++++-----
 arch/powerpc/kernel/pci_64.c       |    4 ++--
 arch/ppc/Kconfig                   |    7 +++++++
 arch/ppc/kernel/pci.c              |   12 ++++++------
 include/asm-powerpc/pci.h          |    2 +-
 include/asm-ppc/pci.h              |    2 +-
 16 files changed, 74 insertions(+), 21 deletions(-)

diff -puN arch/m32r/Kconfig~kconfigurable-resources-arch-changes-j-p arch/m32r/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/m32r/Kconfig~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/m32r/Kconfig	2006-05-05 11:58:46.000000000 -0400
@@ -188,6 +188,13 @@ config ARCH_DISCONTIGMEM_ENABLE
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config IRAM_START
 	hex "Internal memory start address (hex)"
 	default "00f00000" if !CHIP_M32104
diff -puN arch/m68k/Kconfig~kconfigurable-resources-arch-changes-j-p arch/m68k/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/m68k/Kconfig~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/m68k/Kconfig	2006-05-05 11:58:46.000000000 -0400
@@ -368,6 +368,13 @@ config 060_WRITETHROUGH
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 menu "General setup"
diff -puN arch/m68knommu/Kconfig~kconfigurable-resources-arch-changes-j-p arch/m68knommu/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/m68knommu/Kconfig~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/m68knommu/Kconfig	2006-05-05 11:58:46.000000000 -0400
@@ -605,6 +605,13 @@ endchoice
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 config ISA_DMA_API
diff -puN arch/m68knommu/kernel/comempci.c~kconfigurable-resources-arch-changes-j-p arch/m68knommu/kernel/comempci.c
--- linux-2.6.17-rc3-mm1-1M/arch/m68knommu/kernel/comempci.c~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/m68knommu/kernel/comempci.c	2006-05-05 11:58:46.000000000 -0400
@@ -357,7 +357,8 @@ void pcibios_fixup_bus(struct pci_bus *b
 
 /*****************************************************************************/
 
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size, unsigned long align)
+void pcibios_align_resource(void *data, struct resource *res,
+				resource_size_t size, resource_size_t align)
 {
 }
 
diff -puN arch/mips/Kconfig~kconfigurable-resources-arch-changes-j-p arch/mips/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/mips/Kconfig~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/mips/Kconfig	2006-05-05 11:58:46.000000000 -0400
@@ -1655,6 +1655,14 @@ config NR_CPUS
 
 source "kernel/Kconfig.preempt"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on 32BIT
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config RTC_DS1742
 	bool "DS1742 BRAM/RTC support"
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
diff -puN arch/mips/pci/pci.c~kconfigurable-resources-arch-changes-j-p arch/mips/pci/pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/mips/pci/pci.c~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/mips/pci/pci.c	2006-05-05 11:58:46.000000000 -0400
@@ -51,11 +51,11 @@ unsigned long PCIBIOS_MIN_MEM	= 0;
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	struct pci_controller *hose = dev->sysdata;
-	unsigned long start = res->start;
+	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
 		/* Make sure we start at our min on all hoses */
diff -puN arch/mips/pmc-sierra/yosemite/ht.c~kconfigurable-resources-arch-changes-j-p arch/mips/pmc-sierra/yosemite/ht.c
--- linux-2.6.17-rc3-mm1-1M/arch/mips/pmc-sierra/yosemite/ht.c~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/mips/pmc-sierra/yosemite/ht.c	2006-05-05 11:58:46.000000000 -0400
@@ -383,12 +383,12 @@ void pcibios_update_resource(struct pci_
 
 
 void pcibios_align_resource(void *data, struct resource *res,
-                            unsigned long size, unsigned long align)
+                            resource_size_t size, resource_size_t align)
 {
         struct pci_dev *dev = data;
 
         if (res->flags & IORESOURCE_IO) {
-                unsigned long start = res->start;
+                resource_size_t start = res->start;
 
                 /* We need to avoid collisions with `mirrored' VGA ports
                    and other strange ISA hardware, so we always want the
diff -puN arch/parisc/Kconfig~kconfigurable-resources-arch-changes-j-p arch/parisc/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/parisc/Kconfig~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/parisc/Kconfig	2006-05-05 11:58:46.000000000 -0400
@@ -217,6 +217,14 @@ source "kernel/Kconfig.preempt"
 source "kernel/Kconfig.hz"
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on !64BIT
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config COMPAT
 	def_bool y
 	depends on 64BIT
diff -puN arch/parisc/kernel/pci.c~kconfigurable-resources-arch-changes-j-p arch/parisc/kernel/pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/parisc/kernel/pci.c~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/parisc/kernel/pci.c	2006-05-05 11:58:46.000000000 -0400
@@ -289,7 +289,7 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
  * than res->start.
  */
 void pcibios_align_resource(void *data, struct resource *res,
-				unsigned long size, unsigned long alignment)
+				resource_size_t size, resource_size_t alignment)
 {
 	unsigned long mask, align;
 
diff -puN include/asm-powerpc/pci.h~kconfigurable-resources-arch-changes-j-p include/asm-powerpc/pci.h
--- linux-2.6.17-rc3-mm1-1M/include/asm-powerpc/pci.h~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/include/asm-powerpc/pci.h	2006-05-05 11:58:46.000000000 -0400
@@ -242,7 +242,7 @@ extern pgprot_t	pci_phys_mem_access_prot
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
-				 u64 *start, u64 *end);
+				 resource_size_t *start, resource_size_t *end);
 #endif /* CONFIG_PPC_MULTIPLATFORM || CONFIG_PPC32 */
 
 #endif	/* __KERNEL__ */
diff -puN arch/powerpc/Kconfig~kconfigurable-resources-arch-changes-j-p arch/powerpc/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/powerpc/Kconfig~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/powerpc/Kconfig	2006-05-05 11:58:46.000000000 -0400
@@ -626,6 +626,14 @@ config CRASH_DUMP
 
 	  Don't change this unless you know what you are doing.
 
+config RESOURCES_32BIT
+        bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+        depends on EXPERIMENTAL
+	depends on PPC32
+        help
+          By default resources are 64 bit. This option allows memory and IO
+          resources to be 32 bit to optimize code size.
+
 config EMBEDDEDBOOT
 	bool
 	depends on 8xx || 8260
diff -puN arch/powerpc/kernel/pci_32.c~kconfigurable-resources-arch-changes-j-p arch/powerpc/kernel/pci_32.c
--- linux-2.6.17-rc3-mm1-1M/arch/powerpc/kernel/pci_32.c~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/powerpc/kernel/pci_32.c	2006-05-05 11:58:46.000000000 -0400
@@ -173,18 +173,18 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
  */
-void pcibios_align_resource(void *data, struct resource *res, u64 size,
-				u64 align)
+void pcibios_align_resource(void *data, struct resource *res,
+				resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		u64 start = res->start;
+		resource_size_t start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
 			       " (%lld bytes)\n", pci_name(dev),
-			       dev->resource - res, size);
+			       dev->resource - res, (unsigned long long)size);
 		}
 
 		if (start & 0x300) {
@@ -1756,7 +1756,7 @@ long sys_pciconfig_iobase(long which, un
 
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
-			  u64 *start, u64 *end)
+			  resource_size_t *start, resource_size_t *end)
 {
 	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
 	unsigned long offset = 0;
diff -puN arch/powerpc/kernel/pci_64.c~kconfigurable-resources-arch-changes-j-p arch/powerpc/kernel/pci_64.c
--- linux-2.6.17-rc3-mm1-1M/arch/powerpc/kernel/pci_64.c~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/powerpc/kernel/pci_64.c	2006-05-05 11:58:46.000000000 -0400
@@ -138,11 +138,11 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
  * which might have be mirrored at 0x0100-0x03ff..
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long start = res->start;
+	resource_size_t start = res->start;
 	unsigned long alignto;
 
 	if (res->flags & IORESOURCE_IO) {
diff -puN include/asm-ppc/pci.h~kconfigurable-resources-arch-changes-j-p include/asm-ppc/pci.h
--- linux-2.6.17-rc3-mm1-1M/include/asm-ppc/pci.h~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/include/asm-ppc/pci.h	2006-05-05 11:58:46.000000000 -0400
@@ -133,7 +133,7 @@ extern pgprot_t	pci_phys_mem_access_prot
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 				 const struct resource *rsrc,
-				 u64 *start, u64 *end);
+				 resource_size_t *start, resource_size_t *end);
 
 
 #endif	/* __KERNEL__ */
diff -puN arch/ppc/Kconfig~kconfigurable-resources-arch-changes-j-p arch/ppc/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/ppc/Kconfig~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/ppc/Kconfig	2006-05-05 11:58:46.000000000 -0400
@@ -953,6 +953,13 @@ source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 source "fs/Kconfig.binfmt"
 
 config PREP_RESIDUAL
diff -puN arch/ppc/kernel/pci.c~kconfigurable-resources-arch-changes-j-p arch/ppc/kernel/pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/ppc/kernel/pci.c~kconfigurable-resources-arch-changes-j-p	2006-05-05 11:58:46.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/ppc/kernel/pci.c	2006-05-05 11:58:46.000000000 -0400
@@ -171,13 +171,13 @@ EXPORT_SYMBOL(pcibios_bus_to_resource);
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
  */
-void pcibios_align_resource(void *data, struct resource *res, u64 size,
-		       u64 align)
+void pcibios_align_resource(void *data, struct resource *res,
+				resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		u64 start = res->start;
+		resource_size_t start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
@@ -960,8 +960,8 @@ static pgprot_t __pci_mmap_set_pgprot(st
 	else
 		prot |= _PAGE_GUARDED;
 
-	printk("PCI map for %s:%llx, prot: %llx\n", pci_name(dev), rp->start,
-	       prot);
+	printk("PCI map for %s:%llx, prot: %lx\n", pci_name(dev),
+		(unsigned long long)rp->start, prot);
 
 	return __pgprot(prot);
 }
@@ -1131,7 +1131,7 @@ long sys_pciconfig_iobase(long which, un
 
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
-			  u64 *start, u64 *end)
+			  resource_size_t *start, resource_size_t *end)
 {
 	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
 	unsigned long offset = 0;
_
