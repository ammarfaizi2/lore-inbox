Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTEGX0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTEGXEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:04:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46062 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264323AbTEGXCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Date: Wed, 7 May 2003 16:15:19 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, hannal@us.ibm.com
Subject: [BK PATCH] TTY changes for 2.5.69
Message-ID: <20030507231519.GA4346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some TTY changesets that do two different things TTY related
things:
 - fix the MOD_DEC/MOD_INC warnings for a number of tty drivers.  These
   patches were previously sent to the Trivial Patch Monkey, but seem to
   have disappeared in its bowels somewhere, never to be seen again.
   These are the majority of the changes (25 different patches), and
   were all written by Hanna Linder.

 - Make the tty class code actually work.  With these changes, the
   /sys/class/tty directory shows all current tty devices, along with
   their device numbers, and a link to their device in the sysfs tree,
   if it has a physical location in that tree.  Yeah, the implementation
   of yet another list of devices within the tty core isn't the nicest,
   but until the tty layer switches over to having tty devices in memory
   before they are opened (like all other device subsystems), this is
   necessary.  For 2.7, this extra list will go away.
  
Please pull from:
        bk://kernel.bkbits.net/gregkh/linux/tty-2.5

Patches will be posted as a followup to lkml.

thanks,

greg k-h


 arch/mips/au1000/common/serial.c |    8 +-
 drivers/char/amiserial.c         |    7 -
 drivers/char/cyclades.c          |    8 --
 drivers/char/dz.c                |    5 -
 drivers/char/esp.c               |    9 --
 drivers/char/hvc_console.c       |    3 
 drivers/char/ip2main.c           |    9 --
 drivers/char/isicom.c            |    8 --
 drivers/char/istallion.c         |   10 --
 drivers/char/moxa.c              |   12 ---
 drivers/char/mxser.c             |   19 +----
 drivers/char/pcxx.c              |    6 -
 drivers/char/rio/rio_linux.c     |   26 ------
 drivers/char/rio/rio_linux.h     |    3 
 drivers/char/rio/riotty.c        |    5 -
 drivers/char/riscom8.c           |    8 --
 drivers/char/rocket.c            |   10 --
 drivers/char/ser_a2232.c         |    7 -
 drivers/char/serial167.c         |    1 
 drivers/char/serial_tx3912.c     |   35 ---------
 drivers/char/sh-sci.c            |   22 -----
 drivers/char/specialix.c         |    8 --
 drivers/char/stallion.c          |   28 +------
 drivers/char/tty_io.c            |  146 ++++++++++++++++++++++++++++++++-------
 drivers/char/vme_scc.c           |    7 -
 drivers/char/vt.c                |    2 
 drivers/isdn/capi/capi.c         |    8 --
 drivers/macintosh/macserial.c    |    7 -
 drivers/serial/core.c            |    2 
 drivers/sgi/char/sgiserial.c     |    1 
 drivers/tc/zs.c                  |    5 -
 drivers/usb/class/bluetty.c      |    2 
 drivers/usb/class/cdc-acm.c      |    2 
 drivers/usb/serial/bus.c         |   17 ----
 include/linux/tty.h              |    3 
 35 files changed, 179 insertions(+), 280 deletions(-)
-----

Greg Kroah-Hartman:
  o TTY: remove usb-serial sysfs dev file as it is now redundant
  o TTY: changes based on tty_register_device() paramater change
  o TTY: add tty class support for all tty devices

Hanna V. Linder:
  o vme_scc tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o isdn/capi  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o macintosh/macserial  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o amiserial tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o cyclades tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o dz tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o hvc_console tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o esp  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o isicom tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o ip2main tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o moxa tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o istallion  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o mxser tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o pcxx tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o riscom8 tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o rio  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o sgi/char/sgiserial tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o rocket tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o serial167 tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o ser_a2232 tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o sh-sci tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o serial_tx3912  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o stallion tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o specialix tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o tc_zs tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT

