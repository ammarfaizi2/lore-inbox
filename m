Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVAHGx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVAHGx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVAHGvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:51:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:8326 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261916AbVAHFsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:41 -0500
Date: Fri, 7 Jan 2005 21:38:49 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] I2C patches for 2.6.10
Message-ID: <20050108053849.GA8065@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes and updates for 2.6.10.  There are a few
new i2c drivers in here, and a number of bugfixes.  Almost all of these
patches have been in the past few -mm releases.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/i2c-old-porting      |  626 ---------------------------------
 Documentation/i2c/chips/smsc47b397.txt |  146 +++++++
 Documentation/i2c/i2c-stub             |    9 
 Documentation/w1/w1.generic            |   19 +
 drivers/i2c/algos/Kconfig              |   15 
 drivers/i2c/algos/Makefile             |    2 
 drivers/i2c/algos/i2c-algo-bit.c       |    4 
 drivers/i2c/algos/i2c-algo-pca.c       |    4 
 drivers/i2c/algos/i2c-algo-pcf.c       |    4 
 drivers/i2c/algos/i2c-algo-sgi.c       |  189 +++++++++
 drivers/i2c/algos/i2c-algo-sibyte.c    |  231 ++++++++++++
 drivers/i2c/busses/Kconfig             |   16 
 drivers/i2c/busses/Makefile            |    1 
 drivers/i2c/busses/i2c-ali1535.c       |    7 
 drivers/i2c/busses/i2c-ali1563.c       |   15 
 drivers/i2c/busses/i2c-ali15x3.c       |    7 
 drivers/i2c/busses/i2c-amd756.c        |   15 
 drivers/i2c/busses/i2c-amd8111.c       |    2 
 drivers/i2c/busses/i2c-hydra.c         |    7 
 drivers/i2c/busses/i2c-i801.c          |   56 --
 drivers/i2c/busses/i2c-iop3xx.c        |  545 ++++++++++++++--------------
 drivers/i2c/busses/i2c-iop3xx.h        |  111 ++---
 drivers/i2c/busses/i2c-nforce2.c       |   15 
 drivers/i2c/busses/i2c-piix4.c         |   54 --
 drivers/i2c/busses/i2c-prosavage.c     |    7 
 drivers/i2c/busses/i2c-sibyte.c        |   71 +++
 drivers/i2c/busses/i2c-sis96x.c        |   12 
 drivers/i2c/busses/i2c-stub.c          |   22 +
 drivers/i2c/busses/i2c-viapro.c        |   72 ---
 drivers/i2c/chips/Kconfig              |   12 
 drivers/i2c/chips/Makefile             |    1 
 drivers/i2c/chips/asb100.c             |    3 
 drivers/i2c/chips/eeprom.c             |   19 -
 drivers/i2c/chips/fscher.c             |   11 
 drivers/i2c/chips/isp1301_omap.c       |    9 
 drivers/i2c/chips/it87.c               |  149 ++++++-
 drivers/i2c/chips/lm78.c               |    2 
 drivers/i2c/chips/lm90.c               |   28 +
 drivers/i2c/chips/pc87360.c            |    3 
 drivers/i2c/chips/smsc47b397.c         |  353 ++++++++++++++++++
 drivers/i2c/chips/smsc47m1.c           |    2 
 drivers/i2c/chips/via686a.c            |    2 
 drivers/i2c/chips/w83627hf.c           |   45 +-
 drivers/i2c/chips/w83781d.c            |    3 
 drivers/i2c/i2c-sensor-vid.c           |    5 
 include/linux/i2c-algo-sgi.h           |   27 +
 include/linux/i2c-algo-sibyte.h        |   33 +
 include/linux/i2c-id.h                 |   16 
 include/linux/pci_ids.h                |   16 
 49 files changed, 1772 insertions(+), 1251 deletions(-)
-----

<sjhill:realitydiluted.com>:
  o I2C patch from MIPS tree

David Brownell:
  o I2C: minor isp1301_omap tweaks

Deepak Saxena:
  o Update IOP3xx I2C bus driver

Domen Puncer:
  o it87: /proc/ioports fix

Evgeniy Polyakov:
  o w1: Documentation bits for generic w1 behaviour

Ian Campbell:
  o I2C: i2c-algo-bit should support I2C_FUNC_I2C

Jean Delvare:
  o I2C: Update fscher pwm functionality
  o I2C: Add byte commands to i2c-stub
  o I2C: Fix MAX6657/8/9 detection in lm90
  o I2C: Improve VID code for the W83627THF
  o I2C: Add secondary Super-I/O address support to
  o I2C: Remove checksum code in eeprom driver
  o I2C: Use PCI_DEVICE in bus drivers
  o I2C: Discard old driver porting documentation
  o I2C: i2c-nforce2 supports the nForce3 250Gb
  o I2C: i2c-algo-bit should support I2C_FUNC_I2C
  o I2C: use chip driver name to request regions

Jonas Munsin:
  o I2C: it87.c update

Ladislav Michl:
  o I2C: let I2C_ALGO_SGI depend on MIPS

Mark M. Hoffman:
  o I2C: add new sensors driver: SMSC LPC47B397-NC
  o I2C: probe fewer addresses for asb100 (sensors) driver

Randy Dunlap:
  o i2c-ali1563: fix init & exit section usage

Rudolf Marek:
  o I2C: vid version detection fix

