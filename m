Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTFBSNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbTFBSNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:13:30 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:33221 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264830AbTFBSN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:13:29 -0400
Date: Mon, 2 Jun 2003 11:28:45 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.70
Message-ID: <20030602182845.GA5781@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB changes and fixes for 2.5.70.  Some usb-storage
changes, a BKL removal, a compile fix, and some security root_plug
cleanups (the USB portion of that file.)

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/Makefile               |    3 
 drivers/usb/core/hub.c             |    4 -
 drivers/usb/core/usb.c             |   65 ++++++++++++++++++
 drivers/usb/misc/rio500.c          |   16 ++--
 drivers/usb/serial/Kconfig         |    1 
 drivers/usb/serial/kobil_sct.c     |   53 ++++++++++-----
 drivers/usb/storage/datafab.c      |    2 
 drivers/usb/storage/freecom.c      |    6 -
 drivers/usb/storage/initializers.c |    2 
 drivers/usb/storage/initializers.h |    1 
 drivers/usb/storage/isd200.c       |   20 ++---
 drivers/usb/storage/jumpshot.c     |    2 
 drivers/usb/storage/protocol.c     |    9 +-
 drivers/usb/storage/scsiglue.c     |   40 +++++++----
 drivers/usb/storage/transport.c    |  129 ++++++++++++++++++++++---------------
 drivers/usb/storage/transport.h    |    4 -
 drivers/usb/storage/usb.c          |   17 +++-
 drivers/usb/storage/usb.h          |    2 
 include/linux/usb.h                |    2 
 security/Kconfig                   |    2 
 security/root_plug.c               |   69 ++-----------------
 21 files changed, 265 insertions(+), 184 deletions(-)
-----

<bellucda:tiscali.it>:
  o USB: replaced BKL in rio500.c

Adrian Bunk:
  o SECURITY_ROOTPLUG must depend on USB

Greg Kroah-Hartman:
  o USB: added .owner to kobil_sct driver
  o Root plug: remove USB bus walking functions, now use usb_find_device()
  o USB: add usb_find_device() function to USB core
  o Cset exclude: greg@kroah.com|ChangeSet|20030529215347|05329

Matthew Dharm:
  o USB: usb-storage: change result codes
  o USB: usb-storage: usb_stor_control_msg() and stuff
  o USB: usb-storage: timeouts and aborts
  o USB: usb-storage: fix typo

Oliver Neukum:
  o USB: return errors when disabling a port

Thomas Wahrenbruch:
  o USB: kobil_sct.c added support for KAAN SIM Reader

