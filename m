Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422799AbWJRUHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422799AbWJRUHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWJRUGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:06:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:6373 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932131AbWJRUGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:06:44 -0400
Date: Wed, 18 Oct 2006 13:02:38 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: [GIT PATCH] PCI and PCI hotplug fixes for 2.6.19-rc2
Message-ID: <20061018200238.GA29443@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI and PCI hotplug patches for 2.6.19-rc2, and a single
PnP fix too.

Big things here include the ability to now build pci hotplug drivers
outside of the main kernel tree, and the change of the PCI Hotplug
subsystem maintainer to Kristen Carlson Accardi, as she has done such a
great job with it in the past.

All of these patches have been in the -mm tree for a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/MSI-HOWTO.txt                        |   63 ++++++++++++
 Documentation/kernel-parameters.txt                |    5 +
 MAINTAINERS                                        |    4 -
 arch/i386/pci/common.c                             |   59 +++++++++++
 arch/i386/pci/fixup.c                              |   45 ---------
 arch/i386/pci/pci.h                                |    7 +
 drivers/pci/hotplug/acpi_pcihp.c                   |    2 
 drivers/pci/hotplug/acpiphp.h                      |    2 
 drivers/pci/hotplug/acpiphp_core.c                 |    2 
 drivers/pci/hotplug/acpiphp_glue.c                 |    2 
 drivers/pci/hotplug/acpiphp_ibm.c                  |    1 
 drivers/pci/hotplug/cpci_hotplug_core.c            |    2 
 drivers/pci/hotplug/cpci_hotplug_pci.c             |    2 
 drivers/pci/hotplug/cpcihp_generic.c               |    4 -
 drivers/pci/hotplug/cpqphp.h                       |    1 
 drivers/pci/hotplug/cpqphp_core.c                  |    1 
 drivers/pci/hotplug/cpqphp_ctrl.c                  |    1 
 drivers/pci/hotplug/cpqphp_nvram.c                 |    1 
 drivers/pci/hotplug/cpqphp_pci.c                   |    1 
 drivers/pci/hotplug/cpqphp_sysfs.c                 |    1 
 drivers/pci/hotplug/fakephp.c                      |   13 ++-
 drivers/pci/hotplug/ibmphp.h                       |    2 
 drivers/pci/hotplug/pci_hotplug_core.c             |   11 +-
 drivers/pci/hotplug/pciehp.h                       |   11 +-
 drivers/pci/hotplug/pciehp_core.c                  |    6 +
 drivers/pci/hotplug/pciehp_ctrl.c                  |  104 +++++++++++---------
 drivers/pci/hotplug/pciehp_hpc.c                   |    2 
 drivers/pci/hotplug/pcihp_skeleton.c               |    2 
 drivers/pci/hotplug/rpadlpar_sysfs.c               |    2 
 drivers/pci/hotplug/rpaphp_core.c                  |    2 
 drivers/pci/hotplug/sgi_hotplug.c                  |    2 
 drivers/pci/hotplug/shpchp.h                       |    4 -
 drivers/pci/hotplug/shpchp_hpc.c                   |   82 ++++++++++------
 drivers/pci/msi.c                                  |   16 ++-
 drivers/pci/pcie/portdrv.h                         |    4 +
 drivers/pci/pcie/portdrv_core.c                    |    3 -
 drivers/pci/pcie/portdrv_pci.c                     |    2 
 drivers/pci/probe.c                                |   92 ++++++++++++++++++
 drivers/pci/quirks.c                               |   97 +++++++++++++++++--
 drivers/pci/rom.c                                  |    5 +
 drivers/pci/search.c                               |   72 +++++++++++++-
 drivers/pnp/pnpacpi/rsparser.c                     |   41 +++++---
 include/linux/pci.h                                |    4 +
 .../pci/hotplug => include/linux}/pci_hotplug.h    |    2 
 44 files changed, 584 insertions(+), 203 deletions(-)
 rename drivers/pci/hotplug/pci_hotplug.h => include/linux/pci_hotplug.h (99%)

---------------

Akinobu Mita:
      cpcihp_generic: prevent loading without "bridge" parameter

Alan Cox:
      pci: Stamp out pci_find_* usage in fakephp
      PCI: quirks: switch quirks code offender to use pci_get API
      pci: Additional search functions

Amol Lad:
      PCI hotplug: ioremap balanced with iounmap

Andrew Morton:
      PCI: pcie-check-and-return-bus_register-errors fix

Brice Goglin:
      PCI: Improve pci_msi_supported() comments
      PCI: Update MSI-HOWTO.txt according to pci_msi_supported()

Daniel Drake:
      PCI: VIA IRQ quirk behaviour change

Daniel Ritz:
      PCI: add ICH7/8 ACPI/GPIO io resource quirks

eiichiro.oiwa.nm@hitachi.com:
      PCI: Turn pci_fixup_video into generic for embedded VGA

Eric Sesterhenn:
      pciehp: Remove unnecessary check in pciehp_ctrl.c

Greg Kroah-Hartman:
      PCI Hotplug: move pci_hotplug.h to include/linux/

Kenji Kaneshige:
      shpchp: fix shpchp_wait_cmd in poll
      pciehp: fix improper info messages
      pciehp - add missing locking
      shpchp: fix command completion check
      shpchp: remove unnecessary cmd_busy member from struct controller

Kristen Carlson Accardi:
      change pci hotplug subsystem maintainer to Kristen

Matt Domsch:
      PCI: optionally sort device lists breadth-first

Vojtech Pavlik:
      Fix DMA resource allocation in ACPIPnP

Zhang, Yanmin:
      PCI: fix pcie_portdrv_restore_config undefined without CONFIG_PM error

