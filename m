Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbULIXJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbULIXJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbULIXJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:09:40 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:36051 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261662AbULIXJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:09:27 -0500
Date: Thu, 9 Dec 2004 15:09:01 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.10-rc3
Message-ID: <20041209230900.GA6091@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes for 2.6.10-rc3.  There is also a PCI build time
fix, and a Documentation grammer fix in here too.  Some of the patches
are big, as they involve deleting a unworking driver and replacing it
with a working version.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h


 drivers/usb/host/hc_simple.c   | 1039 ----------------------
 drivers/usb/host/hc_simple.h   |  231 ----
 drivers/usb/host/hc_sl811.c    | 1357 -----------------------------
 drivers/usb/host/hc_sl811.h    |  385 --------
 drivers/usb/host/hc_sl811_rh.c |  583 ------------
 arch/i386/kernel/quirks.c      |    3 
 arch/x86_64/Kconfig            |    1 
 drivers/usb/core/inode.c       |    3 
 drivers/usb/host/Kconfig       |   16 
 drivers/usb/host/Makefile      |    3 
 drivers/usb/host/ehci-hub.c    |    2 
 drivers/usb/host/ehci-q.c      |  133 +-
 drivers/usb/host/ehci-sched.c  |    5 
 drivers/usb/host/hc_crisv10.c  |    2 
 drivers/usb/host/ohci-hub.c    |   18 
 drivers/usb/host/sl811-hcd.c   | 1909 ++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/host/sl811.h       |  270 +++++
 drivers/usb/host/uhci-debug.c  |   11 
 drivers/usb/host/uhci-hub.c    |   10 
 include/linux/usb_sl811.h      |   26 
 20 files changed, 2320 insertions(+), 3687 deletions(-)
-----

Adrian Bunk:
  o USB uhci-debug.c: remove an unused function (fwd)

Alan Stern:
  o USB UHCI: minor bugfix for port resume

David Brownell:
  o USB: sl811-hcd driver, replaces hc_sl811
  o USB: OHCI "resume"/smp fix
  o USB: EHCI qh update race fix

Greg Kroah-Hartman:
  o USB: fix another sparse warning in the USB core
  o USB: fix obvious build error in hc_chrisv10.c driver
  o USB: removed unused hc_sl811 driver from the tree
  o USB: fix sparse warning in ehci-hcd driver
  o USB: fix sparse warnings in sl811-hcd driver

Nishanth Aravamudan:
  o USB: add wake-up for waitqueues in usbfs_remove_file() to fix bug 387

Randy Dunlap:
  o PCI/x86-64: build with PCI=n

