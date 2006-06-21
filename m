Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWFUWKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWFUWKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWFUWKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:10:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:23464 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030336AbWFUWKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:10:03 -0400
Date: Wed, 21 Jun 2006 15:06:56 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB patches for 2.6.17
Message-ID: <20060621220656.GA10652@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a lot of USB patches for 2.6.17.  They do the following:

	 - rework the UHCI driver
	 - lots of new device ids added
	 - EHCI tt fixed (allowing 1.1 devices behind 2.0 hubs to work properly)
	 - new drivers added
	 - endpoint sysfs code redone
	 - lots of other small bugfixes and features added

All of these changes have been in the -mm tree for a number of months.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/power/swsusp.txt             |   37 -
 Documentation/usb/usbmon.txt               |   32 
 arch/powerpc/sysdev/fsl_soc.c              |   66 --
 arch/ppc/syslib/mpc83xx_devices.c          |    6 
 drivers/block/ub.c                         |   78 --
 drivers/media/video/usbvideo/konicawc.c    |    3 
 drivers/usb/Makefile                       |    2 
 drivers/usb/atm/usbatm.c                   |    2 
 drivers/usb/atm/xusbatm.c                  |    1 
 drivers/usb/class/cdc-acm.c                |   84 +-
 drivers/usb/class/cdc-acm.h                |   16 
 drivers/usb/core/Makefile                  |    3 
 drivers/usb/core/devio.c                   |   38 -
 drivers/usb/core/endpoint.c                |  275 ++++++++
 drivers/usb/core/file.c                    |   79 +-
 drivers/usb/core/hub.c                     |  153 +++-
 drivers/usb/core/message.c                 |  182 +++--
 drivers/usb/core/sysfs.c                   |  201 ------
 drivers/usb/core/usb.c                     |    1 
 drivers/usb/core/usb.h                     |    3 
 drivers/usb/gadget/ether.c                 |   90 +-
 drivers/usb/gadget/inode.c                 |   62 +
 drivers/usb/gadget/net2280.c               |   17 
 drivers/usb/gadget/pxa2xx_udc.c            |   13 
 drivers/usb/gadget/rndis.c                 |  389 +++++------
 drivers/usb/gadget/rndis.h                 |   26 
 drivers/usb/gadget/serial.c                |  105 ---
 drivers/usb/host/Kconfig                   |   20 
 drivers/usb/host/ehci-au1xxx.c             |   21 
 drivers/usb/host/ehci-fsl.c                |   37 -
 drivers/usb/host/ehci-hcd.c                |   50 +
 drivers/usb/host/ehci-pci.c                |   59 -
 drivers/usb/host/ehci-sched.c              |  216 ++++++
 drivers/usb/host/isp116x-hcd.c             |    4 
 drivers/usb/host/sl811-hcd.c               |    2 
 drivers/usb/host/sl811_cs.c                |    2 
 drivers/usb/host/uhci-debug.c              |   45 +
 drivers/usb/host/uhci-hcd.c                |  139 ++--
 drivers/usb/host/uhci-hcd.h                |   81 +-
 drivers/usb/host/uhci-hub.c                |    5 
 drivers/usb/host/uhci-q.c                  |  947 ++++++++++++++++-------------
 drivers/usb/input/acecad.c                 |    4 
 drivers/usb/input/aiptek.c                 |    4 
 drivers/usb/input/appletouch.c             |  117 +++
 drivers/usb/input/ati_remote.c             |    4 
 drivers/usb/input/ati_remote2.c            |    2 
 drivers/usb/input/hid-core.c               |   83 +-
 drivers/usb/input/hid-input.c              |   36 -
 drivers/usb/input/hid.h                    |   11 
 drivers/usb/input/itmtouch.c               |    4 
 drivers/usb/input/kbtab.c                  |    5 
 drivers/usb/input/keyspan_remote.c         |    4 
 drivers/usb/input/mtouchusb.c              |    4 
 drivers/usb/input/powermate.c              |    4 
 drivers/usb/input/touchkitusb.c            |    4 
 drivers/usb/input/usbkbd.c                 |    4 
 drivers/usb/input/usbmouse.c               |    4 
 drivers/usb/input/usbtouchscreen.c         |    2 
 drivers/usb/input/wacom.c                  |    5 
 drivers/usb/input/xpad.c                   |    4 
 drivers/usb/input/yealink.c                |    4 
 drivers/usb/misc/Kconfig                   |   23 
 drivers/usb/misc/Makefile                  |    2 
 drivers/usb/misc/appledisplay.c            |  383 +++++++++++
 drivers/usb/misc/cy7c63.c                  |  244 +++++++
 drivers/usb/misc/phidgetkit.c              |  303 ++++++---
 drivers/usb/misc/sisusbvga/sisusb.c        |  127 +--
 drivers/usb/misc/sisusbvga/sisusb.h        |    6 
 drivers/usb/misc/sisusbvga/sisusb_con.c    |  151 ++--
 drivers/usb/misc/sisusbvga/sisusb_init.c   |    4 
 drivers/usb/misc/sisusbvga/sisusb_init.h   |   20 
 drivers/usb/misc/sisusbvga/sisusb_struct.h |    2 
 drivers/usb/misc/usbtest.c                 |   38 -
 drivers/usb/mon/mon_dma.c                  |    5 
 drivers/usb/mon/mon_main.c                 |   23 
 drivers/usb/mon/mon_stat.c                 |    4 
 drivers/usb/mon/mon_text.c                 |   36 +
 drivers/usb/mon/usb_mon.h                  |    2 
 drivers/usb/net/asix.c                     |    4 
 drivers/usb/net/cdc_ether.c                |   14 
 drivers/usb/net/pegasus.c                  |   29 
 drivers/usb/net/rndis_host.c               |    2 
 drivers/usb/net/zaurus.c                   |   19 
 drivers/usb/serial/Kconfig                 |   18 
 drivers/usb/serial/airprime.c              |    2 
 drivers/usb/serial/console.c               |   56 +
 drivers/usb/serial/cp2101.c                |    1 
 drivers/usb/serial/cyberjack.c             |    2 
 drivers/usb/serial/cypress_m8.c            |    2 
 drivers/usb/serial/empeg.c                 |    2 
 drivers/usb/serial/ftdi_sio.c              |   13 
 drivers/usb/serial/ftdi_sio.h              |    6 
 drivers/usb/serial/garmin_gps.c            |    2 
 drivers/usb/serial/generic.c               |    4 
 drivers/usb/serial/io_edgeport.c           |   48 -
 drivers/usb/serial/ipaq.c                  |    2 
 drivers/usb/serial/ipw.c                   |    2 
 drivers/usb/serial/ir-usb.c                |    2 
 drivers/usb/serial/keyspan.c               |    2 
 drivers/usb/serial/kl5kusb105.c            |    3 
 drivers/usb/serial/omninet.c               |    2 
 drivers/usb/serial/option.c                |  139 +++-
 drivers/usb/serial/pl2303.c                |    4 
 drivers/usb/serial/usb-serial.c            |   58 +
 drivers/usb/serial/usb-serial.h            |    5 
 drivers/usb/serial/visor.c                 |    2 
 drivers/usb/serial/whiteheat.c             |    8 
 drivers/usb/storage/onetouch.c             |    3 
 drivers/usb/storage/scsiglue.c             |    4 
 drivers/usb/storage/shuttle_usbat.c        |  105 ++-
 drivers/usb/storage/shuttle_usbat.h        |    4 
 drivers/usb/storage/transport.c            |   88 +-
 drivers/usb/storage/unusual_devs.h         |   35 -
 drivers/usb/storage/usb.c                  |   51 +
 include/linux/usb.h                        |   22 
 include/linux/usb/cdc.h                    |  205 ++++++
 include/linux/usb/input.h                  |   25 
 include/linux/usb/isp116x.h                |   29 
 include/linux/usb/sl811.h                  |   26 
 include/linux/usb_cdc.h                    |  205 ------
 include/linux/usb_input.h                  |   25 
 include/linux/usb_isp116x.h                |   29 
 include/linux/usb_sl811.h                  |   26 
 123 files changed, 4169 insertions(+), 2440 deletions(-)

