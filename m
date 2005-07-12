Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVGLS5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVGLS5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVGLS5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:57:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:54213 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262235AbVGLS50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:57:26 -0400
Date: Tue, 12 Jul 2005 11:56:31 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.13-rc2
Message-ID: <20050712185631.GA23705@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of USB patches against your latest git tree.  They are
all bugfixes with the exception of 2 new drivers being added.  All of
these patches have been in the -mm tree for the past few weeks.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing lists, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/usb/sn9c102.txt          |    4 
 Documentation/usb/usbmon.txt           |   29 -
 drivers/usb/Makefile                   |    2 
 drivers/usb/atm/cxacru.c               |    2 
 drivers/usb/atm/speedtch.c             |   63 +-
 drivers/usb/class/cdc-acm.c            |   31 -
 drivers/usb/core/buffer.c              |    2 
 drivers/usb/core/hcd.c                 |    2 
 drivers/usb/core/hcd.h                 |    8 
 drivers/usb/core/hub.c                 |   40 -
 drivers/usb/core/message.c             |    2 
 drivers/usb/core/sysfs.c               |    2 
 drivers/usb/core/urb.c                 |    4 
 drivers/usb/core/usb.c                 |    5 
 drivers/usb/gadget/dummy_hcd.c         |    9 
 drivers/usb/gadget/ether.c             |   22 
 drivers/usb/gadget/goku_udc.c          |    6 
 drivers/usb/gadget/lh7a40x_udc.c       |    6 
 drivers/usb/gadget/net2280.c           |    8 
 drivers/usb/gadget/omap_udc.c          |    9 
 drivers/usb/gadget/pxa2xx_udc.c        |    6 
 drivers/usb/gadget/zero.c              |    8 
 drivers/usb/host/ehci-hcd.c            |    2 
 drivers/usb/host/ehci-q.c              |    2 
 drivers/usb/host/ehci-sched.c          |   19 
 drivers/usb/host/hc_crisv10.c          |   10 
 drivers/usb/host/isp116x-hcd.c         |   20 
 drivers/usb/host/ohci-hcd.c            |    6 
 drivers/usb/host/ohci-hub.c            |    3 
 drivers/usb/host/ohci-mem.c            |    4 
 drivers/usb/host/ohci-omap.c           |   53 --
 drivers/usb/host/sl811-hcd.c           |    2 
 drivers/usb/host/uhci-q.c              |    2 
 drivers/usb/input/Kconfig              |   13 
 drivers/usb/input/Makefile             |    1 
 drivers/usb/input/hid-core.c           |   24 
 drivers/usb/input/keyspan_remote.c     |  633 ++++++++++++++++++++++++++
 drivers/usb/media/Makefile             |    2 
 drivers/usb/media/sn9c102.h            |    2 
 drivers/usb/media/sn9c102_core.c       |    2 
 drivers/usb/media/sn9c102_ov7630.c     |  394 ++++++++++++++++
 drivers/usb/media/sn9c102_sensor.h     |   16 
 drivers/usb/media/sn9c102_tas5110c1b.c |   21 
 drivers/usb/media/sn9c102_tas5130d1b.c |   27 -
 drivers/usb/misc/Kconfig               |   10 
 drivers/usb/misc/Makefile              |    1 
 drivers/usb/misc/ldusb.c               |  794 +++++++++++++++++++++++++++++++++
 drivers/usb/mon/mon_text.c             |   48 +
 drivers/usb/net/kaweth.c               |    4 
 drivers/usb/serial/ftdi_sio.c          |  756 +++++--------------------------
 drivers/usb/storage/unusual_devs.h     |    2 
 include/linux/usb.h                    |    8 
 include/linux/usb_cdc.h                |   13 
 include/linux/usb_gadget.h             |   12 
 54 files changed, 2294 insertions(+), 882 deletions(-)

----

Andrew Morton:
  USB: net2280 warning fix
  USB: khubd: use kthread API

brian@murphy.dk:
  USB: export usb_get_intf() and usb_put_intf()
  USB: fix usb reference count bug in cdc-acm driver

david-b@pacbell.net:
  USB: fix ohci merge glitch
  USB: ohci-omap pm updates
  USB: another cdc descriptor
  USB: omap_udc tweaks

Duncan Sands:
  USB ATM: robustify poll throttling
  USB ATM: line speed measured in Kb not Kib
  USB ATM: fix line resync logic

Greg Kroah-Hartman:
  USB: fix ftdi_sio compiler warnings
  USB: add bMaxPacketSize0 attribute to sysfs

Ian Abbott:
  USB ftdi_sio: reduce device id table clutter
  USB ftdi_sio: remove redundant TIOCMBIS and TIOCMBIC code

Ian Campbell:
  USB: gadget/ether build fixes.
  USB: gadget/ether fixes

KAMBAROV, ZAUR:
  USB: coverity: (desc->bitmap)[] overrun fix

Luca Risolia:
  USB: SN9C10x driver updates

Michael Downey:
  USB: add driver for Keyspan Digital Remote

Michael Hund:
  USB: add ldusb driver
  USB: add LD devices to hid blacklist

Olav Kongas:
  USB: Fix kmalloc's flags type in USB
  USB: isp116x-hcd cleanup

Pete Zaitcev:
  USB: Patch to make usbmon to print control setup packets

Phil Dibowitz:
  USB Storage: Remove unneeded SC/P

Thomas Winischhofer:
  USB: SiS USB Makefile fixes

