Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTF0Cm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTF0Cm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:42:58 -0400
Received: from granite.he.net ([216.218.226.66]:37903 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263319AbTF0Cm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:42:56 -0400
Date: Thu, 26 Jun 2003 17:50:07 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] Yet more PCI fixes for 2.5.73
Message-ID: <20030627005007.GA6173@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some more PCI fixes that are against the latest 2.5.73 bk tree.
They fix up the kobject bug in the pci hotplug drivers (the core was
fixed in the patches sent yesterday), and change the pci_dev's slot_name
to be a pointer to the struct device's bus_id.  This provides us with
the unique name needed for pci domain support.  There's also a bugfix
for the pci direct code in i386.


Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


-----

 arch/i386/pci/direct.c                  |  106 ++++++++++++++++++++------------
 drivers/pci/hotplug/acpiphp_core.c      |   30 ++++++---
 drivers/pci/hotplug/cpci_hotplug_core.c |   22 ++++--
 drivers/pci/hotplug/cpqphp_core.c       |   38 ++++++-----
 drivers/pci/hotplug/ibmphp.h            |    3 
 drivers/pci/hotplug/ibmphp_core.c       |   25 -------
 drivers/pci/hotplug/ibmphp_ebda.c       |   79 ++++++++++++++++++++---
 drivers/pci/hotplug/ibmphp_hpc.c        |   68 --------------------
 drivers/pci/hotplug/pcihp_skeleton.c    |   42 ++++++++----
 drivers/pci/probe.c                     |   16 ++--
 include/linux/pci.h                     |   10 ++-
 11 files changed, 245 insertions(+), 194 deletions(-)
-----

Greg Kroah-Hartman:
  o PCI Hotplug: ibmphp: add release() callback and other minor cleanups
  o PCI Hotplug: cpqphp: add release() callback and other minor cleanups
  o PCI Hotplug: cpci: fix delete bug and add release() callback
  o PCI Hotplug: acpiphp: add release() callback
  o PCI Hotplug: pcihp_skeleton: fix delete bug and add release() callback

Matthew Wilcox:
  o PCI: create pci_name()
  o PCI: i386/pci/direct.c fixes

