Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUDNXkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUDNXi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:38:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:52126 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261907AbUDNWWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:22:35 -0400
Date: Wed, 14 Apr 2004 15:22:16 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] I2C update for 2.6.5
Message-ID: <20040414222215.GA26225@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver patches 2.6.5.  They have all been in the -mm
kernels for a number of weeks now and do the following:
	- add a new bus i2c driver
	- add 2 new chip drivers
	- updated documentation
	- lots of bug fixes

Please pull from:  bk://linuxusb.bkbits.net/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 arch/i386/pci/irq.c               |   10 
 Documentation/i2c/porting-clients |   46 ++--
 Documentation/i2c/sysfs-interface |   78 +++---
 drivers/i2c/busses/i2c-ali1563.c  |  429 +++++++++++++++++++++++++++++++++++++-
 drivers/i2c/busses/Kconfig        |   28 +-
 drivers/i2c/busses/Makefile       |    3 
 drivers/i2c/chips/adm1021.c       |   54 +---
 drivers/i2c/chips/asb100.c        |   38 +--
 drivers/i2c/chips/ds1621.c        |   28 --
 drivers/i2c/chips/eeprom.c        |   16 -
 drivers/i2c/chips/fscher.c        |   19 -
 drivers/i2c/chips/gl518sm.c       |   24 --
 drivers/i2c/chips/it87.c          |   51 ++--
 drivers/i2c/chips/Kconfig         |   23 +-
 drivers/i2c/chips/lm75.c          |   24 --
 drivers/i2c/chips/lm78.c          |   20 +
 drivers/i2c/chips/lm80.c          |   72 ++++--
 drivers/i2c/chips/lm83.c          |   17 -
 drivers/i2c/chips/lm85.c          |   14 -
 drivers/i2c/chips/lm90.c          |   17 -
 drivers/i2c/chips/Makefile        |    2 
 drivers/i2c/chips/pcf8574.c       |  260 ++++++++++++++++++++++-
 drivers/i2c/chips/pcf8591.c       |  349 +++++++++++++++++++++++++++++-
 drivers/i2c/chips/via686a.c       |  109 +--------
 drivers/i2c/chips/w83627hf.c      |   69 +++---
 drivers/i2c/chips/w83781d.c       |  201 +++++------------
 drivers/i2c/chips/w83l785ts.c     |   18 -
 include/linux/pci_ids.h           |    2 
 28 files changed, 1444 insertions(+), 577 deletions(-)
-----


<aurelien:aurel32.net>:
  o I2C: New chip driver: pcf8591
  o I2C: add new chip driver: pcf8574

<mochel:digitalimplant.org>:
  o I2C: class fixup for the ali1563 driver
  o I2C: Fix check for DEBUG in i2c-ali1563
  o I2C: Add ALi 1563 i2c driver
  o I2C: Add support for the ALi 1563 in the PCI IRQ routing code
  o I2C: Add ALi 1563 Device ID to pci_ids.h

Andrew Morton:
  o I2C: i2c-ali1563.c section fix

Greg Kroah-Hartman:
  o I2C: clean up out of order bus Makefile and Kconfig entries
  o I2C: minor bugfixes for the pcf8591.c driver and formatting cleanups

Jean Delvare:
  o I2C: Fix voltage rounding in asb100
  o I2C: No reset not limit init in via686a
  o I2C: Fix voltage rounding in lm80
  o I2C: make I2C chip drivers return -EINVAL on error
  o I2C: pwm support in w83781d.c
  o I2C: Error paths in it87 and via686a drivers
  o I2C: Rework memory allocation in i2c chip drivers
  o I2C: Enable changing fan_divs in lm80 driver
  o I2C: Refactor swap_bytes in i2c chip drivers
  o I2C: Discard pointless comment in via686a
  o I2C: Incorrect memset in eeprom.c
  o I2C: i2c documentation update (2/2)
  o I2C: i2c documentation update (1/2)
  o I2C: Prevent misdetections in adm1021 driver
  o I2C: Setting w83627hf fan_div preserves fan_min
  o I2C: adm1021 (probably) does something VERY,VERY BAD
  o I2C: initialize fan_mins in w83781d, asb100 and lm78
  o I2C: Discard out-of-date comment in adm1021 driver
  o I2C: w83781d fan_div code refactoring

Mark M. Hoffman:
  o I2C: fix asb100 bug

