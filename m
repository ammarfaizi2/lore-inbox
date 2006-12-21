Return-Path: <linux-kernel-owner+w=401wt.eu-S1422810AbWLUHgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWLUHgN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422818AbWLUHgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:36:13 -0500
Received: from colo.lackof.org ([198.49.126.79]:52981 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422810AbWLUHgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:36:12 -0500
Date: Thu, 21 Dec 2006 00:36:09 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [GIT PATCH] PCI patches for 2.6.20-rc1
Message-ID: <20061221073609.GA6989@colo.lackof.org>
References: <20061220200142.GB1698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220200142.GB1698@kroah.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 12:01:42PM -0800, Greg KH wrote:
> Here are some PCI patches for 2.6.20-rc1
> 
> They contain a number of PCI quirk fixes and some PCI hotplug driver
> fixes and changes, and some other stuff that is detailed below.

Any reasons why the Documentation/pci.txt patch isn't included?
Did I botch something?
Should I resubmit?

thanks,
grant

> 
> All of these patches have been in the -mm tree for a while.
> 
> Please pull from:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
> or if master.kernel.org hasn't synced up yet:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
> 
> The full patches will be sent to the linux-pci mailing list, if anyone
> wants to see them.
> 
> thanks,
> 
> greg k-h
> 
>  arch/i386/pci/fixup.c              |   13 ++-
>  arch/powerpc/sysdev/mpic.c         |    2 +-
>  drivers/ide/pci/atiixp.c           |    1 -
>  drivers/pci/hotplug/acpiphp_glue.c |    2 +-
>  drivers/pci/hotplug/rpaphp_slot.c  |   47 ++++----
>  drivers/pci/hotplug/shpchp.h       |  238 ++++++++++--------------------------
>  drivers/pci/hotplug/shpchp_core.c  |  116 ++----------------
>  drivers/pci/hotplug/shpchp_ctrl.c  |   21 ++--
>  drivers/pci/hotplug/shpchp_hpc.c   |  223 ++++++++++------------------------
>  drivers/pci/htirq.c                |    9 +--
>  drivers/pci/pci-driver.c           |   12 +-
>  drivers/pci/pci.c                  |  112 +++++++++++++++--
>  drivers/pci/pcie/portdrv_pci.c     |    2 +-
>  drivers/pci/probe.c                |   11 +-
>  drivers/pci/quirks.c               |  217 ++++++++++++++++++++++-----------
>  drivers/pci/search.c               |   38 +++---
>  drivers/pci/setup-res.c            |   19 +++-
>  include/asm-generic/vmlinux.lds.h  |    3 +
>  include/linux/Kbuild               |    2 -
>  include/linux/ioport.h             |    3 +
>  include/linux/pci.h                |   29 ++++-
>  include/linux/pci_ids.h            |    4 +
>  include/linux/pci_regs.h           |   19 +++-
>  23 files changed, 537 insertions(+), 606 deletions(-)
> 
> ---------------
> 
> Adrian Bunk (1):
>       PCI: don't export device IDs to userspace
> 
> Alan Cox (2):
>       pci: Introduce pci_find_present
>       PCI: Fix multiple problems with VIA hardware
> 
> Conke Hu (1):
>       PCI: ATI sb600 sata quirk
> 
> David Rientjes (1):
>       PCI quirks: remove redundant check
> 
> Inaky Perez-Gonzalez (1):
>       pci: add class codes for Wireless RF controllers
> 
> Jesper Juhl (1):
>       PCI: Be a bit defensive in quirk_nvidia_ck804() so we don't risk dereferencing a NULL pdev.
> 
> Kenji Kaneshige (5):
>       PCI: pcieport-driver: remove invalid warning message
>       shpchp: remove unnecessary struct php_ctlr
>       shpchp: cleanup struct controller
>       shpchp: remove shpchprm_get_physical_slot_number
>       shpchp: cleanup shpchp.h
> 
> Kristen Carlson Accardi (1):
>       acpiphp: Link-time error for PCI Hotplug
> 
> Linas Vepstas (1):
>       rpaphp: compiler warning cleanup
> 
> Michael Ellerman (6):
>       PCI: Create __pci_bus_find_cap_start() from __pci_bus_find_cap()
>       PCI: Add pci_find_ht_capability() for finding Hypertransport capabilities
>       PCI: Use pci_find_ht_capability() in drivers/pci/htirq.c
>       PCI: Add #defines for Hypertransport MSI fields
>       PCI: Use pci_find_ht_capability() in drivers/pci/quirks.c
>       PCI: Only check the HT capability bits in mpic.c
> 
> Ralf Baechle (1):
>       PCI legacy resource fix
> 
> Russell King (1):
>       PCI: use /sys/bus/pci/drivers/<driver>/new_id first
