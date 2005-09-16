Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbVIPICi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbVIPICi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbVIPICi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:02:38 -0400
Received: from [210.76.114.20] ([210.76.114.20]:18861 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1161064AbVIPICh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:02:37 -0400
Message-ID: <432A7C0F.8050903@ccoss.com.cn>
Date: Fri, 16 Sep 2005 16:02:23 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Can we release vma that include code when one process
 is running?
References: <432919C3.7060708@ccoss.com.cn> <43296D1D.4000407@yahoo.com.au>
In-Reply-To: <43296D1D.4000407@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sorry, I perhaps didn't said clearly.

As I knwon, if we remove vma from vma tree of task, the SIGSEGV must be got!
but I am not removed them , I just unmapped them. and the SIGSEGV occurs 
some times,
not alway.

I doublt on it.

Any clearly idea?

many thanks.

> liyu@WAN wrote:
>
>>    It seem that code in other place jump here to enter kernel. this 
>> is in a anonymous
>> code area.
>>    At first time, I think this SIGSEGV will trigger by anonymous code 
>> that is swapped,
>> but I wrote one specical condition check to filte out this sort of 
>> code, IOW, I do
>> not swap out it. but I still get SIGSEGV.
>>
>>    May be, we can not be release the vma that include code? or, Is 
>> there have some errors
>> in my words for page fault?
>>
>
> That's right, you cannot release the VMA if the application still
> expects to use memory in that area. The page fault handler will
> see that no VMA exists in that region and raise a SIGSEGV.
>
> See arch/i386/mm/fault.c:do_page_fault
>
>
> Nick
>

