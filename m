Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbULMFW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbULMFW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 00:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbULMFW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 00:22:28 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:50422 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262202AbULMFWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 00:22:23 -0500
Message-ID: <41BD2705.5080809@mvista.com>
Date: Sun, 12 Dec 2004 21:22:13 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41BA0ECF.1060203@mvista.com> <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com> <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <41BC771D.6020506@mvista.com> <41BCC8F8.3030102@colorfullife.com>
In-Reply-To: <41BCC8F8.3030102@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> George Anzinger wrote:
> 
>>
>> The "normal" idle loop just looks at the need_resched flag and goes 
>> right back to the hlt,
> 
> 
> That's the problem: If a the tasklet does a wakeup then the reschedule 
> is delayed until the next interrupt. 

Not so.  On the interrupt that runs the tasklet, on the way out via entry.S, the 
need_resched flag is checked and acted on.  Thus the task switch is done prio to 
getting back to the hlt.

> Testing need_resched and executing 
> hlt must be atomic, but it isn't - NMIs break the atomicity.

Actually this is not required, especially if preemption is turned on.

> Not a big deal, except if someone implements a tickless kernel. 

Well, it is not tickless, but VST that I am working on :).  The notion is to 
turn off the ticks when in idle and there are not time events in the list.

I think
> we can ignore it for now [or was the thread started by someone who 
> want's to disable the hardware timer when the system is really idle?]

Yep, me!  But still, I keep a timer around to exit, it is just way more than a 
tick later (depending on what the next entry in the time list needs).
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

