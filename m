Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131616AbRCSVCo>; Mon, 19 Mar 2001 16:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131617AbRCSVCe>; Mon, 19 Mar 2001 16:02:34 -0500
Received: from nrg.org ([216.101.165.106]:18468 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131616AbRCSVC0>;
	Mon, 19 Mar 2001 16:02:26 -0500
Date: Mon, 19 Mar 2001 13:01:42 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <20010317183408.A137@bug.ucw.cz>
Message-ID: <Pine.LNX.4.05.10103191249200.24441-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thanks for you comments.

On Sat, 17 Mar 2001, Pavel Machek wrote:
> > diff -Nur 2.4.2/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
> > --- 2.4.2/arch/i386/kernel/traps.c	Wed Mar 14 12:16:46 2001
> > +++ linux/arch/i386/kernel/traps.c	Wed Mar 14 12:22:45 2001
> > @@ -973,7 +973,7 @@
> >  	set_trap_gate(11,&segment_not_present);
> >  	set_trap_gate(12,&stack_segment);
> >  	set_trap_gate(13,&general_protection);
> > -	set_trap_gate(14,&page_fault);
> > +	set_intr_gate(14,&page_fault);
> >  	set_trap_gate(15,&spurious_interrupt_bug);
> >  	set_trap_gate(16,&coprocessor_error);
> >  	set_trap_gate(17,&alignment_check);
> 
> Are you sure about this piece? Add least add a comment, because it
> *looks* strange.

With a preemptible kernel, we need to enter the page fault handler with
interrupts disabled to protect the cr2 register.  The interrupt state is
restored immediately after cr2 has been saved.  Otherwise, an interrupt
could cause the faulting thread to be preempted, and the new thread
could also fault, clobbering the cr2 register for the preempted thread.
See the diff for linux/arch/i386/mm/fault.c.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

