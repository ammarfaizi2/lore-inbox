Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbTGDBwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbTGDBwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:52:04 -0400
Received: from granite.he.net ([216.218.226.66]:19470 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265628AbTGDBwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:52:01 -0400
Date: Thu, 3 Jul 2003 19:06:34 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI and sysfs fixes for 2.5.73
Message-ID: <20030704020634.GA4316@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some PCI and sysfs fixes that are against the latest 2.5.74 bk
tree.  They include Matthew Wilcox's set of pci cleanups, and sysfs
fixes for binary files.  That led into my sysfs attribute file change,
which required John Stultz's timer build fix.  I've also added the
sysfs/kobject/class rename patches based on previously posted patches.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


-----
 Documentation/pci.txt                   |   12 ++-
 arch/i386/kernel/timers/timer_cyclone.c |    4 -
 arch/i386/kernel/timers/timer_tsc.c     |   17 ++++-
 arch/i386/pci/direct.c                  |    2 
 arch/i386/pci/irq.c                     |   11 +--
 arch/i386/pci/legacy.c                  |   26 +------
 arch/sh/kernel/cpu/sh4/pci-sh7751.c     |    2 
 drivers/base/class.c                    |   20 ++++++
 drivers/base/firmware_class.c           |    4 -
 drivers/pci/hotplug/acpiphp_glue.c      |    2 
 drivers/pci/hotplug/cpci_hotplug_pci.c  |    2 
 drivers/pci/hotplug/ibmphp_core.c       |    6 -
 drivers/pci/pci-sysfs.c                 |  105 ++++++++++++++++++++++++++++++++
 drivers/pci/pci.h                       |    1 
 drivers/pci/probe.c                     |   13 ---
 drivers/pci/search.c                    |   32 +++++----
 fs/sysfs/bin.c                          |   27 +++-----
 fs/sysfs/dir.c                          |   22 ++++++
 fs/sysfs/file.c                         |    9 ++
 include/linux/device.h                  |   13 ++-
 include/linux/kobject.h                 |    2 
 include/linux/pci.h                     |    2 
 include/linux/sysfs.h                   |    5 +
 lib/kobject.c                           |   15 ++++
 24 files changed, 262 insertions(+), 92 deletions(-)
-----

Greg Kroah-Hartman:
  o driver core: add my copyright to class.c
  o driver core: added class_device_rename() Based on a patch written by Dan Aloni <da-x@gmx.net>
  o kobject: add kobject_rename() Based on a patch written by Dan Aloni <da-x@gmx.net>
  o sysfs: add sysfs_rename_dir() Based on a patch written by Dan Aloni <da-x@gmx.net>
  o SYSFS: add module referencing to sysfs attribute files
  o sysfs: change print() to pr_debug() to not annoy everyone
  o PCI: change WARN_ON(irqs_disabled()) to WARN_ON(in_interrupt()) to keep the fusion drivers happy

John Stultz:
  o jiffies include fix This patch fixes a bad declaration of jiffies in timer_tsc.c and timer_cyclone.c, replacing it with the proper usage of jiffies.h.

Matthew Wilcox:
  o Driver Core: fix firmware binary files Fixes the sysfs binary file bug.
  o PCI config space in sysfs
  o PCI: arch/i386/pci/legacy.c: use raw_pci_ops Make pcibios_fixup_peer_bridges() use raw_pci_ops directly instead of faking pci_bus and pci_dev.
  o PCI: arch/i386/pci/irq.c should use pci_find_bus Use pci_find_bus rather than relying on the return value of pci_scan_bus.
  o PCI: Remove pci_bus_exists Convert all callers of pci_bus_exists() to call pci_find_bus() instead.
  o PCI: pci_find_bus needs a domain Give pci_find_bus a domain argument and move its declaration to <linux/pci.h>
  o PCI: arch/i386/pci/direct.c can use __init, not __devinit pci_sanity_check() is only called from functions marked __init, so it can be __init too.
  o PCI: Improve documentation Fix some grammar problems Add a note about Fast Back to Back support Change the slot_name recommendation to pci_name().

