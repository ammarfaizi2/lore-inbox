Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbTAPSqO>; Thu, 16 Jan 2003 13:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbTAPSqO>; Thu, 16 Jan 2003 13:46:14 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25103 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267191AbTAPSqH>;
	Thu, 16 Jan 2003 13:46:07 -0500
Date: Thu, 16 Jan 2003 10:54:30 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.21-pre3
Message-ID: <20030116185430.GB32287@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates and bugfixes for 2.4.21-pre3.

Please pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 Documentation/Configure.help       |   44 +
 MAINTAINERS                        |    8 
 drivers/usb/Config.in              |    1 
 drivers/usb/Makefile               |    1 
 drivers/usb/hcd/ehci-dbg.c         |   30 -
 drivers/usb/konicawc.c             |  938 +++++++++++++++++++++++++++++++++++++
 drivers/usb/scanner.c              |  120 +---
 drivers/usb/scanner.h              |   29 -
 drivers/usb/serial/ipaq.c          |    2 
 drivers/usb/serial/ipaq.h          |    4 
 drivers/usb/serial/usbserial.c     |    6 
 drivers/usb/storage/unusual_devs.h |   22 
 drivers/usb/usb-skeleton.c         |    2 
 drivers/usb/usbnet.c               |   22 
 include/linux/usb_scanner_ioctl.h  |    9 
 15 files changed, 1093 insertions(+), 145 deletions(-)
-----

ChangeSet@1.1025, 2003-01-16 10:51:04-08:00, ganesh@tuxtop.vxindia.veritas.com
  [PATCH] Added ids for the Dell Axim and Toshiba E740. Thanks to Ian Molton

 drivers/usb/serial/ipaq.c |    2 ++
 drivers/usb/serial/ipaq.h |    4 ++++
 2 files changed, 6 insertions(+)
------

ChangeSet@1.1024, 2003-01-16 10:44:04-08:00, greg@kroah.com
  USB: Move the scanner ioctls to usb_scanner_ioctl.h to allow access by archs that need it.
  
  Specifically arches that need to thunk between a 32 bit userspace
  and a 64 bit kernel.
  
  Thanks to Dave Miller for proding me to make this change.

 drivers/usb/scanner.h             |    7 +------
 include/linux/usb_scanner_ioctl.h |    9 +++++++++
 2 files changed, 10 insertions(+), 6 deletions(-)
------

ChangeSet@1.1023, 2003-01-15 13:32:10-08:00, greg@kroah.com
  Merge kroah.com:/home/linux/linux/BK/bleeding-2.4
  into kroah.com:/home/linux/linux/BK/gregkh-2.4

 Documentation/Configure.help |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)
------

ChangeSet@1.971.1.12, 2003-01-15 12:51:56-08:00, henning@meier-geinitz.de
  [PATCH] Add maintainer for USB scanner driver

 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+)
------

ChangeSet@1.971.1.11, 2003-01-15 12:51:27-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: endpoint detection cleanup
  
  This patch makes endpoint detection more generic. Basically, only one
  bulk-in endpoint is required, everything else is optional.
  
  The patch is on top of the PV8630 removal patch.

 drivers/usb/scanner.c |   55 +++++++++++++++++++-------------------------------
 1 files changed, 21 insertions(+), 34 deletions(-)
------

ChangeSet@1.971.1.10, 2003-01-15 12:50:12-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c, scanner.h: Remove PV8630 ioctls
  
  This patch removes the inofficial ioctls that were used to support the
  PV8630 USB-over-Parport chipset. They were already ifdefed out.
  Instead of them, the more generic (and official) SCANNER_IOCTL_CTRLMSG
  should be used. The last software that used the old ioctl
  (sane-hp4200) switched to the new ioctls a long time ago.
  
  This patch is ontop of the "user-supplied" patch.

 drivers/usb/scanner.c |   52 +-------------------------------------------------
 drivers/usb/scanner.h |   15 --------------
 2 files changed, 3 insertions(+), 64 deletions(-)
------

ChangeSet@1.971.1.9, 2003-01-15 12:49:35-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: print user-supplied ids only on start-up
  
  With this patch, information about user-supplied ids is printed only
  once at startup instead of everytime any USB device is plugged in.
  
  The patch is on top of the new ids patch.

 drivers/usb/scanner.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.971.1.8, 2003-01-15 12:48:51-08:00, henning@meier-geinitz.de
  [PATCH] : scanner.h, scanner.c: New vendor/product ids for visioneer scanners
  
  This patch adds vendor/product ids for two Visioneer scanners.

 drivers/usb/scanner.c |    3 +++
 drivers/usb/scanner.h |    4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)
