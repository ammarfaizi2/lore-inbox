Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWHYH6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWHYH6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWHYH6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:58:14 -0400
Received: from mga05.intel.com ([192.55.52.89]:3258 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751262AbWHYH6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:58:14 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,167,1154934000"; 
   d="scan'208"; a="121029643:sNHT37022503"
Message-ID: <44EEAD8D.6010801@linux.intel.com>
Date: Fri, 25 Aug 2006 09:58:05 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org,
       len.brown@intel.com, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] maximum latency tracking infrastructure
References: <1156441295.3014.75.camel@laptopd505.fenrus.org> <200608241408.03853.jbarnes@virtuousgeek.org> <44EE1801.3060805@linux.intel.com> <44EE829C.10606@yahoo.com.au>
In-Reply-To: <44EE829C.10606@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Arjan van de Ven wrote:
>> Jesse Barnes wrote:
>>
>>> On Thursday, August 24, 2006 10:41 am, Arjan van de Ven wrote:
>>>
>>>> The reason for adding this infrastructure is that power management in
>>>> the idle loop needs to make a tradeoff between latency and power
>>>> savings (deeper power save modes have a longer latency to running code
>>>> again).
>>>
>>>
>>> What if a processor was already in a sleep state when a call to 
>>> set_acceptable_latency() latency occurs? 
>>
>>
>> there's nothing sane that can be done in that case; any wake up 
>> already will cause the unwanted latency!
>> A premature wakeup is only making it happen *now*, but now is as 
>> inconvenient a time as any...
>> (in fact it may be a worst case time scenario, say, an audio 
>> interrupt...)
> 
> Surely you would call set_acceptable_latency() *before* running such
> operation that requires the given latency? And that set_acceptable_latency
> would block the caller until all CPUs are set to wake within this latency.
> 
> That would be the API semantics I would expect, anyway.

but that means it blocks, and thus can't be used in irq context

(the usage model I imagine happens most is a set_acceptable_latency() which can block during device init,
with either no or a very course limit, and a modify_acceptable_latency(), which cannot block, from irq context or
device open)
