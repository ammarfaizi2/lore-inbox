Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWFPVe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWFPVe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 17:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWFPVe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 17:34:58 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:9992 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750903AbWFPVe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 17:34:57 -0400
Message-ID: <449323F6.6050301@de.ibm.com>
Date: Fri, 16 Jun 2006 23:34:46 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: statistics infrastructure (in -mm tree) review
References: <20060613232131.GA30196@kroah.com> <20060613234739.GA30534@kroah.com> <p73slm8qqe4.fsf@verdi.suse.de> <44909292.2080005@de.ibm.com> <20060616204047.GB9445@kroah.com>
In-Reply-To: <20060616204047.GB9445@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jun 15, 2006 at 12:49:54AM +0200, Martin Peschke wrote:
>> Andi Kleen wrote:
>>> Greg KH <greg@kroah.com> writes:
>>>>> + * exploiters don't update several statistics of the same entity in one 
>>>>> go.
>>>>> + */
>>>>> +static inline void statistic_add(struct statistic *stat, int i,
>>>>> +				 s64 value, u64 incr)
>>>>> +{
>>>>> +	unsigned long flags;
>>>>> +	local_irq_save(flags);
>>>>> +	if (stat[i].state == STATISTIC_STATE_ON)
>>>>> +		stat[i].add(&stat[i], smp_processor_id(), value, incr);
>>>
>>> Indirect call in statistics hotpath?  You know how slow this is 
>>> on IA64 and even on other architectures it tends to disrupt 
>>> the pipeline.
>> Okay, let's try to improve it then. The options here are:
>>
>> a) Replace the indirect function call by a switch statement which directly
>>    calls the add function of the data processing mode chosen by user.
>>    (e.g. simple counter, histogram, utilisation indicator etc.).
>>
>>    No loss in functionality, slightly uglier code, acceptable 
>>    performance(?).
>>    This would be my choice.
> 
> Probably best.  Just don't make it an inline function :)

Andi, would this be fine with you?

Thanks, Martin

