Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbWF0Qgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbWF0Qgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWF0Qgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:36:31 -0400
Received: from ns2.suse.de ([195.135.220.15]:29930 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161172AbWF0Qga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:36:30 -0400
Date: Tue, 27 Jun 2006 09:33:17 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] 64bit resource patches for 2.6.17
Message-ID: <20060627163317.GA31073@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a set of patches for 2.6.17 that move the resource size to be
64bits.  This patch series has gone though many different iterations, by
many different people, and been tested heavily in the -mm tree for quite
some time (so Andrew says it's finally time to send it to you.)

The main reason someone finally implemented it was to fix some issues
with kexec and kdump on 32bit machines with large amounts of memory.
That fix is the last one in this series and only came to 2 lines of
code.

The majority of the changes in this series is fixing up the odd places
where people were printing the resource start and end values to the
kernel log.  If it weren't for noisy drivers, this series would be much
smaller :)

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 arch/alpha/kernel/pci.c                    |    4 +-
 arch/arm/kernel/bios32.c                   |    6 ++-
 arch/arm/kernel/setup.c                    |   42 +++++++++++++++++++----
 arch/cris/arch-v32/drivers/pci/bios.c      |    4 +-
 arch/frv/mb93090-mb00/pci-frv.c            |    4 +-
 arch/i386/Kconfig                          |    1 +
 arch/i386/kernel/efi.c                     |    6 ++-
 arch/i386/kernel/setup.c                   |    2 +
 arch/i386/pci/i386.c                       |    4 +-
 arch/ia64/pci/pci.c                        |    2 +
 arch/m68knommu/kernel/comempci.c           |    3 +-
 arch/mips/pci/pci.c                        |    4 +-
 arch/mips/pmc-sierra/yosemite/ht.c         |    4 +-
 arch/parisc/kernel/pci.c                   |    2 +
 arch/powerpc/kernel/pci_32.c               |   47 +++++++++++++------------
 arch/powerpc/kernel/pci_64.c               |    4 +-
 arch/powerpc/platforms/83xx/pci.c          |    5 ++-
 arch/powerpc/platforms/85xx/pci.c          |    5 ++-
 arch/powerpc/platforms/chrp/pci.c          |    4 +-
 arch/powerpc/platforms/maple/pci.c         |    5 ++-
 arch/powerpc/platforms/powermac/pci.c      |    5 ++-
 arch/ppc/kernel/pci.c                      |   52 ++++++++++++++++------------
 arch/sh/boards/mpc1211/pci.c               |    4 +-
 arch/sh/boards/overdrive/galileo.c         |    2 +
 arch/sh/drivers/pci/pci.c                  |    6 ++-
 arch/sh64/kernel/pcibios.c                 |    4 +-
 arch/sparc/kernel/ioport.c                 |    8 +++-
 arch/sparc/kernel/pcic.c                   |    2 +
 arch/sparc64/kernel/pci.c                  |    2 +
 arch/v850/kernel/rte_mb_a_pci.c            |    2 +
 arch/xtensa/kernel/pci.c                   |    6 ++-
 drivers/amba/bus.c                         |    5 ++-
 drivers/atm/ambassador.c                   |    3 +-
 drivers/atm/firestream.c                   |    5 ++-
 drivers/block/sx8.c                        |    5 ++-
 drivers/char/applicom.c                    |    9 +++--
 drivers/ide/pci/aec62xx.c                  |    3 +-
 drivers/ide/pci/cmd64x.c                   |    3 +-
 drivers/ide/pci/hpt34x.c                   |    2 +
 drivers/ide/pci/pdc202xx_new.c             |    4 +-
 drivers/ide/pci/pdc202xx_old.c             |    4 +-
 drivers/ieee1394/ohci1394.c                |   17 +++++----
 drivers/infiniband/hw/ipath/ipath_driver.c |    8 ++--
 drivers/infiniband/hw/mthca/mthca_main.c   |    5 ++-
 drivers/input/serio/ct82c710.c             |    6 ++-
 drivers/isdn/hisax/hfc_pci.c               |    2 +
 drivers/isdn/hisax/telespci.c              |    5 ++-
 drivers/macintosh/macio_asic.c             |    4 +-
 drivers/media/video/bt8xx/bttv-driver.c    |   10 +++--
 drivers/media/video/cx88/cx88-alsa.c       |    8 ++--
 drivers/media/video/cx88/cx88-core.c       |    4 +-
 drivers/media/video/cx88/cx88-mpeg.c       |    4 +-
 drivers/media/video/cx88/cx88-video.c      |    4 +-
 drivers/media/video/saa7134/saa7134-core.c |    8 ++--
 drivers/message/i2o/iop.c                  |   14 ++++----
 drivers/mmc/mmci.c                         |    4 +-
 drivers/mtd/devices/pmc551.c               |    8 ++--
 drivers/mtd/maps/amd76xrom.c               |    5 ++-
 drivers/mtd/maps/ichxrom.c                 |    5 ++-
 drivers/mtd/maps/scx200_docflash.c         |    5 ++-
 drivers/mtd/maps/sun_uflash.c              |    5 ++-
 drivers/net/3c59x.c                        |    6 ++-
 drivers/net/8139cp.c                       |   11 +++---
 drivers/net/8139too.c                      |    6 ++-
 drivers/net/e100.c                         |    4 +-
 drivers/net/skge.c                         |    4 +-
 drivers/net/sky2.c                         |    6 ++-
 drivers/net/tulip/de2104x.c                |    9 +++--
 drivers/net/tulip/tulip_core.c             |    6 ++-
 drivers/net/typhoon.c                      |    5 ++-
 drivers/net/wan/dscc4.c                    |   12 +++---
 drivers/net/wan/pc300_drv.c                |    4 +-
 drivers/pci/bus.c                          |   10 +++--
 drivers/pci/hotplug/cpcihp_zt5550.c        |    9 +++--
 drivers/pci/hotplug/cpqphp_core.c          |   10 +++--
 drivers/pci/hotplug/pciehp_hpc.c           |    5 ++-
 drivers/pci/hotplug/shpchp_sysfs.c         |   18 ++++++----
 drivers/pci/pci-sysfs.c                    |    4 +-
 drivers/pci/pci.c                          |    6 ++-
 drivers/pci/pci.h                          |    6 ++-
 drivers/pci/proc.c                         |   20 ++++-------
 drivers/pci/rom.c                          |   10 +++--
 drivers/pci/setup-bus.c                    |    6 ++-
 drivers/pci/setup-res.c                    |   34 +++++++++++-------
 drivers/pcmcia/i82365.c                    |    5 ++-
 drivers/pcmcia/pd6729.c                    |    3 +-
 drivers/pcmcia/rsrc_nonstatic.c            |   26 ++++++++------
 drivers/pcmcia/tcic.c                      |    5 ++-
 drivers/pnp/interface.c                    |    8 ++--
 drivers/pnp/manager.c                      |   15 +++++---
 drivers/pnp/resource.c                     |    8 ++--
 drivers/scsi/sata_via.c                    |    8 ++--
 drivers/serial/8250_pci.c                  |    4 +-
 drivers/usb/host/sl811-hcd.c               |   10 ++++-
 drivers/video/console/vgacon.c             |   12 +++---
 include/asm-arm/mach/pci.h                 |    2 +
 include/asm-powerpc/pci.h                  |    2 +
 include/asm-ppc/pci.h                      |    2 +
 include/linux/ioport.h                     |   27 +++++++++------
 include/linux/pci.h                        |   13 ++++---
 include/linux/pnp.h                        |    7 +++-
 include/linux/types.h                      |    7 ++++
 kernel/resource.c                          |   52 +++++++++++++++-------------
 mm/Kconfig                                 |    6 +++
 sound/arm/aaci.c                           |    5 ++-
 sound/drivers/mpu401/mpu401.c              |    5 ++-
 sound/isa/es18xx.c                         |    3 +-
 sound/isa/gus/interwave.c                  |    8 ++--
 sound/isa/sb/sb16.c                        |    3 +-
 sound/oss/forte.c                          |    5 ++-
 sound/pci/bt87x.c                          |    5 ++-
 sound/pci/sonicvibes.c                     |    4 +-
 sound/ppc/pmac.c                           |   14 ++++----
 sound/sparc/cs4231.c                       |    4 +-
 sound/sparc/dbri.c                         |    4 +-
 115 files changed, 527 insertions(+), 391 deletions(-)

---------------

Greg Kroah-Hartman:
      64bit resource: C99 changes for struct resource declarations
      64bit resource: fix up printks for resources in sound drivers
      64bit resource: fix up printks for resources in networks drivers
      64bit resource: fix up printks for resources in pci core and hotplug drivers
      64bit resource: fix up printks for resources in mtd drivers
      64bit resource: fix up printks for resources in ide drivers
      64bit resource: fix up printks for resources in video drivers
      64bit resource: fix up printks for resources in pcmcia drivers
      64bit resource: fix up printks for resources in arch and core code
      64bit resource: fix up printks for resources in misc drivers
      64bit resource: introduce resource_size_t for the start and end of struct resource
      64bit resource: change resource core to use resource_size_t
      64bit resource: change pci core and arch code to use resource_size_t
      64bit resource: change pnp core to use resource_size_t
      64bit Resource: convert a few remaining drivers to use resource_size_t where needed
      64bit Resource: finally enable 64bit resource sizes

Vivek Goyal:
      i386: export memory more than 4G through /proc/iomem

