Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTDXN3U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbTDXN3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:29:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263672AbTDXN3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:29:14 -0400
Date: Thu, 24 Apr 2003 14:41:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] iomem ends at ~0UL, not 0xffffffff
Message-ID: <20030424134121.GZ3140@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Every 64-bit architecture changes the end of iomem_resources.  Some more
gracefully than others.  This patch does away with all that by making
it end at ~0UL by default.

 arch/alpha/kernel/core_marvel.c      |    1 -
 arch/alpha/kernel/core_mcpcia.c      |    1 -
 arch/alpha/kernel/core_titan.c       |    1 -
 arch/alpha/kernel/core_tsunami.c     |    1 -
 arch/alpha/kernel/core_wildfire.c    |    1 -
 arch/ia64/sn/io/pci_bus_cvlink.c     |    6 ------
 arch/ia64/sn/io/sn2/pci_bus_cvlink.c |    6 ------
 arch/mips64/sgi-ip27/ip27-pci.c      |    1 -
 arch/parisc/mm/init.c                |    5 -----
 arch/sparc64/kernel/devices.c        |    1 -
 kernel/resource.c                    |    2 +-
 11 files changed, 1 insertion(+), 25 deletions(-)

diff -urpNX build-tools/dontdiff linus-2.5/arch/alpha/kernel/core_marvel.c parisc-2.5/arch/alpha/kernel/core_marvel.c
--- linus-2.5/arch/alpha/kernel/core_marvel.c	Mon Mar 17 20:25:10 2003
+++ parisc-2.5/arch/alpha/kernel/core_marvel.c	Thu Apr 24 07:15:06 2003
@@ -452,7 +452,6 @@ marvel_init_arch(void)
 
 	/* With multiple PCI busses, we play with I/O as physical addrs.  */
 	ioport_resource.end = ~0UL;
-	iomem_resource.end = ~0UL;
 
 	/* PCI DMA Direct Mapping is 1GB at 2GB.  */
 	__direct_map_base = 0x80000000;
