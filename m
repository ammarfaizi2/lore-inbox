Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422863AbWAMTqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422863AbWAMTqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422864AbWAMTqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:46:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:6803 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422863AbWAMTqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:46:23 -0500
Date: Fri, 13 Jan 2006 11:46:02 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] More Driver Core patches for 2.6.15
Message-ID: <20060113194602.GB18262@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more driver core patches for 2.6.15.  They have all been
in the last -mm with no problems.  They contain the following
things:
	- input MODALIAS addition (it was accentially dropped from the
	  last patch series).
	- suspend bugfix
	- Russell's bus and driver callback rework (touches a lot of
	  different files.)
	- comment typo fixed.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

The full patch set will be sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h

 arch/arm/common/locomo.c            |    4 +-
 arch/arm/common/sa1111.c            |    4 +-
 arch/arm/kernel/ecard.c             |   14 +++++----
 arch/arm/mach-integrator/lm.c       |   36 +++++++++++------------
 arch/ia64/sn/kernel/tiocx.c         |   16 +++++-----
 arch/parisc/kernel/drivers.c        |    4 +-
 arch/powerpc/kernel/of_device.c     |    4 +-
 arch/powerpc/kernel/vio.c           |    8 ++---
 arch/ppc/syslib/ocp.c               |    4 +-
 arch/sh/kernel/cpu/bus.c            |   34 +++++++++++-----------
 drivers/base/dd.c                   |   12 ++++++-
 drivers/base/driver.c               |    5 +++
 drivers/base/platform.c             |    2 -
 drivers/base/power/shutdown.c       |    9 +++--
 drivers/dio/dio-driver.c            |    4 +-
 drivers/i2c/i2c-core.c              |   20 +++++--------
 drivers/ide/ide-cd.c                |   14 +++------
 drivers/ide/ide-disk.c              |   22 +++++---------
 drivers/ide/ide-floppy.c            |   14 +++------
 drivers/ide/ide-tape.c              |   18 ++++-------
 drivers/ide/ide.c                   |   31 ++++++++++++++++++++
 drivers/input/gameport/gameport.c   |   12 ++++---
 drivers/input/input.c               |   55 ++++++++++++++++++++++++------------
 drivers/input/serio/serio.c         |   12 ++++---
 drivers/macintosh/macio_asic.c      |    6 +--
 drivers/media/dvb/bt8xx/dvb-bt8xx.c |   23 +++++++--------
 drivers/media/video/bttv-gpio.c     |   24 ++++++++++++++-
 drivers/media/video/bttv.h          |    2 +
 drivers/mfd/mcp-core.c              |    4 +-
 drivers/mmc/mmc_sysfs.c             |   26 +++++++----------
 drivers/pci/pci-driver.c            |    4 +-
 drivers/pcmcia/ds.c                 |    4 +-
 drivers/pnp/driver.c                |    4 +-
 drivers/rapidio/rio-driver.c        |    6 +--
 drivers/s390/cio/ccwgroup.c         |   16 +++++-----
 drivers/s390/cio/css.c              |   36 ++++++++++++++++++++++-
 drivers/s390/cio/css.h              |    4 ++
 drivers/s390/cio/device.c           |   50 +++++++++++++++-----------------
 drivers/scsi/scsi_debug.c           |    4 +-
 drivers/sh/superhyway/superhyway.c  |    4 +-
 drivers/usb/gadget/ether.c          |    3 -
 drivers/usb/gadget/inode.c          |    3 -
 drivers/usb/gadget/serial.c         |    3 -
 drivers/usb/gadget/zero.c           |    3 -
 drivers/usb/serial/bus.c            |   15 ++++-----
 drivers/zorro/zorro-driver.c        |    4 +-
 include/linux/device.h              |    3 +
 include/linux/ide.h                 |    5 +++
 48 files changed, 358 insertions(+), 256 deletions(-)


Cornelia Huck:
      Add {css,ccw}_bus_type probe, remove, shutdown methods.

Jean Delvare:
      platform-device-del typo fix

Kay Sievers:
      INPUT: add MODALIAS to the event environment

Michael Richardson:
      device_shutdown can loop if the driver frees itself

Russell King:
      Add bus_type probe, remove, shutdown methods.
      Add pci_bus_type probe and remove methods
      Add SA1111 bus_type probe/remove methods
      Add locomo bus_type probe/remove methods
      Add logic module bus_type probe/remove methods
      Add tiocx bus_type probe/remove methods
      Add ecard_bus_type probe/remove/shutdown methods
      Add of_platform_bus_type probe and remove methods
      Add ocp_bus_type probe and remove methods
      Add parisc_bus_type probe and remove methods
      Add sh_bus_type probe and remove methods
      Add gameport bus_type probe and remove methods
      Add vio_bus_type probe and remove methods
      Add serio bus_type probe and remove methods
      Add dio_bus_type probe and remove methods
      Add i2c_bus_type probe and remove methods
      Add pcmcia_bus_type probe and remove methods
      Add MCP bus_type probe and remove methods
      Add macio_bus_type probe and remove methods
      Add mmc_bus_type probe and remove methods
      Add pnp_bus_type probe and remove methods
      Add usb_serial_bus_type probe and remove methods
      Add ccwgroup_bus_type probe and remove methods
      Add superhyway_bus_type probe and remove methods
      Add ide_bus_type probe and remove methods
      Add zorro_bus_type probe and remove methods
      Add Pseudo LLD bus_type probe and remove methods
      Add rio_bus_type probe and remove methods
      Add bttv sub bus_type probe and remove methods
      Remove usb gadget generic driver methods

