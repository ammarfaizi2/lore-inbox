Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUJTAmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUJTAmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268036AbUJTAkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:40:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:54450 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265044AbUJTARK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:17:10 -0400
Date: Tue, 19 Oct 2004 17:16:04 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] I2C update for 2.6.9
Message-ID: <20041020001603.GA11393@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver fixes and updates for 2.6.9.  There is a new
chip and a new bus driver, as well as a bunch of minor fixes.  The
majority of these patches have been in the past few -mm releases.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/i2c-stub         |   33 +
 Documentation/i2c/sysfs-interface  |   32 +
 Documentation/i2c/writing-clients  |   26 -
 drivers/i2c/algos/i2c-algo-ite.c   |    8 
 drivers/i2c/busses/Kconfig         |   34 +
 drivers/i2c/busses/Makefile        |    2 
 drivers/i2c/busses/i2c-ali1535.c   |    4 
 drivers/i2c/busses/i2c-ali1563.c   |    4 
 drivers/i2c/busses/i2c-ali15x3.c   |    4 
 drivers/i2c/busses/i2c-amd756.c    |   50 +-
 drivers/i2c/busses/i2c-amd8111.c   |    4 
 drivers/i2c/busses/i2c-elektor.c   |    8 
 drivers/i2c/busses/i2c-hydra.c     |    4 
 drivers/i2c/busses/i2c-i801.c      |    4 
 drivers/i2c/busses/i2c-i810.c      |    6 
 drivers/i2c/busses/i2c-ibm_iic.c   |    4 
 drivers/i2c/busses/i2c-mpc.c       |    7 
 drivers/i2c/busses/i2c-nforce2.c   |    5 
 drivers/i2c/busses/i2c-piix4.c     |    4 
 drivers/i2c/busses/i2c-prosavage.c |   14 
 drivers/i2c/busses/i2c-s3c2410.c   |  877 +++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-savage4.c   |    6 
 drivers/i2c/busses/i2c-sis5595.c   |    4 
 drivers/i2c/busses/i2c-sis630.c    |    4 
 drivers/i2c/busses/i2c-sis96x.c    |    4 
 drivers/i2c/busses/i2c-stub.c      |  125 +++++
 drivers/i2c/busses/i2c-via.c       |    4 
 drivers/i2c/busses/i2c-viapro.c    |    4 
 drivers/i2c/busses/i2c-voodoo3.c   |    6 
 drivers/i2c/busses/scx200_acb.c    |   13 
 drivers/i2c/chips/Kconfig          |   11 
 drivers/i2c/chips/Makefile         |    1 
 drivers/i2c/chips/adm1021.c        |    2 
 drivers/i2c/chips/adm1025.c        |   16 
 drivers/i2c/chips/adm1031.c        |   48 +-
 drivers/i2c/chips/asb100.c         |   18 
 drivers/i2c/chips/ds1621.c         |    2 
 drivers/i2c/chips/eeprom.c         |    2 
 drivers/i2c/chips/fscher.c         |    2 
 drivers/i2c/chips/gl518sm.c        |    8 
 drivers/i2c/chips/it87.c           |   50 +-
 drivers/i2c/chips/lm75.c           |    2 
 drivers/i2c/chips/lm77.c           |    2 
 drivers/i2c/chips/lm78.c           |   40 -
 drivers/i2c/chips/lm80.c           |    7 
 drivers/i2c/chips/lm83.c           |   22 
 drivers/i2c/chips/lm85.c           |   53 +-
 drivers/i2c/chips/lm87.c           |  814 ++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/lm90.c           |   49 +-
 drivers/i2c/chips/max1619.c        |    5 
 drivers/i2c/chips/pcf8574.c        |    2 
 drivers/i2c/chips/pcf8591.c        |    2 
 drivers/i2c/chips/smsc47m1.c       |   58 +-
 drivers/i2c/chips/via686a.c        |   32 -
 drivers/i2c/chips/w83627hf.c       |   22 
 drivers/i2c/chips/w83781d.c        |   76 +--
 drivers/i2c/i2c-core.c             |   20 
 drivers/w1/Makefile                |    4 
 drivers/w1/dscore.c                |   13 
 drivers/w1/w1.c                    |   29 -
 drivers/w1/w1.h                    |    2 
 drivers/w1/w1_family.c             |   11 
 drivers/w1/w1_int.c                |   17 
 drivers/w1/w1_int.h                |    2 
 drivers/w1/w1_netlink.c            |    8 
 drivers/w1/w1_therm.c              |   71 +-
 include/linux/i2c-vid.h            |   36 +
 67 files changed, 2476 insertions(+), 387 deletions(-)
-----

<ben-linux:fluff.org>:
  o I2C: S3C2410 I2C Bus driver

Evgeniy Polyakov:
  o w1: schedule_timeout() issues
  o w1_therm: more precise temperature calculation
  o W1: let W1 select NET
  o w1: Added slave->ttl - time to live for the registered slave

Gerd Knorr:
  o I2C: i2c bus power management support

Greg Kroah-Hartman:
  o I2C: convert from pci_module_init to pci_register_driver for all i2c drivers
  o I2C: convert scx200_acb driver to not use pci_find_device
  o I2C: change i2c-elektor.c driver from using pci_find_device()
  o I2C: fix up __iomem marking for i2c bus drivers

Jean Delvare:
  o I2C: lm87 driver ported to Linux 2.6
  o I2C: Clean up i2c-amd756 and i2c-prosavage messages
  o I2C: Fix amd756 name
  o I2C: Update Kconfig for AMD bus drivers
  o I2C: Fourth auto-fan control interface proposal
  o I2C: Spare 1 byte in lm90 driver
  o I2C: Store lm83 and lm90 temperatures in signed
  o I2C: Cleanup lm78 init
  o I2C: Update Documentation/i2c/writing-clients
  o I2C: More verbose debug in w83781d detection
  o I2C: Fix macro calls in chip drivers
  o I2C: Do not init global variables to 0

Margit Schubert-While:
  o I2C: minor lm85 fix

Mark M. Hoffman:
  o i2c: kill some sensors driver macro abuse
  o i2c: sensors chip driver updates
  o i2c: Add Intel VRD 10.0 and AMD Opteron VID support
  o I2C/SMBus stub for driver testing

Matthieu Castet:
  o use of MODULE_DEVICE_TABLE in i2c busses driver

Nishanth Aravamudan:
  o I2C: replace schedule_timeout() with msleep_interruptible() in i2c-ibm_iic.c
  o i2c/i2c-mpc: replace schedule_timeout() with msleep_interruptible()
  o i2c-algo-ite: remove iic_sleep()

Rudolf Marek:
  o I2C: fix it8712 detection

