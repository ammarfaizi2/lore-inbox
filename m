Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTBJEfB>; Sun, 9 Feb 2003 23:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbTBJEfB>; Sun, 9 Feb 2003 23:35:01 -0500
Received: from dial-ctb0186.webone.com.au ([210.9.241.86]:49412 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261495AbTBJEfA>;
	Sun, 9 Feb 2003 23:35:00 -0500
Message-ID: <3E472E33.9070604@cyberone.com.au>
Date: Mon, 10 Feb 2003 15:44:35 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <ckolivas@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <3E4718D9.4030805@cyberone.com.au> <Pine.LNX.4.50L.0302100143000.12742-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 10 Feb 2003, Nick Piggin wrote:
>
>>Andrea Arcangeli wrote:
>>
>>
>>>The only way to get the minimal possible latency and maximal fariness is
>>>my new stochastic fair queueing idea.
>>>
>>Sounds nice. I would like to see per process disk distribution.
>>
>
>Sounds like the easiest way to get that fair, indeed.  Manage
>every disk as a separately scheduled resource...
>
I hope this option becomes available one day.

>
>
>>However dependant reads can not merge with each other obviously so
>>you could end up say submitting 4K reads per process.
>>
>
>Considering that one medium/far disk seek counts for about 400 kB
>of data read/write, I suspect we'll just want to merge requests or
>put adjacant requests next to each other into the elevator up to
>a fairly large size. Probably about 1 MB for a hard disk or a cdrom,
>but much less for floppies, opticals, etc...
>
Yes, but the point is _dependant reads_. This is why Andrea's approach
alone can't solve dependant read vs write or nondependant read - while
maintaining a good throughput.

>
>
>>But your solution also does nothing for sequential IO throughput in
>>the presence of more than one submitter.
>>
>
>>I think you should be giving each process a timeslice,
>>
>
>That is the anticipatory scheduler.  A good complement to the SFQ
>part of the IO scheduler.  I'd really like to see both ideas together
>in one scheduler, they sound like a winning pair.
>
No, anticipatory scheduling just "pauses for a bit after some reads"
I am talking about all this nonsense about trying to measure seek vs
throughput vs rotational latency, etc. We don't process schedule by
how many memory accesses a process makes * processor speed / memory
speed + instruction jumps.....

If you want a fair disk scheduler, just give each process a disk
timeslice, and all your seek, stream, settle, track buffer, etc
accounting is magically done for you... For any device, and is
100% tunable. The point is, account by _time_.

Nick

