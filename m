Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWF2MZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWF2MZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932896AbWF2MZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:25:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14604 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932489AbWF2MZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:25:53 -0400
Date: Thu, 29 Jun 2006 13:25:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Milan Svoboda <msvoboda@ra.rockwell.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Deepak Saxena <dsaxena@plexity.net>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
Message-ID: <20060629122541.GB9709@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	Esben Nielsen <nielsen.esben@googlemail.com>,
	Milan Svoboda <msvoboda@ra.rockwell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Deepak Saxena <dsaxena@plexity.net>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
References: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com> <Pine.LNX.4.64.0606291334540.10401@localhost.localdomain> <Pine.LNX.4.58.0606290803190.25935@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0606290803190.25935@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 08:09:24AM -0400, Steven Rostedt wrote:
> 
> 
> On Thu, 29 Jun 2006, Esben Nielsen wrote:
> 
> >
> > On Thu, 29 Jun 2006, Milan Svoboda wrote:
> >
> >
> > It seems that dma_unmap_single() on arm contains
> >  	local_irq_save(flags);
> >
> >  	unmap_single(dev, dma_addr, size, dir);
> >
> >  	local_irq_restore(flags);
> >
> 
> Yeah I saw this too.
> 
> > I don't know the dma code on arm. It doesn't look like a per-cpu code but it
> > seems to me that it is not SMP safe and therefore not preempt-realtime
> > safe, either.
> >
> > The hard thing is to figure out which datastructures exactly is protected
> > by those irq-disable and put in a spinlock..
> >
> > I added Deepak Saxena on CC as he seems to be the last one who touched the
> > file.
> >
> 
> Well, the following patch may not be the best but I don't see it being any
> worse than what is already there.  I don't have any arm platforms or even
> an arm compiler, so I haven't even tested this patch with a compile.  But
> it should be at least a temporary fix.

Guys, look at what's in the latest -git from Linus.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
