Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUHUBkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUHUBkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 21:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268814AbUHUBkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 21:40:55 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:49126 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S268812AbUHUBkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 21:40:51 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 20 Aug 2004 21:40:48 -0400
User-Agent: KMail/1.6.82
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408050948.47535.gene.heskett@verizon.net> <200408210118.02011.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408210118.02011.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408202140.49125.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.62.54] at Fri, 20 Aug 2004 20:40:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 August 2004 18:18, Denis Vlasenko wrote:
>> mmm, I wonder who the zombie is.  Ahh, it's ~/bin/its-daylight.
>> It's a script that cron triggered, and which changes the mode of
>> the heyu/xtend stuff for daytime operations.  Its (a bash script)
>> apparently hung looking for a response it didn't get.  I have 3
>> of those at various times of the day and I've never gotten email
>> from that one.  The mode change does occur though...  FWIW heyu
>> has been fixed, the distro version has a severe scope problem
>> from a missing '}' which was not caught by the compiler, but by
>> a tool I wrote years ago for os9 that I've ported to linux!   The
>> heyu author ): didn't seem to be interested in fixing it either.
>>
>> I'll go take a look at it after I've sent this, but it does bring
>> up a sore point.  linux doesn't get this right, os9 did.  zombies
>> are killable by os9, it simply takes it out of the execution
>> queue, and reclaims all resources used back into the free pool, no
>> questions asked or expected.  We shouldn't have to reboot just to
>> kill a fscking zombie...
>
>zombie is not much more than an exit code to be collected by
>wait() syscall. All other resources are already freed.
>
>Zombies result when parent does not wait() for dead children.
>Trivial example:
>
>#!/bin/sh
>sleep 10 &
>exec env - sleep 100
>
>26752 pts/0    S      0:00           sleep 100
>26753 pts/0    Z      0:00             [sleep <defunct>]
>
>Such zombies got reparented to init *as soon as parent dies itself*.
>Properly functioning init constanly wait()s for any unexpected
> chindren, so it takes care of zombies.
>--
>vda

Oh oh, looks like I need a lesson in bash then.  The whole basic idea 
of what I was doing there was for the parent shell to go away, 
leaving the child process sitting there until its done some 10 
seconds later.  If I didn't do that, then cron seemed to hang on the 
first execution as if was dutifully waiting for bash to exit...

The bash manual I have is both too concise, and too verbose because 
bash is as close to emac's as I can think of when looking for a 
universal executer.

In the crontab its this:
00 05 * * *     /root/bin/its-daylight

Then /root/bin/its-daylight calls 2 other scripts using the "&" 
syntax.

So I guess its time to RTFM on bash again.

Thanks.

Now, to get this back on-thread..

I switched the memory sticks to each others sockets this afternoon.  
And "memburn 512" megabytes, which puts me into the swap about 70 
megs, is still running with no detected errors in 1162 loops.  About 
4:30 elapsed time so far.  I've got all my fingers and toes crossed, 
and everything but tied a knot in it, hoping this may be the end of 
the problem.  If not, then the nightmare continues.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
