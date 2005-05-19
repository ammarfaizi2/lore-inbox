Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVESMVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVESMVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVESMVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:21:43 -0400
Received: from alog0191.analogic.com ([208.224.220.206]:46470 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262470AbVESMVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:21:37 -0400
Date: Thu, 19 May 2005 08:19:04 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Adrian Bunk <bunk@stusta.de>
cc: Kyle Moffett <mrmacman_g4@mac.com>, "Gilbert, John" <JGG@dolby.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <20050519112840.GE5112@stusta.de>
Message-ID: <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
 <20050518195337.GX5112@stusta.de> <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
 <20050519112840.GE5112@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Adrian Bunk wrote:

> On Wed, May 18, 2005 at 10:22:24PM -0400, Kyle Moffett wrote:
>>
>> On May 18, 2005, at 15:53:37, Adrian Bunk wrote:
>>> Looking at the source code of MySQL, it seems MySQL does some dirty
>>> tricks for using the inlines from asm/atomic.h in userspace.
>>>
>>> It's _really_ wrong to do this.
>>
>> A project that had some discussion a while ago was to clean up the
>> kernel headers and separate them from the kernel-ABI ones, such that
>> the ABI headers don't need to use CONFIG_* defines or anything else.
>> that might be iffy.
>> ...
>
> The whole kernel headers issue contains real problems that have to be
> solved properly.
>
> But in this case, this is not the problem:
>
> What MySQL uses from asm/atomic.h doesn't seem to have anything to do
> with any kind of kernel <-> userspace interface (which is what userspace
> might validly require kernel headers for).
>
>> Cheers,
>> Kyle Moffett
>
> cu
> Adrian

First off, I think we need a system-call that will return some of
the information that now comes from headers. PAGE_SIZE comes to
mind. You need this for mmap() but there doesn't seem to be any
way to get it. getpagesize() 'C' library just returns something
it's swiped from kernel headers when the library was compiled.
There are other things like the following that sometimes need
to be known also.

 	HZ
 	TASK_SIZE
 	SMP
 	MAXHOSTNAMELEN
 	_NSIG
 	Number of errno values
 	Highest ioctl value used
 	A default 'struct termios'

These things are gotten from 'kernel' headers used when the
'C' runtime library was built. They can all change. If these
and others were returned all at once in a structure, then
the 'C' runtime library could make a single call during
initialization and have the correct information for the
existing kernel.

>
> -- 
>
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                       Pearl S. Buck - Dragon Seed
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
