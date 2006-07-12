Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWGLX0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWGLX0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWGLX0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:26:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:22668 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932186AbWGLX0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:26:50 -0400
Date: Wed, 12 Jul 2006 16:23:03 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.18-rc1
Message-ID: <20060712232303.GA22660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a some patches for USB against 2.6.18-rc1.  They do the
following:
	- lots of device id updates
	- add a few new drivers
	- rename a driver and update it to work better (don't know why
	  git didn't notice the rename, I guess it's too big of a
	  change).
	- rename usb-serial.h to include/usb/serial.h to allow
	  out-of-the-tree usb-serial drivers to be able to be built
	  properly.
	- numerous bug fixes
	- security fix in a usb-serial driver

All of these changes have been in the -mm tree for a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/usb/usb-serial.txt                   |    4 
 drivers/usb/Kconfig                                |    1 
 drivers/usb/Makefile                               |    2 
 drivers/usb/class/cdc-acm.c                        |   49 ++--
 drivers/usb/core/Kconfig                           |    3 
 drivers/usb/core/hub.c                             |   10 +
 drivers/usb/core/inode.c                           |    2 
 drivers/usb/gadget/epautoconf.c                    |   16 +
 drivers/usb/gadget/ether.c                         |    8 -
 drivers/usb/gadget/file_storage.c                  |    2 
 drivers/usb/gadget/rndis.c                         |    2 
 drivers/usb/gadget/rndis.h                         |    2 
 drivers/usb/gadget/serial.c                        |    2 
 drivers/usb/gadget/zero.c                          |    2 
 drivers/usb/host/ehci-au1xxx.c                     |   23 +-
 drivers/usb/host/ehci-hcd.c                        |    7 -
 drivers/usb/host/ohci-au1xxx.c                     |    7 -
 drivers/usb/host/ohci-ep93xx.c                     |  225 ++++++++++++++++
 drivers/usb/host/ohci-hcd.c                        |    5 
 drivers/usb/host/ohci-hub.c                        |    4 
 drivers/usb/host/pci-quirks.c                      |    8 -
 drivers/usb/input/hid-core.c                       |    4 
 drivers/usb/misc/Kconfig                           |   10 -
 drivers/usb/misc/Makefile                          |    2 
 drivers/usb/misc/cy7c63.c                          |  244 -----------------
 drivers/usb/misc/cypress_cy7c63.c                  |  279 ++++++++++++++++++++
 drivers/usb/misc/usblcd.c                          |    6 
 drivers/usb/mon/mon_text.c                         |    7 -
 drivers/usb/net/rtl8150.c                          |    3 
 drivers/usb/serial/Kconfig                         |   11 +
 drivers/usb/serial/Makefile                        |    1 
 drivers/usb/serial/airprime.c                      |    2 
 drivers/usb/serial/anydata.c                       |    4 
 drivers/usb/serial/ark3116.c                       |    2 
 drivers/usb/serial/belkin_sa.c                     |    2 
 drivers/usb/serial/bus.c                           |    2 
 drivers/usb/serial/console.c                       |    3 
 drivers/usb/serial/cp2101.c                        |    2 
 drivers/usb/serial/cyberjack.c                     |    2 
 drivers/usb/serial/cypress_m8.c                    |    2 
 drivers/usb/serial/digi_acceleport.c               |    2 
 drivers/usb/serial/empeg.c                         |    2 
 drivers/usb/serial/ezusb.c                         |    2 
 drivers/usb/serial/ftdi_sio.c                      |  108 +++++++-
 drivers/usb/serial/ftdi_sio.h                      |   15 +
 drivers/usb/serial/funsoft.c                       |    2 
 drivers/usb/serial/garmin_gps.c                    |    3 
 drivers/usb/serial/generic.c                       |    3 
 drivers/usb/serial/hp4x.c                          |    2 
 drivers/usb/serial/io_edgeport.c                   |    2 
 drivers/usb/serial/io_ti.c                         |    2 
 drivers/usb/serial/ipaq.c                          |   25 +-
 drivers/usb/serial/ipw.c                           |    4 
 drivers/usb/serial/ir-usb.c                        |    2 
 drivers/usb/serial/keyspan.c                       |    2 
 drivers/usb/serial/keyspan_pda.c                   |    3 
 drivers/usb/serial/kl5kusb105.c                    |    2 
 drivers/usb/serial/kobil_sct.c                     |    2 
 drivers/usb/serial/mct_u232.c                      |    2 
 drivers/usb/serial/navman.c                        |    2 
 drivers/usb/serial/omninet.c                       |    2 
 drivers/usb/serial/option.c                        |    8 -
 drivers/usb/serial/pl2303.c                        |    4 
 drivers/usb/serial/pl2303.h                        |    5 
 drivers/usb/serial/safe_serial.c                   |    2 
 drivers/usb/serial/sierra.c                        |   75 +++++
 drivers/usb/serial/ti_usb_3410_5052.c              |    2 
 drivers/usb/serial/usb-serial.c                    |   25 +-
 drivers/usb/serial/visor.c                         |   39 ++-
 drivers/usb/serial/whiteheat.c                     |    2 
 drivers/usb/storage/scsiglue.c                     |   12 -
 drivers/usb/storage/unusual_devs.h                 |   60 ++++
 drivers/usb/storage/usb.c                          |   29 +-
 drivers/usb/storage/usb.h                          |    4 
 include/linux/usb.h                                |    2 
 .../usb-serial.h => include/linux/usb/serial.h     |    6 
 include/linux/usb_ch9.h                            |    7 +
 include/linux/usb_gadget.h                         |    4 
 include/linux/usb_usual.h                          |    2 
 79 files changed, 1007 insertions(+), 442 deletions(-)
 create mode 100644 drivers/usb/host/ohci-ep93xx.c
 delete mode 100644 drivers/usb/misc/cy7c63.c
 create mode 100644 drivers/usb/misc/cypress_cy7c63.c
 create mode 100644 drivers/usb/serial/sierra.c
 rename drivers/usb/serial/usb-serial.h => include/linux/usb/serial.h (99%)

