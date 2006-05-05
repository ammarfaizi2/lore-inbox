Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWEERdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWEERdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWEERdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:33:38 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:42202 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750839AbWEERdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:33:37 -0400
Date: Fri, 5 May 2006 13:33:26 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Morton Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH 4/6] kconfigurable resources arch dependent changes (arch/[a-i]*)
Message-ID: <20060505173326.GF6450@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060505172847.GC6450@in.ibm.com> <20060505173002.GD6450@in.ibm.com> <20060505173102.GE6450@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505173102.GE6450@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes to arch specific code for  kconfigurable resources. This
  patch contains changes for arch/[a-i]*

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/alpha/kernel/pci.c               |    4 ++--
 arch/arm/Kconfig                      |    7 +++++++
 arch/arm/kernel/bios32.c              |    6 +++---
 arch/arm26/Kconfig                    |    7 +++++++
 arch/cris/Kconfig                     |    7 +++++++
 arch/cris/arch-v32/drivers/pci/bios.c |    4 ++--
 arch/frv/Kconfig                      |    7 +++++++
 arch/frv/mb93090-mb00/pci-frv.c       |    4 ++--
 arch/h8300/Kconfig.cpu                |   12 ++++++++++++
 arch/i386/Kconfig                     |    7 +++++++
 arch/i386/pci/i386.c                  |    4 ++--
 arch/ia64/pci/pci.c                   |    2 +-
 12 files changed, 59 insertions(+), 12 deletions(-)

diff -puN arch/alpha/kernel/pci.c~kconfigurable-resources-arch-changes-a-i arch/alpha/kernel/pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/alpha/kernel/pci.c~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/alpha/kernel/pci.c	2006-05-05 11:57:33.000000000 -0400
@@ -124,12 +124,12 @@ DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_
 
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	struct pci_controller *hose = dev->sysdata;
 	unsigned long alignto;
-	unsigned long start = res->start;
+	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
 		/* Make sure we start at our min on all hoses */
diff -puN arch/arm26/Kconfig~kconfigurable-resources-arch-changes-a-i arch/arm26/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/arm26/Kconfig~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/arm26/Kconfig	2006-05-05 11:57:33.000000000 -0400
@@ -187,6 +187,13 @@ config CMDLINE
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 source "net/Kconfig"
diff -puN arch/arm/Kconfig~kconfigurable-resources-arch-changes-a-i arch/arm/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/arm/Kconfig~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/arm/Kconfig	2006-05-05 11:57:33.000000000 -0400
@@ -520,6 +520,13 @@ config NODES_SHIFT
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config LEDS
 	bool "Timer and CPU usage LEDs"
 	depends on ARCH_CDB89712 || ARCH_CO285 || ARCH_EBSA110 || \
