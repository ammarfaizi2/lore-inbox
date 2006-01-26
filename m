Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWAZU2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWAZU2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWAZU2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:28:23 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:6153 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932388AbWAZU2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:28:22 -0500
Message-ID: <43D930C6.40201@symas.com>
Date: Thu, 26 Jan 2006 12:27:50 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: davids@webmaster.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
>> The point of this discussion is that the POSIX spec says one thing and
>> you guys say another; one way or another that should be resolved. The
>> 2.6 kernel behavior is a noticable departure from previous releases. The
>> 2.4/LinuxThreads guys believed their implementation was correct. If you
>> believe the 2.6 implementation is correct, then you should get the spec
>> amended or state up front that the "P" in "NPTL" doesn't really mean
>> anything.
>>     
>
> 	There is disagreement over what the POSIX specification says. You have
> already seen three arguments against your interpretation, any one of which
> is, IMO, sufficient to demolish it.
>   

> 	First, there's the as-if issue. You cannot write a program that can print
> "non-compliant" with the behavior you claim is non-compliant that is
> guaranteed not to do so by the standard because there is no way to know that
> another thread is blocked on the mutex (except for PI mutexes).
>   

The exception here demolishes this argument, IMO. Moreover, if the 
unlocker was a lower priority thread and there are higher priority 
threads blocked on the mutex, you really want the higher priority thread 
to run.

> 	Second, there's the plain langauge of the standard. It says "If X is so at
> time T, then Y". This does not require Y to happen at time T. It is X
> happening at time T that requires Y, but the time for Y is not specified.
>
> 	If a law says, for example, "if there are two or more bids with the same
> price lower than all other bids at the close of bidding, the first such bid
> to be received shall be accepted". The phrase "at the close of bidding"
> refers to the time the rule is deteremined to apply to the situation, not
> the time at which the decision as to which bid to accept is made.
>   

The time at which the decision takes effect is immaterial; the point is 
that the decision can only be made from the set of options available at 
time T.

Per your analogy, if a new bid comes in at time T+1, it can't have any 
effect on which of the bids shall be accepted.

> 	Third, there's the ambiguity of the standard. It says the "sceduling
> policy" shall decide, not that the scheduler shall decide. If the policy is
> to make a conditional or delayed decision, that is still perfectly valid
> policy. "Whichever thread requests it first" is a valid scheduler policy.

I am not debating what the policy can decide. Merely the set of choices 
from which it may decide.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