---------------

Adrian Bunk:
      USB: sisusbvga: possible cleanups

Alan Stern:
      USB: usbcore: always turn on hub port power
      USB: net2280: add a shutdown routine
      USB: UHCI: store the endpoint type in the QH structure
      USB: UHCI: fix obscure bug in enqueue()
      usbhid: automatically set HID_QUIRK_NOGET for keyboards and mice
      UHCI: Common result routine for Control/Bulk/Interrupt
      UHCI: Remove non-iso TDs as they are used
      UHCI: Move code for cleaning up unlinked URBs
      UHCI: Eliminate the TD-removal list
      UHCI: Reimplement FSBR
      UHCI: Work around old Intel bug
      UHCI: use integer-sized frame numbers
      UHCI: fix race in ISO dequeuing
      UHCI: store the period in the queue header
      UHCI: remove ISO TDs as they are used
      gadgetfs: fix AIO interface bugs
      gadgetfs: fix memory leaks
      usbtest: report errors in iso tests
      usbhid: Remove unneeded blacklist entries
      usbcore: port reset for composite devices
      USB hub: use usb_reset_composite_device
      usb-storage: use usb_reset_composite_device
      usbhid: use usb_reset_composite_device
      usbcore: recovery from Set-Configuration failure
      usb-storage: unusual_devs entry for Nikon DSC D70s
      UHCI: remove hc_inaccessible flag
      UHCI: Improve FSBR-off timing
      USB: unusual_devs entry for Nokia N80

Andrew Morton:
      Driver for Apple Cinema Display

Arjan van de Ven:
      USB: convert the semaphores in the sisusb driver to mutexes

