Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbULKCWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbULKCWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 21:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbULKCWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 21:22:54 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5873 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261909AbULKCWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 21:22:52 -0500
Message-ID: <41BA59F6.5010309@mvista.com>
Date: Fri, 10 Dec 2004 18:22:46 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com> <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com> <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Fri, 10 Dec 2004, George Anzinger wrote:
> 
> 
>>>Well, softirqs should really be preemptible if you care about RT task
>>>latency.  Ingo's patches have had this for months.  Works great.  Maybe
>>>it's time to push it upstream.
>>
>>Yes, I understand, and soft_irq() does turn on interrupts...
>>I was thinking of something like:
>>
>>	while(softirq_pending()) {
>>		local_irq_enable();
>>		do_softirq();
>>		local_irq_disable();
>>	}
>>		<proceed to idle hlt...>
> 
> 
> But that's a deadlock and if you enable interrupts you race.

Again, I remind you we are in the idle task.  Nothing more important to do.  Or 
do you mean that softirq_pending() will NEVER return false?

The other question is: "Is useful work being done?"

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

