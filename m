Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWHHQkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWHHQkB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWHHQkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:40:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13491 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964989AbWHHQkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:40:00 -0400
Message-ID: <44D8BE71.4010807@engr.sgi.com>
Date: Tue, 08 Aug 2006 09:40:17 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
References: <44CE57EF.2090409@sgi.com> <44CF6433.50108@in.ibm.com> <44CFCCE4.7060702@sgi.com> <44D7AF34.10301@sgi.com> <44D81F89.3050009@in.ibm.com>
In-Reply-To: <44D81F89.3050009@in.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Jay Lan wrote:
>> Jay Lan wrote:
>>
>> [snip]
>>
>>>>
>>>>
>>>>> +    /* Each process gets a minimum of a half tick cpu time */
>>>>> +    if ((stats->ac_utime == 0) && (stats->ac_stime == 0)) {
>>>>> +        stats->ac_stime = USEC_PER_TICK/2;
>>>>> +    }
>>>>> +
>>>>
>>>>
>>>>
>>>> This is confusing. Half tick does not make any sense from the
>>>> scheduler view point (or am I missing something?), so why
>>>> return half a tick to the user.
>>>
>>>
>>> It must be inherited from old code dated back to Cray UNICOS.
>>> I do not know if bad thing can happen if both utime and stime
>>> are less than 1 usec...  I guess not. But i agree that
>>> half a tick does not make sense. To play safe, we can change
>>> it to 1 usec if both utime and stime are sub microsecond.
>>> What do you think?
>>
>> Hi Balbir,
>>
>> I figured this out. The tsk->stime (and utime as well) are
>> charged by 1 tick (or cputime) from the timer interrupt handler
>> through update_process_times->account_{user,system}_time.
>>
>> The clock resolution is a tick. Any short process less than
>> 1 tick will the counter being 0. It can be from 0 to 0.99999...
>> tick. A half tick is the average value.
>>
>
> But the scheduling happens in the granularity of a tick, so the
> minimum each task gets is a tick.
>
>> I think it makes more sense to assign a half tick than assign
>> 1 usec to the stime. What do you think? Certainly the code need
>> better explanation.
>>
>
> Can't we leave these values as zero in case both stime and utime are
> zero.

Yes, i will leave them as zero in this case.

Regards,
 - jay

>
>
>> Regards,
>>  - jay
>>
>>
>> [snip]
>
>

