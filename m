Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWAZIyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWAZIyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWAZIyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:54:50 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:21156 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751320AbWAZIyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:54:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OcG7QY/TIPZP43gQpDgFVwOkKP0MkZsnF8zZy10cjEiBi241rJnOk+ycyl82/MeKWFWZp3X9pDD2yCO7YdWI2R6JKkjpIl3pJ4bJBCAqjW8dVhRAA/h8GeI+bpV+lxo2mCmLKsiv70vHDwJVIPu4CrsbuAdn6KAs4sfAxqIgHZA=  ;
Message-ID: <43D88E55.7010506@yahoo.com.au>
Date: Thu, 26 Jan 2006 19:54:45 +1100
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
References: <20060124225919.GC12566@suse.de>	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>	 <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com>
In-Reply-To: <43D7F863.3080207@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Lee Revell wrote:
> 
>> On Wed, 2006-01-25 at 10:26 -0800, Howard Chu wrote:
>>  
>>
>>> The SUSv3 text seems pretty clear. It says "WHEN
>>> pthread_mutex_unlock() is called, ... the scheduling policy SHALL 
>>> decide ..." It doesn't say MAY, and it doesn't say "some undefined 
>>> time after the call."      
>>
>>
>> This does NOT require pthread_mutex_unlock() to cause the scheduler to
>> immediately pick a new runnable process.  It only says it's up the the
>> scheduling POLICY what to do.  The policy could be "let the unlocking
>> thread finish its timeslice then reschedule".
>>   
> 
> 
> This is obviously some very old ground.
> 
> http://groups.google.com/groups?threadm=etai7.108188%24B37.2381726%40news1.rdc1.bc.home.com 
> 
> 
> Kaz's post clearly interprets the POSIX spec differently from you. The 
> policy can decide *which of the waiting threads* gets the mutex, but the 
> releasing thread is totally out of the picture. For good or bad, the 
> current pthread_mutex_unlock() is not POSIX-compliant. Now then, if 
> we're forced to live with that, for efficiency's sake, that's OK, 
> assuming that valid workarounds exist, such as inserting a sched_yield() 
> after the unlock.
> 
> http://groups.google.com/group/comp.programming.threads/msg/16c01eac398a1139?hl=en& 
> 
> 
> But then we have to deal with you folks' bizarre notion that 
> sched_yield() can legitimately be a no-op, which also defies the POSIX 
> spec. Again, in SUSv3 "The /sched_yield/() function shall force the 
> running thread to relinquish the processor until it again becomes the 
> head of its thread list. It takes no arguments." There is no language 

How many times have we been over this? What do you think the "head of
its thread list" might mean?

> here saying "sched_yield *may* do nothing at all." There are of course 

There is language saying SCHED_OTHER is arbitrary, including how the
thread list is implemented and how a task might become on the head of
it.

They obviously don't need to redefine exactly what sched_yield may do
under each scheduling policy, do they?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
