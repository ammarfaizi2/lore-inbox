Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267279AbSKPOde>; Sat, 16 Nov 2002 09:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbSKPOde>; Sat, 16 Nov 2002 09:33:34 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:64683 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267279AbSKPOdd>; Sat, 16 Nov 2002 09:33:33 -0500
Date: Sat, 16 Nov 2002 06:38:42 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: ink@jurassic.park.msu.ru
Cc: linux-kernel@vger.kernel.org, david.rusling@reo.mts.dec.com,
       davidm@cs.arizona.edu
Subject: Patch: linux-2.5.47/arch/alpha/kernel/pci.c - do not directly set pci_dev.dma_mask where possible
Message-ID: <20021116063842.A20141@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

        pcibios_fixup_final in linux-2.5.47/arch/alpha/kernel/pci.c
directly sets pci_dev->dma_mask instead of calling pci_set_dma_mask.
pci_dev.dma_mask may be moved soon (probably to
pci_dev.device.dma_mask).  So, applying this patch will reduce or
eliminate the need to change this code when that happens, and it will
be one less change to maintain between 2.4 and 2.5+ kernels.

	I am not quite sure who to directly alpha architecture patches
to, so I'm sending this to the authors listed in the file and to lkml.
If there is a more appropriate address to submit this to, I would
appreciate it if someone would let me know.  Otherwise, I'd ask
that someone who actually uses Linux on Alpha give this patch a
whirl and submit it to Linus if it works.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffs

--- linux-2.5.47/arch/alpha/kernel/pci.c	2002-11-10 19:28:03.000000000 -0800
+++ linux/arch/alpha/kernel/pci.c	2002-11-16 05:54:00.000000000 -0800
@@ -124,7 +124,7 @@
 	unsigned int class = dev->class >> 8;
 
 	if (class == PCI_CLASS_BRIDGE_ISA || class == PCI_CLASS_BRIDGE_ISA) {
-		dev->dma_mask = MAX_ISA_DMA_ADDRESS - 1;
+		pci_set_dma_mask(dev, MAX_ISA_DMA_ADDRESS - 1);
 		isa_bridge = dev;
 	}
 }

--7JfCtLOvnd9MIVvH--
