Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVLLAM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVLLAM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVLLAM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:12:27 -0500
Received: from ozlabs.org ([203.10.76.45]:22402 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750925AbVLLAM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:12:26 -0500
Date: Mon, 12 Dec 2005 11:12:01 +1100
From: Anton Blanchard <anton@samba.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, miltonm@bga.com,
       rajesh.shah@intel.com
Subject: [PATCH] PCI express must be initialized before PCI hotplug
Message-ID: <20051212001201.GF23641@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Milton Miller <miltonm@bga.com>

PCI express hotplug uses the pcieportbus driver so pcie must be
initialized before hotplug/.  This patch changes the link order.

Signed-Off-By: Milton Miller <miltonm@bga.com>
Acked-by: Anton Blanchard <anton@samba.org>
--- 

This could also be fixed by changing initcall levels, but what level
would be appropriate?  Should it be subsys_initcall?  Should it be
postcore_initcall like pci_driver_init (but after it), before the
architecture subsys_initcall(pcibios_init)?

pci_hotplug: PCI Hot Plug PCI Core version: 0.5
fakephp: Fake PCI Hot Plug Controller Driver
Badness in kref_get at lib/kref.c:32
Call Trace:
[C00000003AFB7770] [C000000000022F68] .show_stack+0x68/0x1d0 (unreliable)
[C00000003AFB7810] [C0000000004CAE30] .program_check_exception+0x2f0/0x600
[C00000003AFB78B0] [C000000000004348] program_check_common+0xc8/0x100
--- Exception: 700 at .kref_get+0x14/0x30
    LR = .kobject_get+0x20/0x40
[C00000003AFB7BA0] [C0000000005E5908] __per_cpu_end+0x0/0x26f8 (unreliable)
[C00000003AFB7C20] [C0000000002C2B70] .get_bus+0x20/0x50
[C00000003AFB7CA0] [C0000000002C34EC] .bus_add_driver+0x3c/0x200
[C00000003AFB7D50] [C0000000002C46FC] .driver_register+0x5c/0x80
[C00000003AFB7DF0] [C000000000239D44] .pcie_port_service_register+0x54/0x70
[C00000003AFB7E70] [C0000000005AD448] .pciehp_init+0x98/0x120
[C00000003AFB7F00] [C0000000000093FC] .init+0x1ac/0x490
[C00000003AFB7F90] [C0000000000283B4] .kernel_thread+0x4c/0x68
Badness in kref_get at lib/kref.c:32
Call Trace:
[C00000003AFB76E0] [C000000000022F68] .show_stack+0x68/0x1d0 (unreliable)
[C00000003AFB7780] [C0000000004CAE30] .program_check_exception+0x2f0/0x600
[C00000003AFB7820] [C000000000004348] program_check_common+0xc8/0x100
--- Exception: 700 at .kref_get+0x14/0x30
    LR = .kobject_get+0x20/0x40
[C00000003AFB7B10] [C0000000006D4400] devlist+0xcf88/0xee78 (unreliable)
[C00000003AFB7B90] [C000000000219310] .kobject_init+0x40/0x90
[C00000003AFB7C10] [C0000000002194BC] .kobject_register+0x2c/0xb0
[C00000003AFB7CA0] [C0000000002C3560] .bus_add_driver+0xb0/0x200
[C00000003AFB7D50] [C0000000002C46FC] .driver_register+0x5c/0x80
[C00000003AFB7DF0] [C000000000239D44] .pcie_port_service_register+0x54/0x70
[C00000003AFB7E70] [C0000000005AD448] .pciehp_init+0x98/0x120
[C00000003AFB7F00] [C0000000000093FC] .init+0x1ac/0x490
[C00000003AFB7F90] [C0000000000283B4] .kernel_thread+0x4c/0x68
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000000000219004
NIP: C000000000219004 LR: C000000000219168 CTR: 0000000000000000
REGS: c00000003afb78f0 TRAP: 0300   Not tainted  (2.6.15-rc3-bml)
MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 24FFFF84  XER: 00000000
DAR: 0000000000000000, DSISR: 0000000042000000
TASK = c00000003ffcd810[1] 'swapper' THREAD: c00000003afb4000 CPU: 1
GPR00: C000000000219168 C00000003AFB7B70 C000000000811680 C0000000006A9F70 
GPR04: 00000000000000D0 C0000000005281E9 C00000003AFB7CE0 C0000000007E1A98 
GPR08: C0000000005281E8 C0000000006A9F58 0000000000000000 C0000000006A9AE8 
GPR12: 0000000000000002 C00000000061E400 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: C0000000005E5908 C000000000838110 C0000000006A9F70 C0000000006A9A98 
GPR28: FFFFFFFFFFFFFFFE FFFFFFFFFFFFFFEA C0000000006A3BD0 C0000000006A9AC8 
NIP [C000000000219004] .kobject_add+0x84/0x200
LR [C000000000219168] .kobject_add+0x1e8/0x200
Call Trace:
[C00000003AFB7B70] [C000000000219168] .kobject_add+0x1e8/0x200 (unreliable)
[C00000003AFB7C10] [C0000000002194C4] .kobject_register+0x34/0xb0
[C00000003AFB7CA0] [C0000000002C3560] .bus_add_driver+0xb0/0x200
[C00000003AFB7D50] [C0000000002C46FC] .driver_register+0x5c/0x80
[C00000003AFB7DF0] [C000000000239D44] .pcie_port_service_register+0x54/0x70
[C00000003AFB7E70] [C0000000005AD448] .pciehp_init+0x98/0x120
[C00000003AFB7F00] [C0000000000093FC] .init+0x1ac/0x490
[C00000003AFB7F90] [C0000000000283B4] .kernel_thread+0x4c/0x68
Instruction dump:
419e0048 38630020 482b1495 60000000 2fba0000 419e0174 e93f0038 397f0020 
39290010 e9490008 f93f0020 f9690008 <f96a0000> f94b0008 e93f0038 7c2004ac 
cpu 0x1: Vector: 300 (Data Access) at [c00000003afb78f0]
    pc: c000000000219004: .kobject_add+0x84/0x200
    lr: c000000000219168: .kobject_add+0x1e8/0x200
    sp: c00000003afb7b70
   msr: 9000000000009032
   dar: 0
 dsisr: 42000000
  current = 0xc00000003ffcd810
  paca    = 0xc00000000061e400
    pid   = 1, comm = swapper
enter ? for help
1:mon> 

Index: gr_work/drivers/pci/Makefile
===================================================================
--- gr_work.orig/drivers/pci/Makefile	2005-11-29 17:31:39.077083723 -0600
+++ gr_work/drivers/pci/Makefile	2005-11-30 15:14:55.611654901 -0600
@@ -6,6 +6,9 @@ obj-y		+= access.o bus.o probe.o remove.
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
+# Build PCI Express stuff if needed
+obj-$(CONFIG_PCIEPORTBUS) += pcie/
+
 obj-$(CONFIG_HOTPLUG) += hotplug.o
 
 # Build the PCI Hotplug drivers if we were asked to
@@ -40,7 +43,3 @@ endif
 ifeq ($(CONFIG_PCI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
-
-# Build PCI Express stuff if needed
-obj-$(CONFIG_PCIEPORTBUS) += pcie/
-

