Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266654AbUHWSra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUHWSra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUHWSqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:46:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:60866 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266574AbUHWSeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:34:23 -0400
Date: Mon, 23 Aug 2004 11:33:23 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] PCI and I2C fixes for 2.6.8
Message-ID: <20040823183323.GA1236@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and I2C patches for 2.6.8.  The trees are merged
together because they were conflicting with each other in the pci quirks
area.  They include lots of different fixes and changes, and a few new
i2c drivers.  All of these patches have been in the last few -mm
releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 Documentation/pci.txt                   |   11 
 arch/alpha/kernel/pci.c                 |   15 
 arch/arm/kernel/bios32.c                |   39 -
 arch/i386/Kconfig                       |    4 
 arch/i386/pci/common.c                  |    2 
 arch/i386/pci/fixup.c                   |  129 -----
 arch/i386/pci/numa.c                    |    5 
 arch/i386/pci/pcbios.c                  |    2 
 arch/ia64/pci/pci.c                     |    2 
 arch/m68k/kernel/bios32.c               |    5 
 arch/m68knommu/kernel/comempci.c        |    2 
 arch/mips/pci/fixup-atlas.c             |   10 
 arch/mips/pci/fixup-au1000.c            |    4 
 arch/mips/pci/fixup-capcella.c          |    4 
 arch/mips/pci/fixup-cobalt.c            |   12 
 arch/mips/pci/fixup-ddb5074.c           |    7 
 arch/mips/pci/fixup-ddb5477.c           |   16 
 arch/mips/pci/fixup-ip32.c              |    4 
 arch/mips/pci/fixup-jaguar.c            |    4 
 arch/mips/pci/fixup-lasat.c             |    4 
 arch/mips/pci/fixup-malta.c             |   11 
 arch/mips/pci/fixup-mpc30x.c            |    4 
 arch/mips/pci/fixup-ocelot-c.c          |    4 
 arch/mips/pci/fixup-ocelot-g.c          |    4 
 arch/mips/pci/fixup-sni.c               |    4 
 arch/mips/pci/fixup-tb0219.c            |    4 
 arch/mips/pci/fixup-tb0226.c            |    4 
 arch/mips/pci/fixup-yosemite.c          |    4 
 arch/mips/pci/pci-ip27.c                |   21 
 arch/mips/pci/pci-sb1250.c              |    4 
 arch/mips/pmc-sierra/yosemite/ht.c      |    5 
 arch/parisc/kernel/pci.c                |    9 
 arch/ppc/kernel/pci.c                   |   23 
 arch/ppc/platforms/pmac_pci.c           |    5 
 arch/ppc/platforms/sbc82xx.c            |   20 
 arch/ppc64/kernel/iSeries_pci.c         |    4 
 arch/ppc64/kernel/pSeries_pci.c         |   10 
 arch/ppc64/kernel/pci.c                 |   22 
 arch/ppc64/kernel/pmac_pci.c            |    1 
 arch/sh/boards/mpc1211/pci.c            |    9 
 arch/sh/boards/overdrive/galileo.c      |    8 
 arch/sh/drivers/pci/fixups-dreamcast.c  |    6 
 arch/sh/drivers/pci/pci-sh7751.c        |    9 
 arch/sh/drivers/pci/pci-st40.c          |    8 
 arch/sh64/kernel/pci_sh5.c              |    7 
 arch/sparc/kernel/pcic.c                |    4 
 arch/sparc64/kernel/pci.c               |    4 
 arch/v850/kernel/rte_mb_a_pci.c         |    2 
 drivers/i2c/Makefile                    |    3 
 drivers/i2c/algos/Kconfig               |   11 
 drivers/i2c/algos/Makefile              |    1 
 drivers/i2c/algos/i2c-algo-bit.c        |    4 
 drivers/i2c/algos/i2c-algo-ite.c        |   14 
 drivers/i2c/algos/i2c-algo-pca.c        |  395 +++++++++++++++
 drivers/i2c/algos/i2c-algo-pca.h        |   26 +
 drivers/i2c/algos/i2c-algo-pcf.c        |   12 
 drivers/i2c/busses/Kconfig              |   58 +-
 drivers/i2c/busses/Makefile             |    7 
 drivers/i2c/busses/i2c-ali1563.c        |    2 
 drivers/i2c/busses/i2c-ali15x3.c        |    6 
 drivers/i2c/busses/i2c-amd756.c         |    2 
 drivers/i2c/busses/i2c-amd8111.c        |    2 
 drivers/i2c/busses/i2c-elektor.c        |   10 
 drivers/i2c/busses/i2c-hydra.c          |    2 
 drivers/i2c/busses/i2c-i801.c           |    6 
 drivers/i2c/busses/i2c-i810.c           |    2 
 drivers/i2c/busses/i2c-ibm_iic.c        |    8 
 drivers/i2c/busses/i2c-ite.c            |   24 
 drivers/i2c/busses/i2c-ixp2000.c        |  171 ++++++
 drivers/i2c/busses/i2c-keywest.c        |    7 
 drivers/i2c/busses/i2c-mpc.c            |  392 +++++++++++++++
 drivers/i2c/busses/i2c-nforce2.c        |    5 
 drivers/i2c/busses/i2c-parport-light.c  |    4 
 drivers/i2c/busses/i2c-parport.h        |    2 
 drivers/i2c/busses/i2c-pca-isa.c        |  184 +++++++
 drivers/i2c/busses/i2c-piix4.c          |    2 
 drivers/i2c/busses/i2c-prosavage.c      |    2 
 drivers/i2c/busses/i2c-savage4.c        |    2 
 drivers/i2c/busses/i2c-sis5595.c        |    6 
 drivers/i2c/busses/i2c-sis630.c         |   17 
 drivers/i2c/busses/i2c-sis96x.c         |    2 
 drivers/i2c/busses/i2c-via.c            |    2 
 drivers/i2c/busses/i2c-viapro.c         |    8 
 drivers/i2c/busses/i2c-voodoo3.c        |    2 
 drivers/i2c/busses/scx200_acb.c         |    6 
 drivers/i2c/busses/scx200_i2c.c         |   10 
 drivers/i2c/chips/Kconfig               |   15 
 drivers/i2c/chips/Makefile              |    1 
 drivers/i2c/chips/adm1021.c             |    2 
 drivers/i2c/chips/adm1025.c             |    2 
 drivers/i2c/chips/asb100.c              |    5 
 drivers/i2c/chips/ds1621.c              |    2 
 drivers/i2c/chips/eeprom.c              |    2 
 drivers/i2c/chips/it87.c                |   60 ++
 drivers/i2c/chips/lm83.c                |   29 -
 drivers/i2c/chips/lm85.c                |    5 
 drivers/i2c/chips/pcf8591.c             |    2 
 drivers/i2c/chips/rtc8564.c             |    4 
 drivers/i2c/chips/smsc47m1.c            |  579 +++++++++++++++++++++++
 drivers/i2c/chips/via686a.c             |    4 
 drivers/i2c/chips/w83627hf.c            |   12 
 drivers/i2c/chips/w83781d.c             |    9 
 drivers/i2c/i2c-sensor-detect.c         |  175 ++++++
 drivers/i2c/i2c-sensor-vid.c            |   99 +++
 drivers/i2c/i2c-sensor.c                |  167 ------
 drivers/ide/pci/aec62xx.c               |    2 
 drivers/ide/pci/alim15x3.c              |    2 
 drivers/ide/pci/amd74xx.c               |    2 
 drivers/ide/pci/atiixp.c                |    2 
 drivers/ide/pci/cmd64x.c                |    2 
 drivers/ide/pci/cs5520.c                |    2 
 drivers/ide/pci/cy82c693.c              |    2 
 drivers/ide/pci/generic.c               |    2 
 drivers/ide/pci/hpt34x.c                |    2 
 drivers/ide/pci/hpt366.c                |    4 
 drivers/ide/pci/it8172.c                |    2 
 drivers/ide/pci/ns87415.c               |    2 
 drivers/ide/pci/opti621.c               |    2 
 drivers/ide/pci/pdc202xx_new.c          |    2 
 drivers/ide/pci/pdc202xx_old.c          |    2 
 drivers/ide/pci/piix.c                  |    2 
 drivers/ide/pci/rz1000.c                |    2 
 drivers/ide/pci/sc1200.c                |    2 
 drivers/ide/pci/serverworks.c           |    2 
 drivers/ide/pci/sgiioc4.c               |    2 
 drivers/ide/pci/siimage.c               |    2 
 drivers/ide/pci/sis5513.c               |    2 
 drivers/ide/pci/sl82c105.c              |    2 
 drivers/ide/pci/slc90e66.c              |    2 
 drivers/ide/pci/triflex.c               |    2 
 drivers/ide/pci/trm290.c                |    2 
 drivers/ide/pci/via82cxxx.c             |    2 
 drivers/input/gameport/cs461x.c         |    2 
 drivers/input/gameport/emu10k1-gp.c     |    2 
 drivers/input/gameport/fm801-gp.c       |    2 
 drivers/input/gameport/vortex.c         |    2 
 drivers/media/dvb/b2c2/skystar2.c       |    2 
 drivers/parisc/superio.c                |    2 
 drivers/pci/hotplug/Kconfig             |   12 
 drivers/pci/hotplug/Makefile            |    1 
 drivers/pci/hotplug/acpiphp.h           |   16 
 drivers/pci/hotplug/acpiphp_core.c      |  127 +++--
 drivers/pci/hotplug/acpiphp_glue.c      |   14 
 drivers/pci/hotplug/acpiphp_ibm.c       |  474 ++++++++++++++++++
 drivers/pci/hotplug/cpci_hotplug_core.c |   18 
 drivers/pci/hotplug/ibmphp.h            |    6 
 drivers/pci/hotplug/ibmphp_core.c       |    4 
 drivers/pci/hotplug/ibmphp_hpc.c        |   20 
 drivers/pci/hotplug/pciehp_hpc.c        |    4 
 drivers/pci/hotplug/rpaphp_core.c       |    8 
 drivers/pci/hotplug/rpaphp_pci.c        |   21 
 drivers/pci/hotplug/rpaphp_slot.c       |   12 
 drivers/pci/hotplug/shpchp_hpc.c        |    4 
 drivers/pci/pci.c                       |    7 
 drivers/pci/pci.ids                     |  546 +++++++++++++++------
 drivers/pci/probe.c                     |    2 
 drivers/pci/quirks.c                    |  387 +++++++--------
 drivers/pci/setup-bus.c                 |    5 
 drivers/w1/Kconfig                      |   26 +
 drivers/w1/Makefile                     |    7 
 drivers/w1/ds_w1_bridge.c               |  182 +++++++
 drivers/w1/dscore.c                     |  803 +++++++++++++++++++++++++++++++-
 drivers/w1/dscore.h                     |  173 ++++++
 drivers/w1/matrox_w1.c                  |    2 
 drivers/w1/w1.c                         |  286 +++++++++--
 drivers/w1/w1.h                         |   19 
 drivers/w1/w1_family.c                  |   11 
 drivers/w1/w1_family.h                  |    2 
 drivers/w1/w1_int.c                     |   16 
 drivers/w1/w1_io.c                      |   77 ++-
 drivers/w1/w1_io.h                      |    3 
 drivers/w1/w1_netlink.h                 |   15 
 drivers/w1/w1_smem.c                    |  122 ++++
 drivers/w1/w1_therm.c                   |  107 ++--
 include/asm-generic/vmlinux.lds.h       |   10 
 include/asm-ppc/fsl_ocp.h               |    2 
 include/linux/i2c-algo-pca.h            |   17 
 include/linux/i2c-id.h                  |    4 
 include/linux/i2c-vid.h                 |    5 
 include/linux/i2c.h                     |    4 
 include/linux/moduleparam.h             |    4 
 include/linux/pci.h                     |   26 -
 include/linux/pci_ids.h                 |   25 
 kernel/module.c                         |   13 
 kernel/params.c                         |    3 
 185 files changed, 5451 insertions(+), 1363 deletions(-)
