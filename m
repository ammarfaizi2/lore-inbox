Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162216AbWLAXQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162216AbWLAXQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162219AbWLAXQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:16:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:3564 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162216AbWLAXQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:16:38 -0500
Date: Fri, 1 Dec 2006 15:16:26 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.19
Message-ID: <20061201231626.GA7556@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of USB patches for 2.6.19.

They contain:
	- new driver for usb debug device (client side only so far)
	- helper functions to find usb endpoints easier
	- minor bugfixes
	- new device support
	- usb core rework for autosuspend logic
	- autosuspend logic that should now save a lot of power when no
	  one is using a USB device.
	- proper minor number usage for the usb endpoints (although they
	  are not yet hooked up to anything, that work is still
	  underway.)
	- other minor things.

All of these changes have been in the last few -mm releases.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/DocBook/writing_usb_driver.tmpl     |    3 +-
 drivers/char/watchdog/pcwd_usb.c                  |    3 +-
 drivers/input/joystick/iforce/iforce-usb.c        |    6 +-
 drivers/isdn/gigaset/usb-gigaset.c                |   15 +-
 drivers/media/dvb/cinergyT2/cinergyT2.c           |    6 +-
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    3 +-
 drivers/media/video/pvrusb2/pvrusb2-hdw.c         |   10 +-
 drivers/media/video/pvrusb2/pvrusb2-io.c          |    2 +-
 drivers/media/video/pwc/pwc-if.c                  |    6 +-
 drivers/media/video/sn9c102/sn9c102_core.c        |    2 +-
 drivers/media/video/usbvideo/quickcam_messenger.c |    3 +-
 drivers/media/video/zc0301/zc0301_core.c          |    2 +-
 drivers/net/irda/irda-usb.c                       |    6 +-
 drivers/net/wireless/zd1201.c                     |    6 +-
 drivers/usb/atm/speedtch.c                        |    4 +-
 drivers/usb/atm/ueagle-atm.c                      |   10 +-
 drivers/usb/class/cdc-acm.c                       |    2 +-
 drivers/usb/core/Kconfig                          |   15 +
 drivers/usb/core/devices.c                        |    9 +-
 drivers/usb/core/devio.c                          |    4 +-
 drivers/usb/core/driver.c                         |  304 +++++++++++++--------
 drivers/usb/core/endpoint.c                       |   98 ++++++-
 drivers/usb/core/hcd.c                            |    4 +-
 drivers/usb/core/hub.c                            |  234 ++++++++++++-----
 drivers/usb/core/hub.h                            |   41 ---
 drivers/usb/core/message.c                        |    8 +-
 drivers/usb/core/usb.c                            |  160 +----------
 drivers/usb/core/usb.h                            |    9 +-
 drivers/usb/gadget/ether.c                        |    4 +-
 drivers/usb/gadget/lh7a40x_udc.c                  |    1 -
 drivers/usb/gadget/net2280.c                      |    8 +-
 drivers/usb/gadget/net2280.h                      |    3 +-
 drivers/usb/gadget/pxa2xx_udc.c                   |    2 +
 drivers/usb/host/ehci-hcd.c                       |   16 +-
 drivers/usb/host/ehci-hub.c                       |  104 +++++--
 drivers/usb/host/ehci-pci.c                       |   40 +--
 drivers/usb/host/ehci.h                           |    1 +
 drivers/usb/host/ohci-hcd.c                       |   10 +
 drivers/usb/host/ohci-hub.c                       |  172 ++++++------
 drivers/usb/host/u132-hcd.c                       |    8 +-
 drivers/usb/image/microtek.c                      |    8 +-
 drivers/usb/input/Kconfig                         |    6 +
 drivers/usb/input/ati_remote.c                    |    7 +-
 drivers/usb/input/ati_remote2.c                   |    3 +-
 drivers/usb/input/hid-core.c                      |   91 ++++---
 drivers/usb/input/hid.h                           |    1 +
 drivers/usb/input/usbkbd.c                        |   10 +-
 drivers/usb/input/usbmouse.c                      |    4 +-
 drivers/usb/input/usbtouchscreen.c                |   96 +++++++-
 drivers/usb/input/wacom.h                         |    1 -
 drivers/usb/input/wacom_sys.c                     |    2 +-
 drivers/usb/input/yealink.c                       |    6 +-
 drivers/usb/misc/Makefile                         |    1 +
 drivers/usb/misc/appledisplay.c                   |    5 +-
 drivers/usb/misc/auerswald.c                      |    7 +-
 drivers/usb/misc/emi26.c                          |    3 +-
 drivers/usb/misc/emi62.c                          |    3 +-
 drivers/usb/misc/ftdi-elan.c                      |   20 +--
 drivers/usb/misc/idmouse.c                        |   22 +-
 drivers/usb/misc/legousbtower.c                   |   31 +--
 drivers/usb/misc/phidgetkit.c                     |    5 +-
 drivers/usb/misc/phidgetmotorcontrol.c            |    5 +-
 drivers/usb/misc/usb_u132.h                       |    4 +
 drivers/usb/misc/usbtest.c                        |    4 +-
 drivers/usb/net/asix.c                            |    6 +-
 drivers/usb/net/catc.c                            |   12 +-
 drivers/usb/net/cdc_ether.c                       |    3 +-
 drivers/usb/net/net1080.c                         |    4 +-
 drivers/usb/net/pegasus.c                         |    1 +
 drivers/usb/net/usbnet.c                          |    4 +-
 drivers/usb/serial/Kconfig                        |   11 +
 drivers/usb/serial/Makefile                       |    1 +
 drivers/usb/serial/aircable.c                     |    9 +-
 drivers/usb/serial/airprime.c                     |    1 +
 drivers/usb/serial/ark3116.c                      |    3 +-
 drivers/usb/serial/console.c                      |    6 +-
 drivers/usb/serial/cypress_m8.c                   |    9 +-
 drivers/usb/serial/ezusb.c                        |    3 +-
 drivers/usb/serial/ftdi_sio.c                     |    3 +-
 drivers/usb/serial/garmin_gps.c                   |    3 +-
 drivers/usb/serial/io_edgeport.c                  |    4 +-
 drivers/usb/serial/ipw.c                          |    3 +-
 drivers/usb/serial/keyspan.c                      |   18 +-
 drivers/usb/serial/kobil_sct.c                    |    9 +-
 drivers/usb/serial/mct_u232.c                     |    6 +-
 drivers/usb/serial/mos7840.c                      |    3 +-
 drivers/usb/serial/navman.c                       |    3 +-
 drivers/usb/serial/ti_usb_3410_5052.c             |    5 +-
 drivers/usb/serial/ti_usb_3410_5052.h             |    1 +
 drivers/usb/serial/usb-serial.c                   |   12 +-
 drivers/usb/serial/usb_debug.c                    |   65 +++++
 drivers/usb/serial/visor.c                        |    3 +-
 drivers/usb/storage/onetouch.c                    |    5 +-
 drivers/usb/storage/unusual_devs.h                |   10 +
 drivers/usb/storage/usb.c                         |    8 +-
 include/linux/usb.h                               |  181 +++++++++++-
 sound/usb/usbmidi.c                               |    2 +-
 sound/usb/usbmixer.c                              |    9 +-
 98 files changed, 1264 insertions(+), 851 deletions(-)
 create mode 100644 drivers/usb/serial/usb_debug.c

