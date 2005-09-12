Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVILUPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVILUPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVILUPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:15:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:30405 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932206AbVILUP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:15:28 -0400
Date: Mon, 12 Sep 2005 13:15:01 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] More USB patches for 2.6.13
Message-ID: <20050912201500.GA13298@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch more USB patches against your latest git tree.  They
are pretty all just small bugfixes, with the exception of the big sisvga
driver update.  There's also a revert here for the usb apple bluetooth
problem that was previously pointed out.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing lists, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/input/appletouch.txt         |   84 +
 Documentation/usb/proc_usb_info.txt        |   13 
 drivers/usb/class/audio.c                  |   12 
 drivers/usb/core/hcd.c                     |    3 
 drivers/usb/core/hub.c                     |   11 
 drivers/usb/gadget/inode.c                 |    1 
 drivers/usb/host/ehci-hcd.c                |   28 
 drivers/usb/host/ehci-hub.c                |   27 
 drivers/usb/host/ehci.h                    |    1 
 drivers/usb/host/ohci-dbg.c                |    9 
 drivers/usb/host/ohci-hcd.c                |   14 
 drivers/usb/host/ohci-hub.c                |   22 
 drivers/usb/host/ohci-pxa27x.c             |   48 
 drivers/usb/host/ohci.h                    |    1 
 drivers/usb/host/uhci-hcd.c                |   62 -
 drivers/usb/host/uhci-hcd.h                |   11 
 drivers/usb/host/uhci-hub.c                |   11 
 drivers/usb/host/uhci-q.c                  |    2 
 drivers/usb/input/Kconfig                  |   20 
 drivers/usb/input/Makefile                 |    1 
 drivers/usb/input/appletouch.c             |  469 ++++++++
 drivers/usb/input/hid-core.c               |    2 
 drivers/usb/misc/sisusbvga/Kconfig         |   42 
 drivers/usb/misc/sisusbvga/Makefile        |    4 
 drivers/usb/misc/sisusbvga/sisusb.c        |  463 +++++++-
 drivers/usb/misc/sisusbvga/sisusb.h        |   73 +
 drivers/usb/misc/sisusbvga/sisusb_con.c    | 1658 +++++++++++++++++++++++++++++
 drivers/usb/misc/sisusbvga/sisusb_init.c   | 1047 ++++++++++++++++++
 drivers/usb/misc/sisusbvga/sisusb_init.h   |  830 ++++++++++++++
 drivers/usb/misc/sisusbvga/sisusb_struct.h |  169 ++
 drivers/usb/misc/uss720.c                  |  393 ++++--
 drivers/usb/mon/mon_text.c                 |    2 
 drivers/usb/serial/cp2101.c                |    5 
 drivers/usb/serial/cypress_m8.c            |    3 
 drivers/usb/serial/ftdi_sio.c              |    2 
 drivers/usb/serial/pl2303.c                |    4 
 drivers/usb/serial/pl2303.h                |    4 
 drivers/usb/storage/scsiglue.c             |   20 
 drivers/usb/storage/unusual_devs.h         |   35 
 drivers/usb/storage/usb.c                  |   11 
 drivers/video/console/Kconfig              |    2 
 drivers/video/console/Makefile             |    4 
 include/linux/usbdevice_fs.h               |    2 
 43 files changed, 5277 insertions(+), 348 deletions(-)
--------------------

Alan Stern:
  usbcore: small changes to HCD glue layer
  USB UHCI: remove the FSBR kernel timer

Craig Shelley:
  USB: CP2101 New Device IDs

Daniel Drake:
  USB: usb-storage: Add unusual_devs entry for Neuros Audio MP3 player

David Brownell:
  USB: EHCI port tweaks
  USB: get rid of minor log spamming
  USB: EHCI workaround for NForce and mem > 2GB
  USB: OHCI irq tweak
  USB: OHCI, pxa27x OHCI port power tweaks
  USB: OHCI relies less on NDP register
  USB: relax usbcore reset timings

Greg Kroah-Hartman:
  Revert "USB: Prevent hid-core claiming Apple Bluetooth device on new G4 powerbooks"

Harald Welte:
  USB: fix usbdevice_fs header breakage

Ian Abbott:
  USB: ftdi_sio: custom baud rate fix

Matthew Dharm:
  USB: storage: Fix messed-up locking

Nishanth Aravamudan:
  drivers/usb: fix-up schedule_timeout() usage

Pavol Kurina:
  USB gadgetfs: fixes an error on writing to endpoint file

Pete Zaitcev:
  USB Storage: unusual_devs.h request for Transcend
  USB: Usbmon setup DMA patch

Phil Dibowitz:
  USB: storage: Add unusual_dev SINGLE_LUN entries

Randy Dunlap:
  USB: proc_usb_info.txt: add blank lines

Robert Spanton:
  USB: PL2303: CA-42 Phone cable

Stelian Pop:
  USB: add apple usb touchpad driver

Thomas Sailer:
  usb: fix uss720 schedule with interrupts off

Thomas Winischhofer:
  USB: sisusb[vga] update

