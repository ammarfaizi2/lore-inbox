Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132167AbRAXAlA>; Tue, 23 Jan 2001 19:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132216AbRAXAku>; Tue, 23 Jan 2001 19:40:50 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:29993 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S132207AbRAXAki>;
	Tue, 23 Jan 2001 19:40:38 -0500
Date: Wed, 24 Jan 2001 01:43:26 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Godfrey Livingstone <godfrey@hattaway-associates.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Ingo's RAID patch for 2.2.18 final?
In-Reply-To: <20010124010936.A1201@athlon.random>
Message-ID: <Pine.LNX.4.30.0101240126500.3522-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Andrea Arcangeli wrote:

> > 2.2.19preXaaX Virtually disabled I/O cache extention-by-swapout, working
> > on previous (semi)stock kernels (raid+ide patched) :(
> Can you measure a performance degradation because of that? Previous kernels was
> certainly not a good example because they was swapping out stuff even with
> `cp /dev/zero .`.

Still produced an overall average extra 30+% more serviced bandwidth for
fileserving. (large files, we can call them high BW streaming...)

> You said me your machine start to swapout when the filesystem cache reaches
> 100mbytes (on your 384Mbyte box). That seems sane behaviour on a misc load. We

Nope.

> could add some additional bit of page aging to swapout more when it worth
> indeed, but current balance looks just quite sane.

Ok let's see: the box does a lot of this fileserving. 3MB/s+

Sometimes I use it interactivelly (pine, X, netscape).

Sometimes others log in remotely, pine, etc.

Sometimes they read their mail (apache, neomail)

bind runs for one (1) zone.

Sshd is listening.

Sendmail is listening.

Infrequently friends use squid proxy on it.

Notes runs, currently is being tested, buteven more infrequently.

=> So, basically, a lot of stuff is runing, but they are rarely used.
Compared to the gain which could result swapping out the more or less
inactive processes' pages, freeing ram for the all time fileservings cache
(30+ high speed streams from 4 disks does really need some caching).

I do not say the case is "nothing is active please store everything on
swap, get back only what is needed", but the actual situation is on the
contrary: 0 (zero) bytes swapped out!

Can't say, of these many daemons nothing can be swapped out (and should
under I/O load)!

And even if I don't think this zero swapping is ok, I do use it, because I
do not get a single "VM: do_try_to_free_pages failed for ..." no more...
The performance just used to be better, but the whole more instable.

Be this, if this is the price for stability.

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
