Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVG1K32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVG1K32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVG1K32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:29:28 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:31059 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261401AbVG1K3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:29:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SNpEkiA3jrGvMBEhArLSeEPjRoWeIRy3XFRzcmXapDFl6CPqjVLsv7uYraDkkKhLXPb/AyIJYKZ/ps/ERwVz8mqolHgwHKy5EQ6T7TIsgHm2h2beMbIy76uPd6WoXTOmwQNB9YypOvRBXtZcVbRXXSp8QdGu648ih+HLxaXDVIw=  ;
Message-ID: <42E8B380.1070003@yahoo.com.au>
Date: Thu, 28 Jul 2005 20:29:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
References: <10613.1122538148@kao2.melbourne.sgi.com> <42E897FD.6060506@yahoo.com.au> <20050728083544.GA22740@elte.hu> <42E89BE6.6040304@yahoo.com.au> <20050728091638.GA25846@elte.hu> <42E8A688.7070802@yahoo.com.au> <20050728100429.GA27030@elte.hu>
In-Reply-To: <20050728100429.GA27030@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:

[...]

> 	prefetch_area(void *first_addr, void *last_addr)
> 
> (or as addr,len)
> 

Yep. We have prefetch_range.


>>
>>Yeah, then a specific field _within_ next->mm or thread_info may want 
>>to be fetched. In short, I don't see any argument why we shouldn't 
>>call the function prefetch_task().
> 
> 
> it's a fundamental thing: we _dont_ want to push generic code into 
> architectures, and there's nothing per-arch about next->mm.
> 

Yeah, I mean within mm, ie. prefetch(&mm->random_cacheline).

>>Secondly, I don't really like your prefetch(kernel_stack()) function 
>>because it doesn't really give architectures enough control over 
>>exactly what cachelines they get in memory.
> 
> 
> my point is, it comes down to concrete examples, it may or may not make 
> sense to do things per-arch.
> 

I thought the concrete example there was ia64's switch_stack,
which looks to be over half a K... oh I see you've asked Ken
whether this will be sufficient. OK in that case let's wait and
see.

> 
>>[...] I see nothing wrong with having a prefetch_task() call.  
>>(Although I agree things like thread_info->flags and next->mm can be 
>>done in generic code).
> 
> 
> great that we now agree wrt. thread_info and next->mm. My remaining 
> point is, once we prefetch ->thread_info, ->mm and the kernel stack, 
> nothing else significant remains! (It's still very much possible that 
> something needs to be prefetched per-arch, but i'd like to see a robust 
> case be made for it, instead of your global 'it might happen' argument.)
> 

Well to be clear, I think we have always agreed, except that I
thought it 'did happen' with the ia64 example. If it turns out
that your prefetch is good enough then I will have been mistaken.

Actually to be even clearer, I was never really arguing about what
to prefetch or whether to prefetch from arch code or not. Just that
the name, if any, should be prefetch_task as opposed to
prefetch_stack :)

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
