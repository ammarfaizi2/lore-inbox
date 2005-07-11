Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVGKWGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVGKWGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVGKWDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:03:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:13276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262740AbVGKWCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:02:41 -0400
Date: Mon, 11 Jul 2005 15:01:23 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: [GIT PATCH] I2C patches for 2.6.13-rc2
Message-ID: <20050711220123.GA3807@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some i2c patches that have been in the -mm tree for a while.
They fix a number of different bugs.  But the majority of this patchest
(in diffstat volume) is moving the i2c chip drivers into the hwmon
directory.  I used your 'dotest' script to acomplish this, but don't
know if git registered that these files were just renamed or not.  If I
should do it a different way, please let me know and I'll regenerate the
tree.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the linux-kernel and sensors mailing lists,
if anyone wants to see them.

thanks,

greg k-h

 Documentation/hwmon/adm1021         |  111 ++
 Documentation/hwmon/adm1025         |   51 +
 Documentation/hwmon/adm1026         |   93 +
 Documentation/hwmon/adm1031         |   35 
 Documentation/hwmon/adm9240         |  177 +++
 Documentation/hwmon/asb100          |   72 +
 Documentation/hwmon/ds1621          |  108 ++
 Documentation/hwmon/fscher          |  169 +++
 Documentation/hwmon/gl518sm         |   74 +
 Documentation/hwmon/it87            |   96 ++
 Documentation/hwmon/lm63            |   57 +
 Documentation/hwmon/lm75            |   65 +
 Documentation/hwmon/lm77            |   22 
 Documentation/hwmon/lm78            |   82 +
 Documentation/hwmon/lm80            |   56 +
 Documentation/hwmon/lm83            |   76 +
 Documentation/hwmon/lm85            |  221 ++++
 Documentation/hwmon/lm87            |   73 +
 Documentation/hwmon/lm90            |  121 ++
 Documentation/hwmon/lm92            |   37 
 Documentation/hwmon/max1619         |   29 
 Documentation/hwmon/pc87360         |  189 +++
 Documentation/hwmon/sis5595         |  106 ++
 Documentation/hwmon/smsc47b397      |  158 +++
 Documentation/hwmon/smsc47m1        |   52 +
 Documentation/hwmon/sysfs-interface |  274 +++++
 Documentation/hwmon/userspace-tools |   39 
 Documentation/hwmon/via686a         |   65 +
 Documentation/hwmon/w83627hf        |   66 +
 Documentation/hwmon/w83781d         |  402 ++++++++
 Documentation/hwmon/w83l785ts       |   39 
 Documentation/i2c/chips/adm1021     |  111 --
 Documentation/i2c/chips/adm1025     |   51 -
 Documentation/i2c/chips/adm1026     |   93 -
 Documentation/i2c/chips/adm1031     |   35 
 Documentation/i2c/chips/adm9240     |  177 ---
 Documentation/i2c/chips/asb100      |   72 -
 Documentation/i2c/chips/ds1621      |  108 --
 Documentation/i2c/chips/fscher      |  169 ---
 Documentation/i2c/chips/gl518sm     |   74 -
 Documentation/i2c/chips/it87        |   96 --
 Documentation/i2c/chips/lm63        |   57 -
 Documentation/i2c/chips/lm75        |   65 -
 Documentation/i2c/chips/lm77        |   22 
 Documentation/i2c/chips/lm78        |   82 -
 Documentation/i2c/chips/lm80        |   56 -
 Documentation/i2c/chips/lm83        |   76 -
 Documentation/i2c/chips/lm85        |  221 ----
 Documentation/i2c/chips/lm87        |   73 -
 Documentation/i2c/chips/lm90        |  121 --
 Documentation/i2c/chips/lm92        |   37 
 Documentation/i2c/chips/max1619     |   29 
 Documentation/i2c/chips/max6875     |   22 
 Documentation/i2c/chips/pc87360     |  189 ---
 Documentation/i2c/chips/sis5595     |  106 --
 Documentation/i2c/chips/smsc47b397  |  158 ---
 Documentation/i2c/chips/smsc47m1    |   52 -
 Documentation/i2c/chips/via686a     |   65 -
 Documentation/i2c/chips/w83627hf    |   66 -
 Documentation/i2c/chips/w83781d     |  402 --------
 Documentation/i2c/chips/w83l785ts   |   39 
 Documentation/i2c/dev-interface     |   15 
 Documentation/i2c/sysfs-interface   |  274 -----
 Documentation/i2c/userspace-tools   |   39 
 Documentation/i2c/writing-clients   |    7 
 arch/arm/Kconfig                    |    2 
 arch/h8300/Kconfig                  |    2 
 arch/sparc64/Kconfig                |    2 
 drivers/Kconfig                     |    2 
 drivers/Makefile                    |    1 
 drivers/hwmon/Kconfig               |  420 ++++++++
 drivers/hwmon/Makefile              |   44 
 drivers/hwmon/adm1021.c             |  402 ++++++++
 drivers/hwmon/adm1025.c             |  577 ++++++++++++
 drivers/hwmon/adm1026.c             | 1714 ++++++++++++++++++++++++++++++++++++
 drivers/hwmon/adm1031.c             |  977 ++++++++++++++++++++
 drivers/hwmon/adm9240.c             |  791 ++++++++++++++++
 drivers/hwmon/asb100.c              | 1065 ++++++++++++++++++++++
 drivers/hwmon/atxp1.c               |  361 +++++++
 drivers/hwmon/ds1621.c              |  341 +++++++
 drivers/hwmon/fscher.c              |  691 ++++++++++++++
 drivers/hwmon/fscpos.c              |  641 +++++++++++++
 drivers/hwmon/gl518sm.c             |  604 ++++++++++++
 drivers/hwmon/gl520sm.c             |  769 ++++++++++++++++
 drivers/hwmon/it87.c                | 1184 ++++++++++++++++++++++++
 drivers/hwmon/lm63.c                |  597 ++++++++++++
 drivers/hwmon/lm75.c                |  296 ++++++
 drivers/hwmon/lm75.h                |   49 +
 drivers/hwmon/lm77.c                |  420 ++++++++
 drivers/hwmon/lm78.c                |  795 ++++++++++++++++
 drivers/hwmon/lm80.c                |  601 ++++++++++++
 drivers/hwmon/lm83.c                |  408 ++++++++
 drivers/hwmon/lm85.c                | 1575 +++++++++++++++++++++++++++++++++
 drivers/hwmon/lm87.c                |  828 +++++++++++++++++
 drivers/hwmon/lm90.c                |  655 +++++++++++++
 drivers/hwmon/lm92.c                |  429 +++++++++
 drivers/hwmon/max1619.c             |  372 +++++++
 drivers/hwmon/pc87360.c             | 1348 ++++++++++++++++++++++++++++
 drivers/hwmon/sis5595.c             |  817 +++++++++++++++++
 drivers/hwmon/smsc47b397.c          |  352 +++++++
 drivers/hwmon/smsc47m1.c            |  593 ++++++++++++
 drivers/hwmon/via686a.c             |  875 ++++++++++++++++++
 drivers/hwmon/w83627ehf.c           |  846 +++++++++++++++++
 drivers/hwmon/w83627hf.c            | 1511 +++++++++++++++++++++++++++++++
 drivers/hwmon/w83781d.c             | 1632 ++++++++++++++++++++++++++++++++++
 drivers/hwmon/w83l785ts.c           |  328 ++++++
 drivers/i2c/algos/i2c-algo-ite.c    |    8 
 drivers/i2c/busses/i2c-i801.c       |    4 
 drivers/i2c/busses/i2c-piix4.c      |    2 
 drivers/i2c/busses/i2c-sis5595.c    |    2 
 drivers/i2c/chips/Kconfig           |  415 --------
 drivers/i2c/chips/Makefile          |   38 
 drivers/i2c/chips/adm1021.c         |  402 --------
 drivers/i2c/chips/adm1025.c         |  577 ------------
 drivers/i2c/chips/adm1026.c         | 1714 ------------------------------------
 drivers/i2c/chips/adm1031.c         |  977 --------------------
 drivers/i2c/chips/adm9240.c         |  791 ----------------
 drivers/i2c/chips/asb100.c          | 1065 ----------------------
 drivers/i2c/chips/atxp1.c           |  361 -------
 drivers/i2c/chips/ds1621.c          |  341 -------
 drivers/i2c/chips/eeprom.c          |    3 
 drivers/i2c/chips/fscher.c          |  691 --------------
 drivers/i2c/chips/fscpos.c          |  641 -------------
 drivers/i2c/chips/gl518sm.c         |  604 ------------
 drivers/i2c/chips/gl520sm.c         |  769 ----------------
 drivers/i2c/chips/it87.c            | 1184 ------------------------
 drivers/i2c/chips/lm63.c            |  597 ------------
 drivers/i2c/chips/lm75.c            |  296 ------
 drivers/i2c/chips/lm75.h            |   49 -
 drivers/i2c/chips/lm77.c            |  420 --------
 drivers/i2c/chips/lm78.c            |  795 ----------------
 drivers/i2c/chips/lm80.c            |  601 ------------
 drivers/i2c/chips/lm83.c            |  408 --------
 drivers/i2c/chips/lm85.c            | 1575 ---------------------------------
 drivers/i2c/chips/lm87.c            |  828 -----------------
 drivers/i2c/chips/lm90.c            |  655 -------------
 drivers/i2c/chips/lm92.c            |  429 ---------
 drivers/i2c/chips/m41t00.c          |    2 
 drivers/i2c/chips/max1619.c         |  372 -------
 drivers/i2c/chips/max6875.c         |    6 
 drivers/i2c/chips/pc87360.c         | 1348 ----------------------------
 drivers/i2c/chips/sis5595.c         |  817 -----------------
 drivers/i2c/chips/smsc47b397.c      |  352 -------
 drivers/i2c/chips/smsc47m1.c        |  593 ------------
 drivers/i2c/chips/tps65010.c        |   61 -
 drivers/i2c/chips/via686a.c         |  887 ------------------
 drivers/i2c/chips/w83627ehf.c       |  846 -----------------
 drivers/i2c/chips/w83627hf.c        | 1511 -------------------------------
 drivers/i2c/chips/w83781d.c         | 1632 ----------------------------------
 drivers/i2c/chips/w83l785ts.c       |  328 ------
 drivers/i2c/i2c-core.c              |   17 
 drivers/w1/w1.c                     |    5 
 152 files changed, 29226 insertions(+), 29184 deletions(-)

----------

Adrian Bunk:
  I2C: SENSORS_ATXP1 must select I2C_SENSOR

david-b@pacbell.net:
  I2C: minor I2C doc cleanups
  I2C: minor TPS6501x cleanups

Denis Vlasenko:
  I2C: Coding style cleanups to via686a

Evgeniy Polyakov:
  w1: fix CRC calculation on bigendian platforms.

Jan Veldeman:
  I2C: Documentation fix

Jean Delvare:
  I2C: Move hwmon drivers (3/3)
  I2C: Move hwmon drivers (2/3)
  I2C: Move hwmon drivers (1/3)
  I2C: Clarify the usage of i2c-dev.h
  I2C: New max6875 driver may corrupt EEPROMs
  I2C: m41t00: fix incorrect kfree
  I2C: Strip trailing whitespace from strings
  I2C: drop bogus eeprom comment
  I2C: max6875 Kconfig update
  I2C: max6875 documentation update

Mark M. Hoffman:
  i2c: make better use of IDR in i2c-core

