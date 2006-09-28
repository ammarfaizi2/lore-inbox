Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161346AbWI1Wm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbWI1Wm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161348AbWI1Wm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:42:58 -0400
Received: from mail.suse.de ([195.135.220.2]:59351 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161346AbWI1Wm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:42:57 -0400
Date: Thu, 28 Sep 2006 15:42:48 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Jean Delvare <khali@linux-fr.org>
Subject: [GIT PATCH] HWMon patches for 2.6.18
Message-ID: <20060928224248.GA23843@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some hwmon patches for 2.6.18.  They include a new driver, and
a bunch of warning fixes that cleaned up the code a lot.

Half of these have been in the -mm tree for a while, the other half were
in Jean's tree for too long before I added them to mine (the delay was
my fault.)

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/hwmon-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/hwmon-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/hwmon/it87      |   61 +-
 Documentation/hwmon/k8temp    |   52 ++
 Documentation/hwmon/vt1211    |  206 ++++++
 Documentation/hwmon/w83627ehf |   85 +++
 Documentation/hwmon/w83791d   |   69 +-
 MAINTAINERS                   |    6 
 drivers/hwmon/Kconfig         |   51 +-
 drivers/hwmon/Makefile        |    2 
 drivers/hwmon/abituguru.c     |   30 +
 drivers/hwmon/adm1021.c       |   31 +
 drivers/hwmon/adm1025.c       |   94 ++-
 drivers/hwmon/adm1026.c       |  286 ++++-----
 drivers/hwmon/adm1031.c       |  114 ++-
 drivers/hwmon/adm9240.c       |  105 +--
 drivers/hwmon/asb100.c        |  122 ++--
 drivers/hwmon/atxp1.c         |   28 +
 drivers/hwmon/ds1621.c        |   28 +
 drivers/hwmon/f71805f.c       |  336 +++++++---
 drivers/hwmon/fscher.c        |  106 +--
 drivers/hwmon/fscpos.c        |   75 +-
 drivers/hwmon/gl518sm.c       |   74 +-
 drivers/hwmon/gl520sm.c       |  128 ++--
 drivers/hwmon/hdaps.c         |    6 
 drivers/hwmon/it87.c          |  469 +++++++++++---
 drivers/hwmon/k8temp.c        |  294 +++++++++
 drivers/hwmon/lm63.c          |   96 ++-
 drivers/hwmon/lm75.c          |   24 +
 drivers/hwmon/lm77.c          |   33 +
 drivers/hwmon/lm78.c          |   88 ++-
 drivers/hwmon/lm80.c          |   85 +--
 drivers/hwmon/lm83.c          |  128 +++-
 drivers/hwmon/lm85.c          |  173 +++--
 drivers/hwmon/lm87.c          |  191 ++++--
 drivers/hwmon/lm90.c          |   90 ++-
 drivers/hwmon/lm92.c          |   34 +
 drivers/hwmon/max1619.c       |   33 +
 drivers/hwmon/pc87360.c       |  230 +++++--
 drivers/hwmon/sis5595.c       |  101 ++-
 drivers/hwmon/smsc47b397.c    |   39 +
 drivers/hwmon/smsc47m1.c      |   81 ++
 drivers/hwmon/smsc47m192.c    |  150 +++--
 drivers/hwmon/via686a.c       |   83 ++-
 drivers/hwmon/vt1211.c        | 1355 +++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/vt8231.c        |  186 ++++--
 drivers/hwmon/w83627ehf.c     |  485 ++++++++++++++-
 drivers/hwmon/w83627hf.c      |  232 ++++---
 drivers/hwmon/w83781d.c       |  277 ++++----
 drivers/hwmon/w83791d.c       |    7 
 drivers/hwmon/w83792d.c       |  554 ++++++++++-------
 drivers/hwmon/w83l785ts.c     |   28 +
 include/linux/pci_ids.h       |    1 
 51 files changed, 5727 insertions(+), 1915 deletions(-)
 create mode 100644 Documentation/hwmon/k8temp
 create mode 100644 Documentation/hwmon/vt1211
 create mode 100644 Documentation/hwmon/w83627ehf
 create mode 100644 drivers/hwmon/k8temp.c
 create mode 100644 drivers/hwmon/vt1211.c

---------------

Alexey Dobriyan:
      atxp1: Signed/unsigned char bug fix

Charles Spirakis:
      w83791d: Documentation update

David Hubbard:
      w83627ehf: Fix unchecked return status

Dmitry Torokhov:
      hdaps: Handle errors from input_register_device

Hans de Goede:
      abituguru: Add suspend/resume support

Jean Delvare:
      smsc47m1: dev_warn fix
      it87: Add support for the IT8716F
      it87: No sysfs files for disabled fans
      it87: Prevent overflow on fan clock divider write
      it87: in8 has no limit registers
      it87: Cleanup set_fan_div
      it87: Add support for the IT8718F
      it87: Overwrite broken default limits
      it87: Copyright update
      k8temp: Enable automatic loading
      hwmon: Make a dozen drivers no more experimental
      hwmon: Add individual alarm files to 4 drivers
      hwmon: Fix unchecked return status, batch 4
      Fix unchecked return status, batch 5
      hwmon: Fix unchecked return status, batch 6
      hwmon: Fix unchecked return status, SMSC chips
      hwmon: Remove Yuan Mu's address

Jim Cromie:
      pc87360: Move some code around
      pc87360: Delete sysfs files on device deletion
      pc87360: Check for error on sysfs files creation
      w83781d: Fix unchecked return status

Juerg Haefliger:
      hwmon: New driver for the VIA VT1211
      vt1211: Add documentation
      vt1211: Document module parameters

Mark M. Hoffman:
      hwmon: Fix unchecked return status, batch 1
      hwmon: Fix unchecked return status, batch 2
      hwmon: Fix unchecked return status, batch 3

Roger Lucas:
      vt8231: Fix unchecked return status

Rudolf Marek:
      hwmon: Add fan speed control features to w83627ehf
      hwmon: Documentation update for w83627ehf
      hwmon: New driver k8temp
      k8temp: Add documentation
      w83l785ts: Fix unchecked return status
      w83792d: Fix unchecked return status

