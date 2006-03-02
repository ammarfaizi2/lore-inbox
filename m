Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWCBLpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWCBLpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 06:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWCBLpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 06:45:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40721 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750701AbWCBLpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 06:45:31 -0500
Date: Thu, 2 Mar 2006 11:45:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060302114526.GC14017@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <20060129152228.GF13831@suse.de> <43DDC6F9.6070007@drzeus.cx> <20060130080930.GB4209@suse.de> <43DFAEC6.3090205@drzeus.cx> <20060301232913.GC4024@flint.arm.linux.org.uk> <44069E3A.4000907@drzeus.cx> <20060302094153.GA14017@flint.arm.linux.org.uk> <4406C044.4080201@drzeus.cx> <20060302100409.GB14017@flint.arm.linux.org.uk> <4406C845.8000603@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4406C845.8000603@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 11:26:13AM +0100, Pierre Ossman wrote:
> This I know. My beef is the readability of:
> 
> if (do_dma)
>     *dev->dma_mask = DEVICE_DMA_MASK;
> else
>     *dev->dma_mask = 0;
> 
> I.e. we use dma_mask even though we don't do DMA.

Not a lot we can do about the readability issue - we end up with code
like that in some layer of the MMC.  If it's in mmc_queue, it might be:

        u64 limit = BLK_BOUNCE_HIGH;

        if (host->caps & MMC_CAP_DMA &&
	    host->dev->dma_mask && *host->dev->dma_mask)
                limit = *host->dev->dma_mask;

which is equally as (un)readable as your code.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
