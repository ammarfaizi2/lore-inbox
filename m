Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbSLEWuI>; Thu, 5 Dec 2002 17:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbSLEWuI>; Thu, 5 Dec 2002 17:50:08 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:273 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267581AbSLEWuC>;
	Thu, 5 Dec 2002 17:50:02 -0500
Date: Thu, 5 Dec 2002 14:57:21 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.20
Message-ID: <20021205225721.GB5681@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates for 2.4.20.

Pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email.

thanks,

greg k-h

 drivers/usb/vicam.h              |   81 -
 drivers/usb/vicamurbs.h          |  324 ------
 Documentation/Configure.help     |   15 
 Documentation/usb/usb-serial.txt |   43 
 drivers/input/input.c            |    2 
 drivers/usb/Config.in            |   11 
 drivers/usb/Makefile             |    3 
 drivers/usb/devio.c              |  125 +-
 drivers/usb/hcd.c                |   94 +
 drivers/usb/hcd.h                |    1 
 drivers/usb/hcd/ehci-dbg.c       |  525 +++++++++-
 drivers/usb/hcd/ehci-hcd.c       |  512 +++++++---
 drivers/usb/hcd/ehci-hub.c       |   16 
 drivers/usb/hcd/ehci-q.c         |  575 ++++++-----
 drivers/usb/hcd/ehci-sched.c     |  630 +++++-------
 drivers/usb/hcd/ehci.h           |   87 +
 drivers/usb/hid-core.c           |    6 
 drivers/usb/hid-input.c          |    2 
 drivers/usb/hpusbscsi.c          |   25 
 drivers/usb/hpusbscsi.h          |    1 
 drivers/usb/pegasus.c            |  238 +++-
 drivers/usb/pegasus.h            |   18 
 drivers/usb/powermate.c          |  363 +++++++
 drivers/usb/rtl8150.c            |    1 
 drivers/usb/scanner.h            |   26 
 drivers/usb/serial/io_16654.h    |   16 
 drivers/usb/serial/io_edgeport.c |   18 
 drivers/usb/serial/io_ti.c       |   18 
 drivers/usb/serial/ipaq.c        |   25 
 drivers/usb/serial/keyspan.c     |    5 
 drivers/usb/serial/pl2303.c      |    1 
 drivers/usb/serial/pl2303.h      |    3 
 drivers/usb/serial/visor.c       |    6 
 drivers/usb/serial/visor.h       |    3 
 drivers/usb/tiglusb.c            |   46 
 drivers/usb/usb-midi.c           |   10 
 drivers/usb/usb-uhci.c           |    1 
 drivers/usb/usbnet.c             |  335 +++++-
 drivers/usb/vicam.c              | 1895 +++++++++++++++++++++++----------------
 include/linux/input.h            |    1 
 include/linux/videodev.h         |    1 
 drivers/usb/Makefile             |    0 
 42 files changed, 3761 insertions(+), 2347 deletions(-)
-----

ChangeSet@1.798, 2002-12-05 14:22:42-08:00, rlievin@free.fr
  [PATCH] USB: tiglusb sync with 2.5
  

 drivers/usb/tiglusb.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)
------

ChangeSet@1.797, 2002-12-05 14:22:32-08:00, rddunlap@osdl.org
  [PATCH] USB requires MIDI
  
  Driver has unresolved references to sound/MIDI symbols
  (linker problems) without this if USB_MIDI = Y and
  SOUND isn't in-kernel.

 drivers/usb/Config.in |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.796, 2002-12-05 14:22:24-08:00, marcel@holtmann.org
  [PATCH] Disable bluetooth.o if Bluetooth subsystem is used
  
  This patch disables the USB Bluetooth driver (bluetooth.o) from
  the drivers/usb/ directory if the Linux Bluetooth subsystem is
  selected.

 drivers/usb/Config.in |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)
------

ChangeSet@1.795, 2002-12-05 14:22:16-08:00, dana.lacoste@peregrine.com
  [PATCH] RATOC USB-60 patch
  
  Trivial patch to get the RATOC USB60 USB-Serial converter working :

 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    3 +++
 2 files changed, 4 insertions(+)
