Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267168AbUGWGp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbUGWGp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 02:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267198AbUGWGp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 02:45:29 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:57719 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267168AbUGWGp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 02:45:27 -0400
Message-ID: <4100B403.6080402@yahoo.com.au>
Date: Fri, 23 Jul 2004 16:45:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption
 Patch
References: <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721154428.GA24374@elte.hu> <40FF48F9.1020004@yahoo.com.au> <20040722070743.GA7553@elte.hu> <40FF9CD1.7050705@yahoo.com.au> <20040722162357.GB23972@elte.hu> <41003BA3.70806@yahoo.com.au> <20040723054735.GA14108@elte.hu>
In-Reply-To: <20040723054735.GA14108@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>this doesnt work either: once we've committed ourselves to do an
>>>'immediate' softirq processing pass we are risking latencies. We cannot
>>>preempt the idle task while it's processing softirqs the same way we can
>>>do the lock-break if they are always deferred.
>>>
>>
>>It is a preempt off region no matter where it is run. I don't see how
>>moving it to ksoftirqd can shorten that time any further.
> 
> 
> look at my latest patches to see how it's done. We can preempt softirq
> handlers via lock-break methods. The same method doesnt work in the idle

Are you referring to this patch?
http://people.redhat.com/mingo/voluntary-preempt/defer-softirqs-2.6.8-rc2-A2

Surely something similar could easily be done for irq context softirq
processing with a patch like my earlier one? And it would prevent spilling
to ksoftirq when a RT thread isn't waiting to run.

> thread. With this method i've reduced worst-case softirq latencies from
> ~2-4 msecs to 100-200 usecs on a 2GHz x86 box.
> 

Nice numbers.
