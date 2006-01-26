Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWAZQpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWAZQpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWAZQpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:45:23 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:18440 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1750754AbWAZQpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:45:22 -0500
Message-ID: <43D8FC76.2050906@symas.com>
Date: Thu, 26 Jan 2006 08:44:38 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>	 <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au>
In-Reply-To: <43D8EFF7.3070203@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> No, a spec is something that is written unambiguously, and generally
> the wording leads me to believe they attempted to make it so (it
> definitely isn't perfect - your mutex unlock example is one that could
> be interpreted either way). If they failed to say something that should
> be there then the spec needs to be corrected -- however in this case
> I don't think you've shown what's missing.

What is missing: sched_yield is a core threads function but it's defined 
using language that only has meaning in the presence of an optional 
feature (Process Scheduling.) Since the function must exist even in the 
absence of these options, the definition must be changed to use language 
that has meaning even in the absence of these options.

> And actually your reading things into the spec that "they failed to say"
> is wrong I believe (in the above sched_yield example).
>
>> interpretation would come from saying "hey, this spec is only defined 
>> for realtime behavior, WTF is it supposed to do for the default 
>> non-realtime case?" and getting a clear definition in the spec.
>
> However they do not omit to say that. They quite explicitly say that
> SCHED_OTHER is considered a single priority class in relation to its
> interactions with other realtime classes, and is otherwise free to
> be implemented in any way.
>
> I can't see how you still have a problem with that...
>
I may be missing the obvious, but I couldn't find this explicit 
statement in the SUS docs. Also, it would not address the core 
complaint, that sched_yield's definition has no meaning when the Process 
Scheduling option doesn't exist.

The current Open Group response to my objection reads:
 >>>

Add to APPLICATION USAGE
Since there may not be more than one thread runnable in a process
a call to sched_yield() might not relinquish the processor at all.
In a single threaded application this will always be case.

<<<
The interesting point one can draw from this response is that 
sched_yield is only intended to yield to other runnable threads within a 
single process. This response is also problematic, because restricting 
it to threads within a process makes it useless for Process Scheduling. 
E.g., the Process Scheduling language would imply that a single-threaded 
app could yield the processor to some other process. As such, I think 
this response is also flawed, and the definition still needs more work.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

