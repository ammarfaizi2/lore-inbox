Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270117AbUJSXBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270117AbUJSXBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270051AbUJSWmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:42:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:11655 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270042AbUJSWix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:38:53 -0400
Date: Tue, 19 Oct 2004 15:37:52 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.9
Message-ID: <20041019223752.GA9763@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI patches for 2.6.7.  They have all been included in the
-mm trees for the last few weeks.  They include:
	- lots of old pci api cleanups
	- some pci hotplug driver updates
	- pci_save/restore_state is fixed up to use the pci device
	  structure.
	- lots of patches from the kernel-janitor developers.
	
Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 Documentation/pci.txt                         |   13 
 Documentation/power/pci.txt                   |   51 +
 arch/alpha/kernel/console.c                   |    2 
 arch/alpha/kernel/pci.c                       |   20 
 arch/alpha/kernel/pci_impl.h                  |    1 
 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c     |    3 
 arch/i386/kernel/cpu/cpufreq/speedstep-ich.c  |   15 
 arch/i386/kernel/cpu/cyrix.c                  |   33 
 arch/i386/kernel/cpu/mtrr/main.c              |    8 
 arch/i386/kernel/scx200.c                     |   67 +
 arch/i386/pci/acpi.c                          |    4 
 arch/i386/pci/i386.c                          |   26 
 arch/i386/pci/irq.c                           |   20 
 arch/ia64/pci/pci.c                           |    6 
 arch/ia64/sn/io/machvec/pci_bus_cvlink.c      |    4 
 arch/ppc/kernel/pci.c                         |   56 -
 arch/ppc64/kernel/pSeries_pci.c               |  215 +++++-
 arch/ppc64/kernel/pci.c                       |  167 +++-
 arch/ppc64/kernel/pci.h                       |    6 
 arch/ppc64/kernel/pci_dn.c                    |   12 
 arch/sparc/kernel/pcic.c                      |   12 
 drivers/acpi/motherboard.c                    |    6 
 drivers/acpi/processor.c                      |   15 
 drivers/atm/eni.c                             |    4 
 drivers/atm/firestream.c                      |   12 
 drivers/atm/idt77252.c                        |   19 
 drivers/block/cpqarray.c                      |    8 
 drivers/char/agp/intel-agp.c                  |    7 
 drivers/char/agp/intel-mch-agp.c              |    8 
 drivers/char/agp/via-agp.c                    |    4 
 drivers/char/applicom.c                       |    2 
 drivers/char/drm/drm_fops.h                   |    7 
 drivers/char/epca.c                           |   26 
 drivers/char/ipmi/ipmi_si_intf.c              |   28 
 drivers/isdn/hisax/hisax_fcpcipnp.c           |   12 
 drivers/media/video/bttv-cards.c              |    6 
 drivers/media/video/bttv-driver.c             |    4 
 drivers/media/video/bttvp.h                   |    1 
 drivers/media/video/cx88/cx88-video.c         |    4 
 drivers/media/video/cx88/cx88.h               |    1 
 drivers/media/video/meye.c                    |    4 
 drivers/media/video/meye.h                    |    1 
 drivers/message/fusion/mptbase.c              |    8 
 drivers/message/fusion/mptbase.h              |    6 
 drivers/misc/ibmasm/ibmasm.h                  |    2 
 drivers/misc/ibmasm/ibmasmfs.c                |    4 
 drivers/misc/ibmasm/lowlevel.c                |    2 
 drivers/misc/ibmasm/lowlevel.h                |   30 
 drivers/misc/ibmasm/module.c                  |    6 
 drivers/misc/ibmasm/uart.c                    |    2 
 drivers/net/3c59x.c                           |   11 
 drivers/net/8139cp.c                          |    5 
 drivers/net/8139too.c                         |    6 
 drivers/net/amd8111e.c                        |    4 
 drivers/net/amd8111e.h                        |    1 
 drivers/net/b44.c                             |    4 
 drivers/net/b44.h                             |    1 
 drivers/net/dgrs.c                            |    4 
 drivers/net/e100.c                            |    5 
 drivers/net/e1000/e1000.h                     |    1 
 drivers/net/e1000/e1000_main.c                |    4 
 drivers/net/eepro100.c                        |    7 
 drivers/net/hamachi.c                         |    5 
 drivers/net/irda/via-ircc.c                   |   10 
 drivers/net/irda/vlsi_ir.c                    |    4 
 drivers/net/irda/vlsi_ir.h                    |    1 
 drivers/net/ixgb/ixgb.h                       |    1 
 drivers/net/ixgb/ixgb_main.c                  |    2 
 drivers/net/pci-skeleton.c                    |    5 
 drivers/net/s2io.c                            |    4 
 drivers/net/s2io.h                            |    1 
 drivers/net/sis900.c                          |    6 
 drivers/net/tg3.c                             |    8 
 drivers/net/tg3.h                             |    1 
 drivers/net/tokenring/abyss.c                 |    9 
 drivers/net/tokenring/tmspci.c                |    9 
 drivers/net/tulip/xircom_tulip_cb.c           |    7 
 drivers/net/typhoon.c                         |   18 
 drivers/net/via-rhine.c                       |    4 
 drivers/net/via-velocity.c                    |    4 
 drivers/net/via-velocity.h                    |    4 
 drivers/net/wan/sbni.c                        |    6 
 drivers/net/wireless/airo.c                   |    5 
 drivers/net/wireless/prism54/islpci_dev.h     |    1 
 drivers/net/wireless/prism54/islpci_hotplug.c |    4 
 drivers/net/wireless/prism54/islpci_mgt.c     |    4 
 drivers/parport/parport_pc.c                  |   16 
 drivers/pci/hotplug/acpiphp_ibm.c             |  101 +-
 drivers/pci/hotplug/cpcihp_zt5550.c           |   15 
 drivers/pci/hotplug/cpqphp.h                  |    9 
 drivers/pci/hotplug/cpqphp_core.c             |   38 -
 drivers/pci/hotplug/cpqphp_ctrl.c             |    4 
 drivers/pci/hotplug/cpqphp_nvram.h            |   12 
 drivers/pci/hotplug/cpqphp_pci.c              |   12 
 drivers/pci/hotplug/ibmphp_core.c             |    2 
 drivers/pci/hotplug/ibmphp_ebda.c             |    4 
 drivers/pci/hotplug/ibmphp_hpc.c              |   28 
 drivers/pci/hotplug/pciehp.h                  |   11 
 drivers/pci/hotplug/pciehp_core.c             |    4 
 drivers/pci/hotplug/pciehp_hpc.c              |    4 
 drivers/pci/hotplug/rpadlpar_core.c           |  170 +++-
 drivers/pci/hotplug/rpaphp.h                  |    4 
 drivers/pci/hotplug/rpaphp_core.c             |  159 ++--
 drivers/pci/hotplug/rpaphp_pci.c              |  166 +++-
 drivers/pci/hotplug/rpaphp_slot.c             |   11 
 drivers/pci/hotplug/rpaphp_vio.c              |    4 
 drivers/pci/hotplug/shpchp.h                  |    9 
 drivers/pci/hotplug/shpchp_core.c             |    4 
 drivers/pci/hotplug/shpchp_ctrl.c             |  898 ++++++--------------------
 drivers/pci/hotplug/shpchp_hpc.c              |   11 
 drivers/pci/hotplug/shpchprm_acpi.c           |    6 
 drivers/pci/msi.c                             |   20 
 drivers/pci/msi.h                             |    2 
 drivers/pci/pci-driver.c                      |   68 -
 drivers/pci/pci.c                             |   40 -
 drivers/pci/pci.h                             |   21 
 drivers/pci/pci.ids                           |    8 
 drivers/pci/probe.c                           |   72 +-
 drivers/pci/proc.c                            |    5 
 drivers/pci/quirks.c                          |   66 +
 drivers/pci/search.c                          |  141 ++--
 drivers/pci/setup-bus.c                       |   12 
 drivers/pci/setup-irq.c                       |    2 
 drivers/pcmcia/yenta_socket.c                 |   12 
 drivers/pcmcia/yenta_socket.h                 |    2 
 drivers/pnp/system.c                          |    6 
 drivers/scsi/eata.c                           |  240 +++---
 drivers/scsi/ipr.c                            |    4 
 drivers/scsi/ipr.h                            |    1 
 drivers/scsi/megaraid/megaraid_mbox.c         |   16 
 drivers/scsi/nsp32.c                          |   10 
 drivers/scsi/nsp32.h                          |    6 
 drivers/usb/core/hcd-pci.c                    |   10 
 drivers/usb/core/hcd.h                        |    5 
 drivers/usb/gadget/goku_udc.c                 |   16 
 drivers/usb/gadget/net2280.c                  |    4 
 drivers/usb/host/ehci-hcd.c                   |    4 
 drivers/usb/host/ohci-pci.c                   |   39 -
 drivers/usb/host/uhci-hcd.c                   |    4 
 drivers/video/i810/i810.h                     |    2 
 drivers/video/i810/i810_main.c                |   28 
 drivers/video/riva/fbdev.c                    |   10 
 include/asm-generic/vmlinux.lds.h             |    3 
 include/asm-ppc64/pci-bridge.h                |    6 
 include/asm-ppc64/pci.h                       |    2 
 include/linux/pci.h                           |   64 -
 sound/core/init.c                             |    2 
 sound/oss/ali5455.c                           |   11 
 sound/oss/esssolo1.c                          |    6 
 sound/oss/forte.c                             |    7 
 sound/oss/i810_audio.c                        |   15 
 sound/oss/maestro3.c                          |    3 
 sound/oss/trident.c                           |    6 
 sound/oss/via82cxxx_audio.c                   |    8 
 154 files changed, 1927 insertions(+), 1940 deletions(-)
