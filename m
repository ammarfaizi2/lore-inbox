Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWAFGig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWAFGig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 01:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWAFGig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 01:38:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:46482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932644AbWAFGif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 01:38:35 -0500
Date: Thu, 5 Jan 2006 22:37:16 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.15
Message-ID: <20060106063716.GA4425@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI patches against your latest git tree.  They have all
been in the -mm tree for a while with no problems.

The thing that touches so many different files are the change from the
pci_module_init() to pci_register_driver() that was done by Richard
Knutsson.  Other big stuff is the addition of the pci error recovery
framework, after many different revisions and reworks.
There are also some pci hotplug fixes, and quirks added.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/feature-removal-schedule.txt    |    7 
 Documentation/filesystems/sysfs-pci.txt       |   21 +-
 Documentation/pci-error-recovery.txt          |  246 ++++++++++++++++++++++++++
 MAINTAINERS                                   |    7 
 arch/alpha/kernel/sys_alcor.c                 |    3 
 arch/alpha/kernel/sys_sio.c                   |    6 
 arch/frv/mb93090-mb00/pci-frv.c               |    8 
 arch/frv/mb93090-mb00/pci-irq.c               |    4 
 arch/i386/kernel/scx200.c                     |    2 
 arch/i386/pci/acpi.c                          |   29 ++-
 arch/i386/pci/common.c                        |   19 +-
 arch/i386/pci/fixup.c                         |    7 
 arch/i386/pci/irq.c                           |   42 ++--
 arch/mips/vr41xx/common/vrc4173.c             |    2 
 arch/ppc/kernel/pci.c                         |   21 +-
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c  |   11 -
 arch/sparc64/kernel/ebus.c                    |   15 -
 arch/x86_64/pci/k8-bus.c                      |    6 
 drivers/acpi/pci_irq.c                        |    7 
 drivers/block/DAC960.c                        |    2 
 drivers/block/cciss.c                         |    2 
 drivers/block/sx8.c                           |    2 
 drivers/block/umem.c                          |    2 
 drivers/media/radio/radio-gemtek-pci.c        |    2 
 drivers/media/radio/radio-maxiradio.c         |    2 
 drivers/media/video/bttv-driver.c             |    2 
 drivers/media/video/saa7134/saa7134-core.c    |    2 
 drivers/net/3c59x.c                           |    2 
 drivers/net/8139cp.c                          |    2 
 drivers/net/8139too.c                         |    2 
 drivers/net/acenic.c                          |    2 
 drivers/net/amd8111e.c                        |    2 
 drivers/net/arcnet/com20020-pci.c             |    2 
 drivers/net/b44.c                             |    2 
 drivers/net/bnx2.c                            |    2 
 drivers/net/cassini.c                         |    2 
 drivers/net/chelsio/cxgb2.c                   |    2 
 drivers/net/defxx.c                           |    2 
 drivers/net/dl2k.c                            |    2 
 drivers/net/e100.c                            |   72 +++++++
 drivers/net/e1000/e1000_main.c                |  103 ++++++++++
 drivers/net/eepro100.c                        |    2 
 drivers/net/epic100.c                         |    2 
 drivers/net/fealnx.c                          |    2 
 drivers/net/forcedeth.c                       |    2 
 drivers/net/hp100.c                           |    2 
 drivers/net/irda/donauboe.c                   |    2 
 drivers/net/irda/vlsi_ir.c                    |    2 
 drivers/net/ixgb/ixgb_main.c                  |   88 +++++++++
 drivers/net/natsemi.c                         |    2 
 drivers/net/ne2k-pci.c                        |    2 
 drivers/net/ns83820.c                         |    2 
 drivers/net/pci-skeleton.c                    |    2 
 drivers/net/pcnet32.c                         |    2 
 drivers/net/r8169.c                           |    2 
 drivers/net/rrunner.c                         |    2 
 drivers/net/s2io.c                            |    2 
 drivers/net/saa9730.c                         |    2 
 drivers/net/sis190.c                          |    2 
 drivers/net/sis900.c                          |    2 
 drivers/net/sk98lin/skge.c                    |    2 
 drivers/net/skfp/skfddi.c                     |    2 
 drivers/net/skge.c                            |    2 
 drivers/net/starfire.c                        |    2 
 drivers/net/sundance.c                        |    2 
 drivers/net/sungem.c                          |    2 
 drivers/net/tc35815.c                         |    2 
 drivers/net/tg3.c                             |    2 
 drivers/net/tokenring/3c359.c                 |    2 
 drivers/net/tokenring/lanstreamer.c           |    2 
 drivers/net/tokenring/olympic.c               |    2 
 drivers/net/tulip/de2104x.c                   |    2 
 drivers/net/tulip/de4x5.c                     |    2 
 drivers/net/tulip/dmfe.c                      |    2 
 drivers/net/tulip/tulip_core.c                |    2 
 drivers/net/tulip/uli526x.c                   |    2 
 drivers/net/tulip/winbond-840.c               |    2 
 drivers/net/tulip/xircom_tulip_cb.c           |    2 
 drivers/net/typhoon.c                         |    2 
 drivers/net/via-rhine.c                       |    2 
 drivers/net/via-velocity.c                    |    2 
 drivers/net/wan/dscc4.c                       |    2 
 drivers/net/wan/farsync.c                     |    2 
 drivers/net/wan/lmc/lmc_main.c                |    2 
 drivers/net/wan/pc300_drv.c                   |    2 
 drivers/net/wan/pci200syn.c                   |    2 
 drivers/net/wan/wanxl.c                       |    2 
 drivers/net/wireless/atmel_pci.c              |    2 
 drivers/net/wireless/ipw2100.c                |    2 
 drivers/net/wireless/ipw2200.c                |    2 
 drivers/net/wireless/orinoco_nortel.c         |    2 
 drivers/net/wireless/orinoco_pci.c            |    2 
 drivers/net/wireless/orinoco_plx.c            |    2 
 drivers/net/wireless/orinoco_tmd.c            |    2 
 drivers/net/wireless/prism54/islpci_hotplug.c |    2 
 drivers/net/yellowfin.c                       |    2 
 drivers/parport/parport_serial.c              |    2 
 drivers/pci/hotplug/acpiphp_glue.c            |    6 
 drivers/pci/hotplug/cpqphp.h                  |    8 
 drivers/pci/hotplug/cpqphp_core.c             |  127 +++++++------
 drivers/pci/hotplug/cpqphp_ctrl.c             |   28 --
 drivers/pci/hotplug/cpqphp_sysfs.c            |  138 ++++++++++++--
 drivers/pci/hotplug/ibmphp_pci.c              |    2 
 drivers/pci/hotplug/pciehp_core.c             |   92 +++++----
 drivers/pci/hotplug/pciehp_hpc.c              |   19 +-
 drivers/pci/hotplug/pciehp_pci.c              |   52 ++---
 drivers/pci/hotplug/pciehprm_acpi.c           |   13 -
 drivers/pci/hotplug/rpadlpar_core.c           |   27 --
 drivers/pci/hotplug/rpaphp_pci.c              |   47 ----
 drivers/pci/hotplug/shpchp.h                  |    4 
 drivers/pci/hotplug/shpchp_core.c             |   16 +
 drivers/pci/hotplug/shpchp_ctrl.c             |   37 ---
 drivers/pci/hotplug/shpchp_hpc.c              |  138 +++++++++-----
 drivers/pci/hotplug/shpchp_pci.c              |   19 +-
 drivers/pci/pci.c                             |    7 
 drivers/pci/pci.h                             |    5 
 drivers/pci/pcie/portdrv_core.c               |    4 
 drivers/pci/probe.c                           |   49 ++++-
 drivers/pci/proc.c                            |    3 
 drivers/pci/quirks.c                          |   26 ++
 drivers/pci/remove.c                          |    3 
 drivers/pcmcia/vrc4173_cardu.c                |    2 
 drivers/scsi/3w-9xxx.c                        |    2 
 drivers/scsi/3w-xxxx.c                        |    2 
 drivers/scsi/a100u2w.c                        |    2 
 drivers/scsi/ahci.c                           |    2 
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c        |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c        |    2 
 drivers/scsi/ata_piix.c                       |    4 
 drivers/scsi/dc395x.c                         |    2 
 drivers/scsi/dmx3191d.c                       |    2 
 drivers/scsi/ipr.c                            |   94 +++++++++
 drivers/scsi/ips.c                            |    2 
 drivers/scsi/megaraid.c                       |    2 
 drivers/scsi/megaraid/megaraid_sas.c          |    2 
 drivers/scsi/nsp32.c                          |    2 
 drivers/scsi/pdc_adma.c                       |    2 
 drivers/scsi/qla1280.c                        |    2 
 drivers/scsi/qla2xxx/ql2100.c                 |    2 
 drivers/scsi/qla2xxx/ql2200.c                 |    2 
 drivers/scsi/qla2xxx/ql2300.c                 |    2 
 drivers/scsi/qla2xxx/ql2322.c                 |    2 
 drivers/scsi/qla2xxx/ql6312.c                 |    2 
 drivers/scsi/qla2xxx/qla_os.c                 |    2 
 drivers/scsi/sata_mv.c                        |    2 
 drivers/scsi/sata_nv.c                        |    2 
 drivers/scsi/sata_promise.c                   |    2 
 drivers/scsi/sata_qstor.c                     |    2 
 drivers/scsi/sata_sil.c                       |    2 
 drivers/scsi/sata_sil24.c                     |    2 
 drivers/scsi/sata_sis.c                       |    2 
 drivers/scsi/sata_svw.c                       |    2 
 drivers/scsi/sata_sx4.c                       |    2 
 drivers/scsi/sata_uli.c                       |    2 
 drivers/scsi/sata_via.c                       |    2 
 drivers/scsi/sata_vsc.c                       |    2 
 drivers/scsi/sym53c8xx_2/sym_glue.c           |  113 +++++++++++
 drivers/scsi/sym53c8xx_2/sym_glue.h           |    4 
 drivers/scsi/sym53c8xx_2/sym_hipd.c           |   15 +
 drivers/scsi/tmscsim.c                        |    2 
 drivers/serial/serial_txx9.c                  |    2 
 drivers/video/cyblafb.c                       |    2 
 include/asm-i386/pci.h                        |   19 ++
 include/asm-i386/topology.h                   |    2 
 include/asm-x86_64/pci.h                      |   18 +
 include/asm-x86_64/topology.h                 |    2 
 include/linux/pci.h                           |   80 +++++++-
 sound/oss/ad1889.c                            |    2 
 sound/oss/btaudio.c                           |    2 
 sound/oss/cmpci.c                             |    2 
 sound/oss/cs4281/cs4281m.c                    |    2 
 sound/oss/cs46xx.c                            |    2 
 sound/oss/emu10k1/main.c                      |    2 
 sound/oss/es1370.c                            |    2 
 sound/oss/es1371.c                            |    2 
 sound/oss/ite8172.c                           |    2 
 sound/oss/kahlua.c                            |    2 
 sound/oss/maestro.c                           |    2 
 sound/oss/nec_vrc5477.c                       |    2 
 sound/oss/nm256_audio.c                       |    2 
 sound/oss/rme96xx.c                           |    2 
 sound/oss/sonicvibes.c                        |    2 
 sound/oss/ymfpci.c                            |    2 
 sound/pci/cs5535audio/cs5535audio.c           |    2 
 184 files changed, 1635 insertions(+), 568 deletions(-)
