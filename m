Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162195AbWLAXQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162195AbWLAXQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162216AbWLAXQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:16:36 -0500
Received: from cantor2.suse.de ([195.135.220.15]:2284 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162195AbWLAXQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:16:35 -0500
Date: Fri, 1 Dec 2006 15:16:24 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: [GIT PATCH] PCI patches for 2.6.19
Message-ID: <20061201231624.GA7552@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI patches for 2.6.19

They contain a number of PCI hotplug driver fixes and changes, and some
other stuff that is detailed below.

All of these patches have been in the -mm tree for a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h

 arch/i386/kernel/pci-dma.c              |    4 +-
 arch/i386/pci/common.c                  |    2 +-
 arch/i386/pci/fixup.c                   |   46 ---
 arch/i386/pci/i386.c                    |   64 ++-
 arch/i386/pci/irq.c                     |    6 +
 arch/ia64/pci/pci.c                     |   75 ++---
 arch/ia64/sn/kernel/Makefile            |    5 +-
 arch/ia64/sn/kernel/io_acpi_init.c      |  231 +++++++++++
 arch/ia64/sn/kernel/io_common.c         |  613 ++++++++++++++++++++++++++++++
 arch/ia64/sn/kernel/io_init.c           |  633 +++++--------------------------
 arch/ia64/sn/kernel/iomv.c              |   11 +-
 arch/ia64/sn/kernel/setup.c             |   18 +
 arch/ia64/sn/kernel/tiocx.c             |    2 +-
 arch/ia64/sn/pci/pcibr/pcibr_provider.c |   17 +-
 arch/ia64/sn/pci/tioce_provider.c       |   18 -
 arch/powerpc/platforms/powermac/pci.c   |    1 -
 arch/sparc64/kernel/pci.c               |    9 -
 drivers/i2c/busses/Kconfig              |    1 +
 drivers/i2c/busses/i2c-i801.c           |    2 +
 drivers/message/i2o/pci.c               |   15 +-
 drivers/pci/Kconfig                     |    2 +-
 drivers/pci/access.c                    |   75 +++--
 drivers/pci/hotplug/acpiphp.h           |    4 +-
 drivers/pci/hotplug/acpiphp_core.c      |   39 +--
 drivers/pci/hotplug/acpiphp_glue.c      |    8 +-
 drivers/pci/hotplug/ibmphp_pci.c        |    4 +-
 drivers/pci/hotplug/pciehp_core.c       |    7 +-
 drivers/pci/hotplug/pciehp_hpc.c        |    2 -
 drivers/pci/hotplug/rpadlpar_core.c     |    2 +-
 drivers/pci/hotplug/rpaphp_core.c       |    2 +-
 drivers/pci/hotplug/sgi_hotplug.c       |   35 +-
 drivers/pci/msi.h                       |    8 -
 drivers/pci/pci-acpi.c                  |   10 +-
 drivers/pci/pci-driver.c                |   11 +-
 drivers/pci/pci-sysfs.c                 |   33 +-
 drivers/pci/pci.c                       |  123 +++++-
 drivers/pci/pci.h                       |    1 +
 drivers/pci/probe.c                     |   27 ++
 drivers/pci/quirks.c                    |   59 +---
 drivers/pci/rom.c                       |    9 +-
 include/asm-ia64/io.h                   |    2 +-
 include/asm-ia64/machvec.h              |   12 +
 include/asm-ia64/machvec_sn2.h          |    2 +
 include/asm-ia64/pci.h                  |   21 +-
 include/asm-ia64/sn/acpi.h              |   16 +
 include/asm-ia64/sn/pcidev.h            |   22 +-
 include/asm-ia64/sn/sn_feature_sets.h   |    6 +
 include/asm-ia64/sn/sn_sal.h            |    1 +
 include/asm-powerpc/pci.h               |   20 +-
 include/asm-sparc64/pci.h               |    6 +-
 include/linux/ioport.h                  |    1 +
 include/linux/pci.h                     |    3 +-
 include/linux/pci_ids.h                 |    7 +
 include/linux/pci_regs.h                |    6 +
 54 files changed, 1400 insertions(+), 959 deletions(-)
 create mode 100644 arch/ia64/sn/kernel/io_acpi_init.c
 create mode 100644 arch/ia64/sn/kernel/io_common.c
 create mode 100644 include/asm-ia64/sn/acpi.h

---------------

Adrian Bunk (2):
      PCI: ibmphp_pci.c: fix NULL dereference
      PCI: make arch/i386/pci/common.c:pci_bf_sort static

Akinobu Mita (3):
      acpiphp: fix use of list_for_each macro
      acpiphp: fix missing acpiphp_glue_exit()
      pci: fix __pci_register_driver error handling

Alan Cox (1):
      PCI: quirks: fix the festering mess that claims to handle IDE quirks

Amol Lad (1):
      PCI: arch/i386/kernel/pci-dma.c: ioremap balanced with iounmap

Greg Kroah-Hartman (1):
      PCI: Let PCI_MULTITHREAD_PROBE not be broken

Inaky Perez-Gonzalez (2):
      PCI: switch pci_{enable,disable}_device() to be nestable
      PCI: pci_{enable,disable}_device() nestable ports

Jason Gaston (2):
      PCI: irq: irq and pci_ids patch for Intel ICH9
      i2c-i801: SMBus patch for Intel ICH9

John Keller (3):
      Altix: Add initial ACPI IO support
      Altix: SN ACPI hotplug support.
      Altix: Initial ACPI support - ROM shadowing.

John Rose (1):
      PCI: rpaphp: change device tree examination

Kenji Kaneshige (2):
      pciehp: remove unnecessary free_irq
      pciehp: remove unnecessary pci_disable_msi

Kristen Carlson Accardi (1):
      pci: clear osc support flags if no _OSC method

Matthew Wilcox (5):
      PCI: Use pci_generic_prep_mwi on ia64
      PCI: Use pci_generic_prep_mwi on sparc64
      PCI: Replace HAVE_ARCH_PCI_MWI with PCI_DISABLE_MWI
      PCI: Delete unused extern in powermac/pci.c
      PCI: Block on access to temporarily unavailable pci device

Michael Ellerman (1):
      PCI: Make some MSI-X #defines generic

Randy Dunlap (1):
      pci/i386: style cleanups

Rolf Eike Beer (1):
      PCI: Change memory allocation for acpiphp slots

Stephen Hemminger (1):
      PCI: save/restore PCI-X state

