Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTDGW2W (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTDGW2W (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:28:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32708 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263728AbTDGW2S (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 18:28:18 -0400
Date: Mon, 7 Apr 2003 15:34:26 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.67
Message-ID: <20030407223426.GA4646@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB changes.  Most notable here is a usbnet driver update
that should remove the need for the separate cdc-ether.c driver, a
DocBook documentation update for the usbfs interface, and a usb-storage
update that fixes some bugs noted in the bug database.  There are some
other good bugfixes in here too.

I've also included my patches in here that add hotplug support for the
kobject core, and convert the driver core to use this functionality.
These patches were posted to lkml in the past, and Pat has said they
look good to him.


Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5


Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h


 Documentation/DocBook/usb.tmpl     |  681 ++++++++++++++++++++++++++++++++
 arch/i386/kernel/edd.c             |    2 
 drivers/acpi/bus.c                 |    2 
 drivers/base/base.h                |    5 
 drivers/base/bus.c                 |    2 
 drivers/base/class.c               |    4 
 drivers/base/core.c                |   55 ++
 drivers/base/firmware.c            |    2 
 drivers/base/hotplug.c             |   32 -
 drivers/block/genhd.c              |   14 
 drivers/hotplug/pci_hotplug_core.c |    2 
 drivers/usb/class/usb-midi.c       |   31 -
 drivers/usb/core/hub.c             |   17 
 drivers/usb/core/message.c         |    2 
 drivers/usb/core/usb.c             |   34 -
 drivers/usb/host/ehci-mem.c        |    1 
 drivers/usb/host/ehci-q.c          |   13 
 drivers/usb/host/ohci-hcd.c        |    8 
 drivers/usb/host/ohci-q.c          |    2 
 drivers/usb/input/hid-core.c       |    3 
 drivers/usb/input/kbtab.c          |    2 
 drivers/usb/input/usbkbd.c         |    3 
 drivers/usb/input/usbmouse.c       |    3 
 drivers/usb/misc/speedtch.c        |   26 -
 drivers/usb/net/pegasus.c          |   18 
 drivers/usb/net/pegasus.h          |    2 
 drivers/usb/net/usbnet.c           |  765 +++++++++++++++++++++++++++----------
 drivers/usb/serial/io_edgeport.c   |    8 
 drivers/usb/serial/keyspan.h       |   26 -
 drivers/usb/serial/usb-serial.c    |    3 
 drivers/usb/storage/scsiglue.c     |   40 +
 drivers/usb/storage/transport.c    |   30 +
 drivers/usb/storage/transport.h    |    2 
 drivers/usb/storage/usb.c          |  339 ++++++++--------
 fs/filesystems.c                   |    2 
 fs/partitions/check.c              |    2 
 include/linux/kobject.h            |   22 +
 lib/kobject.c                      |  170 +++++++-
 net/core/dev.c                     |    2 
 39 files changed, 1824 insertions(+), 553 deletions(-)
-----

<alborchers@steinerpoint.com>:
  o USB: patch for oops in io_edgeport.c

Art Haas <ahaas@airmail.net>:
  o USB: C99 initializers for drivers/usb files

David Brownell <david-b@pacbell.net>:
  o USB: set_configuration() missed some state
  o USB: kerneldoc for usbfs
  o USB usbnet: dynamic config, cdc-ether, net1080
  o USB: ohci-hcd, pci posting paranoia
  o USB: ehci-hcd, minor hardware tweaks

Duncan Sands <baldrick@wanadoo.fr>:
  o USB speedtouch: handle failure of usb_set_interface

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: set port->tty to NULL after we have closed the port
  o Kobject: add NULL to decl_subsys() due to addition of hotplug operations
  o block: add /sbin/hotplug support for when block devices are created and destroyed
  o driver core: move the hotplug support for /sys/devices to use the kobject logic
  o Kobject: add NULL to decl_subsys() due to addition of hotplug operations
  o kobject: cause /sbin/hotplug to be called when kobjects are added and removed
  o USB: remove redundant checks for NULL when it can never happen

Hanna Linder <hannal@us.ibm.com>:
  o USB: input class hookup to existing support

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o usb-storage: add info to /proc interface
  o usb-storage: remove BUG/BUG_ON
  o usb-storage: variable renames
  o usb-storage: fix CB/CBI

Oliver Neukum <oliver@neukum.org>:
  o USB: removing unnecessary calls to usb_set_configuration
  o USB: locking reset/probe
  o USB: leave usage counts during probe/remove to driver core

Paul Mackerras <paulus@samba.org>:
  o USB: small fix to pegasus.c

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus link status fix

