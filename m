Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130183AbRCESQL>; Mon, 5 Mar 2001 13:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130186AbRCESPv>; Mon, 5 Mar 2001 13:15:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:24082 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130183AbRCESPr>; Mon, 5 Mar 2001 13:15:47 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Date: 5 Mar 2001 10:15:27 -0800
Organization: Transmeta Corporation
Message-ID: <980l3v$7ct$1@penguin.transmeta.com>
In-Reply-To: <20010303144856.A18389@ftsoj.fsmlabs.com> <19350127143809.22288@smtp.wanadoo.fr> <20010304230707.L2565@ftsoj.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010304230707.L2565@ftsoj.fsmlabs.com>,
Cort Dougan  <cort@fsmlabs.com> wrote:
>
>More generic in terms of using irq_desc[] and some similar structures I can
>see.  Making do_IRQ() and enable/disable use the same names and structures
>as x86 isn't sensible.  They're different ports, with different design
>philosophies.
>
>I don't believe that the plan is a common irq.c - lets stay away from that.

Most of arch/i386/kernel/irq.c should really be fairly generic, and the
fact is that a lot of the issues are a lot more subtle than most people
really end up realizing.  I got really tired of seeing the same old SMP
problems that had long since been fixed on x86 show up on other
architectures. 

So the plan is to have at least a framework for allowing other
architectures to use a common irq.c if they want to. Probably not force
it down peoples throats, because this is an area where the differences
can be _so_ large that it might not be worth it for everybody. But I
seriously doubt that PPC is all that different.

And I seriously doubt that PPC SMP irq handling has gotten _nearly_ the
amount of testing and hard work that the x86 counterpart has. Things
like support for CPU affinity, per-irq spinlocks, etc etc.

Now, I'm not saying that irq.c would necessarily work as-is. It probably
doesn't support all the things that other architectures might need (but
with three completely different irq controllers on just standard PCs
alone, I bet it supports most of it), and I know ia64 wants to extend it
to be more spread out over different CPU's, but most of the high-level
stuff probably _can_ and should be fairly common.

		Linus
