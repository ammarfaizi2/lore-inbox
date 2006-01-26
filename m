Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWAZOyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWAZOyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWAZOyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:54:20 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:41087 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932201AbWAZOyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:54:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=d0aklalnm24Zdyk+IEiaGCIGjzekBbJVTJ0m9WfWX09Of5Z1X9FXRsrlKgtWfYYp4GX6Q5mvFJAIdVZkuHVlCwGfVkfxSAFV1WDNZHc7U8uSphuVQXcnkajW9E3MWN2N/KLNqXYoHtaMO+qwWZJWAGbLgDIgC9dElfsJXk77i34=  ;
Message-ID: <43D8E298.3020402@yahoo.com.au>
Date: Fri, 27 Jan 2006 01:54:16 +1100
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
References: <20060124225919.GC12566@suse.de>	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>	 <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com>
In-Reply-To: <43D8DB90.7070601@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Nick Piggin wrote:

>> They obviously don't need to redefine exactly what sched_yield may do
>> under each scheduling policy, do they?
>>
> As Dave Butenhof says so often, threading is a cooperative programming 
> model, not a competitive one. The sched_yield function exists for a 
> specific purpose, to let one thread decide to allow some other thread to 
> run. No matter what the scheduling policy, or even if there is no 

Yes, and even SCHED_OTHER in Linux attempts to do this as part of
the principle of least surprise. That it doesn't _exactly_ match
what you want it to do just means you need to be using something
else.

> scheduling policy at all, the expectation is that the current thread 
> will not continue to run unless there are no other runnable threads in 
> the same process. The other important point here is that the yielding 
> thread is only cooperating with other threads in its process. The 2.6 

No I don't think so. POSIX 1.b where sched_yield is defined are the
realtime extensions, are they not?

sched_yield explicitly makes reference to the realtime priority system
of thread lists does it not? It is pretty clear that it is used for
realtime processes to deterministically give up their timeslices to
others of the same priority level.

Linux's SCHED_OTHER behaviour is arguably the best interpretation,
considering SCHED_OTHER is defined to have a single priority level.

> kernel behavior effectively causes the entire process to give up its 
> time slice, since the yielding thread has to wait for other processes in 
> the system before it can run again. Again, if folks wanted process 

It yields to all other SCHED_OTHER processes (which are all on the
same thread priority list) and not to any other processes of higher
realtime priority.

> scheduling behavior they would have used fork().
> 

It so happens that processes and threads use the same scheduling
policy in Linux. Is that forbidden somewhere?

> By the way, I've already raised an objection with the Open Group asking 
> for more clarification here.
> http://www.opengroup.org/austin/aardvark/latest/xshbug2.txt   request 
> number 120.
> 

-- 
Send instant messages to your online friends http://au.messenger.yahoo.com 
