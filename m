Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTBJHd5>; Mon, 10 Feb 2003 02:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTBJHd5>; Mon, 10 Feb 2003 02:33:57 -0500
Received: from dial-ctb03241.webone.com.au ([210.9.243.241]:37125 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S264716AbTBJHdz>;
	Mon, 10 Feb 2003 02:33:55 -0500
Message-ID: <3E475833.704@cyberone.com.au>
Date: Mon, 10 Feb 2003 18:43:47 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <ckolivas@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <3E4718D9.4030805@cyberone.com.au> <Pine.LNX.4.50L.0302100143000.12742-100000@imladris.surriel.com> <3E472E33.9070604@cyberone.com.au> <20030210072650.GF31401@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>On Mon, Feb 10, 2003 at 03:44:35PM +1100, Nick Piggin wrote:
>
>>Rik van Riel wrote:
>>
>>
>>>On Mon, 10 Feb 2003, Nick Piggin wrote:
>>>
>>>
>>>>Andrea Arcangeli wrote:
>>>>
>>>>
>>>>
>>>>>The only way to get the minimal possible latency and maximal fariness is
>>>>>my new stochastic fair queueing idea.
>>>>>
>>>>>
>>>>Sounds nice. I would like to see per process disk distribution.
>>>>
>>>>
>>>Sounds like the easiest way to get that fair, indeed.  Manage
>>>every disk as a separately scheduled resource...
>>>
>>>
>>I hope this option becomes available one day.
>>
>>
>>>
>>>>However dependant reads can not merge with each other obviously so
>>>>you could end up say submitting 4K reads per process.
>>>>
>>>>
>>>Considering that one medium/far disk seek counts for about 400 kB
>>>of data read/write, I suspect we'll just want to merge requests or
>>>put adjacant requests next to each other into the elevator up to
>>>a fairly large size. Probably about 1 MB for a hard disk or a cdrom,
>>>but much less for floppies, opticals, etc...
>>>
>>>
>>Yes, but the point is _dependant reads_. This is why Andrea's approach
>>alone can't solve dependant read vs write or nondependant read - while
>>maintaining a good throughput.
>>
>
>note that for soem workloads the _dependant reads_ can have _dependant
>writes_ in between. I know it's not the most common case though, but I
>don't love too much to make reads that much special. But again, it makes
>perfect sense to have it as a feature, but I wouldn't like it to be only
>option, I mean there must always be a way to disable anticipatory
>scheduling like there must be a way to disable SFQ (infact for SFQ it
>makes sense to leave it disabled by default, it's only a few people that
>definitely only cares to have the lowest possible latency for mplayer or
>xmms, or for multiuser system doing lots of I/O, but those guys can't
>live without it)
>
>Andrea
>
If you pass the information down, the IO scheduler can easily put a
lower expiry time on sync writes for example, or a higher one on
async reads. This isn't what the anticipatory scheduler patch is
about.

The point is that it is very easy to get a huge backlog of writes
for the purpose of disk head schedule optimising, but this is
difficult with reads, anticipatory scheduling helps address this.
Thats all really.

