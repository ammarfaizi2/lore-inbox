Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVEQVp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVEQVp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEQVok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:44:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:41371 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261986AbVEQVoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:44:16 -0400
Date: Tue, 17 May 2005 14:44:13 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI bugfixes for 2.6.12-rc4
Message-ID: <20050517214413.GA28629@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 6 patches for the 2.6.12-rc4 tree that fix some PCI and PCI
Hotplug bugs.  They also delete a lot of code that is no longer needed
from the pci hotplug core.  There are also two patches in here that make
it easier for userspace to autoload modules for PCI devices.  All of
these patches have been in the past few -mm releases.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

Full patches will be sent to the linux-usb-devel and linux-pci mailing
lists, if anyone wants to see them.

thanks,

greg k-h

 drivers/pci/hotplug.c                   |  119 ----------
 drivers/pci/hotplug/cpci_hotplug.h      |    2 
 drivers/pci/hotplug/cpci_hotplug_core.c |  169 +++++++--------
 drivers/pci/hotplug/cpci_hotplug_pci.c  |  352 ++------------------------------
 drivers/pci/hotplug/pciehp.h            |    1 
 drivers/pci/hotplug/pciehp_core.c       |    2 
 drivers/pci/hotplug/pciehp_hpc.c        |  156 +++++++-------
 drivers/pci/hotplug/shpchp_core.c       |    2 
 drivers/pci/hotplug/shpchp_ctrl.c       |   30 +-
 drivers/pci/pci-sysfs.c                 |   12 +
 drivers/pci/pci.h                       |   27 --
 drivers/pci/pcie/portdrv_bus.c          |    3 
 12 files changed, 233 insertions(+), 642 deletions(-)


Dely Sy:
  o PCI Hotplug: get pciehp to work on the downstream port of a switch
  o PCI Hotplug: Fix echoing 1 to power file of enabled slot problem with SHPC driver

Greg Kroah-Hartman:
  o PCI: add MODALIAS to hotplug event for pci devices
  o PCI: add modalias sysfs file for pci devices

Scott Murray:
  o PCI Hotplug: remove pci_visit_dev
  o PCI Hotplug: CPCI update

