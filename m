Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWCWWn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWCWWn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWCWWn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:43:28 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:12946
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932532AbWCWWn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:43:27 -0500
Date: Thu, 23 Mar 2006 14:43:06 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] I2C and hwmon patches for 2.6.16
Message-ID: <20060323224306.GA32322@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some i2c and hwmon patches for against your current git tree.
They all have been in the -mm tree for a few weeks and months.

They fix a number of various bugs and add some new drivers and features
(hm, that was sure vague, see the changelog below for details...)

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h


 Documentation/hwmon/w83627hf          |    4 
 Documentation/hwmon/w83781d           |   24 +
 Documentation/i2c/busses/i2c-piix4    |    2 
 Documentation/i2c/busses/scx200_acb   |    5 
 drivers/hwmon/Kconfig                 |    7 
 drivers/hwmon/adm1021.c               |   13 
 drivers/hwmon/adm1025.c               |   25 -
 drivers/hwmon/adm1026.c               |   92 ++---
 drivers/hwmon/adm1031.c               |   49 +--
 drivers/hwmon/adm9240.c               |   29 -
 drivers/hwmon/asb100.c                |   45 +-
 drivers/hwmon/atxp1.c                 |    9 
 drivers/hwmon/ds1621.c                |   13 
 drivers/hwmon/f71805f.c               |  281 ++++++++---------
 drivers/hwmon/fscher.c                |   41 +-
 drivers/hwmon/fscpos.c                |   33 +-
 drivers/hwmon/gl518sm.c               |   25 -
 drivers/hwmon/gl520sm.c               |   45 +-
 drivers/hwmon/hdaps.c                 |   37 +-
 drivers/hwmon/hwmon-vid.c             |    9 
 drivers/hwmon/hwmon.c                 |   26 +
 drivers/hwmon/it87.c                  |   66 ++--
 drivers/hwmon/lm63.c                  |   29 -
 drivers/hwmon/lm75.c                  |   13 
 drivers/hwmon/lm77.c                  |   21 -
 drivers/hwmon/lm78.c                  |   51 +--
 drivers/hwmon/lm80.c                  |   27 -
 drivers/hwmon/lm83.c                  |   13 
 drivers/hwmon/lm85.c                  |   71 ++--
 drivers/hwmon/lm87.c                  |   39 +-
 drivers/hwmon/lm90.c                  |   21 -
 drivers/hwmon/lm92.c                  |   17 -
 drivers/hwmon/max1619.c               |   13 
 drivers/hwmon/pc87360.c               |  471 ++++++++++++++---------------
 drivers/hwmon/sis5595.c               |   51 +--
 drivers/hwmon/smsc47b397.c            |   17 -
 drivers/hwmon/smsc47m1.c              |   41 +-
 drivers/hwmon/via686a.c               |   33 +-
 drivers/hwmon/vt8231.c                |   51 +--
 drivers/hwmon/w83627ehf.c             |  241 ++++++---------
 drivers/hwmon/w83627hf.c              |  134 +++++---
 drivers/hwmon/w83781d.c               |   82 +++--
 drivers/hwmon/w83792d.c               |  538 +++++++++++++++-------------------
 drivers/hwmon/w83l785ts.c             |    9 
 drivers/i2c/busses/Kconfig            |   11 
 drivers/i2c/busses/i2c-ali1535.c      |    4 
 drivers/i2c/busses/i2c-amd756-s4882.c |   13 
 drivers/i2c/busses/i2c-frodo.c        |   85 -----
 drivers/i2c/busses/i2c-isa.c          |    2 
 drivers/i2c/busses/i2c-ite.c          |    4 
 drivers/i2c/busses/i2c-ixp4xx.c       |    1 
 drivers/i2c/busses/i2c-piix4.c        |    4 
 drivers/i2c/busses/i2c-pxa.c          |    2 
 drivers/i2c/busses/scx200_acb.c       |  283 ++++++++---------
 drivers/i2c/chips/ds1374.c            |   11 
 drivers/i2c/chips/eeprom.c            |    9 
 drivers/i2c/chips/isp1301_omap.c      |    2 
 drivers/i2c/chips/m41t00.c            |   11 
 drivers/i2c/chips/max6875.c           |   10 
 drivers/i2c/chips/pcf8591.c           |   13 
 drivers/i2c/chips/tps65010.c          |   45 +-
 drivers/i2c/i2c-core.c                |   81 ++---
 drivers/media/video/adv7170.c         |    1 
 drivers/media/video/adv7175.c         |    1 
 drivers/media/video/bt819.c           |    1 
 drivers/media/video/bt856.c           |    1 
 drivers/media/video/saa7110.c         |    1 
 drivers/media/video/saa7111.c         |    1 
 drivers/media/video/saa7114.c         |    1 
 drivers/media/video/saa711x.c         |    1 
 drivers/media/video/saa7185.c         |    1 
 drivers/media/video/vpx3220.c         |    1 
 include/linux/hwmon-sysfs.h           |   24 -
 include/linux/i2c-id.h                |    1 
 include/linux/i2c.h                   |    6 
 include/linux/pci_ids.h               |    1 
 sound/oss/dmasound/dmasound_awacs.c   |    2 
 sound/ppc/daca.c                      |    1 
 sound/ppc/keywest.c                   |    1 
 sound/ppc/toonie.c                    |    1 
 sound/ppc/tumbler.c                   |    1 
 81 files changed, 1711 insertions(+), 1791 deletions(-)

---------------

Alessandro Zummo:
      I2C: i2c-ixp4xx: Add hwmon class

Arjan van de Ven:
      I2C: Convert i2c to mutexes

Ben Gardner:
      i2c: scx200_acb whitespace and comment cleanup
      i2c: scx200_acb debug log cleanup
      i2c: scx200_acb refactor/simplify code
      i2c: scx200_acb remove use of lock_kernel
      i2c: scx200_acb add support for the CS5535/CS5536
      i2c: scx200_acb fix and speed up the poll loop
      i2c: scx200_acb minimal documentation update

Darren Jenkins:
      I2C: hwmon: Rename register parameters

Ingo Molnar:
      i2c: Semaphore to mutex conversions, part 2
      hwmon: Semaphore to mutex conversions

Jean Delvare:
      hwmon: Use attribute arrays in f71805f
      I2C: fix sx200_acb build on other arches
      hwmon: w83792d drop useless macros
      i2c: Speed up block transfers
      i2c: Semaphore to mutex conversions, part 3
      hwmon: f71805f semaphore to mutex conversions
      hwmon: Add support for the Winbond W83687THF
      hwmon: Support the Pentium M VID code
      w83781d: Document the alarm and beep bits
      w83781d: Don't reset the chip by default
      i2c: Optimize core_lists mutex usage
      i2c: Drop the i2c-frodo bus driver
      i2c: Fix i2c-ite name initialization
      i2c: Cleanup isp1301_omap
      I2C: i2c-ali1535: Drop redundant mutex
      I2C: i2c-amd756-s4882: Improve static mutex initialization
      I2C: Drop unneeded i2c-dev.h includes

Jim Cromie:
      hwmon: Allow sensor attributes arrays
      hwmon: Use attribute arrays in pc87360
      hwmon: Refactor SENSOR_DEVICE_ATTR_2

Mark M. Hoffman:
      hwmon: add required idr locking

Martin Devera:
      I2C: i2c-piix4: Add Broadcom HT-1000 support

Yuan Mu:
      hwmon: w83792d use arrays of attributes
      w83627ehf: Refactor the sysfs interface

