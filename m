Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVBXCnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVBXCnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVBXCnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:43:17 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:9909 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261767AbVBXClZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:41:25 -0500
Message-ID: <421D3ED1.9040409@yahoo.com.au>
Date: Thu, 24 Feb 2005 13:41:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
References: <1109182061.16201.6.camel@krustophenia.net>	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>	 <1109187381.3174.5.camel@krustophenia.net>	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>	 <1109190614.3126.1.camel@krustophenia.net>	 <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com>	 <421D1171.7070506@yahoo.com.au> <1109207024.4516.6.camel@krustophenia.net>	 <421D2DEE.8070209@yahoo.com.au> <1109211897.4831.2.camel@krustophenia.net>
In-Reply-To: <1109211897.4831.2.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2005-02-24 at 12:29 +1100, Nick Piggin wrote:
> 
>>Lee Revell wrote:
>>
>>>IIRC last time I really tested this a few months ago, the worst case
>>>latency on that machine was about 150us.  Currently its 422us from the
>>>same clear_page_range code path.
>>>
>>
>>Well it should be pretty trivial to add a break in there.
>>I don't think it can get into 2.6.11 at this point though,
>>so we'll revisit this for 2.6.12 if the clear_page_range
>>optimisations don't get anywhere.
>>
> 
> 
> Agreed, it would be much better to optimize this away than just add a
> scheduling point.  It seems like we could do this lazily.
> 

Oh? What do you mean by lazy? IMO it is sort of implemented lazily now.
That is, we are too lazy to refcount page table pages in fastpaths, so
that pushes a lot of work to unmap time. Not necessarily a bad trade-off,
mind you. Just something I'm looking into.

