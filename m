Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318850AbSIIUEV>; Mon, 9 Sep 2002 16:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318851AbSIIUEV>; Mon, 9 Sep 2002 16:04:21 -0400
Received: from packet.digeo.com ([12.110.80.53]:33743 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318850AbSIIUEU>;
	Mon, 9 Sep 2002 16:04:20 -0400
Message-ID: <3D7CFFC2.283953@digeo.com>
Date: Mon, 09 Sep 2002 13:08:34 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Zwane Mwaikambo <zwane@mwaikambo.name>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
References: <Pine.LNX.4.44.0209092120310.1096-100000@linux-box.realnet.co.sz> <Pine.LNX.4.44.0209092122030.4648-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 20:08:50.0065 (UTC) FILETIME=[B65D6010:01C2583C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Mon, 9 Sep 2002, Zwane Mwaikambo wrote:
> 
> > As an aside, i just had an idea for another way to improve interrupt
> > handling latency. Instead of walking through all the isrs in the chain,
> > we can have an isr flag wether it was the source of the irq, and if so
> > we stop right there and not walk through the other isrs. Obviously
> > taking into account that some devices are dumb and have no real way of
> > determining.
> 
> this is something i have a 0.5 MB patch for that touches a few hundred
> drivers. I can dust it off if there's demand - it will break almost
> nothing because i've done the hard work of adding the default 'no work was
> done' bit to every driver's IRQ handler.
> 

Does that code re-order the chain dynamically?

(My laptop shares an interrupt between the cardbus controller
and the cardbus ethernet controller.  The ethernet controller
generates 1000 interrupts per second.  The cardbus controller
generates 2 interrupts per day.  yenta_interrupt is really, really
slow).
