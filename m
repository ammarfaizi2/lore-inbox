Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbTEGR3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264167AbTEGR3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:29:19 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:55441 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264164AbTEGR1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:27:54 -0400
Date: Wed, 7 May 2003 19:40:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507174027.GD19324@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com> <20030507164901.GB19324@wohnheim.fh-wedel.de> <Pine.LNX.4.50.0305071009050.2208-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.50.0305071009050.2208-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 10:18:29 -0700, Davide Libenzi wrote:
> On Wed, 7 May 2003, [iso-8859-1] Jörn Engel wrote:
> 
> > It also matters if people writing applications for embedded systems
> > have a fetish for many threads. 1000 threads, each eating 8k memory
> > for pure existance (no actual work done yet), do put some memory
> > pressure on small machines. Yes, it would be possible to educate those
> > people, but changing kernel code is more fun and less work.
> 
> I'm afraid I do not agree with both your sentences. Changing a *working
> kernel* code is definitely not much fun and not really less work if your
> target is the per-cpu kernel stack. You'll completely lose kernel
> preemption and this is really bad since many paths inside the kernel are
> easily preemptable. The design and the code of the kernel will become more
> complex (and slow) and even people that are correctly programming it are
> going to pay the price. No thanks, I'd say screw you thread maniacs ...

I'm not sure if I got you wrong, or vice versa. Either way, some
definitions first.
Process Stack == the traditional per-process kernel stack
Interrupt Stack == a dedicated per-CPU stack for interrupts only
CPU Stack == all kernel data on a per-CPU stack

Not for anything would I want a CPU Stack. At first thought, this is
impossible, but in reality it is just ugly beyond anything I could
bear.

An Interrupt Stack is a very good thing. I know PPC machines with 125
Interrupt lines (3 for cascading) that could theoretically all happen
at once. That alone demands for a stack size well above 8k and having
this per process is just a bad design. But that is another issue.

The real Process Stack without the interrupt overhead should not need
to be bigger than 4k. It currently is for all platforms I know about,
s390 has even 16k. This is the point of my regular allyesconfig
compilations and postings.

Do you still disagree? Then I must have misread your mail.

Jörn

-- 
Do not stop an army on its way home.
-- Sun Tzu