-----

<buytenh:wantstofly.org>:
  o PCI: more New PCI vendor/device ID for Radisys ENP-2611 board

<dwmw2:shinybook.infradead.org>:
  o PCI quirks -- other architectures
  o PCI quirks -- ppc64
  o PCI quirks -- parisc
  o [3/3] PCI quirks -- i386
  o [2/3] PCI quirks -- PPC
  o [1/3] Split pci quirks array to allow separate declarations

<killekulla:rdrz.de>:
  o PCI: fix PCI access mode dependences in arch/i386/Kconfig again
  o PCI: fix PCI access mode dependences in arch/i386/Kconfig

<nacc:us.ibm.com>:
  o PCI: replace schedule_timeout() with msleep()
  o I2C: scx200_acb: replace schedule_timeout() with msleep()
  o I2C: i2c-nforce2: replace schedule_timeout() with msleep()
  o I2C: i2c-ite: replace schedule_timeout() with msleep()
  o I2C: i2c-algo-pcf: replace schedule_timeout() with msleep()
  o I2C: i2c-keywest: replace schedule_timeout() with msleep()
  o PCI Hotplug: shpchp_hpc: replace schedule_timeout() with msleep()
  o PCI Hotplug: ibmphp_hpc: replace long_delay() with msleep()
  o PCI Hotplug: ibmphp_core: replace long_delay() with msleep()
  o PCI Hotplug: ibmphp: remove long_delay
  o PCI Hotplug: cpci_hotplug_core: replace schedule_timeout() with msleep()

