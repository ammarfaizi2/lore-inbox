Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbUAaC1W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 21:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUAaC1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 21:27:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:46029 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264472AbUAaC1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 21:27:12 -0500
Date: Fri, 30 Jan 2004 18:27:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.2-rc3
Message-ID: <Pine.LNX.4.58.0401301823500.2847@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The bulk of this is an ACPI update, but there's USB, ia-64, i2c, XFS and 
PCI hotplug updates here too.

Please don't send in anything but critical fixes until after the final 
2.6.2 release.

		Linus

----

Summary of changes from v2.6.2-rc2 to v2.6.2-rc3
============================================

Alan Stern:
  o USB Storage: unusual_devs update
  o USB: Don't dereference NULL actconfig
  o USB: Fix DMA coherence when reading device descriptor
  o USB: Update sound/usb/usbaudio.c

Andi Kleen:
  o Fix error checking in IPC_SET

Andreas Schwab:
  o ia64: Fix xbow.c compilation

Andrew Morton:
  o ia64: i2c config fix
  o Fix CONFIG_DEBUG_SPINLOCK on UP
  o kbuildL fix cscope index generation
  o Fix two warnings on x86-64
  o Fix kernel_flag again
  o pmdisk.c needs utsname.h
  o cpufreq: fix cpufreq_update_policy

Arjan van de Ven:
  o usb: remove some sleep_on's

Ben Collins:
  o head.S
  o [SPARC64]: Changes to accomodate booting from non-phys_base memory
  o [SPARC64]: Add _end and _start to list of sections
  o [SUNSAB]: Fixup sunsab_receive_chars for when serial console isn't
    open (no tty)

Bjorn Helgaas:
  o ia64: Kconfig cleanup, part 1
  o ia64: remove MCA (MicroChannel) cruft

Christoph Hellwig:
  o [XFS] Small ktrace fixes
  o [XFS] Simplify pagebuf_rele / pagebuf_free
  o [XFS] Don't fail pagebuf allocations
  o [XFS] Stop using sleep_on
  o [XFS] Plug a pagebuf race that got bigger with the recent cleanup

Dave Jones:
  o USB: fix suspicious pointer usage in kobil_sct driver

David Brownell:
  o USB gadget: net2280 controller updates
  o USB gadget: add File-backed Storage Gadget (FSG)
  o USB gadget: config/build updates
  o USB gadget: zero config updates
  o USB gadget: ethernet config updates
  o USB gadget: serial driver config update
  o USB: fix gadget config

David Mosberger:
  o ia64: arch/ia64/Kconfig URL update: www.linux-on-laptops.com
  o ia64: Drop copyright notices on header files which are either
    entirely trivial
  o ia64: Fix typo in comment in asm-ia64/posix_types.h
  o ia64: Patch by Jesse Barnes: remove unnecessary set_affinity
    handler
  o ia64: Fix merge error: remove duplicate NR_CPUS
  o ia64: Implement exception-table sorting for real

David S. Miller:
  o [IPV6]: Fix TCP socket leak, do not grab socket reference when
    adding to main hashes
  o [IRDA]: Mark init/exit functions of drivers static to fix build
  o [SPARC64]: Remove interruptible_sleep_on() usage, with help from
    Tom Callaway

Dirk Behme:
  o [ARM PATCH] 1749/1: Remove warnings in csumpartialcopygeneric.S

Dominik Brodowski:
  o Validate ACPI CPU frequency values

Frank Becker:
  o [ARM PATCH] 1744/1: SA Cerfboard/cube update (flash)
  o [ARM PATCH] 1747/1: MIssing export for cpufreq
  o [ARM PATCH] 1748/1: SA Cerfcube update (base+pcmica)

Grant Grundler:
  o ia64: enable PIOW/DMAR relaxed ordering on ZX1

Greg Kroah-Hartman:
  o USB storage: remove info sysfs file as it violates the sysfs 1
    value per file rule
  o USB: fix up emi drivers Kconfig dependancy
  o USB: fix up whiteheat syntax errors from previous patch
  o USB: add ohci support for OMAP controller
  o I2C: remove printk() calls in lm85, and clean up debug logic
  o PCI: add .owner field to the config sysfs file to be "correct"
  o PCI: fix compiler warning in probe.c cause by PPC patch

Herbert Xu:
  o USB Storage: revert freecom dvd-rw fx-50 usb-ide patch

James Simmons:
  o fbdev booting fix
  o fbdev documentation patch

Jean Delvare:
  o I2C: undo documentation change
  o I2C: Fix bus reset in i2c-philips-par
  o I2C: Add ADM1025EB support to i2c-parport
  o I2C: Bring lm75 and lm78 in compliance with sysfs naming
    conventions

Jesse Barnes:
  o ia64: fix cast in irq_lsapic.c
  o ia64: kill some more warnings

John Rose:
  o PCI: Allow pci hotplug drivers to initialize individual devices

Kieran Morrissey:
  o PCI: name length change
  o PCI: pci.ids update

Leann Ogasawara:
  o PCI hotplug: pcihp_zt5550.c ioremap/iounmap audit

