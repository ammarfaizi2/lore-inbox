Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272211AbRHWHv3>; Thu, 23 Aug 2001 03:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272231AbRHWHvU>; Thu, 23 Aug 2001 03:51:20 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:46854 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S272211AbRHWHvE>; Thu, 23 Aug 2001 03:51:04 -0400
Date: Thu, 23 Aug 2001 09:53:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>, lse-tech@lists.sourceforge.net,
        "Leonard N. Zubkoff" <lnz@dandelion.com>, arjanv@redhat.com
Subject: [patch] PCI64 + block zero-bounce highmem v11
Message-ID: <20010823095324.Q604@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Uploaded a new version. Changes since block-highmem-all-10:

- Merge pci64-1 from davem (me)
- Merge pci64-2 from davem (me)
- printk type warning on x86 when HIGHMEM wasn't enabled (me)
- Better comment asm-i386/scatterlist.h
- Add single_segment/highmem comment in scsi_merge (me)
- Include Mark Hemment's no __save_flags/__cli in read bounce
- Convert cciss to pci64 interface (me)

HIGHMEM I/O capable hardware now includes:

- IDE (DMA, PIO will revert to bounce) Basically all low level drivers
- SCSI
	- aic7xxx (new)
	- qlogicfc (64-bit too)
	- sym53c8xx (64-bit too)
	- megaraid
	- IPS
- cpqarray
- cciss (64-bit too)

SCSI drivers are typically easy to convert to support < 4GB I/O, usually
just the can_dma_32 flag needs to be added. Some need a bit more work,
like IPS. Look for references to virt_to_bus on the scatterlist
->address and/or bh->b_data to find obvious highmem breakage. For 64-bit
PCI DMA, take a look at David's modifications to sym53c8xx as a good
reference.

I'll include I2O highmem support in the next release -- haven't started
it yet, but it should be a breeze.

DAC960 would be nice to have as well. Leonard, we talked about
converting it to the pci dma interface some time ago -- did you make
progress on that?

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.9/block-highmem-all-11

-- 
Jens Axboe

