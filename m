Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSFEV4o>; Wed, 5 Jun 2002 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSFEV4m>; Wed, 5 Jun 2002 17:56:42 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63670 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316446AbSFEV4g>; Wed, 5 Jun 2002 17:56:36 -0400
Date: Wed, 5 Jun 2002 17:56:29 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200206052156.g55LuTI15282@devserv.devel.redhat.com>
To: William Jhun <wjhun@ayrnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deprecate pci_dma_sync_{single,sg}()?
In-Reply-To: <mailman.1023308362.19729.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> In the current linux-mips implementation, this has some subtle problems:
> pci_unmap_{single,sg}() is essentially a no-op. Thus, in the above
> example, a driver would break (stale cachelines from a previous
> pci_dma_sync_*/read would not be invalidated). One might argue that a
> cache invalidate should happen in the pci_unmap_single(). But then the
> other case (where a driver does a pci_map, DMAs, does a pci_unmap, and
> sends it up the stack) would require an additional cache
> flush/invalidate that is not needed at all.

Frist, fix mips, it is broken. Then patch those simple
minded drivers that do map->dma->unmap cycle and suffer
performance degradation to use pci_unmap(..., PCI_DMA_NONE).

-- Pete
