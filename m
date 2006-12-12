Return-Path: <linux-kernel-owner+w=401wt.eu-S932298AbWLLRml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWLLRml (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWLLRml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:42:41 -0500
Received: from zone4.gcu.info ([217.195.17.234]:53532 "EHLO
	zone4.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298AbWLLRmj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:42:39 -0500
Date: Tue, 12 Dec 2006 18:33:25 +0100 (CET)
To: torvalds@osdl.org
Subject: [GIT PULL] i2c updates for 2.6.20
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <PPamA8AW.1165944805.3983670.khali@localhost>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull the i2c subsystem updates for Linux 2.6.20 from branch
i2c-for-linus of repository git://jdelvare.pck.nerim.net/jdelvare-2.6

There are 3 new i2c bus drivers, one old broken bus driver deleted, and a
few cleanups and fixes in the i2c core and individual drivers.

I'm not yet comfortable with git so please let me know if I did anything
wrong.

 Documentation/feature-removal-schedule.txt |   11
 Documentation/i2c/busses/i2c-amd8111       |    2
 Documentation/i2c/busses/i2c-i801          |    5
 Documentation/i2c/busses/i2c-nforce2       |    6
 arch/arm/mach-pnx4008/Makefile             |    2
 arch/arm/mach-pnx4008/i2c.c                |  167 ++++++
 arch/arm/mach-realview/core.c              |   13
 arch/arm/mach-realview/core.h              |    1
 arch/arm/mach-realview/realview_eb.c       |    1
 arch/arm/mach-versatile/core.c             |   14
 drivers/acorn/char/i2c.c                   |    2
 drivers/i2c/algos/Kconfig                  |   11
 drivers/i2c/algos/Makefile                 |    1
 drivers/i2c/algos/i2c-algo-bit.c           |    8
 drivers/i2c/algos/i2c-algo-ite.c           |  806
-------------------------
 drivers/i2c/algos/i2c-algo-ite.h           |  117 ----
 drivers/i2c/algos/i2c-algo-pca.c           |    7
 drivers/i2c/algos/i2c-algo-pcf.c           |    8
 drivers/i2c/algos/i2c-algo-sgi.c           |    8
 drivers/i2c/busses/Kconfig                 |   49 +-
 drivers/i2c/busses/Makefile                |    4
 drivers/i2c/busses/i2c-at91.c              |  325 +++++++++++
 drivers/i2c/busses/i2c-elektor.c           |    2
 drivers/i2c/busses/i2c-hydra.c             |    2
 drivers/i2c/busses/i2c-i801.c              |   16 -
 drivers/i2c/busses/i2c-i810.c              |    6
 drivers/i2c/busses/i2c-ibm_iic.c           |    9
 drivers/i2c/busses/i2c-ite.c               |  278 ----------
 drivers/i2c/busses/i2c-ixp2000.c           |    2
 drivers/i2c/busses/i2c-ixp4xx.c            |    2
 drivers/i2c/busses/i2c-nforce2.c           |   89 ---
 drivers/i2c/busses/i2c-omap.c              |    4
 drivers/i2c/busses/i2c-parport-light.c     |    2
 drivers/i2c/busses/i2c-parport.c           |    2
 drivers/i2c/busses/i2c-pca-isa.c           |    2
 drivers/i2c/busses/i2c-pnx.c               |  708
+++++++++++++++++++++++++
 drivers/i2c/busses/i2c-prosavage.c         |    2
 drivers/i2c/busses/i2c-savage4.c           |    2
 drivers/i2c/busses/i2c-versatile.c         |  153 +++++
 drivers/i2c/busses/i2c-via.c               |    2
 drivers/i2c/busses/i2c-voodoo3.c           |    6
 drivers/i2c/busses/scx200_i2c.c            |    2
 drivers/i2c/chips/ds1337.c                 |    8
 drivers/i2c/i2c-core.c                     |   67 +-
 drivers/i2c/i2c-dev.c                      |   44 +-
 drivers/ieee1394/pcilynx.c                 |    2
 drivers/media/dvb/pluto2/pluto2.c          |    8
 drivers/media/video/bt8xx/bttv-i2c.c       |    6
 drivers/media/video/cx88/cx88-core.c       |    2
 drivers/media/video/cx88/cx88-vp3054-i2c.c |    2
 drivers/media/video/vino.c                 |    2
 drivers/media/video/zoran_card.c           |    2
 drivers/video/aty/radeon_i2c.c             |    8
 drivers/video/i810/i810-i2c.c              |    6
 drivers/video/intelfb/intelfb_i2c.c        |    4
 drivers/video/matrox/i2c-matroxfb.c        |    2
 drivers/video/nvidia/nv_i2c.c              |    6
 drivers/video/riva/rivafb-i2c.c            |    6
 drivers/video/savage/savagefb-i2c.c        |    2
 include/asm-arm/arch-pnx4008/i2c.h         |   67 ++
 include/linux/i2c-algo-bit.h               |    5
 include/linux/i2c-algo-ite.h               |   72 ---
 include/linux/i2c-algo-pca.h               |    1
 include/linux/i2c-algo-pcf.h               |    3
 include/linux/i2c-algo-sgi.h               |    1
 include/linux/i2c-id.h                     |   17 -
 include/linux/i2c-pnx.h                    |   43 +
 include/linux/i2c.h                        |   75 +--
 68 files changed, 1730 insertions(+), 1590 deletions(-)
 create mode 100644 arch/arm/mach-pnx4008/i2c.c
 delete mode 100644 drivers/i2c/algos/i2c-algo-ite.c
 delete mode 100644 drivers/i2c/algos/i2c-algo-ite.h
 create mode 100644 drivers/i2c/busses/i2c-at91.c
 delete mode 100644 drivers/i2c/busses/i2c-ite.c
 create mode 100644 drivers/i2c/busses/i2c-pnx.c
 create mode 100644 drivers/i2c/busses/i2c-versatile.c
 create mode 100644 include/asm-arm/arch-pnx4008/i2c.h
 delete mode 100644 include/linux/i2c-algo-ite.h
 create mode 100644 include/linux/i2c-pnx.h

---------------

Akinobu Mita:
      i2c: Fix return value check in i2c-dev

Andrew Victor:
      i2c: New Atmel AT91 bus driver

David Brownell:
      i2c: Whitespace cleanups

Dirk Eibach:
      i2c: fix broken ds1337 initialization

Hans-Frieder Vogt:
      i2c: Cleanups to the i2c-nforce2 bus driver

Jason Gaston:
      i2c: i2c-i801 documentation update

Jean Delvare:
      i2c: Fix documentation typos
      i2c: Update the list of driver IDs
      i2c: Delete the broken i2c-ite bus driver
      i2c: Use put_user instead of copy_to_user where possible
      i2c: Use the __ATTR macro where possible
      i2c: Discard the i2c algo del_bus wrappers
      i2c: Enable PEC on more i2c-i801 devices
      i2c: Refactor a kfree in i2c-dev
      i2c: Fix OMAP clock prescaler to match the comment

Jean-Baptiste Maneyrol:
      i2c: Add request/release_mem_region to i2c-ibm_iic bus driver

Jiri Kosina:
      i2c: Add support for nested i2c bus locking

Russell King:
      i2c: New ARM Versatile/Realview bus driver

Vitaly Wool:
      i2c: New Philips PNX bus driver

--
Jean Delvare
