Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTF0Xjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTF0Xjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:39:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:3523 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264955AbTF0Xjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:39:39 -0400
Date: Fri, 27 Jun 2003 16:44:15 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.4.22-pre2
Message-ID: <20030627234415.GA11813@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes and updates against 2.4.21.  There biggest
thing here is a speedtouch driver cleanup to use the kernel's crc32
code, and a ftdi_sio update.  I've also included the one-shot interrupt
patches that are shipping in the latest Red Hat kernel, and have had
many people wanting for a while now.

I've also removed the floating point code that was present in the last
USB patches that went into 2.4.22-pre1.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 drivers/usb/speedcrc.c             |  124 ---
 drivers/usb/speedcrc.h             |   28 
 drivers/usb/speedtouch.c           | 1344 -------------------------------------
 drivers/usb/Makefile               |    4 
 drivers/usb/Makefile.lib           |    1 
 drivers/usb/aiptek.c               |   11 
 drivers/usb/host/uhci-debug.h      |    2 
 drivers/usb/host/usb-ohci.c        |   19 
 drivers/usb/host/usb-uhci.c        |    9 
 drivers/usb/powermate.c            |   22 
 drivers/usb/serial/ftdi_sio.c      |  604 +++++++++++++---
 drivers/usb/serial/ftdi_sio.h      |   69 +
 drivers/usb/serial/io_edgeport.c   |    3 
 drivers/usb/serial/pl2303.c        |    5 
 drivers/usb/speedtch.c             | 1344 +++++++++++++++++++++++++++++++++++++
 drivers/usb/storage/initializers.c |   48 +
 drivers/usb/storage/initializers.h |    6 
 drivers/usb/storage/unusual_devs.h |   20 
 drivers/usb/usbnet.c               |   19 
 drivers/usb/vicam.c                |   52 +
 20 files changed, 2077 insertions(+), 1657 deletions(-)
-----

<abbotti:mev.co.uk>:
  o USB: several ftdi_sio driver patches

<david:csse.uwa.edu.au>:
  o USB: usb-ohci handling of one-shot interrupt transfers
  o USB: usb-uhci fix for one-shot interrupt problem

<grigouze:noos.fr>:
  o USB: zaurus SL-C700

<kpc-usbdev:gelato.uiuc.edu>:
  o USB: Desknote/ECS UCR-61S2B card reader (2.4.21 patched)

Duncan Sands:
  o USB speedtouch: use common CRC library

Greg Kroah-Hartman:
  o USB: compiler fixes for previous vicam patches
  o Cset exclude: cweidema@indiana.edu|ChangeSet|20030620002017|05386
  o USB: pl2303: report CTS and DSR status changes to userspace
  o USB: add support for 50 baud to io_edgeport.c
  o USB: 2.4 fix UHCI debug kmalloc() usage
  o USB: remove stupid conversions and use of floating point from aiptek.c

Oliver Neukum:
  o USB: fix to previous vicam patch
  o USB: disconnect of v4l devices in 2.4

William R. Sowerbutts:
  o USB: Update for the powermate driver to work with newer devices

