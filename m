Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276359AbRJCPTN>; Wed, 3 Oct 2001 11:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276364AbRJCPTD>; Wed, 3 Oct 2001 11:19:03 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:61879 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S276359AbRJCPSw>;
	Wed, 3 Oct 2001 11:18:52 -0400
Date: Wed, 3 Oct 2001 11:16:33 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan van de Ven <arjanv@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, <netdev@oss.sgi.com>
Subject: Re: [patch] auto-limiting IRQ load take #2, irq-rewrite-2.4.11-F4
In-Reply-To: <Pine.LNX.4.33.0110031625330.7342-101000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110031114490.4833-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Your approach is still wrong. Please do not accept this patch.

cheers,
jamal

On Wed, 3 Oct 2001, Ingo Molnar wrote:

>
> the attached patch contains a cleaned up version of IRQ auto-mitigation.
>
> - i've removed the max_rate limit and have streamlined the impact of the
>   load-estimator on do_IRQ() to this piece of code:
>
>         desc->total_contexts++;
>         if (unlikely(in_interrupt()))
>                 goto mitigate_irqload;
>
>   i dont think we can get much cheaper than this. (We could perhaps avoid
>   the total_contexts counter by saving a 'snapshot' of the existing
>   kstat.irqs array of counters in every timer tick and comparing the
>   snapshot to the current kstat.irqs values. That looked pretty unclean
>   though.)
>
> - the per-cpu irq counting in -D9 was incorrect as it collapsed all irq
>   handlers into a single counter.
>
> - i've removed the net-polling hacks - they are unrelated to this problem.
>
> the patch is against 2.4.11-pre2. (the eepro100.c fixes from the -ac tree
> are already included in -pre2, i only included them in this patch to make
> patching & testing against 2.4.10 easier.).
>
> (i'd like to stress the point again that the goal of this approach is
> *not* to be nice. This is an airbag mechanizm, it can and will hurt
> performance. But my box does not lock up anymore.)
>
> 	Ingo
>

