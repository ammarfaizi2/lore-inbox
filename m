Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTEGSPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbTEGSPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:15:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:9383 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264173AbTEGSPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:15:14 -0400
Date: Wed, 7 May 2003 11:28:12 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.69
Message-ID: <20030507182812.GA2516@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB changes and fixes for 2.5.69.  The majority of these
changes are cleanups to the usb_register_dev() and usb_deregister_dev()
functions, moving all of the minor handling and other misc things usb
drivers had to do to use the usb major number into the usb core.  This
removed a number of static arrays in some of the different USB drivers.
I've also gotten rid of the kdev_t that the usb core was using for this,
as it's not really needed at all.  It also adds a usb class for those
drivers using the usb major in sysfs.

There are some other bugfixes, and some added usb-storage device fixups
in these patches too.


Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5


Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/class/usblp.c          |   41 ++++--------
 drivers/usb/core/file.c            |  123 +++++++++++++++++++++++++------------
 drivers/usb/core/usb.c             |   12 ++-
 drivers/usb/host/ehci-hcd.c        |   24 ++++---
 drivers/usb/host/ehci-q.c          |   35 +++-------
 drivers/usb/host/ehci.h            |   51 ++++++++++++++-
 drivers/usb/image/mdc800.c         |   17 +++--
 drivers/usb/image/scanner.c        |   54 ++++++----------
 drivers/usb/image/scanner.h        |    6 -
 drivers/usb/input/hiddev.c         |   37 +++++------
 drivers/usb/input/xpad.c           |    1 
 drivers/usb/media/dabusb.c         |   17 +++--
 drivers/usb/media/dabusb.h         |    4 -
 drivers/usb/media/vicam.c          |   30 ---------
 drivers/usb/misc/auerswald.c       |   71 ++++++---------------
 drivers/usb/misc/brlvger.c         |   65 ++++++-------------
 drivers/usb/misc/rio500.c          |   28 +++-----
 drivers/usb/misc/speedtch.c        |    1 
 drivers/usb/misc/usblcd.c          |   16 +++-
 drivers/usb/net/rtl8150.c          |   17 ++---
 drivers/usb/serial/console.c       |    2 
 drivers/usb/serial/usb-serial.h    |    2 
 drivers/usb/storage/unusual_devs.h |   50 ++++++++++++---
 drivers/usb/usb-skeleton.c         |   66 ++++++-------------
 include/linux/brlvger.h            |    8 --
 include/linux/usb.h                |   44 +++++++++++--
 27 files changed, 428 insertions(+), 394 deletions(-)
-----

<nicolas:dupeux.net>:
  o USB: UNUSUAL_DEV for aiptek pocketcam

<per.winkvist:telia.com>:
  o USB: more unusual_devs.h changes

<philipp:void.at>:
  o USB: unusual_devs.h patch

Adrian Bunk:
  o USB: kill the last occurances of usb_serial_get_by_minor

David Brownell:
  o USB: ehci i/o watchdog

David S. Miller:
  o USB speedtouch fix

Geert Uytterhoeven:
  o USB: Big endian RTL8150

Greg Kroah-Hartman:
  o USB: converted hiddev over to new usb_register_dev() changes
  o USB: remove #include <linux/devfs_fs_kernel.h> from some drivers that do not need it
  o USB: converted usb-skeleton over to new usb_register_dev() changes
  o USB: converted usblcd over to new usb_register_dev() changes
  o USB: converted rio500 over to new usb_register_dev() changes
  o USB: converted brlvger over to new usb_register_dev() changes
  o USB: converted auerswald over to new usb_register_dev() changes
  o USB: converted dabusb over to new usb_register_dev() changes
  o USB: converted scanner over to new usb_register_dev() changes
  o USB: converted mdc800 over to new usb_register_dev() changes
  o USB: converted usblp over to new usb_register_dev() changes
  o USB: add usb class support for usb drivers that use the USB major
  o USB: vicam: fix bugs in writing to proc files that were found by the CHECKER project
  o Cset exclude: linux-usb@gemeinhardt.info|ChangeSet|20030429230539|30870
  o USB: replace kdev_t with int in usb_interface structure, as only drivers with the USB major use it

