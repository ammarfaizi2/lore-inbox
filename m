Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVC3Vso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVC3Vso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVC3Vso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:48:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:3799 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262279AbVC3Vqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:46:36 -0500
Date: Wed, 30 Mar 2005 13:46:06 -0800
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.6.12-rc1
Message-ID: <20050330214606.GA20026@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB patchs for 2.6.12-rc1.  All of these patches have been
in the past few -mm releases.  There are a lot of bugfixes in here, and
a few new drivers have been added (and one removed.)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/image/hpusbscsi.c        |  523 -----------------------------
 drivers/usb/image/hpusbscsi.h        |   73 ----
 Documentation/usb/usbmon.txt         |  156 ++++++++
 MAINTAINERS                          |   32 +
 arch/arm/mach-omap/usb.c             |   87 ++--
 drivers/block/ub.c                   |   81 +++-
 drivers/media/video/cpia_usb.c       |    4 
 drivers/usb/Makefile                 |    2 
 drivers/usb/class/usb-midi.c         |    6 
 drivers/usb/core/buffer.c            |    2 
 drivers/usb/core/config.c            |    6 
 drivers/usb/core/devices.c           |    7 
 drivers/usb/core/hcd-pci.c           |   14 
 drivers/usb/core/hcd.c               |  112 ++++--
 drivers/usb/core/hcd.h               |   40 --
 drivers/usb/core/hub.c               |  102 +++++
 drivers/usb/core/hub.h               |    2 
 drivers/usb/core/message.c           |   10 
 drivers/usb/core/usb.c               |   41 ++
 drivers/usb/core/usb.h               |    8 
 drivers/usb/gadget/Kconfig           |   77 +---
 drivers/usb/gadget/config.c          |    1 
 drivers/usb/gadget/dummy_hcd.c       |    6 
 drivers/usb/gadget/ether.c           |  504 ++++++++++++++++++----------
 drivers/usb/gadget/file_storage.c    |   65 ++-
 drivers/usb/gadget/gadget_chips.h    |    7 
 drivers/usb/gadget/inode.c           |   29 -
 drivers/usb/gadget/net2280.c         |    2 
 drivers/usb/gadget/pxa2xx_udc.c      |  279 ++++++++++-----
 drivers/usb/gadget/pxa2xx_udc.h      |   29 -
 drivers/usb/gadget/rndis.c           |  169 ++++-----
 drivers/usb/gadget/rndis.h           |  162 ++++-----
 drivers/usb/gadget/serial.c          |    3 
 drivers/usb/gadget/usbstring.c       |    4 
 drivers/usb/gadget/zero.c            |   50 +-
 drivers/usb/host/ehci-hcd.c          |   26 -
 drivers/usb/host/ehci-hub.c          |   10 
 drivers/usb/host/ehci-q.c            |   23 -
 drivers/usb/host/ehci-sched.c        |   43 +-
 drivers/usb/host/ehci.h              |    2 
 drivers/usb/host/ohci-dbg.c          |    6 
 drivers/usb/host/ohci-hcd.c          |   24 -
 drivers/usb/host/ohci-hub.c          |   19 -
 drivers/usb/host/ohci-omap.c         |  123 ++----
 drivers/usb/host/ohci-q.c            |   12 
 drivers/usb/host/ohci.h              |   10 
 drivers/usb/host/sl811-hcd.c         |   16 
 drivers/usb/host/uhci-debug.c        |    4 
 drivers/usb/host/uhci-hcd.c          |  166 ++++-----
 drivers/usb/host/uhci-hcd.h          |   37 +-
 drivers/usb/host/uhci-hub.c          |   46 +-
 drivers/usb/host/uhci-q.c            |  107 ++++--
 drivers/usb/image/Kconfig            |   11 
 drivers/usb/image/Makefile           |    1 
 drivers/usb/image/microtek.c         |    8 
 drivers/usb/input/aiptek.c           |    2 
 drivers/usb/media/ibmcam.c           |    3 
 drivers/usb/media/pwc/pwc-ctrl.c     |   10 
 drivers/usb/media/pwc/pwc-dec23.c    |    4 
 drivers/usb/media/pwc/pwc-if.c       |   45 +-
 drivers/usb/media/usbvideo.c         |    6 
 drivers/usb/misc/emi26.c             |    2 
 drivers/usb/misc/rio500.c            |   12 
 drivers/usb/misc/sisusbvga/sisusb.c  |   17 
 drivers/usb/misc/usblcd.c            |  534 +++++++++++++++---------------
 drivers/usb/misc/usbtest.c           |    2 
 drivers/usb/mon/mon_text.c           |   14 
 drivers/usb/net/catc.c               |    3 
 drivers/usb/net/kaweth.c             |    2 
 drivers/usb/net/kawethfw.h           |    8 
 drivers/usb/net/pegasus.c            |  304 +++++++++++------
 drivers/usb/net/pegasus.h            |    4 
 drivers/usb/net/usbnet.c             |  427 ++++++++++++++++++------
 drivers/usb/net/zd1201.c             |    4 
 drivers/usb/net/zd1201.h             |    4 
 drivers/usb/serial/Kconfig           |   28 +
 drivers/usb/serial/Makefile          |    3 
 drivers/usb/serial/cp2101.c          |  617 ++++++++++++++++++++++++++++++++++-
 drivers/usb/serial/digi_acceleport.c |   29 -
 drivers/usb/serial/ftdi_sio.c        |   55 +--
 drivers/usb/serial/garmin_gps.c      |    4 
 drivers/usb/serial/ipw.c             |    4 
 drivers/usb/serial/kl5kusb105.c      |    2 
 drivers/usb/serial/mct_u232.c        |   22 -
 drivers/usb/serial/usb-serial.c      |   10 
 drivers/usb/serial/visor.c           |   41 +-
 drivers/usb/serial/visor.h           |    3 
 drivers/usb/storage/Kconfig          |   22 -
 drivers/usb/storage/datafab.c        |    2 
 drivers/usb/storage/debug.h          |    2 
 drivers/usb/storage/dpcm.c           |    2 
 drivers/usb/storage/freecom.c        |    2 
 drivers/usb/storage/initializers.c   |    2 
 drivers/usb/storage/isd200.c         |    2 
 drivers/usb/storage/jumpshot.c       |    2 
 drivers/usb/storage/protocol.c       |    3 
 drivers/usb/storage/protocol.h       |    3 
 drivers/usb/storage/scsiglue.c       |  111 ++----
 drivers/usb/storage/scsiglue.h       |    6 
 drivers/usb/storage/sddr09.c         |    2 
 drivers/usb/storage/sddr55.c         |    2 
 drivers/usb/storage/shuttle_usbat.c  |   15 
 drivers/usb/storage/shuttle_usbat.h  |    4 
 drivers/usb/storage/transport.c      |   13 
 drivers/usb/storage/transport.h      |    8 
 drivers/usb/storage/unusual_devs.h   |   52 ++
 drivers/usb/storage/usb.c            |  180 ++++------
 drivers/usb/storage/usb.h            |   62 ++-
 include/linux/usb.h                  |    4 
 include/linux/usb_cdc.h              |   34 +
 sound/usb/usbaudio.c                 |    8 
 sound/usb/usbmidi.c                  |    2 
 112 files changed, 3603 insertions(+), 2556 deletions(-)
