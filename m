Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTFSXXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTFSXXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:23:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:10397 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261868AbTFSXXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:23:37 -0400
Date: Thu, 19 Jun 2003 16:37:28 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI changes and fixes for 2.5.72
Message-ID: <20030619233727.GA7200@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some PCI changes that are against the latest 2.5.72 bk tree.
They contain a number of different pci core changes, all listed below.
Included in these patches is the pci list locking patch that has been
reviewed a bunch on lkml.


Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 MAINTAINERS              |    6 -
 arch/i386/pci/common.c   |   23 ++++++
 arch/i386/pci/direct.c   |   82 +++++++-----------------
 arch/i386/pci/fixup.c    |    6 -
 arch/i386/pci/irq.c      |    2 
 arch/i386/pci/legacy.c   |    6 -
 arch/i386/pci/numa.c     |   26 ++-----
 arch/i386/pci/pcbios.c   |   22 +-----
 arch/i386/pci/pci.h      |    2 
 arch/ia64/pci/pci.c      |   33 +++++-----
 drivers/acpi/osl.c       |   41 +++---------
 drivers/acpi/pci_root.c  |    2 
 drivers/pci/bus.c        |    6 +
 drivers/pci/hotplug.c    |   36 +++++++---
 drivers/pci/pci-driver.c |   20 +++---
 drivers/pci/pci-sysfs.c  |   24 +++----
 drivers/pci/pci.h        |    3 
 drivers/pci/probe.c      |    2 
 drivers/pci/proc.c       |   53 +++++++++-------
 drivers/pci/search.c     |  155 +++++++++++++++++++++++++++++++++++++++++------
 include/linux/pci.h      |   41 ++++++++----
 21 files changed, 351 insertions(+), 240 deletions(-)
-----

David Mosberger:
  o PCI: move pci_domain_nr() inside "#ifdef CONFIG_PCI" bracket

Greg Kroah-Hartman:
  o PCI: rename pci_get_dev() and pci_put_dev() to pci_dev_get() and pci_dev_put()
  o PCI: well, everyone is treating me like the maintainer
  o PCI: merge bits missed from the pci locking patch
  o PCI: add locking to the pci device lists

Matthew Wilcox:
  o PCI: pci_raw_ops patch to fix acpi on ia64
  o PCI: Unconfuse /proc
  o PCI: Tidy up sysfs a bit

