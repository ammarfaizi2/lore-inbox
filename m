Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263020AbTC1PuF>; Fri, 28 Mar 2003 10:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263023AbTC1PuF>; Fri, 28 Mar 2003 10:50:05 -0500
Received: from pop.gmx.de ([213.165.65.60]:836 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263020AbTC1PuD>;
	Fri, 28 Mar 2003 10:50:03 -0500
Message-Id: <5.2.0.9.2.20030328170241.019947a0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 28 Mar 2003 17:05:53 +0100
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.66-mm1
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>,
       Ed Tomlinson <tomlins@cam.org>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.44.0303281619530.9943-100000@localhost.localdom
 ain>
References: <Pine.LNX.4.50.0303280942420.2884-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:25 PM 3/28/2003 +0100, Ingo Molnar wrote:

>On Fri, 28 Mar 2003, Zwane Mwaikambo wrote:
>
> > Hmm i think i may have his this one but i never posted due to being
> > unable to reproduce it on a vanilla kernel or the same kernel afterwards
> > (which was hacked so i won't vouch for it's cleanliness). I think
> > preempt might have bitten him in a bad place (mine is also
> > CONFIG_PREEMPT), is it possible that when we did the task_rq_unlock we
> > got preempted and when we got back we used the local variable
> > requeue_waker which was set before dropping the lock, and therefore
> > might not be valid anymore due to scheduler decisions done after
> > dropping the runqueue lock?
>
>yes, this one was my only suspect, but it should really never cause any
>problems. We might change sleep_avg during the wakeup, and carry the
>requeue_waker flag over a preemptible window, but the requeueing itself
>re-takes the runqueue lock, and does not take anything for granted. The
>flag could very well be random as well, and the code should still be
>correct - there's no requirement to recalculate the priority every time we
>change sleep_avg. (in fact we at times intentionally keep those values
>detached.)

In my 66-twiddle tree, I moved that under the lock out of pure paranoia.  I 
can try to see if printing under hefty (very) load will still trigger the 
occasional explosion.

         -Mike 

