Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbUKEAzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUKEAzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUKEAxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:53:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:61150 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262529AbUKEAtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:49:15 -0500
Date: Thu, 4 Nov 2004 16:35:42 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB patches for 2.6.10-rc1
Message-ID: <20041105003542.GA31842@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB fixes and changes for 2.6.10-rc1.  All of these
patches should have been in the past few -mm releases.

Big fix here is some PCI suspend fixes (yeah, it came along with some
USB suspend fixes, so it all got mushed together...)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/usb/usb-serial.txt  |   56 +
 MAINTAINERS                       |   16 
 drivers/block/Kconfig             |    2 
 drivers/block/ub.c                |   62 +
 drivers/pci/pci-driver.c          |    4 
 drivers/pci/quirks.c              |    6 
 drivers/usb/core/devio.c          |    8 
 drivers/usb/core/hcd-pci.c        |  100 ++-
 drivers/usb/core/hcd.c            |   61 +
 drivers/usb/core/hcd.h            |   10 
 drivers/usb/core/hub.c            |   36 -
 drivers/usb/core/message.c        |   25 
 drivers/usb/core/usb.c            |    8 
 drivers/usb/gadget/Makefile       |    2 
 drivers/usb/gadget/dummy_hcd.c    |  452 +++++++------
 drivers/usb/gadget/ether.c        |    4 
 drivers/usb/gadget/file_storage.c |    4 
 drivers/usb/gadget/serial.c       |  875 ++++++++++++++++++++-------
 drivers/usb/gadget/zero.c         |    2 
 drivers/usb/host/ehci-hcd.c       |  146 ++--
 drivers/usb/host/ehci-hub.c       |   48 -
 drivers/usb/host/ehci-mem.c       |    5 
 drivers/usb/host/ehci-q.c         |    3 
 drivers/usb/host/ehci-sched.c     |    7 
 drivers/usb/host/ehci.h           |   13 
 drivers/usb/host/ohci-dbg.c       |  144 ++--
 drivers/usb/host/ohci-hcd.c       |  110 +--
 drivers/usb/host/ohci-hub.c       |  111 +--
 drivers/usb/host/ohci-lh7a404.c   |   10 
 drivers/usb/host/ohci-mem.c       |   11 
 drivers/usb/host/ohci-omap.c      |   34 -
 drivers/usb/host/ohci-pci.c       |    1 
 drivers/usb/host/ohci-pxa27x.c    |   10 
 drivers/usb/host/ohci-q.c         |  189 +++--
 drivers/usb/host/ohci-sa1111.c    |   10 
 drivers/usb/host/ohci.h           |  262 +++++---
 drivers/usb/host/uhci-hcd.c       |   42 -
 drivers/usb/host/uhci-hcd.h       |    2 
 drivers/usb/host/uhci-hub.c       |    2 
 drivers/usb/input/hid-core.c      |   11 
 drivers/usb/input/powermate.c     |    2 
 drivers/usb/media/stv680.c        |    6 
 drivers/usb/media/usbvideo.c      |   79 --
 drivers/usb/net/Kconfig           |    8 
 drivers/usb/net/catc.c            |    4 
 drivers/usb/net/usbnet.c          |   18 
 drivers/usb/serial/Kconfig        |   15 
 drivers/usb/serial/Makefile       |    1 
 drivers/usb/serial/cypress_m8.c   | 1230 +++++++++++++++++++++++++++++++++++++-
 drivers/usb/serial/cypress_m8.h   |   55 +
 drivers/usb/serial/pl2303.c       |    3 
 drivers/usb/serial/pl2303.h       |   14 
 drivers/usb/serial/usb-serial.c   |  111 ++-
 drivers/usb/serial/usb-serial.h   |   16 
 54 files changed, 3301 insertions(+), 1165 deletions(-)
-----

<arjan:fenrus.demon.nl>:
  o USB: remove dead code in usb video

<lmendez19:austin.rr.com>:
  o cypress_m8: add usb-serial driver 'cypress_m8' to kernel tree
  o usb-serial: add interrupt out support and improved debug messages
  o hid-core: add two devices to device blacklist

Adrian Bunk:
  o USB ohci-dbg.c: remove an unused function
  o USB stv680.c: remove an unused function

Alan Stern:
  o usbcore: add comment to updated hcd.h
  o dummy-hcd: removal hcd release
  o Non-PCI OHCI drivers: remove hcd release
  o USB PCI drivers: hcd release changes
  o usbcore: Make the core release hcd structures
  o dummy-hcd: Refactor startup and shutdown
  o dummy_hcd: minor fixups
  o UHCI: Use a sane timeout for device initialization
  o USB: Dequeuing of root-hub URBs
  o UHCI: Workaround for broken remote wakeup

Arnaldo Carvalho de Melo:
  o USB: add id for Siemens x65 series of mobiles to pl2303 driver

David Brownell:
  o USB: ohci-omap, updates for omap1510/5910 and innovator
  o USB: usb gadget serial driver v2.0
  o USB: usb gadget drivers, minor tweaks
  o USB: ohci, hooks for big-endian registers
  o USB: ohci, remove pre-byteswapped constants
  o USB: clean up error messages
  o USB: fix bug
  o USB: fix ohci_restart warning
  o usbcore, diagnostic tweaks
  o OHCI suspend/resume updates (minor)
  o EHCI suspend/resume updates
  o PCI: make pci_save_state() only happen when no suspend()
  o usbcore and system sleep states

Greg Kroah-Hartman:
  o USB: fix sparse warnings in cypress_m8 driver
  o USB: fix up pl2303 device ids that ended up getting duplicated
  o USB: fix up serial object reference count bug on error path

Jonathan McDowell:
  o USB: add KC2190 support for usbnet

Karsten Wiese:
  o UHCI: Convert remainder to bitwise-and

Nishanth Aravamudan:
  o pci/quirks: replace schedule_timeout() with msleep()

Pete Zaitcev:
  o USB: Patch for ub

Thomas Gleixner:
  o Lock initializer unifying Batch 2 (USB)

