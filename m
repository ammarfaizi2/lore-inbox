Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbUBTTE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUBTTE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:04:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:57060 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261267AbUBTTEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:04:15 -0500
Date: Fri, 20 Feb 2004 11:04:14 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI update for 2.6.3
Message-ID: <20040220190413.GA15063@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and PCI hotplug patches for 2.6.3.
The majority of these changes are 3 new pci hotplug drivers:
	- ppc64 dynamic partition driver
	- PCI Express hotplug driver
	- SHPC hotplug driver (the "standard" pci hotplug driver.)
	  Should work just fine on most x86-64 boxes too.

There are some other minor bug fixes in here, and the moving of the
CONFIG_HOTPLUG declaration so that all archs can now use it.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 Documentation/MSI-HOWTO.txt            |   19 
 arch/alpha/Kconfig                     |   18 
 arch/arm/Kconfig                       |   36 
 arch/arm26/Kconfig                     |   18 
 arch/i386/Kconfig                      |   36 
 arch/ia64/Kconfig                      |   36 
 arch/m68knommu/Kconfig                 |   18 
 arch/mips/Kconfig                      |   18 
 arch/mips/pci/pci-cobalt.c             |    2 
 arch/ppc/Kconfig                       |   18 
 arch/ppc64/Kconfig                     |   18 
 arch/sh/Kconfig                        |   18 
 arch/sparc64/Kconfig                   |   18 
 arch/v850/Kconfig                      |   18 
 arch/x86_64/Kconfig                    |   36 
 drivers/net/gt96100eth.c               |    6 
 drivers/parisc/Kconfig                 |   18 
 drivers/pci/hotplug/Kconfig            |   90 
 drivers/pci/hotplug/Makefile           |   40 
 drivers/pci/hotplug/cpqphp_sysfs.c     |    4 
 drivers/pci/hotplug/pci_hotplug.h      |   21 
 drivers/pci/hotplug/pci_hotplug_core.c |    1 
 drivers/pci/hotplug/pciehp.h           |  386 ++++
 drivers/pci/hotplug/pciehp_core.c      |  707 +++++++
 drivers/pci/hotplug/pciehp_ctrl.c      | 2622 ++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c       | 1436 +++++++++++++++
 drivers/pci/hotplug/pciehp_pci.c       |  834 +++++++++
 drivers/pci/hotplug/pciehp_sysfs.c     |  147 +
 drivers/pci/hotplug/pciehprm.h         |   53 
 drivers/pci/hotplug/pciehprm_acpi.c    | 1689 ++++++++++++++++++
 drivers/pci/hotplug/pciehprm_nonacpi.c |  498 +++++
 drivers/pci/hotplug/pciehprm_nonacpi.h |   56 
 drivers/pci/hotplug/rpadlpar.h         |   24 
 drivers/pci/hotplug/rpadlpar_core.c    |  343 +++
 drivers/pci/hotplug/rpadlpar_sysfs.c   |  151 +
 drivers/pci/hotplug/rpaphp.h           |  101 +
 drivers/pci/hotplug/rpaphp_core.c      |  948 ++++++++++
 drivers/pci/hotplug/rpaphp_pci.c       |   75 
 drivers/pci/hotplug/shpchp.h           |  467 +++++
 drivers/pci/hotplug/shpchp_core.c      |  704 +++++++
 drivers/pci/hotplug/shpchp_ctrl.c      | 3055 +++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/shpchp_hpc.c       | 1608 +++++++++++++++++
 drivers/pci/hotplug/shpchp_pci.c       |  821 ++++++++
 drivers/pci/hotplug/shpchp_sysfs.c     |  147 +
 drivers/pci/hotplug/shpchprm.h         |   56 
 drivers/pci/hotplug/shpchprm_acpi.c    | 1694 ++++++++++++++++++
 drivers/pci/hotplug/shpchprm_legacy.c  |  474 +++++
 drivers/pci/hotplug/shpchprm_legacy.h  |  113 +
 drivers/pci/hotplug/shpchprm_nonacpi.c |  431 ++++
 drivers/pci/hotplug/shpchprm_nonacpi.h |   56 
 drivers/pci/msi.c                      |    6 
 drivers/pci/msi.h                      |    4 
 drivers/pci/pci.c                      |   94 -
 drivers/pci/quirks.c                   |    9 
 drivers/s390/Kconfig                   |   22 
 include/linux/pci.h                    |    2 
 include/linux/pci_ids.h                |   26 
 init/Kconfig                           |   19 
 58 files changed, 19946 insertions(+), 439 deletions(-)
-----


<lxiep:linux.ibm.com>:
  o PCI Hotplug: Add PPC64 PCI Hotplug Driver for RPA

<martine.silbermann:hp.com>:
  o PCI: update MSI Documentation

<tlnguyen:snoqualmie.dp.intel.com>:
  o PCI: add copyright for files msi.c and msi.h

Adam Belay:
  o PCI: remove unused defines in pci.h

Bartlomiej Zolnierkiewicz:
  o move CONFIG_HOTPLUG to init/Kconfig

Dely Sy:
  o PCI Hotplug: Add SHPC and PCI Express hot-plug drivers

Greg Kroah-Hartman:
  o PCI Hotplug: fix build warnings on 64 bit processors
  o PCI: fix pci quirk for P4B533-V, fixes bug 1720

John Rose:
  o PCI Hotplug : add DLPAR driver for PPC64 PCI Hotplug slots

Mark A. Greer:
  o PCI: Changing 'GALILEO' to 'MARVELL'

Matthew Wilcox:
  o PCI: Fix pci_bus_find_capability()

