Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTIYVvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbTIYVum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:50:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:26012 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261906AbTIYVuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:50:22 -0400
Date: Thu, 25 Sep 2003 14:33:34 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB fixes for 2.6.0-test5
Message-ID: <20030925213334.GA29937@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB fixes for 2.6.0-test5.  The USB configuration logic was
reworked a by David Brownell, now allowing Linux to support devices with
different configurations much easier than before.  This cleaned up the
usb device reference counting logic a bit as a nice side benifit.  We've
also removed the ax8817x driver, as it is now supported in the usbnet
driver, and there are a lot of other minor fixes and cleanups.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/net/ax8817x.c            | 1340 -----------------------------------
 drivers/usb/Makefile                 |    1 
 drivers/usb/Makefile.lib             |    1 
 drivers/usb/class/Kconfig            |   30 
 drivers/usb/class/usb-midi.c         |    2 
 drivers/usb/core/config.c            |    3 
 drivers/usb/core/driverfs.c          |   26 
 drivers/usb/core/hcd-pci.c           |   14 
 drivers/usb/core/message.c           |  126 ++-
 drivers/usb/core/usb.c               |   87 --
 drivers/usb/gadget/ether.c           |  241 ++++--
 drivers/usb/gadget/inode.c           |   34 
 drivers/usb/host/Kconfig             |   24 
 drivers/usb/host/uhci-hcd.c          |    2 
 drivers/usb/image/Kconfig            |   12 
 drivers/usb/image/scanner.c          |   39 -
 drivers/usb/image/scanner.h          |   19 
 drivers/usb/input/Kconfig            |   24 
 drivers/usb/misc/Kconfig             |   42 -
 drivers/usb/net/Kconfig              |   55 -
 drivers/usb/net/Makefile             |    1 
 drivers/usb/net/Makefile.mii         |    1 
 drivers/usb/serial/digi_acceleport.c |    2 
 drivers/usb/serial/ftdi_sio.c        |    8 
 drivers/usb/serial/ftdi_sio.h        |    7 
 drivers/usb/serial/usb-serial.c      |    4 
 drivers/usb/storage/transport.c      |    1 
 27 files changed, 474 insertions(+), 1672 deletions(-)
-----

<adobriyan:mail.ru>:
  o USB: Remove setting TASK_RUNNING after schedule_timeout in /drivers/usb/

Adrian Bunk:
  o USB: fix USB_MOUSE help text

Alan Stern:
  o USB: improve debugging logging during suspend and resume

Chris Wright:
  o USB: Memory Leaks on Error Paths of usb-midi

Daniele Bellucci:
  o USB: Minor cleanups in usb_serial_probe

David Brownell:
  o USB: usb_set_configuration() rework (v2)
  o USB: usb gadgetfs updates
  o USB: usb "ether" net gadget

David T. Hollis:
  o USB: Remove ax8817x driver

Greg Kroah-Hartman:
  o USB: i was wrong, clean up some extra refcounts that are no longer needed
  o USB: remove misleading FIXME comment added by previous patch

Henning Meier-Geinitz:
  o USB scanner driver: added USB_CLASS_CDC_DATA
  o USB scanner driver: new device ids
  o USB scanner driver: balancing usb_register_dev/usb_deregister_dev
  o USB scanner driver: report back return codes
  o USB scanner driver: use static declarations

Ian Abbott:
  o USB: ftdi_sio - new vid/pid for OCT US101 USB to RS-232 converter

Nicolas Kaiser:
  o USB: Remove modules.txt drivers_usb_class_Kconfig
  o USB: Remove modules.txt drivers_usb_misc_Kconfig
  o USB: Remove modules.txt drivers_usb_image_Kconfig
  o USB: Remove modules.txt drivers_usb_host_Kconfig
  o USB: Remove modules.txt drivers_usb_net_Kconfig

