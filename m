Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbUDORU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbUDORUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:20:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:41644 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264354AbUDORUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:20:22 -0400
Date: Thu, 15 Apr 2004 10:19:59 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
Message-ID: <20040415171959.GA3849@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and PCI hotplug patches for 2.6.6-rc1.  These have all
been in the -mm tree for a number of weeks now, and contain:
	- some pci hotplug driver fixes and updates
	- the final pci express patch that enables access to the
	  extended config area.
	- DMA mapping constants renamed and moved.

Please pull from:
	bk://linuxusb.bkbits.net/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.  Note that some spam filters seem to be
flagging my patches as spam, sorry about that :(


 Documentation/DMA-mapping.txt         |   64 +++++-----
 drivers/net/e1000/e1000.h             |    6 
 drivers/net/e1000/e1000_main.c        |    8 -
 drivers/net/ixgb/ixgb.h               |    6 
 drivers/net/ixgb/ixgb_main.c          |    4 
 drivers/pci/hotplug/acpiphp_glue.c    |   38 ++----
 drivers/pci/hotplug/acpiphp_pci.c     |  110 ++++-------------
 drivers/pci/hotplug/pci_hotplug.h     |    2 
 drivers/pci/hotplug/pciehp_ctrl.c     |    6 
 drivers/pci/hotplug/pciehp_hpc.c      |  180 +++++++++++++++++++++++-----
 drivers/pci/hotplug/pciehp_pci.c      |    2 
 drivers/pci/hotplug/rpadlpar_core.c   |   23 +--
 drivers/pci/hotplug/rpaphp.h          |    2 
 drivers/pci/hotplug/rpaphp_core.c     |   23 +--
 drivers/pci/hotplug/rpaphp_pci.c      |    1 
 drivers/pci/hotplug/rpaphp_slot.c     |   80 ++++++------
 drivers/pci/hotplug/shpchp_ctrl.c     |   10 -
 drivers/pci/hotplug/shpchp_hpc.c      |   26 ++--
 drivers/pci/hotplug/shpchprm_acpi.c   |    3 
 drivers/pci/hotplug/shpchprm_legacy.c |   30 ----
 drivers/pci/pci-sysfs.c               |   29 +++-
 drivers/pci/pci.c                     |   63 ++++++++--
 drivers/pci/pci.h                     |    2 
 drivers/pci/probe.c                   |   40 ++++++
 drivers/pci/proc.c                    |   26 ++--
 drivers/pci/quirks.c                  |   11 +
 include/linux/dma-mapping.h           |    3 
 include/linux/pci.h                   |  213 +++++++++++++++++++++++++++++-----
 include/linux/pci_ids.h               |    2 
 29 files changed, 647 insertions(+), 366 deletions(-)
-----

Deepak Saxena:
  o PCI: Allow arch-specific pci_set_dma_mask and friends

Dely Sy:
  o PCI Hotplug: Fix interpretation of 0/1 for MRL in SHPC & PCI-E hot-plug
  o PCI: Updates for PCI Express hot-plug driver

Greg Kroah-Hartman:
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20040323051558|61282
  o PCI: add ability to access pci extended config space for PCI Express devices

Jeff Garzik:
  o Create PCI_DMA_{64,32]BIT constants, for use in passing to pci_set_{consistent_}dma_mask().

John Rose:
  o PCI Hotplug: RPA PCI Hotplug - redundant free

Linda Xie:
  o PCI Hotplug: php_phy_location.patch

Matthew Wilcox:
  o PCI Hotplug: Rewrite acpiphp detect_used_resource
  o PCI Hotplug: Don't up() twice in acpiphp

Randy Dunlap:
  o PCI: move DMA_nnBIT_MASK to linux/dma-mapping.h
  o PCI: add DMA_{64,32}BIT constants

