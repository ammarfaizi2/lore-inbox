Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTITAkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 20:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTITAkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 20:40:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:60828 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261796AbTITAko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 20:40:44 -0400
Date: Fri, 19 Sep 2003 17:37:36 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.0-test5
Message-ID: <20030920003736.GA8734@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes for 2.6.0-test5.  The USB config logic was
reworked a lot by Alan Stern to handle errors and odd devices much
better, ending up with a smaller code path, and less memory allocated
for every USB device.  There are also a number of other small fixups in
here, fixes for oopses when trying to suspend, docbook fixes, debug
build fixes, and an oops fix in the ipaq driver.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 CREDITS                                       |    4 
 Documentation/DocBook/gadget.tmpl             |   27 
 Documentation/DocBook/writing_usb_driver.tmpl |    3 
 MAINTAINERS                                   |    4 
 drivers/usb/Kconfig                           |   12 
 drivers/usb/class/usblp.c                     |    5 
 drivers/usb/core/config.c                     |  772 ++++++++++++--------------
 drivers/usb/core/hub.c                        |    3 
 drivers/usb/core/usb.c                        |   10 
 drivers/usb/gadget/Kconfig                    |   34 -
 drivers/usb/gadget/inode.c                    |    1 
 drivers/usb/input/Kconfig                     |   48 -
 drivers/usb/media/Kconfig                     |   61 --
 drivers/usb/media/dabusb.c                    |    5 
 drivers/usb/media/usbvideo.c                  |    1 
 drivers/usb/media/vicam.c                     |    2 
 drivers/usb/misc/speedtch.c                   |   33 -
 drivers/usb/misc/usbtest.c                    |    2 
 drivers/usb/net/usbnet.c                      |  277 ++++++---
 drivers/usb/serial/Kconfig                    |  121 +---
 drivers/usb/serial/ipaq.c                     |    2 
 drivers/usb/serial/usb-serial.c               |    4 
 drivers/usb/storage/Kconfig                   |    6 
 drivers/usb/storage/unusual_devs.h            |    2 
 include/linux/usb.h                           |    2 
 include/linux/usb_gadget.h                    |   30 -
 26 files changed, 752 insertions(+), 719 deletions(-)
-----

<baldrick:free.fr>:
  o USB speedtouch: bump the version number
  o USB speedtouch: neater sanity check
  o USB: New email address for duncan
  o USB speedtouch: use multiple urbs by default

<dan:reactivated.net>:
  o USB: Debug code fixes for dabusb
  o USB: Debug code fixes for usblp
  o USB: Debug code fixes for vicam

<nikai:nikai.net>:
  o USB: Remove modules.txt: usb serial & storage
  o USB: Remove modules.txt: usb_media, usb_input

Alan Stern:
  o USB: Changes to core/config.c (9 of 9)
  o USB: Changes to core/config.c (8 of 9)
  o USB: Changes to core/config.c (7 of 9)
  o USB: Changes to core/config.c (6 of 9)
  o USB: Changes to core/config.c (5 of 9)
  o USB: Changes to core/config.c (4 of 9)
  o USB: Changes to core/config.c (3 of 9)
  o USB: Changes to core/config.c (2 of 9)
  o USB: Changes to core/config.c (1 of 9)
  o USB: Use num_altsetting in usbnet and usbtest

Daniel A. Nobuto:
  o USB: make pdfdocs problem

David Brownell:
  o USB: psdocs fails for usbgadget
  o USB: usb/gadget/Kconfig, use right PXA2xx symbols

David T. Hollis:
  o USB: ethtool_ops and ax8817x fixes for usbnet

Greg Kroah-Hartman:
  o USB: unusual device fixup for the Y-E floppy drive
  o USB: make sure we never reference a usbserial port after it has been unregistered
  o USB: fix up missing </para> in usb documentation
  o USB: fix oops in ipaq driver
  o USB: fix oops when trying to suspend and resume

Pete Zaitcev:
  o USB: Drop debounce printout for 2.6

Randy Hron:
  o [PATCH] drivers/usb version/include cleanup

