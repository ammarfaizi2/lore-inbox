Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbUKLXPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbUKLXPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbUKLXNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:13:30 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:34466 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262663AbUKLXHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:07:50 -0500
Date: Fri, 12 Nov 2004 15:07:34 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] Yet More USB patches for 2.6.10-rc1
Message-ID: <20041112230733.GA11920@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a some more USB fixes and cleanups for 2.6.10-rc1.
	- driver updates
	- suspend bug fixes and updates
	- locking bugs found by sparse fixed
	- endian warnings found by sparse fixed.
	- misc other bugfixes.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

USB bug fixes only from me from now on till 2.6.10 is out (hint to the
usb developers...)

thanks,

greg k-h


 Documentation/usb/sn9c102.txt          |  118 +++-
 drivers/usb/core/hcd-pci.c             |  151 +++---
 drivers/usb/core/hcd.c                 |   42 -
 drivers/usb/core/hub.c                 |   26 -
 drivers/usb/core/usb.c                 |    8 
 drivers/usb/gadget/file_storage.c      |    4 
 drivers/usb/gadget/rndis.c             |    4 
 drivers/usb/host/ehci-hcd.c            |   39 -
 drivers/usb/host/ehci-hub.c            |   78 +--
 drivers/usb/host/ehci-sched.c          |    1 
 drivers/usb/host/ohci-hcd.c            |   12 
 drivers/usb/host/ohci-hub.c            |   56 +-
 drivers/usb/host/ohci-pci.c            |    5 
 drivers/usb/host/ohci.h                |   12 
 drivers/usb/media/sn9c102.h            |   14 
 drivers/usb/media/sn9c102_core.c       |  324 +++++++++----
 drivers/usb/media/sn9c102_pas106b.c    |  113 +++-
 drivers/usb/media/sn9c102_pas202bcb.c  |   95 +++
 drivers/usb/media/sn9c102_sensor.h     |   25 -
 drivers/usb/media/sn9c102_tas5110c1b.c |    4 
 drivers/usb/media/sn9c102_tas5130d1b.c |    8 
 drivers/usb/misc/rio500.c              |   14 
 drivers/usb/misc/tiglusb.c             |    4 
 drivers/usb/misc/usbtest.c             |    6 
 drivers/usb/net/Kconfig                |   25 -
 drivers/usb/serial/io_edgeport.c       |  254 ++++++----
 drivers/usb/serial/io_fw_boot.h        |    6 
 drivers/usb/serial/io_fw_boot2.h       |    6 
 drivers/usb/serial/io_fw_down.h        |    6 
 drivers/usb/serial/io_fw_down2.h       |    6 
 drivers/usb/serial/io_tables.h         |    9 
 drivers/usb/serial/io_ti.c             |  812 +++++++++++++++++++++++++--------
 drivers/usb/serial/io_usbvend.h        |    2 
 drivers/usb/serial/kl5kusb105.c        |    2 
 drivers/usb/serial/mct_u232.c          |    2 
 drivers/usb/serial/usb-serial.c        |   65 +-
 drivers/usb/serial/whiteheat.c         |    2 
 drivers/usb/storage/freecom.c          |    2 
 drivers/usb/storage/unusual_devs.h     |   15 
 include/linux/videodev2.h              |    1 
 40 files changed, 1615 insertions(+), 763 deletions(-)
-----

<lmendez19:austin.rr.com>:
  o usb-serial: free interrupt_out_buffer in cleanup routines

Adrian Bunk:
  o USB: misc USB gadget cleanups

Al Borchers:
  o USB: io_ti new devices, circular buffer, flow control, misc fixes
  o USB: revised usbserial open/close unbalanced get/put
  o USB: io_edgeport locking, flow control, and misc fixes

Bjoern Paetzel:
  o USB Storage: unusual_devs entry for yakumo

David Brownell:
  o USB: usb PM updates, EHCI (4/4)
  o USB: usb PM updates, OHCI (3/4)
  o USB: usb PM updates, root hub stuff (2/4)
  o USB: usb PM updates, PCI glue (1/4)
  o USB: usb network Kconfig updates

Greg Kroah-Hartman:
  o USB: fix up a bunch of sparse bitwise warnings in the ohci driver
  o USB: fix sparse warnings in io_ti.c
  o USB: fix endian issues found by sparse in mct_u232 driver
  o USB: fix up endian issues found by sparse in io_edgeport.c driver
  o USB: fix endian bug found by sparse in freecom usb-storage driver
  o USB: fix sparse warnings in tiglusb.c driver
  o USB: fix endian warnings as found by sparse in the rio500.c driver
  o USB: fix 2 locking bugs in usbtest.c as found by sparse
  o USB: fix locking bug found by sparse in ehci-sched.c
  o Cset exclude: david-b@pacbell.net|ChangeSet|20041112030233|28853
  o USB: fix up locking bugs in kl5kusb105.c that sparse found
  o USB: fix up sparse lock warning in whiteheat driver

Luca Risolia:
  o USB: SN9C10x driver updates

Nickolai Zeldovich:
  o USB: EHCI and APM suspend

Phil Dibowitz:
  o USB Storage: Add unusual_devs entry for iPod


