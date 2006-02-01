Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWBABuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWBABuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 20:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWBABuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 20:50:17 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:12211
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964825AbWBABuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 20:50:15 -0500
Date: Tue, 31 Jan 2006 17:50:13 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.16-rc1
Message-ID: <20060201015013.GA20562@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB patches for 2.6.16-rc1.  They fix a bunch of different
bugs (run-time, and build time), add a number of new device ids for
various drivers, and add 2 new usb video drivers.  There is also an
update to the usb atm drivers in here, as they have not been updated in
a long time and the authors assure me that it is safe to do so :)

All of these patches have been in the -mm tree for quite a while.

(The one sound file being modified in this patchset comes from an
embedded board fix that Andrew forwarded to me that also has a usb host
driver fix in it.)

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/usb/et61x251.txt          |  306 +++
 Documentation/usb/sn9c102.txt           |   95 -
 Documentation/usb/w9968cf.txt           |   32 
 MAINTAINERS                             |   10 
 drivers/block/ub.c                      |  139 +
 drivers/usb/Makefile                    |    1 
 drivers/usb/atm/cxacru.c                |   92 -
 drivers/usb/atm/speedtch.c              |  181 +-
 drivers/usb/atm/ueagle-atm.c            |   98 -
 drivers/usb/atm/usbatm.c                |  618 ++++---
 drivers/usb/atm/usbatm.h                |   59 
 drivers/usb/atm/xusbatm.c               |  143 +
 drivers/usb/class/cdc-acm.c             |    9 
 drivers/usb/class/usblp.c               |   71 
 drivers/usb/core/message.c              |    1 
 drivers/usb/core/urb.c                  |    1 
 drivers/usb/gadget/inode.c              |    8 
 drivers/usb/gadget/net2280.c            |    1 
 drivers/usb/gadget/zero.c               |    8 
 drivers/usb/host/ehci-pci.c             |   64 
 drivers/usb/host/ehci-sched.c           |    4 
 drivers/usb/host/isp116x-hcd.c          |   21 
 drivers/usb/host/ohci-au1xxx.c          |    2 
 drivers/usb/host/pci-quirks.c           |  106 -
 drivers/usb/host/uhci-q.c               |    4 
 drivers/usb/input/hid-core.c            |    9 
 drivers/usb/input/hiddev.c              |    3 
 drivers/usb/input/touchkitusb.c         |    3 
 drivers/usb/input/yealink.c             |   48 
 drivers/usb/media/Kconfig               |   17 
 drivers/usb/media/Makefile              |    2 
 drivers/usb/media/et61x251.h            |  220 ++
 drivers/usb/media/et61x251_core.c       | 2605 ++++++++++++++++++++++++++++++++
 drivers/usb/media/et61x251_sensor.h     |  115 +
 drivers/usb/media/et61x251_tas5130d1b.c |  137 +
 drivers/usb/media/ov511.c               |  196 --
 drivers/usb/media/pwc/pwc-ctrl.c        |  264 +--
 drivers/usb/media/sn9c102.h             |   58 
 drivers/usb/media/sn9c102_core.c        | 1697 +++++++++++---------
 drivers/usb/media/sn9c102_hv7131d.c     |    2 
 drivers/usb/media/sn9c102_mi0343.c      |    2 
 drivers/usb/media/sn9c102_ov7630.c      |    8 
 drivers/usb/media/sn9c102_pas106b.c     |    2 
 drivers/usb/media/sn9c102_sensor.h      |   85 -
 drivers/usb/media/sn9c102_tas5110c1b.c  |    2 
 drivers/usb/media/sn9c102_tas5130d1b.c  |    2 
 drivers/usb/media/w9968cf.c             |  128 -
 drivers/usb/media/w9968cf.h             |    1 
 drivers/usb/media/w9968cf_vpp.h         |    3 
 drivers/usb/misc/auerswald.c            |    2 
 drivers/usb/misc/ldusb.c                |    2 
 drivers/usb/net/asix.c                  |    4 
 drivers/usb/serial/cp2101.c             |   14 
 drivers/usb/serial/ftdi_sio.c           |    6 
 drivers/usb/serial/ftdi_sio.h           |   23 
 drivers/usb/serial/pl2303.c             |    4 
 drivers/usb/serial/pl2303.h             |    7 
 drivers/usb/storage/initializers.c      |   73 
 drivers/usb/storage/initializers.h      |    1 
 drivers/usb/storage/libusual.c          |    2 
 drivers/usb/storage/unusual_devs.h      |   15 
 drivers/usb/usb-skeleton.c              |    2 
 include/linux/usb_ch9.h                 |    6 
 include/linux/videodev2.h               |    1 
 sound/oss/au1550_ac97.c                 |   12 
 65 files changed, 5739 insertions(+), 2118 deletions(-)


