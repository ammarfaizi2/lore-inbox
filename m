Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263233AbVCDXVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbVCDXVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbVCDXUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:20:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:32162 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263176AbVCDUyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:49 -0500
Date: Fri, 4 Mar 2005 12:53:16 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI update for 2.6.11
Message-ID: <20050304205316.GB32044@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and PCI Hotplug patches for 2.6.11.  All of these have
been in the past few -mm releases.

It includes a big pci.ids update.  Hm, I need to mark that thing as
"will be deleted in the future" soon, as we are tired of keeping that
around.  Will do that in the next round of pci patches.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 Documentation/pci.txt                |    8 
 arch/frv/mb93090-mb00/pci-frv.c      |    4 
 arch/frv/mb93090-mb00/pci-vdk.c      |    6 
 arch/i386/pci/acpi.c                 |   17 
 arch/i386/pci/direct.c               |   12 
 arch/i386/pci/irq.c                  |   73 +-
 arch/i386/pci/mmconfig.c             |    6 
 arch/i386/pci/numa.c                 |   10 
 arch/i386/pci/pcbios.c               |    6 
 arch/ia64/pci/pci.c                  |   69 --
 arch/mips/pmc-sierra/yosemite/ht.c   |    6 
 arch/ppc/kernel/pci.c                |    2 
 arch/ppc64/kernel/pci.c              |   16 
 arch/sh/drivers/pci/fixups-sh03.c    |    4 
 arch/sh/drivers/pci/pci-sh7751.c     |    8 
 arch/sh/drivers/pci/pci-st40.c       |    2 
 arch/sh64/kernel/pci_sh5.c           |    2 
 arch/sh64/kernel/pcibios.c           |    4 
 arch/sparc64/kernel/pci.c            |    6 
 arch/x86_64/pci/mmconfig.c           |    8 
 drivers/char/agp/generic.c           |    2 
 drivers/char/agp/sis-agp.c           |    2 
 drivers/ide/pci/sgiioc4.c            |    6 
 drivers/isdn/hisax/hisax_fcpcipnp.c  |    2 
 drivers/media/common/saa7146_video.c |    2 
 drivers/media/video/meye.c           |    2 
 drivers/media/video/zoran_driver.c   |    2 
 drivers/net/defxx.c                  |    2 
 drivers/net/r8169.c                  |    8 
 drivers/net/s2io.c                   |    4 
 drivers/net/sk98lin/skethtool.c      |    2 
 drivers/net/sk98lin/skge.c           |    2 
 drivers/net/tulip/tulip.h            |    2 
 drivers/net/typhoon.c                |    2 
 drivers/net/via-velocity.c           |    2 
 drivers/net/wan/wanxl.c              |   38 -
 drivers/parisc/dino.c                |    5 
 drivers/pci/hotplug/ibmphp_pci.c     |    3 
 drivers/pci/hotplug/pciehp_ctrl.c    |    3 
 drivers/pci/hotplug/pciehprm_acpi.c  |    3 
 drivers/pci/hotplug/shpchprm_acpi.c  |    3 
 drivers/pci/msi.c                    |   13 
 drivers/pci/pci-driver.c             |    1 
 drivers/pci/pci-sysfs.c              |    2 
 drivers/pci/pci.c                    |    4 
 drivers/pci/pci.ids                  | 1137 +++++++++++++++++++++++++++++++----
 drivers/pci/pcie/Kconfig             |    1 
 drivers/pci/pcie/portdrv_pci.c       |    2 
 drivers/pci/probe.c                  |    9 
 drivers/pci/proc.c                   |   20 
 drivers/pci/quirks.c                 |   13 
 drivers/pci/setup-res.c              |    4 
 drivers/pcmcia/yenta_socket.c        |    2 
 drivers/scsi/qla2xxx/qla_os.c        |   28 
 include/asm-alpha/pci.h              |   11 
 include/asm-ia64/pci.h               |    9 
 include/asm-mips/pci.h               |   11 
 include/asm-ppc/pci.h                |    3 
 include/asm-ppc64/pci.h              |    4 
 include/asm-sparc64/pci.h            |    5 
 include/linux/pci.h                  |   11 
 include/linux/pci_ids.h              |    8 
 62 files changed, 1255 insertions(+), 409 deletions(-)
-----


<c-d.hailfinger.devel.2005:gmx.net>:
  o PCI: pci.ids update
  o pci/quirks.c: unhide SMBus device on Samsung P35 laptop

<muneda.takahiro:jp.fujitsu.com>:
  o PCI: fix pci_remove_legacy_files() crash

Alexander Nyberg:
  o PCI: fix hotplug double free

Andi Kleen:
  o PCI: allow x86_64 to do pci express

Benjamin Herrenschmidt:
  o PCI: Apple PCI IDs update

Bjorn Helgaas:
  o PCI: tone down pci=routeirq message
  o PCI: pci_raw_ops should use unsigned args
  o PCI: NUMA-Q PCI config access arg validation

Brian King:
  o PCI: Dynids - passing driver data

Christophe Lucas:
  o drivers/pci/*: convert to pci_register_driver

Dave Jones:
  o Remove pci_dev->slot_name
  o convert pci_dev->slot_name usage to pci_name()

Dely Sy:
  o PCI Hotplug: Fix OSHP calls in shpchp and pciehp drivers

Greg Kroah-Hartman:
  o PCI: remove pci_find_device usage from pci sysfs code

Jean Delvare:
  o PCI: One more Asus SMBus quirk
  o PCI: Add PCI quirk for SMBus on the Toshiba Satellite A40

Mark F. Haigh:
  o arch/i386/kernel/pci/irq.c:  Wrong message output

Matthew Wilcox:
  o PCI: Make pci_claim_resource __devinit
  o PCI: pci_proc_domain

Roland Dreier:
  o PCI: clean up the msi api

Rolf Eike Beer:
  o PCI Hotplug: Remove unneeded instructions from ibmphp_pci.c

