Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVFVFhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVFVFhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVFVFgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:36:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:37273 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262756AbVFVFQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:16:57 -0400
Date: Tue, 21 Jun 2005 22:16:48 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: [GIT PATCH] I2C patches for 2.6.12
Message-ID: <20050622051648.GA28793@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of i2c patches that have been in the -mm tree for the
past few months.  There are a few new drivers in here, a bunch of
spelling fixes, lots of documentation updates, and a few other minor
things.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel and sensors mailing lists,
if anyone wants to see them.

thanks,

greg k-h


 Documentation/feature-removal-schedule.txt |   10 
 Documentation/i2c/busses/i2c-sis69x        |    2 
 Documentation/i2c/chips/adm1021            |  111 +++
 Documentation/i2c/chips/adm1025            |   51 +
 Documentation/i2c/chips/adm1026            |   93 ++
 Documentation/i2c/chips/adm1031            |   35 
 Documentation/i2c/chips/adm9240            |  177 ++++
 Documentation/i2c/chips/asb100             |   72 +
 Documentation/i2c/chips/ds1621             |  108 ++
 Documentation/i2c/chips/eeprom             |   96 ++
 Documentation/i2c/chips/fscher             |  169 ++++
 Documentation/i2c/chips/gl518sm            |   74 ++
 Documentation/i2c/chips/it87               |   96 ++
 Documentation/i2c/chips/lm63               |   57 +
 Documentation/i2c/chips/lm75               |   65 +
 Documentation/i2c/chips/lm77               |   22 
 Documentation/i2c/chips/lm78               |   82 ++
 Documentation/i2c/chips/lm80               |   56 +
 Documentation/i2c/chips/lm83               |   76 ++
 Documentation/i2c/chips/lm85               |  221 +++++
 Documentation/i2c/chips/lm87               |   73 +
 Documentation/i2c/chips/lm90               |  121 +++
 Documentation/i2c/chips/lm92               |   37 +
 Documentation/i2c/chips/max1619            |   29 
 Documentation/i2c/chips/max6875            |   54 +
 Documentation/i2c/chips/pc87360            |  189 +++++
 Documentation/i2c/chips/pca9539            |   47 +
 Documentation/i2c/chips/pcf8574            |   69 +
 Documentation/i2c/chips/pcf8591            |   90 ++
 Documentation/i2c/chips/sis5595            |  106 ++
 Documentation/i2c/chips/smsc47b397         |  168 ++++
 Documentation/i2c/chips/smsc47b397.txt     |  146 ---
 Documentation/i2c/chips/smsc47m1           |   52 +
 Documentation/i2c/chips/via686a            |   65 +
 Documentation/i2c/chips/w83627hf           |   66 +
 Documentation/i2c/chips/w83781d            |  428 +++++++++++
 Documentation/i2c/chips/w83l785ts          |   39 +
 Documentation/i2c/porting-clients          |    2 
 Documentation/i2c/userspace-tools          |   39 +
 Documentation/i2c/writing-clients          |   64 -
 MAINTAINERS                                |   16 
 arch/ppc/platforms/83xx/mpc834x_sys.c      |   20 
 drivers/acorn/char/pcf8583.c               |    3 
 drivers/i2c/algos/i2c-algo-pca.c           |    8 
 drivers/i2c/algos/i2c-algo-sibyte.c        |    1 
 drivers/i2c/busses/Kconfig                 |   34 
 drivers/i2c/busses/i2c-ali1535.c           |    1 
 drivers/i2c/busses/i2c-ali15x3.c           |    1 
 drivers/i2c/busses/i2c-amd756.c            |    1 
 drivers/i2c/busses/i2c-amd8111.c           |    1 
 drivers/i2c/busses/i2c-au1550.c            |    1 
 drivers/i2c/busses/i2c-elektor.c           |    1 
 drivers/i2c/busses/i2c-frodo.c             |    1 
 drivers/i2c/busses/i2c-i801.c              |    1 
 drivers/i2c/busses/i2c-i810.c              |    1 
 drivers/i2c/busses/i2c-ibm_iic.c           |    2 
 drivers/i2c/busses/i2c-ibm_iic.h           |    1 
 drivers/i2c/busses/i2c-iop3xx.c            |    2 
 drivers/i2c/busses/i2c-isa.c               |    1 
 drivers/i2c/busses/i2c-ite.c               |    1 
 drivers/i2c/busses/i2c-ixp2000.c           |    5 
 drivers/i2c/busses/i2c-ixp4xx.c            |    5 
 drivers/i2c/busses/i2c-keywest.c           |    1 
 drivers/i2c/busses/i2c-mpc.c               |   18 
 drivers/i2c/busses/i2c-nforce2.c           |    1 
 drivers/i2c/busses/i2c-parport-light.c     |    1 
 drivers/i2c/busses/i2c-parport.c           |    3 
 drivers/i2c/busses/i2c-pca-isa.c           |    1 
 drivers/i2c/busses/i2c-piix4.c             |    1 
 drivers/i2c/busses/i2c-prosavage.c         |    1 
 drivers/i2c/busses/i2c-rpx.c               |    1 
 drivers/i2c/busses/i2c-s3c2410.c           |    3 
 drivers/i2c/busses/i2c-savage4.c           |    1 
 drivers/i2c/busses/i2c-sibyte.c            |    1 
 drivers/i2c/busses/i2c-sis5595.c           |    1 
 drivers/i2c/busses/i2c-sis630.c            |    1 
 drivers/i2c/busses/i2c-sis96x.c            |    1 
 drivers/i2c/busses/i2c-stub.c              |    1 
 drivers/i2c/busses/i2c-via.c               |    1 
 drivers/i2c/busses/i2c-viapro.c            |    1 
 drivers/i2c/busses/i2c-voodoo3.c           |    1 
 drivers/i2c/busses/scx200_acb.c            |    1 
 drivers/i2c/chips/Kconfig                  |  117 ++-
 drivers/i2c/chips/Makefile                 |   10 
 drivers/i2c/chips/adm1021.c                |    9 
 drivers/i2c/chips/adm1025.c                |    5 
 drivers/i2c/chips/adm1026.c                |    8 
 drivers/i2c/chips/adm1031.c                |    2 
 drivers/i2c/chips/adm9240.c                |  829 +++++++++++++++++++++-
 drivers/i2c/chips/asb100.c                 |    5 
 drivers/i2c/chips/atxp1.c                  |  385 ++++++++++
 drivers/i2c/chips/ds1337.c                 |  107 +-
 drivers/i2c/chips/ds1374.c                 |  272 +++++++
 drivers/i2c/chips/ds1621.c                 |    4 
 drivers/i2c/chips/eeprom.c                 |    1 
 drivers/i2c/chips/fscher.c                 |    1 
 drivers/i2c/chips/gl518sm.c                |    1 
 drivers/i2c/chips/isp1301_omap.c           |    1 
 drivers/i2c/chips/it87.c                   |  398 +++++-----
 drivers/i2c/chips/lm63.c                   |  274 +++----
 drivers/i2c/chips/lm75.c                   |    1 
 drivers/i2c/chips/lm77.c                   |    1 
 drivers/i2c/chips/lm78.c                   |    5 
 drivers/i2c/chips/lm80.c                   |    1 
 drivers/i2c/chips/lm83.c                   |  162 ++--
 drivers/i2c/chips/lm85.c                   |    5 
 drivers/i2c/chips/lm87.c                   |    1 
 drivers/i2c/chips/lm90.c                   |  281 ++++---
 drivers/i2c/chips/m41t00.c                 |    3 
 drivers/i2c/chips/max1619.c                |    1 
 drivers/i2c/chips/max6875.c                |  473 ++++++++++++
 drivers/i2c/chips/pc87360.c                |    1 
 drivers/i2c/chips/pca9539.c                |  192 +++++
 drivers/i2c/chips/pcf8574.c                |    6 
 drivers/i2c/chips/rtc8564.c                |    4 
 drivers/i2c/chips/sis5595.c                |    1 
 drivers/i2c/chips/smsc47m1.c               |   10 
 drivers/i2c/chips/tps65010.c               | 1072 +++++++++++++++++++++++++++++
 drivers/i2c/chips/via686a.c                |  303 ++++----
 drivers/i2c/chips/w83627ehf.c              |  870 +++++++++++++++++++++++
 drivers/i2c/chips/w83627hf.c               |    2 
 drivers/i2c/chips/w83781d.c                |   78 --
 drivers/i2c/chips/w83l785ts.c              |    1 
 drivers/i2c/i2c-core.c                     |  102 --
 drivers/i2c/i2c-dev.c                      |    3 
 drivers/macintosh/therm_windtunnel.c       |    6 
 drivers/media/video/adv7170.c              |   16 
 drivers/media/video/adv7175.c              |   16 
 drivers/media/video/bt819.c                |   16 
 drivers/media/video/bt832.c                |    4 
 drivers/media/video/bt856.c                |   16 
 drivers/media/video/msp3400.c              |    1 
 drivers/media/video/saa5246a.c             |    1 
 drivers/media/video/saa5249.c              |    1 
 drivers/media/video/saa7110.c              |   16 
 drivers/media/video/saa7111.c              |   16 
 drivers/media/video/saa7114.c              |   16 
 drivers/media/video/saa7134/saa6752hs.c    |    1 
 drivers/media/video/saa7185.c              |   16 
 drivers/media/video/tda7432.c              |    1 
 drivers/media/video/tda9840.c              |    1 
 drivers/media/video/tda9875.c              |    1 
 drivers/media/video/tda9887.c              |    1 
 drivers/media/video/tea6415c.c             |    1 
 drivers/media/video/tea6420.c              |    1 
 drivers/media/video/tuner-3036.c           |   23 
 drivers/media/video/tuner-core.c           |   11 
 drivers/media/video/tvaudio.c              |    1 
 drivers/media/video/tveeprom.c             |    1 
 drivers/media/video/vpx3220.c              |   16 
 drivers/video/matrox/matroxfb_maven.c      |    1 
 include/asm-arm/arch-omap/tps65010.h       |   76 ++
 include/linux/hwmon-sysfs.h                |   36 
 include/linux/i2c-id.h                     |    1 
 include/linux/i2c-sysfs.h                  |   36 
 include/linux/i2c-vid.h                    |   12 
 include/linux/i2c.h                        |   12 
 157 files changed, 8574 insertions(+), 1514 deletions(-)

