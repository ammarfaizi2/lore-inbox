Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318784AbSIISfh>; Mon, 9 Sep 2002 14:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318786AbSIISfg>; Mon, 9 Sep 2002 14:35:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44945 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318784AbSIISfd>;
	Mon, 9 Sep 2002 14:35:33 -0400
Date: Mon, 9 Sep 2002 20:44:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@mwaikambo.name>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209090759010.1641-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209092041300.30411-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Linus Torvalds wrote:

> Remember: you'd be "improving latency" by taking several interrupts
> instead of taking just one. And usually, if the system is really under
> so much interrupt load that this would be noticeable, you want to try to
> _mitigate_ interrupts instead of adding new ones.

There's also the following effect that could generate additional
interrupts: the *same* IRQ source that is currently executing might
generate a (spurious but otherwise harmless) interrupt if we first ACK the
card then ACK the APIC and then do processing. Our current way of masking
interrupts in the IO-APIC at least leaves them pending there until the
handler's main work loop is finished and mitigates irqs.

	Ingo

