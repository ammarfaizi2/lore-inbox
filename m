Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286756AbSAFBlq>; Sat, 5 Jan 2002 20:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSAFBlh>; Sat, 5 Jan 2002 20:41:37 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34312 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286756AbSAFBle>; Sat, 5 Jan 2002 20:41:34 -0500
Date: Sat, 5 Jan 2002 17:45:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201051722540.24370-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0201051740220.1607-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Linus Torvalds wrote:

>
> On Sun, 6 Jan 2002, Ingo Molnar wrote:
> >
> > (if Davide's post gave you the impression that my patch doesnt do per-CPU
> > queues then i'd like to point out that it does so. Per-CPU runqueues are a
> > must for good performance on 8-way boxes and bigger. It's just the actual
> > implementation of the 'per CPU queue' that is O(1).)
>
> Ahh, ok. No worries then.
>
> At that point I don't think O(1) matters all that much, but it certainly
> won't hurt. UNLESS it causes bad choices to be made. Which we can only
> guess at right now.

You're the men :)
Ok, this stops all the talks Ingo.
Can you send me a link, there're different things to be fixed IMHO.
The load estimator can easily use the current dyn_prio/time_slice by
simplyfing things a _lot_
I would suggest a lower number of queues, 32 is way more than necessary.
The rt code _must_ be better, it can be easily done by a smartest wakeup.
There's no need to acquire the whole lock set, at least w/out a checkpoint
solution ( look at BMQS ) that prevents multiple failing lookups inside
the RT queue.




- Davide