-----

Andrew Morton:
  o PCI: pci_dev_put() build fix
  o PCI: CONFIG_PCI=n build fix

Bjorn Helgaas:
  o add-pci_fixup_enable-pass.patch

Christoph Hellwig:
  o PCI: mark proc_bus_pci_dir static

David Brownell:
  o PCI: update Documentation/power/pci.txt

Dely Sy:
  o PCI: Hot-plug driver updates due to MSI change
  o PCI Hotplug: quirk fix missed out in last patch
  o PCI Hotplug: Bug fixes for shpchp driver
  o PCI Hotplug: change bus speed patch

Evgeniy Polyakov:
  o scx200: pci_find_device() removal

Greg Kroah-Hartman:
  o PCI: fix up pci_save/restore_state in via-agp due to api change
  o PCI: remove pci_module_init() usage from drivers/usb/*
  o PCI: pci_module_init() is identical to pci_register_driver() so just make it a #define
  o PCI: audit all callers of pci_register_driver() to work properly
  o PCI: fix up pci_register_driver() to stop lying in its return value
  o PCI: remove all usages of pci_dma_sync_single as it's obsolete
  o PCI: remove all usages of pci_dma_sync_sg as it's obsolete
  o PCI: clean up pci_dev_get() to be sane
  o PCI: remove pci_module_init() usage from drivers/pci/hotplug/*
  o PCI Hotplug: Oops, didn't mean to apply the msi pci express patch, so revert it
  o PCI: change cyrix.c driver to use pci_dev_present
  o PCI: Create new function to see if a pci device is present
  o ibmasm: fix __iomem warnings
  o PCI Hotplug: fix the rest of the drivers for __iomem and other sparse issues
  o PCI Hotplug: fix __iomem warnings in the ibm pci hotplug driver
  o PCI Hotplug: fix __iomem warnings in the compaq pci hotplug driver
  o PCI: fix __iomem * warnings for PCI msi core code
  o PCI: remove pci_find_device() usages from drivers/pci/*
  o PCI: get rid of pci_find_device() from arch/i386/*
  o PCI: fix improper pr_debug() statement
  o PCI: delete the pci_find_class() function as it's unsafe in hotpluggable systems
  o PCI: remove pci_find_class() usage from all drivers/ files
  o PCI: remove pci_find_class() usage from arch specific files
  o PCI: clean up the comments in search.c to be correct
  o PCI: add pci_get_class() to make a safe pci_find_class() like call
  o PCI: make pci_find_class() warn if in interrupt like all other find/get functions do
  o PCI: update the pci.txt documentation about pci_find_device and pci_find_subsys going away
  o PCI: make pci_find_subsys() static, as it should not be used anymore
  o PCI: remove pci_find_subsys() calls from acpi code
  o PCI: remove pci_find_subsys() calls from cpufreq code

Hanna V. Linder:
  o PCI: Changed pci_find_device to pci_get_device for acpi.c
  o PCI: Fix one missed pci_find_device

John Rose:
  o PCI Hotplug: rpaphp safe list traversal
  o PCI Hotplug: RPA DLPAR - remove error check
  o PPC64: RPA dynamic addition/removal of PCI Host Bridges
  o PPC64: Add pcibios_remove_root_bus
  o PCI Hotplug: RPA dynamic addition/removal of PCI Host Bridges
  o PCI Hotplug: add host bridges to RPA hotplug subsystem

Kenji Kaneshige:
  o PCI: warn of missing pci_disable_device()

Lennert Buytenhek:
  o PCI: minor pci.ids update

Li Shaohua:
  o PCI: Reorder some initialization code to allow resources to be proper allocated

Luiz Capitulino:
  o PCI: add missing checks in drivers/pci/probe.c

Maximilian Attems:
  o PCI pci_dev_b to list_for_each_entry: drivers-pci-setup-bus.c
  o PCI list_for_each: arch-sparc-kernel-pcic.c
  o PCI list_for_each: arch-ppc-kernel-pci.c
  o PCI list_for_each: arch-ppc64-kernel-pci_dn.c
  o PCI list_for_each: arch-ppc64-kernel-pci.c
  o PCI list_for_each: arch-ia64-sn-io-machvec-pci_bus_cvlink.c
  o PCI list_for_each: arch-ia64-pci-pci.c
  o PCI list_for_each: arch-alpha-kernel-pci.c
  o PCI list_for_each: arch-i386-pci-i386.c

Nishanth Aravamudan:
  o pci hotplug/cpqphp_ctrl: replace schedule_timeout() with msleep_interruptible()
  o pci hotplug/cpqphp: replace schedule_timeout() with msleep_interruptible()
  o pci hotplug/pciehp: replace schedule_timeout() with msleep_interruptible()
  o pci hotplug/shpchp: replace schedule_timeout() with msleep_interruptible()

Roger Luethi:
  o PCI: remove driver private PCI state, 1 arg for pci_{save,restore}_state

Vernon Mauery:
  o PCI Hotplug: acpiphp extension fixes