<r.marek:sh.cvut.cz>:
  o I2C: automatic VRM detection part2
  o I2C: automatic VRM detection part1

<vernux:us.ibm.com>:
  o PCI Hotplug: acpiphp extension for 2.6.7 part 2
  o PCI Hotplug: acpiphp extension for 2.6.7, part 1

Adrian Cox:
  o I2C: bus driver for multiple PowerPCs

Alexander Malysh:
  o I2C: new device for sis630

Andrew Morton:
  o I2C: scx200_i2c build fix

Bjorn Helgaas:
  o PCI: Document pci_disable_device()

Deepak Saxena:
  o Remove spaces from Skystar2 pci_driver.name field
  o Remove spaces from PCI gameport pci_driver.name fields
  o Remove spaces from PCI I2C pci_driver.name fields
  o Remove spaces from PCI IDE pci_driver.name field
  o [5/3][ARM] PCI quirks update for ARM
  o I2C: Add Intel IXP2000 GPIO-based I2C adapter

Domen Puncer:
  o PCI: use list_for_each() drivers/pci/setup-bus.c
  o PCI: use list_for_each() i386/pci/common.c
  o PCI: use list_for_each() i386/pci/pcbios.c

Dominik Brodowski:
  o I2C: activate SMBus device on hp d300l

