Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270990AbUJUWWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270990AbUJUWWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270972AbUJUWSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:18:49 -0400
Received: from mail.timesys.com ([65.117.135.102]:39657 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S270998AbUJUWQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:16:26 -0400
Message-ID: <417834E4.7000506@timesys.com>
Date: Thu, 21 Oct 2004 18:15:00 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Wood <scott@timesys.com>
CC: "Eugeny S. Mints" <emints@ru.mvista.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com> <4177E89A.1090100@timesys.com> <20041021173302.GA26318@yoda.timesys> <4177FB4F.9030202@timesys.com> <20041021184742.GB26530@yoda.timesys> <41781984.5090602@timesys.com> <20041021211244.GA28290@yoda.timesys>
In-Reply-To: <20041021211244.GA28290@yoda.timesys>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2004 22:11:16.0734 (UTC) FILETIME=[E2A2D9E0:01C4B7BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Wood wrote:

>On Thu, Oct 21, 2004 at 04:18:12PM -0400, john cooper wrote:
>
>>Yet considering the cost to maintain these lists in priority
>>order with multiple spinlock acquisition sequences due to how
>>the aggregate data structure must be traversed/ordered,
>>I haven't yet convinced myself either way.
>>
>
>Another issue is that if you keep them in order, you have to fix the
>list whenever an owner of a listed mutex changes its priority.
>
Yes, but my concern was having to backoff in out-of-sequence
spinlock acquisition paths. Looking at it again if the canonical
lock acquisition sequence is a task's mutex-owned list then a
mutex's task-owned list, the nondeterministic backoff (if any)
gets pushed to the case of a waiter blocking on the lock.

>>It isn't obvious to me how this would address the case of a
>>task holding a reader lock on mx-A then blocking on mx-B.
>>Another task attempting to acquire a reader lock on mx-A would
>>block rather than immediately acquiring the lock.
>>
>
>Yes.  However, the contention case should not be optimized at the
>expense of the common case, which can be faster for non-rwlock
>implementations when PI is involved.  On SMP, you'd be introducing a
>bottleneck by taking away rwlocks, but on UP it's only an issue when
>you get preempted or block in a critical section.
>
My concern is removing what should be available reader
concurrency for the mutex in question. I can't assess
how un/common that may be over all application scenarios.

-john


-- 
john.cooper@timesys.com