------------

Alexey Dobriyan:
  I2C: drivers/i2c/*: #include <linux/config.h> cleanup

Andrew Morton:
  I2C: fix ds1374 build

BGardner@Wabtec.com:
  max6875: new i2c device driver

bgardner@wabtec.com:
  I2C: add new pca9539 driver

Clemens Koller:
  I2C: rtc8564.c remove duplicate include

David Brownell:
  I2C: add i2c driver for TPS6501x

Dominik Hackl:
  I2C: include of jiffies.h for some i2c drivers

Grant Coady:
  I2C: add adm9240 driver documentation
  I2C: driver adm1021: remove die_code
  I2C: adm9240 driver cleanup
  I2C: remove <linux/delay.h> from via686a
  I2C: Setting w83627hf fan divisor 128 fails.
  I2C: sysfs names: rename to cpu0_vid, take 3
  I2C: add new hardware monitor driver: adm9240

Greg Kroah-Hartman:
  I2C: fix up ds1374.c driver so it will build.
  I2C: fix up some sysfs device attribute file parameters
  I2C: mark all functions static in atxp1 driver

Jean Delvare:
  I2C: w83781d: remove non-i2c sensor chips
  I2C: rename i2c-sysfs.h to hwmon-sysfs.h
  I2C: lm63 uses new sysfs callbacks
  I2C: drivers/i2c/chips/it87.c: use dynamic sysfs callbacks
  I2C: lm83 uses new sysfs callbacks
  I2C: pcf8574 driver cleanup
  I2C: lm90 uses new sysfs callbacks
  I2C: Sensors mailing list has moved
  I2C: Kill another macro abuse in via686a
  I2C: Coding style cleanups to via686a
  I2C: chips/Kconfig corrections
  I2C: Kill common macro abuse in chip drivers
  I2C: Remove redundancy from i2c-core.c
  I2C: Add support for the LPC47M15x and LPC47M192 chips to smsc47m1
  I2C: Fix bugs in the new w83627ehf driver
  I2C: New hardware monitoring driver: w83627ehf
  I2C: #include <linux/config.h> cleanup
  I2C: Merge unused address lists in some video drivers
  I2C: Kill address ranges in non-sensors i2c chip drivers

Kumar Gala:
  I2C: Allow for sharing of the interrupt line for i2c-mpc.c

Ladislav Michl:
  ds1337: export ds1337_do_command
  ds1337 driver works also with ds1339 chip
  I2C: ds1337: search by bus number
  I2C: ds1337 3/4
  I2C: ds1337 2/4
  I2C: ds1337: Make time format consistent with other RTC drivers
  I2C: ds1337: i2c_transfer() checking
  I2C: ds1337 1/4

Randy Vinson:
  I2C: Add support for Maxim/Dallas DS1374 Real-Time Clock Chip (1/2)
  I2C: Add support for Maxim/Dallas DS1374 Real-Time Clock Chip (2/2)

Rudolf Marek:
  I2C: documentation update 3/3
  I2C: documentation update 2/3
  I2C: KConfig update - some EXPERIMENTAL removal
  I2C: documentation update 1/3

Sebastian Witt:
  I2C: add new atxp1 driver
  I2C: i2c-vid.h: Support for VID to reg conversion

Steven Cole:
  Spelling fixes for drivers/i2c.

Sylvain Munaut:
  i2c: Race fix for i2c-mpc.c

Tobias Klauser:
  I2C: Spelling fixes for drivers/i2c/i2c-dev.c
  I2C: Spelling fixes for drivers/i2c/i2c-core.c
  I2C: Spelling fixes for drivers/i2c/busses/i2c-parport.c
  I2C: Spelling fixes for drivers/i2c/algos/i2c-algo-pca.c