---------------

Adrian Bunk (5):
      USB: make drivers/usb/input/wacom_sys.c:wacom_sys_irq() static
      USB: make drivers/usb/host/u132-hcd.c:u132_hcd_wait static
      USB: ftdi-elan.c: fixes and cleanups
      USB: make drivers/usb/core/driver.c:usb_device_match() static
      USB: build the appledisplay driver

Alan Stern (18):
      USB HID: Handle STALL on interrupt endpoint
      USB core: don't match interface descriptors for vendor-specific devices
      USB: ohci-hcd: fix compiler warning
      USB: OHCI: disable RHSC inside interrupt handler
      USB: OHCI: remove stale testing code from root-hub resume
      USB: autosuspend code consolidation
      USB: expand autosuspend/autoresume API
      USB: Move private hub declarations out of public header file
      OHCI: change priority level of resume log message
      USB core: fix compiler warning about usb_autosuspend_work
      USB: net2280: don't send unwanted zero-length packets
      EHCI: Fix root-hub and port suspend/resume problems
      USB: Add autosuspend support to the hub driver
      OHCI: make autostop conditional on CONFIG_PM
      USB: struct usb_device: change flag to bitflag
      USB hub: simplify remote-wakeup handling
      USB: keep count of unsuspended children
      usbcore: remove unused argument in autosuspend

Burman Yan (1):
      USB serial: replace kmalloc+memset with kzalloc

daniel@centurion.net.nz (1):
      USB: airprime: New device ID

