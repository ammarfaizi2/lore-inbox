Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWAFWHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWAFWHr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWAFWHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:07:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:41867 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932577AbWAFWHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:07:46 -0500
Date: Fri, 6 Jan 2006 14:06:42 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] I2C and hwmon patches for 2.6.15
Message-ID: <20060106220642.GA19212@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some i2c and hwmon patches.  They add a new hwmon driver and
fix a number of different bugs.  All of these have been in tha last few
-mm releases.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/feature-removal-schedule.txt     |    9 
 Documentation/hwmon/w83627hf                   |   19 
 Documentation/i2c/busses/i2c-nforce2           |    3 
 Documentation/i2c/busses/i2c-parport           |    1 
 Documentation/i2c/porting-clients              |   96 +-
 Documentation/i2c/writing-clients              |   22 
 MAINTAINERS                                    |    6 
 arch/arm/mach-pxa/akita-ioexp.c                |    9 
 drivers/acorn/char/pcf8583.c                   |    7 
 drivers/hwmon/Kconfig                          |   12 
 drivers/hwmon/Makefile                         |    1 
 drivers/hwmon/adm1021.c                        |    8 
 drivers/hwmon/adm1025.c                        |   12 
 drivers/hwmon/adm1026.c                        |   12 
 drivers/hwmon/adm1031.c                        |    8 
 drivers/hwmon/adm9240.c                        |    8 
 drivers/hwmon/asb100.c                         |    8 
 drivers/hwmon/atxp1.c                          |    8 
 drivers/hwmon/ds1621.c                         |    8 
 drivers/hwmon/fscher.c                         |    8 
 drivers/hwmon/fscpos.c                         |    8 
 drivers/hwmon/gl518sm.c                        |    8 
 drivers/hwmon/gl520sm.c                        |    8 
 drivers/hwmon/hwmon-vid.c                      |   69 +
 drivers/hwmon/it87.c                           |   22 
 drivers/hwmon/lm63.c                           |    8 
 drivers/hwmon/lm75.c                           |    8 
 drivers/hwmon/lm77.c                           |    8 
 drivers/hwmon/lm78.c                           |   17 
 drivers/hwmon/lm80.c                           |    8 
 drivers/hwmon/lm83.c                           |    8 
 drivers/hwmon/lm85.c                           |   52 +
 drivers/hwmon/lm87.c                           |    8 
 drivers/hwmon/lm90.c                           |    8 
 drivers/hwmon/lm92.c                           |    8 
 drivers/hwmon/max1619.c                        |    8 
 drivers/hwmon/pc87360.c                        |    9 
 drivers/hwmon/sis5595.c                        |   10 
 drivers/hwmon/smsc47b397.c                     |   10 
 drivers/hwmon/smsc47m1.c                       |    9 
 drivers/hwmon/via686a.c                        |   10 
 drivers/hwmon/vt8231.c                         |  868 ++++++++++++++++++++++++-
 drivers/hwmon/w83627ehf.c                      |    9 
 drivers/hwmon/w83627hf.c                       |   25 
 drivers/hwmon/w83781d.c                        |   17 
 drivers/hwmon/w83792d.c                        |   85 --
 drivers/hwmon/w83l785ts.c                      |    8 
 drivers/i2c/busses/i2c-i801.c                  |    6 
 drivers/i2c/busses/i2c-ibm_iic.c               |    1 
 drivers/i2c/busses/i2c-isa.c                   |   10 
 drivers/i2c/busses/i2c-mv64xxx.c               |   33 
 drivers/i2c/busses/i2c-nforce2.c               |    2 
 drivers/i2c/busses/i2c-parport.h               |   12 
 drivers/i2c/chips/ds1337.c                     |   45 +
 drivers/i2c/chips/ds1374.c                     |    8 
 drivers/i2c/chips/eeprom.c                     |    8 
 drivers/i2c/chips/isp1301_omap.c               |    8 
 drivers/i2c/chips/m41t00.c                     |    8 
 drivers/i2c/chips/max6875.c                    |    8 
 drivers/i2c/chips/pca9539.c                    |    8 
 drivers/i2c/chips/pcf8574.c                    |    8 
 drivers/i2c/chips/pcf8591.c                    |    8 
 drivers/i2c/chips/rtc8564.c                    |   45 -
 drivers/i2c/chips/tps65010.c                   |    8 
 drivers/i2c/chips/x1205.c                      |    8 
 drivers/i2c/i2c-core.c                         |   76 --
 drivers/i2c/i2c-dev.c                          |   65 -
 drivers/macintosh/therm_adt746x.c              |    8 
 drivers/macintosh/therm_pm72.c                 |    8 
 drivers/macintosh/therm_windtunnel.c           |    8 
 drivers/macintosh/windfarm_lm75_sensor.c       |    8 
 drivers/media/video/adv7170.c                  |    9 
 drivers/media/video/adv7175.c                  |    9 
 drivers/media/video/bt819.c                    |    9 
 drivers/media/video/bt832.c                    |    9 
 drivers/media/video/bt856.c                    |    9 
 drivers/media/video/bttv-i2c.c                 |    2 
 drivers/media/video/cs53l32a.c                 |   16 
 drivers/media/video/cx25840/cx25840-core.c     |    9 
 drivers/media/video/cx25840/cx25840.h          |    7 
 drivers/media/video/cx88/cx88-i2c.c            |    2 
 drivers/media/video/em28xx/em28xx-i2c.c        |    1 
 drivers/media/video/indycam.c                  |    8 
 drivers/media/video/ir-kbd-i2c.c               |    7 
 drivers/media/video/msp3400.c                  |   22 
 drivers/media/video/ovcamchip/ovcamchip_core.c |    8 
 drivers/media/video/saa5246a.c                 |   15 
 drivers/media/video/saa5249.c                  |   15 
 drivers/media/video/saa6588.c                  |    9 
 drivers/media/video/saa7110.c                  |    9 
 drivers/media/video/saa7111.c                  |    9 
 drivers/media/video/saa7114.c                  |    9 
 drivers/media/video/saa7115.c                  |   16 
 drivers/media/video/saa711x.c                  |    9 
 drivers/media/video/saa7127.c                  |   19 
 drivers/media/video/saa7134/saa6752hs.c        |    9 
 drivers/media/video/saa7134/saa7134-i2c.c      |    4 
 drivers/media/video/saa7185.c                  |    9 
 drivers/media/video/saa7191.c                  |    8 
 drivers/media/video/tda7432.c                  |    8 
 drivers/media/video/tda9840.c                  |    8 
 drivers/media/video/tda9875.c                  |    8 
 drivers/media/video/tda9887.c                  |    7 
 drivers/media/video/tea6415c.c                 |    8 
 drivers/media/video/tea6420.c                  |    8 
 drivers/media/video/tuner-3036.c               |    8 
 drivers/media/video/tuner-core.c               |    9 
 drivers/media/video/tvaudio.c                  |    9 
 drivers/media/video/tveeprom.c                 |    9 
 drivers/media/video/tvmixer.c                  |   14 
 drivers/media/video/tvp5150.c                  |    9 
 drivers/media/video/vpx3220.c                  |    9 
 drivers/media/video/wm8775.c                   |   13 
 drivers/media/video/zoran_driver.c             |   14 
 drivers/usb/media/w9968cf.c                    |    4 
 drivers/video/matrox/matroxfb_maven.c          |   13 
 include/linux/hwmon-vid.h                      |    6 
 include/linux/i2c-id.h                         |   20 
 include/linux/i2c.h                            |   41 -
 include/linux/pci_ids.h                        |    1 
 include/media/tuner.h                          |    7 
 sound/oss/dmasound/dac3550a.c                  |    8 
 sound/oss/dmasound/tas_common.c                |    8 
 sound/ppc/keywest.c                            |    7 
 124 files changed, 1657 insertions(+), 854 deletions(-)