Bart Massey:
      USB HID/HIDBP, INPUT DRIVERS: fix various usb/input/hid-input.c bugs that make Apple Mighty Mouse work poorly

Chris Lund:
      USB: free allocated memory on io_edgeport startup memory failure

Dan Streetman:
      improved TT scheduling for EHCI

Daniel Drake:
      USB shuttle_usbat: hardcode flash detection for now
      USB: usb-storage alauda: Fix transport info mismerge
      USB: print message when device is rejected due to insufficient power

David Brownell:
      USB: usbnet, zaurus mtu fixup
      USB: correct the USB info in Documentation/power/swsusp.txt
      USB: more pegasus log spamming removed
      USB: cdc_ether: recognize olympus r1000 (fix regression)
      UHCI: various updates
      USB: whitespace removal from usb/gadget/ether
      USB: move <linux/usb_cdc.h> to <linux/usb/cdc.h>
      USB: move hardware-specific <linux/usb_*.h> to <linux/usb/*.h>
      USB: move <linux/usb_input.h> to <linux/usb/input.h>

Duncan Sands:
      USBATM: remove pointless inline
      USBATM: remove no-longer needed #include

Eduard Warkentin:
      USB: added support for ASIX 88178 chipset USB Gigabit Ethernet adaptor

Eric Sesterhenn:
      USB: negative index in drivers/usb/host/isp116x-hcd.c

Franck Bui-Huu:
      Fix a deadlock in usbtest
      usb-storage: get rid of the timer during URB submission
      USB: gadget-serial: fix a deadlock when closing the serial device
      USB: gadget-serial: do not save/restore IRQ flags in gs_close()

Frank Gevaerts:
      USB Serial: clean tty fields on failed device open

Giridhar Pemmasani:
      usbcore: Fix broken RNDIS config selection

Greg Kroah-Hartman:
      USB: add usb_interrupt_msg() function for api completeness.
      USB: move the endpoint specific sysfs code to it's own file
      USB: make usb_create_ep_files take a struct device
      USB: make endpoints real struct devices
      USB: move usb_device_class class devices to be real devices
      USB: convert usb class devices to real devices
      USB: only make /sys/class/usb show up when there is something in it

Guennadi Liakhovetski:
      USB: console: fix oops
      USB console: fix disconnection issues

Henk Vergonet:
      USB: add YEALINK phones to the HID_QUIRK_IGNORE blacklist

Ian Abbott:
      USB: ftdi_sio: add support for Yost Engineering ServoCenter3.1

Jeremy Fitzhardinge:
      USB: Add Sierra Wireless MC5720 ID to airprime.c

Kumar Gala:
      USB: allow multiple types of EHCI controllers to be built as modules

Luiz Fernando N. Capitulino:
      usbserial: Fixes wrong return values.

Matt Reimer:
      USB: trivial DEBUG message correction in gadget ether driver

Matthias Urlichs:
      USB: new devices for the Option driver

Micah Dowty:
      USB: Remove 4088-byte limit on usbfs control URBs
      USB: Allow high-bandwidth isochronous packets via usbfs

Milan Svoboda:
      usb gadget: allow drivers support speeds higher than full speed
      usb gadget: fix compile errors
      usb gadget: update pxa2xx_udc.c driver to fully support IXP4xx platform

Nicolas Boichat:
      USB: MacBook Pro touchpad support

Oliver Bock:
      USB: new driver for Cypress CY7C63xxx mirco controllers

Oliver Neukum:
      USB: cdc-acm: add a new special case for modems with buggy firmware

Paul Fulghum:
      USB: console: fix cr/lf issues
      USB: console: prevent ENODEV on node

Paul Serice:
      USB: EHCI works again on NVidia controllers with >2GB RAM

Pete Zaitcev:
      USB: clean out an unnecessary NULL check from ub
      usb: io_edgeport, cleanup to unicode handling
      USB serial: encapsulate schedule_work, remove double-calling
      USB: Improve Kconfig comment for mct_u232
      USB: Syntax cleanup for pl2303 (trailing backslash)
      USB: rmmod pl2303 after -28
      ub: atomic add_disk
      ub: random cleanups
      USB: io_edgeport touch-up
      USB: update usbmon, fix glued lines
      USB: implement error event in usbmon
      USB: update usbmon.txt

Peter Chubb:
      USB: shuttle_usbat: Fix handling of scatter-gather buffers
      USB: shuttle_usbat: Hardcode detection of HP CDRW devices

Philippe Retornaz:
      usb: drivers/usb/core/devio.c dereferences a userspace pointer

Ralf Baechle:
      USB: EHCI on non-Au1200 build fix

Rene Rebe:
      USB: Add Apple MacBook product IDs to usbhid

Sean Young:
      USB Phidget InterfaceKit: make inputs pollable and new device support

Stuart MacDonald:
      USB: Whiteheat: fix firmware spurious errors

Timothy Sipples:
      airprime.c: add Kyocera Wireless KPC650/Passport support

Vitja Makarov:
      USB: new cp2101 device

