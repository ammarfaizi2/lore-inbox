Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbQKFRRy>; Mon, 6 Nov 2000 12:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbQKFRRo>; Mon, 6 Nov 2000 12:17:44 -0500
Received: from [209.245.157.171] ([209.245.157.171]:11392 "EHLO krispykreme")
	by vger.kernel.org with ESMTP id <S129467AbQKFRRg>;
	Mon, 6 Nov 2000 12:17:36 -0500
Date: Mon, 6 Nov 2000 09:17:23 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
Message-ID: <20001106091723.A516@linuxcare.com>
In-Reply-To: <20001106011000.A9787@athlon.random> <E13sa8o-0005jc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13sa8o-0005jc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 06, 2000 at 12:28:00AM +0000
From: Anton Blanchard <anton@linuxcare.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > fast_gettimeoffset_quotient, see do_fast_gettimeoffset().
> 
> Also remember that the TSC may not be available due to the chip era, chip
> bugs or running SMP with non matched CPU clocks.

When I boot my thinkpad 600e off battery and then change to AC power,
gettimeofday has a nasty habit of going backwards. Stephen Rothwell
tells me it is one of these machines in which the cycle counter
slows down when power is removed.

This means our offset calculations in do_fast_gettimeoffset are way off
and taking a reading just before a timer tick and just after results in
a negative interval. Perhaps we should disable tsc based gettimeofday
for these type of machines.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
