Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSIIPCG>; Mon, 9 Sep 2002 11:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSIIPCF>; Mon, 9 Sep 2002 11:02:05 -0400
Received: from [63.209.4.196] ([63.209.4.196]:5138 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S317354AbSIIPB6>;
	Mon, 9 Sep 2002 11:01:58 -0400
Date: Mon, 9 Sep 2002 08:06:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@mwaikambo.name>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209091204070.15029-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209090759010.1641-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Ingo Molnar wrote:
> 
> On Sun, 8 Sep 2002, Linus Torvalds wrote:
> 
> > As far as I can tell, the only time when this might be an advantage is
> > an SMP machine with multiple devices sharing an extremely busy irq line.
> > Then the per-isr in-progress bit allows multiple CPU's to actively
> > handle several of the devices at the same time.
> > 
> > Or is there some other case where this is helpful?
> 
> it could also improve latency of a faster interrupt source that shares its
> irq line with a slow (but still frequent) handler. (such as SCSI or ne2k.)  

Well, it migth also _deprove_ that latency, as taking another interrupt is 
a lot more expensive than just walking the list of ISR's on the existing 
irq chain.

Particularly on a P4, taking an interrupt is quite expensive.

Remember: you'd be "improving latency" by taking several interrupts 
instead of taking just one. And usually, if the system is really under so 
much interrupt load that this would be noticeable, you want to try to 
_mitigate_ interrupts instead of adding new ones. 

I think. I'd like to point out that I just have a gut feel for this, so
I'm definitely not trying to say that I absolutely hate the idea and that
it will never happen. But the thing worries me a bit, and I really would 
prefer to have some quantifiable reasons for or against it.

In other words, I kind of understand your concerns, but I've got concerns 
of my own. But nobody will argue against numbers..

		Linus

