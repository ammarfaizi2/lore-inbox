Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUATARG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUATAPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:15:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:26284 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265143AbUATAAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:10 -0500
Date: Mon, 19 Jan 2004 15:57:33 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver fixes for 2.6.1
Message-ID: <20040119235733.GA5549@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes and updates for 2.6.1.  There are a
number of bug fixes here, and a few new drivers have been added to the
tree.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/porting-clients      |    5 
 drivers/Kconfig                        |    2 
 drivers/char/Kconfig                   |    2 
 drivers/i2c/Kconfig                    |   32 
 drivers/i2c/algos/Kconfig              |    1 
 drivers/i2c/algos/i2c-algo-pcf.h       |    2 
 drivers/i2c/busses/Kconfig             |  101 ++-
 drivers/i2c/busses/Makefile            |    2 
 drivers/i2c/busses/i2c-ali1535.c       |    5 
 drivers/i2c/busses/i2c-ali15x3.c       |    5 
 drivers/i2c/busses/i2c-amd756.c        |    5 
 drivers/i2c/busses/i2c-amd8111.c       |    5 
 drivers/i2c/busses/i2c-elektor.c       |   19 
 drivers/i2c/busses/i2c-elv.c           |   17 
 drivers/i2c/busses/i2c-frodo.c         |    5 
 drivers/i2c/busses/i2c-i801.c          |    5 
 drivers/i2c/busses/i2c-i810.c          |    5 
 drivers/i2c/busses/i2c-ibm_iic.c       |    8 
 drivers/i2c/busses/i2c-iop3xx.c        |    9 
 drivers/i2c/busses/i2c-isa.c           |    5 
 drivers/i2c/busses/i2c-ite.c           |   24 
 drivers/i2c/busses/i2c-keywest.c       |   36 -
 drivers/i2c/busses/i2c-nforce2.c       |    5 
 drivers/i2c/busses/i2c-parport-light.c |  179 +++++
 drivers/i2c/busses/i2c-parport.c       |  273 ++++++++
 drivers/i2c/busses/i2c-parport.h       |   87 ++
 drivers/i2c/busses/i2c-philips-par.c   |    9 
 drivers/i2c/busses/i2c-piix4.c         |   12 
 drivers/i2c/busses/i2c-prosavage.c     |    5 
 drivers/i2c/busses/i2c-rpx.c           |    9 
 drivers/i2c/busses/i2c-savage4.c       |    5 
 drivers/i2c/busses/i2c-sis5595.c       |   10 
 drivers/i2c/busses/i2c-sis630.c        |    5 
 drivers/i2c/busses/i2c-sis96x.c        |    5 
 drivers/i2c/busses/i2c-velleman.c      |   14 
 drivers/i2c/busses/i2c-via.c           |    7 
 drivers/i2c/busses/i2c-viapro.c        |    5 
 drivers/i2c/busses/i2c-voodoo3.c       |    5 
 drivers/i2c/busses/scx200_acb.c        |   15 
 drivers/i2c/busses/scx200_i2c.c        |   10 
 drivers/i2c/chips/Kconfig              |   36 +
 drivers/i2c/chips/Makefile             |    7 
 drivers/i2c/chips/adm1021.c            |    5 
 drivers/i2c/chips/asb100.c             | 1059 ++++++++++++++++++++++++++++++++-
 drivers/i2c/chips/eeprom.c             |   67 +-
 drivers/i2c/chips/it87.c               |   13 
 drivers/i2c/chips/lm75.c               |    5 
 drivers/i2c/chips/lm78.c               |    7 
 drivers/i2c/chips/lm83.c               |    7 
 drivers/i2c/chips/lm85.c               |    5 
 drivers/i2c/chips/lm90.c               |  529 ++++++++++++++++
 drivers/i2c/chips/via686a.c            |    5 
 drivers/i2c/chips/w83781d.c            |   37 -
 drivers/i2c/chips/w83l785ts.c          |  314 +++++++++
 drivers/i2c/i2c-core.c                 |  114 +--
 drivers/i2c/i2c-dev.c                  |   10 
 drivers/i2c/i2c-sensor.c               |    5 
 drivers/ieee1394/Kconfig               |    9 
 drivers/media/video/Kconfig            |   13 
 drivers/media/video/saa7146.h          |    1 
 drivers/video/Kconfig                  |   21 
 include/linux/i2c-id.h                 |    3 
 62 files changed, 2966 insertions(+), 266 deletions(-)
-----

<ebs:ebshome.net>:
  o I2C: IBM IIC compile fix

Greg Kroah-Hartman:
  o I2C: remove unneeded CVS Id: lines
  o I2C: add I2C_DEBUG_BUS config option and convert the i2c bus drivers to use it
  o I2C: add I2C_DEBUG_CHIP config option and convert the i2c chip drivers to use it
  o I2C: add I2C_DEBUG_CORE config option and convert the i2c core code to use it
  o I2C: only select I2C_ITE if we are a MIPS system
  o I2C: remove CONFIG_ISA dependancy for I2C_ISA as x86_64 does not have CONFIG_ISA
  o I2C: move the Kconfig "source..." out of the drivers/char/ location

Jean Delvare:
  o I2C: Autoselect i2c algos
  o I2C: New driver: w83l785ts
  o I2C: Fix i2c busses warnings with DEBUG
  o I2C: Fix i2c-core.c with DEBUG
  o I2C: Fix lm90.c with DEBUG
  o I2C: speed up eeprom driver by a factor of 4
  o I2C: i2c-i801 help
  o I2C: clean up ISA dependancies
  o I2C: restore correct vaio handling in eeprom driver
  o I2C: Fix debug bug in lm83 driver
  o I2C: Fix w83781d temp
  o I2C: New chip driver: lm90
  o I2C: New parport bus drivers
  o I2C: i2c-rpx.c doesn't need ioports.h nor parport.h
  o I2C: Typo in i2c/busses/Kconfig
  o I2C: saa7146.h doesn't need i2c.h
  o I2C: documentation update

Mark M. Hoffman:
  o I2C: link asb100 in the proper order
  o I2C: Add ported sensor chip driver: asb100

Matthew Wilcox:
  o I2C: Kconfig cleanups

Tom Rini:
  o I2C: module_parm fixes for i2c-piix4.c

