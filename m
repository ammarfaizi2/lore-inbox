Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVEUCAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVEUCAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 22:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVEUCAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 22:00:25 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:28611 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261636AbVEUCAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 22:00:17 -0400
Message-ID: <428E962F.40600@acm.org>
Date: Fri, 20 May 2005 21:00:15 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: george@mvista.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes for IPMI use of timers
References: <428D2181.2080106@acm.org>  <428E8B68.6040909@mvista.com> <1116639005.14582.7.camel@mindpipe>
In-Reply-To: <1116639005.14582.7.camel@mindpipe>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Fri, 2005-05-20 at 18:14 -0700, George Anzinger wrote:
>  
>
>>> 		/* We already have irqsave on, so no need for it
>>>                    here. */
>>>-		read_lock(&xtime_lock);
>>>+		read_lock_irqsave(&xtime_lock, flags);
>>>      
>>>
>>I rather hope this fails to compile :)  xtime_lock is a sequence lock in the 2.6 
>>kernel.
>>
>>    
>>
>>> 		jiffies_now = jiffies;
>>> 		smi_info->si_timer.expires = jiffies_now;
>>> 		smi_info->si_timer.sub_expires = get_arch_cycles(jiffies_now);
>>>+		read_unlock_irqrestore(&xtime_lock, flags);
>>>      
>>>
>
>The old code clearly has an unbalanced lock/unlock, maybe it's
>sufficient to just fix that?
>  
>
Yes, probably just best to fix that up.  When high-res timers make it 
into the kernel, this can be fixed up, this is left over from the 2.4 
high-res timers.

-Corey
