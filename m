Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbRAXB1V>; Tue, 23 Jan 2001 20:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbRAXB1M>; Tue, 23 Jan 2001 20:27:12 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15680 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130195AbRAXB0z>; Tue, 23 Jan 2001 20:26:55 -0500
Date: Wed, 24 Jan 2001 02:27:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Sasi Peter <sape@iq.rulez.org>
Cc: Godfrey Livingstone <godfrey@hattaway-associates.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Ingo's RAID patch for 2.2.18 final?
Message-ID: <20010124022726.D1201@athlon.random>
In-Reply-To: <20010124010936.A1201@athlon.random> <Pine.LNX.4.30.0101240126500.3522-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101240126500.3522-100000@iq.rulez.org>; from sape@iq.rulez.org on Wed, Jan 24, 2001 at 01:43:26AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 01:43:26AM +0100, Sasi Peter wrote:
> (30+ high speed streams from 4 disks does really need some caching).

This isn't obvious. Your working may not fit in cache and so the kernel
understand it's worthless to swapout stuff to make space to a polluted cache.

> Can't say, of these many daemons nothing can be swapped out (and should
> under I/O load)!

If you run `cp /dev/zero .` on a smart VM nothing must be swapped out even if
it generated nearly the maximal I/O flood possible. It's worthless to let a
polluted cache to grow. It won't help anyways and you'll run slower the next
time you'll have to pagein from swap.

It _enterely_ depends on the I/O load pattern if it worth to swapout or not
to make space for filesystem cache.

> The performance just used to be better, but the whole more instable.
> 
> Be this, if this is the price for stability.

As said we can add bits of page aging (that can't destabilize anything and it
will only affect performance behaviour), but I'd prefer to be sure you really
get a slowdown due the new VM behaviour (because more aging if done without
multiqueue O(1) approch can introduces waste of CPU and cachelines in kernel
space), so could you try to kill notes and squid and the other unused stuff and
to see if you return to deliver performance as with the older kernels? I still
miss this important information (last thing you said me was that with 100mbyte
in cache it swapouts, and without knowing the details of the I/O pattern it
looked sane). After that I'd also like to know what happens with 2.4.0 that
uses multiqueue and that is also able to detect pollution and to avoid swapping
out in such case.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
