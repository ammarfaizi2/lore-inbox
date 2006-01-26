Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWAZPvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWAZPvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 10:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWAZPvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 10:51:24 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:20356 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964783AbWAZPvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 10:51:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nyH2O4nGPypn0WeJT6ThTBKkSzCxXqlqjgbW2BJ5ijHp46sU2tP1YAyQleayaBZDI1PQcHvTnXN5UUOyJ8GbGTnZxeRdtlmQjujdyBrrMy5Mz/RQwasGDUjGPKNMJJxIm0gB7v+1IpsRPW/RIRnVUEIdCYX1YB0sqe5h0vP4LWQ=  ;
Message-ID: <43D8EFF7.3070203@yahoo.com.au>
Date: Fri, 27 Jan 2006 02:51:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>	 <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com>
In-Reply-To: <43D8E96B.3070606@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Nick Piggin wrote:
> 
>> Howard Chu wrote:
>>
>>> scheduling policy at all, the expectation is that the current thread 
>>> will not continue to run unless there are no other runnable threads 
>>> in the same process. The other important point here is that the 
>>> yielding thread is only cooperating with other threads in its 
>>> process. The 2.6 
>>
>>
>> No I don't think so. POSIX 1.b where sched_yield is defined are the
>> realtime extensions, are they not?
>>
>> sched_yield explicitly makes reference to the realtime priority system
>> of thread lists does it not? It is pretty clear that it is used for
>> realtime processes to deterministically give up their timeslices to
>> others of the same priority level.
> 
> 
> The fact that sched_yield came originally from the realtime extensions 
> is just a historical artifact. There was a pthread_yield() function 
> specifically for threads and it was merged with sched_yield(). Today 
> sched_yield() is a core part of the basic Threads specification, 
> independent of the realtime extensions. The fact that it is defined 
> solely in the language of the realtime priorities is an obvious flaw in 
> the spec, since the function itself exists independently of realtime 
> priorities. The objection I raised with the Open Group specifically 
> addresses this flaw.
> 

Either way, it by no means says anything about yielding to other
threads in the process but nobody else. Where did you get that
from?

>> Linux's SCHED_OTHER behaviour is arguably the best interpretation,
>> considering SCHED_OTHER is defined to have a single priority level.
> 
> 
> It appears that you just read the spec and blindly followed it without 
> thinking about what it really said and failed to say. The best 

No, a spec is something that is written unambiguously, and generally
the wording leads me to believe they attempted to make it so (it
definitely isn't perfect - your mutex unlock example is one that could
be interpreted either way). If they failed to say something that should
be there then the spec needs to be corrected -- however in this case
I don't think you've shown what's missing.

And actually your reading things into the spec that "they failed to say"
is wrong I believe (in the above sched_yield example).

> interpretation would come from saying "hey, this spec is only defined 
> for realtime behavior, WTF is it supposed to do for the default 
> non-realtime case?" and getting a clear definition in the spec.
> 

However they do not omit to say that. They quite explicitly say that
SCHED_OTHER is considered a single priority class in relation to its
interactions with other realtime classes, and is otherwise free to
be implemented in any way.

I can't see how you still have a problem with that...

-- 
Send instant messages to your online friends http://au.messenger.yahoo.com 
