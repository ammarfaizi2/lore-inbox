Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbVJ0WQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbVJ0WQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVJ0WQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:16:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:32930 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932675AbVJ0WQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:16:53 -0400
To: Michael Madore <michael.madore@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: high address but no IOMMU
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2005 00:16:51 +0200
In-Reply-To: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com>
Message-ID: <p73slum38rw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Madore <michael.madore@gmail.com> writes:

> 2.6.14-rc5 on a dual Opteron nforce4 motherboard with 8GB of RAM:
> 
> Checking aperture...
> CPU 0: aperture @ be8c000000 size 32 MB
> Aperture from northbridge cpu 0 too small (32 MB)
> No AGP bridge found
> Your BIOS doesn't leave a aperture memory hole
> Please enable the IOMMU option in the BIOS setup
> This costs you 64 MB of RAM
> Mapping aperture over 65536 KB of RAM @ 8000000
> 
> ...
> 
> PCI-DMA: Disabling AGP.
> PCI-DMA: More than 4GB of RAM and no IOMMU
> PCI-DMA: 32bit PCI IO may malfunction.<6>PCI-DMA: Disabling IOMMU.
> 
> ...
> 
> Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
> Kernel panic - not syncing: PCI-DMA: high address but no IOMMU.
> 
> With 2.6.13, the systems boots OK with these messages in the log:
> 
> Checking aperture...
> CPU 0: aperture @ 8000000 size 32 MB
> Aperture from northbridge cpu 0 too small (32 MB)
> No AGP bridge found
> Your BIOS doesn't leave a aperture memory hole
> Please enable the IOMMU option in the BIOS setup
> This costs you 64 MB of RAM
> Mapping aperture over 65536 KB of RAM @ 8000000
> 
> ...
> 
> PCI-DMA: Disabling AGP.
> PCI-DMA: aperture base @ 8000000 size 65536 KB
> PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture

Can you post the full boot log? 
 
> Using git bisect, I narrowed the problem down to the following commit:
> 
> 6142891a0c0209c91aa4a98f725de0d6e2ed4918 is first bad commit
> diff-tree 6142891a0c0209c91aa4a98f725de0d6e2ed4918 (from
> 357e11d4cbbbb959a88a9bdbbf33a10f160b0823)
> Author: Andi Kleen <ak@suse.de>
> Date:   Mon Sep 12 18:49:24 2005 +0200
> 
>     [PATCH] x86-64: Avoid unnecessary double bouncing for swiotlb
> 
>     PCI_DMA_BUS_IS_PHYS has to be zero even when the GART IOMMU is disabled
>     and the swiotlb is used. Otherwise the block layer does unnecessary
>     double bouncing.

Your system shouldn't be using swiotlb anyways.

-Andi
