Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318167AbSHDS0X>; Sun, 4 Aug 2002 14:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318168AbSHDS0X>; Sun, 4 Aug 2002 14:26:23 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:39430 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318167AbSHDS0W>; Sun, 4 Aug 2002 14:26:22 -0400
Message-ID: <3D4D7284.7050507@namesys.com>
Date: Sun, 04 Aug 2002 22:29:24 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
References: <200208041308.51638.agruen@suse.de> <3D4D1070.1020802@namesys.com> <200208041511.27990.agruen@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:

>On Sunday 04 August 2002 13:30, Hans Reiser wrote:
>  
>
>>How do you ensure that caches have their (internal) aging hands pushed
>>at a speed that is proportional to their memory usage, or is your design
>>susceptible to all the usual complaints the unified memory manager crowd
>>has about separate caches?
>>    
>>
>
>That's a policy/optimization issue; it's not even desirable to shrink the 
>caches with priorities proportional to their size---they would all tend to 
>become equally large.
>
That is not what I said, I said move the aging hand at a speed 
proportional to size, what affect the aging has depends on the usage of 
the objects in the cache.

>
>The patch shrinks all the caches equally often, with the same priorities. 
>
This is wrong, because frequently used objects should not be shrunk out 
of their caches.

>The 
>caches can then decide themselves how they will react, depending on their 
>cache size and entry size, replacement strategy, taking care of page entry 
>clustering or not, etc.
>
How can they decide this without a pressure signal from the master 
memory manager that is proportional to their size?  Or is the idea that 
they figure out their own size?  I suppose that is equivalent....

>
>The icache, dcache, and dqcache are shrunk using the same strategy (except the 
>priority is a constant for some of the caches, which could be coded in the 
>shrink function as well). 
>
What does priority

>This scheme has worked out pretty well so far, 
>right?
>
 Our cache management has deep algorithm flaws which result in things 
like one active dcache entry keeping an entire page of unused dcache 
entries from expiring from the cache.  Did you see Joshua MacDonald's 
post on that topic?

>
>For Extended Attributes we are currently using a very simple cache with LRU 
>entry replacement, and small entries. The cache doesn't grow very big, 
>either.
>
You don't support eas that are larger than a page?  Is it LRU on each 
ea, or is it LRU on the page containing the ea?

>
>Regards,
>Andreas.
>
>------------------------------------------------------------------
> Andreas Gruenbacher                                SuSE Linux AG
> mailto:agruen@suse.de                     Deutschherrnstr. 15-19
> http://www.suse.de/                   D-90429 Nuernberg, Germany
>
>
>
>  
>


-- 
Hans



