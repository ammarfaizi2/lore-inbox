Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTDVVrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTDVVrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:47:24 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57106 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263871AbTDVVrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:47:23 -0400
Date: Tue, 22 Apr 2003 17:54:33 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: kpfleming@cox.net, arjanv@redhat.com
Subject: Re: irq balancing; kernel vs. userspace
Message-ID: <Pine.LNX.3.96.1030422173857.31749A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---------- Forwarded message ----------
Subject: Re: irq balancing; kernel vs. userspace
From: "Kevin P. Fleming" <kpfleming@cox.net>
Date: Sun, 20 Apr 2003 11:37:00 -0700
To: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> On Sun, 2003-04-20 at 15:23, Sean Neakums wrote:
> 
>>I thought I'd play with the userspace IRQ-balancer, but booting with
>>noirqbalance seems not to not balance.  Possibly I misunderstand how
>>this all fits together.
> 
> 
> this looks like you haven't started the userspace daemon (yet)

I thought the same thing reading his original message, then I looked 
closer. He booted using "noirqbalance", did not start the userspace 
balancer, and yet his IRQs are still being balanced.

---------- Forwarded message ----------
Subject: Re: irq balancing; kernel vs. userspace
From: Arjan van de Ven <arjanv@redhat.com>
Date: 20 Apr 2003 21:10:18 +0200
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-kernel@vger.kernel.org

On Sun, 2003-04-20 at 20:37, Kevin P. Fleming wrote:

> I thought the same thing reading his original message, then I looked 
> closer. He booted using "noirqbalance", did not start the userspace 
> balancer, and yet his IRQs are still being balanced.

if you don't do a thing, pIII cpu based machines will balance by
themselves while pIV cpu based machines will redirect everything to CPU
0. 

It would seem that there might be four commonly desirable modes of
operation:
 1 - All IRQ on CPU0
 2 - Spread IRQ between all processors evenly
 3 - Bind ints to CPUs to get about the same int count per CPU
 4 - Fancy other stuff controlled by user app

Now (1) is what you get if you disable apic, Alan Cox recommends this on
the smp list from time to time, and in most cases it works fine. Mode (2)
is what happens on Pentium-III unless you prevent it. It has more cache
overhead for some loads, but it's preferabe to trying to explain anything
else to certain managers. Note the total lack of a smiley on that
statement.

Now if that user program (4) could give me (2), and maybe even (1) with
apic enabled for the really odd load and testing, I suspect that (3) is
pretty much going to be included.

Think we could support a few other modes in the user tool and have the
kernel default to either (1) or whatever the apic wants to do? And how
does this map on non-Intel hardware?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


