Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVCaXWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVCaXWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVCaXWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:22:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:57311 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261573AbVCaXWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:22:46 -0500
Date: Thu, 31 Mar 2005 15:22:30 -0800
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] I2C patches for 2.6.12-rc1
Message-ID: <20050331232230.GA2614@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a I2C update for 2.6.12-rc1.  It includes a lot of bugfixes and
documenation updates.  It also has two new i2c drivers.  All of these
patches have been in the past few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Patches will be posted to linux-kernel and sensors as a follow-up thread
for those who want to see them.

thanks,

greg k-h

 Documentation/i2c/i2c-parport              |  156 ----------
 Documentation/i2c/busses/i2c-ali1535       |   42 ++
 Documentation/i2c/busses/i2c-ali1563       |   27 +
 Documentation/i2c/busses/i2c-ali15x3       |  112 +++++++
 Documentation/i2c/busses/i2c-amd756        |   25 +
 Documentation/i2c/busses/i2c-amd8111       |   41 ++
 Documentation/i2c/busses/i2c-i801          |   80 +++++
 Documentation/i2c/busses/i2c-i810          |   46 +++
 Documentation/i2c/busses/i2c-nforce2       |   41 ++
 Documentation/i2c/busses/i2c-parport       |  174 +++++++++++
 Documentation/i2c/busses/i2c-parport-light |   11 
 Documentation/i2c/busses/i2c-pca-isa       |   23 +
 Documentation/i2c/busses/i2c-piix4         |   72 ++++
 Documentation/i2c/busses/i2c-prosavage     |   23 +
 Documentation/i2c/busses/i2c-savage4       |   26 +
 Documentation/i2c/busses/i2c-sis5595       |   59 ++++
 Documentation/i2c/busses/i2c-sis630        |   49 +++
 Documentation/i2c/busses/i2c-sis69x        |   73 +++++
 Documentation/i2c/busses/i2c-via           |   34 ++
 Documentation/i2c/busses/i2c-viapro        |   47 +++
 Documentation/i2c/busses/i2c-voodoo3       |   62 ++++
 Documentation/i2c/busses/scx200_acb        |   14 
 drivers/i2c/algos/i2c-algo-ite.c           |   13 
 drivers/i2c/algos/i2c-algo-pcf.c           |   44 ++-
 drivers/i2c/algos/i2c-algo-sibyte.c        |   13 
 drivers/i2c/busses/Kconfig                 |   38 +-
 drivers/i2c/busses/i2c-elektor.c           |    9 
 drivers/i2c/busses/i2c-ibm_iic.c           |    4 
 drivers/i2c/busses/i2c-ite.c               |    7 
 drivers/i2c/busses/i2c-mv64xxx.c           |    2 
 drivers/i2c/busses/i2c-s3c2410.c           |   15 -
 drivers/i2c/busses/i2c-viapro.c            |   17 -
 drivers/i2c/chips/Kconfig                  |   25 +
 drivers/i2c/chips/Makefile                 |    2 
 drivers/i2c/chips/adm1021.c                |   14 
 drivers/i2c/chips/ds1337.c                 |  402 +++++++++++++++++++++++++++
 drivers/i2c/chips/eeprom.c                 |    3 
 drivers/i2c/chips/it87.c                   |   10 
 drivers/i2c/chips/lm85.c                   |  104 +++++--
 drivers/i2c/chips/lm87.c                   |   20 -
 drivers/i2c/chips/lm90.c                   |   44 ++-
 drivers/i2c/chips/lm92.c                   |  423 +++++++++++++++++++++++++++++
 drivers/i2c/chips/m41t00.c                 |    1 
 drivers/i2c/chips/w83627hf.c               |    5 
 drivers/i2c/chips/w83781d.c                |  100 ------
 drivers/i2c/i2c-core.c                     |   10 
 include/linux/i2c.h                        |   13 
 47 files changed, 2175 insertions(+), 400 deletions(-)
-----


<frank.beesley:aeroflex.com>:
  o I2C: Clean up of i2c-elektor.c build

<grant_nospam:dodo.com.au>:
  o I2C: Drop useless w83781d RT feature
  o I2C: group Intel on I2C Hardware Bus support

Domen Puncer:
  o i2c/i2c-elektor: remove interruptible_sleep_on_timeout() usage
  o i2c/i2c-ite: remove interruptible_sleep_on_timeout() usage

Eric Brower:
  o I2C: lost arbitration detection for PCF8584

James Chapman:
  o i2c: add adt7461 chip support to lm90 driver
  o i2c: new driver for ds1337 RTC

Jean Delvare:
  o I2C: Fix indentation of lm87 driver
  o I2C: Fix broken force parameter handling
  o i2c: add adt7461 chip support to lm90 driver's Kconfig entry
  o I2C: i2c-s3c2410 functionality and fixes
  o I2C: Fix race condition in it87 driver
  o I2C: Delete useless instruction in it87
  o I2C: Fix Vaio EEPROM detection
  o I2C: Recognize new revision of the ADT7463 chip
  o I2C: Avoid repeated resets of i2c-viapro
  o I2C: Kill outdated defines in i2c.h
  o I2C: Fix some i2c algorithm initialization
  o I2C: Skip broken detection step in it87
  o I2C: Make master_xfer debug messages more useful
  o I2C: Kill unused struct members in w83627hf driver
  o I2C: Fix adm1021 alarms mask
  o I2C: Cleanup adm1021 unused defines
  o I2C: New lm92 chip driver

Mark A. Greer:
  o i2c: i2c-mv64xxx - set adapter owner and class fields
  o I2C: Fix breakage in m41t00 i2c rtc driver

Rafael Ávila de Espíndola:
  o I2C: lsb in emc6d102 and adm1027

Rudolf Marek:
  o I2C: busses documentation update 2 of 2
  o I2C: busses documentation update 1 of 2