-----


<craig:microtron.org.uk>:
  o USB: add driver for CP2101/CP2102 RS232 adaptors

<g.toth:e-biz.lu>:
  o USB: rewrite the usblcd driver

Adrian Bunk:
  o MAINTAINERS: remove obsolete HPUSBSCSI entry
  o drivers/usb/media/usbvideo.c: fix a check after use
  o drivers/usb/misc/usbtest.c: fix a NULL dereference
  o drivers/usb/class/usb-midi.c: remove dead code
  o drivers/usb/core/devices.c: small corrections
  o remove drivers/usb/image/hpusbscsi.c
  o drivers/usb/net/pegasus.c: make some code static
  o drivers/usb/storage/: cleanups
  o drivers/usb/serial/: make some functions static
  o USB: possible cleanups

Alan Stern:
  o USB: fix usb file_storage gadget sparse fixes [2/5]
  o UHCI updates
  o UHCI updates
  o UHCI updates
  o UHCI updates
  o UHCI updates
  o USBcore updates
  o USBcore updates
  o USBcore updates
  o USBcore and HCD updates
  o USBcore updates
  o USB: Prevent hub driver interference during port reset
  o g_file_storage: add configuration and interface strings
  o usb-midi: fix arguments to usb_maxpacket()

Andrew Morton:
  o usb hcd u64 warning fix

