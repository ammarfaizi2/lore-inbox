Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWAZOYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWAZOYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWAZOYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:24:53 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:18183 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932336AbWAZOYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:24:52 -0500
Message-ID: <43D8DB90.7070601@symas.com>
Date: Thu, 26 Jan 2006 06:24:16 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>	 <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au>
In-Reply-To: <43D88E55.7010506@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Howard Chu wrote:
>> But then we have to deal with you folks' bizarre notion that 
>> sched_yield() can legitimately be a no-op, which also defies the 
>> POSIX spec. Again, in SUSv3 "The /sched_yield/() function shall force 
>> the running thread to relinquish the processor until it again becomes 
>> the head of its thread list. It takes no arguments." There is no 
>> language 
>
> How many times have we been over this? What do you think the "head of
> its thread list" might mean?
>
>> here saying "sched_yield *may* do nothing at all." There are of course 
>
> There is language saying SCHED_OTHER is arbitrary, including how the
> thread list is implemented and how a task might become on the head of
> it.
>
> They obviously don't need to redefine exactly what sched_yield may do
> under each scheduling policy, do they?
>
As Dave Butenhof says so often, threading is a cooperative programming 
model, not a competitive one. The sched_yield function exists for a 
specific purpose, to let one thread decide to allow some other thread to 
run. No matter what the scheduling policy, or even if there is no 
scheduling policy at all, the expectation is that the current thread 
will not continue to run unless there are no other runnable threads in 
the same process. The other important point here is that the yielding 
thread is only cooperating with other threads in its process. The 2.6 
kernel behavior effectively causes the entire process to give up its 
time slice, since the yielding thread has to wait for other processes in 
the system before it can run again. Again, if folks wanted process 
scheduling behavior they would have used fork().

By the way, I've already raised an objection with the Open Group asking 
for more clarification here.
http://www.opengroup.org/austin/aardvark/latest/xshbug2.txt   request 
number 120.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

