Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVJ1VGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVJ1VGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbVJ1VGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:06:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:40935 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750764AbVJ1VGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:06:43 -0400
Date: Fri, 28 Oct 2005 14:06:07 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] I2C and hwmon patches for 2.6.14
Message-ID: <20051028210607.GA18845@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some i2c and hwmon patches.  They have all been in the past few
-mm releases with no problem.  They fix a number of different bugs, and
add a new driver.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing lists, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/hwmon/it87              |    8 
 Documentation/hwmon/lm90              |   47 +-
 Documentation/hwmon/smsc47b397        |    8 
 Documentation/hwmon/smsc47m1          |    7 
 Documentation/hwmon/sysfs-interface   |    3 
 Documentation/hwmon/via686a           |   17 
 Documentation/i2c/busses/i2c-i810     |    1 
 Documentation/i2c/busses/i2c-viapro   |   31 -
 Documentation/i2c/chips/x1205         |   38 +
 Documentation/i2c/functionality       |    7 
 Documentation/i2c/porting-clients     |    2 
 Documentation/i2c/writing-clients     |   27 -
 MAINTAINERS                           |    6 
 drivers/hwmon/adm1021.c               |    5 
 drivers/hwmon/adm1025.c               |    3 
 drivers/hwmon/adm1026.c               |   22 -
 drivers/hwmon/adm1031.c               |    3 
 drivers/hwmon/adm9240.c               |  465 +++++++++++-----------
 drivers/hwmon/asb100.c                |   11 
 drivers/hwmon/atxp1.c                 |    5 
 drivers/hwmon/ds1621.c                |    9 
 drivers/hwmon/fscher.c                |    3 
 drivers/hwmon/fscpos.c                |    5 
 drivers/hwmon/gl518sm.c               |    3 
 drivers/hwmon/gl520sm.c               |    3 
 drivers/hwmon/it87.c                  |   56 --
 drivers/hwmon/lm63.c                  |    3 
 drivers/hwmon/lm75.c                  |    3 
 drivers/hwmon/lm77.c                  |    3 
 drivers/hwmon/lm78.c                  |    6 
 drivers/hwmon/lm80.c                  |    5 
 drivers/hwmon/lm83.c                  |    3 
 drivers/hwmon/lm85.c                  |   15 
 drivers/hwmon/lm87.c                  |    3 
 drivers/hwmon/lm90.c                  |  183 +++++---
 drivers/hwmon/lm92.c                  |    3 
 drivers/hwmon/max1619.c               |    3 
 drivers/hwmon/pc87360.c               |    3 
 drivers/hwmon/sis5595.c               |    3 
 drivers/hwmon/smsc47b397.c            |   10 
 drivers/hwmon/smsc47m1.c              |   10 
 drivers/hwmon/via686a.c               |   28 -
 drivers/hwmon/w83627ehf.c             |   16 
 drivers/hwmon/w83627hf.c              |   32 -
 drivers/hwmon/w83781d.c               |   11 
 drivers/hwmon/w83792d.c               |    7 
 drivers/hwmon/w83l785ts.c             |   44 +-
 drivers/i2c/algos/i2c-algo-pca.c      |    2 
 drivers/i2c/algos/i2c-algo-sibyte.c   |    2 
 drivers/i2c/busses/Kconfig            |    3 
 drivers/i2c/busses/i2c-ali1535.c      |    7 
 drivers/i2c/busses/i2c-ali1563.c      |    7 
 drivers/i2c/busses/i2c-ali15x3.c      |   10 
 drivers/i2c/busses/i2c-amd756-s4882.c |    4 
 drivers/i2c/busses/i2c-amd756.c       |    8 
 drivers/i2c/busses/i2c-amd8111.c      |   16 
 drivers/i2c/busses/i2c-elektor.c      |  158 ++++---
 drivers/i2c/busses/i2c-hydra.c        |    1 
 drivers/i2c/busses/i2c-i801.c         |   65 ---
 drivers/i2c/busses/i2c-i810.c         |    2 
 drivers/i2c/busses/i2c-ibm_iic.c      |    3 
 drivers/i2c/busses/i2c-iop3xx.c       |    9 
 drivers/i2c/busses/i2c-isa.c          |    1 
 drivers/i2c/busses/i2c-ixp2000.c      |    8 
 drivers/i2c/busses/i2c-ixp4xx.c       |    8 
 drivers/i2c/busses/i2c-keywest.c      |    7 
 drivers/i2c/busses/i2c-mpc.c          |    4 
 drivers/i2c/busses/i2c-mv64xxx.c      |    6 
 drivers/i2c/busses/i2c-nforce2.c      |   18 
 drivers/i2c/busses/i2c-parport.c      |   11 
 drivers/i2c/busses/i2c-piix4.c        |   13 
 drivers/i2c/busses/i2c-pmac-smu.c     |    3 
 drivers/i2c/busses/i2c-prosavage.c    |   10 
 drivers/i2c/busses/i2c-s3c2410.c      |    2 
 drivers/i2c/busses/i2c-savage4.c      |    1 
 drivers/i2c/busses/i2c-sis5595.c      |   10 
 drivers/i2c/busses/i2c-sis630.c       |    9 
 drivers/i2c/busses/i2c-sis96x.c       |    8 
 drivers/i2c/busses/i2c-via.c          |    7 
 drivers/i2c/busses/i2c-viapro.c       |  311 +++++++--------
 drivers/i2c/busses/i2c-voodoo3.c      |    1 
 drivers/i2c/busses/scx200_acb.c       |    3 
 drivers/i2c/chips/Kconfig             |    9 
 drivers/i2c/chips/Makefile            |    1 
 drivers/i2c/chips/ds1337.c            |    3 
 drivers/i2c/chips/ds1374.c            |    7 
 drivers/i2c/chips/eeprom.c            |    9 
 drivers/i2c/chips/isp1301_omap.c      |    1 
 drivers/i2c/chips/m41t00.c            |    4 
 drivers/i2c/chips/max6875.c           |    6 
 drivers/i2c/chips/pca9539.c           |    3 
 drivers/i2c/chips/pcf8574.c           |    5 
 drivers/i2c/chips/pcf8591.c           |    5 
 drivers/i2c/chips/rtc8564.c           |    5 
 drivers/i2c/chips/tps65010.c          |    3 
 drivers/i2c/chips/x1205.c             |  698 ++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c                |  196 +++------
 drivers/i2c/i2c-dev.c                 |   17 
 include/linux/i2c-algo-bit.h          |    4 
 include/linux/i2c-algo-pca.h          |    2 
 include/linux/i2c-algo-pcf.h          |    4 
 include/linux/i2c-dev.h               |    2 
 include/linux/i2c-id.h                |    3 
 include/linux/i2c.h                   |   38 -
 include/linux/mod_devicetable.h       |    5 
 include/linux/x1205.h                 |   31 +
 include/media/ovcamchip.h             |   14 
 scripts/mod/file2alias.c              |   10 
 108 files changed, 1872 insertions(+), 1140 deletions(-)


