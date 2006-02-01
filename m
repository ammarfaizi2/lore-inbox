Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWBAOJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWBAOJr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWBAOJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:09:47 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:42103 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161058AbWBAOJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:09:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Pf+jMUq4ZpVktN9TbhWrlYN+lIGaANG8CmGpltTqh8VOuhhuyXwXhBoCQhuWAibkjtjq8m2z/DywwbIZzN0kPCxe8qIu8FYfmw+tuHRGclFNFSx/oT0RuqGjeXGYTVJuMIHheA8wf2Y4Z5I192un1+XMhdtjsXQZt7SgtzLLYCo=  ;
Message-ID: <43E0C127.8060401@yahoo.com.au>
Date: Thu, 02 Feb 2006 01:09:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <1138736609.7088.35.camel@localhost.localdomain> <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au> <20060201132054.GA31156@elte.hu> <43E0BBEC.3020209@yahoo.com.au> <20060201140041.GA5298@elte.hu>
In-Reply-To: <20060201140041.GA5298@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>>So it is not a nice thing to tinker with unless there is good reason.
>>>
>>>unbound latencies with hardirqs off are obviously a good reason - but i 
>>>agree that the solution is not good enough, yet.
>>
>>Ah, so this is an RT tree thing where the scheduler lock turns off 
>>"hard irqs"? [...]
> 
> 
> no, this is about the mainline kernel turning off hardirqs for a long 
> time. (i used the hardirqs-off terminology instead of irqs-off to 
> differentiate it from softirqs-off a'ka local_bh_disable(). It's a 
> side-effect of working on the lock validator i guess ;).
> 

OK.

> 
>>[...] As opposed to something like the rwsem lock that only turns off 
>>your "soft irqs" (sorry, I'm not with the terminlogy)?
> 
> 
> rwsems/rwlocks are not an issue in -rt because they have different 
> semantics there - and thus readers cannot amass. I do think rwsems and 
> rwlocks have pretty nasty characteristics [non-latency ones] for the 
> mainline kernel's use too, but that's not being argued here ;)
> 

But all I'm saying is that while there are equivalent magnitudes of
interrupts off regions in mainline, there is little point introducing
a hack like this to "solve" one of them.

Sure, rework one of them nicely to solve the issue for that case, or
hack _all_ of them (not for mainline but for your specific RT system).
But hacking just one does not make any sense.

Just because this one path actually _triggered_ due to a silly
benchmark doesn't make it any more valid. I think it shouldn't be too
hard to cause similar or worse latencies with the mmap_sem rwsem using
the same number of threads.

If anyone is running hackbench 20 on their sound mixer, then they
deserve to have overruns.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
