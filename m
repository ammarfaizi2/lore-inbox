Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWFSVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWFSVqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWFSVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:46:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40123 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932544AbWFSVqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:46:02 -0400
Date: Mon, 19 Jun 2006 14:42:58 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI Hotplug patches for 2.6.17
Message-ID: <20060619214258.GA6607@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are PCI Hotplug fixes and patches for 2.6.17.  They refactor a
number of different pci hotplug drivers and fix some bugs for different
platforms.

All of these patches have been in the -mm tree for a number of months.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h


 drivers/pci/hotplug/acpi_pcihp.c   |  257 +++++++++--
 drivers/pci/hotplug/acpiphp.h      |    5 
 drivers/pci/hotplug/acpiphp_glue.c |  242 +++++++---
 drivers/pci/hotplug/ibmphp_core.c  |   12 
 drivers/pci/hotplug/pci_hotplug.h  |   50 +-
 drivers/pci/hotplug/pciehp.h       |    2 
 drivers/pci/hotplug/pciehp_core.c  |   14 
 drivers/pci/hotplug/pciehp_hpc.c   |   32 -
 drivers/pci/hotplug/pciehp_pci.c   |  152 ++++++
 drivers/pci/hotplug/sgi_hotplug.c  |   46 +
 drivers/pci/hotplug/shpchp.h       |    8 
 drivers/pci/hotplug/shpchp_core.c  |    8 
 drivers/pci/hotplug/shpchp_ctrl.c  |   32 -
 drivers/pci/hotplug/shpchp_hpc.c   |  861 ++++++++++++++++---------------------
 drivers/pci/hotplug/shpchp_pci.c   |   31 -
 15 files changed, 1091 insertions(+), 661 deletions(-)

---------------

Eric Sesterhenn:
      PCI Hotplug: fake NULL pointer dereferences in IBM Hot Plug Controller Driver

Jan Beulich:
      PCI Hotplug: Fix recovery path from errors during pcie_init()

Kenji Kaneshige:
      acpi_pcihp: Fix programming _HPP values
      acpi_pcihp: Remove improper error message about OSHP
      acpi_pcihp: Add support for _HPX
      pciehp: Fix programming hotplug parameters
      SHPC: Cleanup SHPC register access
      SHPC: Cleanup SHPC Logical Slot Register access
      SHPC: Cleanup SHPC Logical Slot Register bits access
      SHPC: Fix SHPC Logical Slot Register bits access
      SHPC: Fix SHPC Contoller SERR-INT Register bits access
      shpchp: Mask Global SERR and Intr at controller release time
      shpchp: Create shpchpd at controller probe time
      pciehp: Replace pci_find_slot() with pci_get_slot()
      pciehp: Add missing pci_dev_put
      pciehp: Implement get_address callback
      shpchp: Remove unnecessary hpc_ctlr_handle check
      shpchp: Cleanup interrupt handler
      shpchp: Cleanup SHPC commands
      shpchp: Cleanup interrupt polling timer
      shpchp: Remove Unused hpc_evelnt_lock
      shpchp: Cleanup improper info messages

Kristen Accardi:
      PCI Hotplug: don't use acpi_os_free
      pciehp: dont call pci_enable_dev

Mike Habeck:
      SGI Hotplug: Incorrect power status

MUNEDA Takahiro:
      acpiphp: configure _PRT - V3
      acpiphp: hotplug slot hotplug
      acpiphp: host and p2p hotplug
      acpiphp: turn off slot power at error case

Prarit Bhargava:
      PCI Hotplug: Tollhouse HP: SGI hotplug driver changes

