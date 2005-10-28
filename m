Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751955AbVJ1Wva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbVJ1Wva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbVJ1Wva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:51:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:31394 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751955AbVJ1Wv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:51:29 -0400
Date: Fri, 28 Oct 2005 15:50:55 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.14
Message-ID: <20051028225055.GA21464@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI patches against your latest git tree.  They have all
been in the -mm tree for a while with no problems.

Main things here are:
	- pci-ids.h cleanup
	- shpchp driver cleanup (very good job done here.)
	- more quirks added.


Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing lists, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/DocBook/kernel-api.tmpl  |    4 
 arch/i386/pci/fixup.c                  |   59 
 drivers/pci/access.c                   |   89 +
 drivers/pci/hotplug/acpiphp_glue.c     |    8 
 drivers/pci/hotplug/cpcihp_zt5550.c    |   25 
 drivers/pci/hotplug/cpqphp_core.c      |   24 
 drivers/pci/hotplug/rpaphp.h           |    3 
 drivers/pci/hotplug/rpaphp_core.c      |    5 
 drivers/pci/hotplug/rpaphp_pci.c       |   11 
 drivers/pci/hotplug/shpchp.h           |  126 -
 drivers/pci/hotplug/shpchp_core.c      |  111 -
 drivers/pci/hotplug/shpchp_ctrl.c      | 2120 +--------------------------------
 drivers/pci/hotplug/shpchp_hpc.c       |  175 --
 drivers/pci/hotplug/shpchp_pci.c       |  879 +------------
 drivers/pci/hotplug/shpchp_sysfs.c     |  197 +--
 drivers/pci/hotplug/shpchprm.h         |   55 
 drivers/pci/hotplug/shpchprm_acpi.c    | 1653 -------------------------
 drivers/pci/hotplug/shpchprm_legacy.c  |  395 ------
 drivers/pci/hotplug/shpchprm_legacy.h  |  113 -
 drivers/pci/hotplug/shpchprm_nonacpi.c |  389 ------
 drivers/pci/hotplug/shpchprm_nonacpi.h |   56 
 drivers/pci/msi.c                      |    2 
 drivers/pci/pci-driver.c               |   17 
 drivers/pci/pci-sysfs.c                |   20 
 drivers/pci/pci.c                      |   21 
 drivers/pci/pci.h                      |    7 
 drivers/pci/probe.c                    |    1 
 drivers/pci/proc.c                     |   28 
 drivers/pci/quirks.c                   |   37 
 drivers/pci/syscall.c                  |   14 
 drivers/scsi/ipr.c                     |    2 
 drivers/scsi/megaraid/megaraid_mbox.c  |   10 
 drivers/video/cirrusfb.c               |   24 
 include/linux/pci.h                    |    7 
 include/linux/pci_ids.h                |  577 --------
 sound/oss/ymfpci.c                     |   17 
 sound/pci/bt87x.c                      |   11 
 37 files changed, 841 insertions(+), 6451 deletions(-)


Andrew Morton:
      PCI: fix edac drivers for radisys 82600 borkage

Bjorn Helgaas:
      cpcihp_zt5550: add pci_enable_device()
      cpqphp: add pci_enable_device()

Brian King:
      PCI: ipr: Block config access during BIST
      PCI: Block config access during BIST

Grant Coady:
      pci_ids: macros: replace partial with whole symbols
      pci_ids: remove duplicates from pci_ids.h
      pci_ids: remove non-referenced symbols from pci_ids.h
      pci_ids: cleanup comments

Jean Delvare:
      PCI: Add quirk for SMBus on HP D530

Jesse Barnes:
      PCI fixup for Toshiba laptops and ohci1394

John W. Linville:
      pci: cleanup need_restore switch statement

Kristen Accardi:
      acpiphp: allocate resources for adapters with bridges

linas:
      ppc64 PCI Hotplug: cleanup unsymmetric API routines

rajesh.shah@intel.com:
      shpchp: remove redundant display of PCI device resources
      shpchp: use the PCI core for hotplug resource management
      shpchp: detect SHPC capability before doing a lot of work
      shpchp: remove redundant data structures
      shpchp: reduce dependence on ACPI
      shpchp: dont save PCI config for hotplug slots/devices
      shpchp: reduce debug message verbosity
      shpchp: miscellaneous cleanups
      shpchp: fix oops at driver unload

Randy Dunlap:
      kernel-doc: PCI fixes
      kernel-doc: fix PCI hotplug

Rudolf Marek:
      PCI: ICH6 ACPI and GPIO quirk
      unhide ICH6 SMBus - take 2

Russell King:
      PCI: Convert megaraid to use pci_driver shutdown method
      PCI: Fixup PCI driver shutdown

