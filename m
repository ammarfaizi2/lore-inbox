Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271384AbTHMFYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 01:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271388AbTHMFYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 01:24:39 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:21228 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S271384AbTHMFYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 01:24:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Wed, 13 Aug 2003 01:24:31 -0400
User-Agent: KMail/1.5.1
Cc: jw schultz <jw@pegasys.ws>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308050207.18096.kernel@kolivas.org> <200308122307.22813.gene.heskett@verizon.net> <3F39AF78.1030903@cyberone.com.au>
In-Reply-To: <3F39AF78.1030903@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308130124.31978.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.61.27] at Wed, 13 Aug 2003 00:24:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 23:24, Nick Piggin wrote:
>Gene Heskett wrote:
>>On Tuesday 12 August 2003 22:08, jw schultz wrote:
>>>On Tue, Aug 12, 2003 at 09:58:04PM +1000, Nick Piggin wrote:
>>>>I have been hearing of people complaining the scheduler is worse
>>>>than 2.4 so its not entirely obvious to me. But yeah lots of it
>>>> is trial and error, so I'm not saying Con is wasting his time.
>>>
>>>I've been watching Con and Ingo's efforts with the process
>>>scheduler and i haven't seen people complaining that the
>>>process scheduler is worse.  They have complained that
>>>interactive processes seem to have more latency.  Con has
>>>rightly questioned whether that might be because the process
>>>scheduler has less control over CPU time allocation than in
>>>2.4.  Remember that the process scheduler only manages the
>>>CPU time not spent in I/O and other overhead.
>>>
>>>If there is something in BIO chewing cycles it will wreak
>>>havoc with latency no matter what you do about process
>>>scheduling.  The work on BIO to improve bandwidth and reduce
>>>latency was Herculean but the growing performance gap
>>>between CPU and I/O is a formidable challenge.
>>
>>In thinking about this from the aspect of what I do here, this
>> makes quite a bit of sense.  In running 2.6.0-test3, with
>> anticipatory scheduler, it appears the i/o intensive tasks are
>> being pushed back in favor of interactivity, perhaps a bit too
>> aggressively.  An amanda estimate phase, which turns tar loose on
>> the drives, had to be advanced to a -10 niceness for the whole
>> tree of processes amanda spawns before it began to impact the
>> setiathome use as shown by the nice display in gkrellm.  Normally
>> there is a period for maybe 20 minutes before the tape drive fires
>> up where the machine is virtually unusable due to gzip hogging
>> things, like the cpu, during which time seti could just as easily
>> be swapped out.  It remained at around 60%!
>>
>>It did not hog/lag near as badly as usual, and the amanda run was
>> over an hour longer than it would have been in 2.4.22-rc2.
>>
>>It is my opinion that all this should have been at setiathomes
>>expense, which is also rather cpu intensive, but it didn't seem to
>> be without lots of forceing.  This is what the original concept of
>> niceness was all about.  Or at least that was my impression.  From
>> what it feels like here, it seems the i/o stuff is whats being
>> choked, and choked pretty badly when using the anticipatory
>> scheduler.
>>
>>I've read rumors that a boottime option can switch it to somethng
>>else, so what do I do to switch it from the anticipatory scheduler
>> to whatever the alternate is?, so that I can get a feel for the
>> other methods and results.
>
>Boot with "elevator=deadline" to use the more conventional elevator.
>
>It would be good if you could get some numbers 2.4 vs 2.6, with and
>without seti running. Sounds like a long cycle though so you
> probably can't be bothered!

Not this time of the night at least since amanda is doing her nightly 
thing ATM.  But thats not an impossible task, just time consuming.  
Right now, 40 minutes into the backup, seti is only getting 20% of 
the cpu, and I'd expect the run to be finished by about 3:50.  Kernel 
is 2.4.22-rc2 ATM.

Tomorrow nite, I'll be running the 2.6.0-test3 kernel, and will kill 
seti just before amanda starts and see how long it takes.

Then thursday I'll be running the deadline scheduler just for 
comparison, again without seti, and I'll relate the results.

Unrelated question:  I've applied the 2.6 patches someone pointed me 
at to the nvidia-linux-4496-pkg2 after figuring out how to get it to 
unpack and leave itself behind, so x can be run on 2.6 now.  But its 
a 100% total crash to exit x by any method when using it that way.

Has the patch been updated in the last couple of weeks to prevent that 
now?  It takes nearly half an hour to e2fsck a hundred gigs worth of 
drives, and its going to bite me if I don't let the system settle 
before I crash it to reboot, finishing the reboot with the hardware 
reset button.

Better yet, a fresh pointer to that site.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

