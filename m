Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbTHUR3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbTHUR3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:29:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:46277 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262812AbTHUR3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:29:10 -0400
Date: Thu, 21 Aug 2003 10:29:22 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.0-test3
Message-ID: <20030821172922.GA3761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some tiny PCI patches against 2.6.0-test3.  They fix a bug with
code that shouldn't have gotten into setup-bus.c and allow pci drivers
to properly propagate their probe() errors up to the driver core (which
now reports them.)  I've also moved the pci_pretty_name() macro to pci.h
as two different archs already created the same macro for themselves,
and created the PCI_DEVICE() and PCI_DEVICE_CLASS() macro to make the
pci_device_id lists in drivers a lot simpler to use.

I also added two compile bug fixes for video drivers, but you already
beat me to them in your tree, so they merged away.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 arch/alpha/kernel/sys_marvel.c     |    7 -------
 arch/x86_64/kernel/pci-gart.c      |    6 ------
 drivers/media/video/saa7111.c      |    2 +-
 drivers/pci/hotplug/cpqphp_core.c  |    1 -
 drivers/pci/hotplug/cpqphp_nvram.c |    1 -
 drivers/pci/names.c                |    6 +++---
 drivers/pci/pci-driver.c           |    6 ++----
 drivers/pci/setup-bus.c            |    5 -----
 drivers/video/tridentfb.c          |    2 +-
 include/linux/pci.h                |   37 ++++++++++++++++++++++++++++++++++++-
 10 files changed, 43 insertions(+), 30 deletions(-)

------


<janiceg:us.ibm.com>:
  o PCI: testing for probe errors in pci-driver.c

Greg Kroah-Hartman:
  o PCI: added the pci_pretty_name() macro to pci.h as 2 arches already had it
  o FB: fix broken tridentfb.c driver due to device.name change
  o Video: fix broken saa7111.c driver due to i2c structure changes
  o PCI: add PCI_NAME_SIZE instead of using DEVICE_NAME_SIZE
  o PCI: remove #include <linux/miscdevice.h> from some pci hotplug drivers
  o PCI: add PCI_DEVICE_CLASS() macro to match PCI_DEVICE() macro
  o PCI: add PCI_DEVICE() macro to make pci_device_id tables easier to read

Ivan Kokshaysky:
  o PCI: undo recent pci_setup_bridge() change

