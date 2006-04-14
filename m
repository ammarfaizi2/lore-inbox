Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWDNUBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWDNUBx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWDNUBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:01:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:40668 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965102AbWDNUBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:01:46 -0400
Date: Fri, 14 Apr 2006 13:00:45 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI and PCI Hotplug fixes for 2.6.17-rc1
Message-ID: <20060414200045.GA5626@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI and PCI Hotplug fixes against your latest git tree.
They have all been in the -mm tree for a while with no problems.

They do the following:
	- fix bug of MSI config values not being saved and restored
	  properly accross suspend/resume.
	- documentation update for the DMA api.
	- other minor bugfixes and id updates.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h



 Documentation/DMA-API.txt         |   49 ++++++--
 Documentation/DMA-mapping.txt     |   22 ++-
 arch/i386/pci/irq.c               |    3 
 drivers/pci/hotplug/rpaphp_core.c |    3 
 drivers/pci/msi.c                 |  227 +++++++++++++++++++++++++++++++++-----
 drivers/pci/pci.c                 |    6 +
 drivers/pci/pci.h                 |   11 +
 drivers/pci/quirks.c              |    4 
 include/linux/pci.h               |   33 +++++
 include/linux/pci_ids.h           |    3 
 include/linux/pm_legacy.h         |    7 -
 kernel/power/pm.c                 |   20 ---
 12 files changed, 308 insertions(+), 80 deletions(-)

---------------

Adrian Bunk:
      remove kernel/power/pm.c:pm_unregister()

David Brownell:
      dma doc updates

Grzegorz Janoszka:
      arch/i386/pci/irq.c - new VIA chipsets (fwd)

Jean Delvare:
      PCI: Add PCI quirk for SMBus on the Asus A6VA notebook

John Rose:
      PCI: rpaphp: remove init error condition

John W. Linville:
      pci_ids.h: correct naming of 1022:7450 (AMD 8131 Bridge)

Roland Dreier:
      PCI: fix sparse warning about pci_bus_flags

Shaohua Li:
      PCI: MSI(X) save/restore for suspend/resume