Clemens Ladisch:
  o emi26: add another product ID for the Emi2|6/A26

Colin Leroy:
  o USB: fix shared key auth in zd1201
  o USB: fix harmful typos in zd1201.c
  o USB: fix missing hunk in drivers/usb/Makefile

David Brownell:
  o USB: ohci D3 resume fix
  o USB: ehci split ISO fixes (full speed audio etc)
  o USB: usbnet uses netif_msg_*() ethtool filtering
  o USB: usbnet minor bugfixes
  o USB: pegasus uses netif_msg_*() filters
  o USB: usb rndis gadget sparse fixes [4/5]
  o USB: gadget zero sparse fixes [5/5]
  o USB: usb gadgetfs sparse fixes [3/5]
  o USB: usb file_storage gadget sparse fixes [2/5]
  o USB: usb gadget misc sparse fixes [1/5]
  o USB: pxa25x udc updates, mostly PM
  o USB: ohci-omap update (mostly clock gating)
  o USB: ethernet/rndis gadget driver updates
  o USB: net2280 reports correct dequeue status
  o USB: usbnet fix for Zaurus C-860
  o USB: usbnet gets status polling, uses for CDC Ethernet
  o USB: ehci and short in-bulk transfers with 20KB+ urbs
  o USB: ohci zero length control IN transfers
  o USB: usb gadget kconfig tweaks
  o USB: add at91_udc recognition

Domen Puncer:
  o USB: compile warning cleanup
  o usb/digi_acceleport: remove interruptible_sleep_on_timeout() usage
  o usb/rio500: remove interruptible_sleep_on_timeout() usage

Greg Kroah-Hartman:
  o USB: fix up a lot of sparse warnings and bugs in the pwc driver
  o USB: Put the Kconfig and Makefile back in proper order for the serial drivers
  o USB: mark functions static in the cp2101 driver
  o USB: add fossil watch ids to the visor driver
  o USB: mark usb-serial interface GPL only
  o USB: fix bug in visor driver with throttle/unthrottle causing oopses
  o USB Storage: remove unneeded unusual_devs.h entry
  o USB: fix cpia_usb driver's warning messages in the syslog
  o USB: minor cleanup of string freeing in core code
  o USB: optimize the usb-storage device string logic a bit

Guillermo Menguez Alvarez:
  o USB: Support for new ipod mini (and possibly others) + usb

Ian Abbott:
  o ftdi_sio: fix sysfs attribute permissions
  o ftdi_sio: Support sysfs attributes for more chip
  o ftdi_sio: add array to map chip type to a string

Matthew Dharm:
  o USB Storage: remove RW_DETECT from being a config option
  o USB Storage: combine waitqueues
  o USB Storage: allow disconnect to complete faster
  o USB Storage: exit control thread immediately upon disconnect
  o USB Storage: make usb-storage structures refcounted by SCSI
  o USB Storage: change how unusual_devs.h flags are defined
  o USB Storage: remove unneeded NULL tests
  o USB Storage: Header reorganization

Nishanth Aravamudan:
  o sound/usbmidi: change parameters of usb_bulk_msg() to msecs
  o sound/usbaudio: change parameters of snd_usb_ctl_msg() to msecs
  o usb/kl5kusb105: change parameters of usb_control_msg() to msecs
  o usb/pwc-ctrl: change parameters of usb_control_msg() to msecs

Olaf Hering:
  o USB: another broken usb floppy

Olaf Kirch:
  o USB: fix uhci irq 10: nobody cared! error

Oliver Neukum:
  o USB: removal of obsolete error code from kaweth

Pete Zaitcev:
  o USB: fix for ub for sleeping function called from invalid context at kernel/workqueue.c:264
  o USB: Add myself to MAINTAINERS
  o USB: usbmon - document and kill pipe from API
  o USB: Fix baud selection in mct_u232
  o USB: ub static patch
  o USB: Patch for ub to fix oops after disconnect

Phil Dibowitz:
  o USB Storage: Remove dup in unusual_devs
  o USB unusual_devs: add another datafab device
  o USB unusual_devs: Add another Tekom entry

Randy Dunlap:
  o pwc: fix printk arg types
  o sisusb: fix arg. types

Roman Kagan:
  o drivers/usb/core/usb.c: add MODALIAS env var to hotplug

