Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTIHAkI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 20:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTIHAkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 20:40:08 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:33152
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261785AbTIHAkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 20:40:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Mon, 8 Sep 2003 10:47:45 +1000
User-Agent: KMail/1.5.3
Cc: John Yau <jyau_kernel_dev@hotmail.com>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309071722430.20816-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.44.0309071722430.20816-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081047.45461.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003 10:27, David Lang wrote:
> On Mon, 8 Sep 2003, Con Kolivas wrote:
> > Ultra short timeslices would dissolve a lot of the interactivity issues
> > but come with a serious problem - most cpu caches these days, which are
> > incredibly valuable to cpu performance, take time to be filled and
> > emptied, and 1ms timeslices are just too short to use their benefits. The
> > time required to derive useful benefit depends on the cpu type but can be
> > up to 20ms. In my patches, the most interactive tasks round robin every
> > 10ms which can cause some detriment to performance, but fortunately
> > interactive tasks tend not to be as cpu bound as other tasks. What also
> > happens is that if an interactive task decides to use a burst of cpu it
> > will always be dropped by at least one priority so the tasks that only
> > ever use small amounts of cpu (read audio apps) will always go first.
>
> Con,
> doesn't this get affected more with the CPU and memory speed then with
> clock time? (i.e. the faster CPU is calling for addresses in a sorter time
> period since it gets through more of the program and the faster memory
> gets the cache misses into cache faster)
>
> or are the caches getting enough larger as CPU and memeory
> speeds climb that the clock time is close to being consistant?
>
> it just seems wrong to list a specific wall clock time nessasary to fill a
> cache with so many variables, it may have been correct as of the date that
> time was calculated, but as CPU's change I would expect the minimum time
> to vary quite a bit based on the particular CPU (which brings up the
> question of if the timeslices should be different for different CPU's)

Good question. What it seems from basic testing is that the cache build 
up/tear down time does not seem to change at the same rate as the clock speed 
at all. From the testing I _could_ do, it made no difference across PII->PIV 
in terms of deriving benefit from the minimum timeslice possible, suggesting 
to me that the cache is probably the rate limiting thing but I have no 
further science to back me up on that. This meant to me that despite the fact 
that varying timeslice according to clock speed sounding like a good idea, it 
would probably be better to vary the timeslice according to cpu architecture 
first (i386), family second (P2 versus P4), and clock speed to not have any 
effect. All in all it makes for another swag of confusing changes that 
probably are not worth it in the grand scheme if the baseline settings work 
well across the board.

There are heaps of people out there with more hardware knowledge than I who 
could answer this better.

Con

