Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWHCAT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWHCAT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWHCAT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:19:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:61876 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750712AbWHCAT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:19:26 -0400
Date: Wed, 2 Aug 2006 17:14:56 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.18-rc3
Message-ID: <20060803001455.GA9534@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a some fixes for USB against 2.6.18-rc1.  They do the
following:
	- revert the two USB patches that forced people to upgrade udev
	  to a newer version than specified in Documentation/Changes
	- removed the anydata driver, as the option driver does
	  everything it did already, and it's supported by an active
	  developer
	- lots of device id updates
	- some documentation fixes
	- lots of bugfixes (most minor, but a few are big enough to have
	  been reported.)

Some of these changes have been in the -mm tree for a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/usb/proc_usb_info.txt |    2 
 Documentation/usb/usb-help.txt      |    3 -
 drivers/usb/Kconfig                 |    2 
 drivers/usb/core/devio.c            |   20 ++--
 drivers/usb/core/file.c             |   13 +--
 drivers/usb/gadget/Kconfig          |    2 
 drivers/usb/gadget/at91_udc.c       |  176 ++++++++++++++++++++++-------------
 drivers/usb/gadget/at91_udc.h       |    1 
 drivers/usb/gadget/dummy_hcd.c      |    6 +
 drivers/usb/host/ehci-hcd.c         |    2 
 drivers/usb/host/ohci-at91.c        |   88 ++++++++++++------
 drivers/usb/host/ohci-hcd.c         |    3 -
 drivers/usb/host/uhci-q.c           |    4 +
 drivers/usb/input/ati_remote.c      |    5 -
 drivers/usb/misc/cypress_cy7c63.c   |    9 +-
 drivers/usb/net/rtl8150.c           |   83 ++++++++++++++---
 drivers/usb/serial/Kconfig          |   24 ++---
 drivers/usb/serial/Makefile         |    1 
 drivers/usb/serial/anydata.c        |  123 ------------------------
 drivers/usb/serial/ftdi_sio.c       |    1 
 drivers/usb/serial/ftdi_sio.h       |    4 +
 drivers/usb/serial/ipaq.c           |    1 
 drivers/usb/serial/option.c         |   76 +--------------
 drivers/usb/serial/pl2303.c         |    1 
 drivers/usb/serial/pl2303.h         |    4 +
 drivers/usb/storage/unusual_devs.h  |   29 +++---
 drivers/usb/storage/usb.c           |   13 ++-
 include/linux/usb.h                 |    7 +
 include/linux/usb_usual.h           |    4 +
 29 files changed, 343 insertions(+), 364 deletions(-)
 delete mode 100644 drivers/usb/serial/anydata.c

---------------

Adrian Bunk:
      USB: fix the USB_GADGET_DUMMY_HCD dependencies

Alan Stern:
      USB: dummy-hcd: disable interrupts during req->complete
      USB: unusual_devs entry for Nokia 3250
      USB: UHCI: Don't test the Short Packet Detect bit

Daniel Drake:
      usb-storage: Add US_FL_IGNORE_DEVICE flag; ignore ZyXEL G220F

Dave Platt:
      USB: Additional PID for the ftdi_sio driver

David Brownell:
      USB: AT91 UDC updates, mostly power management
      USB: AT91 OHCI updates, mostly power management

Greg Kroah-Hartman:
      Revert "USB: convert usb class devices to real devices"
      Revert "USB: move usb_device_class class devices to be real devices"

Kim Oldfield:
      USB: New USB ID for Belkin Serial Adapter

Li Yang:
      USB: Fix Freescale high-speed USB host dependency

Luiz Fernando N. Capitulino:
      USB: doc: usb-help.txt update.
      USB: doc: fixes devio.c location in proc_usb_info.txt.

Marko Macek:
      USB: ati_remote.c: autorepeat fix

Matthias Urlichs:
      USB: Option driver: removed change history and linux/version.h include
      USB: Option driver: Short driver names were identical
      USB: Let option driver handle Anydata CDMA modems. Remove anydata driver.
      USB: Drop Sierra Wireless MC8755 from the Option driver
      USB: Removed 3-port device handler from Option driver

Norihiko Tomiyama:
      USB: adding support for SHARP WS003SH to ipaq.c

Oliver Bock:
      USB: cypress driver comment updates

Peter Chubb:
      USB: Patch for rtl8150 to fix unplug problems

Phil Dibowitz:
      USB: unusual_devs device removal

