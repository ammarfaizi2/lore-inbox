Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVAQWn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVAQWn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVAQWX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:23:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:48613 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262933AbVAQWCO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:14 -0500
Date: Mon, 17 Jan 2005 14:01:07 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes and PCI Express drivers for 2.6.11-rc1
Message-ID: <20050117220107.GA28985@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small PCI patches for 2.6.11-rc1, and the addition of a
new PCI Express subsystem (it's self contained, if you don't have PCI
Express, or select it, the code never gets built.)  All of these patches
have been in the past few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 Documentation/PCIEBUS-HOWTO.txt   |  217 ++++++++++++++++++
 arch/i386/Kconfig                 |    4 
 arch/i386/pci/pcbios.c            |    4 
 drivers/Makefile                  |    2 
 drivers/pci/Makefile              |    2 
 drivers/pci/access.c              |    2 
 drivers/pci/hotplug/Kconfig       |   21 -
 drivers/pci/hotplug/pciehp.h      |    3 
 drivers/pci/hotplug/pciehp_core.c |   83 ++++--
 drivers/pci/hotplug/pciehp_hpc.c  |   21 -
 drivers/pci/msi.c                 |   39 +--
 drivers/pci/pci.c                 |    2 
 drivers/pci/pci.h                 |    2 
 drivers/pci/pcie/Kconfig          |   38 +++
 drivers/pci/pcie/Makefile         |    7 
 drivers/pci/pcie/portdrv.h        |   42 +++
 drivers/pci/pcie/portdrv_bus.c    |   88 +++++++
 drivers/pci/pcie/portdrv_core.c   |  453 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv_pci.c    |  138 +++++++++++
 drivers/pci/probe.c               |   10 
 drivers/pci/remove.c              |   13 -
 drivers/pci/rom.c                 |   80 +++---
 drivers/pci/search.c              |    2 
 include/linux/pci_ids.h           |    4 
 include/linux/pcieport_if.h       |   74 ++++++
 25 files changed, 1209 insertions(+), 142 deletions(-)
-----


<jason.d.gaston:intel.com>:
  o PCI: pci_ids.h correction for Intel ICH7 - 2.6.10-bk13

Bjorn Helgaas:
  o PCI: use modern format for PCI addresses

David Howells:
  o PCI: Downgrade printk that complains about unsupported PCI PM caps

Greg Kroah-Hartman:
  o PCI: move pcie build into the drivers/pci/ subdirectory

Jesse Barnes:
  o PCI: rom.c cleanups

John Rose:
  o PCI: fix release_pcibus_dev() crash

Roland Dreier:
  o PCI: Clean up printks in msi.c

Thomas Gleixner:
  o PCI: Lock initializer cleanup - batch 4

Tom L. Nguyen:
  o PCI: add PCI Express Port Bus Driver subsystem

