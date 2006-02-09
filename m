Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWBIOKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWBIOKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWBIOKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:10:37 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:39023 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030398AbWBIOKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:10:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Rb9vqpM8/0L5HM1J921tPwg+DM46uGp49GYVAUE1/UiHR6oyJY9J2JBk8E1jCkP6SzTq0QxO1HPVaRLOZ3FnDFuSapwPLCSVDLmCMi+Oyz4Kquo2+bEYM2ouNg1hcDBDl1jHolFasUKCyFBDKp0Plcb64LkmNcco8uIB+TeUm5M=  ;
Message-ID: <43EB4D5C.8030603@yahoo.com.au>
Date: Fri, 10 Feb 2006 01:10:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
References: <200602092339.49719.kernel@kolivas.org> <43EB43B9.5040001@yahoo.com.au> <200602100047.09722.kernel@kolivas.org>
In-Reply-To: <200602100047.09722.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 10 February 2006 00:29, Nick Piggin wrote:
> 
>>busy Con Kolivas wrote:
> 
> 
> busy? that's an interesting mua comment...
> 
> 

Oh I just added that.

>>- Looking a lot better from an impact-on-rest-of-vm code wise inspection.
> 
> 
> That's good to hear, thanks.
> 
> 
>>I got a couple of suggestions to make it even better.
>>
>>- I still have big reservations about it. For example the fact that if you
>>thrash memory and force everything to swap out, then exit your memory
>>hog, it won't do anything if you just happened to `cat bigfile > /dev/null`
>>
>>- Then, it has the potential to make *useful* swapping much less useful
>>(ie. it will page back in your unused programs and libraries, which will
>>kick out unmapped pagecache on desktop workloads).
>>
>>- It does not appear to necessarily solve the updatedb problem.
>>
>>- People complaining about their browser getting swapped out of their 1GB+
>>desktop systems due to a midnight cron run must be angering the VM gods.
>>I'd rather try to work out what to sacrifice in order to appease them
>>before sending another one up there to beat them into submission.
> 
> 
> I really don't want to go throwing out pagecache without some smart semantics 
> and then swap in random stuff that could be crap I agree. The answer to this 

Sure. It is not an easy problem space.

> is for the vm itself to have an ageing algorithm like the clockpro stuff 
> which does this in a smart way. It could certainly age away the updatedb 
> wrinkles and leave some free ram - which would help/be helped by prefetching.
> 
> I don't think I've ever said it fixes the updatedb debacle. Updatedb gets to 

I'm not sure that you ever did either, although I (and it seems at least
one other other in these recent threads) were perhaps under that impression
at one stage.

> rule another day, but that does not constitute every swap workload out there. 
> It helps my daily workloads, and as you might have missed, others have 
> reported demonstrable benefits (and not just the "it seems faster" type).
> 

Umm, yes I saw that. It is fairly plain that almost any VM change you could
possibly make that actually compiles is going to improve something.

I'm not denying any improvements. I'm pointing out that there are problems
too.

> 
>>Sorry to sound negative about it. 
> 
> 
> Well you're honest and that's worth respecting.
> 

Honesty shmonesty, I'm reviewing the thing :)

> 
>>Lucky for you nobody listens to me. 
> 
> 
> After some thought I've decided I ain't touching that one.
> 

Well at least you do.... Just to be sure, you did see my comments through
the code right?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