Grant Coady:
      hwmon: remove deprecated sysfs names of adm1025 and adm1026

Greg Kroah-Hartman:
      I2C: Make i2c_add_driver automatically set the proper module owner
      I2C: Fix up debug build error for previous i2c structure changes
      I2C: Remove .owner setting from i2c_driver as it's no longer needed
      I2C: move i2c-dev to use dynamic class devices

Jean Delvare:
      hwmon: Support the VRM 10 mode of the ADT7463
      i2c: Drop i2c_driver.flags, 2 of 3
      i2c: Drop i2c_driver.flags, 1 of 3
      i2c: i2c_get_client is gone
      i2c: Drop i2c_driver.flags, 3 of 3
      i2c: Chip driver porting guide update
      i2c: Rework client usage count, 1 of 3
      i2c: Rework client usage count, 2 of 3
      i2c: Rework client usage count, 3 of 3
      i2c: Drop i2c_driver.{owner,name}, 10 of 11
      i2c: Drop i2c_driver.{owner,name}, 11 of 11
      hwmon: w83792d simplify in low bits handling
      hwmon: w83792d misc cleanups
      i2c: Documentation update
      i2c: driver ID list cleanups
      hwmon: it87 use u8 for vrm
      i2c: update i2c_driver.command documentation
      i2c: I2C_DF_NOTIFY removal comment cleanups
      i2c: i2c-nforce2 add nforce4 MCP-04 device ID

Laurent Riffard:
      i2c: Drop i2c_driver.{owner,name}, 1 of 11
      i2c: Drop i2c_driver.{owner,name}, 5 of 11
      i2c: Drop i2c_driver.{owner,name}, 4 of 11
      i2c: Drop i2c_driver.{owner,name}, 2 of 11
      i2c: Drop i2c_driver.{owner,name}, 3 of 11
      i2c: Drop i2c_driver.{owner,name}, 6 of 11
      i2c: Drop i2c_driver.{owner,name}, 7 of 11
      i2c: Drop i2c_driver.{owner,name}, 9 of 11
      i2c: Drop i2c_driver.{owner,name}, 8 of 11
      i2c: drop empty i2c_driver.command implementations

Mark A. Greer:
      i2c: i2c-mv64xxx fix transaction abortion

Mark M. Hoffman:
      i2c: i2c-i801 explicitly enables/disables PEC
      hwmon: Clarify the W83627THF VID documentation

Martin Hicks:
      i2c: i2c-ibm_iic add I2C_CLASS_HWMON

Michael Burian:
      i2c: Extend ds1337 initialization

Nicolas Kaiser:
      i2c: Remove duplicate rtc8564 BCD macros

Peter Korsgaard:
      i2c: Add support for Barco LPT->DVI to i2c-parport

Roger Lucas:
      hwmon: New vt8231 driver

Rudolf Marek:
      hwmon: add VRM/VID support for some VIA CPUs

Yuan Mu:
      hwmon: W83627THF VID fixes

