Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVF1Fbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVF1Fbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVF1Fbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:31:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:3050 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261274AbVF1Fah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:30:37 -0400
Date: Mon, 27 Jun 2005 22:30:22 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.12
Message-ID: <20050628053022.GA1588@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of PCI patches against your latest git tree, and even a
merge (hey, it was my first, I was happy it all worked out ok...).  They
include:
	- acpi pci hotplug driver updates and reworks.
	- dma bursting help for drivers
	- msi minor cleanups
	- MCFG acpi table parsing for pci busses

All of these patches have been in the -mm tree for the past few months.
I have not included any of the pci patches in the -mm tree that were
causing people problems.  Those are still being worked on to get
correct.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-kernel and linux-pci mailing
lists, if anyone wants to see them.

thanks,

greg k-h


 Documentation/kernel-parameters.txt |    4 
 arch/i386/kernel/acpi/boot.c        |   57 +-
 arch/i386/pci/common.c              |    8 
 arch/i386/pci/irq.c                 |   51 +-
 arch/i386/pci/legacy.c              |    2 
 arch/i386/pci/mmconfig.c            |   41 +
 arch/i386/pci/numa.c                |    2 
 arch/i386/pci/pci.h                 |    1 
 arch/ia64/kernel/acpi.c             |   38 +
 arch/ia64/kernel/iosapic.c          |  134 ++++-
 arch/ia64/pci/pci.c                 |   38 +
 arch/ppc/kernel/pci.c               |   21 
 arch/ppc64/kernel/pci.c             |   22 
 arch/x86_64/pci/mmconfig.c          |   74 ++
 drivers/acpi/container.c            |    2 
 drivers/acpi/pci_bind.c             |   27 -
 drivers/acpi/pci_root.c             |   24 
 drivers/acpi/processor_core.c       |    2 
 drivers/acpi/scan.c                 |  126 ++++-
 drivers/char/moxa.c                 |    2 
 drivers/char/rio/rio_linux.c        |    4 
 drivers/message/fusion/mptfc.c      |    4 
 drivers/message/fusion/mptscsih.c   |   10 
 drivers/message/fusion/mptscsih.h   |    2 
 drivers/message/fusion/mptspi.c     |    4 
 drivers/net/e100.c                  |    9 
 drivers/net/via-rhine.c             |   11 
 drivers/parisc/dino.c               |    1 
 drivers/parisc/lba_pci.c            |    2 
 drivers/pci/bus.c                   |   11 
 drivers/pci/hotplug/Makefile        |    4 
 drivers/pci/hotplug/acpiphp.h       |   47 -
 drivers/pci/hotplug/acpiphp_core.c  |    9 
 drivers/pci/hotplug/acpiphp_glue.c  |  900 ++++++++++++++++++++----------------
 drivers/pci/hotplug/acpiphp_pci.c   |  449 -----------------
 drivers/pci/hotplug/acpiphp_res.c   |  700 ----------------------------
 drivers/pci/hotplug/cpqphp_core.c   |    5 
 drivers/pci/msi.c                   |   88 +--
 drivers/pci/msi.h                   |    9 
 drivers/pci/pci-sysfs.c             |   26 -
 drivers/pci/probe.c                 |   29 -
 drivers/pci/proc.c                  |   14 
 drivers/pci/remove.c                |   14 
 drivers/pci/setup-bus.c             |    5 
 drivers/scsi/3w-9xxx.c              |    8 
 drivers/scsi/3w-xxxx.c              |    8 
 drivers/scsi/ipr.c                  |   10 
 drivers/scsi/megaraid.c             |    8 
 include/acpi/acpi_bus.h             |   17 
 include/acpi/acpi_drivers.h         |    1 
 include/asm-alpha/pci.h             |   19 
 include/asm-arm/pci.h               |   10 
 include/asm-frv/pci.h               |   10 
 include/asm-i386/pci.h              |   10 
 include/asm-ia64/iosapic.h          |   12 
 include/asm-ia64/pci.h              |   19 
 include/asm-mips/pci.h              |   10 
 include/asm-parisc/pci.h            |   19 
 include/asm-ppc/pci.h               |   16 
 include/asm-ppc64/pci.h             |   26 +
 include/asm-sh/pci.h                |   10 
 include/asm-sh64/pci.h              |   10 
 include/asm-sparc/pci.h             |   10 
 include/asm-sparc64/pci.h           |   19 
 include/asm-v850/pci.h              |   10 
 include/asm-x86_64/pci.h            |   10 
 include/linux/acpi.h                |   19 
 include/linux/pci.h                 |   33 +
 include/linux/pci_ids.h             |    2 
 69 files changed, 1509 insertions(+), 1850 deletions(-)

---------------

Amit Gud:
  pci: remove deprecates
  pci: remove deprecates

Andrew Morton:
  PCI: fix up errors after dma bursting patch and CONFIG_PCI=n

David S. Miller:
  PCI: DMA bursting advice

Greg Kroah-Hartman:
  PCI: use the MCFG table to properly access pci devices (x86-64)
  PCI: use the MCFG table to properly access pci devices (i386)
  PCI: make drivers use the pci shutdown callback instead of the driver core callback.
  PCI: add proper MCFG table parsing to ACPI core.
  PCI: clean up the MSI code a bit.

jayalk@intworks.biz:
  PCI Allow OutOfRange PIRQ table address

Keith Moore:
  cpqphp: fix oops during unload without probe

Kenji Kaneshige:
  ACPI based I/O APIC hot-plug: acpiphp support
  ACPI based I/O APIC hot-plug: add interfaces
  ACPI based I/O APIC hot-plug: ia64 support

Michael Ellerman:
  PCI: fix-pci-mmap-on-ppc-and-ppc64.patch

Rajesh Shah:
  acpi hotplug: aCPI based root bridge hot-add
  acpi hotplug: decouple slot power state changes from physical hotplug
  acpi hotplug: fix slot power-down problem with acpiphp
  acpi bridge hotadd: Export the interface to get PCI id for an ACPI handle
  acpi hotplug: convert acpiphp to use generic resource code
  acpi bridge hotadd: Allow ACPI .add and .start operations to be done independently
  acpi hotplug: clean up notify handlers on acpiphp unload
  acpi bridge hotadd: Read bridge resources when fixing up the bus
  acpi bridge hotadd: Remove hot-plugged devices that could not be allocated resources
  acpi bridge hotadd: Make the PCI remove routines safe for failed hot-plug
  acpi bridge hotadd: Take the PCI lock when modifying pci bus or device lists
  acpi bridge hotadd: Prevent duplicate bus numbers when scanning PCI bridge
  acpi bridge hotadd: Link newly created pci child bus to its parent on creation
  acpi bridge hotadd: Fix pci_enable_device() for p2p bridges
  acpi bridge hotadd: ACPI based root bridge hot-add
  acpi bridge hotadd: Make pcibios_fixup_bus() hot-plug safe

