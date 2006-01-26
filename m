Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWAZBhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWAZBhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWAZBhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:37:43 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:56836 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1750701AbWAZBhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:37:42 -0500
Message-ID: <43D8268D.1070407@symas.com>
Date: Wed, 25 Jan 2006 17:31:57 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Robert Hancock <hancockr@shaw.ca>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP	slow)
References: <20060124225919.GC12566@suse.de>	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>	 <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com>	 <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com>	 <43D814E1.7030600@shaw.ca>  <43D81C8D.5000106@symas.com> <1138237456.3087.93.camel@mindpipe>
In-Reply-To: <1138237456.3087.93.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2006-01-25 at 16:49 -0800, Howard Chu wrote:
>   
>> Basic "fairness" isn't the issue. Fairness is concerned with which of 
>> *multiple waiting threads* gets the mutex, and that is certainly 
>> irrelevant here. The issue is that the releasing thread should not be
>> a candidate.
>>
>>     
>
> You seem to be making 2 controversial assertions:
>
> 1. pthread_mutex_unlock must cause an immediate reschedule if other
> threads are blocked on the mutex, and 
> 2. if the unlocking thread immediately tries to relock the mutex,
> another thread must get it first
>
> I disagree with #1, which makes #2 irrelevant.  It would lead to
> obviously incorrect behavior, pthread_mutex_unlock would no longer be an
> RT safe operation for example.
>   

Actually no, I see that #1 is unnecessary, and already acknowledged as such
http://groups.google.com/group/fa.linux.kernel/msg/89da66017d53d496

But #2 still holds.

> Also consider a SCHED_FIFO policy - static priorities and the scheduler
> always runs the highest priority runnable thread - under your
> interpretation of POSIX a high priority thread unlocking a mutex would
> require the scheduler to run a lower priority thread which violates
> SCHED_FIFO semantics

See the Mutex Initialization Scheduling Attributes section which 
specifically addresses priority inversion:
http://www.opengroup.org/onlinepubs/000095399/xrat/xsh_chap02.html#tag_03_02_09

If point #2 were not true, then there would be no need to bother with 
any of that. Instead that text ends with "it is important that 
IEEE Std 1003.1-2001 provide these interfaces for those cases in which 
it is necessary."

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