------

ChangeSet@1.971.1.7, 2003-01-12 23:17:07-08:00, spse@secret.org.uk
  [PATCH] USB: Backport konicawc driver to 2.4
  
  This patch adds support for webcams based on a konica chipset
  (eg Intel YC76). It is a backport from 2.5

 Documentation/Configure.help |   15 
 drivers/usb/Config.in        |    1 
 drivers/usb/Makefile         |    1 
 drivers/usb/konicawc.c       |  938 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 955 insertions(+)
------

ChangeSet@1.971.1.6, 2003-01-12 00:01:28-08:00, greg@kroah.com
  [PATCH] USB bluetooth: fix incorrect url in help text.

 Documentation/Configure.help |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)
------

ChangeSet@1.971.1.5, 2003-01-11 23:45:51-08:00, randy.dunlap@verizon.net
  [PATCH] usb-skeleton MINOR_BASE change
  
  USB_SKEL_MINOR_BASE should be a multiple of 16 to work
  correctly with the way that minors are assigned (in blocks
  of 16) in Linux 2.4.x.

 drivers/usb/usb-skeleton.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.954.1.5, 2003-01-09 01:02:07-08:00, greg@kroah.com
  [PATCH] USB: fix ehci build problem for older versions of gcc

 drivers/usb/hcd/ehci-dbg.c |   30 ++++++++----------------------
 1 files changed, 8 insertions(+), 22 deletions(-)
------

ChangeSet@1.971.1.3, 2003-01-08 16:45:23-08:00, alan@lxorguk.ukuu.org.uk
  [PATCH] PATCH: more unusual USB storage devices
  
  IBM memory key
  Epson 785EPX PCMCIA slot
  Konica KD-200Z camera

 drivers/usb/storage/unusual_devs.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)
------

ChangeSet@1.971.1.2, 2003-01-08 16:45:11-08:00, henning@meier-geinitz.de
  [PATCH] USB scanner driver: updated Configure.help
  
  This patch removes the link in Configure.help to
  Documentation/usb/scanner-hp-sane.txt which was removed by the
  documentation update.

 Documentation/Configure.help |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.954.1.4, 2003-01-08 10:13:02-08:00, neilt@slimy.greenend.org.uk
  [PATCH] USB Serial patch.
  
  I got a PL2303 USB serial converter a few days ago, and got your driver
  up and running fairly quickly.  The problem is that I got an oops when I
  rmmod-ed the drivers.  The pl2303 uses two interfaces but registers only
  the second (technically wrong, I guess, but should work).  When pl2303.o
  is removed, it attempts to deregister the first interface (which has no
  effect), so the second interface remains registered with usbserial.  The
  old struct serial still points at the removed pl2303 driver so things go
  pop when anything touches it.
  
  I think the PL2303 hack in usb_serial_probe should not change the
  "interface" variable, which gets stored in serial->interface, since
  usbcore will register whatever "ifnum" says.  I think that's enough
  waffle.  The patch is below.  Keep up the good work!

 drivers/usb/serial/usbserial.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.954.1.3, 2003-01-08 08:36:06-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: remove "magic" number for interface
  
  On Tue, Dec 24, 2002 at 12:40:06AM +0100, Oliver Neukum wrote:
  >
  > > Well, the reason I didn't use one was that I didn't found one in
  > > usb.h/usb_ch9.h for 16. It's also not listed on www.usb.org.
  > >
  > > lsusb calls it "Data". However, I'm not sure if this is a hex/dec
  > > error and they really mean "Data" = dec 10, not 0x10 (=dec 16).
  > >
  > > Shall I define a local symbolic name (e.g.
  > > STRANGE_HP_SCANJET_INTERFACE_CLASS)? But I really don't know what this
  > > class is. I only know that it's used by a Hewlett-Packard ScanJet
  > > 3300c and Genius HR6 USB - Vivid III.
  >
  > Better that than a bare number.
  
  Patch attached.

 drivers/usb/scanner.c |    2 +-
 drivers/usb/scanner.h |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)
------

ChangeSet@1.954.1.2, 2003-01-06 15:48:16-08:00, david-b@pacbell.net
  [PATCH] zaurus B500 (sl-5600?) & usbnet
  
  More Zaurii.  That model will be interesting from the
  perspective of "usb gadget drivers", lots of flexible
  endpoints are available.

 drivers/usb/usbnet.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)
------

