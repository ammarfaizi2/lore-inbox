Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317763AbSGVR7j>; Mon, 22 Jul 2002 13:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317764AbSGVR7j>; Mon, 22 Jul 2002 13:59:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33159 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317763AbSGVR7i>;
	Mon, 22 Jul 2002 13:59:38 -0400
Date: Mon, 22 Jul 2002 20:01:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
       <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <Pine.LNX.4.44.0207221004420.2504-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207221925410.17527-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Linus Torvalds wrote:

> I'd much rather keep the current "local_xxx" versions, since they
> clearly say that it's local to the CPU. Let's face it, people SHOULD NOT
> USE THESE!

okay, agreed.

> So I vote for
> 
> 	local_irq_save(flags)		- save and disable
> 	local_irq_restore(flags)	- restore
> 	local_irq_disable()		- disable
> 	local_irq_enable()		- enable

i've added this one as well:

	local_save_flags(flags)		- save

a fair number of places want (and need) to use __save_flags(flags)-type of
functionality, without the irq-disabling side-effect.

But also, a number of places now do:

	local_save_flags(flags);
	local_irq_disable();

which should be:

	local_irq_save(flags);

(these places will be simplified in an upcoming patch.)

The new __cli/__sti cleanup patch is at:

  http://redhat.com/~mingo/remove-irqlock-patches/cli-sti-cleanup-2.5.27-B2

compiles, boots & works just fine on x86 UP and SMP.

	Ingo

