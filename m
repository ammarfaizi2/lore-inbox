Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVAaW0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVAaW0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVAaW0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:26:35 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:43672 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261397AbVAaW0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:26:32 -0500
Message-ID: <41FEB136.5070706@tmr.com>
Date: Mon, 31 Jan 2005 17:29:10 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <871xc62bot.fsf@sulphur.joq.us><871xc62bot.fsf@sulphur.joq.us> <20050128084049.GA5004@elte.hu>
In-Reply-To: <20050128084049.GA5004@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Jack O'Quin <joq@io.com> wrote:
> 
> 
>>>i'm wondering, couldnt Jackd solve this whole issue completely in
>>>user-space, via a simple setuid-root wrapper app that does nothing else
>>>but validates whether the user is in the 'jackd' group and then keeps a
>>>pipe open to to the real jackd process which it forks off, deprivileges
>>>and exec()s? Then unprivileged jackd could request RT-priority changes
>>>via that pipe in a straightforward way. Jack normally gets installed as
>>>root/admin anyway, so it's not like this couldnt be done.
>>
>>Perhaps.
>>
>>Until recently, that didn't work because of the longstanding rlimits
>>bug in mlockall().  For scheduling only, it might be possible.
>>
>>Of course, this violates your requirement that the user not be able to
>>lock up the CPU for DoS.  The jackd watchdog is not perfect.
> 
> 
> there is a legitimate fear that if it's made "too easy" to acquire some
> sort of SCHED_FIFO priority, that an "arm's race" would begin between
> desktop apps, each trying to set themselves to SCHED_FIFO (or SCHED_ISO)
> and advising users to 'raise the limit if they see delays' - just to get
> snappier than the rest.
> 
> thus after a couple of years we'd end up with lots of desktop apps
> running as SCHED_FIFO, and latency would go down the drain again.
> 
> (yeah, this feels like going back to the drawing board.)

The problem hasn't changed in a few decades, neither has the urge of 
developers to make their app look good at the expense of the rest of the 
system. Been there and done that myself.

"Back when" we had no good tools except to raise priority and drop 
timeslice if a process blocked for i/o and vice-versa if it used the 
whole timeslice. The amzing thing is that it worked reasonably well as 
long as no one was there who knew how to cook the books the scheduler 
used. And the user could hold off interrupts for up to 16ms, just to 
make it worse.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
