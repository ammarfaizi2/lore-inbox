Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136683AbREGVyR>; Mon, 7 May 2001 17:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136684AbREGVyH>; Mon, 7 May 2001 17:54:07 -0400
Received: from nrg.org ([216.101.165.106]:11110 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S136683AbREGVyA>;
	Mon, 7 May 2001 17:54:00 -0400
Date: Mon, 7 May 2001 14:53:47 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Brian Gerst <bgerst@didntduck.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <3AF712D5.5D712E0F@didntduck.org>
Message-ID: <Pine.LNX.4.05.10105071442210.21199-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Brian Gerst wrote:
> Nigel Gamble wrote:
> > 
> > On Mon, 7 May 2001, Linus Torvalds wrote:
> > > On Mon, 7 May 2001, Brian Gerst wrote:
> > > > This patch will still cause the user process to seg fault: The error
> > > > code on the stack will not match the address in %cr2.
> > >
> > > You've convinced me. Good thinking. Let's do the irq thing.
> > 
> > I've actually seen user processes seg faulting because of this with the
> > fully preemptible kernel patch applied.  The fix we used in that patch
> > was to use an interrupt gate for the fault handler, then to simply
> > restore the interrupt state:
> 
> Keep in mind that regs->eflags could be from user space, and could have
> some undesirable flags set.  That's why I did a test/sti instead of

Good point.

> reloading eflags.  Plus my patch leaves interrupts disabled for the
> minimum time possible.

I'm not sure that it makes much difference, as interrupts are disabled
for such a short time anyway.  I'd prefer to put the test/sti in
do_page_fault(), and reduce the complexity needed in assembler routines
as much as possible, for maintainability reasons.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

