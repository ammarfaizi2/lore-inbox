Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271073AbTGWCWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 22:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271070AbTGWCWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 22:22:10 -0400
Received: from www.opensource-ca.org ([168.234.203.30]:34263 "EHLO
	guug.galileo.edu") by vger.kernel.org with ESMTP id S271055AbTGWCWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 22:22:06 -0400
Date: Tue, 22 Jul 2003 20:32:29 -0600
To: "David S. Miller" <davem@redhat.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030723023229.GC30174@guug.org>
References: <20030722025142.GC25561@guug.org> <20030722080905.A21280@devserv.devel.redhat.com> <20030722182609.GA30174@guug.org> <20030722175400.4fe2aa5d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722175400.4fe2aa5d.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 05:54:00PM -0700, David S. Miller wrote:
> On Tue, 22 Jul 2003 12:26:09 -0600
> Otto Solares <solca@guug.org> wrote:
> 
> > converting the esp scsi driver to sbus without
> > pci requirement is the right step IMO.  Maybe
> > the scsi people can comment on this.
> 
> No, the problem is that SCSI DMA transfer direction
> macros are defined in terms of PCI ones.  That's all,
> it's a minor issue and probably easily solved.

these are the ofending messages:

In file included from include/asm/dma-mapping.h:1,
                 from include/linux/dma-mapping.h:13,
                 from include/scsi/scsi_cmnd.h:4,
                 from drivers/scsi/scsi.h:20,
                 from drivers/scsi/scsi.c:57:
include/asm-generic/dma-mapping.h: In function `dma_supported':
include/asm-generic/dma-mapping.h:19: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h:19: (Each undeclared identifier is reported only once
include/asm-generic/dma-mapping.h:19: for each function it appears in.)
include/asm-generic/dma-mapping.h: In function `dma_set_mask':
include/asm-generic/dma-mapping.h:27: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_alloc_coherent':
include/asm-generic/dma-mapping.h:36: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_free_coherent':
include/asm-generic/dma-mapping.h:45: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_map_single':
include/asm-generic/dma-mapping.h:54: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_unmap_single':
include/asm-generic/dma-mapping.h:63: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_map_page':
include/asm-generic/dma-mapping.h:73: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_unmap_page':
include/asm-generic/dma-mapping.h:82: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_map_sg':
include/asm-generic/dma-mapping.h:91: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_unmap_sg':
include/asm-generic/dma-mapping.h:100: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_sync_single':
include/asm-generic/dma-mapping.h:109: `pci_bus_type' undeclared (first use in this function)
include/asm-generic/dma-mapping.h: In function `dma_sync_sg':
include/asm-generic/dma-mapping.h:118: `pci_bus_type' undeclared (first use in this function)
make[2]: *** [drivers/scsi/scsi.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

-solca

