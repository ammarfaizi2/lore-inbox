Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRAXPCq>; Wed, 24 Jan 2001 10:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbRAXPCg>; Wed, 24 Jan 2001 10:02:36 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:16172 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S129847AbRAXPCU>;
	Wed, 24 Jan 2001 10:02:20 -0500
Date: Wed, 24 Jan 2001 16:05:12 +0100
Message-Id: <200101241505.QAA01045@iq.rulez.org>
From: "Sasi Peter" <sape@iq.rulez.org>
To: Andrea Arcangeli <andrea@suse.de>, Sasi Peter <sape@iq.rulez.org>,
        Godfrey Livingstone <godfrey@hattaway-associates.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Ingo's RAID patch for 2.2.18 final?
X-Mailer: NeoMail 1.21
X-IPAddress: 195.228.20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (30+ high speed streams from 4 disks does really need some caching).
> This isn't obvious. Your working may not fit in cache and so the 
kernel
> understand it's worthless to swapout stuff to make space to a 
polluted cache.

But your understanding agrees on that the larger chunks for each stream 
we read into cache, the more efficient for this kind of RAID disk 
structure the read is, thus basically the more cache we have, the more 
bandwidth we can serve. (disks give more data in the same time with 
fewer long reads than with several shorter ones)

So might it have been an accidental behaviour of the previous kernels 
to swap out pages in favor of caching under high I/O pressure, but it 
was certainly a benefical behaviour.

> > Can't say, of these many daemons nothing can be swapped out (and 
should
> > under I/O load)!
> If you run `cp /dev/zero .` on a smart VM nothing must be swapped out 
even if
> it generated nearly the maximal I/O flood possible. It's worthless to 
let a
> polluted cache to grow. It won't help anyways and you'll run slower 
the next
> time you'll have to pagein from swap.
> It _enterely_ depends on the I/O load pattern if it worth to swapout 
or not
> to make space for filesystem cache.

Ok (possibily incorrect, but simple) definition of I/O pressure of mine 
is when the _real_ _physical_ disks are working all the time, pushing 
data out of the box (in this case through the network).

"cp /dev/zero ." is a somewhat different from my case:
- mine is an IRL case (don't know how often a pattern like the "cp" 
case show up IRL)
- Mine is about _reading_ from disks
 
> > Be this, if this is the price for stability.
> As said we can add bits of page aging (that can't destabilize 
anything and it
> will only affect performance behaviour), but I'd prefer to be sure 
you really
> get a slowdown due the new VM behaviour (because more aging if done 
without
> multiqueue O(1) approch can introduces waste of CPU and cachelines in 
kernel
> space), so could you try to kill notes and squid and the other unused 
stuff and
> to see if you return to deliver performance as with the older 
kernels? I still

It might and it should, but actually I gotta have these started in case 
someone drops in for using them. As I understand the only thing this is 
worth trying out for is that maybe even with more cache I will have 
less performance, than before, because in this case to or not to swap 
out dows not really matter. Is this correct? Beacuse I will have to 
have these running anyways...

> miss this important information (last thing you said me was that with 
100mbyte
> in cache it swapouts, and without knowing the details of the I/O 
pattern it

like when decreasing constantly, at reaching that only 100MB cache we 
have left do we start swapping to have more cache, or at least have the 
100MB not less.

> looked sane). After that I'd also like to know what happens with 
2.4.0 that
> uses multiqueue and that is also able to detect pollution and to 
avoid swapping
> out in such case.

What should I test with? (2.4.0/1pre?)

-- SaPE / Sasi Péter / mailto: sape@sch.hu / http://sape.iq.rulez.org/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
