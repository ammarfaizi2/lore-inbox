Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUBAURZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 15:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbUBAURZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 15:17:25 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:49328
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265291AbUBAURX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 15:17:23 -0500
Message-ID: <401D5F33.60400@tmr.com>
Date: Sun, 01 Feb 2004 15:18:59 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1: process start times by procps
References: <20040127155254.GA1656@elektroni.ee.tut.fi> <1075342912.1592.72.camel@cog.beaverton.ibm.com>
In-Reply-To: <1075342912.1592.72.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Tue, 2004-01-27 at 07:52, Petri Kaukasoina wrote:
> 
>>On Sun, Jan 25, 2004 at 01:08:47PM +0200, I wrote:
>>
>>>On Fri, Jan 23, 2004 at 09:47:14PM +0200, I wrote:
>>>
>>>>For example, I started this bash process really at 21:24 (date showed 21:24
>>>>then):
>>>>
>>>>kaukasoi 22108  0.0  0.2  4452 1532 pts/4    R    21:28   0:00 /bin/bash
>>>
>>>OK, I would like to make my bug report more accurate: the problem seems to
>>>be that the value of btime in /proc/stat is not correct.
>>
>>btime in /proc/stat does not stay constant but decreases at a rate of 15
>>secs/day. (So I thought that that's why there is that four minute error in
>>ps output after uptime of a couple of weeks.) Maybe this has something to do
>>with the fact that the 'timer' line in /proc/interrupts does not seem to
>>increase at an exact rate of 1000 steps per second but about 1000.18 steps
>>per second, instead. (The relative error is the same: 0.18 divided by 1000
>>is equal to 15 seconds divided by 24 hours).
>>
>>I made an experiment shown below. I know nothing about kernel programming,
>>so this is probably not correct, but at least btime seemed to stay constant.
>>(I don't believe this fixes procps, though. If HZ if off by 180 ppm then I
>>guess ps can't possibly get its calculations involving HZ right. But at
>>least the bootup time reported by procinfo stays constant.)
> 
> 
> 
> Uh, what does your /etc/ntp/drift file show?
> 
> The basic equation is: 
> btime ~= gettimeodfay() - uptime
> 
> Thus if your time of day is adjusted by NTP, btime will change as well.
> Uptime is calculated calculated by jiffies/HZ, and HZ is not NTP
> adjusted, so if your system is running 180ppm too fast or slow, btime
> would be expected to change. 

It would seem that there is a problem having the system know which two 
times to believe. Given that I set time from a good source in rc.local, 
it would be nice to have the system know that the correct and unchanging 
btime is NOW-uptime. And to make that assumption it would have to be 
told in some way that the btime should be calculated and treated as 
unchanging. On other systems a standard may never be used, or the 
standard mey be the local cable guide (most have a time).

A good thing to consider if you care, I guess right after setting to a 
trusted clock I might want to save the btime somewhere.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
