Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbUKIFWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUKIFWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUKIFWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:22:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:7837 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261357AbUKIFWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:22:43 -0500
Date: Mon, 8 Nov 2004 21:22:29 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] I2C update for 2.6.10-rc1
Message-ID: <20041109052229.GA5117@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes and updates for 2.6.10-rc1.  There are a
few new i2c sensor and adapter drivers in here, and a number of bug
fixes.  The structures that the chip drivers use to specify which
addresses they support has been shrunk, as a step toward moving them to
use the hotplug interfaces for autoloading.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 drivers/i2c/busses/Kconfig            |   15 
 drivers/i2c/busses/Makefile           |    1 
 drivers/i2c/busses/i2c-ali1535.c      |    4 
 drivers/i2c/busses/i2c-amd756-s4882.c |  261 ++++++
 drivers/i2c/busses/i2c-amd756.c       |   12 
 drivers/i2c/busses/i2c-amd8111.c      |   12 
 drivers/i2c/busses/i2c-ibm_iic.c      |   16 
 drivers/i2c/busses/i2c-s3c2410.c      |   71 +
 drivers/i2c/busses/scx200_acb.c       |    4 
 drivers/i2c/busses/scx200_i2c.c       |    4 
 drivers/i2c/chips/Kconfig             |   28 
 drivers/i2c/chips/Makefile            |    2 
 drivers/i2c/chips/adm1021.c           |    9 
 drivers/i2c/chips/adm1025.c           |    4 
 drivers/i2c/chips/adm1031.c           |    4 
 drivers/i2c/chips/asb100.c            |    5 
 drivers/i2c/chips/ds1621.c            |    5 
 drivers/i2c/chips/eeprom.c            |    5 
 drivers/i2c/chips/fscher.c            |    2 
 drivers/i2c/chips/gl518sm.c           |    2 
 drivers/i2c/chips/it87.c              |   14 
 drivers/i2c/chips/lm63.c              |  571 ++++++++++++++
 drivers/i2c/chips/lm75.c              |    5 
 drivers/i2c/chips/lm77.c              |    4 
 drivers/i2c/chips/lm78.c              |    7 
 drivers/i2c/chips/lm80.c              |    5 
 drivers/i2c/chips/lm83.c              |    8 
 drivers/i2c/chips/lm85.c              |  451 ++++++++++-
 drivers/i2c/chips/lm87.c              |    4 
 drivers/i2c/chips/lm90.c              |    2 
 drivers/i2c/chips/max1619.c           |    8 
 drivers/i2c/chips/pc87360.c           | 1316 +++++++++++++++++++++++++++++++++-
 drivers/i2c/chips/pcf8574.c           |    6 
 drivers/i2c/chips/pcf8591.c           |    5 
 drivers/i2c/chips/rtc8564.c           |    3 
 drivers/i2c/chips/smsc47m1.c          |    8 
 drivers/i2c/chips/via686a.c           |    2 
 drivers/i2c/chips/w83627hf.c          |    2 
 drivers/i2c/chips/w83781d.c           |    6 
 drivers/i2c/chips/w83l785ts.c         |    2 
 drivers/i2c/i2c-core.c                |   73 -
 drivers/i2c/i2c-sensor-detect.c       |   91 --
 drivers/w1/dscore.c                   |    4 
 drivers/w1/w1.c                       |    4 
 drivers/w1/w1_family.c                |    5 
 drivers/w1/w1_int.c                   |    5 
 include/linux/i2c-sensor.h            |   36 
 47 files changed, 2752 insertions(+), 361 deletions(-)
-----

<arjan:infradead.org>:
  o I2C: remove dead code from i2c

<jthiessen:penguincomputing.com>:
  o I2C: fix lm85.c build warnings
  o I2C: lm85.c driver update

Adrian Bunk:
  o i2c/busses/ : make some code static
  o i2c it87.c: remove an unused function

Ben Dooks:
  o S3C2410 i2c updates
  o I2C: Fix compile of drivers/i2c/busses/i2c-s3c2410.c

Eugene Surovegin:
  o I2C: fix recently introduced race in IBM PPC4xx I2C driver

Evgeniy Polyakov:
  o w1/w1_int: replace schedule_timeout() with msleep_interruptible()
  o w1/dscore: replace schedule_timeout() with msleep_interruptible()
  o w1/w1: replace schedule_timeout() with msleep_interruptible()
  o w1/w1_family: replace schedule_timeout() with msleep_interruptible()

Greg Kroah-Hartman:
  o I2C: delete normal_i2c_range logic from sensors as there are no more users
  o I2C: moved from all sensor drivers from normal_i2c_range to normal_i2c
  o I2C: fix i2c_detect to allow NULL fields in adapter address structure
  o I2C: remove normal_isa_range from I2C sensor drivers, as it's not used
  o I2C: remove ignore_range from I2C sensor drivers, as it's not used
  o I2C: remove probe_range from I2C sensor drivers, as it's not used
  o W1: fix build warnings due to msleep changes
  o I2C: fix MODULE_PARAM warning in pc87360.c driver

Jean Delvare:
  o I2C: add Tyan S4882 driver
  o I2C: Check for unregistered adapter in i2c_del_adapter
  o I2C: New PC8736x chip driver
  o I2C: New LM63 chip driver

