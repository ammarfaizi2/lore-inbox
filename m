Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbSL3I6z>; Mon, 30 Dec 2002 03:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266804AbSL3I6z>; Mon, 30 Dec 2002 03:58:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29454 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266796AbSL3I6u>;
	Mon, 30 Dec 2002 03:58:50 -0500
Date: Mon, 30 Dec 2002 01:02:22 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] minor TTY changes for 2.5.53
Message-ID: <20021230090221.GA29926@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some minor tty patches.  They change the name of
tty_*register_devfs() to tty_*register_device() which makes more sense
as to what the call is doing.  They also get rid of flag that was unused
by everyone but the pty driver for this call.  Also, a tty_devclass was
created, and the usb-serial core changed to use it.  Both of these
patches were posted to lkml previously with no comments.

I also removed some usages of MIN and MAX while I was messing around
with the core tty files, as I couldn't help myself :)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/tty-2.5

thanks,

greg k-h

 arch/mips/au1000/common/serial.c |   12 +++++-----
 drivers/char/dz.c                |    4 +--
 drivers/char/hvc_console.c       |    2 -
 drivers/char/ip2main.c           |    8 +++----
 drivers/char/n_tty.c             |   17 +++++++--------
 drivers/char/pty.c               |    7 ++----
 drivers/char/tty_io.c            |   43 ++++++++++++++++++++++++---------------
 drivers/char/vt.c                |    2 -
 drivers/serial/core.c            |   12 ++++------
 drivers/tc/zs.c                  |    4 +--
 drivers/usb/class/bluetty.c      |   10 ++++-----
 drivers/usb/class/cdc-acm.c      |   12 +++++-----
 drivers/usb/serial/bus.c         |   17 ++++++++-------
 include/linux/tty.h              |    5 +---
 include/linux/tty_driver.h       |    2 +
 15 files changed, 83 insertions(+), 74 deletions(-)
-----

ChangeSet@1.971, 2002-12-30 00:03:48-08:00, greg@kroah.com
  Merge kroah.com:/home/linux/linux/BK/bleeding-2.5
  into kroah.com:/home/linux/linux/BK/tty-2.5

 drivers/serial/core.c       |    8 +++-----
 drivers/usb/class/bluetty.c |    6 +++---
 drivers/usb/class/cdc-acm.c |    6 +++---
 drivers/usb/serial/bus.c    |   12 ++++++------
 4 files changed, 15 insertions(+), 17 deletions(-)
------

ChangeSet@1.956.3.4, 2002-12-29 23:59:37-08:00, greg@kroah.com
  TTY: replace MIN and MAX macro usages with min() and max()

 drivers/char/n_tty.c  |   17 ++++++++---------
 drivers/char/pty.c    |    4 +---
 drivers/char/tty_io.c |    9 +--------
 3 files changed, 10 insertions(+), 20 deletions(-)
------

ChangeSet@1.956.3.3, 2002-12-29 23:42:02-08:00, greg@kroah.com
  TTY: Use the tty_devclass for all usb-serial devices.

 drivers/usb/serial/bus.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.956.3.2, 2002-12-29 23:34:36-08:00, greg@kroah.com
  TTY: add tty_devclass to the tty core.

 drivers/char/tty_io.c      |    8 ++++++++
 include/linux/tty_driver.h |    2 ++
 2 files changed, 10 insertions(+)
------

ChangeSet@1.956.3.1, 2002-12-29 23:21:18-08:00, greg@kroah.com
  TTY: Change tty_*register_devfs() to tty_*register_device()
  
  Also got rid of the unused flag paramater.

 arch/mips/au1000/common/serial.c |   12 ++++++------
 drivers/char/dz.c                |    4 ++--
 drivers/char/hvc_console.c       |    2 +-
 drivers/char/ip2main.c           |    8 ++++----
 drivers/char/pty.c               |    3 ++-
 drivers/char/tty_io.c            |   26 ++++++++++++++++++--------
 drivers/char/vt.c                |    2 +-
 drivers/serial/core.c            |    4 ++--
 drivers/tc/zs.c                  |    4 ++--
 drivers/usb/class/bluetty.c      |    4 ++--
 drivers/usb/class/cdc-acm.c      |    6 +++---
 drivers/usb/serial/bus.c         |    4 ++--
 include/linux/tty.h              |    5 ++---
 13 files changed, 47 insertions(+), 37 deletions(-)
------

