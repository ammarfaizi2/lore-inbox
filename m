Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270684AbUJVEX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270684AbUJVEX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270899AbUJVEUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 00:20:24 -0400
Received: from mail.timesys.com ([65.117.135.102]:44703 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S270930AbUJUUU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:20:26 -0400
Message-ID: <41781984.5090602@timesys.com>
Date: Thu, 21 Oct 2004 16:18:12 -0400
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
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com> <4177E89A.1090100@timesys.com> <20041021173302.GA26318@yoda.timesys> <4177FB4F.9030202@timesys.com> <20041021184742.GB26530@yoda.timesys>
In-Reply-To: <20041021184742.GB26530@yoda.timesys>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2004 20:15:22.0406 (UTC) FILETIME=[B1889C60:01C4B7AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Wood wrote:

>On Thu, Oct 21, 2004 at 02:09:19PM -0400, john cooper wrote:
>
>>That's true for the case where the current priority is
>>somewhere else handy (likely) and we don't need to traverse
>>the list for other reasons such as allowing/disallowing
>>recursive acquisition of a mutex by a given task.
>>
>
>How would maintaining priority order make it faster to check for
>recursive usage?  
>
It wouldn't. My point was an exhaustive traversal may be
needed for other reasons with an insertion sort being
near free.

Yet considering the cost to maintain these lists in priority
order with multiple spinlock acquisition sequences due to how
the aggregate data structure must be traversed/ordered,
I haven't yet convinced myself either way.

>On uniprocessor, one may wish to turn rwlocks into recursive non-rw
>mutexes, where recursion checking would use a single owner field.
>
It isn't obvious to me how this would address the case of a
task holding a reader lock on mx-A then blocking on mx-B.
Another task attempting to acquire a reader lock on mx-A would
block rather than immediately acquiring the lock.

-john


-- 
john.cooper@timesys.com

