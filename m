Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272162AbTHIAjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272158AbTHIAht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:37:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:56767 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272160AbTHIAcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:17 -0400
Date: Fri, 8 Aug 2003 17:14:40 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB fixes for 2.6.0-test2
Message-ID: <20030809001440.GA2948@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB fixes for 2.6.0-test2.  Again, more audit patches
from Oliver Neukum, and some other good fixes from David Brownell that
solve some bugzilla.kernel.org bug reports.

I've also fixed a stupid issue with the pl2303 driver that some people
were seeing, and got rid of all of the usages of the struct device .name
variable as it is going to go away soon.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/isdn/hisax/st5481_b.c                     |    4 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 
 drivers/usb/core/hcd-pci.c                        |    3 
 drivers/usb/core/hcd.c                            |    3 
 drivers/usb/core/hub.c                            |    4 
 drivers/usb/core/usb.c                            |  137 ++++------------------
 drivers/usb/gadget/net2280.c                      |    1 
 drivers/usb/host/ehci-dbg.c                       |    4 
 drivers/usb/host/ehci-mem.c                       |    1 
 drivers/usb/host/ohci-hcd.c                       |    4 
 drivers/usb/host/ohci-mem.c                       |    1 
 drivers/usb/host/ohci-pci.c                       |   11 -
 drivers/usb/host/ohci-sa1111.c                    |    1 
 drivers/usb/host/uhci-hcd.c                       |    1 
 drivers/usb/net/pegasus.c                         |    6 
 drivers/usb/net/rtl8150.c                         |   14 +-
 drivers/usb/net/usbnet.c                          |   10 +
 drivers/usb/serial/ftdi_sio.c                     |    7 +
 drivers/usb/serial/ftdi_sio.h                     |    6 
 drivers/usb/serial/pl2303.c                       |    9 -
 drivers/usb/serial/usb-serial.c                   |    1 
 drivers/usb/storage/initializers.c                |    6 
 drivers/usb/storage/initializers.h                |    2 
 drivers/usb/usb-skeleton.c                        |    5 
 24 files changed, 89 insertions(+), 154 deletions(-)
-----

<sojka:planetarium.cz>:
  o USB: fixes for usb-skeleton.c

Alan Stern:
  o USB: usb-storage: Move static string out of initializers.h

David Brownell:
  o USB: usbnet, prevent exotic rtnl deadlock
  o USB: disable both sides of usb device ep0 at once
  o USB: usb_new_device() updates
  o USB: ohci-hcd, minor d3cold resume fix

Greg Kroah-Hartman:
  o USB: remove dev.name usage from gadget code
  o USB: remove all struct device.name usage from the USB code
  o USB: remove some vendor specific stuff from the pl2303 driver to get other devices to work

Ian Abbott:
  o USB: ftdi_sio - VID/PID for ID TECH IDT1221U USB to RS-232 adapter

Oliver Neukum:
  o USB: dvb usb driver sleeping in interrupt
  o USB: use of __devinit in st5481
  o USB: DMA coherency issue with rtl8150
  o USB: remove GFP_DMA from pegasus