Adrian Bunk:
      PCI Hotplug: cpqphp_ctrl.c: remove dead code
      PCI: drivers/pci: some cleanups

Benjamin Herrenschmidt:
      PCI: Export pci_cfg_space_size

Daniel Marjamäki:
      PCI: irq.c: trivial printk and DBG updates

Daniel Yeisley:
      PCI Quirk: 1K I/O space granularity on Intel P64H2

Dominik Brodowski:
      PCI: use bus numbers sparsely, if necessary

Greg Kroah-Hartman:
      drivers/sound/oss: Replace pci_module_init() with pci_register_driver()
      PCI Hotplug: fix up the sysfs file in the compaq pci hotplug driver

Hanna Linder:
      PCI: arch/i386/pci/acpi.c: use for_each_pci_dev

Jeff Garzik:
      x86 PCI domain support: the meat
      x86 PCI domain support: struct pci_sysdata
      x86 PCI domain support: a humble fix

Jesper Juhl:
      PCI: Reduce nr of ptr derefs in drivers/pci/hotplug/cpqphp_core.c
      PCI: Reduce nr of ptr derefs in drivers/pci/hotplug/rpaphp_pci.c
      PCI: Reduce nr of ptr derefs in drivers/pci/hotplug/pciehp_core.c
      PCI: Reduce nr of ptr derefs in drivers/pci/hotplug/pciehprm_acpi.c

