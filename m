Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTIYXK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTIYXK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:10:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:29616 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261835AbTIYXKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:10:51 -0400
Date: Thu, 25 Sep 2003 16:02:17 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.4.23-pre5
Message-ID: <20030925230217.GA30692@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes and changes against 2.4.23-pre5.  The big
thing here is the addition of the usb gadget code.  It is self contained
(so if you don't enable it, it doesn't affect anything), and has been in
the 2.6 tree for a while now.  I've also fixed the locking issues I
caused with the last round of copy_from_user audits, and there are a
number of other small bug fixes in here.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h


 CREDITS                            |    2 
 Documentation/Configure.help       |    4 
 MAINTAINERS                        |    2 
 Makefile                           |    1 
 drivers/Makefile                   |    3 
 drivers/usb/Config.in              |    3 
 drivers/usb/devio.c                |    2 
 drivers/usb/gadget/Config.in       |   69 
 drivers/usb/gadget/Makefile        |   31 
 drivers/usb/gadget/ether.c         | 1879 +++++++++++++++++++++++++
 drivers/usb/gadget/net2280.c       | 2731 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/net2280.h       |  755 ++++++++++
 drivers/usb/gadget/usbstring.c     |   71 
 drivers/usb/gadget/zero.c          | 1261 +++++++++++++++++
 drivers/usb/mdc800.c               |    4 
 drivers/usb/serial/ftdi_sio.c      |    8 
 drivers/usb/serial/ftdi_sio.h      |    7 
 drivers/usb/serial/ipaq.c          |    2 
 drivers/usb/serial/pl2303.c        |    1 
 drivers/usb/serial/pl2303.h        |    3 
 drivers/usb/speedtch.c             |   12 
 drivers/usb/storage/protocol.c     |    4 
 drivers/usb/storage/unusual_devs.h |    8 
 drivers/usb/usbnet.c               |  462 +++++-
 drivers/usb/vicam.c                |    4 
 include/linux/usb_ch9.h            |  315 ++++
 include/linux/usb_gadget.h         |  719 +++++++++
 27 files changed, 8281 insertions(+), 82 deletions(-)
-----

<amn3s1a:ono.com>:
  o USB: New unusual_devs.h entry (Minolta DiMAGE E223 Digital Camera)

Adrian Bunk:
  o USB: fix USB_MOUSE help text

Alan Stern:
  o USB: Pad UFI commands to 12 bytes with zeros

David Brownell:
  o USB: usb gadget support for 2.4 (5/5): kbuild/kconf
  o USB: usb gadget support for 2.4 (4/5): ether
  o USB: usb gadget support for 2.4 (3/5): zero
  o USB: usb gadget support for 2.4 (2/5): net2280
  o USB: usb gadget support for 2.4 (1/5):  api

David T. Hollis:
  o USB: ax8817x support for usbnet and ethtool_ops support

Duncan Sands:
  o USB speedtouch: bump the version number
  o USB: New email address
  o USB speedtouch: neater sanity check

Greg Kroah-Hartman:
  o USB: fix up two locking issues in mdc800 and vicam drivers
  o USB: port ipaq fix to 2.4
  o USB: add a new pl2303 device id
  o USB: unusual device fixup for the Y-E floppy drive

Ian Abbott:
  o USB: ftdi_sio - new vid/pid for OCT US101 USB to RS-232 converter

Oleg Drokin:
  o USB: devio.c memleak on unexpected disconnect

