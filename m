Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbSI0Tds>; Fri, 27 Sep 2002 15:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262574AbSI0Tds>; Fri, 27 Sep 2002 15:33:48 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:64781 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262569AbSI0Tdo>;
	Fri, 27 Sep 2002 15:33:44 -0400
Date: Fri, 27 Sep 2002 12:37:24 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927193723.GA12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series includes some USB changes, and my changes to the driver core
to move /sbin/hotplug notification there, and out of the USB and PCI
cores.  This patch has been previously posted and discussed.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/base/Makefile              |    2 
 drivers/base/base.h                |   10 ++
 drivers/base/core.c                |    6 +
 drivers/base/hotplug.c             |  103 +++++++++++++++++++++++
 drivers/net/irda/irda-usb.c        |   65 ++++++++------
 drivers/pci/hotplug.c              |   96 ++++++++++++---------
 drivers/pci/pci-driver.c           |    6 -
 drivers/pci/pci.h                  |    5 +
 drivers/usb/core/usb.c             |  163 ++++++++++++++++++-------------------
 drivers/usb/storage/sddr55.c       |    2 
 drivers/usb/storage/transport.c    |    8 +
 drivers/usb/storage/unusual_devs.h |   15 ++-
 drivers/usb/usb-skeleton.c         |   37 ++++----
 include/linux/device.h             |    2 
 include/net/irda/irda-usb.h        |    2 
 15 files changed, 343 insertions(+), 179 deletions(-)
-----

ChangeSet@1.611.1.10, 2002-09-27 11:32:53-07:00, greg@kroah.com
  converted PCI to use the driver core's hotplug call.

 drivers/pci/hotplug.c    |   96 ++++++++++++++++++++++++++---------------------
 drivers/pci/pci-driver.c |    6 +-
 drivers/pci/pci.h        |    5 ++
 3 files changed, 63 insertions(+), 44 deletions(-)
------

ChangeSet@1.611.1.9, 2002-09-27 11:29:36-07:00, greg@kroah.com
  converted USB to use the driver core's hotplug call.

 drivers/usb/core/usb.c |  163 ++++++++++++++++++++++++-------------------------
 1 files changed, 81 insertions(+), 82 deletions(-)
------

ChangeSet@1.611.1.8, 2002-09-27 11:21:46-07:00, greg@kroah.com
  add hotplug support to the driver core for devices, if their bus type supports it.

 drivers/base/Makefile  |    2 
 drivers/base/base.h    |   10 ++++
 drivers/base/core.c    |    6 ++
 drivers/base/hotplug.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |    2 
 5 files changed, 123 insertions(+)
------

ChangeSet@1.611.1.7, 2002-09-26 23:07:16-07:00, yuri@acronis.com
  [PATCH] USB storage: Another (!) patch for the abort handler
  
  This is a simple, obvious patch for the abort handler.  I don't know how
  we missed it before.
  
  Fix abort problem: us->srb was used after it was erased.

 drivers/usb/storage/transport.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)
------

ChangeSet@1.611.1.6, 2002-09-26 23:03:01-07:00, rgcrettol@datacomm.ch
  [PATCH] USB 2.0 HDD Walker / ST-HW-818SLIM usb-storage fix
  

 drivers/usb/storage/unusual_devs.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.611.1.5, 2002-09-26 23:01:59-07:00, tim@physik3.uni-rostock.de
  [PATCH] fix compares of jiffies
  
  on rechecking the current stable kernel code, I found some places where jiffies
  were compared in a way that seems to break when they wrap. For these,
  I made up patches to use the macros "time_before()" or "time_after()"
  that are supposed to handle wraparound correctly.

 drivers/usb/storage/sddr55.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.611.1.4, 2002-09-26 23:01:20-07:00, brihall@pcisys.net
  [PATCH] Update for JMTek USBDrive
  
  Attached is a patch against the 2.4.19 linux kernel. It adds an entry
  for another version of the JMTek USBDrive (driverless), and also updates
  my email address.

 drivers/usb/storage/unusual_devs.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)
------

ChangeSet@1.611.1.3, 2002-09-26 17:17:41-07:00, greg@kroah.com
  USB: fix ifnum usage that was missed in the previous irda-usb patch

 drivers/net/irda/irda-usb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.611.1.2, 2002-09-26 16:11:18-07:00, greg@kroah.com
  USB: convert the usb-skeleton.c driver to work with the latest USB core changes.

 drivers/usb/usb-skeleton.c |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)
------

ChangeSet@1.611.1.1, 2002-09-26 15:35:06-07:00, jt@bougret.hpl.hp.com
  USB: convert the irda-usb driver to work properly with the new USB core changes.

 drivers/net/irda/irda-usb.c |   63 ++++++++++++++++++++++++--------------------
 include/net/irda/irda-usb.h |    2 -
 2 files changed, 36 insertions(+), 29 deletions(-)
------

