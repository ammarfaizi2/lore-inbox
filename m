Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWHJABY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWHJABY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWHJABY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:01:24 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:39322 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751332AbWHJABX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:01:23 -0400
Date: Wed, 9 Aug 2006 20:00:51 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <nielsen.esben@gogglemail.com>
cc: Bill Huey <billh@gnuppy.monkey.org>, Robert Crocombe <rcrocomb@gmail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re:
 Problems with 2.6.17-rt8
In-Reply-To: <Pine.LNX.4.64.0608090050500.23474@frodo.shire>
Message-ID: <Pine.LNX.4.58.0608091958540.16850@gandalf.stny.rr.com>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
 <1154541079.25723.8.camel@localhost.localdomain>
 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
 <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org>
 <20060808030524.GA20530@gnuppy.monkey.org> <Pine.LNX.4.64.0608090050500.23474@frodo.shire>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2006, Esben Nielsen wrote:

>
> I had a long discussion with Paul McKenney about this. I opposed the patch
> from a latency point of view: Suddenly a high-priority RT task could be
> made into releasing a task_struct. It would be better for latencies to
> defer it to a low priority task.
>
> The conclusion we ended up with was that it is not a job for the RCU
> system, but it ought to be deferred to some other low priority task to
> free the task_struct.
>

Fair enough.  But by removing the rcu code to do the dirty work, we ended
up breaking the code completely.  So although the rcu work is not the
right method, it needs to be there until we have a better solution.
This solution is better than what is there right now in -rt8, and that is,
-rt8 is broken without it!

-- Steve

