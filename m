Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318922AbSIITJ4>; Mon, 9 Sep 2002 15:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSIITJ4>; Mon, 9 Sep 2002 15:09:56 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:31716 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318922AbSIITJy>; Mon, 9 Sep 2002 15:09:54 -0400
Date: Mon, 9 Sep 2002 21:37:42 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.33.0209091151200.14841-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209092120310.1096-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Linus Torvalds wrote:

> I agree with you, but that is only true for edge-triggered APIC
> interrupts, though - for level-triggered ones we will just re-take the
> interrupt when we unmask it again.
> 
> Which is kind of sad. Is there some fast way to read the status of a 
> level-trigger irq off the IO-APIC in case it is still pending, and to do 
> the mitigation even for level-triggered?

perhaps Remote IRR might help there?

> (Btw, if there is, that would also allow us to notice the "constantly
> screaming PCI interrupt" without help from the low-level isrs)

As an aside, i just had an idea for another way to improve interrupt 
handling latency. Instead of walking through all the isrs in the chain, 
we can have an isr flag wether it was the source of the irq, and if so we 
stop right there and not walk through the other isrs. Obviously taking 
into account that some devices are dumb and have no real way of 
determining.

	Zwane

-- 
function.linuxpower.ca


