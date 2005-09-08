Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVIHW1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVIHW1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVIHW1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:27:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:46785 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965063AbVIHW1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:27:15 -0400
Date: Thu, 8 Sep 2005 15:25:53 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.13
Message-ID: <20050908222553.GA6847@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI patches against your latest git tree.  All of these
have been in the -mm tree for a while.  They do the following major
things:
	- remove the pci ids database, finally
	- some pci hotplug driver fixes
	- clean up pci.h to be a bit smaller
	- add compiler warnings if you don't check the return value of
	  some pci api functions.
	- other minor fixes.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing lists, if anyone
wants to see them.

thanks,

greg k-h


 Documentation/feature-removal-schedule.txt |    9 
 MAINTAINERS                                |    7 
 arch/alpha/kernel/sys_marvel.c             |    5 
 arch/i386/pci/i386.c                       |    6 
 arch/ppc/kernel/pci.c                      |    1 
 arch/ppc64/kernel/eeh.c                    |   31 
 arch/ppc64/kernel/iSeries_VpdInfo.c        |    5 
 arch/ppc64/kernel/pci.c                    |    1 
 arch/sparc64/kernel/pci.c                  |  139 
 arch/sparc64/kernel/pci_psycho.c           |   34 
 arch/sparc64/kernel/pci_sabre.c            |   36 
 arch/sparc64/kernel/pci_schizo.c           |   48 
 drivers/char/drm/drmP.h                    |    4 
 drivers/infiniband/hw/mthca/mthca_main.c   |    8 
 drivers/infiniband/hw/mthca/mthca_reset.c  |    8 
 drivers/net/irda/vlsi_ir.h                 |    6 
 drivers/parport/parport_pc.c               |    2 
 drivers/pci/Kconfig                        |   17 
 drivers/pci/Makefile                       |   24 
 drivers/pci/bus.c                          |   51 
 drivers/pci/gen-devlist.c                  |  132 
 drivers/pci/hotplug/Makefile               |    3 
 drivers/pci/hotplug/pciehp.h               |    2 
 drivers/pci/hotplug/rpadlpar_core.c        |  355 -
 drivers/pci/hotplug/rpaphp.h               |   37 
 drivers/pci/hotplug/rpaphp_core.c          |  144 
 drivers/pci/hotplug/rpaphp_pci.c           |  373 -
 drivers/pci/hotplug/rpaphp_slot.c          |   66 
 drivers/pci/hotplug/rpaphp_vio.c           |  129 
 drivers/pci/hotplug/sgi_hotplug.c          |  195 
 drivers/pci/hotplug/shpchp.h               |    2 
 drivers/pci/msi.c                          |   10 
 drivers/pci/names.c                        |  137 
 drivers/pci/pci-driver.c                   |   37 
 drivers/pci/pci.c                          |  106 
 drivers/pci/pci.ids                        |10180 -----------------------------
 drivers/pci/pcie/portdrv_pci.c             |    8 
 drivers/pci/probe.c                        |    4 
 drivers/pci/proc.c                         |   12 
 drivers/pci/quirks.c                       |    7 
 drivers/pci/setup-res.c                    |    7 
 drivers/scsi/ahci.c                        |   16 
 drivers/scsi/ata_piix.c                    |   14 
 drivers/scsi/sata_sis.c                    |   14 
 drivers/scsi/sata_uli.c                    |   14 
 drivers/usb/core/hcd-pci.c                 |   28 
 drivers/usb/host/ehci-hcd.c                |    4 
 drivers/video/nvidia/nvidia.c              |    4 
 drivers/video/riva/fbdev.c                 |    4 
 include/asm-alpha/pci.h                    |   13 
 include/asm-arm/pci.h                      |   13 
 include/asm-generic/pci.h                  |   13 
 include/asm-ia64/pci.h                     |   13 
 include/asm-parisc/pci.h                   |   13 
 include/asm-ppc/pci.h                      |   13 
 include/asm-ppc64/pci.h                    |   13 
 include/asm-sparc64/pci.h                  |    2 
 include/linux/mempolicy.h                  |    1 
 include/linux/pci.h                        |  511 -
 include/linux/pci_regs.h                   |  448 +
 mm/mempolicy.c                             |    2 
 61 files changed, 1379 insertions(+), 12162 deletions(-)

----------------

Adrian Bunk:
  PCI: remove CONFIG_PCI_NAMES

Alan Stern:
  PCI: Fix regression in pci_enable_device_bars

Andi Kleen:
  PCI: Run PCI driver initialization on local node

Andrew Morton:
  PCI: Move PCI fixup data into r/o section
  PCI: fix up pretty-names removal patch

Brett M Russ:
  PCI/libata INTx cleanup

Daniel Ritz:
  PCI: Support PCM PM CAP version 3

David S. Miller:
  Make sparc64 use setup-res.c

Greg Kroah-Hartman:
  PCI: clean up pci.h and split pci register info to separate header file.
  PCI: start paying attention to a lot of pci function return values

Jiri Slaby:
  PCI: remove pci_find_device from parport_pc.c

John Rose:
  PCI Hotplug: rpaphp: Move VIO registration
  PCI Hotplug: rpaphp: Change slot pci reference
  PCI Hotplug: rpaphp: Remove unused stuff
  PCI Hotplug: rpaphp: Remove rpaphp_find_pci
  PCI Hotplug: rpaphp: Purify hotplug
  PCI Hotplug: rpaphp: Export slot enable

John W. Linville:
  PCI: restore BAR values after D3hot->D0 for devices that need it

Kristen Accardi:
  PCI Hotplug: use bus_slot number for name

Michael S. Tsirkin:
  arch/386/pci: remap_pfn_range -> io_remap_pfn_range

Paul Mackerras:
  PCI: Add pci_walk_bus function to PCI core (nonrecursive)

Prarit Bhargava:
  PCI Hotplug: SGI hotplug driver fixes

