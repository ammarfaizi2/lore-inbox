Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWGEID7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWGEID7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGEID7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:03:59 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:237 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932378AbWGEID5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:03:57 -0400
Message-ID: <44AB726B.8070602@bigpond.net.au>
Date: Wed, 05 Jul 2006 18:03:55 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <20060705063550.GA28004@elte.hu>
In-Reply-To: <20060705063550.GA28004@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 5 Jul 2006 08:03:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>> ===================================================================
>> --- MM-2.6.17-mm6.orig/kernel/mutex.c	2006-07-04 14:37:43.000000000 +1000
>> +++ MM-2.6.17-mm6/kernel/mutex.c	2006-07-04 14:38:12.000000000 +1000
>> @@ -51,6 +51,16 @@ __mutex_init(struct mutex *lock, const c
>>  
>>  EXPORT_SYMBOL(__mutex_init);
>>  
>> +static inline void inc_mutex_count(void)
>> +{
>> +	current->mutexes_held++;
>> +}
>> +
>> +static inline void dec_mutex_count(void)
>> +{
>> +	current->mutexes_held--;
>> +}
>> +
> 
> NACK! This whole patch is way too intrusive for such a relatively small 
> gain.
> 
> also, if something doesnt hold a mutex, it might still be unsafe to 
> background it! For example if it holds a semaphore. Or an rwsem. Or any 
> other kernel resource that has exclusion semantics.
> 
> so unless this patch gets _much_ less complex and much less intrusive, 
> we'll have to stay with SCHED_BATCH and nice +19.

This means being less strict but (as you imply) that may be not much 
better than nice +19.  I'll have a look at it.

Of course, a comprehensive (as opposed to RT only) priority inheritance 
mechanism would make the "safe/unsafe to background" problem go away and 
make this patch very simple.  Any plans in that direction?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
