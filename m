Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289282AbSA1RYo>; Mon, 28 Jan 2002 12:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289277AbSA1RYh>; Mon, 28 Jan 2002 12:24:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9685 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289281AbSA1RYY>;
	Mon, 28 Jan 2002 12:24:24 -0500
Date: Mon, 28 Jan 2002 20:21:56 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] yield speedup, 2.5.3-pre5
In-Reply-To: <Pine.LNX.4.21.0201281807530.4731-100000@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.33.0201282020440.13846-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jan 2002, Martin Josefsson wrote:

> > -	spin_unlock_irq(&rq->lock);
> > +	spin_unlock(&rq->lock);

> I'm not an spinlock expert but shouldn't you use spin_unlock_irq()
> when it was locked with spin_lock_irq() ?

normally yes, but in this case it's an optimization: schedule() will
disable interrupts within a few cycles, so there is no point in enabling
irqs for a short amount of time.

	Ingo