Jesse Barnes:
      PCI: document sysfs rom file interface
      PCI: update Toshiba ohci quirk DMI table

Jiri Slaby:
      PCI: pci_find_device remove (ppc/platforms/85xx/mpc85xx_cds_common.c)
      PCI: pci_find_device remove (alpha/kernel/sys_sio.c)
      PCI: pci_find_device remove (sparc64/kernel/ebus.c)
      PCI: pci_find_device remove (alpha/kernel/sys_alcor.c)
      PCI: pci_find_device remove (ppc/kernel/pci.c)
      PCI: pci_find_device remove (frv/mb93090-mb00/pci-frv.c)
      PCI: arch: pci_find_device remove (frv/mb93090-mb00/pci-irq.c)

Jordan, William P:
      PCI Hotplug: ibmphp_pci.c copy-n-paste fix

Kenji Kaneshige:
      shpchp: fix improper reference to Slot Avail Regsister
      shpchp: replace pci_find_slot() with pci_get_slot()
      shpchp: fix improper mmio mapping
      shpchp: fix improper reference to Mode 1 ECC Capability" bit
      shpchp: fix improper write to Command Completion Detect bit
      shpchp: fix improper wait for command completion
      shpchp: Implement get_address callback

Kristen Accardi:
      pci: store PCI_INTERRUPT_PIN in pci_dev
      apci: use pin stored in pci_dev
      pci: call pci_read_irq for bridges
      pci: use pin stored in pci_dev
      acpiphp: only size new bus

linas:
      PCI Error Recovery: header file patch
      PCI Error Recovery: Symbios SCSI device driver
      PCI Error Recovery: e1000 network device driver
      PCI Error Recovery: ixgb network device driver
      PCI Error Recovery: e100 network device driver
      PCI Error Recovery: IPR SCSI device driver

linas@austin.ibm.com:
      PCI Hotplug/powerpc: more removal of duplicated code
      PCI Error Recovery: documentation
      PCI Hotplug/powerpc: remove duplicated code

Rajesh Shah:
      pciehp: allow bridged card hotplug

Richard Knutsson:
      arch: Replace pci_module_init() with pci_register_driver()
      drivers/block: Replace pci_module_init() with pci_register_driver()
      drivers/net: Replace pci_module_init() with pci_register_driver()
      drivers/scsi: Replace pci_module_init() with pci_register_driver()
      pci: Schedule removal of pci_module_init
      drivers/*rest*: Replace pci_module_init() with pci_register_driver()

Sergey Vlasov:
      PCIE: make bus_id for PCI Express devices unique

Thomas Schaefer:
      pciehp: handle sticky power-fault status

