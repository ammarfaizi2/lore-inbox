Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVEDHCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVEDHCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVEDHCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:02:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:47844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261600AbVEDHCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:08 -0400
Date: Wed, 4 May 2005 00:01:07 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI bugfixes for 2.6.12-rc3
Message-ID: <20050504070107.GA17791@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a number of PCI bugfixes for 2.6.12-rc3.  They include a
long-standing 64bit sysfs pci bug (has been fixed in the SuSE kernels
for months) and some PCI hotplug bugfixes (hopefully the drivers are all
now working again...) Almost all of these patches have been in the past
few -mm releases.

Pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

Full patches will be sent to the linux-kernel and linux-pci mailing lists, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/pci.txt                |    1 
 Documentation/power/pci.txt          |   35 --------------
 arch/arm/mach-ixp4xx/common-pci.c    |   10 ----
 drivers/pci/hotplug/ibmphp.h         |    2 
 drivers/pci/hotplug/ibmphp_hpc.c     |    6 +-
 drivers/pci/hotplug/ibmphp_pci.c     |    7 ++
 drivers/pci/hotplug/pci_hotplug.h    |    2 
 drivers/pci/hotplug/pciehp_core.c    |   23 +++++++--
 drivers/pci/hotplug/pcihp_skeleton.c |    2 
 drivers/pci/msi.c                    |    6 +-
 drivers/pci/pci-acpi.c               |    2 
 drivers/pci/pci-driver.c             |   11 ++++
 drivers/pci/pci-sysfs.c              |   82 ++++++++++++++++++++++++-----------
 drivers/pci/pci.c                    |   20 +-------
 drivers/pci/probe.c                  |    1 
 drivers/pci/proc.c                   |    1 
 drivers/pci/quirks.c                 |    2 
 include/linux/pci.h                  |    3 -
 18 files changed, 113 insertions(+), 103 deletions(-)


<ssant:in.ibm.com>:
  o PCI: fix up word-aligned 16-bit PCI config access through sysfs This patch adds the possibility to do word-aligned 16-bit atomic PCI configuration space accesses via the sysfs PCI interface. As a result, problems with Emulex LFPC on IBM PowerPC64 are fixed.

Adrian Bunk:
  o PCI: drivers/pci/pci.c: remove pci_dac_set_dma_mask pci_dac_set_dma_mask is currently completely unused.

Dely Sy:
  o PCI Hotplug: fix pciehp regression I fogot to remove the code that freed the memory in cleanup_slots().

Greg Kroah-Hartman:
  o PCI: Add pci shutdown ability Now pci drivers can know when the system is going down without having to add a reboot notifier event.
  o PCI: Clean up a lot of sparse "Should it be static?" warnings

Matthew Wilcox:
  o PCI: update PCI documentation for pci_get_slot() depreciation pci_find_slot() doesn't work on multiple-domain boxes so pci_get_slot() should be used instead.

Pavel Machek:
  o PCI: fix stale PCI pm docs This fixes u32 vs. pm_message_t confusion in documentation, and removes references to no-longer-existing (*save_state), too. With exception of USB (I hope David will fix/apply my patch), this should fix last piece of this confusion... famous last words.

Rolf Eike Beer:
  o PCI Hotplug ibmphp_pci.c: Fix masking out needed information too early here is the patch that fixes the bug introduced by my previous patch which already went into 2.6.12-rc2 and is likely to cause trouble is someone hits

Rudolf Marek:
  o PCI: Rapid Hance quirk This patch just adds Intel's Hance Rapid south bridge IDs to ICH4 region quirk.

Steven Cole:
  o PCI: Spelling fixes for drivers/pci


