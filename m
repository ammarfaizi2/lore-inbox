Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293347AbSCOVtD>; Fri, 15 Mar 2002 16:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293352AbSCOVsx>; Fri, 15 Mar 2002 16:48:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14485 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S293347AbSCOVsi>;
	Fri, 15 Mar 2002 16:48:38 -0500
Date: Fri, 15 Mar 2002 21:42:33 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Joe Korty <joe.korty@ccur.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18 scheduler bugs
In-Reply-To: <E16lziH-0004ma-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203152138550.22550-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Mar 2002, Alan Cox wrote:

> > > moment work for them becomes available.  I see no reason why an idle cpu
> > > should be forced to remain idle until the next tick, nor why fixing that
> > > should be considered `broken'.
> > 
> > performance. IPIs are expensive.
> 
> On a PIII I can see this being the case, especially as they dont power
> save on hlt nowdays.

it's an option, and the default is to use the hlt instruction. The main
reason is to let Linux save power - and those who need that final
performance edge (and it's measurable), can enable it. HTL still uses less
power than the tight idle loop.

> [...] But on the Athlon the IPI isnt going down a little side channel
> between cpus.

but even in the Athlon case an IPI is still an IRQ entry, which will add
at least 200 cycles or more to the idle wakeup latency.

	Ingo

