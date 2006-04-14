Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWDNUBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWDNUBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWDNUBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:01:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:25036 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965073AbWDNUBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:01:32 -0400
Date: Fri, 14 Apr 2006 13:00:30 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes and patches for 2.6.17-rc1
Message-ID: <20060414200030.GA5693@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB fixes for 2.6.17-rc1.  They consist of the following
changes:
	- unified touchscreen driver, fixing issues in the older ones
	- new usb-serial driver (fixing an issue it had with the generic
	  driver).
	- move a header file so a wireless usb driver can be added to
	  the kernel.
	- usb gadget updates and fixes
	- new device ids added
	- other random bugfixes.

All of these changes have been in the -mm tree for a number of weeks.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/usb/atm/ueagle-atm.c       |   52 ++-
 drivers/usb/core/Kconfig           |    7 
 drivers/usb/core/hub.c             |    8 
 drivers/usb/core/usb.c             |    2 
 drivers/usb/gadget/Kconfig         |    4 
 drivers/usb/gadget/at91_udc.c      |    4 
 drivers/usb/gadget/ether.c         |    6 
 drivers/usb/gadget/file_storage.c  |   38 +-
 drivers/usb/gadget/gadget_chips.h  |    6 
 drivers/usb/gadget/inode.c         |   24 -
 drivers/usb/gadget/net2280.c       |   93 ++++-
 drivers/usb/gadget/net2280.h       |  415 -------------------------
 drivers/usb/gadget/zero.c          |    7 
 drivers/usb/host/ohci-at91.c       |   35 +-
 drivers/usb/host/ohci-s3c2410.c    |   41 +-
 drivers/usb/host/pci-quirks.c      |    1 
 drivers/usb/host/pci-quirks.h      |    7 
 drivers/usb/host/uhci-hcd.c        |    7 
 drivers/usb/host/uhci-hcd.h        |    1 
 drivers/usb/host/uhci-hub.c        |   18 -
 drivers/usb/input/Kconfig          |   60 +--
 drivers/usb/input/Makefile         |    1 
 drivers/usb/input/hid-core.c       |   14 
 drivers/usb/input/hid-ff.c         |    6 
 drivers/usb/input/hid.h            |    5 
 drivers/usb/input/keyspan_remote.c |    2 
 drivers/usb/input/usbtouchscreen.c |  605 +++++++++++++++++++++++++++++++++++++
 drivers/usb/input/wacom.c          |  136 +++++---
 drivers/usb/misc/usbtest.c         |   13 
 drivers/usb/net/asix.c             |  327 +++++++++----------
 drivers/usb/net/pegasus.c          |    2 
 drivers/usb/net/rndis_host.c       |   28 +
 drivers/usb/serial/Kconfig         |    9 
 drivers/usb/serial/Makefile        |    1 
 drivers/usb/serial/console.c       |    2 
 drivers/usb/serial/ftdi_sio.c      |    2 
 drivers/usb/serial/ftdi_sio.h      |   15 
 drivers/usb/serial/funsoft.c       |   65 +++
 drivers/usb/serial/pl2303.c        |    1 
 drivers/usb/serial/pl2303.h        |    4 
 drivers/usb/serial/usb-serial.c    |   16 
 drivers/usb/serial/usb-serial.h    |    6 
 include/linux/usb/net2280.h        |  444 +++++++++++++++++++++++++++
 43 files changed, 1741 insertions(+), 799 deletions(-)

---------------

Adrian Bunk:
      USB: pci-quirks.c: proper prototypes
      USB: input/: proper prototypes
      USB: drivers/usb/core/: remove unused exports

Alan Stern:
      USB: g_file_storage: Set short_not_ok for bulk-out transfers
      USB: g_file_storage: add comment about buffer allocation
      USB: g_file_storage: use module_param_array_named macro
      USB: UHCI: don't track suspended ports

Ben Dooks:
      USB: cleanups for ohci-s3c2410.c
      USB: S3C2410: use clk_enable() to ensure 48MHz to OHCI core

Daniel Ritz:
      USB: usbtouchscreen: unified USB touchscreen driver
      usb/input: remove Kconfig entries of old touchscreen drivers in favour of usbtouchscreen

David Brownell:
      USB: otg hub support is optional
      USB: fix gadget_is_musbhdrc()
      USB: net2280 short rx status fix
      USB: rndis_host whitespace/comment updates
      USB: gadgetfs highspeed bugfix
      USB: gadget zero poisons OUT buffers
      USB: at91 usb driver supend/resume fixes
      USB: usbtest: scatterlist OUT data pattern testing
      USB: g_ether, highspeed conformance fix

David Hollis:
      USB: Rename ax8817x_func() to asix_func() and add utility functions to reduce bloat

Folkert van Heusden:
      USB: add support for Papouch TMU (USB thermometer)

Greg Kroah-Hartman:
      USB: add driver for funsoft usb serial device

Guennadi Liakhovetski:
      USB: net2282 and net2280 software compatibility

Ian Abbott:
      USB: ftdi_sio: add support for Eclo COM to 1-Wire USB adapter

Jeffrey Vandenbroucke sign:
      hid-core.c: fix "input irq status -32 received" for Silvercrest USB Keyboard

Luiz Fernando Capitulino:
      USB serial: Converts port semaphore to mutexes.

matthieu castet:
      USB: UEAGLE : cosmetic
      USB: UEAGLE : support geode
      USB: UEAGLE : null pointer dereference fix
      USB: UEAGLE : memory leack fix

Michael Downey:
      USB: keyspan-remote bugfix

Paul Fulghum:
      USB: remove __init from usb_console_setup

Pete Zaitcev:
      USB: linux/usb/net2280.h common definitions

Petko Manolov:
      USB: pegasus driver bugfix

Ping Cheng:
      USB: wacom tablet driver update
      USB: add new wacom devices to usb hid-core list

Tomasz Kazmierczak:
      USB: pl2303: added support for OTi's DKU-5 clone cable

