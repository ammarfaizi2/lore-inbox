Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287508AbSAPUtj>; Wed, 16 Jan 2002 15:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287513AbSAPUt3>; Wed, 16 Jan 2002 15:49:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51653 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287508AbSAPUtU>;
	Wed, 16 Jan 2002 15:49:20 -0500
Date: Wed, 16 Jan 2002 23:46:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] I3 sched tweaks... 
In-Reply-To: <E16QnOx-0003vt-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0201162343290.18971-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jan 2002, Rusty Russell wrote:

> > > 4) scheduler_tick needs no args (p is always equal to current).
> >
> > i have not taken this part. We have 'current' calculated in
> > update_process_times(), so why not pass it along to the scheduler_tick()
> > function?
>
> Because it's redundant.  It's *always* p == current (and the code
> assumes this!), but I had to grep the callers to find out.

we pass pointers across functions regularly, even if the pointer could be
calculated within the function. We do this in the timer code too. It's
slightly cheaper to pass an already existing (calculated) 'current'
pointer over to another function, instead of calculating it once more in
that function. This will be especially true once we make 'current' a tiny
bit more expensive (Alan's kernel stack coloring rewrite will do that i
think, it will be one more instruction to get 'current'.)

> Moreover, the function doesn't make *sense* if p != current...

yes - would it be perhaps cleaner then to name the variable 'this_task' or
something like that?

> > > 3) lock_task_rq returns the rq, rather than assigning it, for clarity.
> >
> > i've made it an inline function instead of a macro.
>
> I thought of that, but assumed you had a good reason for making it a
> macro in the first place...

no good reason, the macro started out being simple, but then grew in size
significantly, as the sophistication and correctness of the O(1) scheduler
improved ;-)

	Ingo