diff -puN arch/arm/kernel/bios32.c~kconfigurable-resources-arch-changes-a-i arch/arm/kernel/bios32.c
--- linux-2.6.17-rc3-mm1-1M/arch/arm/kernel/bios32.c~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/arm/kernel/bios32.c	2006-05-05 11:57:33.000000000 -0400
@@ -304,7 +304,7 @@ static inline int pdev_bad_for_parity(st
 static void __devinit
 pdev_fixup_device_resources(struct pci_sys_data *root, struct pci_dev *dev)
 {
-	u64 offset;
+	resource_size_t offset;
 	int i;
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -634,9 +634,9 @@ char * __init pcibios_setup(char *str)
  * which might be mirrored at 0x0100-0x03ff..
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    u64 size, u64 align)
+			    resource_sz_t size, resource_size_t align)
 {
-	u64 start = res->start;
+	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/cris/arch-v32/drivers/pci/bios.c~kconfigurable-resources-arch-changes-a-i arch/cris/arch-v32/drivers/pci/bios.c
--- linux-2.6.17-rc3-mm1-1M/arch/cris/arch-v32/drivers/pci/bios.c~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/cris/arch-v32/drivers/pci/bios.c	2006-05-05 11:57:33.000000000 -0400
@@ -45,10 +45,10 @@ int pci_mmap_page_range(struct pci_dev *
 
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/cris/Kconfig~kconfigurable-resources-arch-changes-a-i arch/cris/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/cris/Kconfig~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/cris/Kconfig	2006-05-05 11:57:33.000000000 -0400
@@ -80,6 +80,13 @@ config PREEMPT
 
 source mm/Kconfig
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 endmenu
 
 menu "Hardware setup"
diff -puN arch/frv/Kconfig~kconfigurable-resources-arch-changes-a-i arch/frv/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/frv/Kconfig~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/frv/Kconfig	2006-05-05 11:57:33.000000000 -0400
@@ -80,6 +80,13 @@ config HIGHPTE
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 choice
 	prompt "uClinux kernel load address"
 	depends on !MMU
diff -puN arch/frv/mb93090-mb00/pci-frv.c~kconfigurable-resources-arch-changes-a-i arch/frv/mb93090-mb00/pci-frv.c
--- linux-2.6.17-rc3-mm1-1M/arch/frv/mb93090-mb00/pci-frv.c~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/frv/mb93090-mb00/pci-frv.c	2006-05-05 11:57:33.000000000 -0400
@@ -64,10 +64,10 @@ pcibios_update_resource(struct pci_dev *
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/h8300/Kconfig.cpu~kconfigurable-resources-arch-changes-a-i arch/h8300/Kconfig.cpu
--- linux-2.6.17-rc3-mm1-1M/arch/h8300/Kconfig.cpu~kconfigurable-resources-arch-changes-a-i	2006-05-05 12:55:38.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/h8300/Kconfig.cpu	2006-05-05 12:56:28.000000000 -0400
@@ -183,4 +183,10 @@ config PREEMPT
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
 endmenu
diff -puN arch/i386/Kconfig~kconfigurable-resources-arch-changes-a-i arch/i386/Kconfig
--- linux-2.6.17-rc3-mm1-1M/arch/i386/Kconfig~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/i386/Kconfig	2006-05-05 11:57:33.000000000 -0400
@@ -762,6 +762,13 @@ config PHYSICAL_START
 
 	  Don't change this unless you know what you are doing.
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
diff -puN arch/i386/pci/i386.c~kconfigurable-resources-arch-changes-a-i arch/i386/pci/i386.c
--- linux-2.6.17-rc3-mm1-1M/arch/i386/pci/i386.c~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/i386/pci/i386.c	2006-05-05 11:57:33.000000000 -0400
@@ -48,10 +48,10 @@
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       u64 size, u64 align)
+			resource_size_t size, resource_size_t align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		u64 start = res->start;
+		resource_size_t start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/ia64/pci/pci.c~kconfigurable-resources-arch-changes-a-i arch/ia64/pci/pci.c
--- linux-2.6.17-rc3-mm1-1M/arch/ia64/pci/pci.c~kconfigurable-resources-arch-changes-a-i	2006-05-05 11:57:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/ia64/pci/pci.c	2006-05-05 11:57:33.000000000 -0400
@@ -568,7 +568,7 @@ pcibios_disable_device (struct pci_dev *
 
 void
 pcibios_align_resource (void *data, struct resource *res,
-		        unsigned long size, unsigned long align)
+		        resource_size_t size, resource_size_t align)
 {
 }
 
diff -puN arch/h8300/Kconfig.cpu~kconfigurable-resources-arch-changes-a-i arch/h8300/Kconfig.cpu
--- linux-2.6.17-rc3-mm1-1M/arch/h8300/Kconfig.cpu~kconfigurable-resources-arch-changes-a-i	2006-05-05 12:55:38.000000000 -0400
+++ linux-2.6.17-rc3-mm1-1M-root/arch/h8300/Kconfig.cpu	2006-05-05 12:56:28.000000000 -0400
@@ -183,4 +183,10 @@ config PREEMPT
 
 source "mm/Kconfig"
 
+config RESOURCES_32BIT
+	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  By default resources are 64 bit. This option allows memory and IO
+	  resources to be 32 bit to optimize code size.
 endmenu
_
