Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTIWAKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTIVX6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:58:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:27553 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262807AbTIVXb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:27 -0400
Date: Mon, 22 Sep 2003 16:28:47 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test5
Message-ID: <20030922232846.GA800@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes and additions for 2.6.0-test5.  I've
ported almost all of the i2c bus drivers from the 2.4 cvs tree to the
2.6 kernel (the one exception is a crazy one that acts like a pci
hotplug driver in its init function, I'll leave that to someone else...)
I've also cleaned up the existing i2c bus drivers by moving them into
the proper directory, and polishing up the Kconfig entries.

There are a also a few other minor i2c cleanups and fixes in here.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/i2c-adap-ite.c           |  278 ----------
 drivers/i2c/i2c-algo-ibm_ocp.c       |  900 -----------------------------------
 drivers/i2c/i2c-algo-ibm_ocp.h       |   55 --
 drivers/i2c/i2c-elektor.c            |  286 -----------
 drivers/i2c/i2c-elv.c                |  176 ------
 drivers/i2c/i2c-frodo.c              |   85 ---
 drivers/i2c/i2c-ibm_iic.c            |  729 ----------------------------
 drivers/i2c/i2c-ibm_iic.h            |  124 ----
 drivers/i2c/i2c-iop3xx.c             |  536 --------------------
 drivers/i2c/i2c-iop3xx.h             |  118 ----
 drivers/i2c/i2c-keywest.c            |  653 -------------------------
 drivers/i2c/i2c-keywest.h            |  110 ----
 drivers/i2c/i2c-philips-par.c        |  256 ---------
 drivers/i2c/i2c-prosavage.c          |  356 -------------
 drivers/i2c/i2c-rpx.c                |  103 ----
 drivers/i2c/i2c-velleman.c           |  161 ------
 drivers/i2c/scx200_acb.c             |  553 ---------------------
 drivers/i2c/scx200_i2c.c             |  133 -----
 drivers/i2c/Kconfig                  |  237 +--------
 drivers/i2c/Makefile                 |   18 
 drivers/i2c/busses/Kconfig           |  385 +++++++++-----
 drivers/i2c/busses/Makefile          |   22 
 drivers/i2c/busses/i2c-ali1535.c     |    4 
 drivers/i2c/busses/i2c-ali15x3.c     |    4 
 drivers/i2c/busses/i2c-amd756.c      |    4 
 drivers/i2c/busses/i2c-amd8111.c     |    3 
 drivers/i2c/busses/i2c-elektor.c     |  304 +++++++++++
 drivers/i2c/busses/i2c-elv.c         |  197 +++++++
 drivers/i2c/busses/i2c-frodo.c       |   85 +++
 drivers/i2c/busses/i2c-i801.c        |    4 
 drivers/i2c/busses/i2c-i810.c        |  256 +++++++++
 drivers/i2c/busses/i2c-ibm_iic.c     |  729 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-ibm_iic.h     |  124 ++++
 drivers/i2c/busses/i2c-iop3xx.c      |  536 ++++++++++++++++++++
 drivers/i2c/busses/i2c-iop3xx.h      |  118 ++++
 drivers/i2c/busses/i2c-isa.c         |   10 
 drivers/i2c/busses/i2c-ite.c         |  278 ++++++++++
 drivers/i2c/busses/i2c-keywest.c     |  653 +++++++++++++++++++++++++
 drivers/i2c/busses/i2c-keywest.h     |  110 ++++
 drivers/i2c/busses/i2c-nforce2.c     |    3 
 drivers/i2c/busses/i2c-philips-par.c |  289 ++++++++++-
 drivers/i2c/busses/i2c-piix4.c       |    4 
 drivers/i2c/busses/i2c-prosavage.c   |  410 ++++++++++++++-
 drivers/i2c/busses/i2c-rpx.c         |  105 ++++
 drivers/i2c/busses/i2c-savage4.c     |  205 +++++++
 drivers/i2c/busses/i2c-sis5595.c     |  420 ++++++++++++++++
 drivers/i2c/busses/i2c-sis630.c      |  497 +++++++++++++++++++
 drivers/i2c/busses/i2c-sis96x.c      |    3 
 drivers/i2c/busses/i2c-velleman.c    |  164 ++++++
 drivers/i2c/busses/i2c-via.c         |  184 +++++++
 drivers/i2c/busses/i2c-viapro.c      |    3 
 drivers/i2c/busses/i2c-voodoo3.c     |  248 +++++++++
 drivers/i2c/busses/scx200_acb.c      |  553 +++++++++++++++++++++
 drivers/i2c/busses/scx200_i2c.c      |  132 +++++
 drivers/i2c/chips/Kconfig            |  111 +---
 drivers/i2c/chips/adm1021.c          |   13 
 drivers/i2c/chips/it87.c             |    5 
 drivers/i2c/chips/lm75.c             |    2 
 drivers/i2c/chips/lm78.c             |    8 
 drivers/i2c/chips/lm85.c             |   16 
 drivers/i2c/chips/via686a.c          |    4 
 drivers/i2c/chips/w83781d.c          |   32 -
 drivers/i2c/i2c-adap-ite.c           |    1 
 drivers/i2c/i2c-algo-ite.c           |    1 
 drivers/i2c/i2c-core.c               |    6 
 drivers/i2c/i2c-dev.c                |    3 
 drivers/i2c/i2c-elektor.c            |    1 
 drivers/i2c/i2c-ibm_iic.c            |  729 ++++++++++++++++++++++++++++
 drivers/i2c/i2c-ibm_iic.h            |  124 ++++
 drivers/i2c/i2c-keywest.c            |    1 
 drivers/i2c/i2c-prosavage.c          |    1 
 drivers/i2c/i2c-sensor.c             |    5 
 drivers/i2c/scx200_acb.c             |    2 
 drivers/media/video/msp3400.c        |    2 
 drivers/media/video/saa5249.c        |    2 
 drivers/media/video/tuner.c          |    4 
 drivers/video/matrox/i2c-matroxfb.c  |    2 
 include/linux/i2c-id.h               |    2 
 include/linux/i2c.h                  |    9 
 79 files changed, 7794 insertions(+), 6205 deletions(-)
-----

<arvidjaar:mail.ru>:
  o I2C: sysfs sensor nameing inconsistency

<mds:paradyne.com>:
  o I2C: i2c-isa functionality

Greg Kroah-Hartman:
  o I2C: remove I2C_VERSION and I2C_DATE as they make no sense in the kernel tree
  o I2C: remove check_region usage and warning from i2c-sensor
  o I2C: move the remaining i2c bus drivers to drivers/i2c/busses
  o I2C: move the scx200* drivers to drivers/i2c/busses
  o I2C: move i2c-velleman driver to drivers/i2c/busses
  o I2C: move i2c-elektor.c driver to drivers/i2c/busses/
  o I2C: clean up the i2c-elv.c driver a bit
  o I2C: move i2c-elv.c driver to drivers/i2c/busses
  o I2C: clean up i2c-philips-par.c driver a bit
  o I2C: move the i2c-philips-par driver to drivers/i2c/busses
  o I2C: fix up dependancies in the i2c/busses/Kconfig file
  o I2C: clean up i2c-prosavage.c driver
  o I2C: move i2c-prosavage.c driver to drivers/i2c/busses where it belongs
  o I2C: clean up the drivers/i2c/Kconfig file
  o I2C: clean up the i2c chips Kconfig logic and help information
  o I2C: add the i2c-voodoo3 i2c bus driver
  o I2C: add the i2c-savage4 i2c bus driver
  o I2C: add the i2c-i810 i2c bus driver
  o I2C: turn off debugging on the new sis i2c bus drivers
  o I2C: clean up the i2c bus Kconfig menu and help texts
  o I2C: add the i2c-via i2c bus driver
  o I2C: add the i2c-sis630 i2c bus driver
  o I2C: add the i2c-sis5595 i2c bus driver
  o I2C: remove some usages of i2c_adapter.id as they are not used
  o I2C: added new id for Radeon driver

Hirofumi Ogawa:
  o DEVICE_NAME_SIZE/_HALF removal (I2C related, but fb stuff)
  o DEVICE_NAME_SIZE/_HALF removal (I2C related, but v4l stuff)
  o DEVICE_NAME_SIZE/_HALF removal (I2C stuff)

Martin Schlemmer:
  o I2C: Fix conversion from milli volts in store_in_reg() for w83781d.c

Matt Porter:
  o I2C: New PPC4xx I2C driver

Randy Hron:
  o I2C: drivers/i2c version.h cleanup

