Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWAZUrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWAZUrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWAZUrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:47:02 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:51355 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964881AbWAZUrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:47:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=oNxtBF6cqwYKpnNyIv7x9vDWatTxKaUqh1nKfqXN+bngggGR6ATtcxQEoC8FZAf3aXISuzBG4N62xSY0PWs/svfHbXJGGTMCs9BmrdgYmbipwfZ9UQByf1DvyvBaDNUZzcU5/wWHjoKT6OTATzyxWI2ySqfaedtj56V//pYarHg=  ;
Message-ID: <43D93542.9000809@yahoo.com.au>
Date: Fri, 27 Jan 2006 07:46:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: davids@webmaster.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com> <43D930C6.40201@symas.com>
In-Reply-To: <43D930C6.40201@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> David Schwartz wrote:
> 

> The time at which the decision takes effect is immaterial; the point is 
> that the decision can only be made from the set of options available at 
> time T.
> 
> Per your analogy, if a new bid comes in at time T+1, it can't have any 
> effect on which of the bids shall be accepted.
> 
>>     Third, there's the ambiguity of the standard. It says the "sceduling
>> policy" shall decide, not that the scheduler shall decide. If the 
>> policy is
>> to make a conditional or delayed decision, that is still perfectly valid
>> policy. "Whichever thread requests it first" is a valid scheduler policy.
> 
> 
> I am not debating what the policy can decide. Merely the set of choices 
> from which it may decide.
> 

OK, you believe that the mutex *must* be granted to a blocking thread
at the time of the unlock. I don't think this is unreasonable from the
wording (because it does not seem to be completely unambiguous english),
however think about this -

A realtime system with tasks A and B, A has an RT scheduling priority of
1, and B is 2. A and B are both runnable, so A is running. A takes a mutex
then sleeps, B runs and ends up blocked on the mutex. A wakes up and at
some point it drops the mutex and then tries to take it again.

What happens?

I haven't programmed realtime systems of any complexity, but I'd think it
would be undesirable if A were to block and allow B to run at this point.

Now this has nothing to do with PI or SCHED_OTHER, so behaviour is exactly
determined by our respective interpretations of what it means for "the
scheduling policy to decide which task gets the mutex".

What have I proven? Nothing ;) but perhaps my question could be answered
by someone who knows a lot more about RT systems than I.

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