Evgeniy Polyakov:
  o w1: Added dynamic slave removal mechanism. Fixed bug when we have multiple slave with different families
  o w1: Added driver for Dallas' DS9490* USB <-> W1 master
  o w1: Added  w1_smem.c - driver for simple 64bit ROM devices
  o w1: Spelling fix
  o w1: Debug output cleanup. memcpy instead of direct structure copying
  o w1: Netlink update - changed event generating/processing
  o w1: Changed define for W1_FAMILY_SMEM
  o w1: Changed printing format for slave names
  o w1: Added w1_check_family()
  o w1: Added w1_read_block() and w1_write_block() callbacks
  o w1: attributes split, timeout unit changed

Greg Kroah-Hartman:
  o PCI Hotplug: fix compiler warnings in pciehp driver
  o W1: removed some unneeded global symbols from the w1_smem module
  o W1: fix some improper '{' style code
  o MODULE: delete local static copy of param_set_byte as we now have a real version of it
  o I2C: rename i2c-sensor.c file to prepare for Rudolf's VRM patch
  o I2C: fix up the order of bus drivers in the Kconfig and Makefile
  o I2C: convert all drivers from MODULE_PARM to module_param
  o MODULE: add byte type of module paramater, like the comments say we support
  o PCI: oops, forgot to check in the pci.h changes so that the quirk cleanups will work
  o PCI: clean up code formatting of quirks.c
  o PCI: fix compiler warning in quirks file, and other minor quirks cleanup
  o PCI Hotplug: fix build warnings due to msleep() patches
  o PCI: update pci.ids from sf.net site

Ian Campbell:
  o I2C: algorithm and bus driver for PCA9564

Jean Delvare:
  o I2C: fix for previous lm83 driver update
  o I2C: port smsc47m1 to 2.6
  o I2C: update the lm83 driver
  o I2C: Fix debug in w83781d driver

John Rose:
  o PCI: rpaphp build break - remove eeh register

Karol Kozimor:
  o PCI: ASUS L3C SMBus fixup

Linda Xie:
  o PCI Hotplug: rpaphp_get_power_level bug fix
  o PCI Hotplug: rpaphp_add_slot.patch

Ralf Bächle:
  o [4/3] PCI quirks -- MIPS

Roger Luethi:
  o PCI: saved_config_space -> u32

