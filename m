Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbTFZAh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbTFZAgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:36:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9208 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265257AbTFZAfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:35:21 -0400
Date: Wed, 25 Jun 2003 17:45:51 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] More PCI fixes for 2.5.73
Message-ID: <20030626004551.GA14034@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some PCI fixes that are against the latest 2.5.73 bk tree.  They
fix some PCI domain issues in the core and acpi, a reference count bug
in the PCI Hotplug core, and a fix for a character driver I broke with
one of the older PCI reference count patches.

I've also added a "fake" pci hotplug driver that might be useful for
some people to test their PCI drivers with, if they don't have access to
any PCI hotplug hardware.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 Documentation/pci.txt                  |   37 +++--
 arch/i386/pci/acpi.c                   |   10 +
 arch/ia64/pci/pci.c                    |   14 -
 drivers/acpi/pci_root.c                |    4 
 drivers/char/ip2main.c                 |   60 ++++----
 drivers/pci/Makefile                   |    9 -
 drivers/pci/hotplug/Kconfig            |   25 +++
 drivers/pci/hotplug/Makefile           |    1 
 drivers/pci/hotplug/fakephp.c          |  232 +++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/ibmphp_hpc.c       |   61 ++++----
 drivers/pci/hotplug/ibmphp_res.c       |    4 
 drivers/pci/hotplug/pci_hotplug.h      |    4 
 drivers/pci/hotplug/pci_hotplug_core.c |   22 +--
 drivers/pci/probe.c                    |   34 ++--
 include/acpi/acpi_drivers.h            |    4 
 include/asm-ia64/pci.h                 |    1 
 17 files changed, 399 insertions(+), 123 deletions(-)
-----

Eduardo Pereira Habkost:
  o Fix compilation of ip2main

Greg Kroah-Hartman:
  o PCI Hotplug: add fake PCI hotplug driver
  o IBM PCI Hotplug: fixes found by sparse
  o PCI Hotplug: fix core problem with kobject lifespans

Matthew Wilcox:
  o PCI: fixes for pci/probe.c
  o PCI: more PCI gubbins
  o PCI documentation
  o PCI: [PATCH] pcibios_scan_acpi()

