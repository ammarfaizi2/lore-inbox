Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269140AbTCDFTX>; Tue, 4 Mar 2003 00:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269148AbTCDFTX>; Tue, 4 Mar 2003 00:19:23 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:28854 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S269140AbTCDFTV>;
	Tue, 4 Mar 2003 00:19:21 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [BENCHMARK] 2.5.63-mm2 + i/o schedulers with contest
Date: Tue, 4 Mar 2003 16:29:45 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <200303041354.03428.kernel@kolivas.org> <200303041615.17617.kernel@kolivas.org> <3E64390F.7090309@cyberone.com.au>
In-Reply-To: <3E64390F.7090309@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303041629.46019.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003 04:26 pm, Nick Piggin wrote:
> Con Kolivas wrote:
> >On Tue, 4 Mar 2003 03:18 pm, Nick Piggin wrote:
> >>small randomish reads vs large writes _is_ where AS really can
> >>perform better than non a non AS scheduler. Unfortunately gcc
> >>doesn't have the _best_ IO pattern for AS ;)
> >
> >Yes I recall this discussion against a gcc based benchmark. However it is
> >interesting that it still performed by far the best.
>
> Yes, AS obviously does help gcc against io_load. My
> "unfortunately" comment was just a pun, of course we
> don't want to just test where AS does well.
>
> >>>CFQ and DL scheduler were faster compiling the kernel under read_load,
> >>>list_load and dbench_load.
> >>>
> >>>Mem_load result of AS being slower was just plain weird with the result
> >>>rising from 100 to 150 during testing.
> >>
> >>I would like to see if AS helps much with a swap/memory
> >>thrashing load.
> >
> >That's what mem_load is. It repeatedly tries to access 110% of available
> > ram. quote from original post:
> >mem_load:
> >Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> >2.5.63              3   104     75.0    57.7    1.9     1.32
> >2.5.63-mm2cfq       3   101     76.2    52.3    2.0     1.28
> >2.5.63-mm2          3   132     59.1    90.3    2.3     1.65
> >2.5.63-mm2dl        3   100     79.0    52.0    2.0     1.27
> >
> >Note that mm2 with AS performed equivalent to the other schedulers but on
> >later runs took longer. (99, 148,150) This is usually suspicious of a
> > memory leak that contest is unusually sensitive at picking up, but there
> > wasn't anything suspicious about the meminfo after these runs, and none
> > of the other loads changed over time. io_load usually shows drastic
> > prolongation when memory is leaking.
>
> Ah ok. And this change didn't affect other schedulers on mm2? Is
> it reproducable with AS? I'll have to keep this in mind and take
> another look at it after a few othe bugs are fixed.

Not on the other schedulers, no. I'll throw some more benchmarks at it to see 
if it recurs. I didn't think much of it at the time.

Con
