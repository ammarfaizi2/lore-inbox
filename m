Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTFRSIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbTFRSIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:08:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:55507 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265270AbTFRSIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:08:39 -0400
Date: Wed, 18 Jun 2003 11:21:14 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.72
Message-ID: <20030618182114.GA7699@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes for 2.5.72.  Lots of little minor things are in
here, and a new usb network driver was added.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/usb/dma.txt          |   31 
 drivers/usb/Makefile.lib           |    1 
 drivers/usb/class/audio.c          |   28 
 drivers/usb/class/bluetty.c        |    2 
 drivers/usb/class/cdc-acm.c        |  221 +++---
 drivers/usb/class/usb-midi.c       |    4 
 drivers/usb/class/usblp.c          |   36 
 drivers/usb/core/hcd.c             |   28 
 drivers/usb/core/hub.c             |    2 
 drivers/usb/core/message.c         |    3 
 drivers/usb/core/urb.c             |    2 
 drivers/usb/core/usb.c             |   56 +
 drivers/usb/gadget/net2280.c       |    4 
 drivers/usb/host/ehci-dbg.c        |   48 -
 drivers/usb/host/ehci-hcd.c        |   18 
 drivers/usb/host/ehci-q.c          |   49 -
 drivers/usb/host/ehci.h            |    5 
 drivers/usb/input/aiptek.c         |    2 
 drivers/usb/input/hid-core.c       |   19 
 drivers/usb/input/kbtab.c          |    2 
 drivers/usb/input/powermate.c      |    4 
 drivers/usb/input/usbkbd.c         |    5 
 drivers/usb/input/usbmouse.c       |    2 
 drivers/usb/input/wacom.c          |    2 
 drivers/usb/input/xpad.c           |    2 
 drivers/usb/misc/auerswald.c       |   10 
 drivers/usb/misc/brlvger.c         |   10 
 drivers/usb/misc/rio500.c          |   10 
 drivers/usb/misc/rio500_usb.h      |    2 
 drivers/usb/misc/speedtch.c        |  109 ++
 drivers/usb/misc/tiglusb.c         |    4 
 drivers/usb/misc/usblcd.c          |    8 
 drivers/usb/misc/usbtest.c         |    2 
 drivers/usb/net/Kconfig            |   24 
 drivers/usb/net/Makefile           |    1 
 drivers/usb/net/Makefile.mii       |    1 
 drivers/usb/net/ax8817x.c          | 1347 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/net/catc.c             |    4 
 drivers/usb/net/kaweth.c           |   50 +
 drivers/usb/net/pegasus.c          |    6 
 drivers/usb/net/rtl8150.c          |    4 
 drivers/usb/net/usbnet.c           |   12 
 drivers/usb/storage/isd200.c       |   31 
 drivers/usb/storage/protocol.c     |    4 
 drivers/usb/storage/protocol.h     |    2 
 drivers/usb/storage/scsiglue.c     |  195 +----
 drivers/usb/storage/transport.c    |   35 
 drivers/usb/storage/transport.h    |    8 
 drivers/usb/storage/unusual_devs.h |  104 --
 drivers/usb/storage/usb.c          |   74 +-
 drivers/usb/storage/usb.h          |    6 
 include/linux/usb.h                |   51 -
 52 files changed, 2061 insertions(+), 629 deletions(-)
-----

<hanno:gmx.de>:
  o USB: Patch for Vivicam 355

<stefan.becker:nokia.com>:
  o USB: Patch to cdc-acm.c to detect ACM part of USB WMC devices

Alan Stern:
  o USB: Use separate transport_flags bits for transfer_dma
  o USB: Keep root hub status timer running during suspend

David Brownell:
  o USB: usbnet talks to boot loader (blob)
  o USB: net2280, halt ep != 0
  o USB: ehci-hcd micro-patch
  o USB: ehci, fix qh re-activation problem
  o USB:  ehci-hcd: short reads, chip workaround, cleanup

David T. Hollis:
  o USB: AX8817X Driver for 2.5

Duncan Sands:
  o USB speedtouch: add module parameters

Greg Kroah-Hartman:
  o USB: fix up sparse warnings in drivers/usb/misc/*
  o USB: fix up sparse warnings in drivers/usb/class/*
  o USB: fix up sparse warnings in ax8817x driver
  o USB: fixed up some __user warnings reported by sparse in drivers/usb/net/*

Matthew Dharm:
  o USB storage: avoid NULL-ptr OOPS
  o USB storage: more cleanups
  o USB storage: unusual_devs fixups
  o USB storage: cleanups

Oliver Neukum:
  o USB: convert kaweth to usb_buffer_alloc

Randy Dunlap:
  o USB: handle USB printer error bits independently
  o USB: missed one usblp status buffer change

