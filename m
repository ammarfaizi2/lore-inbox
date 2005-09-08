Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbVIHXuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVIHXuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVIHXuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:50:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:39041 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965083AbVIHXuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:50:54 -0400
Date: Thu, 8 Sep 2005 16:50:24 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.13
Message-ID: <20050908235024.GA8159@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of USB patches against your latest git tree.  These
have all been in the -mm tree for a number of weeks.  They include a few
new drivers, a rework of the usbnet drivers, and lots of bugfixes all
around.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing lists, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/input/yealink.txt     |  221 ++
 MAINTAINERS                         |    6 
 drivers/block/ub.c                  |  493 ++---
 drivers/net/irda/irda-usb.c         |   13 
 drivers/usb/atm/cxacru.c            |    2 
 drivers/usb/class/Kconfig           |   21 
 drivers/usb/class/usblp.c           |    9 
 drivers/usb/core/Makefile           |    4 
 drivers/usb/core/devio.c            |  116 +
 drivers/usb/core/hcd.h              |    8 
 drivers/usb/core/hub.c              |  115 -
 drivers/usb/core/hub.h              |    7 
 drivers/usb/core/inode.c            |    9 
 drivers/usb/core/message.c          |    8 
 drivers/usb/core/urb.c              |   26 
 drivers/usb/core/usb.c              |   35 
 drivers/usb/core/usb.h              |    5 
 drivers/usb/gadget/ether.c          |   33 
 drivers/usb/gadget/file_storage.c   |   33 
 drivers/usb/gadget/gadget_chips.h   |   55 
 drivers/usb/gadget/serial.c         |   51 
 drivers/usb/gadget/zero.c           |   48 
 drivers/usb/host/ehci-q.c           |    7 
 drivers/usb/host/ehci-sched.c       |    4 
 drivers/usb/host/ehci.h             |    2 
 drivers/usb/host/isp116x-hcd.c      |   88 
 drivers/usb/host/ohci-ppc-soc.c     |   24 
 drivers/usb/host/ohci-s3c2410.c     |    4 
 drivers/usb/input/Kconfig           |   14 
 drivers/usb/input/Makefile          |    1 
 drivers/usb/input/hid-core.c        |    9 
 drivers/usb/input/keyspan_remote.c  |    5 
 drivers/usb/input/map_to_7segment.h |  189 ++
 drivers/usb/input/yealink.c         | 1023 ++++++++++
 drivers/usb/input/yealink.h         |  220 ++
 drivers/usb/misc/auerswald.c        |    3 
 drivers/usb/misc/ldusb.c            |    6 
 drivers/usb/misc/sisusbvga/sisusb.c |    4 
 drivers/usb/misc/usbtest.c          |    2 
 drivers/usb/mon/Makefile            |    2 
 drivers/usb/mon/mon_dma.c           |   55 
 drivers/usb/mon/mon_text.c          |   35 
 drivers/usb/mon/usb_mon.h           |    4 
 drivers/usb/net/Kconfig             |  302 +--
 drivers/usb/net/Makefile            |    8 
 drivers/usb/net/asix.c              |  948 ++++++++++
 drivers/usb/net/catc.c              |    2 
 drivers/usb/net/cdc_ether.c         |  509 +++++
 drivers/usb/net/cdc_subset.c        |  335 +++
 drivers/usb/net/gl620a.c            |  407 ++++
 drivers/usb/net/kaweth.c            |    1 
 drivers/usb/net/net1080.c           |  622 ++++++
 drivers/usb/net/pegasus.c           |    1 
 drivers/usb/net/plusb.c             |  156 +
 drivers/usb/net/rndis_host.c        |  615 ++++++
 drivers/usb/net/rtl8150.c           |    1 
 drivers/usb/net/usbnet.c            | 3372 +-----------------------------------
 drivers/usb/net/usbnet.h            |  195 ++
 drivers/usb/net/zaurus.c            |  386 ++++
 drivers/usb/net/zd1201.c            |    1 
 drivers/usb/serial/cypress_m8.c     |  253 +-
 drivers/usb/serial/ftdi_sio.c       |   56 
 drivers/usb/serial/ftdi_sio.h       |   54 
 drivers/usb/serial/keyspan.c        |    8 
 drivers/usb/serial/option.c         |  203 --
 drivers/usb/serial/pl2303.c         |    6 
 drivers/usb/serial/usb-serial.c     |   24 
 drivers/usb/storage/Kconfig         |   12 
 drivers/usb/storage/Makefile        |    1 
 drivers/usb/storage/onetouch.c      |  234 ++
 drivers/usb/storage/onetouch.h      |    9 
 drivers/usb/storage/scsiglue.c      |    8 
 drivers/usb/storage/shuttle_usbat.c |  101 -
 drivers/usb/storage/transport.c     |   17 
 drivers/usb/storage/unusual_devs.h  |   19 
 drivers/usb/storage/usb.c           |   79 
 drivers/usb/storage/usb.h           |    1 
 include/linux/usb.h                 |   11 
 include/linux/usb_isp116x.h         |   30 
 sound/usb/usbaudio.c                |   10 
 80 files changed, 7673 insertions(+), 4343 deletions(-)