Len Brown:
  o [ACPI] If ACPI is disabled by DMI BIOS date, then turn it off
    completely, including table parsing for HT.
  o [ACPI] In ACPI mode, delay print_IO_APIC() to make its output valid
  o [ACPI] print_IO_APIC() only after it is programmed
    http://bugzilla.kernel.org/show_bug.cgi?id=1177
  o [ACPI] "acpi_pic_sci=edge" in case platform requires Edge Triggered
    SCI http://bugzilla.kernel.org/show_bug.cgi?id=1390
  o [ACPI] fix compiler warning (Andrew Morton)
  o [ACPI] prevent ES7000 tweak from breaking i386 IOAPIC (Andrew de
    Quincey)
  o [ACPI] sync with 2.4.23 Re-enable IRQ balacning if IOAPIC mode
    http://bugzilla.kernel.org/show_bug.cgi?id=1440
  o [ACPI] add warning to thermal shutdown (Pavel Machek)
  o [ACPI] set APIC ACPI SCI OVR default to level/low
    http://bugzilla.kernel.org/show_bug.cgi?id=1351
  o [ACPI] replace multiple flags with acpi_noirq -- ala 2.4
  o [ACPI] revert two fixes in preparation for ACPICA merge
  o [ACPI] update Linux to ACPICA 20031029 (Bob Moore)
  o [ACPI] Update Linux to ACPICA 20031203 (Bob Moore)
  o [ACPI] delete old _TRA code formerly used just by IA64. (Bjorn
    Helgaas) The current approach is to walk the _CRS in
    pcibios_scan_root() using acpi_walk_resources().
  o [ACPI] /proc/acpi files appear in /proc if acpi=off (Shaohua David
    Li)
  o [ACPI] set acpi_disabled=1 on failure for clean /proc
    http://bugzilla.kernel.org/show_bug.cgi?id=991
  o [ACPI] change hard-coded IO width to programmable width
    http://bugzilla.kernel.org/show_bug.cgi?id=1349 from David Shaohua
    Li and Venatesh Pallipadi
  o [ACPI] ACPICA 20040116 from Bob Moore
  o [ACPI] acpi_bus_add() ignored _STA's return value from Bjorn
    Helgaas
  o [ACPI] fix ACPI spec URL in comment - from Randy Dunlap
  o [ACPI] on SCI allocation failure, don't mistakenly free IRQ0 from
    Jes Sorensen
  o [ACPI] move zero initialized data to .bss from Jes Sorensen
  o [ACPI] handle system with NULL DSDT and valid XDSDT from ia64 via
    Alex Williamson

Linda Xie:
  o PCI Hotplug: add unlimited PHP slot name lengths support

Linus Torvalds:
  o Move exception table sorting much earlier
  o Fix sha256 padding block initializer to be static
  o Linux 2.6.2-rc3

Marcelo Tosatti:
  o PC300 update

Mark M. Hoffman:
  o I2C: i2c-piix4.c bugfix

Martin Hicks:
  o ia64: add platform_timer_interrupt() hook
  o ia64: remove old sn1 machvec header file
  o Remove sn2 debug printk
  o PCI Hotplug: Trivial warning fix

Matthew Chapman:
  o ia64: Fix ptrace infrastructure some more so that strace'd
    sigreturn() works without trashing any registers.

Matthew Dobson:
  o PCI: add pci_bus sysfs class

Matthew Wilcox:
  o PCI Hotplug: Better reporting of PCI frequency / bus mode problems
    for acpi driver
  o PCI: add pci_get_slot() function
  o PCI: fix pci_get_slot() bug

Michael Hunold:
  o dvb subsystem and saa7146 v4l fixes

Michael Schierl:
  o [APM] Is this the correct way to fix suspend bug introduced

Nathan Scott:
  o [XFS] Fix a warning from some gcc variants after recent flags botch
  o [XFS] Revert botched merge where KM_NOFS check was unintentionally
    dropped
  o [XFS] Add the security extended attributes namespace
  o [XFS] Remove no-longer-needed debug symbol exports
  o [XFS] Sync up some missing header updates from local XFS tree

Oliver Neukum:
  o USB: fix whiteheat doing DMA to stack
  o USB: fix dma to stack in ti driver

Ralf Bächle:
  o PCI: fix probing for some mips systems

Rolf Eike Beer:
  o PCI Hotplug: Fixup pcihp_skeleton.c

Russell Cattelan:
  o [XFS] Christoph has signed over copyrights
  o [XFS] Move bits around to better manage common code.  No functional
    change

Russell King:
  o Prevent PCI driver registration failure oopsing
  o [ARM] Eliminate tsk->used_math
  o [ARM] Fix bitops pointer qualifiers
  o [ARM] Add comments for newish functions in cacheflush.h
  o [ARM] Remove FP work-arounds

Stéphane Eranian:
  o ia64: fix icc compilation

Suresh B. Siddha:
  o ia64: replace inline assembly in sn2 code

Takayoshi Kochi:
  o PCI Hotplug: add address file and fix acpiphp bugs

