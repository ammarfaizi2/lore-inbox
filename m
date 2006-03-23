Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWCWWkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWCWWkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWCWWkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:40:39 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:62108
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932539AbWCWWki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:40:38 -0500
Date: Thu, 23 Mar 2006 14:40:15 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI and PCI Hotplug patches for 2.6.16
Message-ID: <20060323224015.GA32055@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI and PCI Hotplug patches against your latest git tree.
They have all been in the -mm tree for a while with no problems.

They do the following:
	- lots of pci hotplug reworks and fixes.  It seems that people
	  have finally started caring about these drivers in their quest
	  to get both laptop docking stations and large systems working
	  properly.
	- MSI cleanups (the recent MSI reworks are not here, as they
	  came in to late to make this merge...)  There's an outstanding
	  MSI suspend/resume patch that I had to pull at the last
	  minute, but will be reworking for the next round.
	- lots of various bug fixes.
	- new boot paramater to disable MSI entirely.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h


 Documentation/feature-removal-schedule.txt |    7 
 Documentation/kernel-parameters.txt        |    4 
 arch/i386/kernel/efi.c                     |    2 
 arch/i386/kernel/setup.c                   |   22 
 arch/i386/pci/Makefile                     |    2 
 arch/i386/pci/common.c                     |   32 +
 arch/i386/pci/direct.c                     |   15 
 arch/i386/pci/init.c                       |   25 
 arch/i386/pci/mmconfig.c                   |   11 
 arch/i386/pci/pcbios.c                     |    4 
 arch/i386/pci/pci.h                        |    3 
 arch/x86_64/pci/Makefile                   |    3 
 drivers/acpi/Kconfig                       |   12 
 drivers/acpi/ibm_acpi.c                    |   13 
 drivers/acpi/scan.c                        |    5 
 drivers/pci/Kconfig                        |   21 
 drivers/pci/hotplug/Makefile               |   20 
 drivers/pci/hotplug/acpi_pcihp.c           |  211 +++++++
 drivers/pci/hotplug/acpiphp.h              |   62 +-
 drivers/pci/hotplug/acpiphp_core.c         |  132 ++--
 drivers/pci/hotplug/acpiphp_dock.c         |  438 +++++++++++++++
 drivers/pci/hotplug/acpiphp_glue.c         |  356 +++++++-----
 drivers/pci/hotplug/cpci_hotplug_core.c    |    9 
 drivers/pci/hotplug/cpqphp.h               |    3 
 drivers/pci/hotplug/cpqphp_core.c          |   27 
 drivers/pci/hotplug/cpqphp_ctrl.c          |  124 +---
 drivers/pci/hotplug/fakephp.c              |    9 
 drivers/pci/hotplug/ibmphp.h               |    2 
 drivers/pci/hotplug/ibmphp_core.c          |   10 
 drivers/pci/hotplug/ibmphp_ebda.c          |   59 --
 drivers/pci/hotplug/ibmphp_hpc.c           |   64 +-
 drivers/pci/hotplug/ibmphp_pci.c           |  121 +---
 drivers/pci/hotplug/ibmphp_res.c           |   81 +-
 drivers/pci/hotplug/pci_hotplug.h          |   16 
 drivers/pci/hotplug/pciehp.h               |   27 
 drivers/pci/hotplug/pciehp_core.c          |   19 
 drivers/pci/hotplug/pciehp_ctrl.c          |   68 +-
 drivers/pci/hotplug/pciehp_hpc.c           |   77 ++
 drivers/pci/hotplug/pciehprm_acpi.c        |  257 ---------
 drivers/pci/hotplug/pciehprm_nonacpi.c     |   47 -
 drivers/pci/hotplug/pcihp_skeleton.c       |   33 -
 drivers/pci/hotplug/rpaphp_slot.c          |    9 
 drivers/pci/hotplug/sgi_hotplug.c          |   16 
 drivers/pci/hotplug/shpchp.h               |  108 +--
 drivers/pci/hotplug/shpchp_core.c          |  331 ++++-------
 drivers/pci/hotplug/shpchp_ctrl.c          |  806 ++++++++++-------------------
 drivers/pci/hotplug/shpchp_hpc.c           |  518 ++++++------------
 drivers/pci/hotplug/shpchp_pci.c           |   10 
 drivers/pci/hotplug/shpchprm_acpi.c        |  186 ------
 drivers/pci/hotplug/shpchprm_legacy.c      |   54 -
 drivers/pci/hotplug/shpchprm_nonacpi.c     |   57 --
 drivers/pci/msi.c                          |  105 ++-
 drivers/pci/pci-driver.c                   |   12 
 drivers/pci/pci-sysfs.c                    |    3 
 drivers/pci/pci.c                          |   22 
 drivers/pci/pci.h                          |    2 
 drivers/pci/pcie/portdrv.h                 |    1 
 drivers/pci/pcie/portdrv_core.c            |    3 
 drivers/pci/pcie/portdrv_pci.c             |   66 --
 drivers/pci/probe.c                        |   34 -
 drivers/pci/proc.c                         |  126 ----
 drivers/pci/quirks.c                       |   71 ++
 drivers/pci/search.c                       |    4 
 include/acpi/acpi_bus.h                    |    1 
 include/linux/pci.h                        |   12 
 65 files changed, 2322 insertions(+), 2688 deletions(-)