diff -urpNX build-tools/dontdiff linus-2.5/arch/alpha/kernel/core_mcpcia.c parisc-2.5/arch/alpha/kernel/core_mcpcia.c
--- linus-2.5/arch/alpha/kernel/core_mcpcia.c	Tue Oct  8 10:52:15 2002
+++ parisc-2.5/arch/alpha/kernel/core_mcpcia.c	Thu Apr 24 07:15:06 2003
@@ -407,7 +407,6 @@ mcpcia_init_arch(void)
 {
 	/* With multiple PCI busses, we play with I/O as physical addrs.  */
 	ioport_resource.end = ~0UL;
-	iomem_resource.end = ~0UL;
 
 	/* Allocate hose 0.  That's the one that all the ISA junk hangs
 	   off of, from which we'll be registering stuff here in a bit.
diff -urpNX build-tools/dontdiff linus-2.5/arch/alpha/kernel/core_titan.c parisc-2.5/arch/alpha/kernel/core_titan.c
--- linus-2.5/arch/alpha/kernel/core_titan.c	Mon Mar 17 20:25:10 2003
+++ parisc-2.5/arch/alpha/kernel/core_titan.c	Thu Apr 24 07:15:06 2003
@@ -412,7 +412,6 @@ titan_init_arch(void)
 
 	/* With multiple PCI busses, we play with I/O as physical addrs.  */
 	ioport_resource.end = ~0UL;
-	iomem_resource.end = ~0UL;
 
 	/* PCI DMA Direct Mapping is 1GB at 2GB.  */
 	__direct_map_base = 0x80000000;
diff -urpNX build-tools/dontdiff linus-2.5/arch/alpha/kernel/core_tsunami.c parisc-2.5/arch/alpha/kernel/core_tsunami.c
--- linus-2.5/arch/alpha/kernel/core_tsunami.c	Tue Feb  4 04:50:43 2003
+++ parisc-2.5/arch/alpha/kernel/core_tsunami.c	Thu Apr 24 07:15:06 2003
@@ -390,7 +390,6 @@ tsunami_init_arch(void)
 #endif
 	/* With multiple PCI busses, we play with I/O as physical addrs.  */
 	ioport_resource.end = ~0UL;
-	iomem_resource.end = ~0UL;
 
 	/* Find how many hoses we have, and initialize them.  TSUNAMI
 	   and TYPHOON can have 2, but might only have 1 (DS10).  */
diff -urpNX build-tools/dontdiff linus-2.5/arch/alpha/kernel/core_wildfire.c parisc-2.5/arch/alpha/kernel/core_wildfire.c
--- linus-2.5/arch/alpha/kernel/core_wildfire.c	Tue Feb  4 04:50:43 2003
+++ parisc-2.5/arch/alpha/kernel/core_wildfire.c	Thu Apr 24 07:15:06 2003
@@ -309,7 +309,6 @@ wildfire_init_arch(void)
 
 	/* With multiple PCI buses, we play with I/O as physical addrs.  */
 	ioport_resource.end = ~0UL;
-	iomem_resource.end = ~0UL;
 
 
 	/* Probe the hardware for info about configuration. */
diff -urpNX build-tools/dontdiff linus-2.5/arch/ia64/sn/io/pci_bus_cvlink.c parisc-2.5/arch/ia64/sn/io/pci_bus_cvlink.c
--- linus-2.5/arch/ia64/sn/io/pci_bus_cvlink.c	Thu Jul 18 09:52:27 2002
+++ parisc-2.5/arch/ia64/sn/io/pci_bus_cvlink.c	Thu Apr 24 07:15:50 2003
@@ -373,12 +373,6 @@ sn1_pci_fixup(int arg)
 #endif
 
 	/*
-	 * Set the root start and end for Mem Resource.
-	 */
-	iomem_resource.start = 0;
-	iomem_resource.end = 0xffffffffffffffff;
-
-	/*
 	 * Initialize the device vertex in the pci_dev struct.
 	 */
 	pci_for_each_dev(device_dev) {
diff -urpNX build-tools/dontdiff linus-2.5/arch/ia64/sn/io/sn2/pci_bus_cvlink.c parisc-2.5/arch/ia64/sn/io/sn2/pci_bus_cvlink.c
--- linus-2.5/arch/ia64/sn/io/sn2/pci_bus_cvlink.c	Mon Mar 17 16:11:46 2003
+++ parisc-2.5/arch/ia64/sn/io/sn2/pci_bus_cvlink.c	Thu Apr 24 07:15:51 2003
@@ -323,12 +323,6 @@ sn_pci_fixup(int arg)
 	ioport_resource.end =    0xcfffffffffffffff;
 
 	/*
-	 * Set the root start and end for Mem Resource.
-	 */
-	iomem_resource.start = 0;
-	iomem_resource.end = 0xffffffffffffffff;
-
-	/*
 	 * Initialize the device vertex in the pci_dev struct.
 	 */
 	pci_for_each_dev(device_dev) {
diff -urpNX build-tools/dontdiff linus-2.5/arch/mips64/sgi-ip27/ip27-pci.c parisc-2.5/arch/mips64/sgi-ip27/ip27-pci.c
--- linus-2.5/arch/mips64/sgi-ip27/ip27-pci.c	Mon Mar 17 20:27:09 2003
+++ parisc-2.5/arch/mips64/sgi-ip27/ip27-pci.c	Thu Apr 24 07:16:25 2003
@@ -149,7 +149,6 @@ void __init pcibios_init(void)
 	int	i;
 
 	ioport_resource.end = ~0UL;
-	iomem_resource.end = ~0UL;
 
 	for (i=0; i<num_bridges; i++) {
 		printk("PCI: Probing PCI hardware on host bus %2d.\n", i);
diff -urpNX build-tools/dontdiff linus-2.5/arch/parisc/mm/init.c parisc-2.5/arch/parisc/mm/init.c
--- linus-2.5/arch/parisc/mm/init.c	Thu Mar  6 06:16:44 2003
+++ parisc-2.5/arch/parisc/mm/init.c	Thu Apr 24 07:16:30 2003
@@ -195,11 +195,6 @@ static void __init setup_bootmem(void)
 
 #endif /* __LP64__ */
 
-#if 1
-	/* KLUGE! this really belongs in kernel/resource.c! */
-	iomem_resource.end = ~0UL;
-#endif
-
 	sysram_resource_count = npmem_ranges;
 	for (i = 0; i < sysram_resource_count; i++) {
 		struct resource *res = &sysram_resources[i];
diff -urpNX build-tools/dontdiff linus-2.5/arch/sparc64/kernel/devices.c parisc-2.5/arch/sparc64/kernel/devices.c
--- linus-2.5/arch/sparc64/kernel/devices.c	Tue Apr  8 12:15:41 2003
+++ parisc-2.5/arch/sparc64/kernel/devices.c	Thu Apr 24 07:17:15 2003
@@ -40,7 +40,6 @@ void __init device_scan(void)
 
 	/* FIX ME FAST... -DaveM */
 	ioport_resource.end = 0xffffffffffffffffUL;
-	iomem_resource.end = 0xffffffffffffffffUL;
 
 	prom_getstring(prom_root_node, "device_type", node_str, sizeof(node_str));
 
diff -urpNX build-tools/dontdiff linus-2.5/kernel/resource.c parisc-2.5/kernel/resource.c
--- linus-2.5/kernel/resource.c	Thu Mar  6 06:21:57 2003
+++ parisc-2.5/kernel/resource.c	Thu Apr 24 07:27:36 2003
@@ -21,7 +21,7 @@
 
 
 struct resource ioport_resource = { "PCI IO", 0x0000, IO_SPACE_LIMIT, IORESOURCE_IO };
-struct resource iomem_resource = { "PCI mem", 0x00000000, 0xffffffff, IORESOURCE_MEM };
+struct resource iomem_resource = { "PCI mem", 0UL, ~0UL, IORESOURCE_MEM };
 
 static rwlock_t resource_lock = RW_LOCK_UNLOCKED;
 

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
