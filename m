Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWFVS3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWFVS3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFVS3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:29:53 -0400
Received: from mx1.suse.de ([195.135.220.2]:63881 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932279AbWFVS3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:29:52 -0400
Date: Thu, 22 Jun 2006 11:26:34 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Jean Delvare <khali@linux-fr.org>
Subject: [GIT PATCH] I2C and hwmon patches for 2.6.17
Message-ID: <20060622182634.GA5668@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some i2c and hwmon patches and fixes for 2.6.17.  They add a
few new drivers, and fix a wide range of bugs and cleanups.

They all have been in the -mm tree for a few months.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h



 Documentation/hwmon/abituguru           |   59 +
 Documentation/hwmon/abituguru-datasheet |  312 +++++++
 Documentation/hwmon/lm70                |   31 +
 Documentation/hwmon/lm83                |   17 
 Documentation/hwmon/smsc47m192          |  102 ++
 Documentation/hwmon/sysfs-interface     |  274 ++++--
 Documentation/hwmon/userspace-tools     |   17 
 Documentation/hwmon/w83791d             |  113 ++
 Documentation/i2c/busses/i2c-i801       |    3 
 Documentation/i2c/busses/i2c-nforce2    |    2 
 Documentation/i2c/busses/i2c-ocores     |   51 +
 Documentation/i2c/busses/i2c-piix4      |   40 +
 Documentation/i2c/busses/scx200_acb     |   19 
 MAINTAINERS                             |   24 -
 drivers/hwmon/Kconfig                   |   65 +
 drivers/hwmon/Makefile                  |    4 
 drivers/hwmon/abituguru.c               | 1415 +++++++++++++++++++++++++++++++
 drivers/hwmon/f71805f.c                 |   15 
 drivers/hwmon/hdaps.c                   |    8 
 drivers/hwmon/hwmon-vid.c               |   44 +
 drivers/hwmon/lm70.c                    |  165 ++++
 drivers/hwmon/lm83.c                    |   50 +
 drivers/hwmon/smsc47m192.c              |  648 ++++++++++++++
 drivers/hwmon/w83627ehf.c               |  170 ++++
 drivers/hwmon/w83791d.c                 | 1255 +++++++++++++++++++++++++++
 drivers/hwmon/w83792d.c                 |   86 +-
 drivers/i2c/busses/Kconfig              |   22 
 drivers/i2c/busses/Makefile             |    1 
 drivers/i2c/busses/i2c-i801.c           |  154 +--
 drivers/i2c/busses/i2c-nforce2.c        |   38 +
 drivers/i2c/busses/i2c-ocores.c         |  341 +++++++
 drivers/i2c/busses/i2c-piix4.c          |   33 -
 drivers/i2c/busses/scx200_acb.c         |  202 +++-
 drivers/i2c/chips/Kconfig               |    8 
 drivers/i2c/chips/m41t00.c              |  346 ++++++--
 drivers/i2c/i2c-core.c                  |    4 
 drivers/i2c/i2c-dev.c                   |    5 
 include/linux/i2c-ocores.h              |   19 
 include/linux/i2c.h                     |    4 
 include/linux/m41t00.h                  |   50 +
 include/linux/pci_ids.h                 |    5 
 41 files changed, 5747 insertions(+), 474 deletions(-)
 create mode 100644 Documentation/hwmon/abituguru
 create mode 100644 Documentation/hwmon/abituguru-datasheet
 create mode 100644 Documentation/hwmon/lm70
 create mode 100644 Documentation/hwmon/smsc47m192
 create mode 100644 Documentation/hwmon/w83791d
 create mode 100644 Documentation/i2c/busses/i2c-ocores
 create mode 100644 drivers/hwmon/abituguru.c
 create mode 100644 drivers/hwmon/lm70.c
 create mode 100644 drivers/hwmon/smsc47m192.c
 create mode 100644 drivers/hwmon/w83791d.c
 create mode 100644 drivers/i2c/busses/i2c-ocores.c
 create mode 100644 include/linux/i2c-ocores.h
 create mode 100644 include/linux/m41t00.h

---------------

Charles Spirakis:
      HWMON: w83791d: New hardware monitoring driver for the Winbond W83791D

David Brownell:
      I2C: I2C controllers go into right place on sysfs

Hans de Goede:
      abituguru: New hardware monitoring driver
      abituguru: Review fixes
      abituguru: Fix fan detection

Hartmut Rick:
      smsc47m192: New hwmon driver for SMSC LPC47M192/997

Jean Delvare:
      w83627ehf: Add alarms support
      f71805f: Resource needs not be global
      hwmon: Add sysfs interface for individual alarm files
      I2C: i2c-piix4: Fix typo in documentation
      I2C: i2c-piix4: Document the IBM problem more clearly
      I2C: i2c-nforce2: Add support for the nForce4 MCP51 and MCP55
      HWMON: hdaps: Update the list of supported systems
      HWMON: lm83: Documentation update
      HWMON: Improve the help text for CONFIG_HWMON
      i2c: Suggest N for rare devices in Kconfig
      hwmon: Sysfs interface documentation update, 2 of 2, take 2
      hwmon: Fix a typo in the hdaps driver
      hwmon: Drop some maintainers entries
      scx200_acb: Mark scx200_acb_probe __init
      scx200_acb: Documentation update
      i2c-i801: Fix block transaction poll loops
      i2c-i801: Remove force_addr parameter
      i2c-i801: Remove PCI function check
      i2c-i801: Cleanups
      i2c-i801: Better pci subsystem integration
      i2c-i801: Merge setup function
      hwmon: Fix the Kconfig header

Jordan Crouse:
      lm83: Add LM82 support
      scx200_acb: Use PCI I/O resource when appropriate

Kaiwan N Billimoria:
      lm70: New hardware monitoring driver

Krzysztof Halasa:
      i2c: Mark block write buffers as const

Mark A. Greer:
      i2c: cleanup m41t00
      I2C: m41t00: Add support for the ST M41T81 and M41T85

Peter Korsgaard:
      i2c: New bus driver for the OpenCores I2C controller
      i2c-ocores: Minor cleanups

Rudolf Marek:
      w83627ehf: Add voltage inputs support
      i2c-piix4: Add ATI IXP200/300/400 support
      I2C: i2c-piix4: Remove the fix_hstcfg parameter
      HWMON: Trim VID values to correct number of bits
      hwmon: Sysfs interface documentation update, 1 of 2
      hwmon-vid: Add support for Intel Core and Conroe

Yuan Mu:
      w83792d: Fix setting the PWM value
      w83792d: Add missing data access locks

