Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136728AbRASBlO>; Thu, 18 Jan 2001 20:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136678AbRASBlE>; Thu, 18 Jan 2001 20:41:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2319 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136710AbRASBkt>;
	Thu, 18 Jan 2001 20:40:49 -0500
Date: Fri, 19 Jan 2001 02:40:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010119024023.B18209@suse.de>
In-Reply-To: <Pine.LNX.4.21.0101181449240.4124-100000@freak.distro.conectiva> <20010119011629.C32087@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010119011629.C32087@athlon.random>; from andrea@suse.de on Fri, Jan 19, 2001 at 01:16:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19 2001, Andrea Arcangeli wrote:
> On Thu, Jan 18, 2001 at 03:17:13PM -0200, Marcelo Tosatti wrote:
> > Jens, can be the -blk patch the reason for the slowdown I'm seeing?
> 
> This heuristic is way too aggressive:
> 
> 	/*
> 	 * Try to keep 128MB max hysteris. If not possible,
> 	 * use half of RAM
> 	 */
> 	high_queued_sectors = (total_ram * 2) / 3;
> 	low_queued_sectors = high_queued_sectors - MB(128);
> 	if (low_queued_sectors < 0)
> 		low_queued_sectors = total_ram / 2;
> 
> 	/*
> 	 * for big RAM machines (>= 384MB), use more for I/O
> 	 */
> 	if (total_ram >= MB(384)) {
> 		high_queued_sectors = (total_ram * 4) / 5;
> 		low_queued_sectors = high_queued_sectors - MB(128);
> 	}
> 
> 2/3 of ram locked down in the I/O queue is way too much. 1/3 should be
> ok. big RAM machines needs way less than 1/3 locked down.

Yes I agree, that values should probably be tweaked a bit. I'll
try and squeeze some testing in to generate the best possible
values.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
