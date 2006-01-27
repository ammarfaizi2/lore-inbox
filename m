Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWA0SiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWA0SiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWA0SiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:38:11 -0500
Received: from [85.8.13.51] ([85.8.13.51]:19417 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751530AbWA0SiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:38:11 -0500
Message-ID: <43DA687C.8050401@drzeus.cx>
Date: Fri, 27 Jan 2006 19:37:48 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127123917.GI4311@suse.de> <43DA1D23.1000508@drzeus.cx>
In-Reply-To: <43DA1D23.1000508@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> 
> Doesn't seem like a generic solution is easily implemented. I'll start
> hacking together some way of specifying that highmem isn't supported so
> that mmc_block can indicate this to the block layer.
> 

Whilst doing this I discovered that the MMC layer already does some
bounce buffer limiting. It defaults to BLK_BOUNCE_HIGH, but when
dev->dma_mask is set it uses that. The problem is that the default value
for PCI devices covers high mem transfers.

Russell, what was your plan here? Should MMC drivers set dma_mask to
BLK_BOUNCE_HIGH when not doing DMA? Or perhaps 0?

Rgds
Pierre