------

Adrian Bunk:
  USB: schedule OSS USB drivers for removal

Alan Stern:
  USB: Fix regression in core/devio.c
  USB: URB_ASYNC_UNLINK flag removed from the kernel
  USB: Code motion in the hub driver
  USB: Disconnect children when unbinding the hub driver
  USB: Add timeout to usb_lock_device_for_reset
  USB: Support unbinding of the usb_generic driver

Alexey Dobriyan:
  USB ldusb: fmt warnings fixes for 64-bit platforms

Andrew de Quincey:
  USB: Prevent hid-core claiming Apple Bluetooth device on new G4 powerbooks

Andrew Morton:
  USB: option card driver coding style tweaks

Ben Dooks:
  USB: S3C24XX port numbering fix

Dale Farnsworth:
  USB: Fix typo in ohci-ppc-soc.c: usb_hcd_put => usb_put_hcd
  USB: remove include of asm/usb.h in ohci-ppc-soc.c

Daniel Drake:
  USB: Fix HP8200 detection in shuttle_usbat

Dariusz M:
  USB: pl2303 driver, makes pl2303HX chip work correctly

David Brownell:
  USB: Gadget library: centralize gadget controller numbers
  USB: usbnet (1/9) clean up framing
  USB: usbnet (3/9) module for ASIX Ethernet adapters
  USB: usbnet (2/9) module for simple network links
  USB: usbnet (4/9) module for net1080 cables
  USB: usbnet (6/9) module for Zaurii and compatibles
  USB: usbnet (7/9) module for CDC Ethernet
  USB: usbnet (5/9) module for genesys gl620a cables
  USB: usbnet (9/9) module for pl2301/2302 cables
  USB: usbnet (8/9) module for RNDIS devices

david-b@pacbell.net:
  USB: usbnet and unsigned gfp_flags
  USB: remove annoying message
  USB: tweak highspeed timing calculations
  ehci: add think_time
  ehci: add tt_usecs

Greg Kroah-Hartman:
  USB: fix keyspan_remote endian bug on probe
  USB: fix up URB_ASYNC_UNLINK usages from the usb-serial drivers
  USB: fix endian issues in yealink driver.

Henk:
  input-driver-yealink-P1K-usb-phone
  USB: yealink: fix htons usage, documentation updates

Ian Abbott:
  USB ftdi_sio: user specified VID/PID
  USB ftdi_sio: New IDs for ELV, Xsens and Falcom products

Kay Sievers:
  USB: real nodes instead of usbfs

Lonnie Mendez:
  USB: whitespace fixes for cypress_m8 driver

Matthew Dharm:
  USB Storage: remove dependency on SCSI-provided serial/tag number
  USB Storage: close a race condition in disconnect near probe
  USB Storage: close a race condition in disconnect near queuecommand
  USB Storage: add support for Maxtor One-Touch button
  USB Storage: wedge SCSI revision at 2 for usb-storage devices

Mihnea-Costin Grigore:
  usb-storage: Add IGNORE_RESIDUE flag for Mitsumi USB 2.0 card reader (VIA hardware)

Nick Sillik:
  USB Storage: code cleanups for onetouch.c

Olav Kongas:
  USB: isp116x-hcd: support only per-port power switching
  USB: isp116x-hcd: remove unnecessary ClockNotStop configuration option
  USB: isp116x-hcd: use fixed power-on-to-power-good-time
  USB: Switch isp116x-hcd over to root hub interrupt
  USB: isp116x-hcd: per-port overcurrent reporting
  USB: isp116x-hcd: remove clock() and reset()

Pete Zaitcev:
  USB: ub 2/3: Fold one line
  USB: ub 1/3: Axboe's quasi-S/G
  USB: ub 3/3: death to ub_bd_rq_fn_1
  USB: ub 4: Zaitcev's quasi-S/G
  usbmon in 2.6.13: peeking into DMA areas

Randy Dunlap:
  USB usblp: rate-limit printer status error messages

Tobias Klauser:
  USB: drivers/serial/usb-serial: Remove unneeded void * casts

