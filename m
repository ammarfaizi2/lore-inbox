Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbUB1AHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbUB1AHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:07:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:58788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263209AbUB1AHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:07:41 -0500
Date: Fri, 27 Feb 2004 16:07:25 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.4-rc1
Message-ID: <20040228000725.GB13346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small PCI and PCI hotplug fixes for 2.6.4-rc1.  With these
patches, the ARM tree should build properly now as well as the shpc
driver will not oops.

I _really_ wanted to get the PCI Express support in with this set of
patches, but the patch in the -mm tree breaks any box that is in the
ACPI quirks table.  Then the patches that tried to fix that problem
broke all of my boxes (ones without PCI Express and with PCI Express.)
So the PCI Express code is not stable enough yet for mainline,
unfortunately :(

Good news is I now have hardware to test on, so PCI Express support has
a chance to make it into the tree (thanks a lot to Intel for this...)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/pci/hotplug/Kconfig       |    4 +--
 drivers/pci/hotplug/Makefile      |   37 ++++++++++------------------
 drivers/pci/hotplug/pciehp_ctrl.c |    2 +
 drivers/pci/hotplug/rpaphp.h      |    2 -
 drivers/pci/hotplug/rpaphp_core.c |    4 ---
 drivers/pci/hotplug/shpchp.h      |    4 +--
 drivers/pci/hotplug/shpchp_ctrl.c |    2 +
 drivers/pci/hotplug/shpchp_hpc.c  |   49 ++++++++++++++++++++++----------------
 drivers/pci/pci.c                 |    5 ---
 drivers/pci/probe.c               |    4 +++
 drivers/pci/setup-bus.c           |   22 +++++++----------
 drivers/pci/setup-res.c           |    5 ++-
 include/linux/pci.h               |    2 +
 13 files changed, 71 insertions(+), 71 deletions(-)
-----

<lxiep:ltcfwd.linux.ibm.com>:
  o PCI Hotplug: fix rpaphp bugs

<rmk-pci:arm.linux.org.uk>:
  o PCI: Introduce bus->bridge_ctl member
  o PCI: Don't report pci_request_regions() failure twice
  o PCI: Report meaningful error for failed resource allocation

Dely Sy:
  o PCI Hotplug: Patch to get polling mode in SHPC hot-plug driver properly working

Greg Kroah-Hartman:
  o PCI Hotplug: clean up the Makefile a bit more
  o PCI Hotplug: remove unneeded ACPI Makefile rules