------

ChangeSet@1.794, 2002-12-05 14:22:07-08:00, will@sowerbutts.com
  [PATCH] USB: add USB powermate driver
  
  Matches the existing 2.5 driver support.

 Documentation/Configure.help |   15 +
 drivers/input/input.c        |    2 
 drivers/usb/Config.in        |    1 
 drivers/usb/Makefile         |    1 
 drivers/usb/hid-core.c       |    6 
 drivers/usb/powermate.c      |  363 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/input.h        |    1 
 7 files changed, 389 insertions(+)
------

ChangeSet@1.793, 2002-12-05 14:21:57-08:00, tvrtko@net4u.hr
  [PATCH] usb-uhci, fixed memory leak with one-shot interrupt transfers
  
  Credit goes to Georg Acher for the fix. I only reported the leak, and did the
  pre&post testing. Tested under 2.4.18 and 2.4.19.

 drivers/usb/usb-uhci.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.792, 2002-12-05 14:21:46-08:00, baldrick@wanadoo.fr
  [PATCH] usbdevfs: more list cleanups
  
  Here is a small cleanup patch for 2.4 that goes on top of my previous
  ones.  It makes devio.c use the list traversal macros from list.h.

 drivers/usb/devio.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)
------

ChangeSet@1.791, 2002-12-05 14:21:38-08:00, randy.dunlap@verizon.net
  [PATCH] tiglusb timeouts
  
  It addresses the timeout parameter in the tiglusb driver.
  
  1.  timeout could be 0, causing a divide-by-zero.
  The patch prevents this.
  
  2.  The timeout value to usb_bulk_msg() could be rounded
  down to cause a divide-by-zero if timeout was < 10, e.g. 9,
  in:
  	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_read,
  			       &bytes_read, HZ / (timeout / 10));
  9 / 10 == 0 => divide-by-zero !!
  
  3.  The timeout value above doesn't do very well on converting
  timeout to tenths of seconds.  Even for the default timeout
  value of 15 (1.5 seconds), it becomes:
  	HZ / (15 / 10) == HZ / 1 == HZ, or 1 second.
  The patch corrects this formula to use:
  	(HZ * 10) / timeout

 drivers/usb/tiglusb.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)
------

ChangeSet@1.790, 2002-12-05 14:21:30-08:00, ganesh@tuxtop.vxindia.veritas.com
  [PATCH] USB ipaq: added support for insmod options to specify vendor/product id
  
  this will allow people to try out new wince/pocketpc2k devices without
  having to recompile the module.

 Documentation/usb/usb-serial.txt |   43 +++++++++------------------------------
 drivers/usb/serial/ipaq.c        |   22 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 35 deletions(-)
------

ChangeSet@1.789, 2002-12-05 14:21:22-08:00, greg@kroah.com
  [PATCH] USB: added Palm Tungsten W support.
  
  Thanks to Ralf Dietrich <ralle@envicon.de> for the information.

 drivers/usb/serial/visor.c |    2 ++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 3 insertions(+)
------

ChangeSet@1.788, 2002-12-05 14:21:12-08:00, baldrick@wanadoo.fr
  [PATCH] usbdevfs: finalize urbs on interface release
  
  here is a patch for 2.4 that goes on top of the previous one.  It cleans up the
  list handling, in line with Dave's comment.

 drivers/usb/devio.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)
------

ChangeSet@1.787, 2002-12-05 14:21:03-08:00, ganesh@tuxtop.vxindia.veritas.com
  [PATCH] USB ipaq: brown paper bag bug - uninitialized spinlock fixed.
  

 drivers/usb/serial/ipaq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.786, 2002-12-05 14:20:55-08:00, randy.dunlap@verizon.net
  [PATCH] USB: use time_before() to compare times
  

 drivers/usb/serial/keyspan.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.785, 2002-12-05 14:20:47-08:00, baldrick@wanadoo.fr
  [PATCH] usbdevfs: finalize urbs on interface release
  
  Description: When an urb has been submitted via usbdevfs, and is still
  pending when the interface it was submitted to is released, force the
  urb to be completed.  This is the correct behaviour.  It fixes an oops on
  system shutdown when using the user space driver for the speedtouch
  modem.

 drivers/usb/devio.c |   72 +++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 52 insertions(+), 20 deletions(-)