David Brownell (5):
      usb/gadget/ether.c minor manycast tweaks
      USB: EHCI hooks for high speed electrical tests
      USB: add ehci_hcd.ignore_oc parameter
      USB: pxa2xx_udc recognizes ixp425 rev b0 chip
      USB: lh7a40x_udc remove double declaration

Eric Sesterhenn (1):
      USB: kmemdup() cleanup in drivers/usb/

Greg Kroah-Hartman (2):
      USB: add driver for the USB debug devices
      USB: create a new thread for every USB device found during the probe sequence

Holger Schurig (1):
      usbtouchscreen: add support for DMC TSC-10/25 devices

inaky@linux.intel.com (2):
      usb/hub: allow hubs up to 31 children
      usb hub: fix root hub code so it takes more than 15 devices per root hub

Jaco Kroon (1):
      USB: add Digitech USB-Storage to unusual_devs.h

Jean Delvare (1):
      USB: net1080: Fix && typos

Julien BLACHE (1):
      USB: hid-core: canonical defines for Apple USB device IDs

Luiz Fernando N. Capitulino (21):
      USB: aircable: Use usb_endpoint_* functions
      USB: appledisplay: Use usb_endpoint_* functions
      USB: cdc_ether: Use usb_endpoint_* functions
      USB: cdc-acm: Use usb_endpoint_* functions
      USB: devices: Use usb_endpoint_* functions
      USB: ftdi-elan: Use usb_endpoint_* functions
      USB: hid-core: Use usb_endpoint_* functions
      USB: idmouse: Use usb_endpoint_* functions
      USB: kobil_sct: Use usb_endpoint_* functions
      USB: legousbtower: Use usb_endpoint_* functions
      USB: onetouch: Use usb_endpoint_* functions
      USB: phidgetkit: Use usb_endpoint_* functions
      USB: phidgetmotorcontrol: Use usb_endpoint_* functions
      USB: speedtch: Use usb_endpoint_* functions
      USB: usbkbd: Use usb_endpoint_* functions
      USB: usbmouse: Use usb_endpoint_* functions
      USB: usbnet: Use usb_endpoint_* functions
      USB: usbtest: Use usb_endpoint_* functions
      USB: storage: Use usb_endpoint_* functions
      USB: yealink: Use usb_endpoint_* functions
      USB: makes usb_endpoint_* functions inline.

Mariusz Kozlowski (37):
      USB: pwc-if loop fix
      usb: writing_usb_driver free urb cleanup
      usb: pcwd_usb free urb cleanup
      usb: iforce-usb free urb cleanup
      usb: usb-gigaset free kill urb cleanup
      usb: cinergyT2 free kill urb cleanup
      usb: ttusb_dec free urb cleanup
      usb: pvrusb2-hdw free unlink urb cleanup
      usb: pvrusb2-io free urb cleanup
      usb: pwc-if free urb cleanup
      usb: sn9c102_core free urb cleanup
      usb: quickcam_messenger free urb cleanup
      usb: zc0301_core free urb cleanup
      usb: irda-usb free urb cleanup
      usb: zd1201 free urb cleanup
      usb: ati_remote free urb cleanup
      usb: ati_remote2 free urb cleanup
      usb: hid-core free urb cleanup
      usb: usbkbd free urb cleanup
      usb: auerswald free kill urb cleanup
      usb: legousbtower free kill urb cleanup
      usb: phidgetkit free urb cleanup
      usb: phidgetmotorcontrol free urb cleanup
      usb: ftdi_sio kill urb cleanup
      usb: catc free urb cleanup
      usb: io_edgeport kill urb cleanup
      usb: keyspan free urb cleanup
      usb: kobil_sct kill urb cleanup
      usb: mct_u232 free urb cleanup
      usb: navman kill urb cleanup
      usb: usb-serial free urb cleanup
      usb: visor kill urb cleanup
      usb: usbmidi kill urb cleanup
      usb: usbmixer free kill urb cleanup
      usb: microtek possible memleak fix
      usb: cypress_m8 init error path fix
      USB: idmouse cleanup

Naranjo Manuel Francisco (1):
      USB: fix aircable.c: inconsequent NULL checking

Oleg Verych (1):
      usb-serial: ti_usb, TI ez430 development tool ID

Oliver Neukum (2):
      USB: endianness fix for asix.c
      USB: pegasus error path not resetting task's state

Sarah Bailey (1):
      USB: added dynamic major number for USB endpoints

Stephen Hemminger (1):
      USB: resume_device symbol conflict

