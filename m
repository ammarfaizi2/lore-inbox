Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbRE3Jpw>; Wed, 30 May 2001 05:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbRE3Jpm>; Wed, 30 May 2001 05:45:42 -0400
Received: from [204.177.156.37] ([204.177.156.37]:37056 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S262685AbRE3Jp0>; Wed, 30 May 2001 05:45:26 -0400
Date: Wed, 30 May 2001 10:43:33 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Jens Axboe <axboe@kernel.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
In-Reply-To: <20010529160704.N26871@suse.de>
Message-ID: <Pine.LNX.4.21.0105301022410.7153-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

  I ran this (well, cut-two) on a 4-way box with 4GB of memory and a
modified qlogic fibre channel driver with 32disks hanging off it, without
any problems.  The test used was SpecFS 2.0

  Peformance is definitely up - but I can't give an exact number, as the
run with this patch was compiled with no-omit-frame-pointer for debugging
any probs.

  I did change the patch so that bounce-pages always come from the NORMAL
zone, hence the ZONE_DMA32 zone isn't needed.  I avoided the new zone, as
I'm not 100% sure the VM is capable of keeping the zones it already has
balanced - and adding another one might break the camels back.  But as the
test box has 4GB, it wasn't bouncing anyway.

Mark


On Tue, 29 May 2001, Jens Axboe wrote:
> Another day, another version.
> 
> Bugs fixed in this version: none
> Known bugs in this version: none
> 
> In other words, it's perfect of course.
> 
> Changes:
> 
> - Added ide-dma segment coalescing
> - Only print highmem I/O enable info when HIGHMEM is actually set
> 
> Please give it a test spin, especially if you have 1GB of RAM or more.
> You should see something like this when booting:
> 
> hda: enabling highmem I/O
> ...
> SCSI: channel 0, id 0: enabling highmem I/O
> 
> depending on drive configuration etc.
> 
> Plea to maintainers of the different architectures: could you please add
> the arch parts to support this? This includes:
> 
> - memory zoning at init time
> - page_to_bus
> - pci_map_page / pci_unmap_page
> - set_bh_sg
> - KM_BH_IRQ (for HIGHMEM archs)
> 
> I think that's it, feel free to send me questions and (even better)
> patches.