------

ChangeSet@1.784, 2002-12-05 14:20:39-08:00, petkan@tequila.dce.bg
  [PATCH] USB: pegasus: the kmalloc/kfree crap removed from [get|set]_registers();
  

 drivers/usb/pegasus.c |  238 +++++++++++++++++++++++++++++++++++---------------
 drivers/usb/pegasus.h |   15 ++-
 2 files changed, 180 insertions(+), 73 deletions(-)
------

ChangeSet@1.783, 2002-12-05 14:20:31-08:00, oliver@oenone.homelinux.org
  [PATCH] - use of unplugged scanner oops fix
  

 drivers/usb/hpusbscsi.c |   23 +++++++++++++++--------
 drivers/usb/hpusbscsi.h |    1 +
 2 files changed, 16 insertions(+), 8 deletions(-)
------

ChangeSet@1.782, 2002-12-05 14:20:22-08:00, henning@meier-geinitz.de
  [PATCH] [PATCH 2.4.20-rc1] scanner.h: add/fix vendor/product ids
  
  This patch against 2.4.20-rc1 adds some vendor/product ids for Mustek
  and Lexmark scanners. Also, the names of the existing Mustek scanners
  were fixed and the product id of the Bearpaw 1200 F was corrected.
  
  I think that's a rather low-risk patch that can be applied. That's why
  I splitted it from the patch that fixes the "two-endpoints-only" issue
  and the "can't unload" issue of the scanner driver (posted earlier on
  linux-usb-devel).

 drivers/usb/scanner.h |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)
------

ChangeSet@1.781, 2002-12-05 14:20:12-08:00, david-b@pacbell.net
  [PATCH] usbnet talks to Zaurus
  
  This more or less syncs the 2.4 version with the 2.5 one.
  
  It teaches "usbnet" how to talk to the SL-5000D/SL-5500,
  and the A-300.  It's got some cleanups of how it talks
  to other StrongArm PDAs -- which is most of the patch by
  volume, other than making the GPL explicit.
  
  This will make Zaurus interop easier, folk won't need to
  find and install the "usbdnet" version which, as Pavel
  put it, "eats disks".

 drivers/usb/usbnet.c |  335 ++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 265 insertions(+), 70 deletions(-)
------

ChangeSet@1.780, 2002-12-05 14:20:04-08:00, erik@aarg.net
  [PATCH] USB: added support for Palm Tungsten T devices to visor driver
  

 drivers/usb/serial/visor.c |    2 ++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 3 insertions(+)
------

ChangeSet@1.779, 2002-12-05 14:19:56-08:00, olh@suse.de
  [PATCH] minor fixes for compile warnings in 2.4.20pre11 , usb-2.4 tree
  
  this patch fixes some compile warnings with the 2.4.20pre11 tree.
  The rtl8150.c does not compile on ppc32 because linux/init.h is missing,
  but the driver uses __init.
  
  The MSR_RI is the machine state register on ppc, it seems to be a modem
  state register on the io edge port. The patch does just a rename, maybe
  it can be done in a better way..

 drivers/usb/hpusbscsi.c          |    2 +-
 drivers/usb/rtl8150.c            |    1 +
 drivers/usb/serial/io_16654.h    |   16 ++++++++--------
 drivers/usb/serial/io_edgeport.c |   18 +++++++++---------
 drivers/usb/serial/io_ti.c       |   18 +++++++++---------
 drivers/usb/serial/keyspan.c     |    3 +++
 6 files changed, 31 insertions(+), 27 deletions(-)
------

ChangeSet@1.778, 2002-12-05 14:19:47-08:00, plcl@telefonica.net
  [PATCH] usb-midi patch for 2.4.20-pre11
  
  Please, apply the attached patch for usb-midi.c (Linux kernel 2.4.20-pre11)
  
  This patch solves some problems with MIDI IN:
  - System exclusive messages corrupted.
  - Other MIDI messages lost (mainly simultaneous notes).

 drivers/usb/usb-midi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
