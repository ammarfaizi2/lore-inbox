Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWFUTFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWFUTFx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWFUTFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:05:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:24981 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932657AbWFUTFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:05:52 -0400
Date: Wed, 21 Jun 2006 12:02:46 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.17
Message-ID: <20060621190246.GA20912@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI fixes and patches for 2.6.17.  They do a bunch of work
getting MSI to work properly on ia64, and fix some other MSI issues.  We
also added a few new sysfs attributes for PCI devices and add some more
quirks and fix a few minor bugs.

All of these patches have been in the -mm tree for a number of months.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h


 Documentation/pci.txt                        |   14 +
 arch/i386/kernel/acpi/boot.c                 |    2 
 arch/i386/pci/common.c                       |    1 
 arch/i386/pci/i386.c                         |    9 
 arch/i386/pci/mmconfig.c                     |    9 
 arch/i386/pci/pci.h                          |    1 
 arch/ia64/kernel/irq_ia64.c                  |   19 +
 arch/ia64/sn/kernel/io_init.c                |    9 
 arch/ia64/sn/kernel/irq.c                    |  142 +++++++------
 arch/ia64/sn/pci/pci_dma.c                   |   10 
 arch/ia64/sn/pci/pcibr/pcibr_dma.c           |   62 ++++-
 arch/ia64/sn/pci/tioca_provider.c            |    8 
 arch/ia64/sn/pci/tioce_provider.c            |   65 ++++--
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    9 
 arch/x86_64/pci/mmconfig.c                   |   13 -
 drivers/pci/Makefile                         |    6 
 drivers/pci/bus.c                            |   21 -
 drivers/pci/msi-altix.c                      |  210 +++++++++++++++++++
 drivers/pci/msi-apic.c                       |  100 +++++++++
 drivers/pci/msi.c                            |  285 ++++++++++++++-------------
 drivers/pci/msi.h                            |  133 ++++++------
 drivers/pci/pci-acpi.c                       |   16 -
 drivers/pci/pci-sysfs.c                      |   45 ++++
 drivers/pci/pci.c                            |   16 +
 drivers/pci/pci.h                            |    2 
 drivers/pci/probe.c                          |   45 ++--
 drivers/pci/quirks.c                         |   47 +++-
 drivers/pci/remove.c                         |   12 -
 drivers/pci/search.c                         |   32 +--
 drivers/pci/setup-bus.c                      |    5 
 drivers/pci/setup-res.c                      |   40 +++
 drivers/scsi/qla1280.c                       |   24 --
 drivers/scsi/sata_vsc.c                      |   11 -
 include/asm-i386/msi.h                       |   10 
 include/asm-ia64/hw_irq.h                    |   15 +
 include/asm-ia64/machvec.h                   |    7 
 include/asm-ia64/machvec_sn2.h               |    7 
 include/asm-ia64/msi.h                       |   12 +
 include/asm-ia64/sn/intr.h                   |    8 
 include/asm-ia64/sn/pcibr_provider.h         |    5 
 include/asm-ia64/sn/pcibus_provider_defs.h   |   17 +
 include/asm-ia64/sn/tiocp.h                  |    3 
 include/asm-x86_64/msi.h                     |   10 
 include/linux/pci.h                          |    4 
 include/linux/pci_ids.h                      |   11 +
 include/linux/pci_regs.h                     |    1 
 46 files changed, 1097 insertions(+), 436 deletions(-)

---------------

Arjan van de Ven:
      PCI: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access

bibo,mao:
      PCI: cleanup unused variable about msi driver

Bjorn Helgaas:
      PCI: fix to pci ignore pre-set 64-bit bars on 32-bit platforms

Brent Casavant:
      PCI: Move various PCI IDs to header file

Brice Goglin:
      PCI: Add PCI_CAP_ID_VNDR
      PCI: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
      PCI: nVidia quirk to make AER PCI-E extended capability visible

Chris Wedgwood:
      PCI: MSI-K8T-Neo2-Fir: run only where needed

Chuck Ebbert:
      PCI: fix issues with extended conf space when MMCONFIG disabled because of e820

Doug Thompson:
      PCI Bus Parity Status-broken hardware attribute, EDAC foundation
      PCI: Bus Parity Status sysfs interface

Grant Grundler:
      PCI: remove unneeded msi code
      PCI: clean up pci documentation to be more specific

Greg Kroah-Hartman:
      PCI: fix error with pci_get_device() call in the mpc85xx driver

H. Peter Anvin:
      PCI: Ignore pre-set 64-bit BARs on 32-bit platforms

Kimball Murray:
      PCI: don't move ioapics below PCI bridge

Konrad Rzeszutek:
      PCI: fix memory leak in MMCONFIG error path

Kristen Accardi:
      PCI: don't enable device if already enabled

Kumar Gala:
      PCI: Add pci_assign_resource_fixed -- allow fixed address assignments

Mark Maule:
      PCI: msi abstractions and support for altix
      PCI: per-platform IA64_{FIRST,LAST}_DEVICE_VECTOR definitions
      PCI: altix: msi support

Muthu Kumar:
      PCI ACPI: Rename the functions to avoid multiple instances.

Rajesh Shah:
      PCI: i386/x86_84: disable PCI resource decode on device disable
      PCI: Allow MSI to work on kexec kernel

Shaohua Li:
      PCI: disable msi mode in pci_disable_device

Zhang Yanmin:
      PCI: fix race with pci_walk_bus and pci_destroy_dev

