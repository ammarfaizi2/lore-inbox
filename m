Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316540AbSFEXFV>; Wed, 5 Jun 2002 19:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSFEXFU>; Wed, 5 Jun 2002 19:05:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49548 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316540AbSFEXFT>;
	Wed, 5 Jun 2002 19:05:19 -0400
Date: Wed, 05 Jun 2002 16:02:01 -0700 (PDT)
Message-Id: <20020605.160201.76773422.davem@redhat.com>
To: zaitcev@redhat.com
Cc: wjhun@ayrnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: Deprecate pci_dma_sync_{single,sg}()?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206052156.g55LuTI15282@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Wed, 5 Jun 2002 17:56:29 -0400

   >[...]
   > In the current linux-mips implementation, this has some subtle problems:
   > pci_unmap_{single,sg}() is essentially a no-op. Thus, in the above
   > example, a driver would break (stale cachelines from a previous
   > pci_dma_sync_*/read would not be invalidated). One might argue that a
   > cache invalidate should happen in the pci_unmap_single(). But then the
   > other case (where a driver does a pci_map, DMAs, does a pci_unmap, and
   > sends it up the stack) would require an additional cache
   > flush/invalidate that is not needed at all.
   
   Frist, fix mips, it is broken.

No, MIPS is not broken.  If there is no intervening call into
the PCI DMA layer between the read of the data and giving
the buffer back to the device, it has no reason to flush.

It flushes when it should, at pci_map_single() time for
PCI_DMA_FROM_DEVICE direction.

This provides the behavior exactly as inteded by the API.
It is precisely the optimization non-cache-coherent cpu
systems are expected to do for best performance.
