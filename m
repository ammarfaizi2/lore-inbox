Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTH1V52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTH1V52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:57:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:42389 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264304AbTH1V5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:57:24 -0400
Date: Thu, 28 Aug 2003 14:55:50 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB update for 2.4.23-pre1
Message-ID: <20030828215550.GA13190@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes and updates against 2.4.23-pre1.  This mostly
consists of a number of driver bug fixes from 2.6 and an occasional new
device supported.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 Documentation/usb/usb-serial.txt      |    3 
 drivers/usb/acm.c                     |  165 +++++++------
 drivers/usb/bluetooth.c               |    4 
 drivers/usb/devio.c                   |   55 ++--
 drivers/usb/host/ehci-hcd.c           |    3 
 drivers/usb/host/ehci-q.c             |    4 
 drivers/usb/host/ehci-sched.c         |    2 
 drivers/usb/pwc-ctrl.c                |   41 ---
 drivers/usb/pwc-if.c                  |  405 +++++++++++++++-------------------
 drivers/usb/pwc-ioctl.h               |    2 
 drivers/usb/pwc-misc.c                |    4 
 drivers/usb/pwc-uncompress.c          |   19 -
 drivers/usb/pwc-uncompress.h          |    2 
 drivers/usb/pwc.h                     |   27 +-
 drivers/usb/scanner.c                 |   84 +++++--
 drivers/usb/scanner.h                 |    8 
 drivers/usb/serial/ftdi_sio.c         |   59 +++-
 drivers/usb/serial/ftdi_sio.h         |   16 +
 drivers/usb/serial/io_16654.h         |    2 
 drivers/usb/serial/io_edgeport.c      |    4 
 drivers/usb/serial/io_edgeport.h      |    2 
 drivers/usb/serial/io_fw_boot.h       |    2 
 drivers/usb/serial/io_fw_boot2.h      |    2 
 drivers/usb/serial/io_fw_down.h       |    2 
 drivers/usb/serial/io_fw_down2.h      |    2 
 drivers/usb/serial/io_fw_down3.h      |    2 
 drivers/usb/serial/io_ionsp.h         |    2 
 drivers/usb/serial/io_ti.c            |    6 
 drivers/usb/serial/io_ti.h            |    2 
 drivers/usb/serial/io_usbvend.h       |    3 
 drivers/usb/serial/keyspan_pda.c      |    6 
 drivers/usb/serial/keyspan_pda_fw.h   |    2 
 drivers/usb/serial/keyspan_usa26msg.h |    4 
 drivers/usb/serial/keyspan_usa28msg.h |    4 
 drivers/usb/serial/keyspan_usa49msg.h |    4 
 drivers/usb/serial/pl2303.c           |   17 -
 drivers/usb/serial/usbserial.c        |    4 
 drivers/usb/serial/visor.c            |    2 
 drivers/usb/serial/visor.h            |    3 
 drivers/usb/serial/xircom_pgs_fw.h    |    4 
 drivers/usb/storage/unusual_devs.h    |   23 +
 drivers/usb/usb-skeleton.c            |    2 
 drivers/usb/usb.c                     |   30 ++
 drivers/usb/usbnet.c                  |   44 +--
 include/linux/usb.h                   |    2 
 include/linux/usbdevice_fs.h          |    2 
 46 files changed, 576 insertions(+), 511 deletions(-)
-----

<gaa:ulticom.com>:
  o USB: new ids for io_ti driver

<kevino:asti-usa.com>:
  o USB: bug in EHCI device reset through transaction

<malte.d:gmx.net>:
  o USB: support for Zaurus 750/760 to usbnet.c (2.4.22-pre8) + code cleanup backport from 2.6

<russell_d_cagle:mindspring.com>:
  o USB: add Garmin iQue support to visor driver

Alan Stern:
  o USB: Another unusual_devs.h entry update
  o USB: More unusual_devs.h stuff
  o USB: More unusual_devs.h entry updates

Dan Streetman:
  o USB: backport usbfs 'disconnect'

Dave Jones:
  o USB: Add Minolta Dimage F300 to unusual_devs

David Brownell:
  o USB: ehci-hcd and period=1frame hs interrupts
  o USB: ehci needs a readb() on IDP425 PCI (ARM)

Greg Kroah-Hartman:
  o USB: fix up a bunch of copyrights that were incorrectly declared
  o USB: remove some vendor specific stuff from the pl2303 driver to get other devices to work
  o USB: added support for TIOCM_RI and TIOCM_CD to pl2303 driver and fix stupid bug

Henning Meier-Geinitz:
  o USB: unlink interrupt URBs in scanner driver
  o USB: Fix crash when scanners are disconnected while open
  o USB: fix check for SCN_MAX_MNR in scanner driver
  o USB: New vendor/product ids for scanner driver

Ian Abbott:
  o USB: ftdi_sio - tidy up write bulk callback
  o USB: ftdi_sio - VID/PID for ID TECH IDT1221U USB to RS-232 adapter
  o USB: ftdi_sio - additional pids

Judd Montgomery:
  o USB: visor.h[c] USB device IDs documentation

Nemosoft Unv.:
  o USB: PWC 8.11

Stefan Becker:
  o USB: acm.c update for new devices

