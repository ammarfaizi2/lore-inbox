Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319165AbSILX0k>; Thu, 12 Sep 2002 19:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319167AbSILX0h>; Thu, 12 Sep 2002 19:26:37 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:6153 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319165AbSILX0e>;
	Thu, 12 Sep 2002 19:26:34 -0400
Date: Thu, 12 Sep 2002 16:27:53 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.20-pre6
Message-ID: <20020912232752.GA22390@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates for 2.4.20-pre6.

Pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email.

thanks,

greg k-h

 Documentation/Configure.help   |    8 ++++
 drivers/usb/devices.c          |    2 +
 drivers/usb/hc_sl811.c         |    1 
 drivers/usb/hcd.c              |   23 ++++++-------
 drivers/usb/hcd.h              |   66 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/hpusbscsi.c        |    6 +++
 drivers/usb/hub.c              |   57 +++++++++++++-------------------
 drivers/usb/scanner.c          |    6 +--
 drivers/usb/serial/belkin_sa.c |    1 
 drivers/usb/serial/belkin_sa.h |    1 
 drivers/usb/serial/usbserial.c |    6 +--
 drivers/usb/uhci.c             |    3 +
 drivers/usb/usb-ohci.c         |   20 ++---------
 drivers/usb/usb-uhci.c         |    3 +
 drivers/usb/usb.c              |   71 ++++++++++++++++++++++++-----------------
 include/linux/usb.h            |   69 +++++++++++++++++++++++++--------------
 16 files changed, 222 insertions(+), 121 deletions(-)
-----

ChangeSet@1.655, 2002-09-12 15:46:54-07:00, bunk@fs.tum.de
  [PATCH] add Configure.help entries for CONFIG_USB_SERIAL_KEYSPAN_USA19Q{W,I}
  
  the patch below adds Configure.help entries for
  CONFIG_USB_SERIAL_KEYSPAN_USA19QW and CONFIG_USB_SERIAL_KEYSPAN_USA19QI
  which were introduced in 2.4.20-pre.

 Documentation/Configure.help |    8 ++++++++
 1 files changed, 8 insertions(+)
------

ChangeSet@1.654, 2002-09-12 15:46:33-07:00, zwane@mwaikambo.name
  [PATCH] trivial ohci fixes
  
  This is just a trivial patch for the following, and also a
  buglet (clear_bit usb_register/derister race there?) fix
  
  usb-uhci.c: $Revision: 1.1.1.1 $ time 21:43:25 Sep  8 2002
  usb-uhci.c: High bandwidth mode enabled
  usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
  usb-ohci.c: USB OHCI at membase 0xd0012000, IRQ 11
  usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
  usb-ohci.c: USB HC TakeOver failed!
  usb.c: USB bus -1 deregistered <--

 drivers/usb/usb-ohci.c |    3 ++-
 drivers/usb/usb.c      |    3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.653, 2002-09-12 15:42:06-07:00, greg@kroah.com
  USB serial: added device path to the proc file now that usb_make_path() is available.

 drivers/usb/serial/usbserial.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.651, 2002-09-12 15:32:19-07:00, mlang@delysid.org
  [PATCH] HandyTech HandyLink patch
  
  HandyTech's Braille displays support a USB port, those are
  implemented with a GoHubs usb serial converter.  The only difference
  is that the pID is 0x1200, not 0x1000.

 drivers/usb/serial/belkin_sa.c |    1 +
 drivers/usb/serial/belkin_sa.h |    1 +
 2 files changed, 2 insertions(+)
------

ChangeSet@1.650, 2002-09-12 15:31:46-07:00, fzago@austin.rr.com
  [PATCH] [PATCH] (repost) fix for big endian machines in scanner.c
  
  This patch fixes a problem with big endian machines and scanner drivers which
  use the SCANNER_IOCTL_CTRLMSG ioctl. The big endian to little endian swap was
  done twice, resulting in a no-op.

 drivers/usb/scanner.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.649, 2002-09-12 15:25:24-07:00, oliver@neukum.name
  [PATCH] new ids for hpusbscsi
  

 drivers/usb/hpusbscsi.c |    6 ++++++
 1 files changed, 6 insertions(+)
------

