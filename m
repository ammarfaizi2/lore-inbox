Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUCQX76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUCQX76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:59:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:41443 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262208AbUCQX7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:59:49 -0500
Date: Wed, 17 Mar 2004 15:59:33 -0800
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com, zaitcev@redhat.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.4.26-pre4
Message-ID: <20040317235933.GA20237@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the long delay, I haven't had much time to be doing 2.4 work.
Hence the last patch in this changeset (more on that below...)

Anyway, here are a bunch of small bugfixes against the 2.4.26-pre4
kernel.  There are also some usb gadget driver updates that bring them
more in sync with what is in the current 2.6 kernel.

Please pull from:  bk://linuxusb.bkbits.net/usb-devel-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

The last changeset in this series changes the USB maintainer for the 2.4
kernel from me to Pete Zaitcev.  I would like to thank Pete for taking
on this responsibility, and wish him the best of luck.  So that means
any 2.4 USB patches should be sent to him, not me :)

thanks,

greg k-h


 MAINTAINERS                        |   22 ++--
 drivers/usb/audio.c                |   16 +--
 drivers/usb/gadget/Config.in       |    3 
 drivers/usb/gadget/Makefile        |    4 
 drivers/usb/gadget/config.c        |  115 ++++++++++++++++++++++
 drivers/usb/gadget/ether.c         |  191 ++++++++++++++++++------------------
 drivers/usb/gadget/gadget_chips.h  |   57 ++++++++++
 drivers/usb/gadget/net2280.c       |    1 
 drivers/usb/gadget/usbstring.c     |   92 ++++++++++++++---
 drivers/usb/gadget/zero.c          |  193 +++++++++++++++++--------------------
 drivers/usb/hcd.c                  |   48 +++++----
 drivers/usb/hid-core.c             |   17 ++-
 drivers/usb/hiddev.c               |   78 ++++++++++----
 drivers/usb/host/ehci-dbg.c        |    2 
 drivers/usb/host/ehci-hub.c        |    2 
 drivers/usb/host/ehci-sched.c      |   96 ++++++------------
 drivers/usb/pegasus.h              |    5 
 drivers/usb/printer.c              |   35 ++++--
 drivers/usb/serial/ftdi_sio.c      |   20 +++
 drivers/usb/serial/ftdi_sio.h      |   12 ++
 drivers/usb/serial/io_edgeport.c   |    4 
 drivers/usb/serial/pl2303.c        |    8 +
 drivers/usb/serial/visor.c         |    2 
 drivers/usb/serial/visor.h         |    3 
 drivers/usb/storage/unusual_devs.h |   28 +++--
 include/linux/hiddev.h             |   76 ++++++++------
 include/linux/usb_gadget.h         |   16 ++-
 drivers/usb/storage/unusual_devs.h |    0 
 28 files changed, 750 insertions(+), 396 deletions(-)
-----

<brill:fs.math.uni-frankfurt.de>:
  o USB Storage: unusual_devs.h entry submission

<jamesl:appliedminds.com>:
  o USB: Fixing HID support for non-explicitly specified usages

<michal_dobrzynski:mac.com>:
  o USB: add IRTrans support to ftdi_sio driver

<mlotek:foobar.pl>:
  o USB: another unusual_devs.h change

<not:just.any.name>:
  o USB: Using physical extents instead of logical ones for NEC USB HID gamepads

<pg:futureware.at>:
  o USB: more FTDI-SIO devices

Alan Stern:
  o USB: fix unneeded SubClass entry in unusual_devs.h

David Brownell:
  o USB: gadget zero, simplified controller-specific configuration
  o USB: usb gadget, dualspeed {run,compile}-time flags
  o USB: gadget config buffer utilities
  o USB: add "gadget_chips.h"
  o USB Gadget: make usb gadget strings talk utf-8
  o USB: EHCI updates (mostly periodic schedule scanning)
  o USB Gadget: ethernet gadget locking tweaks

Greg Kroah-Hartman:
  o USB: add support for the Aceeca Meazura device to the visor driver

Ian Abbott:
  o USB: ftdi_sio new PIDs and name fix for sysfs

Luca Tettamanti:
  o USB: fix hid-core compile warning

Martin Diehl:
  o USB: fix stack usage in pl2303 driver

Paulo Marques:
  o USB: usblp.c (Was: usblp_write spins forever after an error)

Per Winkvist:
  o USB Storage: unusual devs fix for Pentax cameras

Pete Zaitcev:
  o USB: Change the USB Maintainer entry

Petko Manolov:
  o USB: another patch to pegasus.h
  o USB: patch for pegasus.h

Richard Curnow:
  o USB: Fix handling of bounce buffers by rh_call_control

Thomas Chen:
  o USB: fix little bug in io_edgeport.c

Thomas Sailer:
  o USB: OSS audio driver workaround for buggy descriptors

