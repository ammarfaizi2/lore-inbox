Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbUCPASr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbUCPAFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:05:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:8879 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262884AbUCPACF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:05 -0500
Date: Mon, 15 Mar 2004 14:48:53 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver fixes for 2.6.4
Message-ID: <20040315224853.GA18325@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver updates for 2.6.4.  All of these changes have
been in the last few -mm trees.  It includes a number of bugfixes, new
i2c chip drivers, and a rework of the i2c sysfs file interface.  Because
of the sysfs changes, a new version of lmsensors will be needed (just
like almost all other 2.6 kernel releases...)  Hopefully now the
lmsensor/sysfs interface changes are resolved so this will not be
necessary in the future.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/sysfs-interface      |  272 +++--
 drivers/i2c/algos/i2c-algo-bit.c       |    2 
 drivers/i2c/algos/i2c-algo-pcf.c       |    2 
 drivers/i2c/algos/Makefile             |    4 
 drivers/i2c/busses/i2c-ali1535.c       |    7 
 drivers/i2c/busses/i2c-ali15x3.c       |    4 
 drivers/i2c/busses/i2c-amd756.c        |    4 
 drivers/i2c/busses/i2c-amd8111.c       |    4 
 drivers/i2c/busses/i2c-elektor.c       |    4 
 drivers/i2c/busses/i2c-elv.c           |  168 ---
 drivers/i2c/busses/i2c-elv.c           |    8 
 drivers/i2c/busses/i2c-frodo.c         |    4 
 drivers/i2c/busses/i2c-i801.c          |    6 
 drivers/i2c/busses/i2c-i810.c          |    4 
 drivers/i2c/busses/i2c-ibm_iic.c       |    4 
 drivers/i2c/busses/i2c-iop3xx.c        |   24 
 drivers/i2c/busses/i2c-isa.c           |    4 
 drivers/i2c/busses/i2c-ite.c           |    4 
 drivers/i2c/busses/i2c-ixp42x.c        |  184 +++
 drivers/i2c/busses/i2c-keywest.c       |    4 
 drivers/i2c/busses/i2c-nforce2.c       |    4 
 drivers/i2c/busses/i2c-parport.c       |    4 
 drivers/i2c/busses/i2c-parport-light.c |    4 
 drivers/i2c/busses/i2c-philips-par.c   |  242 -----
 drivers/i2c/busses/i2c-philips-par.c   |    4 
 drivers/i2c/busses/i2c-piix4.c         |    4 
 drivers/i2c/busses/i2c-prosavage.c     |    8 
 drivers/i2c/busses/i2c-rpx.c           |    4 
 drivers/i2c/busses/i2c-savage4.c       |    4 
 drivers/i2c/busses/i2c-sis5595.c       |    7 
 drivers/i2c/busses/i2c-sis630.c        |    4 
 drivers/i2c/busses/i2c-sis96x.c        |    4 
 drivers/i2c/busses/i2c-velleman.c      |  154 ---
 drivers/i2c/busses/i2c-velleman.c      |    6 
 drivers/i2c/busses/i2c-via.c           |    5 
 drivers/i2c/busses/i2c-viapro.c        |    4 
 drivers/i2c/busses/i2c-voodoo3.c       |    8 
 drivers/i2c/busses/Kconfig             |   43 
 drivers/i2c/busses/Makefile            |    8 
 drivers/i2c/busses/scx200_acb.c        |    4 
 drivers/i2c/busses/scx200_i2c.c        |    4 
 drivers/i2c/chips/adm1021.c            |   65 -
 drivers/i2c/chips/asb100.c             |   60 -
 drivers/i2c/chips/ds1621.c             |  345 +++++++
 drivers/i2c/chips/eeprom.c             |    4 
 drivers/i2c/chips/fscher.c             |  120 +-
 drivers/i2c/chips/gl518sm.c            |  116 +-
 drivers/i2c/chips/it87.c               |  372 ++------
 drivers/i2c/chips/Kconfig              |   64 +
 drivers/i2c/chips/lm75.c               |   37 
 drivers/i2c/chips/lm78.c               |  156 +--
 drivers/i2c/chips/lm80.c               |  730 +++++++++++++--
 drivers/i2c/chips/lm83.c               |   56 -
 drivers/i2c/chips/lm85.c               |  189 +---
 drivers/i2c/chips/lm90.c               |   79 -
 drivers/i2c/chips/Makefile             |    7 
 drivers/i2c/chips/via686a.c            |  139 +--
 drivers/i2c/chips/w83627hf.c           | 1528 +++++++++++++++++++++++++++++++--
 drivers/i2c/chips/w83781d.c            |  324 +++---
 drivers/i2c/chips/w83l785ts.c          |   34 
 drivers/i2c/i2c-core.c                 |   15 
 drivers/i2c/i2c-dev.c                  |   49 -
 drivers/i2c/i2c-sensor.c               |    4 
 drivers/i2c/Kconfig                    |   12 
 drivers/i2c/Makefile                   |    4 
 drivers/pci/quirks.c                   |   25 
 include/linux/pci_ids.h                |   18 
 67 files changed, 3706 insertions(+), 2092 deletions(-)
