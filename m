Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWJFPu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWJFPu0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 11:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWJFPu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 11:50:26 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:4205 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751001AbWJFPuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 11:50:25 -0400
Date: Fri, 6 Oct 2006 17:50:21 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Message-ID: <20061006155021.GE14186@rhun.haifa.ibm.com>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> <m11wpl328i.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11wpl328i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 09:14:53AM -0600, Eric W. Biederman wrote:

> Muli Ben-Yehuda <muli@il.ibm.com> writes:
> 
> > My x366 no longer boots with 2.6.19-rc1. The boot either hangs in
> > uhci_hcd_init or dies with 'do_IRQ: cannot handle IRQ -1". Bisection
> > says this one is bad:
> 
> Ok.  So at least the second case is because some irq is being delivered
> to a cpu that was not expecting it.
> 
> The hang case is weird because the kernel does not get told about
> the irqs on your second ioapic.
> 
> When it gets the 'do_IRQ: cannot handle IRQ -1' how long
> has the system been in user space?  (It doesn't look like
> init got started but that is hard to tell, shutting off irqbalanced
> for testing purposes would be interesting)

In some cases we haven't made it to userspace at all. In other, we're
in the initrd.

> Seeing the failure case is really weird because this early in boot
> everything should be routed to cpu 0.
> 
> What happens if you boot with max_cpus=1?

Trying it now... woohoo, it boots all the way and stays up!

> The change the patch introduced was that we are now always
> pointing irqs towards individual cpus, and not accepting an irq
> if it comes into the wrong cpu.  
> 
> The only hypothesis I have so far is that there may be an issue
> with the x366 chipset ioapics that this patch reveals.
> 
> I would suspect a wider issue but in several months of testing
> this is the first bug report I have seen.

I'm trying to find out if other x366's are also seeing it.

> If simple tests don't reveal what is going on then we will
> have to instrument up that BUG and print out the per
> cpu vector to irq tables, the cpu number, and the vector
> the unexpected irq came in on.

I'm certainly game for any debugging you have in mind - this is my
main Calgary development machine so getting it booting is a pretty
high priority :-)

Cheers,
Muli
