Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTIBAEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 20:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbTIBAEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 20:04:46 -0400
Received: from anumail4.anu.edu.au ([150.203.2.44]:13229 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S263358AbTIBAEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 20:04:44 -0400
Message-ID: <3F53DE8B.7010701@cyberone.com.au>
Date: Tue, 02 Sep 2003 10:04:27 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>
CC: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: [SHED] Questions.
References: <1062324435.9959.56.camel@big.pomac.com>	 <1062369684.9959.166.camel@big.pomac.com>	 <1062373274.1313.28.camel@boobies.awol.org>	 <200309011707.20135.phillips@arcor.de> <1062457396.9959.243.camel@big.pomac.com>
In-Reply-To: <1062457396.9959.243.camel@big.pomac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-2.5)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien wrote:

>[Forgot CC to LKML and Robert Love, sorry ]
>
>On Mon, 2003-09-01 at 17:07, Daniel Phillips wrote:
>
>>On Monday 01 September 2003 01:41, Robert Love wrote:
>>
>>>Priority inversion is bad, but the priority inversion in this case is
>>>intended.  Higher priority tasks cannot starve lower ones.  It is a
>>>classic Unix philosophy that 'all tasks make some forward progress'
>>>
>>So if I have 1000 low priority tasks and one high priority task, all CPU 
>>bound, the high priority task gets 0.1% CPU.  This is not the desirable or 
>>expected behaviour.
>>

In my implementation, the high prio guy gets 1.9% CPU and the others get
0.09%. However, in all implementations, the high priority one will be 
allowed
to preempt the any of others, of course.

At this point you can safely abandon the consideration that a user might be
running KDE as well ;)

>
>>My conclusion is, the strategy of expiring the whole active array before any 
>>expired tasks are allowed to run again is incorrect.  Instead, each active 
>>list should be refreshed from the expired list individually.  This does not 
>>affect the desirable O(1) scheduling property.  To prevent low priority 
>>starvation, the high-to-low scan should be elaborated to skip some runnable, 
>>high priority tasks occasionally in a *controlled* way.
>>
>
>I like this idea.
>You could handle the priority starvation with a "old process" boost.
>(i don't know which would be simpler or if there is something even
>simpler out there)
>
>This would ensure that all processes are run sooner or later. Real
>cpuhogs would run very seldom due to being starved, but run when they
>get the boost. On a loaded system this might be desirable since most
>login tools would be "normal" or "high pri" from the get go.
>(there might be a problem with locks though)
>
>This should also work hand in hand with timeslice changes imho. Aswell
>as process preemption. If we assume that cpu hogs has work that they
>want to get done, let em do it for as long as possible. If something
>"important" happens, it'll be preempted right?
>

This is really just another variation on the idea of dynamic timeslices.
Mine does it explicitly. This idea and the interactivity idea do it
implicitly (not that thats bad).


