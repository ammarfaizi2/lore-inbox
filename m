Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWAZPYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWAZPYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 10:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWAZPYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 10:24:22 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:51207 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932355AbWAZPYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 10:24:22 -0500
Message-ID: <43D8E96B.3070606@symas.com>
Date: Thu, 26 Jan 2006 07:23:23 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>	 <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au>
In-Reply-To: <43D8E298.3020402@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Howard Chu wrote:
>> scheduling policy at all, the expectation is that the current thread 
>> will not continue to run unless there are no other runnable threads 
>> in the same process. The other important point here is that the 
>> yielding thread is only cooperating with other threads in its 
>> process. The 2.6 
>
> No I don't think so. POSIX 1.b where sched_yield is defined are the
> realtime extensions, are they not?
>
> sched_yield explicitly makes reference to the realtime priority system
> of thread lists does it not? It is pretty clear that it is used for
> realtime processes to deterministically give up their timeslices to
> others of the same priority level.

The fact that sched_yield came originally from the realtime extensions 
is just a historical artifact. There was a pthread_yield() function 
specifically for threads and it was merged with sched_yield(). Today 
sched_yield() is a core part of the basic Threads specification, 
independent of the realtime extensions. The fact that it is defined 
solely in the language of the realtime priorities is an obvious flaw in 
the spec, since the function itself exists independently of realtime 
priorities. The objection I raised with the Open Group specifically 
addresses this flaw.

> Linux's SCHED_OTHER behaviour is arguably the best interpretation,
> considering SCHED_OTHER is defined to have a single priority level.

It appears that you just read the spec and blindly followed it without 
thinking about what it really said and failed to say. The best 
interpretation would come from saying "hey, this spec is only defined 
for realtime behavior, WTF is it supposed to do for the default 
non-realtime case?" and getting a clear definition in the spec.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

