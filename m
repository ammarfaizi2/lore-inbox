Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTIKWyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbTIKWyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:54:03 -0400
Received: from mail.kroah.org ([65.200.24.183]:63120 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261598AbTIKWx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:53:58 -0400
Date: Thu, 11 Sep 2003 15:54:18 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.0-test5
Message-ID: <20030911225418.GA14551@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI patches against 2.6.0-test5.  They fix the problem
with PCI drivers declaring their probe function as __init or __devinit
and then not selecting CONFIG_HOTPLUG.  When a user would try to add a
new device id by using the "new_id" file in the driver's sysfs
directory, it would cause an oops.  So now the "new_id" file is only
enabled if CONFIG_HOTPLUG is selected, and we've fixed up all of the PCI
drivers to mark their probe functions (and child functions and data) as
__devinit.

Thanks to Matt Domsch for the big patch, and all of the other people who
helped figure this out.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/atm/firestream.c                |   18 -
 drivers/block/cciss.c                   |    4 
 drivers/char/epca.c                     |    2 
 drivers/char/watchdog/wdt_pci.c         |    2 
 drivers/net/hamachi.c                   |    6 
 drivers/net/irda/via-ircc.c             |    6 
 drivers/net/tc35815.c                   |    4 
 drivers/net/tokenring/abyss.c           |    4 
 drivers/net/tokenring/tmspci.c          |    4 
 drivers/net/tulip/de2104x.c             |    4 
 drivers/net/tulip/de4x5.c               |    8 
 drivers/net/wan/dscc4.c                 |    2 
 drivers/pci/hotplug/acpiphp.h           |   12 -
 drivers/pci/hotplug/acpiphp_core.c      |   12 -
 drivers/pci/hotplug/acpiphp_glue.c      |    6 
 drivers/pci/hotplug/acpiphp_pci.c       |   12 -
 drivers/pci/hotplug/acpiphp_res.c       |   12 -
 drivers/pci/hotplug/cpci_hotplug.h      |    6 
 drivers/pci/hotplug/cpci_hotplug_core.c |    6 
 drivers/pci/hotplug/cpci_hotplug_pci.c  |    2 
 drivers/pci/hotplug/cpqphp.h            |    6 
 drivers/pci/hotplug/cpqphp_core.c       |    6 
 drivers/pci/hotplug/cpqphp_ctrl.c       |    6 
 drivers/pci/hotplug/cpqphp_nvram.c      |    6 
 drivers/pci/hotplug/cpqphp_nvram.h      |    4 
 drivers/pci/hotplug/cpqphp_pci.c        |    6 
 drivers/pci/hotplug/cpqphp_sysfs.c      |    6 
 drivers/pci/hotplug/fakephp.c           |    6 
 drivers/pci/hotplug/ibmphp.h            |    4 
 drivers/pci/hotplug/ibmphp_core.c       |    4 
 drivers/pci/hotplug/ibmphp_ebda.c       |    4 
 drivers/pci/hotplug/ibmphp_hpc.c        |    2 
 drivers/pci/hotplug/ibmphp_pci.c        |    4 
 drivers/pci/hotplug/ibmphp_res.c        |    4 
 drivers/pci/hotplug/pci_hotplug.h       |    6 
 drivers/pci/hotplug/pci_hotplug_core.c  |    4 
 drivers/pci/hotplug/pcihp_skeleton.c    |    4 
 drivers/pci/pci-driver.c                |  334 +++++++++++++++++---------------
 drivers/pcmcia/i82092.c                 |    2 
 drivers/video/i810/i810_main.c          |   20 -
 drivers/video/i810/i810_main.h          |    4 
 drivers/video/riva/fbdev.c              |    4 
 42 files changed, 304 insertions(+), 274 deletions(-)
-----

Greg Kroah-Hartman:
  o PCI: fix up some pci drivers that had marked their probe functions with __init
  o PCI: remove compiler warning from previous new_id patch
  o PCI hotplug: fix up a bunch of copyrights that were incorrectly declared

Matt Domsch:
  o PCI: make new_id rely on CONFIG_HOTPLUG

