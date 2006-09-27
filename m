Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030741AbWI0UGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030741AbWI0UGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030742AbWI0UGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:06:31 -0400
Received: from ns.suse.de ([195.135.220.2]:43716 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030741AbWI0UG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:06:29 -0400
Date: Wed, 27 Sep 2006 13:06:26 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.18
Message-ID: <20060927200626.GA10018@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of USB patches for 2.6.18.  They include some new USB
drivers, a bunch of new device ids added, and some reworks in order to
get ready for the autosuspend work (which is not included yet).  There
are a lot of compiler warnings also fixed, along with some other minor
tweaks and bugfixes.

All of these changes have been in the -mm tree for a while.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/DocBook/usb.tmpl          |  123 +
 Documentation/devices.txt               |    3 
 Documentation/usb/error-codes.txt       |   11 
 Documentation/usb/usb-serial.txt        |    5 
 arch/arm/mach-pxa/corgi.c               |   15 
 arch/arm/plat-omap/usb.c                |    2 
 drivers/block/ub.c                      |   38 
 drivers/i2c/chips/isp1301_omap.c        |    2 
 drivers/isdn/gigaset/bas-gigaset.c      |    2 
 drivers/isdn/hisax/hfc_usb.h            |    6 
 drivers/media/dvb/dvb-usb/dvb-usb-urb.c |    1 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c |    2 
 drivers/media/video/ov511.c             |    7 
 drivers/media/video/pwc/pwc-if.c        |    2 
 drivers/media/video/w9968cf.c           |    7 
 drivers/net/irda/irda-usb.c             |   18 
 drivers/net/wireless/zd1201.c           |    4 
 drivers/usb/Kconfig                     |    1 
 drivers/usb/Makefile                    |   12 
 drivers/usb/atm/ueagle-atm.c            |   74 -
 drivers/usb/class/usblp.c               |   15 
 drivers/usb/core/Makefile               |    2 
 drivers/usb/core/buffer.c               |    4 
 drivers/usb/core/config.c               |    4 
 drivers/usb/core/devices.c              |    6 
 drivers/usb/core/devio.c                |   66 -
 drivers/usb/core/driver.c               | 1011 +++++++++-
 drivers/usb/core/endpoint.c             |   30 
 drivers/usb/core/file.c                 |    2 
 drivers/usb/core/generic.c              |  208 ++
 drivers/usb/core/hcd-pci.c              |   16 
 drivers/usb/core/hcd.c                  |  244 +-
 drivers/usb/core/hcd.h                  |   60 -
 drivers/usb/core/hub.c                  |  555 ++---
 drivers/usb/core/hub.h                  |    3 
 drivers/usb/core/inode.c                |    6 
 drivers/usb/core/message.c              |  148 +
 drivers/usb/core/notify.c               |    3 
 drivers/usb/core/sysfs.c                |   60 -
 drivers/usb/core/urb.c                  |   15 
 drivers/usb/core/usb.c                  |  533 ++---
 drivers/usb/core/usb.h                  |   76 +
 drivers/usb/gadget/Kconfig              |   16 
 drivers/usb/gadget/Makefile             |    2 
 drivers/usb/gadget/at91_udc.c           |    2 
 drivers/usb/gadget/dummy_hcd.c          |    8 
 drivers/usb/gadget/ether.c              |    9 
 drivers/usb/gadget/gmidi.c              | 1337 +++++++++++++
 drivers/usb/gadget/inode.c              |   60 -
 drivers/usb/gadget/net2280.c            |  156 +
 drivers/usb/gadget/omap_udc.c           |    4 
 drivers/usb/gadget/pxa2xx_udc.c         |   70 +
 drivers/usb/gadget/pxa2xx_udc.h         |   24 
 drivers/usb/gadget/serial.c             |    3 
 drivers/usb/host/Kconfig                |   29 
 drivers/usb/host/Makefile               |    1 
 drivers/usb/host/ehci-au1xxx.c          |    2 
 drivers/usb/host/ehci-dbg.c             |   31 
 drivers/usb/host/ehci-fsl.c             |    2 
 drivers/usb/host/ehci-hcd.c             |   95 +
 drivers/usb/host/ehci-hub.c             |   14 
 drivers/usb/host/ehci-mem.c             |   14 
 drivers/usb/host/ehci-pci.c             |    4 
 drivers/usb/host/ehci-q.c               |   26 
 drivers/usb/host/ehci-sched.c           |   26 
 drivers/usb/host/ehci.h                 |   59 -
 drivers/usb/host/isp116x-hcd.c          |    2 
 drivers/usb/host/isp116x.h              |    2 
 drivers/usb/host/ohci-at91.c            |    7 
 drivers/usb/host/ohci-au1xxx.c          |    7 
 drivers/usb/host/ohci-dbg.c             |   18 
 drivers/usb/host/ohci-ep93xx.c          |    3 
 drivers/usb/host/ohci-hcd.c             |   64 -
 drivers/usb/host/ohci-hub.c             |   70 -
 drivers/usb/host/ohci-lh7a404.c         |    7 
 drivers/usb/host/ohci-mem.c             |    1 
 drivers/usb/host/ohci-omap.c            |  120 +
 drivers/usb/host/ohci-pci.c             |    8 
 drivers/usb/host/ohci-pnx4008.c         |  476 ++++
 drivers/usb/host/ohci-ppc-soc.c         |    3 
 drivers/usb/host/ohci-pxa27x.c          |    3 
 drivers/usb/host/ohci-s3c2410.c         |    5 
 drivers/usb/host/ohci-sa1111.c          |    5 
 drivers/usb/host/ohci.h                 |    4 
 drivers/usb/host/sl811-hcd.c            |    4 
 drivers/usb/host/u132-hcd.c             | 3295 +++++++++++++++++++++++++++++++
 drivers/usb/host/uhci-debug.c           |    4 
 drivers/usb/host/uhci-hub.c             |   12 
 drivers/usb/image/mdc800.c              |    4 
 drivers/usb/input/Kconfig               |   30 
 drivers/usb/input/Makefile              |    2 
 drivers/usb/input/acecad.c              |    5 
 drivers/usb/input/appletouch.c          |    5 
 drivers/usb/input/ati_remote.c          |    8 
 drivers/usb/input/hid-core.c            |   24 
 drivers/usb/input/hiddev.c              |    2 
 drivers/usb/input/itmtouch.c            |    2 
 drivers/usb/input/keyspan_remote.c      |    3 
 drivers/usb/input/mtouchusb.c           |    2 
 drivers/usb/input/powermate.c           |    4 
 drivers/usb/input/touchkitusb.c         |    2 
 drivers/usb/input/trancevibrator.c      |  159 +
 drivers/usb/input/usbmouse.c            |    2 
 drivers/usb/input/usbtouchscreen.c      |  285 ++-
 drivers/usb/input/wacom.c               | 1003 ---------
 drivers/usb/input/wacom.h               |  132 +
 drivers/usb/input/wacom_sys.c           |  315 +++
 drivers/usb/input/wacom_wac.c           |  646 ++++++
 drivers/usb/input/wacom_wac.h           |   48 
 drivers/usb/input/yealink.c             |    2 
 drivers/usb/misc/Kconfig                |   61 +
 drivers/usb/misc/Makefile               |    5 
 drivers/usb/misc/adutux.c               |  900 ++++++++
 drivers/usb/misc/auerswald.c            |    6 
 drivers/usb/misc/cypress_cy7c63.c       |   19 
 drivers/usb/misc/cytherm.c              |   35 
 drivers/usb/misc/ftdi-elan.c            | 2809 ++++++++++++++++++++++++++
 drivers/usb/misc/idmouse.c              |    2 
 drivers/usb/misc/ldusb.c                |   10 
 drivers/usb/misc/legousbtower.c         |    2 
 drivers/usb/misc/phidget.c              |   43 
 drivers/usb/misc/phidget.h              |   12 
 drivers/usb/misc/phidgetkit.c           |  316 ++-
 drivers/usb/misc/phidgetmotorcontrol.c  |  466 ++++
 drivers/usb/misc/phidgetservo.c         |  117 +
 drivers/usb/misc/sisusbvga/sisusb.c     |    2 
 drivers/usb/misc/usb_u132.h             |   97 +
 drivers/usb/misc/usblcd.c               |   10 
 drivers/usb/misc/usbled.c               |   20 
 drivers/usb/mon/mon_main.c              |    7 
 drivers/usb/mon/mon_stat.c              |    2 
 drivers/usb/mon/mon_text.c              |   15 
 drivers/usb/mon/usb_mon.h               |    5 
 drivers/usb/net/asix.c                  | 1001 +++++++--
 drivers/usb/net/net1080.c               |   15 
 drivers/usb/net/pegasus.c               |    2 
 drivers/usb/net/rtl8150.c               |    2 
 drivers/usb/net/usbnet.c                |   44 
 drivers/usb/net/usbnet.h                |    1 
 drivers/usb/serial/Kconfig              |   25 
 drivers/usb/serial/Makefile             |    2 
 drivers/usb/serial/aircable.c           |  625 ++++++
 drivers/usb/serial/airprime.c           |  261 ++
 drivers/usb/serial/ark3116.c            |  233 +-
 drivers/usb/serial/cypress_m8.c         |  129 +
 drivers/usb/serial/ftdi_sio.c           |   30 
 drivers/usb/serial/garmin_gps.c         |  219 ++
 drivers/usb/serial/ipaq.c               |   38 
 drivers/usb/serial/mos7840.c            | 2962 ++++++++++++++++++++++++++++
 drivers/usb/serial/pl2303.c             |  827 ++++----
 drivers/usb/serial/pl2303.h             |    4 
 drivers/usb/serial/usb-serial.c         |   28 
 drivers/usb/storage/Kconfig             |   12 
 drivers/usb/storage/Makefile            |    1 
 drivers/usb/storage/initializers.c      |   73 -
 drivers/usb/storage/initializers.h      |    1 
 drivers/usb/storage/karma.c             |  155 +
 drivers/usb/storage/karma.h             |    7 
 drivers/usb/storage/libusual.c          |   10 
 drivers/usb/storage/onetouch.c          |    8 
 drivers/usb/storage/scsiglue.c          |   15 
 drivers/usb/storage/transport.c         |    5 
 drivers/usb/storage/unusual_devs.h      |   18 
 drivers/usb/storage/usb.c               |   11 
 drivers/usb/usb-skeleton.c              |  101 +
 include/asm-arm/arch-pxa/udc.h          |    8 
 include/linux/usb.h                     |  156 +
 include/linux/usb/audio.h               |   53 
 include/linux/usb/midi.h                |  112 +
 include/linux/{usb_otg.h => usb/otg.h}  |    4 
 include/linux/usb_usual.h               |    3 
 sound/usb/usbmidi.c                     |    6 
 172 files changed, 20286 insertions(+), 4083 deletions(-)
 create mode 100644 drivers/usb/core/generic.c
 create mode 100644 drivers/usb/gadget/gmidi.c
 create mode 100644 drivers/usb/host/ohci-pnx4008.c
 create mode 100644 drivers/usb/host/u132-hcd.c
 create mode 100644 drivers/usb/input/trancevibrator.c
 delete mode 100644 drivers/usb/input/wacom.c
 create mode 100644 drivers/usb/input/wacom.h
 create mode 100644 drivers/usb/input/wacom_sys.c
 create mode 100644 drivers/usb/input/wacom_wac.c
 create mode 100644 drivers/usb/input/wacom_wac.h
 create mode 100644 drivers/usb/misc/adutux.c
 create mode 100644 drivers/usb/misc/ftdi-elan.c
 create mode 100644 drivers/usb/misc/phidget.c
 create mode 100644 drivers/usb/misc/phidget.h
 create mode 100644 drivers/usb/misc/phidgetmotorcontrol.c
 create mode 100644 drivers/usb/misc/usb_u132.h
 create mode 100644 drivers/usb/serial/aircable.c
 create mode 100644 drivers/usb/serial/mos7840.c
 create mode 100644 drivers/usb/storage/karma.c
 create mode 100644 drivers/usb/storage/karma.h
 create mode 100644 include/linux/usb/audio.h
 create mode 100644 include/linux/usb/midi.h
 rename include/linux/{usb_otg.h => usb/otg.h} (98%)

---------------

Alan Stern:
      USB: unusual_devs entry for Lacie DVD+-RW
      usbcore: add configuration_string to attribute group
      usbfs: private mutex for open, release, and remove
      usbfs: detect device unregistration
      usb-skeleton: don't submit URBs after disconnection
      usbcore: rename usb_suspend_device to usb_port_suspend
      usbcore: move code among source files
      usbcore: add usb_device_driver definition
      usbcore: make usb_generic a usb_device_driver
      usbcore: split suspend/resume for device and interfaces
      usbcore: resume device resume recursion
      usbcore: track whether interfaces are suspended
      usbcore: set device and power states properly
      usbcore: fix up device and power state tests
      usbcore: suspending devices with no driver
      hub driver: improve use of #ifdef
      UHCI: increase Resume-Detect-off delay
      usbcore: make hcd_endpoint_disable wait for queue to drain
      usbcore: khubd and busy-port handling
      usb-storage: fix for UFI LUN detection
      usbcore: help drivers to change device configs
      USB: remove struct usb_operations
      usbcore: Add flag for whether a host controller uses DMA
      usbcore: trim down usb_bus structure
      usbmon: don't call mon_dmapeek if DMA isn't being used
      usbcore: store each usb_device's level in the tree
      usbcore: add autosuspend/autoresume infrastructure
      usbcore: non-hub-specific uses of autosuspend
      usbcore: remove usb_suspend_root_hub
      USB: fix root-hub resume when CONFIG_USB_SUSPEND is not set
      USB: force root hub resume after power loss

Aleksey Gorelov:
      USB: Properly unregister reboot notifier in case of failure in ehci hcd

Alexey Dobriyan:
      USB: Turn usb_resume_both() into static inline

Andrew Morton:
      USB: kill usb kconfig warning
      USB: usb-hub-driver-improve-use-of-ifdef fix
      USB Storage: fix Rio Karma eject support build error

Andy Gay:
      USB: Airprime driver improvements to allow full speed EvDO transfers

Ben Dooks:
      USB: ohci-s3c2410.c: clock now usb-bus-host

Ben Williamson:
      USB: gmidi: New USB MIDI Gadget class driver.

Daniel Ritz:
      usbtouchscreen: version 0.4

dave rientjes:
      USB: net1080 inherent pad length

David Brownell:
      USB: OHCI avoids root hub timer polling
      USB: move <linux/usb_otg.h> to <linux/usb/otg.h>
      USB: pxa2xx_udc understands GPIO based VBUS sensing
      USB: build fixes: ohci-omap
      USB: ethernet gadget avoids zlps for musb_hdrc
      USB: EHCI whitespace fixes (cosmetic)
      USB: net2280: update dma buffer allocation
      USB: ohci-at91, two one-liners
      USB: EHCI update VIA workaround
      USB: remove OTG build warning

David Hollis:
      USB: asix - Add AX88178 support and many other changes

Dmitry Torokhov:
      USB: Make usb_buffer_free() NULL-safe
      USB: onetouch - handle errors from input_register_device()

Eric Sesterhenn:
      USB: fix signedness issue in drivers/usb/gadget/ether.c

Eugeny S. Mints:
      USB: usb serial gadget smp related bug

Franck Bui-Huu:
      USB: usbcore get rid of the timer in usb_start_wait_urb()

Greg Kroah-Hartman:
      USB: fix __must_check warnings in drivers/usb/core/
      USB: fix __must_check warnings in drivers/usb/misc/
      USB: fix __must_check warnings in drivers/usb/atm/
      USB: fix __must_check warnings in drivers/usb/class/
      USB: fix __must_check warnings in drivers/usb/input/
      USB: fix __must_check warnings in drivers/usb/host/
      USB: fix __must_check warnings in drivers/usb/serial/

Hermann Kneissel:
      USB: garmin_gps support for new generation of gps receivers

Inaky Perez-Gonzalez:
      usb: deal with broken config descriptors
      wusb: hub code recognizes wusb ports
      wusb: handle wusb device ep0 speed settings
      wusb: pretty print new wireless USB devices when they connect

Jamie Painter:
      USB: usbnet - Add unlink_rx_urbs() call to allow for Jumbo Frames

Jesper Juhl:
      USB: making the kernel -Wshadow clean - USB & completion

Johannes Steingraeber:
      usb serial: support Alcor Micro Corp. USB 2.0 TO RS-232 through pl2303 driver

Jules Villard:
      USB: fix typo in drivers/usb/gadget/Kconfig

Luiz Fernando N. Capitulino:
      USB: pl2303: Removes unneeded goto.
      USB: ipaq: minor ipaq_open() cleanup.
      USB: Make file operations structs in drivers/usb const.
      USB: New functions to check endpoints info.
      USB: usblp: Use usb_endpoint_* functions.
      USB: hub: Use usb_endpoint_* functions.
      USB: appletouch: Use usb_endpoint_* functions.
      USB: acecad: Use usb_endpoint_* functions.
      USB: ati_remote: Use usb_endpoint_* functions.
      USB: keyspan_remote: Use usb_endpoint_* functions.
      USB: powermate: Use usb_endpoint_* functions.
      USB: usb-serial: Use usb_endpoint_* functions.
      USB: usblcd: Use usb_endpoint_* functions.
      USB: ldusb: Use usb_endpoint_* functions.
      usb-skeleton: small update
      USB core: Use const where possible.

Manuel Francisco Naranjo:
      Add AIRcable USB Bluetooth Dongle Driver

Matthew Dharm:
      USB Storage: add rio karma eject support
      USB: replace kernel_thread() with kthread_run() in libusual.c

Mike Isely:
      cypress_m8: use appropriate URB polling interval
      cypress_m8: use usb_fill_int_urb where appropriate
      cypress_m8: improve control endpoint error handling
      cypress_m8: implement graceful failure handling

Milan Svoboda:
      USB: correct locking in gadgetfs_disconnect
      USB: fix ep_config to return correct value
      USB: gadgetfs: protect ep_release with lock
      USB: add poll to gadgetfs's endpoint zero
      USB gadget: gadgetfs dont try to lock before free

Paul B Schroeder:
      USB: Moschip 7840 USB-Serial Driver

Pete Zaitcev:
      USB: UB: Let cdrecord to see a device with media absent
      USB: Dealias -110 code (more complete)
      USB: ohci_usb can oops on shutdown

Phil Dibowitz:
      USB: unusual_dev entry for Sony P990i

Ping Cheng:
      USB: wacom tablet driver reorganization

Randy Dunlap:
      usbnet: printk format warning
      aircable: fix printk format warnings

Reiner Herrmann:
      USB: usb/input/usbmouse.c: whitespace cleanup

Sam Bishop:
      USB: doc patch 1
      USB doc patch 2

Sam Hocevar:
      USB: add PlayStation 2 Trance Vibrator driver

Sean Young:
      USB: Add driver for PhidgetMotorControl
      USB: Put phidgets driver in a sysfs class
      USB: Phidgets should check create_device_file() return value

Skip Hansen:
      gadgetfs patch for ep0out

Steven Haigh:
      USB: Add ADU support for Ontrak ADU devices

Thiago Galesi:
      USB: pl2303: remove 80-columns limit violations in pl2303 driver
      USB: pl2303: cosmetic changes to pl2303_buf_{clear, data_avail}
      USB: pl2303: reduce number of prototypes
      USB: pl2303: cosmetic changes to quirk

Tobias Klauser:
      USB: Remove unneeded void * casts in core files

Tony Lindgren:
      USB: Allow compile in g_ether, fix typo

Tony Olech:
      USB: ftdi-elan: client driver for ELAN Uxxx adapters
      USB: u132-hcd: host controller driver for ELAN U132 adapter

Vitaly Wool:
      USB OHCI controller support for PNX4008

Werner Lemberg:
      USB: ark3116: Add TIOCGSERIAL and TIOCSSERIAL ioctl calls.
      USB: ark3116: Formatting cleanups

