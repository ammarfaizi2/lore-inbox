Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbULJVCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbULJVCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbULJVCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:02:49 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:43255 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261177AbULJVCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:02:10 -0500
Message-ID: <41BA0ECF.1060203@mvista.com>
Date: Fri, 10 Dec 2004 13:02:07 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: dipankar@in.ibm.com, ganzinger@mvista.com,
       Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>	 <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com> <1102711532.29919.35.camel@krustophenia.net>
In-Reply-To: <1102711532.29919.35.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2004-12-11 at 02:10 +0530, Dipankar Sarma wrote:
> 
>>On Fri, Dec 10, 2004 at 11:42:55AM -0800, George Anzinger wrote:
>>
>>>Dipankar Sarma wrote:
>>>
>>>>And yes, RCU processing in softirq context can re-raise the softirq.
>>>>AFAICS, it is perfectly normal.
>>>
>>>My assumption was that, this being the idle task, RCU would be more than 
>>>happy to finish all its pending tasks.
>>
>>We try to avoid really long running softirqs (RCU tasklet in this case)
>>for better scheduling latency. A long running rcu tasklet during
>>an idle cpu may delay running of an RT process that becomes runnable
>>during the rcu tasklet.
>>
> 
> 
> Well, softirqs should really be preemptible if you care about RT task
> latency.  Ingo's patches have had this for months.  Works great.  Maybe
> it's time to push it upstream.

Yes, I understand, and soft_irq() does turn on interrupts...
I was thinking of something like:

	while(softirq_pending()) {
		local_irq_enable();
		do_softirq();
		local_irq_disable();
	}
	
	<proceed to idle hlt...>
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

