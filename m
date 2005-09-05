Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbVIEVpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbVIEVpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbVIEVpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:45:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:12742 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932673AbVIEVoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:44:55 -0400
Date: Mon, 5 Sep 2005 14:44:32 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] I2C patches for 2.6.13
Message-ID: <20050905214431.GA5897@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of I2C and HWMON patches that have been in the -mm tree
for a while.  There is a bunch of hwmon and i2c driver split up changes,
and some i2c api reworks to reduce the size of the structures, and the
size of the kernel code (which accounts for all of the small changes to
all of the sensor and i2c drivers across the whole kenel tree.)  There
are also a few new drivers added to the tree.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/hwmon/lm78                          |    7 
 Documentation/hwmon/w83792d                       |  174 ++
 Documentation/i2c/chips/max6875                   |   98 -
 Documentation/i2c/functionality                   |    2 
 Documentation/i2c/porting-clients                 |   25 
 Documentation/i2c/writing-clients                 |  144 -
 MAINTAINERS                                       |    9 
 drivers/hwmon/Kconfig                             |   74 
 drivers/hwmon/Makefile                            |    4 
 drivers/hwmon/adm1021.c                           |   35 
 drivers/hwmon/adm1025.c                           |   31 
 drivers/hwmon/adm1026.c                           |   27 
 drivers/hwmon/adm1031.c                           |   24 
 drivers/hwmon/adm9240.c                           |   33 
 drivers/hwmon/asb100.c                            |   56 
 drivers/hwmon/atxp1.c                             |   26 
 drivers/hwmon/ds1621.c                            |   29 
 drivers/hwmon/fscher.c                            |   27 
 drivers/hwmon/fscpos.c                            |   27 
 drivers/hwmon/gl518sm.c                           |   28 
 drivers/hwmon/gl520sm.c                           |   31 
 drivers/hwmon/hwmon-vid.c                         |  211 ++
 drivers/hwmon/hwmon.c                             |   98 +
 drivers/hwmon/it87.c                              |   82 -
 drivers/hwmon/lm63.c                              |   27 
 drivers/hwmon/lm75.c                              |   41 
 drivers/hwmon/lm75.h                              |    2 
 drivers/hwmon/lm77.c                              |   24 
 drivers/hwmon/lm78.c                              |   90 -
 drivers/hwmon/lm80.c                              |   27 
 drivers/hwmon/lm83.c                              |   27 
 drivers/hwmon/lm85.c                              |   39 
 drivers/hwmon/lm87.c                              |   31 
 drivers/hwmon/lm90.c                              |   27 
 drivers/hwmon/lm92.c                              |   28 
 drivers/hwmon/max1619.c                           |   28 
 drivers/hwmon/pc87360.c                           | 1006 ++++++-------
 drivers/hwmon/sis5595.c                           |   70 
 drivers/hwmon/smsc47b397.c                        |   74 
 drivers/hwmon/smsc47m1.c                          |   72 
 drivers/hwmon/via686a.c                           |   76 
 drivers/hwmon/w83627ehf.c                         |   64 
 drivers/hwmon/w83627hf.c                          |   82 -
 drivers/hwmon/w83781d.c                           |   94 -
 drivers/hwmon/w83792d.c                           | 1677 +++++++++++++++++++++-
 drivers/hwmon/w83l785ts.c                         |   27 
 drivers/i2c/Makefile                              |    6 
 drivers/i2c/algos/i2c-algo-bit.c                  |    6 
 drivers/i2c/algos/i2c-algo-ite.c                  |    6 
 drivers/i2c/algos/i2c-algo-pca.c                  |   18 
 drivers/i2c/algos/i2c-algo-pcf.c                  |    6 
 drivers/i2c/algos/i2c-algo-sgi.c                  |    7 
 drivers/i2c/algos/i2c-algo-sibyte.c               |    6 
 drivers/i2c/busses/Kconfig                        |    8 
 drivers/i2c/busses/i2c-ali1535.c                  |    2 
 drivers/i2c/busses/i2c-ali1563.c                  |    2 
 drivers/i2c/busses/i2c-ali15x3.c                  |    2 
 drivers/i2c/busses/i2c-amd756.c                   |    2 
 drivers/i2c/busses/i2c-amd8111.c                  |    2 
 drivers/i2c/busses/i2c-au1550.c                   |    2 
 drivers/i2c/busses/i2c-i801.c                     |    2 
 drivers/i2c/busses/i2c-ibm_iic.c                  |    6 
 drivers/i2c/busses/i2c-iop3xx.c                   |    2 
 drivers/i2c/busses/i2c-isa.c                      |  163 +-
 drivers/i2c/busses/i2c-keywest.c                  |   15 
 drivers/i2c/busses/i2c-mpc.c                      |    4 
 drivers/i2c/busses/i2c-mv64xxx.c                  |   12 
 drivers/i2c/busses/i2c-nforce2.c                  |   33 
 drivers/i2c/busses/i2c-piix4.c                    |    2 
 drivers/i2c/busses/i2c-s3c2410.c                  |    1 
 drivers/i2c/busses/i2c-sis5595.c                  |    2 
 drivers/i2c/busses/i2c-sis630.c                   |    2 
 drivers/i2c/busses/i2c-sis96x.c                   |    2 
 drivers/i2c/busses/i2c-stub.c                     |    2 
 drivers/i2c/busses/i2c-viapro.c                   |    2 
 drivers/i2c/busses/scx200_acb.c                   |    4 
 drivers/i2c/chips/Kconfig                         |   10 
 drivers/i2c/chips/ds1337.c                        |   11 
 drivers/i2c/chips/ds1374.c                        |    3 
 drivers/i2c/chips/eeprom.c                        |   17 
 drivers/i2c/chips/m41t00.c                        |    3 
 drivers/i2c/chips/max6875.c                       |  478 +-----
 drivers/i2c/chips/pca9539.c                       |   12 
 drivers/i2c/chips/pcf8574.c                       |   13 
 drivers/i2c/chips/pcf8591.c                       |   13 
 drivers/i2c/chips/rtc8564.c                       |    1 
 drivers/i2c/i2c-core.c                            |  310 ++--
 drivers/i2c/i2c-dev.c                             |    5 
 drivers/i2c/i2c-sensor-detect.c                   |  185 --
 drivers/i2c/i2c-sensor-vid.c                      |  108 -
 drivers/ieee1394/pcilynx.c                        |   20 
 drivers/media/common/saa7146_i2c.c                |    4 
 drivers/media/dvb/b2c2/flexcop-i2c.c              |    3 
 drivers/media/dvb/dvb-usb/cxusb.c                 |    2 
 drivers/media/dvb/dvb-usb/dibusb-common.c         |    2 
 drivers/media/dvb/dvb-usb/digitv.c                |    2 
 drivers/media/dvb/dvb-usb/dvb-usb-i2c.c           |    1 
 drivers/media/dvb/pluto2/pluto2.c                 |    1 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    3 
 drivers/media/video/adv7170.c                     |    1 
 drivers/media/video/adv7175.c                     |    1 
 drivers/media/video/bt819.c                       |    1 
 drivers/media/video/bt832.c                       |    4 
 drivers/media/video/bt856.c                       |    1 
 drivers/media/video/bttv-i2c.c                    |   12 
 drivers/media/video/cx88/cx88-i2c.c               |    8 
 drivers/media/video/ir-kbd-i2c.c                  |    6 
 drivers/media/video/msp3400.c                     |    4 
 drivers/media/video/ovcamchip/ov6x20.c            |    6 
 drivers/media/video/ovcamchip/ov6x30.c            |    4 
 drivers/media/video/ovcamchip/ovcamchip_core.c    |   14 
 drivers/media/video/saa7110.c                     |    1 
 drivers/media/video/saa7111.c                     |    1 
 drivers/media/video/saa7114.c                     |    1 
 drivers/media/video/saa7134/saa6752hs.c           |    2 
 drivers/media/video/saa7134/saa7134-i2c.c         |   10 
 drivers/media/video/saa7185.c                     |    1 
 drivers/media/video/tda7432.c                     |    4 
 drivers/media/video/tda9840.c                     |    4 
 drivers/media/video/tda9875.c                     |    4 
 drivers/media/video/tda9887.c                     |    8 
 drivers/media/video/tea6415c.c                    |    4 
 drivers/media/video/tea6420.c                     |    4 
 drivers/media/video/tuner-3036.c                  |    3 
 drivers/media/video/tuner-core.c                  |    2 
 drivers/media/video/tvaudio.c                     |   51 
 drivers/media/video/tveeprom.c                    |    2 
 drivers/media/video/tvmixer.c                     |   14 
 drivers/media/video/vpx3220.c                     |    1 
 drivers/media/video/zoran_card.c                  |    2 
 drivers/usb/media/w9968cf.c                       |   12 
 drivers/video/aty/radeon_i2c.c                    |    2 
 drivers/video/matrox/matroxfb_maven.c             |    2 
 drivers/video/nvidia/nv_i2c.c                     |    3 
 drivers/video/riva/rivafb-i2c.c                   |    3 
 drivers/video/savage/savagefb-i2c.c               |    3 
 include/linux/hwmon-sysfs.h                       |   15 
 include/linux/hwmon-vid.h                         |  197 +-
 include/linux/hwmon.h                             |   35 
 include/linux/i2c-id.h                            |  192 --
 include/linux/i2c-isa.h                           |   44 
 include/linux/i2c-sensor.h                        |  421 +----
 include/linux/i2c-vid.h                           |  111 -
 include/linux/i2c.h                               |  210 ++
 include/media/id.h                                |    5 
 145 files changed, 4794 insertions(+), 3113 deletions(-)


