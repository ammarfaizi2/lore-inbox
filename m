Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbTHZSB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbTHZSB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:01:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48345 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262786AbTHZSBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:01:51 -0400
Date: Tue, 26 Aug 2003 20:01:46 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: rl@hellgate.ch
Subject: Re: [2.6] kernel BUG at arch/i386/mm/highmem.c:14!
Message-ID: <20030826180146.GF862@suse.de>
References: <20030826173337.GA3993@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826173337.GA3993@k3.hellgate.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26 2003, Roger Luethi wrote:
> This BUG immediately followed my turning off DMA on hda (with a mounted
> partition and dirty buffers). Register and stack info are available upon
> request (screenshot). 2.6.0-test4.
> 
> Roger
> 
> kernel BUG at arch/i386/mm/highmem.c:14!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c011bc36>]   Not tainted
> EFLAGS: 00010206
> EIP is at kunmap+0x16/0x30
> [...]
> Process pdflush [...]
> 
>  [<c0158f69>] __blk_queue_bounce+0x1e9/0x230
>  [<c0158fe7>] blk_queue_bounce+0x37/0x60

Funky, it is indeed strictly forbidden to enter this path with
interrupts disabled.

>  [<c022be20>] __make_request+0x50/0x670
>  [<c023ccb0>] task_mulout_intr+0x0/0x290
>  [<c022c584>] generic_make_request+0x144/0x1e0

Possibly some artifact of using read/write multiple on IDE, does it work
if you disable that with -m0 on the device? I'm guessing the error is
100% reproducible?

-- 
Jens Axboe

