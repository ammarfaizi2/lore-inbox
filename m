Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBBRta>; Fri, 2 Feb 2001 12:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129225AbRBBRtU>; Fri, 2 Feb 2001 12:49:20 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:12083 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129108AbRBBRtF>; Fri, 2 Feb 2001 12:49:05 -0500
Date: Fri, 2 Feb 2001 12:45:43 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Manfred <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: mpparse.c question
In-Reply-To: <Pine.GSO.3.96.1010202174717.28509O-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.32.0102021243440.1529-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2001, Maciej W. Rozycki wrote:

> > Can that happen, is that important?
> >
> > Silly question: Why can't we ignore all but the first pin? If we don't
> > enable the additional pins, we don't have to disable them during
> > disable_irq().
>
>  Possibly yes -- I haven't seen such a system.

it does exist, and the feature fixed a real bug. I dont remember which
system exactly :-|

> > Btw, is is correct that the isa irq's are always connected to the first
> > io apic? find_isa_irq_pin() doesn't handle that, and the caller just
> > access io apic 0.
>
> It appears it happens so for all systems checked so far.  The MPS does
> not seem to enforce this configuration, so we might relax this
> dependency for flexibility.  Note that not only find_isa_irq_pin()
> hardcodes this assumption -- setup_ExtINT_IRQ0_pin() does as well, for
> example.

(hm, dont we have an assert in there to catch ISA IRQs bound to the second
IO-APIC?) In any case, it would be a very surprising move if anyone added
a second IO-APIC for the sake of *ISA* devices. This would be truly
backwards.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
