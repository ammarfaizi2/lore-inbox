Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277373AbRJENUv>; Fri, 5 Oct 2001 09:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277375AbRJENUm>; Fri, 5 Oct 2001 09:20:42 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:49804 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S277373AbRJENUX>; Fri, 5 Oct 2001 09:20:23 -0400
Message-ID: <3BBDB26D.2050705@antefacto.com>
Date: Fri, 05 Oct 2001 14:15:25 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alex Larsson <alexl@redhat.com>, Ulrich Drepper <drepper@cygnus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <m3r8slywp0.fsf@myware.mynet> <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com> <20011003232609.A11804@gruyere.muc.suse.de> <3BBDAB24.7000909@antefacto.com> <20011005150144.A11810@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Fri, Oct 05, 2001 at 01:44:20PM +0100, Padraig Brady wrote:
>
>>Andi Kleen wrote:
>>
>>>On Wed, Oct 03, 2001 at 11:15:04AM -0400, Alex Larsson wrote:
>>>
>>>>Is a nanoseconds field the right choice though? In reality you might not 
>>>>have a nanosecond resolution timer, so you would miss changes that appear
>>>>on shorter timescale than the timer resolution. Wouldn't a generation 
>>>>counter, increased when ctime was updated, be a better solution?
>>>>
>>>Near any CPU has a cycle counter builtin now, which gives you ns like
>>>resolution. In theory you could still get collisions on MP systems, 
>>>but window is small enough that it can be ignored in practice.
>>>
>>>-Andi
>>>
>>But the point is you, only ever would want nano second resolution to make
>>sure you notice all changes to a file. A more general (and much simpler)
>>solution would be to gen_count++ every time a file's modified. What other
>>applications would require better than second resolution on files?
>>
>
>The main advantage of using a real timestamp instead of a generation
>counter is that we would be compatible to Unixware/Solaris/... Their
>API is fine, so I see no advantage in inventing a new incompatible one.
>
Even so I can't see a need to have this resolution for mtime, and as you 
pointed
out there can still be races on SMP systems and timing resolutions are 
system
dependent anyway.

>
>Another advantage of using the real time instead of a counter is that 
>you can easily merge the both values into a single 64bit value and do
>arithmetic on it in user space. With a generation counter you would need 
>to work with number pairs, which is much more complex. 
>
??
if (file->mtime != mtime || file->gen_count != gen_count)
     file_changed=1;

>
>[or alternatively reset the generation counter every second in the kernel
>to get a flat time range again, 
>which would be racy and ugly and complicated in the kernel because it 
>would need additional timestamps] 
>
No need as long as it doesn't wrap within the mtime resolution (1 second).

>
>Also a rdtsc/get_timestamp or in the worst case a jiffie read is really
>not complex to code in kernel, what makes you think it is? 
>
Sorry, by more complex I meant more instructions/CPU expensive.

>
>
>-Andi
>
Padraig.