bgardner@wabtec.com:
  I2C: update max6875 documentation
  I2C: simplify max6875 driver
  I2C: max6875 documentation cleanup
  I2C: add kobj_to_i2c_client
  I2C: max6875 code cleanup

Greg Kroah-Hartman:
  I2C: fix max6875 build error

Hans-Frieder Vogt:
  I2C: cleanup of i2c-nforce2

Ian Campbell:
  I2C: i2c-algo-pca -- gracefully handle a busy bus

Jean Delvare:
  hwmon: kill client name lm78-j
  hwmon: soften lm75 initialization
  hwmon: Document on the W83627EHG chip
  I2C: Separate non-i2c hwmon drivers from i2c-core (2/9)
  I2C: Separate non-i2c hwmon drivers from i2c-core (1/9)
  I2C: Separate non-i2c hwmon drivers from i2c-core (3/9)
  I2C: Separate non-i2c hwmon drivers from i2c-core (5/9)
  I2C: Separate non-i2c hwmon drivers from i2c-core (4/9)
  I2C: Separate non-i2c hwmon drivers from i2c-core (6/9)
  I2C: Separate non-i2c hwmon drivers from i2c-core (8/9)
  I2C: Separate non-i2c hwmon drivers from i2c-core (7/9)
  I2C: Separate non-i2c hwmon drivers from i2c-core (9/9)
  I2C: refactor message in i2c_detach_client
  I2C: inline i2c_adapter_id
  hwmon: tag super-i/o find functions __init
  I2C: fix typo in documentation
  I2C: Improve core debugging messages
  hwmon: move SENSORS_LIMIT to hwmon.h
  hwmon: lm85: trivial cleanups
  hwmon: hwmon vs i2c, second round (01/11)
  hwmon: hwmon vs i2c, second round (02/11)
  hwmon: hwmon vs i2c, second round (03/11)
  hwmon: hwmon vs i2c, second round (04/11)
  hwmon: hwmon vs i2c, second round (05/11)
  hwmon: hwmon vs i2c, second round (06/11)
  hwmon: hwmon vs i2c, second round (07/11)
  hwmon: hwmon vs i2c, second round (08/11)
  hwmon: hwmon vs i2c, second round (10/11)
  hwmon: hwmon vs i2c, second round (09/11)
  hwmon: hwmon vs i2c, second round (11/11)
  I2C: Centralize 24RF08 corruption prevention
  I2C: Rewrite i2c_probe
  I2C: Kill i2c_algorithm.name (1/7)
  I2C: Kill i2c_algorithm.id (2/7)
  I2C: Kill i2c_algorithm.id (4/7)
  I2C: Kill i2c_algorithm.id (3/7)
  I2C: Kill i2c_algorithm.id (5/7)
  I2C: Kill i2c_algorithm.id (6/7)
  I2C: Outdated i2c_adapter comment
  I2C: Kill i2c_algorithm.id (7/7)
  hwmon: separate maintainer
  I2C: Drop I2C_DEVNAME and i2c_clientname
  I2C: Drop debug eeprom dump code in pcilynx
  I2C: Drop probe parameter of i2c-keywest
  i2c: bug fix for busses/i2c-mv64xxx.c
  I2C: Fix sgi_xfer return value
  I2C: Drop the I2C_ACK_TEST ioctl

Jim Cromie:
  hwmon: (1/3) pc87360 driver update
  hwmon: (3/3) pc87360 driver update
  hwmon: (2/3) pc87360 driver update

Mark A. Greer:
  i2c: chips/ds1374.c fixup
  i2c: chips/m41t00.c fixup

Mark M. Hoffman:
  I2C hwmon: hwmon sysfs class
  I2C hwmon: add hwmon sysfs class to drivers

Rudolf Marek:
  I2C: W83792D driver 1/3
  I2C: W83792D add hwmon class register 2/3
  I2C: W83792D documentation 3/3
  hwmon: VID table update

