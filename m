Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWIKXiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWIKXiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWIKXiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:38:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:26309 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965048AbWIKXiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:38:05 -0400
Message-ID: <4505F358.3040204@garzik.org>
Date: Mon, 11 Sep 2006 19:38:00 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Neil,
> 
> The following patches implement hardware accelerated raid5 for the Intel
> Xscale® series of I/O Processors.  The MD changes allow stripe
> operations to run outside the spin lock in a work queue.  Hardware
> acceleration is achieved by using a dma-engine-aware work queue routine
> instead of the default software only routine.
> 
> Since the last release of the raid5 changes many bug fixes and other
> improvements have been made as a result of stress testing.  See the per
> patch change logs for more information about what was fixed.  This
> release is the first release of the full dma implementation.
> 
> The patches touch 3 areas, the md-raid5 driver, the generic dmaengine
> interface, and a platform device driver for IOPs.  The raid5 changes
> follow your comments concerning making the acceleration implementation
> similar to how the stripe cache handles I/O requests.  The dmaengine
> changes are the second release of this code.  They expand the interface
> to handle more than memcpy operations, and add a generic raid5-dma
> client.  The iop-adma driver supports dma memcpy, xor, xor zero sum, and
> memset across all IOP architectures (32x, 33x, and 13xx).
> 
> Concerning the context switching performance concerns raised at the
> previous release, I have observed the following.  For the hardware
> accelerated case it appears that performance is always better with the
> work queue than without since it allows multiple stripes to be operated
> on simultaneously.  I expect the same for an SMP platform, but so far my
> testing has been limited to IOPs.  For a single-processor
> non-accelerated configuration I have not observed performance
> degradation with work queue support enabled, but in the Kconfig option
> help text I recommend disabling it (CONFIG_MD_RAID456_WORKQUEUE).
> 
> Please consider the patches for -mm.
> 
> -Dan
> 
> [PATCH 01/19] raid5: raid5_do_soft_block_ops
> [PATCH 02/19] raid5: move write operations to a workqueue
> [PATCH 03/19] raid5: move check parity operations to a workqueue
> [PATCH 04/19] raid5: move compute block operations to a workqueue
> [PATCH 05/19] raid5: move read completion copies to a workqueue
> [PATCH 06/19] raid5: move the reconstruct write expansion operation to a workqueue
> [PATCH 07/19] raid5: remove compute_block and compute_parity5
> [PATCH 08/19] dmaengine: enable multiple clients and operations
> [PATCH 09/19] dmaengine: reduce backend address permutations
> [PATCH 10/19] dmaengine: expose per channel dma mapping characteristics to clients
> [PATCH 11/19] dmaengine: add memset as an asynchronous dma operation
> [PATCH 12/19] dmaengine: dma_async_memcpy_err for DMA engines that do not support memcpy
> [PATCH 13/19] dmaengine: add support for dma xor zero sum operations
> [PATCH 14/19] dmaengine: add dma_sync_wait
> [PATCH 15/19] dmaengine: raid5 dma client
> [PATCH 16/19] dmaengine: Driver for the Intel IOP 32x, 33x, and 13xx RAID engines
> [PATCH 17/19] iop3xx: define IOP3XX_REG_ADDR[32|16|8] and clean up DMA/AAU defs
> [PATCH 18/19] iop3xx: Give Linux control over PCI (ATU) initialization
> [PATCH 19/19] iop3xx: IOP 32x and 33x support for the iop-adma driver

Can devices like drivers/scsi/sata_sx4.c or drivers/scsi/sata_promise.c 
take advantage of this?  Promise silicon supports RAID5 XOR offload.

If so, how?  If not, why not?  :)

	Jeff



