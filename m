Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265382AbTL3WDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbTL3WDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:03:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:42688 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265382AbTL3WCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:02:54 -0500
Date: Tue, 30 Dec 2003 14:02:57 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver fixes for 2.6.0
Message-ID: <20031230220257.GA2408@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes and updates for 2.6.0.  There are a
number of bug fixes here, a big documentation update, and a new i2c chip
driver was added.

Please pull from:  bk://linuxusb.bkbits.net/i2c-devel-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/i2c-velleman    |   16 -
 Documentation/i2c/porting-clients |  121 ++++++++++
 Documentation/i2c/summary         |    2 
 Documentation/i2c/sysfs-interface |   33 +-
 Documentation/i2c/writing-clients |   57 ----
 drivers/i2c/algos/i2c-algo-bit.c  |   96 ++++----
 drivers/i2c/algos/i2c-algo-ite.c  |   36 ---
 drivers/i2c/busses/Kconfig        |   12 -
 drivers/i2c/busses/i2c-amd756.c   |   35 +-
 drivers/i2c/busses/i2c-amd8111.c  |    2 
 drivers/i2c/busses/i2c-ibm_iic.c  |   34 --
 drivers/i2c/busses/i2c-piix4.c    |   39 ++-
 drivers/i2c/busses/i2c-savage4.c  |   12 -
 drivers/i2c/busses/i2c-velleman.c |    2 
 drivers/i2c/busses/i2c-viapro.c   |    8 
 drivers/i2c/chips/Kconfig         |   27 +-
 drivers/i2c/chips/Makefile        |    1 
 drivers/i2c/chips/it87.c          |   11 
 drivers/i2c/chips/lm75.c          |   40 ---
 drivers/i2c/chips/lm75.h          |   49 ++++
 drivers/i2c/chips/lm78.c          |    4 
 drivers/i2c/chips/lm83.c          |  450 +++++++++++++++++++++++++++++++++++---
 drivers/i2c/chips/via686a.c       |   46 +--
 drivers/i2c/chips/w83781d.c       |  221 ++----------------
 drivers/pcmcia/sa1100_stork.c     |    1 
 include/linux/i2c-id.h            |    2 
 26 files changed, 845 insertions(+), 512 deletions(-)
-----

Greg Kroah-Hartman:
  o I2C: removed #include <linux/i2c.h> from sa1100_stork.c as it's not needed

Jean Delvare:
  o I2C: lm83 driver updates
  o I2C: velleman typo
  o I2C: Fix SCx200 dependancies
  o I2C: remove bus scan logic from i2c chip drivers
  o I2C: restore support for AMD8111 in i2c-amd756 driver
  o I2C: fix i2c-amd8111 driver
  o I2C: it87 and via686a alarms
  o I2C: add KT600 support to i2c-viapro driver
  o I2C: add Serverworks CSB6 support to i2c-piix4
  o I2C: fix author of i2c-savage4.c driver
  o I2C: make I2C chipset drivers use temp_hyst[1-3]
  o I2C: sysfs interface documentation
  o I2C: Fix i2c-algo-bit for adapers that cannot read SCL back
  o I2C: i2c documentation (2 of 2)
  o I2C: i2c documentation (1 of 2)
  o I2C: Add lm83 chip driver

Mark D. Studebaker:
  o I2C: fix amd756 byte writes

Mark M. Hoffman:
  o I2C: lm75 chip driver conversion routine fixes
  o I2C: remove initialization of limits by lm75 driver
  o I2C: remove initialization of limits by w83781d driver
  o I2C: improve chip detection in w83781d.c driver

Tom Rini:
  o I2C: make i2c-piix4 fix optional

