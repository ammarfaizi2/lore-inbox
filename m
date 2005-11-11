Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVKKAYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVKKAYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKKAYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:24:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:47556 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932286AbVKKAYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:24:19 -0500
Date: Thu, 10 Nov 2005 16:23:35 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] More PCI patches for 2.6.14
Message-ID: <20051111002334.GA7496@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more PCI patches against your latest git tree.  They have
all been in the -mm tree for a while with no problems.

Big thing here is a huge cleanup of the pciehp driver, and the removal
of the .owner field in the pci_driver structure.  The .owner field in
the struct driver portion of the pci_driver structure is now
automatically set properly for all drivers.  This keeps the network
driver authors happy as nothing changes for the pci driver api at all.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing lists, if anyone
wants to see them.

thanks,

greg k-h

 arch/i386/pci/fixup.c                    |    3 
 arch/ppc/kernel/pci.c                    |   14 
 drivers/acpi/glue.c                      |    1 
 drivers/char/agp/ali-agp.c               |    1 
 drivers/char/agp/amd-k7-agp.c            |    1 
 drivers/char/agp/amd64-agp.c             |    1 
 drivers/char/agp/ati-agp.c               |    1 
 drivers/char/agp/efficeon-agp.c          |    1 
 drivers/char/agp/i460-agp.c              |    1 
 drivers/char/agp/intel-agp.c             |    1 
 drivers/char/agp/nvidia-agp.c            |    1 
 drivers/char/agp/sis-agp.c               |    1 
 drivers/char/agp/sworks-agp.c            |    1 
 drivers/char/agp/uninorth-agp.c          |    1 
 drivers/char/agp/via-agp.c               |    1 
 drivers/char/epca.c                      |    1 
 drivers/char/synclink.c                  |    1 
 drivers/char/synclinkmp.c                |    1 
 drivers/char/watchdog/pcwd_pci.c         |    1 
 drivers/char/watchdog/wdt_pci.c          |    1 
 drivers/i2c/busses/i2c-ali1535.c         |    1 
 drivers/i2c/busses/i2c-ali1563.c         |    1 
 drivers/i2c/busses/i2c-ali15x3.c         |    1 
 drivers/i2c/busses/i2c-amd756.c          |    1 
 drivers/i2c/busses/i2c-amd8111.c         |    1 
 drivers/i2c/busses/i2c-hydra.c           |    1 
 drivers/i2c/busses/i2c-i801.c            |    1 
 drivers/i2c/busses/i2c-i810.c            |    1 
 drivers/i2c/busses/i2c-nforce2.c         |    1 
 drivers/i2c/busses/i2c-piix4.c           |    1 
 drivers/i2c/busses/i2c-prosavage.c       |    1 
 drivers/i2c/busses/i2c-savage4.c         |    1 
 drivers/i2c/busses/i2c-sis5595.c         |    1 
 drivers/i2c/busses/i2c-sis630.c          |    1 
 drivers/i2c/busses/i2c-sis96x.c          |    1 
 drivers/i2c/busses/i2c-via.c             |    1 
 drivers/i2c/busses/i2c-viapro.c          |    1 
 drivers/i2c/busses/i2c-voodoo3.c         |    1 
 drivers/ide/setup-pci.c                  |   12 
 drivers/infiniband/hw/mthca/mthca_main.c |    1 
 drivers/net/spider_net.c                 |    1 
 drivers/pci/access.c                     |    2 
 drivers/pci/hotplug/pciehp.h             |  145 --
 drivers/pci/hotplug/pciehp_core.c        |  110 -
 drivers/pci/hotplug/pciehp_ctrl.c        | 2035 +------------------------------
 drivers/pci/hotplug/pciehp_hpc.c         |  121 -
 drivers/pci/hotplug/pciehp_pci.c         |  840 +-----------
 drivers/pci/hotplug/pciehprm.h           |   52 
 drivers/pci/hotplug/pciehprm_acpi.c      | 1789 ++-------------------------
 drivers/pci/hotplug/pciehprm_nonacpi.c   |  470 -------
 drivers/pci/hotplug/pciehprm_nonacpi.h   |   56 
 drivers/pci/hotplug/rpadlpar_core.c      |   79 -
 drivers/pci/hotplug/rpaphp.h             |    2 
 drivers/pci/hotplug/rpaphp_pci.c         |   76 -
 drivers/pci/hotplug/shpchp_pci.c         |    2 
 drivers/pci/msi.c                        |   20 
 drivers/pci/pci-acpi.c                   |   11 
 drivers/pci/pci-driver.c                 |   11 
 drivers/pci/pci.c                        |   46 
 drivers/pci/quirks.c                     |   19 
 drivers/usb/gadget/goku_udc.c            |    1 
 drivers/usb/gadget/net2280.c             |    1 
 drivers/usb/host/ehci-pci.c              |    1 
 drivers/usb/host/ohci-pci.c              |    1 
 drivers/usb/host/uhci-hcd.c              |    1 
 include/asm-i386/msi.h                   |    9 
 include/asm-i386/smp.h                   |    6 
 include/asm-ia64/msi.h                   |    3 
 include/asm-x86_64/msi.h                 |    4 
 include/asm-x86_64/smp.h                 |    6 
 include/linux/ide.h                      |    3 
 include/linux/pci-acpi.h                 |    5 
 include/linux/pci.h                      |   13 
 sound/pci/ad1889.c                       |    1 
 sound/pci/ali5451/ali5451.c              |    1 
 sound/pci/als4000.c                      |    1 
 sound/pci/atiixp.c                       |    1 
 sound/pci/atiixp_modem.c                 |    1 
 sound/pci/au88x0/au88x0.c                |    1 
 sound/pci/azt3328.c                      |    1 
 sound/pci/bt87x.c                        |    5 
 sound/pci/ca0106/ca0106_main.c           |    1 
 sound/pci/cmipci.c                       |    1 
 sound/pci/cs4281.c                       |    1 
 sound/pci/cs46xx/cs46xx.c                |    1 
 sound/pci/emu10k1/emu10k1.c              |    1 
 sound/pci/emu10k1/emu10k1x.c             |    1 
 sound/pci/ens1370.c                      |    1 
 sound/pci/es1938.c                       |    1 
 sound/pci/es1968.c                       |    1 
 sound/pci/fm801.c                        |    1 
 sound/pci/hda/hda_intel.c                |    1 
 sound/pci/ice1712/ice1712.c              |    1 
 sound/pci/ice1712/ice1724.c              |    1 
 sound/pci/intel8x0.c                     |    1 
 sound/pci/intel8x0m.c                    |    1 
 sound/pci/korg1212/korg1212.c            |    1 
 sound/pci/maestro3.c                     |    1 
 sound/pci/mixart/mixart.c                |    1 
 sound/pci/nm256/nm256.c                  |    1 
 sound/pci/rme32.c                        |    1 
 sound/pci/rme96.c                        |    1 
 sound/pci/rme9652/hdsp.c                 |    1 
 sound/pci/rme9652/hdspm.c                |    1 
 sound/pci/rme9652/rme9652.c              |    1 
 sound/pci/sonicvibes.c                   |    1 
 sound/pci/trident/trident.c              |    1 
 sound/pci/via82xx.c                      |    1 
 sound/pci/via82xx_modem.c                |    1 
 sound/pci/vx222/vx222.c                  |    1 
 sound/pci/ymfpci/ymfpci.c                |    1 
 111 files changed, 610 insertions(+), 5439 deletions(-)