---------------

Alan Stern:
      usb-storage: fix race between reset and disconnect
      USB hub: don't return status > 0 from resume
      usbcore: fixes for hub_port_resume
      USB: unusual_devs entry for Nokia N91
      USB: unusual_devs entry for Nokia E61

Bart Oldeman:
      USB: ipw.c driver fix

Christoph Lameter:
      USB: remove empty destructor from drivers/usb/mon/mon_text.c

Christophe Mariac:
      USB: new device ids for ftdi_sio driver

Colin Leroy:
      USB: Add one VID/PID to ftdi_sio

D. Peter Siddons:
      USB: new device id for Thorlabs motor driver

Dan Streetman:
      USB: add ZyXEL vendor/product ID to rtl8150 driver

Daniel Mack:
      USB: au1200: EHCI and OHCI fixes

David Brownell:
      USB: ehci: fix bogus alteration of a local variable
      USB: gadget section fixups

David Miller:
      USB: OHCI hub code unaligned access

Davide Perini:
      usb-storage: unusual_devs entry for Motorola RAZR V3x

Domen Puncer:
      USB: au1xxx: compile fixes for OHCI for au1200

Eric Sesterhenn:
      USB: fix pointer dereference in drivers/usb/misc/usblcd

Ernis:
      USB: unusual_devs entry for Samsung MP3 player

Frank Gevaerts:
      USB: ipaq.c bugfixes
      USB: ipaq.c timing parameters

Greg Kroah-Hartman:
      USB: move usb-serial.h to include/linux/usb/

Ian Abbott:
      USB serial visor: fix race in open/close
      USB serial ftdi_sio: Prevent userspace DoS

Inaky Perez-Gonzalez:
      USB: Add some basic WUSB definitions

Kevin Lloyd:
      USB: add driver for non-composite Sierra Wireless devices

Kyle McMartin:
      USB: Kill compiler warning in quirk_usb_handoff_ohci

Lars Jacob:
      USB: unusual_devs entry for Sony DSC-H5

Lennert Buytenhek:
      USB: ohci bits for the cirrus ep93xx

Luiz Fernando N. Capitulino:
      USB: Anydata: Fixes wrong URB callback.

Matthew Meno:
      USB: Support for Susteen Datapilot Universal-2 cable in pl2303

Matthias Urlichs:
      USB: Option driver: new product ID

Michal Piotrowski:
      USB: remove devfs information from Kconfig

Navaho Gunleg:
      USB: add support for WiseGroup., Ltd SmartJoy Dual PLUS Adapter

Oliver Bock:
      USB: rename Cypress CY7C63xxx driver to proper name and fix up some tiny things

Oliver Neukum:
      USB: update for acm in quirks and debug

Pete Zaitcev:
      USB: fix usb-serial leaks, oopses on disconnect
      USB: fix visor leaks

Peter Moulder:
      USB: Addition of vendor/product id pair for pl2303 driver

Phil Dibowitz:
      USB Storage: US_FL_MAX_SECTORS_64 flag
      USB Storage: Uname in PR/SC Unneeded message
      USB: another unusual device

Randy Dunlap:
      USB: fix usb kernel-doc

Zoran Marceta:
      usbfs: use the correct signal number for disconnection

