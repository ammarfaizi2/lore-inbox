Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbTFJSTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTFJSTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:19:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:20112 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262166AbTFJSTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:19:11 -0400
Date: Tue, 10 Jun 2003 11:33:34 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Yet more PCI fixes for 2.5.70
Message-ID: <20030610183334.GC18182@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some more PCI changes against the latest 2.5.70 bk tree.  They contain
the following:
	- remove almost all usages of pci_present().  There are only 2
	  users of this function left, and I'll continue to work to
	  remove them.
	- add sysfs support for pci domains.  This is from Matthew
	  Wilcox, and is a bit different from the last patch he sent to
	  lkml.  This one supports sparc64 and ppc64 and has been
	  blessed by David Miller.
	- updated pci pool CONFIG_DEBUG_SLAB logic
	- removed pci_for_each_bus() macro, and added a
	  pci_find_next_bus() function to prevent people from directly
	  walking the PCI bus lists.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 arch/alpha/Kconfig                  |    4 +
 arch/alpha/kernel/pci.c             |    8 --
 arch/i386/pci/common.c              |    6 -
 arch/ia64/Kconfig                   |    4 +
 arch/ia64/hp/common/sba_iommu.c     |    6 -
 arch/ia64/pci/pci.c                 |    4 -
 arch/ppc/Kconfig                    |    4 +
 arch/ppc/kernel/pci.c               |   10 ---
 arch/ppc64/Kconfig                  |    4 +
 arch/ppc64/kernel/pci.c             |    6 -
 arch/sparc/kernel/ebus.c            |    3 
 arch/sparc64/Kconfig                |    4 +
 arch/sparc64/kernel/ebus.c          |    3 
 arch/sparc64/kernel/pci.c           |    6 -
 drivers/atm/ambassador.c            |    3 
 drivers/atm/fore200e.c              |    5 -
 drivers/atm/nicstar.c               |    5 -
 drivers/char/epca.c                 |   13 ----
 drivers/char/ip2main.c              |   58 ++++++++----------
 drivers/char/isicom.c               |    2 
 drivers/char/istallion.c            |    3 
 drivers/char/rio/rio_linux.c        |    3 
 drivers/char/rocket.c               |    8 --
 drivers/char/specialix.c            |    2 
 drivers/char/stallion.c             |    3 
 drivers/char/sx.c                   |  116 ++++++++++++++++++------------------
 drivers/i2c/i2c-elektor.c           |    2 
 drivers/ide/ide.c                   |    5 -
 drivers/isdn/eicon/Divas_mod.c      |   12 ---
 drivers/isdn/hysdn/hysdn_init.c     |    4 -
 drivers/media/radio/radio-maestro.c |    2 
 drivers/mtd/devices/pmc551.c        |    5 -
 drivers/net/acenic.c                |    3 
 drivers/net/dgrs.c                  |   80 +++++++++++-------------
 drivers/net/fc/iph5526.c            |    6 -
 drivers/net/hp100.c                 |    6 +
 drivers/net/saa9730.c               |   39 +++++-------
 drivers/net/sk98lin/skge.c          |    3 
 drivers/net/skfp/skfddi.c           |    4 -
 drivers/net/tc35815.c               |    3 
 drivers/net/tulip/de4x5.c           |    6 -
 drivers/net/wan/lmc/lmc_main.c      |    8 --
 drivers/net/wan/lmc/lmc_ver.h       |    2 
 drivers/net/wan/sbni.c              |    3 
 drivers/net/wan/sdladrv.c           |    8 --
 drivers/pci/pci.c                   |    4 -
 drivers/pci/pool.c                  |   12 ++-
 drivers/pci/power.c                 |   18 +----
 drivers/pci/probe.c                 |    3 
 drivers/pci/proc.c                  |   24 +++----
 drivers/pci/search.c                |   25 ++++++-
 drivers/pci/syscall.c               |    2 
 drivers/scsi/3w-xxxx.c              |    6 -
 drivers/scsi/BusLogic.c             |    3 
 drivers/scsi/aic7xxx_old.c          |    3 
 drivers/scsi/atp870u.c              |    4 -
 drivers/scsi/cpqfcTSinit.c          |    6 -
 drivers/scsi/dmx3191d.c             |    6 -
 drivers/scsi/eata.c                 |    6 -
 drivers/scsi/gdth.c                 |    4 -
 drivers/scsi/inia100.c              |    2 
 drivers/scsi/pci2000.c              |    7 --
 drivers/scsi/pci2220i.c             |    6 -
 drivers/scsi/qla1280.c              |    6 -
 drivers/scsi/qlogicfc.c             |    5 -
 drivers/scsi/qlogicisp.c            |    5 -
 drivers/scsi/sym53c8xx.c            |    8 --
 drivers/scsi/sym53c8xx_2/sym_glue.c |    6 -
 drivers/scsi/sym53c8xx_comm.h       |    8 --
 drivers/scsi/tmscsim.c              |    2 
 drivers/telephony/ixj.c             |    9 --
 drivers/video/pm2fb.c               |    4 -
 include/asm-alpha/pci.h             |    5 -
 include/asm-arm/pci.h               |    8 --
 include/asm-h8300/pci.h             |    3 
 include/asm-i386/pci.h              |    6 -
 include/asm-ia64/pci.h              |    5 -
 include/asm-m68k/pci.h              |    3 
 include/asm-mips/pci.h              |    3 
 include/asm-mips64/pci.h            |    5 -
 include/asm-parisc/pci.h            |    3 
 include/asm-ppc/pci-bridge.h        |    2 
 include/asm-ppc/pci.h               |    2 
 include/asm-ppc64/pci.h             |    3 
 include/asm-sh/pci.h                |    3 
 include/asm-sparc/pci.h             |    3 
 include/asm-sparc64/parport.h       |    3 
 include/asm-sparc64/pci.h           |    2 
 include/asm-v850/rte_cb.h           |    1 
 include/asm-x86_64/pci.h            |    6 -
 include/linux/pci.h                 |   14 +++-
 sound/oss/cmpci.c                   |    4 -
 sound/oss/cs4281/cs4281m.c          |    5 -
 sound/oss/cs46xx.c                  |    5 -
 sound/oss/es1370.c                  |    2 
 sound/oss/es1371.c                  |    2 
 sound/oss/esssolo1.c                |    2 
 sound/oss/i810_audio.c              |    3 
 sound/oss/ite8172.c                 |    2 
 sound/oss/maestro3.c                |    3 
 sound/oss/nec_vrc5477.c             |    2 
 sound/oss/rme96xx.c                 |    3 
 sound/oss/skeleton.c                |    4 -
 sound/oss/sonicvibes.c              |    2 
 sound/oss/trident.c                 |    3 
 105 files changed, 272 insertions(+), 538 deletions(-)
