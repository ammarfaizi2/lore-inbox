Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTEVVrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTEVVrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:47:52 -0400
Received: from granite.he.net ([216.218.226.66]:19211 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263275AbTEVVrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:47:51 -0400
Date: Thu, 22 May 2003 15:02:52 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI changes for 2.5.69
Message-ID: <20030522220251.GA6814@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some PCI changesets against the latest 2.5.69 tree.  They include
Matt Domsch's dynamic PCI id patch for sysfs, which has been gone over
a few times on lkml in the recent past, and everyone now agrees with it.

It also includes the start of the work to add proper locking to the PCI
devices and the PCI device and bus lists.  After years of trying to
foist that task off on unsuspecting people (who later run screaming from
it), it looks like I'm finally going to have to do the work myself :)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/pci/pci-sysfs-dynids.c |  251 -------------
 Documentation/pci.txt          |   24 +
 drivers/base/bus.c             |    2 
 drivers/pci/Makefile           |    6 
 drivers/pci/bus.c              |    2 
 drivers/pci/hotplug.c          |   23 -
 drivers/pci/pci-driver.c       |  785 +++++++++++++++++++++++++++++++++--------
 drivers/pci/pci-sysfs-dynids.c |  251 +++++++++++++
 drivers/pci/pci.h              |    2 
 drivers/pci/probe.c            |   18 
 include/linux/device.h         |   35 +
 include/linux/pci-dynids.h     |   68 ++-
 include/linux/pci.h            |   47 +-
 13 files changed, 1045 insertions(+), 469 deletions(-)
-----

Greg Kroah-Hartman <greg@kroah.com>:
  o PCI: remove pci_insert_device() as no one uses it anymore
  o PCI: add pci_get_dev() and pci_put_dev()

Matt Domsch <matt_domsch@dell.com>:
  o dynids: call driver_attach() when new IDs are added
  o pci.h whitespace cleanups
  o PCI dynids - documentation fixes, id_table NULL check
  o Shrink dynids feature set
  o Device Driver Dynamic PCI Device IDs

