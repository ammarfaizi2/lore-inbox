Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271343AbTHMDZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271352AbTHMDZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:25:05 -0400
Received: from dyn-ctb-210-9-243-246.webone.com.au ([210.9.243.246]:42504 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S271343AbTHMDY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:24:59 -0400
Message-ID: <3F39AF78.1030903@cyberone.com.au>
Date: Wed, 13 Aug 2003 13:24:40 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: jw schultz <jw@pegasys.ws>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <3F38D64C.2030109@cyberone.com.au> <20030813020808.GC23237@pegasys.ws> <200308122307.22813.gene.heskett@verizon.net>
In-Reply-To: <200308122307.22813.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Gene Heskett wrote:

>On Tuesday 12 August 2003 22:08, jw schultz wrote:
>
>>On Tue, Aug 12, 2003 at 09:58:04PM +1000, Nick Piggin wrote:
>>
>>>I have been hearing of people complaining the scheduler is worse
>>>than 2.4 so its not entirely obvious to me. But yeah lots of it is
>>>trial and error, so I'm not saying Con is wasting his time.
>>>
>>I've been watching Con and Ingo's efforts with the process
>>scheduler and i haven't seen people complaining that the
>>process scheduler is worse.  They have complained that
>>interactive processes seem to have more latency.  Con has
>>rightly questioned whether that might be because the process
>>scheduler has less control over CPU time allocation than in
>>2.4.  Remember that the process scheduler only manages the
>>CPU time not spent in I/O and other overhead.
>>
>>If there is something in BIO chewing cycles it will wreak
>>havoc with latency no matter what you do about process
>>scheduling.  The work on BIO to improve bandwidth and reduce
>>latency was Herculean but the growing performance gap
>>between CPU and I/O is a formidable challenge.
>>
>
>In thinking about this from the aspect of what I do here, this makes 
>quite a bit of sense.  In running 2.6.0-test3, with anticipatory 
>scheduler, it appears the i/o intensive tasks are being pushed back 
>in favor of interactivity, perhaps a bit too aggressively.  An amanda 
>estimate phase, which turns tar loose on the drives, had to be 
>advanced to a -10 niceness for the whole tree of processes amanda 
>spawns before it began to impact the setiathome use as shown by the 
>nice display in gkrellm.  Normally there is a period for maybe 20 
>minutes before the tape drive fires up where the machine is virtually 
>unusable due to gzip hogging things, like the cpu, during which time 
>seti could just as easily be swapped out.  It remained at around 60%!
>
>It did not hog/lag near as badly as usual, and the amanda run was over 
>an hour longer than it would have been in 2.4.22-rc2.
>
>It is my opinion that all this should have been at setiathomes 
>expense, which is also rather cpu intensive, but it didn't seem to be 
>without lots of forceing.  This is what the original concept of 
>niceness was all about.  Or at least that was my impression.  From 
>what it feels like here, it seems the i/o stuff is whats being 
>choked, and choked pretty badly when using the anticipatory 
>scheduler.
>
>I've read rumors that a boottime option can switch it to somethng 
>else, so what do I do to switch it from the anticipatory scheduler to 
>whatever the alternate is?, so that I can get a feel for the other 
>methods and results.
>

Boot with "elevator=deadline" to use the more conventional elevator.

It would be good if you could get some numbers 2.4 vs 2.6, with and
without seti running. Sounds like a long cycle though so you probably
can't be bothered!


