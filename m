Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbUA1VqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUA1Vp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:45:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:2711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266207AbUA1VpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:45:08 -0500
Date: Wed, 28 Jan 2004 13:45:12 -0800
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.4.25-pre7
Message-ID: <20040128214512.GB8999@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes and changes against 2.4.25-pre7.  There is a
usb gadget update, and some ehci updates, along with a lot of little
fixes, all of which are present in the 2.6 tree.

Also, the ax8817x driver has been removed, as it was buggy, and the
usbnet driver works much better for all devices the ax8817x driver
supported.

Please pull from:  bk://linuxusb.bkbits.net/usb-devel-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h


 Documentation/Configure.help       |   29 
 drivers/usb/auermain.c             |   11 
 drivers/usb/ax8817x.c              | 1291 -----------
 drivers/usb/Config.in              |    1 
 drivers/usb/gadget/Config.in       |   69 
 drivers/usb/gadget/ether.c         |  100 
 drivers/usb/gadget/file_storage.c  | 4047 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/goku_udc.c      | 1975 ++++++++++++++++++
 drivers/usb/gadget/goku_udc.h      |  321 ++
 drivers/usb/gadget/Makefile        |    8 
 drivers/usb/gadget/net2280.c       |  541 +++-
 drivers/usb/gadget/net2280.h       |    6 
 drivers/usb/gadget/zero.c          |  103 
 drivers/usb/hid-core.c             |    4 
 drivers/usb/host/ehci-dbg.c        |   37 
 drivers/usb/host/ehci.h            |   86 
 drivers/usb/host/ehci-hcd.c        |   25 
 drivers/usb/host/ehci-mem.c        |    3 
 drivers/usb/host/ehci-q.c          |   26 
 drivers/usb/host/ehci-sched.c      |  998 +++++----
 drivers/usb/host/sl811.c           |    4 
 drivers/usb/host/usb-ohci.c        |    2 
 drivers/usb/host/usb-ohci.h        |    2 
 drivers/usb/host/usb-uhci.c        |    4 
 drivers/usb/inode.c                |    4 
 drivers/usb/Makefile               |    1 
 drivers/usb/serial/ir-usb.c        |    2 
 drivers/usb/serial/visor.c         |    2 
 drivers/usb/serial/visor.h         |    1 
 drivers/usb/storage/transport.c    |    2 
 drivers/usb/storage/unusual_devs.h |   61 
 drivers/usb/storage/usb.c          |    2 
 drivers/usb/usb.c                  |    2 
 include/linux/usb_gadget.h         |   54 
 34 files changed, 7739 insertions(+), 2085 deletions(-)
-----

<drb:med.co.nz>:
  o USB Storage: patch to unusual_devs.h for Pentax Optio 330GS camera

<felipe_alfaro:linuxmail.org>:
  o USB Storage: unusual_devs.h patch for Trumpion MP3 player

<michael.krauth:web.de>:
  o USB: unusual-devs.h Patch for Kyocera Finecam L3

<tritol:trilogic.cz>:
  o USB: unusual_devs entry for Netac USB-CF

Alan Stern:
  o USB Storage: unusual_devs.h update
  o USB Storage: another unusual_devs entry
  o USB Storage: another unneeded unusual_devs entry
  o USB storage: unusual_devs.h change

Arnaud Quette:
  o USB: disable hiddev support for MGE UPSs

David Brownell:
  o USB:  ehci update:  3/3, highspeed iso rewrite
  o USB: ehci update:  2/3, microframe scanning
  o USB: ehci update:  1/3, misc
  o USB: EHCI support on MIPS
  o USB gadget: net2280 controller driver updates [7/7]
  o USB gadget: ethernet gadget updates [6/7]
  o USB gadget: gadget zero driver updates [5/7]
  o USB gadget: gadget build/config updates [4/7]
  o USB gadget: add goku_udc (Toshiba TC86C001) [3/7]
  o USB gadget: add file_storage gadget driver [2/7]
  o USB gadget: <linux/usb_gadget.h> updates [1/7]

David T. Hollis:
  o USB: Remove standalone AX8817x       driver Config.in entry
  o USB: Remove standalone AX8817x driver

Greg Kroah-Hartman:
  o USB: add support for the Clie PEG-TJ25 device
  o USB: add test for B4000000 to ir-usb driver to fix build issue on some archs

Herbert Xu:
  o USB Storage: revert freecom dvd-rw fx-50 usb-ide patch

Oliver Neukum:
  o USB: 2.4 memory deadlock avoidance
  o USB: memory allocations in storage code path for 2.4

Pete Zaitcev:
  o USB: fix 2.4 usbdevfs race
  o USB: Patch for usb-storage in 2.4

Wolfgang Muees:
  o USB: auerswald driver: add a new device

