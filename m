Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWDRRmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWDRRmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWDRRmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:42:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:64733 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932149AbWDRRmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:42:52 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: irqbalance mandatory on SMP kernels?
Date: Tue, 18 Apr 2006 10:42:25 -0700
Organization: OSDL
Message-ID: <20060418104225.09cd05cd@localhost.localdomain>
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
	<4443A6D9.6040706@mbligh.org>
	<1145286094.16138.22.camel@mindpipe>
	<20060418163539.GB10933@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1145382146 12679 10.8.0.54 (18 Apr 2006 17:42:26 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 18 Apr 2006 17:42:26 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006 12:35:39 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Mon, Apr 17, 2006 at 11:01:33AM -0400, Lee Revell wrote:
> > > There is an in-kernel IRQ balancer. Redhat just choose to turn it
> > > off, and do it in userspace instead. You can re-enable it if you
> > > compile your own kernel.
> > 
> > Round-robin IRQ balancing is inefficient anyway.  You'd get better cache
> > utilization letting one CPU take them all.
> 
> IIRC, Van Jacobsen at his Linux.conf.au presentation made a pretty
> strong argument that irq balancing was never a good idea, describing
> them as a George Bush-like policy.  "Ooh, interrupts are hurting one
> CPU --- let's hurt them **all** and trash everybody's cache!"
> 
> Which brings up an interesting question --- why do we have an IRQ
> balancer in the kernel at all?  Maybe the scheduler's load balancer
> should take this into account so that processes that have the
> misfortune of getting assigned to the wrong CPU don't get hurt too
> badly (or maybe if we have enough cores/CPU's we can afford to
> dedicate one or two CPU's to doing nothing but handling interrupts);
> but spreading IRQ's across all of the CPU's doesn't seem like it's
> ever the right answer.
> 
> 						- Ted

There are two problems.  First the scheduler probably doesn't account
for the reduced capacity of a CPU getting hammer with interrupts. Second,
it does make sense to balance different device's interrupts to different
CPU's. A longer term user mode IRQ balancer can make those decisions.

For the networking case, there is a real win if the application code runs
on the same CPU as the interrupt. Otherwise, you end up cache thrashing
control block structures and headers.
