Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267522AbSLEVic>; Thu, 5 Dec 2002 16:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267516AbSLEViF>; Thu, 5 Dec 2002 16:38:05 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:52240 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267509AbSLEVgu>;
	Thu, 5 Dec 2002 16:36:50 -0500
Date: Thu, 5 Dec 2002 13:44:10 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.50
Message-ID: <20021205214409.GA5028@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/bluetooth/hci_usb.c          |   12 +--
 drivers/isdn/hisax/st5481_usb.c      |    4 -
 drivers/media/video/cpia_usb.c       |    2 
 drivers/net/irda/irda-usb.c          |   12 +--
 drivers/usb/class/audio.c            |    8 +-
 drivers/usb/class/bluetty.c          |   16 ++--
 drivers/usb/class/cdc-acm.c          |    8 +-
 drivers/usb/class/usb-midi.c         |    8 +-
 drivers/usb/class/usblp.c            |    4 -
 drivers/usb/core/devio.c             |   61 +++++++-----------
 drivers/usb/core/hcd.c               |   61 ++++++++----------
 drivers/usb/core/hcd.h               |    6 +
 drivers/usb/core/hub.c               |    2 
 drivers/usb/core/message.c           |    4 -
 drivers/usb/host/ehci-hcd.c          |   82 +++++++++++++++----------
 drivers/usb/host/ehci-q.c            |  113 ++++++++++++++---------------------
 drivers/usb/host/ehci-sched.c        |    2 
 drivers/usb/host/hc_simple.c         |    4 -
 drivers/usb/host/hc_sl811_rh.c       |    6 -
 drivers/usb/host/ohci-hcd.c          |    8 +-
 drivers/usb/host/ohci-pci.c          |    2 
 drivers/usb/host/ohci-q.c            |   12 +--
 drivers/usb/host/uhci-hcd.c          |   17 +----
 drivers/usb/image/hpusbscsi.c        |   16 ++--
 drivers/usb/image/hpusbscsi.h        |   13 +---
 drivers/usb/image/mdc800.c           |    6 -
 drivers/usb/image/microtek.c         |   12 +--
 drivers/usb/image/microtek.h         |    1 
 drivers/usb/image/scanner.c          |    2 
 drivers/usb/input/aiptek.c           |    4 -
 drivers/usb/input/hid-core.c         |    6 -
 drivers/usb/input/pid.c              |    2 
 drivers/usb/input/powermate.c        |    6 -
 drivers/usb/input/usbkbd.c           |    4 -
 drivers/usb/input/usbmouse.c         |    2 
 drivers/usb/input/wacom.c            |   10 +--
 drivers/usb/input/xpad.c             |    2 
 drivers/usb/media/dabusb.c           |    2 
 drivers/usb/media/konicawc.c         |    2 
 drivers/usb/media/ov511.c            |    2 
 drivers/usb/media/pwc-if.c           |    2 
 drivers/usb/media/se401.c            |    4 -
 drivers/usb/media/stv680.c           |    2 
 drivers/usb/media/usbvideo.c         |    2 
 drivers/usb/misc/auerswald.c         |   38 +++++------
 drivers/usb/misc/brlvger.c           |    4 -
 drivers/usb/misc/speedtouch.c        |   12 +--
 drivers/usb/misc/tiglusb.c           |   52 ++++++----------
 drivers/usb/misc/usbtest.c           |    4 -
 drivers/usb/net/catc.c               |    8 +-
 drivers/usb/net/cdc-ether.c          |    4 -
 drivers/usb/net/kaweth.c             |   12 +--
 drivers/usb/net/pegasus.c            |   10 +--
 drivers/usb/net/rtl8150.c            |    8 +-
 drivers/usb/net/usbnet.c             |    8 +-
 drivers/usb/serial/belkin_sa.c       |    4 -
 drivers/usb/serial/cyberjack.c       |   12 +--
 drivers/usb/serial/digi_acceleport.c |    8 +-
 drivers/usb/serial/empeg.c           |    8 +-
 drivers/usb/serial/ftdi_sio.c        |    8 +-
 drivers/usb/serial/generic.c         |    4 -
 drivers/usb/serial/io_edgeport.c     |   16 ++--
 drivers/usb/serial/io_ti.c           |    6 -
 drivers/usb/serial/ipaq.c            |    8 +-
 drivers/usb/serial/ir-usb.c          |    8 +-
 drivers/usb/serial/keyspan.c         |   46 +++++++-------
 drivers/usb/serial/keyspan_pda.c     |    4 -
 drivers/usb/serial/kl5kusb105.c      |    8 +-
 drivers/usb/serial/mct_u232.c        |    8 +-
 drivers/usb/serial/omninet.c         |    8 +-
 drivers/usb/serial/pl2303.c          |   13 ++--
 drivers/usb/serial/pl2303.h          |    3 
 drivers/usb/serial/safe_serial.c     |    2 
 drivers/usb/serial/usb-serial.h      |   10 +--
 drivers/usb/serial/visor.c           |    8 +-
 drivers/usb/serial/whiteheat.c       |   16 ++--
 drivers/usb/storage/transport.c      |    8 --
 drivers/usb/storage/transport.h      |    2 
 drivers/usb/usb-skeleton.c           |    4 -
 include/linux/usb.h                  |   11 +--
 sound/usb/usbmidi.c                  |    6 -
 81 files changed, 466 insertions(+), 489 deletions(-)
