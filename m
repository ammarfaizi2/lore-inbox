Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVHUAgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVHUAgE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 20:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVHUAgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 20:36:04 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:21101 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750739AbVHUAgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 20:36:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=MWJmucQZqCzKopB/d1DO1VpW2tfR1gFuQejdLY45KqGgVk9FwRumtyJl841BBOcLm19UkR/jMpKRMxQuemybd+ePuDcdfNqypxv0omkFpfGpoEFLifd62GQJ3KZ5ygBvWldKJ5I/4SRTgIWa0T05iDPmN+y2Fqfm6DloHYtLjEI=  ;
Message-ID: <4307CC76.8060308@yahoo.com.au>
Date: Sun, 21 Aug 2005 10:36:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: Lee Revell <rlrevell@joe-job.com>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca>	 <4306AF26.3030106@yahoo.com.au>  <4307788E.1040209@symas.com> <1124571437.2115.3.camel@mindpipe> <43079FA9.700@symas.com>
In-Reply-To: <43079FA9.700@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Lee Revell wrote:
> 
>>  On Sat, 2005-08-20 at 11:38 -0700, Howard Chu wrote:
>> > But I also found that I needed to add a new yield(), to work around
>> > yet another unexpected issue on this system - we have a number of
>> > threads waiting on a condition variable, and the thread holding the
>> > mutex signals the var, unlocks the mutex, and then immediately
>> > relocks it. The expectation here is that upon unlocking the mutex,
>> > the calling thread would block while some waiting thread (that just
>> > got signaled) would get to run. In fact what happened is that the
>> > calling thread unlocked and relocked the mutex without allowing any
>> > of the waiting threads to run. In this case the only solution was
>> > to insert a yield() after the mutex_unlock().
>>
>>  That's exactly the behavior I would expect.  Why would you expect
>>  unlocking a mutex to cause a reschedule, if the calling thread still
>>  has timeslice left?
> 
> 
> That's beside the point. Folks are making an assertion that 
> sched_yield() is meaningless; this example demonstrates that there are 
> cases where sched_yield() is essential.
> 

The point is, with SCHED_OTHER scheduling, sched_yield() need not
do anything. It may not let any other tasks run.

The fact that it does on Linux is because we do attempt to do
something expected... but the simple matter is that you can't realy
on it to do what you expect.

I'm not sure exactly how you would solve the above problem, but I'm
sure it can be achieved using mutexes (for example, you could have
a queue where every thread waits on its own private mutex).... but I
don't do much userspace C programming sorry.

Send instant messages to your online friends http://au.messenger.yahoo.com 
