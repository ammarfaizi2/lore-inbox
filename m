Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267165AbSLaGmX>; Tue, 31 Dec 2002 01:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267167AbSLaGmX>; Tue, 31 Dec 2002 01:42:23 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45072 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267165AbSLaGmW>;
	Tue, 31 Dec 2002 01:42:22 -0500
Date: Mon, 30 Dec 2002 22:45:45 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.53
Message-ID: <20021231064545.GA2326@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This includes a compile time fix for the speedtouch driver that was
caused by the recent module changes.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/usb/ehci.txt    |   38 +++++++++++++++++++++---
 drivers/usb/core/hcd.c        |   38 ++++++++++++++----------
 drivers/usb/core/hcd.h        |    1 
 drivers/usb/core/hub.c        |   47 ++++++++++++++++--------------
 drivers/usb/core/usb.c        |   26 ++++++++---------
 drivers/usb/host/ohci-dbg.c   |   64 +++++++++++++++++++-----------------------
 drivers/usb/host/ohci-hcd.c   |   29 +++++++------------
 drivers/usb/host/ohci-hub.c   |    7 ++--
 drivers/usb/host/ohci-q.c     |    7 ++--
 drivers/usb/misc/speedtouch.c |   18 ++---------
 10 files changed, 147 insertions(+), 128 deletions(-)
-----

ChangeSet@1.972, 2002-12-30 22:46:52-08:00, greg@kroah.com
  USB: convert more dbg() calls to dev_dbg for the usb core

 drivers/usb/core/hcd.c |   26 +++++++++++++-------------
 drivers/usb/core/hub.c |   47 +++++++++++++++++++++++++----------------------
 drivers/usb/core/usb.c |   26 +++++++++++++-------------
 3 files changed, 51 insertions(+), 48 deletions(-)
------

ChangeSet@1.971, 2002-12-30 22:44:47-08:00, greg@kroah.com
  USB: convert more dbg() calls to dev_dbg for the ohci driver

 drivers/usb/host/ohci-dbg.c |   64 ++++++++++++++++++++------------------------
 drivers/usb/host/ohci-hcd.c |   29 ++++++++-----------
 drivers/usb/host/ohci-hub.c |    7 ++--
 drivers/usb/host/ohci-q.c   |    7 ++--
 4 files changed, 50 insertions(+), 57 deletions(-)
------

ChangeSet@1.970, 2002-12-30 17:16:48-08:00, david-b@pacbell.net
  [PATCH] ehci.txt (doc update)
  
  Makes this generic info reflect current behavior.

 Documentation/usb/ehci.txt |   38 ++++++++++++++++++++++++++++++++------
 1 files changed, 32 insertions(+), 6 deletions(-)
------

ChangeSet@1.969, 2002-12-30 17:16:25-08:00, david-b@pacbell.net
  [PATCH] cleanup after dead hc needs task context
  
  Simple patch to invoke hcd->stop() in task context, as
  required.  When Cardbus works again (broken in 2.5.53
  unless it's just me), this will get rid of some oopsing
  when folk physically eject the device, with no shutdown.
  As well as making other "hc died" faults behave better.

 drivers/usb/core/hcd.c |   12 +++++++++---
 drivers/usb/core/hcd.h |    1 +
 2 files changed, 10 insertions(+), 3 deletions(-)
------

ChangeSet@1.968, 2002-12-30 17:15:20-08:00, greg@kroah.com
  USB: fix up init_module and cleanup_module mess in speedtouch driver

 drivers/usb/misc/speedtouch.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)
------