-----

ChangeSet@1.840, 2002-12-05 15:21:11-06:00, greg@kroah.com
  USB: make usb device lists EXPORT_SYMBOL_GPL

 drivers/usb/core/hcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.839, 2002-12-05 15:19:13-06:00, greg@kroah.com
  USB: fix compile time error in tiglusb.c caused by previous devfs changes.

 drivers/usb/misc/tiglusb.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.838, 2002-12-05 14:37:49-06:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/gregkh-2.5

 drivers/usb/core/hcd.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)
------

ChangeSet@1.825.10.1, 2002-12-05 01:06:55-06:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/gregkh-2.5

 drivers/usb/misc/tiglusb.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)
------

ChangeSet@1.797.149.4, 2002-12-04 14:41:46-06:00, ahaas@airmail.net
  [PATCH] C99 initializer for include/linux/usb.h
  
  Here's a small patch for switching the file to use C99 initializers. The
  patch is against 2.5.50.

 include/linux/usb.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.797.149.3, 2002-12-04 01:02:55-08:00, rlievin@free.fr
  [PATCH] USB: tiglusb update
  
  - a patch against 2.5.50 (clean-up and includes Randy Dunlap's patch).

 drivers/usb/misc/tiglusb.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)
------

ChangeSet@1.797.149.2, 2002-12-03 23:04:47-08:00, dana.lacoste@peregrine.com
  [PATCH] RATOC USB-60 patch
  
  Trivial patch to get the RATOC USB60 USB-Serial converter working :

 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    3 +++
 2 files changed, 4 insertions(+)
------

ChangeSet@1.797.149.1, 2002-12-03 11:36:57-08:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/gregkh-2.5

 drivers/usb/core/devio.c        |   59 ++++++++-------------
 drivers/usb/core/hcd.c          |   11 +--
 drivers/usb/host/ehci-hcd.c     |   76 ++++++++++++++++-----------
 drivers/usb/host/ehci-q.c       |  111 ++++++++++++++++------------------------
 drivers/usb/host/uhci-hcd.c     |    4 -
 drivers/usb/storage/transport.c |    2 
 6 files changed, 121 insertions(+), 142 deletions(-)
------

ChangeSet@1.797.147.2, 2002-12-02 23:29:53-08:00, greg@kroah.com
  [PATCH] USB: fix up urb callback functions due to argument change

 drivers/bluetooth/hci_usb.c    |   12 ++++++------
 drivers/media/video/cpia_usb.c |    2 +-
 drivers/usb/class/audio.c      |    8 ++++----
 drivers/usb/media/dabusb.c     |    2 +-
 drivers/usb/media/konicawc.c   |    2 +-
 drivers/usb/media/ov511.c      |    2 +-
 drivers/usb/media/pwc-if.c     |    2 +-
 drivers/usb/media/usbvideo.c   |    2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)
