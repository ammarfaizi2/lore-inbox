Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVDAXqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVDAXqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVDAXqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:46:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:36315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262802AbVDAXqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:46:06 -0500
Date: Fri, 1 Apr 2005 15:45:51 -0800
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI update for 2.6.12-rc1
Message-ID: <20050401234550.GA15046@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and PCI Hotplug patches for 2.6.11.  All of these have
been in the past few -mm releases.

This includes an even bigger pci.ids update, as now we should be
completly synced up with the main sf.net database.  I've also marked
this feature as "will be deleted soon" as it's a waste of time and
space.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 Documentation/feature-removal-schedule.txt |   48 -
 arch/frv/mb93090-mb00/pci-frv.c            |    6 
 arch/i386/pci/fixup.c                      |   20 
 arch/i386/pci/i386.c                       |    8 
 arch/mips/pmc-sierra/yosemite/ht.c         |    2 
 arch/ppc/kernel/pci.c                      |    8 
 arch/sh/drivers/pci/pci.c                  |    2 
 arch/sh64/kernel/pcibios.c                 |    2 
 arch/sparc64/kernel/pci_psycho.c           |    2 
 arch/sparc64/kernel/pci_sabre.c            |    2 
 arch/sparc64/kernel/pci_schizo.c           |    2 
 arch/x86_64/kernel/pci-gart.c              |    4 
 drivers/ide/pci/serverworks.c              |    8 
 drivers/mtd/maps/pci.c                     |    6 
 drivers/pci/Kconfig                        |   10 
 drivers/pci/Makefile                       |    4 
 drivers/pci/gen-devlist.c                  |    2 
 drivers/pci/hotplug.c                      |   25 
 drivers/pci/hotplug/cpqphp_core.c          |    4 
 drivers/pci/hotplug/ibmphp_pci.c           |   56 -
 drivers/pci/hotplug/pci_hotplug.h          |    2 
 drivers/pci/hotplug/pci_hotplug_core.c     |    5 
 drivers/pci/hotplug/rpaphp.h               |    2 
 drivers/pci/hotplug/rpaphp_pci.c           |  105 --
 drivers/pci/hotplug/rpaphp_slot.c          |   11 
 drivers/pci/msi.c                          |    8 
 drivers/pci/pci-driver.c                   |   11 
 drivers/pci/pci-sysfs.c                    |    4 
 drivers/pci/pci.c                          |   24 
 drivers/pci/pci.ids                        | 1310 +++++++++++++++++++++--------
 drivers/pci/probe.c                        |   40 
 drivers/pci/proc.c                         |    9 
 drivers/pci/quirks.c                       |   43 
 drivers/pci/remove.c                       |   10 
 drivers/pci/setup-bus.c                    |   25 
 drivers/pci/setup-irq.c                    |   18 
 drivers/pci/setup-res.c                    |   30 
 include/asm-i386/topology.h                |    7 
 include/asm-x86_64/topology.h              |    3 
 include/linux/pci.h                        |    2 
 include/linux/pci_ids.h                    |    8 
 kernel/resource.c                          |    1 
 42 files changed, 1231 insertions(+), 668 deletions(-)
-----


Adrian Bunk:
  o drivers/pci/msi.c: fix a check after use
  o drivers/pci/hotplug/cpqphp_core.c: fix a check after use

Bjorn Helgaas:
  o PCI: trivial DBG tidy-up

Domen Puncer:
  o arch/i386/pci/i386.c: Use new for_each_pci_dev macro

Greg Kroah-Hartman:
  o PCI: create PCI_DEBUG config option to make it easier for users to enable pci debugging
  o PCI: clean up the dynamic id logic a little bit
  o PCI Hotplug: enforce the rule that a hotplug slot needs a release function
  o PCI: fix an oops in some pci devices on hotplug remove when their resources are being freed
  o PCI: sync up with the latest pci.ids file from sf.net
  o PCI: add CONFIG_PCI_NAMES to the feature-removal-schedule.txt file
  o Remove item from feature-removal-schedule.txt that was already removed from the kernel
  o PCI: increase the size of the pci.ids strings

Jason Gaston:
  o pci_ids.h correction for Intel ICH7M

Jean Delvare:
  o PCI: Quirk for Asus M5N

John Rose:
  o [PATCH] remove redundant devices list

Jon Smirl:
  o PCI: handle multiple video cards on the same bus
  o sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch

Kimball Murray:
  o PCI: Patch for Serverworks chips in hotplug environment

Matthew Wilcox:
  o PCI busses are structs, not integers
  o PCI: 80 column lines

Prarit Bhargava:
  o PCI Hotplug: add documentation about release pointer

Roland Dreier:
  o PCI: Add PCI device ID for new Mellanox HCA

Rolf Eike Beer:
  o PCI: remove pci_find_device usage from pci sysfs code
  o PCI: shrink drivers/pci/proc.c::pci_seq_start()
  o PCI Hotplug: only call ibmphp_remove_resource() if argument is not NULL
  o PCI Hotplug: remove code duplication in drivers/pci/hotplug/ibmphp_pci.c

