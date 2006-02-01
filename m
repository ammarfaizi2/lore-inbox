Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWBACEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWBACEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWBACEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:04:42 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:30443
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964853AbWBACEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:04:41 -0500
Date: Tue, 31 Jan 2006 18:04:37 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.16-rc1
Message-ID: <20060201020437.GA20719@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some small PCI patches against your latest git tree.  They have
all been in the -mm tree for a while with no problems.

They do the following:
	- document some feature-removal things for the future
	- add support for amd pci hotplug devices to the shpchp driver.
	- fix bugs and update the ppc64 rpaphp pci hotplug driver.
	- add some new and remove some duplicate pci ids.
	- make it more obvious that some msi functions are really being
	  used.
	- fix a bug on some boxes that have bogus MCFG tables.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h


 Documentation/feature-removal-schedule.txt |   14 +
 arch/i386/pci/irq.c                        |    5 
 arch/i386/pci/mmconfig.c                   |   15 +
 arch/x86_64/pci/mmconfig.c                 |   19 +
 drivers/pci/hotplug/Kconfig                |    3 
 drivers/pci/hotplug/acpiphp_ibm.c          |   21 --
 drivers/pci/hotplug/ibmphp_core.c          |    4 
 drivers/pci/hotplug/rpadlpar_core.c        |   64 +++---
 drivers/pci/hotplug/rpaphp.h               |   14 -
 drivers/pci/hotplug/rpaphp_core.c          |  114 ++++++-----
 drivers/pci/hotplug/rpaphp_pci.c           |  277 +----------------------------
 drivers/pci/hotplug/rpaphp_slot.c          |   16 -
 drivers/pci/hotplug/shpchp.h               |   94 +++++++++
 drivers/pci/hotplug/shpchp_ctrl.c          |   12 +
 drivers/pci/msi.c                          |    8 
 drivers/pci/msi.h                          |    6 
 drivers/pci/pci.c                          |    2 
 drivers/pci/setup-res.c                    |    1 
 drivers/video/cyblafb.c                    |    1 
 include/linux/pci.h                        |    2 
 include/linux/pci_ids.h                    |   16 -
 21 files changed, 299 insertions(+), 409 deletions(-)


Adrian Bunk:
      PCI: schedule PCI_LEGACY_PROC for removal
      PCI: drivers/pci/pci.c: #if 0 pci_find_ext_capability()

Andi Kleen:
      PCI: handle bogus MCFG entries

Arthur Othieno:
      PCI: cyblafb: remove pci_module_init() return, really.

Grant Coady:
      PCI: pci_ids: remove duplicates gathered during merge period

Grant Grundler:
      PCI: make it easier to see that set_msi_affinity() is used

Jason Gaston:
      PCI: irq and pci_ids: patch for Intel ICH8

Keck, David:
      PCI Hotplug: shpchp: AMD POGO errata fix

linas:
      PCI Hotplug: PCI panic on dlpar add (add pci slot to running partition)
      PCI Hotplug/powerpc: module build break

linas@austin.ibm.com:
      powerpc/PCI hotplug: remove rpaphp_find_bus()
      powerpc/PCI hotplug: merge config_pci_adapter
      powerpc/PCI hotplug: remove remove_bus_device()
      powerpc/PCI hotplug: de-convolute rpaphp_unconfig_pci_adap
      powerpc/PCI hotplug: remove rpaphp_fixup_new_pci_devices()
      powerpc/PCI hotplug: shuffle error checking to better location.
      powerpc/PCI hotplug: minor cleanup forward decls
      powerpc/PCI hotplug: merge rpaphp_enable_pci_slot()
      powerpc/PCI hotplug: cleanup: add prefix

Mark Rustad:
      PCI: restore 2 missing pci ids

Pavel Machek:
      PCI Hotplug: fix up coding style issues
      PCI Hotplug: fix up Kconfig help text

Richard Knutsson:
      pci: Schedule removal of pci_module_init

