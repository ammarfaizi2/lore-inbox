Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbVBEGix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbVBEGix (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbVBEGhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:37:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:8141 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265754AbVBEGgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:36:10 -0500
Date: Fri, 4 Feb 2005 22:35:51 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: bk-usb is now safe (was 2.6.11-rc3-mm1)
Message-ID: <20050205063551.GB1340@kroah.com>
References: <20050204103350.241a907a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 10:33:50AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/
> 
> 
> - The bk-usb and bk-pci and bk-driver-core trees have been temporarily
>   dropped from -mm, for they are not healthy at present.

Ok, I've cleaned up the bk-usb tree a bunch.  If anyone had a previous
copy of it, please just delete it and clone it again.  It's at:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6
and is safe for consumption.

Andrew, can you put it back into the next -mm release?

Oh, and below is the diffstat and changelog of the patches in it.  I've
also placed a full patch of it, against the 2.6.11-rc3-bk1 tree for
those who don't like to use bk, or are just curious about putting this
on top of the latest -mm release:
	kernel.org/pub/linux/kernel/people/gregkh/usb/2.6/2.6.11-rc3/bk-usb-2.6.11-rc3-mm1.patch

Also, if you have sent me a USB patch that is not already in the
mainline tree, and is not included in this big patch-bundle, please
resend it, as my USB patch queue is now empty.  

Oops, no, I have a pending patch from Petko Manolov that didn't make it
into here, sorry about that Petko, I'll get to that one next week.

Next up, the bk-pci and bk-driver-core mess...

thanks,

greg k-h

-------
 CREDITS                             |    5 
 Documentation/usb/sn9c102.txt       |   13 
 MAINTAINERS                         |    6 
 drivers/block/ub.c                  |  181 +-
 drivers/usb/Kconfig                 |    2 
 drivers/usb/Makefile                |    2 
 drivers/usb/class/cdc-acm.c         |   84 
 drivers/usb/class/cdc-acm.h         |   49 
 drivers/usb/core/hcd.c              |  166 +
 drivers/usb/core/hcd.h              |   60 
 drivers/usb/core/hub.c              |   56 
 drivers/usb/core/hub.h              |    1 
 drivers/usb/gadget/Kconfig          |    8 
 drivers/usb/gadget/ether.c          |  237 --
 drivers/usb/gadget/net2280.c        |   25 
 drivers/usb/gadget/omap_udc.c       |   30 
 drivers/usb/gadget/rndis.c          |    2 
 drivers/usb/gadget/serial.c         |  154 -
 drivers/usb/host/Kconfig            |   36 
 drivers/usb/host/ohci-dbg.c         |    4 
 drivers/usb/host/ohci-hcd.c         |   34 
 drivers/usb/host/ohci-omap.c        |   98 -
 drivers/usb/host/ohci-ppc-soc.c     |  299 +++
 drivers/usb/host/ohci-q.c           |    9 
 drivers/usb/host/ohci.h             |   48 
 drivers/usb/host/uhci-debug.c       |    9 
 drivers/usb/host/uhci-hcd.c         | 1497 -----------------
 drivers/usb/host/uhci-q.c           | 1488 +++++++++++++++++
 drivers/usb/image/mdc800.c          |   42 
 drivers/usb/input/ati_remote.c      |   19 
 drivers/usb/input/hid-core.c        |   20 
 drivers/usb/input/wacom.c           |  335 +++
 drivers/usb/media/sn9c102.h         |    6 
 drivers/usb/media/sn9c102_core.c    |   52 
 drivers/usb/misc/Kconfig            |    2 
 drivers/usb/misc/Makefile           |    2 
 drivers/usb/misc/auerswald.c        |   19 
 drivers/usb/misc/sisusbvga/Kconfig  |   14 
 drivers/usb/misc/sisusbvga/Makefile |    6 
 drivers/usb/misc/sisusbvga/sisusb.c | 3144 ++++++++++++++++++++++++++++++++++++
 drivers/usb/misc/sisusbvga/sisusb.h |  278 +++
 drivers/usb/mon/Kconfig             |   22 
 drivers/usb/mon/Makefile            |    7 
 drivers/usb/mon/mon_main.c          |  377 ++++
 drivers/usb/mon/mon_stat.c          |   74 
 drivers/usb/mon/mon_text.c          |  395 ++++
 drivers/usb/mon/usb_mon.h           |   51 
 drivers/usb/net/Kconfig             |    4 
 drivers/usb/net/kaweth.c            |   13 
 drivers/usb/net/usbnet.c            |  571 +++++-
 drivers/usb/serial/cypress_m8.c     |    6 
 drivers/usb/serial/ftdi_sio.c       |    3 
 drivers/usb/serial/ftdi_sio.h       |    1 
 drivers/usb/serial/io_edgeport.c    |   49 
 drivers/usb/storage/Kconfig         |   22 
 drivers/usb/storage/Makefile        |    2 
 drivers/usb/storage/protocol.c      |   39 
 drivers/usb/storage/scsiglue.c      |   10 
 drivers/usb/storage/shuttle_usbat.c | 1258 +++++++++++---
 drivers/usb/storage/shuttle_usbat.h |   82 
 drivers/usb/storage/transport.c     |   23 
 drivers/usb/storage/transport.h     |    5 
 drivers/usb/storage/unusual_devs.h  |   39 
 drivers/usb/storage/usb.c           |   10 
 drivers/usb/storage/usb.h           |    2 
 include/linux/usb.h                 |    4 
 include/linux/usb_cdc.h             |  162 +
 67 files changed, 9056 insertions(+), 2717 deletions(-)


-----


<radford:golemgroup.com>:
  o USB ftdi_sio: an rs485 adaptor from 4n-galaxy.de

Alan Stern:
  o USB: UHCI: Fix build errors when CONFIG_DEBUG_FS isn't set
  o USB: Revised fixups for root-hub message handler
  o USB UHCI: split code from uhci-hcd.c to new file uhci-q.c
  o USB: Initialize connected ports on newly-activated hubs
  o USB: Make use_both_schemes=y the default
  o USB: Retry more aggressively during device initialization

Alex Sanks:
  o USB: don't power down net2280 on suspend

Bernard Blackham:
  o USB: fix types in usb suspend

Daniel Drake:
  o usb-storage: More flexible signature checking mechanism
  o USB: Add USBAT-based CompactFlash storage support
  o USB: Add USBAT02 storage support
  o USB: shuttle_usbat cleanups and generalisations

David Brownell:
  o USB: ohci ppc driver (2/2):  ohci-ppc-soc.c
  o USB: ohci ppc driver (1/2):  big-endian tweaks
  o USB: cdc-acm uses <linux/usb_cdc.h>
  o USB: serial/acm gadget uses <linux/usb_cdc.h>
  o USB: Ethernet/RNDIS gadget driver uses <linux/usb_cdc.h>
  o USB: usbnet uses <linux/usb_cdc.h>
  o USB: usbnet, cleanups and suspend/resume calls
  o USB: pxa2xx_udc isn't for pxa27x
  o USB: omap_udc handles two more devel boards
  o USB: Ethernet/RNDIS build fix on PXA25x
  o USB: add <linux/usb_cdc.h>
  o USB: ohci-omap updates
  o USB: add 'distrust_firmware' option to ohci

David T. Hollis:
  o USB: Add ASIX AX88772 10/100 Ethernet support to usbnet

Greg Kroah-Hartman:
  o USB: remove UB checks in the usb-storage driver
  o USB: fix sparse bitwise warnings in the sisusb.c driver
  o USB: give sisusb a valid minor number (133 - 140)

Luca Risolia:
  o USB: SN9C10x driver bugfix
  o USB: SN9C10x driver bugfix

Matthew Dharm:
  o USB Storage: devices which don't process PREVENT-ALLOW MEDIUM REMOVAL
  o USB storage: make IGNORE_RESIDUE apply for reads (in addition to writes)
  o USB Storage: Remove fix_capacity routine

Nishanth Aravamudan:
  o usb/mdc800: replace wake_up() with wake_up_interruptible()
  o usb/io_edgeport: remove interruptible_sleep_on_timeout() usage
  o usb/kaweth: use wait_event_timeout()
  o usb/hid-core: use wait_event_timeout()
  o usb/ati_remote: use wait_event_timeout()
  o usb/auerswald: use wait_event_timeout()
  o usb/mdc800: use wait_event_timeout()
  o usb/io_edgeport: replace interruptible_sleep_on_timeout() with wait_event_timeout()
  o usb/cypress_m8: replace schedule_timeout() with msleep()

Pete Zaitcev:
  o USB: add usbmon, a USB monitoring framework
  o ub: fix Add ioctls to ub patch
  o USB: Add ioctls to ub

Phil Dibowitz:
  o USB: unusual_devs.h update

Ping Cheng:
  o USB: wacom tablet driver

Thomas Winischhofer:
  o USB: SiS USB2VGA minor fix
  o USB: add SiS USB2VGA kernel driver