Adrian Bunk:
      USB: drivers/usb/media/ov511.c: remove hooks for the decomp module
      USB: drivers/usb/media/w9968cf.c: remove hooks for the vpp module

Alan Cox:
      USB: libusual: fix warning on 64bit boxes

Alan Stern:
      USB: UHCI: No FSBR until device is configured
      USB: gadgetfs: set "zero" flag for short control-IN response

Alexandre Duret-Lutz:
      USB: usb-storage support for SONY DSC-T5 still camera

Alexey Dobriyan:
      USB: arm26: fix compilation of drivers/usb/core/message.c

Andrew Morton:
      USB: fix ehci early handoff issues warning
      USB: add new auerswald device ids
      USB: yealink printk warning fix

Arjan van de Ven:
      USBATM: semaphore to mutex conversion

Clemens Ladisch:
      USB: EHCI, another full speed iso fix

Craig Shelley:
      USB: cp2101 Add new device IDs

David Brownell:
      USB: fix EHCI early handoff issues
      USB: net2280 warning fix
      USB: gadget zero and dma-coherent buffers
      USB: USB authentication states

David Hollis:
      USB: asix - Add device IDs for 0G0 Cable Ethernet

Denis MONTERRAT:
      USB: add new pl2303 device ids

Duncan Sands:
      USBATM: remove .owner
      USBATM: shutdown open connections when disconnected
      USBATM: trivial modifications
      USBATM: xusbatm rewrite
      USBATM: add flags field
      USBATM: return correct error code when out of memory
      USBATM: kzalloc conversion
      USBATM: use dev_kfree_skb_any rather than dev_kfree_skb
      USBATM: measure buffer size in bytes; force valid sizes
      USBATM: allow isochronous transfer
      USBATM: bump version numbers
      USBATM: -EILSEQ workaround
      USBATM: handle urbs containing partial cells

Eric Sesterhenn / snakebyte:
      USB: Remove LINUX_VERSION_CODE check in pwc/pwc-ctrl.c

Greg Kroah-Hartman:
      USB: remove some left over devfs droppings hanging around in the usb drivers
      USB: add might_sleep() to usb_unlink_urb() to warn developers

Henk:
      drivers/usb/input/yealink.c: Cleanup device matching code

Ian Abbott:
      USB: ftdi_sio: new IDs for Westrex devices

Juergen Schindele:
      USB: touchkitusb.c (eGalax driver) fix

Louis Nyffenegger:
      USB: new id for ftdi_sio.c and ftdi_sio.h

Luca Risolia:
      USB: SN9C10x driver updates and bugfixes
      USB: SN9C10x driver updates
      USB: Add ET61X[12]51 Video4Linux2 driver

Martin Gingras:
      USB: pl2303: Added support for CA-42 clone cable

Matthew Dharm:
      USB: usb-storage: Add support for Rio Karma

matthieu castet:
      UEAGLE : add iso support
      UEAGLE : cosmetic
      UEAGLE : cmv name bug (was cosmetic)

Olaf Hering:
      USB: remove extra newline in hid_init_reports

Olav Kongas:
      USB: isp116x-hcd: replace mdelay() by msleep()

Oliver Neukum:
      USB: fix oops in acm disconnect
      USB: cleanup of usblp

Pete Zaitcev:
      USB: ub 05 Bulk reset
      USB: ub 03 Oops with CFQ
      USB: ub 04 Loss of timer and a hang

Randy Dunlap:
      USB EHCI: fix gfp_t sparse warning

Rui Santos:
      USB: ftdi: Two new ATIK based USB astronomical CCD cameras

Sergei Shtylylov:
      USB: Au1xx0: replace casual readl() with au_readl() in the drivers

Vojtech Pavlik:
      USB HID: add blacklist entry for HP keyboard

Wouter Paesen:
      USB: ftdi_sio: new PID for PCDJ DAC2