------

ChangeSet@1.777, 2002-12-05 14:19:39-08:00, acme@conectiva.com.br
  [PATCH] Add support for JTEC FA8101 USB to Ethernet device
  
    o Add support for JTEC FA8101 USB to Ethernet device

 drivers/usb/pegasus.h |    3 +++
 1 files changed, 3 insertions(+)
------

ChangeSet@1.776, 2002-12-05 14:19:31-08:00, greg@kroah.com
  [PATCH] removed vicamurbs.h
  

 drivers/usb/vicamurbs.h |  324 ------------------------------------------------
 1 files changed, 324 deletions(-)
------

ChangeSet@1.775, 2002-12-05 14:19:21-08:00, joe@wavicle.org
  [PATCH] Vicam patch against 2.4.20-pre9
  
  Hi Greg,
  
  I'm not sure what the correct way to submit these patches is, so I'm going to
  send you this one, feel free to reject it because it's in the wrong format,
  you want a patch against 2.5.x first or you want a patch against 2.4.20
  instead.
  
  -Joe
  
  diff -urN linux-2.4.19/drivers/usb/Makefile
  linux-2.4.19-vicam/drivers/usb/Makefile

 drivers/usb/vicam.h      |   81 --
 drivers/usb/Makefile     |    2 
 drivers/usb/vicam.c      | 1895 ++++++++++++++++++++++++++++-------------------
 include/linux/videodev.h |    1 
 4 files changed, 1150 insertions(+), 829 deletions(-)
------

ChangeSet@1.746.1.3, 2002-10-21 14:48:25-07:00, dbrownell@users.sourceforge.net
  [PATCH] USB:  USB 2.0 controller and hubs bugfixes
  
  Yes, this looks like a big patch, but for users with USB 2.0 devices it
  is necessary.  It contains the following things:
  
   - Key point:  this works, more reliably, on a lot of hardware
     that previously did not work.  So it's got all the bugfixes that
     went into 2.5 since three months into the 2.4.19 series, and a fair
     degree of user testing.  Quite a few users have reported complete
     failure on their 2.4 systems until they updated ... and that the
     update gave them no troubles.
  
   - Adds missing locking to some queue unlink paths.  This resolves
     some oopsing problems (often null pointer exceptions) that were
     rare quite some time ago, but became more common as the driver
     is (a) used much more, and (b) used on faster EHCI implementations,
     like the VIA VT8235 and other recent silicon.
  
   - Fixes the problems when used with cardbus.  Previously if you
     did a physical eject without first "rmmod ehci-hcd" (or even a
     system shutdown, which is a cardbus issue) the system would
     lock up.  No more.

 drivers/usb/hcd.c            |   94 +++---
 drivers/usb/hcd.h            |    1 
 drivers/usb/hcd/ehci-dbg.c   |  525 +++++++++++++++++++++++++++++++----
 drivers/usb/hcd/ehci-hcd.c   |  512 +++++++++++++++++++++++++---------
 drivers/usb/hcd/ehci-hub.c   |   16 -
 drivers/usb/hcd/ehci-q.c     |  575 +++++++++++++++++++++------------------
 drivers/usb/hcd/ehci-sched.c |  630 +++++++++++++++++--------------------------
 drivers/usb/hcd/ehci.h       |   87 +++++
 8 files changed, 1552 insertions(+), 888 deletions(-)
------

ChangeSet@1.746.1.2, 2002-10-21 14:37:44-07:00, greg@kroah.com
  [PATCH] USB: added support for Clie NX60 device.
  
  Thanks to Hiroyuki ARAKI <hiro@zob.ne.jp> for the information.

 drivers/usb/serial/visor.c |    2 ++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 3 insertions(+)
------

ChangeSet@1.746.1.1, 2002-10-21 13:37:47-07:00, greg@kroah.com
  Cset exclude: acme@conectiva.com.br|ChangeSet|20021011180213|25533

 drivers/usb/hid-input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

