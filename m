Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbTDXXlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTDXXiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:38:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:7090 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264497AbTDXXeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:07 -0400
Date: Thu, 24 Apr 2003 16:46:14 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.68
Message-ID: <20030424234614.GA29734@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB changes and fixes for 2.5.68.  The majority of these
changes are due to the tty core adding the tiocmset and tiocmget
functions instead of using the ioctl values.  I've also included a small
patch to the tty core's tiocmset function that allows TIOCM_LOOP changes
to be seen by the tty drivers.  Russell King has acked this change.

There are also some small bugfixes and compiler warning removal changes
in here too.


Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5


Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/char/tty_io.c                |    4 
 drivers/usb/class/cdc-acm.c          |  120 +++++++++++----------
 drivers/usb/class/usb-midi.c         |    2 
 drivers/usb/core/hcd-pci.c           |   16 +-
 drivers/usb/core/hcd.c               |    4 
 drivers/usb/core/usb.c               |   14 +-
 drivers/usb/misc/speedtch.c          |   32 +++--
 drivers/usb/net/kaweth.c             |    2 
 drivers/usb/net/usbnet.c             |    8 +
 drivers/usb/serial/belkin_sa.c       |  110 +++++++++++--------
 drivers/usb/serial/digi_acceleport.c |  124 +++++++++++++--------
 drivers/usb/serial/ftdi_sio.c        |  193 +++++++++++++++------------------
 drivers/usb/serial/io_edgeport.c     |   80 +++++---------
 drivers/usb/serial/io_tables.h       |    8 +
 drivers/usb/serial/io_ti.c           |   82 +++++---------
 drivers/usb/serial/keyspan.c         |   68 +++++------
 drivers/usb/serial/keyspan.h         |   11 +
 drivers/usb/serial/keyspan_pda.c     |   94 +++++++---------
 drivers/usb/serial/kl5kusb105.c      |  112 ++++++++++---------
 drivers/usb/serial/kobil_sct.c       |  200 ++++++++++++++++++++---------------
 drivers/usb/serial/mct_u232.c        |   82 +++++++-------
 drivers/usb/serial/pl2303.c          |  142 ++++++++++++++----------
 drivers/usb/serial/usb-serial.c      |   94 ++++++++++++++++
 drivers/usb/serial/usb-serial.h      |    2 
 drivers/usb/serial/whiteheat.c       |  184 +++++++++++++-------------------
 25 files changed, 975 insertions(+), 813 deletions(-)
-----

Andrew Morton <akpm@digeo.com>:
  o usb: minor usb stuff

David Brownell <david-b@pacbell.net>:
  o usb: fix (rare?) disconnect
  o USB: hcd-pci.c catch up to dev_printk changes
  o USB: fix for deadlock in v2.5.67

Duncan Sands <baldrick@wanadoo.fr>:
  o USB speedtouch: compile fix
  o USB speedtouch: crc optimization
  o USB speedtouch: bump the version number

Greg Kroah-Hartman <greg@kroah.com>:
  o tty: let tiocmset pass TIOCM_LOOP changes to the tty drivers
  o USB: add error reporting functionality to the pl2303 driver
  o USB: whiteheat: add support for new tty tiocmget and tiocmset functions
  o USB: pl2303: add support for new tty tiocmget and tiocmset functions
  o USB: mct_u232: add support for new tty tiocmget and tiocmset functions
  o USB: kobil_sct: add support for new tty tiocmget and tiocmset functions
  o USB: kl5kusb105: add support for new tty tiocmget and tiocmset functions
  o USB: keyspan_pda: add support for new tty tiocmget and tiocmset functions
  o USB: ftdi_sio: add support for new tty tiocmget and tiocmset functions
  o USB: digi_acceleport: add support for new tty tiocmget and tiocmset functions
  o USB: belkin_sa: add support for new tty tiocmget and tiocmset functions
  o USB: usb-serial core: add support for new tty tiocmget and tiocmset functions
  o USB: cdc-acm: add support for new tty tiocmget and tiocmset functions

