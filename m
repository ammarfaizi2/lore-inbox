Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbULKQwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbULKQwK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 11:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbULKQwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 11:52:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:12794 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261965AbULKQwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 11:52:05 -0500
Message-ID: <41BB25B2.90303@mvista.com>
Date: Sat, 11 Dec 2004 08:52:02 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com> <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com> <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com> <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com>
In-Reply-To: <41BB2108.70606@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Zwane Mwaikambo wrote:
> 
>> On Fri, 10 Dec 2004, George Anzinger wrote:
>>
>>  
>>
>>> That is ok.  Either we have interrupts off and no softirqs are 
>>> pending and we
>>> proceed to the "hlt" (where the interrupt will be taken), or softirqs 
>>> are
>>> pending, we turn interrupts on, do the softirq, turn interrupts off 
>>> and try
>>> again.  Unless some tasklet (RCU?) never "gives up" or we will exit 
>>> the while
>>> with interrupts off and move on to the "hlt".  Or did I miss something?
>>>   
>>
>>
>> But the point is that you cannot execute hlt with interrupts disabled.
>>  
>>
> The trick is the sti instruction: It enables interrupt processing after 
> the following instruction.
> 
> Thus
>    sti
>    hlt
> 
> cannot race - it atomically enables interrupts and waits.

Exactly :)

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

