Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUG1V0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUG1V0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUG1VYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:24:15 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:26131 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S264097AbUG1VXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:23:23 -0400
Date: Wed, 28 Jul 2004 14:23:14 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, linux-kernel@vger.kernel.org,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>, Bill Huey <bhuey@lnxw.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040728212314.GB7167@nietzsche.lynx.com>
References: <20040727225040.GA4370@yoda.timesys> <20040728062722.GA15283@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728062722.GA15283@elte.hu>
User-Agent: Mutt/1.5.6+20040722i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:27:22AM +0200, Ingo Molnar wrote:
> this is an incorrect change, just grep for in_interrupt() in
> linux/drivers/ ...
> 
> I agree with the concept of using multiple threads for interrupts - i'll
> add that to the voluntary-preempt patch too. This is an essential
> feature to prioritize interrupts.

That way I picture the problem permits those threads to migration across
CPUs and therefore kill interrupt performance from cache thrashing. Do
you have a solution for that ? I like the way you're doing it now with
irqd() in that it's CPU-local, but as you know it's not priority sensitive.
 
> what do you think about making the i8259A's interrupt priorities
> configurable? (a'la rtirq patch) Does it make any sense, given how early
> we mask the source irq and ack the interrupt controller [hence giving
> all other interrupts a fair chance to arrive ASAP]?
> 
> Bernhard Kuhn's rtirq patch is for IO-APIC/APICs, but i think the
> latency issues could be equally well fixed by not keeping the local APIC
> un-ACK-ed during level triggered irqs, but doing the mask & ack thing.
> This will be slightly slower but should make them both redirectable and
> more symmetric and fair.

I think it's pretty complementary to what's going on, but it's also driven
by application demand, how it could possibly hook into the scheduler or
something else like that. There isn't a clear precedence for how to use
something like this potentially. LynxOS doesn't have priorities above
interrupt priorities, that mask interrupts somehow, but are folks that need
that kind of stuff and could certainly be added in a relatively trivial
manner.

My answer would be something like yes it's needed, but not now.

bill

