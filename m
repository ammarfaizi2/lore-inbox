Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267684AbUBTBbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUBTB2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:28:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:38830 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267685AbUBTB2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:28:04 -0500
Date: Thu, 19 Feb 2004 17:28:03 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.6.3
Message-ID: <20040220012802.GA16523@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB patches for 2.6.3.  Here are the main types of changes:
	- switch usb code to use dmapools instead of pcipools which
	  makes the embedded people happy.
	- host controller driver updates for EHCI and UHCI drivers
	- usb storage driver updates.
	- a few other minor bug fixes.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/class/usblp.c          |   20 -
 drivers/usb/core/buffer.c          |   23 -
 drivers/usb/core/hcd-pci.c         |   31 +
 drivers/usb/core/hcd.c             |   38 +-
 drivers/usb/core/hcd.h             |    7 
 drivers/usb/core/hub.c             |    9 
 drivers/usb/core/message.c         |   26 +
 drivers/usb/core/usb.c             |   13 
 drivers/usb/host/ehci-dbg.c        |   24 -
 drivers/usb/host/ehci-hcd.c        |   18 -
 drivers/usb/host/ehci-hub.c        |    2 
 drivers/usb/host/ehci-mem.c        |   40 +-
 drivers/usb/host/ehci-q.c          |    2 
 drivers/usb/host/ehci-sched.c      |  592 ++++++++++++++++++++++++-------------
 drivers/usb/host/ehci.h            |   80 +++--
 drivers/usb/host/ohci-hcd.c        |    8 
 drivers/usb/host/ohci-mem.c        |   20 -
 drivers/usb/host/ohci-omap.c       |   12 
 drivers/usb/host/ohci-pci.c        |   45 +-
 drivers/usb/host/ohci-q.c          |    4 
 drivers/usb/host/ohci-sa1111.c     |   16 -
 drivers/usb/host/ohci.h            |   12 
 drivers/usb/host/uhci-debug.c      |   35 +-
 drivers/usb/host/uhci-hcd.c        |  386 +++++++++++-------------
 drivers/usb/host/uhci-hcd.h        |   30 +
 drivers/usb/host/uhci-hub.c        |  157 +++++----
 drivers/usb/media/stv680.c         |   16 -
 drivers/usb/misc/usbtest.c         |   19 +
 drivers/usb/serial/ftdi_sio.c      |   13 
 drivers/usb/serial/ftdi_sio.h      |    4 
 drivers/usb/storage/sddr09.c       |   31 +
 drivers/usb/storage/transport.c    |   78 ++--
 drivers/usb/storage/unusual_devs.h |   86 +++--
 33 files changed, 1111 insertions(+), 786 deletions(-)
-----

Alan Stern:
  o USB: Use driver-model logging in the UHCI driver
  o USB: Repair unusual_devs.h entry
  o USB: Another unusual_devs.h update
  o USB: More UHCI root hub code improvements
  o USB: Improve UHCI root hub code: descriptor, OC bits, etc
  o USB Storage: unusual_devs.h fixup
  o USB Storage: Reduce auto-sensing for CB transport
  o USB Storage: Treat STALL as failure for CB[I]
  o USB Storage: Handle excess 0-length data packets
  o USB: Mask "HC Halted" bit in the UHCI status register
  o USB: Simplify locking in UHCI
  o USB: ERRBUF_LEN compiling error when PAGE_SIZE=64KB on IA64
  o USB: Even out distribution of UHCI interrupt transfers
  o USB: Remove unneeded and error-provoking variable in UHCI

Andries E. Brouwer:
  o USB: add comments to sddr09.c

David Brownell:
  o USB: ehci-hcd, scheduler handles TT collisions (3/3)
  o USB: ehci-hcd, fullspeed iso data structures (2/3)
  o USB: ehci-hcd, fullspeed iso data structures (1/3)
  o USB: usbtest, two more protocol cases
  o USB: usbcore, avoid RNDIS configs
  o USB: usbcore, hub driver enables TT-per-port mode
  o USB: usbcore, scatterlist cleanups
  o USB: EHCI updates (mostly periodic schedule scanning)

Deepak Saxena:
  o USB: Fix USB host code to use generic DMA API

Domen Puncer:
  o USB: some stv680 fixes

Greg Kroah-Hartman:
  o USB storage: sync up with some missing unusual_devs entries that were in my tree
  o USB: fix up compile errors in uhci driver

Ian Abbott:
  o USB: ftdi_sio new PIDs and name fix for sysfs

Matthew Dharm:
  o USB Storage: Fix small endian-ness bug
  o USB Storage: Reduce unsolicited auto-sense
  o USB Storage: Save the SCSI residue value when auto-sensing

Paulo Marques:
  o USB: fix usblp.c

