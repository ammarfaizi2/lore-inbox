Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVAJRUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVAJRUd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVAJRUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:20:33 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:10970 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262329AbVAJRUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:20:16 -0500
Date: Mon, 10 Jan 2005 09:18:27 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI patches for 2.6.10-rc2
Message-ID: <20050110171827.GA30296@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and PCI Hotplug patches for 2.6.10.  All of these have
been in the past few -mm releases.

Highlights include:
	- start of typesafe pci power states
	- loads of little bug fixes.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 MAINTAINERS                            |   44 +
 arch/i386/pci/fixup.c                  |    4 
 arch/i386/pci/irq.c                    |    8 
 arch/i386/pci/pci.h                    |    2 
 drivers/media/video/bttv-driver.c      |   10 
 drivers/net/3c59x.c                    |   16 
 drivers/net/8139cp.c                   |   12 
 drivers/net/8139too.c                  |    5 
 drivers/net/amd8111e.c                 |   32 -
 drivers/net/e100.c                     |    8 
 drivers/net/eepro100.c                 |   16 
 drivers/net/pci-skeleton.c             |    4 
 drivers/net/sis900.c                   |   14 
 drivers/net/starfire.c                 |    4 
 drivers/net/typhoon.c                  |    9 
 drivers/net/via-rhine.c                |    4 
 drivers/net/via-velocity.c             |   64 +-
 drivers/pci/hotplug/acpiphp_ibm.c      |    2 
 drivers/pci/hotplug/cpci_hotplug_pci.c |    2 
 drivers/pci/hotplug/cpcihp_generic.c   |    2 
 drivers/pci/hotplug/cpqphp_pci.c       |   30 -
 drivers/pci/hotplug/fakephp.c          |    2 
 drivers/pci/hotplug/ibmphp.h           |    2 
 drivers/pci/hotplug/ibmphp_core.c      |  830 +++++++++++++++++----------------
 drivers/pci/hotplug/ibmphp_pci.c       |   56 +-
 drivers/pci/hotplug/shpchp.h           |    2 
 drivers/pci/pci.c                      |   67 ++
 drivers/pci/probe.c                    |   56 ++
 drivers/pci/quirks.c                   |   14 
 drivers/pci/setup-bus.c                |    9 
 drivers/pci/setup-irq.c                |    3 
 include/linux/pci.h                    |   34 +
 32 files changed, 807 insertions(+), 560 deletions(-)
-----

<macro:mips.com>:
  o PCI: PCI early fixup missing bits

Adrian Bunk:
  o PCI Hotplug: drivers/pci/hotplug/ : simply use MODULE
  o PCI: arch/i386/pci/: make some code static

David Howells:
  o PCI: Make pci_set_power_state() check register version

Domen Puncer:
  o hotplug/acpiphp_ibm: module_param fix

Greg Kroah-Hartman:
  o PCI Hotplug: remove my old email address
  o PCI: fix bttv-driver "cleanup" that called an incorrect function
  o PCI: fix typo on previous pci_set_power_state() patch for hte sis900 driver
  o PCI: fix up function calls for CONFIG_PCI=N

Maciej W. Rozycki:
  o PCI: Don't touch BARs of host bridges

Matthew Wilcox:
  o PCI: Software visible configuration request retry status
  o PCI: cope with duplicate bus numbers better

Pavel Machek:
  o PCI: fix sparse warnings in drivers/net/* and bttv
  o PCI: clean up state usage in pci core
  o PCI: add prototype for pci_choose_state()
  o PCI: add pci_choose_state()
  o PCI: Cleanup PCI power states

Randy Dunlap:
  o cpqphp: reduce stack usage

Rolf Eike Beer:
  o PCI Hotplug: don't check pointer before kalling kfree in ibmphp_pci.c
  o PCI Hotplug: use PCI_DEVFN in ibmphp_pci.c
  o PCI Hotplug: Remove unneeded kmalloc casts from ibmphp_pci.c
  o PCI Hotplug: ibmphp_core.c: useless casts
  o PCI Hotplug: ibmphp_core.c: coding style

Thomas Gleixner:
  o PCI: Fix debug statement

