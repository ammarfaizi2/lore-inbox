Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131077AbRASBqf>; Thu, 18 Jan 2001 20:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131389AbRASBqY>; Thu, 18 Jan 2001 20:46:24 -0500
Received: from Cantor.suse.de ([194.112.123.193]:49937 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131378AbRASBqN>;
	Thu, 18 Jan 2001 20:46:13 -0500
Date: Fri, 19 Jan 2001 02:46:10 +0100
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010119024610.A7573@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0101181449240.4124-100000@freak.distro.conectiva> <20010119011629.C32087@athlon.random> <20010119024023.B18209@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010119024023.B18209@suse.de>; from axboe@suse.de on Fri, Jan 19, 2001 at 02:40:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 02:40:23AM +0100, Jens Axboe wrote:
> On Fri, Jan 19 2001, Andrea Arcangeli wrote:
> > On Thu, Jan 18, 2001 at 03:17:13PM -0200, Marcelo Tosatti wrote:
> > > Jens, can be the -blk patch the reason for the slowdown I'm seeing?
> > 
> > This heuristic is way too aggressive:
> > 
> > 	/*
> > 	 * Try to keep 128MB max hysteris. If not possible,
> > 	 * use half of RAM
> > 	 */
> > 	high_queued_sectors = (total_ram * 2) / 3;
> > 	low_queued_sectors = high_queued_sectors - MB(128);
> > 	if (low_queued_sectors < 0)
> > 		low_queued_sectors = total_ram / 2;
> > 
> > 	/*
> > 	 * for big RAM machines (>= 384MB), use more for I/O
> > 	 */
> > 	if (total_ram >= MB(384)) {
> > 		high_queued_sectors = (total_ram * 4) / 5;
> > 		low_queued_sectors = high_queued_sectors - MB(128);
> > 	}
> > 
> > 2/3 of ram locked down in the I/O queue is way too much. 1/3 should be
> > ok. big RAM machines needs way less than 1/3 locked down.
> 
> Yes I agree, that values should probably be tweaked a bit. I'll
> try and squeeze some testing in to generate the best possible
> values.

Please also add a sysctl. I always feel uncomfortable with such hardcoded
heuristics. There tends to be always another workload where the heuristic
fails and manual tuning is useful. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
