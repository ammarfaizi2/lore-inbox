Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUBIXP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbUBIXOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:14:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:51129 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265365AbUBIXNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:13:42 -0500
Date: Mon, 9 Feb 2004 15:13:08 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI update for 2.6.3-rc1
Message-ID: <20040209231308.GB2393@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and PCI hotplug patches for 2.6.3-rc1.
The majority of this is the dmapool code that has been moved from the
pci core to the driver core to enable platforms that do not have pci
support to still use dma pools.  There are a number of other minor PCI
hotplug fixups, and I cleaned up the PCI MSI code a bit.

All of these changes have been in the last few -mm trees with no
problems (not including the UML build, which the UML people need to fix
in their own...)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/pci/pool.c                 |  404 -------------------------------
 include/linux/pci_msi.h            |  170 -------------
 Documentation/DMA-API.txt          |   87 ++++++
 arch/i386/pci/irq.c                |   44 +++
 drivers/base/Makefile              |    4 
 drivers/base/core.c                |    1 
 drivers/base/dmapool.c             |  480 ++++++++++++++++++++++++++++++++++---
 drivers/pci/Makefile               |    2 
 drivers/pci/hotplug.c              |    6 
 drivers/pci/hotplug/acpiphp_core.c |    6 
 drivers/pci/hotplug/acpiphp_glue.c |   56 ++--
 drivers/pci/hotplug/cpqphp_ctrl.c  |    4 
 drivers/pci/hotplug/cpqphp_pci.c   |   28 +-
 drivers/pci/hotplug/ibmphp_core.c  |  195 +++++----------
 drivers/pci/hotplug/ibmphp_ebda.c  |  118 ++++-----
 drivers/pci/hotplug/ibmphp_pci.c   |   78 +++---
 drivers/pci/hotplug/ibmphp_res.c   |   56 ++--
 drivers/pci/msi.c                  |    3 
 drivers/pci/msi.h                  |  168 ++++++++++++
 drivers/pci/pci-driver.c           |    2 
 drivers/pci/pci.ids                |    8 
 drivers/pci/probe.c                |    4 
 drivers/pci/remove.c               |    2 
 drivers/serial/8250_pci.c          |   27 --
 include/linux/device.h             |    1 
 include/linux/dmapool.h            |   27 ++
 include/linux/pci.h                |   16 -
 include/linux/pci_msi.h            |   29 --
 28 files changed, 1044 insertions(+), 982 deletions(-)
-----


<dlsy:snoqualmie.dp.intel.com>:
  o PCI: Patch to get cpqphp working with IOAPIC

<dsaxena:plexity.net>:
  o PCI: Replace pci_pool with generic dma_pool, part 2
  o PCI: Replace pci_pool with generic dma_pool

<eike-hotplug:sf-tec.de>:
  o PCI Hotplug: Convert error paths in ibmphp to use goto
  o PCI Hotplug: mark functions __init/__exit in acpiphp
  o PCI Hotplug: make ibm_unconfigure_device void
  o PCI Hotplug: kill hpcrc from several functions in ibmphp_core.c
  o PCI Hotplug: very small optimisations for ibmphp_pci.c
  o PCI Hotplug: Coding style fixes for drivers/pci/hotplug.c
  o PCI: avoid two returns directly after each other in pcidriver.c
  o PCI Hotplug: Kill useless instructions from ibmphp_core.c
  o PCI Hotplug: Kill spaces before \n in ibmphp*
  o PCI Hotplug: Whitespace fixes for acpiphp
  o PCI Hotplug: coding style for cpqphp_pci.c

Adam Belay:
  o PCI: Remove uneeded resource structures from pci_dev

David Brownell:
  o PCI: dma_pool fixups

Greg Kroah-Hartman:
  o dmapool: fix up list_for_each() calls to list_for_each_entry()
  o PCI: move pci_msi.h out of include/linux to drivers/pci where it belongs
  o PCI: remove stupid MSI debugging code that was never used
  o dmapool: Remove sentance in documentation that is now false on 2.6
  o dmapool: use dev_err() whenever we can to get the better information in it
  o PCI: add back some pci.ids entries that got deleted in the last big update

Matthew Dobson:
  o PCI: fix "pcibus_class" Device Class, release function