-----

<aurelien:aurel32.net>:
  o I2C: New chip driver: ds1621

<clemy:clemy.org>:
  o I2C: add w83627hf driver

<dave.jiang:intel.com>:
  o I2C: IOP3xx i2c driver update

<komoriya:paken.org>:
  o I2C: it87 reset option

<perrye:linuxmail.org>:
  o I2C:  i2c-voodoo3.c needs I2C_ADAP_CLASS_TV_ANALOG

Adrian Bunk:
  o I2C: update I2C help text

Deepak Saxena:
  o I2C:  Support for IXP42x GPIO-based I2C

Greg Kroah-Hartman:
  o I2C: delete the i2c_philips-par.c and i2c-veleman.c drivers
  o I2C: delete the i2c-elv.c driver as it is obsoleted by the i2c-parport.c driver
  o I2C: fix up CONFIG_I2C_DEBUG_CHIP logic to be simpler on the .c files
  o I2C: add CONFIG_I2C_DEBUG_ALGO to be consistant
  o I2C: fix up CONFIG_I2C_DEBUG_CORE logic to be simpler on the .c files
  o I2C: fix up CONFIG_I2C_DEBUG_BUS logic to be simpler on the .c files
  o I2C: keep i2c-dev numbers in sync with i2c adapter numbers
  o I2C: show adapter name in i2c-dev class directory to make it easier for userspace tools
  o I2C: fix compiler warnings in 2 drivers
  o I2C: fix oops in i2c-ali1535 driver if no hardware is present

Jean Delvare:
  o I2C: Setting w83781d fan_div preserves fan_min
  o I2C: Don't handle kind errors that cannot happen
  o I2C: fix forced i2c chip drivers have no name
  o I2C: Cleanup fan_div in w83781d
  o I2c: Kconfig for non-sensors i2c chip drivers
  o I2C: fix i2c adapters class for now
  o I2C: Prevent i2c-dev oops with debug
  o I2C: rename sysfs files, part 2 of 2
  o I2C: rename sysfs files, part 1 of 2
  o I2C: update for sysfs-interface documentation
  o I2C: Remove asb100 support from w83781d
  o I2C: fix another oops in i2c-core with debug
  o I2C: fix it87 sensor type
  o I2C: fix Hangs with w83781d
  o I2C: Lowercase chips name
  o I2C: fix mor rmmod oopses
  o I2C: fix space in message
  o I2C: New chip driver ported: lm80
  o I2C: Credit James Bolt in w83l785ts
  o I2C: Enable debugging in fscher

Mark M. Hoffman:
  o I2C: sensor chip driver refactoring
  o I2C: sysfs interface update for w83627hf
  o PCI: fix i2c quirk for SiS735 chipset SMBus driver

Randy Dunlap:
  o I2C: fix i2c-prosavage.c section usage

Russell King:
  o I2C: Fix i2c_use_client()

