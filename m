Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280088AbRJaFjb>; Wed, 31 Oct 2001 00:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280086AbRJaFjT>; Wed, 31 Oct 2001 00:39:19 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:42172 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S280083AbRJaFjG>; Wed, 31 Oct 2001 00:39:06 -0500
Date: Wed, 31 Oct 2001 00:41:29 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.ent,
        torvalds@transmeta.com
Subject: Re: VM test comparison of 2.4.14-pre5, aa1, and 2.4.13-ac5-fs
Message-ID: <20011031004129.A207@earthlink.net>
In-Reply-To: <20011030022640.A225@earthlink.net> <20011030154911.E1340@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030154911.E1340@athlon.random>; from andrea@suse.de on Tue, Oct 30, 2001 at 03:49:11PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 03:49:11PM +0100, Andrea Arcangeli wrote:
> > 
> > Averages for 10 mtest01 runs
> > bytes allocated:                    1241933414
> > bytes allocated:                    1250217164
> > bytes allocated:                    1244345139
> 
> the mtest01 -p may comparing apples to oranges. Please make sure to apply
> the -p fix I posted in the last days before using the -p option,
> 
> thanks!
> 
> Andrea

I put Andrea's patch on mtest01.c to remove the variation of memory allocated
between runs.  So far I've only tested it on 2.4.14pre5aa1.  

Paul Larson's comments about the test working as designed make sense too.  

Jen Axboe's comment about how much I/O comes into play in these tests is
right on.  The mmap001 test pounds the disk with 20000-30000 Blk_wrtn/s.
mtest01 can do over 50000 Blk_wrtn/s.

Small differences in any results should be ignored, because there is always some 
variation in the test.  I.E. One run may receive 120 lines of input from the IRC 
clients, and another only 30.  One run I may type 30 characters, another 200.  
Not a lot of difference when you think about bytes processed, but it can affect 
the results.

This isn't a perfectly controlled test, though I try to keep variations
down to the things listed above.  For the last 10 days or so, I always use
the same mp3 sampled at 128k.

There are differences in .config too.  They all started with the same .config,
but after "make oldconfig", they change a little.  In the diff below, aa=Andrea, 
ac=Alan, lt=Linus.  (This is from latest pre5aa1, ac5, and pre5 kernels)

diff aa ac
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_PPRO_FENCE=y
< CONFIG_NO_PAGE_VIRTUAL=y

diff aa lt
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
< CONFIG_NO_PAGE_VIRTUAL=y

diff ac lt
< CONFIG_GENERIC_ISA_DMA=y
< CONFIG_X86_PPRO_FENCE=y


The kernels themselves vary in size a bit.

2.4.14pre5aa
Memory: 514516k/524224k available (912k kernel code, 9320k reserved, 231k data, 208k init

2.4.13-ac5
Memory: 513492k/524224k available (911k kernel code, 10344k reserved, 235k data, 212k init

2.4.14-pre5
Memory: 514060k/524224k available (904k kernel code, 9776k reserved, 228k data, 208k init


This is from 2.4.14pre5aa1 with mtest01 patch.

mp3 played 288 seconds of 392 second run (new run with patch - more bytes allocated)
mp3 played 318 seconds of 383 second run (previous run).

Averages for 10 mtest01 runs
bytes allocated:                    1284505600
User time (seconds):                2.145
System time (seconds):              3.005
Elapsed (wall clock) time:          39.206
Percent of CPU this job got:        12.60
Major (requiring I/O) page faults:  132.1
Minor (reclaiming a frame) faults:  314387.9

mp3 played 848 seconds of  875 second run.
mp3 played 823 seconds of  878 second run (previous run).

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.530
System time (seconds):              14.396
Elapsed (wall clock seconds) time:  174.98
Percent of CPU this job got:        19.00
Major (requiring I/O) page faults:  500165.0
Minor (reclaiming a frame) faults:  43.0

For the re-run of mmap001, the seconds played varied by 3% from the
previous run.  Any difference of 5% or less should be ignored, imho.

So I'm thinking about just continuing to use the mtest01 from LTP, 
knowing that with my test conditions, a variation of a few percent 
isn't significant.

Andrea, is that okay with you?

-- 
Randy Hron