----

Adrian Bunk:
      PCI: drivers/pci/: small cleanups

Ashok Raj:
      PCI: Change MSI to use physical delivery mode always

Grant Coady:
      pci_ids cleanup: fix two additional IDs in bt87x

Greg Kroah-Hartman:
      PCI: removed unneeded .owner field from struct pci_driver

Ivan Kokshaysky:
      PCI: NCR 53c810 quirk

Jesse Barnes:
      PCI: fix for Toshiba ohci1394 quirk

John Rose:
      dlpar regression for ppc64 - probe change

Laurent riffard:
      PCI: automatically set device_driver.owner

Meelis Roos:
      PCI: Fix VIA 686 PCI quirk names

Rajesh Shah:
      PCI: fix namespace clashes

rajesh.shah@intel.com:
      patch 1/8] pciehp: use the PCI core for hotplug resource management
      pciehp: reduce dependence on ACPI
      pciehp: remove redundant data structures
      pciehp: reduce debug message verbosity
      pciehp: request control of each hotplug controller individually
      pciehp: fix handling of power faults during hotplug
      pciehp: clean-up how we request control of hotplug hardware
      pciehp: miscellaneous cleanups

Randy Dunlap:
      pci-driver: store_new_id() not inline

Roland Dreier:
      PCI: add pci_find_next_capability()

