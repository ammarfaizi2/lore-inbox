Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbTBXVbV>; Mon, 24 Feb 2003 16:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267583AbTBXVbV>; Mon, 24 Feb 2003 16:31:21 -0500
Received: from [195.223.140.107] ([195.223.140.107]:36998 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267595AbTBXVbT>;
	Mon, 24 Feb 2003 16:31:19 -0500
Date: Mon, 24 Feb 2003 22:42:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224214220.GX29467@dualathlon.random>
References: <15961.33856.876529.568807@napali.hpl.hp.com> <Pine.LNX.4.44.0302231840220.1690-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302231840220.1690-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 06:54:41PM -0800, Linus Torvalds wrote:
> 
> On Sun, 23 Feb 2003, David Mosberger wrote:
> >   >> 2 GHz Xeon:	701 SPECint
> >   >> 1 GHz Itanium 2:	810 SPECint
> > 
> >   >> That is, Itanium 2 is 15% faster.
> > 
> > Unfortunately, HP doesn't sell 1.5MB/1GHz Itanium 2 workstations, but
> > we can do some educated guessing:
> > 
> >   1GHz Itanium 2, 3MB cache:		810 SPECint
> >   900MHz Itanium 2, 1.5MB cache:	674 SPECint
> > 
> > Assuming pure frequency scaling, a 1GHz/1.5MB Itanium 2 would get
> > around 750 SPECint.  In reality, it would get slightly less, but most
> > likely substantially more than 701.
> 
> And as Dean pointed out:
> 
>   2Ghz Xeon MP with 2MB L3 cache:	842 SPECint
> 
> In other words, the P4 eats the Itanium for breakfast even if you limit it 
> to 2GHz due to some "process" rule.
> 
> And if you don't make up any silly rules, but simply look at "what's 
> available today", you get
> 
>   2.8Ghz Xeon MP with 2MB L3 cache: 	907 SPECint
> 
> or even better (much cheaper CPUs):
> 
>   3.06 GHz P4 with 512kB L2 cache:	1074 SPECint
>   AMD Athlon XP 2800+:			 933 SPECint
> 
> These are systems that you can buy today. With _less_ cache, and clearly
> much higher performance (the difference between the best-performing
> published ia-64 and the best P4 on specint, the P4 is 32% faster. Even 
> with the "you can only run the P4 at 2GHz because that is all it ever ran 
> at in 0.18" thing the ia-64 falls behind.

I agree, especially the cache difference makes any comparison not
interesting to my eyes (it's similar to running dbench with different
pagecache sizes and comparing the results). But I've a side note on
these matters in favour of the 64bit platforms. I could be wrong, but
AFIK some of the specint testcases generates a double data memory
footprint if compiled 64bit, so I guess some of the testcases should be
really called speclong and not specint. (however I don't think those
testcases alone can explain a global 32% difference, but still there
would be some difference in favour of the 32bit platform)

So in short, I currently believe specint is not a good benchmark to
compare a 64bit cpu to a 32bit cpu, 64bit can only lose in specint if
the cpu is exactly the same but only the data 'longs' are changed to
64bit.  To do a real fair comparison one should first change the source
replacing every "long" with either a "long long" or an "int", only then
it will be fair to compare specint results between 32bit and 64bit cpus.

I never used specint myself, so don't ask me more details on this, and
again I could be wrong, but really - if I'm right - somebody should go
over the source and make a kind of unofficial (but official) patch
available to people to generate a specint testsuite usable to compare
32bit with 64bit results, or lots of effort will be wasted by people
pretending to do the impossible. I mean, if the memory bus is the same
hardware in both the 32bit and 64bit runs, the double memory footprint
will run slower and there's nothing the OS or the hardware can do about
it (and dozen mbytes of ram won't fit in l1 cache, not even on the
itanium 8). The benchmark suite really must be fixed to ensure the 32bit
and 64bit compilation will generate the same _data_ memory footprint if
one wants to make comparisons between the two.

Andrea
