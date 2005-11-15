Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbVKOUHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVKOUHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVKOUHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:07:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11261 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S965023AbVKOUHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:07:30 -0500
Date: Tue, 15 Nov 2005 12:07:18 -0800 (PST)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: john cooper <john.cooper@timesys.com>,
       Luca Falavigna <dktrkranz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Softlockup detected with linux-2.6.14-rt6
In-Reply-To: <20051115200010.GA13802@elte.hu>
Message-ID: <Pine.LNX.4.64.0511151206000.29907@dhcp153.mvista.com>
References: <4378B48E.6010006@gmail.com> <20051115153257.GA9727@elte.hu>
 <437A14FB.8050206@timesys.com> <20051115200010.GA13802@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wasn't this thread related to a real lock up? I thought Luca said that 
the stack trace came from his printer.

I thought it might be related to the __delay troubles ..

Daniel

On Tue, 15 Nov 2005, Ingo Molnar wrote:

>
> * john cooper <john.cooper@timesys.com> wrote:
>
>> Ingo Molnar wrote:
>>> * Luca Falavigna <dktrkranz@gmail.com> wrote:
>>>> I found this softlockup bug involving arts daemon using a
>>>> linux-2.6.14-rt6 kernel (with "Complete Preemption" and "Detect Soft
>>>> Lockups" compiled in).
>>>> This bug does not happen everytime: I was able to reproduce it only
>>>> three times in a week. [...]
>>>
>>>
>>> does this happen with -rt13 too? I have fixed a softlockup
>>> false-positive in it.
>>
>> Just curious what the cause of the false positive was?
>
> the fix is below - we didnt reset the 'light' counter in the else
> branch.
>
> 	Ingo
>
> Index: linux/kernel/softlockup.c
> ===================================================================
> --- linux.orig/kernel/softlockup.c
> +++ linux/kernel/softlockup.c
> @@ -90,7 +90,8 @@ void softlockup_tick(void)
>
> 		wake_up_process(per_cpu(watchdog_task, this_cpu));
> 		per_cpu(timeout, this_cpu) = jiffies + msecs_to_jiffies(1000);
> -	}
> +	} else
> +		touch_light_softlockup_watchdog();
>
> 	if (per_cpu(print_timestamp, this_cpu) == timestamp)
> 		return;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