Alessandro Zummo:
      i2c: New Xicor X1205 RTC driver

Ben Dooks:
      i2c: Static function fixes, 1 of 4
      i2c: Static function fixes, 4 of 4
      hwmon: Static function fixes, 3 of 4
      hwmon: Static function fixes, 2 of 4

Deepak Saxena:
      i2c: kzalloc conversion, ixp bus drivers
      i2c: kzalloc conversion, other drivers
      hwmon: kzalloc conversion

Grant Coady:
      hwmon: adm9240 driver update - cleanups
      hwmon: adm9240 driver update - dynamic sysfs

Greg KH:
      i2c-viapro: Cleanup ifdef usage

Greg Kroah-Hartman:
      I2C: remove devfs support from i2c-dev driver
      I2C: add i2c module alias for i2c drivers to use

Hideki Iwamoto:
      i2c: Fix union i2c_smbus_data definition
      i2c: Several PEC-related fixes in software SMBus emulation
      i2c: Fix I2C_FUNC_PROTOCOL_MANGLING documentation

Jean Delvare:
      hwmon: via686a: save 0.5k by long v[256] -> s16 v[256]
      hwmon: Discard explicit static initializations to 0
      i2c: Discard explicit static initializations to 0
      hwmon: w83l785ts converted to dynamic sysfs callbacks
      hwmon: Discard bogus comment about init setting limits
      hwmon: Do not forcibly enable via686a by default
      i2c: Reuse name strings in i2c bus drivers
      hwmon: adm9240 whitespace cleanups
      i2c: Minor i2c-amd8111 cleanup
      i2c-viapro: New maintainer
      i2c: Adjust i2c_probe() for busses without SMBUS_QUICK
      i2c-viapro: Coding style fixes
      hwmon: Minor w83l785ts optimization
      i2c-viapro: Refactor control outb
      i2c: Add missing i2c-ixp2000/4xx adapter name
      i2c-viapro: Update supported devices list
      i2c-viapro: Code cleanups
      i2c: Cleanup i2c-dev ioctl debug message
      i2c-viapro: Improve register dump
      i2c-viapro: Implement I2C Block transactions
      i2c: Fix misplaced i2c.h comment
      i2c: Cleanup i2c-i801 ifdefs
      i2c: Documentation fixes
      i2c: Drop out-of-date, colliding ioctl definitions
      hwmon: Drop legacy ISA address support from it87
      i2c: Drop useless CVS revision IDs
      i2c: Drop meaningless use of I2C_DF_NOTIFY in i2c_client structures
      i2c: Drop I2C_SMBUS_I2C_BLOCK_MAX
      i2c: Rename i2c-parport variable to avoid confusion
      hwmon: Drop useless w83627hf initialization step
      i2c: Drop unused per-i2c-algorithm adapter max
      hwmon: Missing class check in two hwmon drivers
      i2c: kzalloc cleanups, 1 of 2
      i2c: Documentation update
      i2c: kzalloc cleanups, 2 of 2
      i2c: i2c-i810 documentation update
      i2c: SMBus PEC support rewrite, 1 of 3
      i2c: ID redefinition cleanups
      i2c: Drop unused parport i2c IDs
      i2c: SMBus PEC support rewrite, 2 of 3
      i2c: SMBus PEC support rewrite, 3 of 3
      hwmon: Separate the lm90 register read function
      hwmon: lm90 documentation update
      hwmon: smsc47m1 documentation update
      hwmon: Add PEC support to the lm90 driver
      i2c: i2c-i801 PEC code cleanups

Laurent Riffard:
      Owner field additions to many i2c drivers, 2 of 5
      Owner field additions to many i2c drivers, 5 of 5
      Owner field additions to many i2c drivers, 4 of 5
      Owner field additions to many i2c drivers, 1 of 5
      Owner field additions to many i2c drivers, 3 of 5

Mark M. Hoffman:
      hwmon: New device ID for the smsc47b397 driver

Petr Vandrovec:
      hwmon: Fix w83627ehf/hf vs PNPACPI conflict (bug #4014)

Stig Telfer:
      i2c: Fix i2c-elektor on Alpha
      i2c: Big i2c-elektor cleanup