---------------

Adrian Bunk:
      PCI: cpqphp_ctrl.c: board_replaced(): remove dead code
      PCI: the scheduled removal of PCI_LEGACY_PROC

Alan Stern:
      PCI: Move pci_dev_put outside a spinlock

Andi Kleen:
      PCI: Give PCI config access initialization a defined ordering

Bauke Jan Douma:
      PCI: quirk for asus a8v and a8v delux motherboards

Bernhard Kaindl:
      PCI: PCI/Cardbus cards hidden, needs pci=assign-busses to fix

Brian Gerst:
      PCI: Add pci_device_shutdown to pci_bus_type

Eric Sesterhenn:
      PCI: kzalloc() conversion in drivers/pci

Grant Grundler:
      PCI: clean up msi.c a bit
      PCI: fix problems with MSI-X on ia64

Ingo Molnar:
      PCI hotplug: convert semaphores to mutex

Jeff Garzik:
      PCI: fix pci_request_region[s] arg

John Keller:
      PCI Hotplug: SN: Fix cleanup on hotplug removal of PPB

Kenji Kaneshige:
      shpchp - cleanup init_slots()
      shpchp - cleanup shpchp_core.c
      shpchp - cleanup slot list
      shpchp - cleanup controller list
      shpchp - cleanup check command status
      shpchp - bugfix: add missing serialization
      pcihp_skeleton.c cleanup
      shpchp - replace kmalloc() with kzalloc() and cleanup arg of sizeof()
      shpchp - removed unncessary 'magic' member from slot
      shpchp - move slot name into struct slot
      shpchp - Fix incorrect return value of interrupt handler
      shpchp: Remove unused pci_bus member from controller structure
      shpchp: Remove unused wait_for_ctrl_irq
      shpchp: event handling rework
      shpchp: Fix slot state handling
      shpchp: adapt to pci driver model
      shpchp: cleanup bus speed handling
      acpiphp: Scan slots under the nested P2P bridge

Kristen Accardi:
      PCI: return max reserved busnr
      PCI: really fix parent's subordinate busnr
      PCI: quirk for IBM Dock II cardbus controllers
      acpiphp: add new bus to acpi
      acpi: export acpi_bus_trim
      acpiphp: add dock event handling
      acpi: remove dock event handling from ibm_acpi
      PCI Hotplug: add common acpi functions to core
      ibmphp: remove TRUE and FALSE

Linus Torvalds:
      PCI: resource address mismatch

Matthew Wilcox:
      PCI: Provide a boot parameter to disable MSI

Michael S. Tsirkin:
      PCI: make MSI quirk inheritable from the pci bus

MUNEDA Takahiro:
      acpiphp - slot management fix - V4
      acpiphp: fix bridge handle
      acpiphp: fix acpi_path_name

Ralf Baechle:
      PCI: Avoid leaving MASTER_ABORT disabled permanently when returning from pci_scan_bridge.

Shaohua Li:
      PCI: remove msi save/restore code in specific driver

tomek@koprowski.org:
      PCI: SMBus unhide on HP Compaq nx6110

