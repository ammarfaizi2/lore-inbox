Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275832AbTHSQVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275421AbTHSQTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:19:23 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S271118AbTHSQQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:16:09 -0400
Message-ID: <3F4228CB.9000805@cyberone.com.au>
Date: Tue, 19 Aug 2003 23:40:27 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
References: <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith wrote:

> At 11:53 AM 8/19/2003 +1000, Nick Piggin wrote:
>
>> Hi everyone,
>>
>> As per the latest trend these days, I've done some tinkering with
>> the cpu scheduler. I have gone in the opposite direction of most
>> of the recent stuff and come out with something that can be nearly
>> as good interactivity wise (for me).
>>
>> I haven't run many tests on it - my mind blanked when I tried to
>> remember the scores of scheduler "exploits" thrown around. So if
>> anyone would like to suggest some, or better still, run some,
>> please do so. And be nice, this isn't my type of scheduler :P
>
>
> Ok, I took it out for a quick spin...


Thanks again.

>
> Test-starve.c starvation is back (curable via other means), but irman2 
> is utterly harmless.  Responsiveness under load is very nice until I 
> get to the "very hefty" end of the spectrum (expected).  Throughput is 
> down a bit at make -j30, and there are many cc1's running at very high 
> priority once swap becomes moderately busy.  OTOH, concurrency for the 
> make -jN in general appears to be up a bit.  X is pretty choppy when 
> moving windows around, but that _appears_ to be the newer/tamer 
> backboost bleeding a kdeinit thread a bit too dry.  (I think it'll be 
> easy to correct, will let you know if what I have in mind to test that 
> theory works out).  Ending on a decidedly positive note, I can no 
> longer reproduce priority inversion troubles with xmms's gl thread, 
> nor with blender.


Well, it sounds like a good start, though I'll have to get up to scratch
on the array of scheduler badness programs!

I expect throughput to be down in this release due to the timeslice thing.
This should be fixable.

I think either there is a bug in my accounting somewhere or I have not quite
thought it though properly because priorities don't seem to get distributed
well. Also its not using the nanosecond timing stuff (yet). This might help
a bit.

Nick

