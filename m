Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbVCDWSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVCDWSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbVCDWRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:17:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:45561 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263055AbVCDU6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:58:44 -0500
Message-ID: <4228CBFB.3000602@mvista.com>
Date: Fri, 04 Mar 2005 12:58:35 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
References: <1109869828.2908.18.camel@mindpipe>	 <20050303164520.0c0900df.akpm@osdl.org> <1109899148.3630.5.camel@mindpipe>	 <42283857.9050007@mvista.com> <1109968985.6710.16.camel@mindpipe>
In-Reply-To: <1109968985.6710.16.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2005-03-04 at 02:28 -0800, George Anzinger wrote:
> 
>>Lee Revell wrote:
>>
>>>On Thu, 2005-03-03 at 16:45 -0800, Andrew Morton wrote:
>>>
>>>
>>>>If efi_enabled is true and efi_set_rtc_mmss(xtime.tv_sec) returns zero, the
>>>>new code will run set_rtc_mmss(xtime.tv_sec) whereas the old code won't.
>>>
>>>
>>>Argh, I should know better then to send patches before having coffee.
>>>
>>>Here's a new patch.  Still ugly, but might be a worthwhile cleanup.
>>
>>Lets ask the obvious question: Why isn't this update hung on a timer?  It seems 
>>silly to check this 6000 times per update.  I am sure we can sync a timer to the 
>>same degree we do timer interrupts, so there _must_ be some other reason.  Right?
>>
> 
> 
> Thanks George, I knew there was an obvious question here, I just didn't
> know what it was ;-).
> 
> The thing that brought this code to my attention is that with PREEMPT_RT
> this happens to be the longest non-preemptible code path in the kernel.
> On my 1.3 Ghz machine set_rtc_mmss takes about 50 usecs, combined with
> the rest of timer irq we end up disabling preemption for about 90 usecs.
> Unfortunately I don't have the trace anymore.
> 
> Anyway the upshot is if we hung this off a timer it looks like we would
> improve the worst case latency with PREEMPT_RT by almost 50%.  Unless
> there is some reason it has to be done synchronously of course.

Well, it does have to be done at the right WRT the second, but I suspect we can 
hit that as well with a timer as it is hit now.  Also, if we are _really_ off 
the mark, this can be defered till the next second.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

