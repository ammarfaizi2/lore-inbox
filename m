Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276708AbRKHTFi>; Thu, 8 Nov 2001 14:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277533AbRKHTF2>; Thu, 8 Nov 2001 14:05:28 -0500
Received: from [208.129.208.52] ([208.129.208.52]:25606 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S276708AbRKHTFK>;
	Thu, 8 Nov 2001 14:05:10 -0500
Date: Thu, 8 Nov 2001 11:13:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <Pine.LNX.4.33.0111082028430.20248-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0111081056490.1501-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Ingo Molnar wrote:

>
> On Thu, 8 Nov 2001, Davide Libenzi wrote:
>
> > It sets the time ( in jiffies ) at which the process won't have any
> > more scheduling advantage.
>
> (sorry, it indeed makes sense, since sched_jtime is on the order of
> jiffies.)
>
> > > and your patch adds a scheduling advantage to processes with more cache
> > > footprint, which is the completely opposite of what we want.
> >
> > It is exactly what we want indeed :
>
> if this is what is done by your patch, then we do not want to do this.
> My patch does not give an advantage of CPU-intensive processes over that
> of eg. 'vi'.

If A & B are CPU hog processes and E is the editor ( low level keventd )
you do want to avoid priority inversion between A and B when E kicks in.
Really IO bound tasks accumulates dynamic priority inside the recalc loop
and this is sufficent to win over this kind of "advantage" given to CPU
hog tasks.
My approach make also more "expensive" the preemption goodness to move
tasks between CPUs.
I'll take a closer look at your patch anyway.


> Perhaps i'm misreading your patch, it's full of branches that

"full of braches" == 2 if + 1 conditional-assign

> does not make the meaning very clear, cpu_jtime and sched_jtime are not
> explained. Is sched_jtime the timestamp of the last schedule of this
> process? And is cpu_jtime the number of jiffies spent on this CPU?

sched_jtime = last schedule time in jiffies
cpu_jtime   = wall time after which the task will have 0 dynamic priority increase

> Is cpu_jtime cleared if we switch to another CPU?

It's missing of the published patch.
The one that i'm testing has that + a lower dynamic priority increase :

weight += (p->cpu_jtime - jiffies) >> 1;

I'm just testing results about this.




- Davide


