Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUGQJ0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUGQJ0L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 05:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUGQJ0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 05:26:11 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:63335 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266334AbUGQJ0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 05:26:07 -0400
Message-ID: <40F8F0A6.8020003@yahoo.com.au>
Date: Sat, 17 Jul 2004 19:25:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc1-np1
References: <40F8B7C5.9030201@yahoo.com.au> <1090053943.1828.4.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1090053943.1828.4.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On Sat, 2004-07-17 at 15:23 +1000, Nick Piggin wrote:
> 
> 
>>Scheduler behaviour is generally pretty good now so I've increased the
>>timeslice size to see how far I can push it. Some workloads really demand
>>small timeslices though, so I've added /proc/sys/kernel/base_timeslice.
>>If you have any problems with the default, please report it to me, and
>>check if lowering this value helps.
> 
> 
> On my 700Mhz Pentium III Mobile laptop, I feel that 256ms is too high
> for the system to keep interactive when a CPU hog is running. For

Yeah, it is probably a bit too large here too. A burst of activity
from X can cause xmms to skip slightly. Probably 128 or 64 would
be a decent default.

> example, running "while true; do a=2; done" makes the system pretty
> sluggish with the default timeslice. This is noticeable while dragging
> windows around (the movement is jerky and doesn't feel smooth).
> Decreasing the timeslie to 50ms, or even better, 25ms, makes the system
> behave much much better, although it will decrease throughput
> considerably, I guess.
> 

It usually isn't too bad for desktops, but is more important on
systems with more CPUs and bigger caches.

On this dual P3 with 256K L2 cache, a make -j8 vmlinux uses
162.16user 15.43system, ~150ctxsw/s with base_timeslice = 10000
163.88user 16.16system, ~300ctxsw/s with base_timeslice = 32
192.65user 17.27system, ~1300ctxsw/s with base_timeslice = 1

So you come to the point of diminishing returns very quickly, and
32 or even 16 or 8 are probably fine values for a desktop system
and worth the small cost for CPU intensive tasks.
