Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbUKQAI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbUKQAI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUKQAGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:06:46 -0500
Received: from gizmo10bw.bigpond.com ([144.140.70.20]:32915 "HELO
	gizmo10bw.bigpond.com") by vger.kernel.org with SMTP
	id S262135AbUKPXso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:48:44 -0500
Message-ID: <419A91D6.60606@bigpond.net.au>
Date: Wed, 17 Nov 2004 10:48:38 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
References: <20041116113209.GA1890@elte.hu> <419A7D09.4080001@bigpond.net.au> <20041116232827.GA842@elte.hu>
In-Reply-To: <20041116232827.GA842@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>Couldn't this part of the problem have been solved by using an
>>atomic_t for nr_uninterruptible as for nr_iowait?  It would also
>>remove the need for migrate_nr_uninterruptible().
> 
> 
> maybe, but why? Atomic ops are still a tad slower than normal ops and
> every cycle counts in the wakeup path. Also, the solution is still not
> correct, because it does not take other migration paths into account, so

Oops.

> we could end up with a sleeping task showing up on another CPU just as
> well. The most robust solution is to simply not care about migration and
> to care about the total count only.

Yes and, with the new comment above its declaration, if anybody (in the 
future) wants to use the per cpu data they will be aware that they need 
to modify the code if they need it to be always accurate.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
