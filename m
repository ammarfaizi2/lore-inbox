Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTAOBEl>; Tue, 14 Jan 2003 20:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTAOBEl>; Tue, 14 Jan 2003 20:04:41 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39433 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265612AbTAOBEf>;
	Tue, 14 Jan 2003 20:04:35 -0500
Date: Tue, 14 Jan 2003 17:13:12 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] TTY changes for 2.5.58
Message-ID: <20030115011312.GA18283@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some minor tty patches.  They add a struct module to the
tty_driver structure and then increment and decrement the driver's
reference when the tty device assigned to that driver is in use.  This
is much like other subsystems do.

This patch was posted to lkml and no one objected to it.

I've also included a patch that adds this support to the tty drivers in
the drivers/usb/ directory.

Please pull from:
        bk://kernel.bkbits.net/gregkh/linux/tty-2.5

thanks,

greg k-h


 drivers/char/tty_io.c           |    7 +++++++
 drivers/usb/class/bluetty.c     |    7 +------
 drivers/usb/class/cdc-acm.c     |    4 +---
 drivers/usb/serial/usb-serial.c |    1 +
 include/linux/tty_driver.h      |    1 +
 5 files changed, 11 insertions(+), 9 deletions(-)
-----

ChangeSet@1.1026, 2003-01-14 16:57:38-08:00, greg@kroah.com
  TTY: Added .owner for tty drivers in the drivers/usb/ directory

 drivers/usb/class/bluetty.c     |    7 +------
 drivers/usb/class/cdc-acm.c     |    4 +---
 drivers/usb/serial/usb-serial.c |    1 +
 3 files changed, 3 insertions(+), 9 deletions(-)
------

ChangeSet@1.1025, 2003-01-14 16:51:58-08:00, greg@kroah.com
  TTY: add module reference counting for tty drivers.
  
  Note, there are still races with unloading modules, this patch
  does not fix that...

 drivers/char/tty_io.c      |    7 +++++++
 include/linux/tty_driver.h |    1 +
 2 files changed, 8 insertions(+)
------