------

ChangeSet@1.797.147.1, 2002-12-02 22:54:03-08:00, davem@redhat.com
  [PATCH] kbd_pt_regs
  
  Hey guys, I really want to kill this thing.
  
  The only way to do that is to actually pass the pt_regs
  all the way down from the interrupt source.  It would be
  a three step process:
  
  1) Add pt_regs arg to serio_interrupt and serio->dev->interrupt()
     Update all serio->dev drivers and serio_interrupt() invokers.
  
     I've done this in the patch below.  We must handle pt_regs being
     NULL, f.e. when the event is via a tty ldisc or a timer for which
     there is no "pt_regs" context to obtain.
  
  2) At the input layer, push 'regs' down via input_event() into the
     handlers.
  
     Patch below does this as well.
  
  3) Final step to complete this, convert USB to pass the pt_regs that
     the host controller interrupt receives down to the URB callbacks.
  
     This itself was also a multistep process:
  
  	a) pass regs down from generic host controller
  	   layer to hcd driver
  
  	b) pass regs from hcd driver into urb handler
  
  	   EHCI is problematic here, as it does the URB
  	   work in a tasklet :(  we need to decide whether
  	   we can move the normal URB completion back into
  	   the hw interrupt handler or not
  
  	   I think it should be done, I'd basically have my
  	   thumbs up my butt if I didn't have Alt-SYSRQ-p
  	   register dumps available and that is what EHCI+usbkbd
  	   is currently.
  
  	   UHCI and OHCI both complete urbs in hw IRQ context
  	   so they are just fine.
  
  	c) update urb handlers to take the regs arg, make hcd
  	   drivers pass it on in
  
     I was really bored, so this was also done in the patch below :)
  
     We get a USB cleanup for free because of this, a lot of people
     were defining their own ugly typedefs for what should be
     usb_complete_t so I fixed that up :-)
  
     I also caught a lot of usb_fill_*() call sites casting the
     completion function pointer to usb_complete_t so the compiler
     wouldn't help us find necessary fixup if we changed the
     args again :-(  I think I got them all, someone bored should
     grep the tree for usb_complete_t and fixup any remaining spots
     where it is used in a cast.
  
     I tried to enable as many drivers as possible in a test build
     but it is possible I did miss a few obscure USB configs.
  
  So why do I want to kill kbd_pt_regs so badly?  Well, first of all I
  have to walk through all kinds of hoops on sparc64 to update
  kbd_pt_regs properly on the USB controller interrupt and I've had
  a few cases where I had trouble tracking down some kernel bug
  because kbd_pt_regs could easily be inaccurate if another interrupt
  came in right after the keyboard USB one.
  
  Right now, kbd_pt_regs is not updated at all for USB keyboards on x86
  rendering SYSRQ register dumps non-existent in such configurations.
  This forces it to happen, and because the regs are passed in the
  context in which the URB completes, it will always be accurate (it
  will even work properly if I have 5 USB keyboards :-)
  
  While doing this, I also noticed a bunch of ancient keyboard drivers
  in 2.5.x under drivers/char that need to be converted or deleted.
  They were still calling handle_scancode() !!! :-)  drivers/tc
  has few as well.  There is also a stray handle_scancode() reference
  in a include/asm-parisc/keyboard.h comment
  
  I tested this on sparc64 with an OHCI attached USB keyboard,
  and register dumping works fine etc.
  
  Here is just the USB bits.

 drivers/isdn/hisax/st5481_usb.c      |    4 +--
 drivers/net/irda/irda-usb.c          |   12 ++++-----
 drivers/usb/class/bluetty.c          |   16 ++++++------
 drivers/usb/class/cdc-acm.c          |    8 +++---
 drivers/usb/class/usb-midi.c         |    8 +++---
 drivers/usb/class/usblp.c            |    4 +--
 drivers/usb/core/devio.c             |    2 -
 drivers/usb/core/hcd.c               |   23 +++++++++--------
 drivers/usb/core/hcd.h               |    6 +++-
 drivers/usb/core/hub.c               |    2 -
 drivers/usb/core/message.c           |    4 +--
 drivers/usb/host/ehci-hcd.c          |    6 ++--
 drivers/usb/host/ehci-q.c            |    2 -
 drivers/usb/host/ehci-sched.c        |    2 -
 drivers/usb/host/hc_simple.c         |    4 +--
 drivers/usb/host/hc_sl811_rh.c       |    6 ++--
 drivers/usb/host/ohci-hcd.c          |    8 +++---
 drivers/usb/host/ohci-pci.c          |    2 -
 drivers/usb/host/ohci-q.c            |   12 ++++-----
 drivers/usb/host/uhci-hcd.c          |   13 ++++-----
 drivers/usb/image/hpusbscsi.c        |   16 ++++++------
 drivers/usb/image/hpusbscsi.h        |   13 ++++-----
 drivers/usb/image/mdc800.c           |    6 ++--
 drivers/usb/image/microtek.c         |   12 ++++-----
 drivers/usb/image/microtek.h         |    1 
 drivers/usb/image/scanner.c          |    2 -
 drivers/usb/input/aiptek.c           |    4 +--
 drivers/usb/input/hid-core.c         |    6 ++--
 drivers/usb/input/pid.c              |    2 -
 drivers/usb/input/powermate.c        |    6 ++--
 drivers/usb/input/usbkbd.c           |    4 +--
 drivers/usb/input/usbmouse.c         |    2 -
 drivers/usb/input/wacom.c            |   10 +++----
 drivers/usb/input/xpad.c             |    2 -
 drivers/usb/media/se401.c            |    4 +--
 drivers/usb/media/stv680.c           |    2 -
 drivers/usb/misc/auerswald.c         |   38 ++++++++++++++--------------
 drivers/usb/misc/brlvger.c           |    4 +--
 drivers/usb/misc/speedtouch.c        |   12 ++++-----
 drivers/usb/misc/usbtest.c           |    4 +--
 drivers/usb/net/catc.c               |    8 +++---
 drivers/usb/net/cdc-ether.c          |    4 +--
 drivers/usb/net/kaweth.c             |   12 ++++-----
 drivers/usb/net/pegasus.c            |   10 +++----
 drivers/usb/net/rtl8150.c            |    8 +++---
 drivers/usb/net/usbnet.c             |    8 +++---
 drivers/usb/serial/belkin_sa.c       |    4 +--
 drivers/usb/serial/cyberjack.c       |   12 ++++-----
 drivers/usb/serial/digi_acceleport.c |    8 +++---
 drivers/usb/serial/empeg.c           |    8 +++---
 drivers/usb/serial/ftdi_sio.c        |    8 +++---
 drivers/usb/serial/generic.c         |    4 +--
 drivers/usb/serial/io_edgeport.c     |   16 ++++++------
 drivers/usb/serial/io_ti.c           |    6 ++--
 drivers/usb/serial/ipaq.c            |    8 +++---
 drivers/usb/serial/ir-usb.c          |    8 +++---
 drivers/usb/serial/keyspan.c         |   46 +++++++++++++++++------------------
 drivers/usb/serial/keyspan_pda.c     |    4 +--
 drivers/usb/serial/kl5kusb105.c      |    8 +++---
 drivers/usb/serial/mct_u232.c        |    8 +++---
 drivers/usb/serial/omninet.c         |    8 +++---
 drivers/usb/serial/pl2303.c          |   12 ++++-----
 drivers/usb/serial/safe_serial.c     |    2 -
 drivers/usb/serial/usb-serial.h      |   10 +++----
 drivers/usb/serial/visor.c           |    8 +++---
 drivers/usb/serial/whiteheat.c       |   16 ++++++------
 drivers/usb/storage/transport.c      |    6 ++--
 drivers/usb/storage/transport.h      |    2 -
 drivers/usb/usb-skeleton.c           |    4 +--
 include/linux/usb.h                  |    3 +-
 sound/usb/usbmidi.c                  |    6 ++--
 71 files changed, 285 insertions(+), 284 deletions(-)
------

