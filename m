Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUF2XiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUF2XiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 19:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUF2XiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 19:38:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:31711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266141AbUF2Xh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 19:37:56 -0400
Date: Tue, 29 Jun 2004 16:36:23 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB patches for 2.6.7
Message-ID: <20040629233623.GA22852@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB fixes against the latest 2.6.7-bk tree.  Almost
all of these patches have been in the past few -mm releases.

The one odd fs/aio.c change is to export a symbol needed by gadgetfs to
be a module.  The other fixes here are:
	- async io support for gadgetfs
	- usb gadget bugfixes
	- cdc-acm bugfixes
	- pwc driver update and fixes
	- ehci and uhci fixes
	- usb-serial bug fix.
	- a few new device ids added

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 Documentation/usb/philips.txt      |   87 ++--
 drivers/usb/class/cdc-acm.c        |  147 +++++--
 drivers/usb/class/cdc-acm.h        |   14 
 drivers/usb/core/hub.c             |   81 ++-
 drivers/usb/core/hub.h             |    2 
 drivers/usb/gadget/dummy_hcd.c     |   43 +-
 drivers/usb/gadget/ether.c         |   10 
 drivers/usb/gadget/file_storage.c  |    2 
 drivers/usb/gadget/inode.c         |  184 ++++++++
 drivers/usb/gadget/serial.c        |    2 
 drivers/usb/gadget/zero.c          |    2 
 drivers/usb/host/ehci-hcd.c        |   29 -
 drivers/usb/host/uhci-debug.c      |    2 
 drivers/usb/host/uhci-hcd.c        |   19 
 drivers/usb/host/uhci-hub.c        |    4 
 drivers/usb/input/hid-tmff.c       |    2 
 drivers/usb/media/Kconfig          |    2 
 drivers/usb/media/konicawc.c       |    2 
 drivers/usb/media/pwc-ctrl.c       |  775 +++++++++++++++++--------------------
 drivers/usb/media/pwc-if.c         |  225 ++++++----
 drivers/usb/media/pwc-ioctl.h      |   88 +++-
 drivers/usb/media/pwc-misc.c       |   50 +-
 drivers/usb/media/pwc-uncompress.c |   33 +
 drivers/usb/media/pwc-uncompress.h |   23 -
 drivers/usb/media/pwc.h            |   43 --
 drivers/usb/net/kaweth.c           |    4 
 drivers/usb/net/pegasus.c          |    4 
 drivers/usb/serial/generic.c       |   33 +
 drivers/usb/serial/pl2303.c        |   53 ++
 drivers/usb/serial/pl2303.h        |    6 
 drivers/usb/serial/usb-serial.c    |   28 -
 drivers/usb/storage/transport.c    |    6 
 drivers/usb/storage/unusual_devs.h |   12 
 fs/aio.c                           |    2 
 34 files changed, 1278 insertions(+), 741 deletions(-)
-----

<hverhagen:dse.nl>:
  o USB: shut-up kaweth usb/net driver

<slansky:usa.net>:
  o USB: PL2303 module, new IDs

<torsten.scherer:uni-bielefeld.de>:
  o USB Storage: unusual_devs.h addition

Alan Stern:
  o USB Storage: Unusual_devs.h update
  o USB: Add mb() during initialization of UHCI controller
  o USB: Imiprove usb_device tracking in dummy_hcd
  o USB: Fail pending URBs in dummy_hcd upon disconnect
  o USB: Add logical connect-change notices to the hub driver

Andrew Morton:
  o USB: pwc-uncompress.h

Craig Nadler:
  o USB: EHCI IRQ tweaks

David Brownell:
  o USB: gadgetfs AIO support
  o USB: usb gadget drivers should be stricter about ZLPs

Frank Neuber:
  o USB: usb ethernet gadget build fixes on PXA

Greg Kroah-Hartman:
  o USB: fix bug where removing usb-serial modules or usb serial devices could oops
  o USB: provide support for the HX version of pl2303 chips
  o USB: enable the pwc driver to be able to be built again

Herbert Xu:
  o USB: Fix pegasus_set_multicast lockup in drivers/usb/net/pegasus.c

Ludovic Aubry:
  o USB: Use 64-bit IO addresses in UHCI driver

Matthew Dharm:
  o USB: Patch to signal underflow in usb-storage driver

Nemosoft Unv.:
  o USB: PWC 9.0.1

Oliver Neukum:
  o USB: kaweth not handling ESHUTDOWN
  o USB: GFP_KERNEL in irq
  o USB: another error check in acm
  o USB:  patches to acm driver

Zinx Verituse:
  o USB: hid-tmff fix