-----

David Brownell:
  o PCI: pci pool, poison more like slab code

Greg Kroah-Hartman:
  o PCI: remove some pci_bus_b() calls in drivers/pci/power.c
  o PCI: remove pci_bus_b() call in arch/i386/pci/common.c
  o PCI: remove pci_for_each_bus() macro as there are now no more users of it
  o PCI: remove pci_for_each_bus() usage from drivers/pci/pci.c
  o PCI: remove pci_for_each_bus() usage from arch/ia64/hp/common/sba_iommu.c
  o PCI: add pci_find_next_bus() function to prevent people from walking pci bus lists themselves
  o PCI: remove pci_present() from sound/oss/trident.c
  o PCI: remove pci_present() from sound/oss/sonicvibes.c
  o PCI: remove pci_present() from sound/oss/skeleton.c
  o PCI: remove pci_present() from sound/oss/rme96xx.c
  o PCI: remove pci_present() from sound/oss/nec_vrc5477.c
  o PCI: remove pci_present() from sound/oss/maestro3.c
  o PCI: remove pci_present() from sound/oss/ite8172.c
  o PCI: remove pci_present() from sound/oss/i810_audio.c
  o PCI: remove pci_present() from sound/oss/esssolo1.c
  o PCI: remove pci_present() from sound/oss/es1371.c
  o PCI: remove pci_present() from sound/oss/es1370.c
  o PCI: remove pci_present() from sound/oss/cs46xx.c
  o PCI: remove pci_present() from sound/oss/cs4281/cs4281m.c
  o PCI: remove pci_present() from sound/oss/cmpci.c
  o PCI: remove pci_present() from include/asm-sparc64/parport.h
  o PCI: remove pci_present() from drivers/video/pm2fb.c
  o PCI: remove pci_present() from drivers/telephony/ixj.c
  o PCI: remove pci_present() from drivers/scsi/tmscsim.c
  o PCI: remove pci_present() from drivers/scsi/sym53c8xx_comm.h
  o PCI: remove pci_present() from drivers/scsi/sym53c8xx_2/sym_glue.c
  o PCI: remove pci_present() from drivers/scsi/sym53c8xx.c
  o PCI: remove pci_present() from drivers/scsi/qlogicisp.c
  o PCI: remove pci_present() from drivers/scsi/qlogicfc.c
  o PCI: remove pci_present() from drivers/scsi/qla1280.c
  o PCI: remove pci_present() from drivers/scsi/pci2220i.c
  o PCI: remove pci_present() from drivers/scsi/pci2000.c
  o PCI: remove pci_present() from drivers/scsi/inia100.c
  o PCI: remove pci_present() from drivers/scsi/gdth.c
  o PCI: remove pci_present() from drivers/scsi/eata.c
  o PCI: remove pci_present() from drivers/scsi/dmx3191d.c
  o PCI: remove pci_present() from drivers/scsi/cpqfcTSinit.c
  o PCI: remove pci_present() from drivers/scsi/atp870u.c
  o PCI: remove pci_present() from drivers/scsi/aic7xxx_old.c
  o PCI: remove pci_present() from drivers/scsi/BusLogic.c
  o PCI: remove pci_present() from drivers/scsi/3w-xxxx.c
  o PCI: remove pci_present() from drivers/pci/syscall.c
  o PCI: remove pci_present() from drivers/pci/proc.c
  o PCI: remove pci_present() from drivers/net/wan/sdladrv.c
  o PCI: remove pci_present() from drivers/net/wan/sbni.c
  o PCI: remove pci_present() from drivers/net/wan/lmc/lmc_main.c
  o PCI: remove pci_present() from drivers/net/tulip/de4x5.c
  o PCI: remove pci_present() from drivers/net/tc35815.c
  o PCI: remove pci_present() from drivers/net/skfp/skfddi.c
  o PCI: remove pci_present() from drivers/net/sk98lin/skge.c
  o PCI: remove pci_present() from drivers/net/saa9730.c
  o PCI: remove pci_present() from drivers/net/hp100.c
  o PCI: remove pci_present() from drivers/net/fc/iph5526.c
  o PCI: remove pci_present() from drivers/net/dgrs.c
  o PCI: remove pci_present() from drivers/net/acenic.c
  o PCI: remove pci_present() from drivers/mtd/devices/pmc551.c
  o PCI: remove pci_present() from drivers/media/radio/radio-maestro.c
  o PCI: remove pci_present() from drivers/isdn/hysdn/hysdn_init.c
  o PCI: remove pci_present() from drivers/isdn/eicon/Divas_mod.c
  o PCI: remove pci_present() from drivers/ide/ide.c
  o PCI: remove pci_present() from drivers/i2c/i2c-elektor.c
  o PCI: remove pci_present() from drivers/char/sx.c
  o PCI: remove pci_present() from drivers/char/stallion.c
  o PCI: remove pci_present() from drivers/char/specialix.c
  o PCI: remove pci_present() from drivers/char/rocket.c
  o PCI: remove pci_present() from drivers/char/rio/rio_linux.c
  o PCI: remove pci_present() from drivers/char/istallion.c
  o PCI: remove pci_present() from drivers/char/isicom.c
  o PCI: remove pci_present() from drivers/char/ip2main.c
  o PCI: remove pci_present() from drivers/char/epca.c
  o PCI: remove pci_present() from drivers/atm/nicstar.c
  o PCI: remove pci_present() from drivers/atm/fore200e.c
  o PCI: remove pci_present() from drivers/atm/ambassador.c
  o PCI: remove pci_present() from arch/sparc64/kernel/ebus.c
  o PCI: remove pci_present() from arch/sparc/kernel/ebus.c

Matthew Wilcox:
  o PCI: domain support for sysfs

