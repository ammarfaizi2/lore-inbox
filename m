Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283001AbRLQWzH>; Mon, 17 Dec 2001 17:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282993AbRLQWy5>; Mon, 17 Dec 2001 17:54:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23309 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283001AbRLQWys>; Mon, 17 Dec 2001 17:54:48 -0500
Date: Mon, 17 Dec 2001 14:53:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.40.0112151934410.1014-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0112171449520.1854-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, Davide Libenzi wrote:

> On Sat, 15 Dec 2001, Linus Torvalds wrote:
>
> > I just don't find it very interesting. The scheduler is about 100 lines
> > out of however-many-million (3.8 at least count), and doesn't even impact
> > most normal performace very much.
>
> Linus, sharing queue and lock between CPUs for a "thing" highly frequency
> ( schedule()s + wakeup()s ) accessed like the scheduler it's quite ugly
> and it's not that much funny. And it's not only performance wise, it's
> more design wise.

"Design wise" is highly overrated.

Simplicity is _much_ more important, if something commonly is only done a
few hundred times a second. Locking overhead is basically zero for that
case.

> > We'll clearly do per-CPU runqueues or something some day. And that worries
> > me not one whit, compared to thigns like VM and block device layer ;)
>
> Why not 2.5.x ?

Maybe. But read the rest of the sentence. There are issues that are about
a million times more important.

> Moving to 4, 8, 16 CPUs the run queue load, that would be thought insane
> for UP systems, starts to matter.

4 cpu's are "high end" today. We can probably point to tens of thousands
of UP machines for each 4-way out there. The ratio gets even worse for 8,
and 16 CPU's is basically a rounding error.

You have to prioritize. Scheduling overhead is way down the list.

		Linus

