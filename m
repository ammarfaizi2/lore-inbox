Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBINHz>; Fri, 9 Feb 2001 08:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBINHq>; Fri, 9 Feb 2001 08:07:46 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:36620 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129075AbRBINHc>;
	Fri, 9 Feb 2001 08:07:32 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Fri, 9 Feb 2001 14:04:33 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection o
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
        mingo@redhat.com
X-mailer: Pegasus Mail v3.40
Message-ID: <14FD47597566@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Feb 01 at 13:10, Maciej W. Rozycki wrote:
> On Fri, 9 Feb 2001, Petr Vandrovec wrote:
> 
> > Unfortunately both these ways needs intimate knowledge of how UP NMI
> > watchdog works in each kernel, and it is incompatible with other
> > perfctr uses. Probably I'll switch perfctr delivery to some real
> > maskable interrupt while VMware VM owns CPU - if it is possible.
> > Then interrupt should be still pending after VM does __sti().
> 
>  Why do you need to mask NMI at all? 

Because of you must provide some function which handles NMI, and as
you cannot switch IDT and CR3 atomically together, NMI handler has
to be on same address in both address spaces - at least temporary. 
And in addition NMI handler in VM would have to switch address spaces 
back, execute NMI handler, and return CPU/MMU back to previous state - 
which may be just in the middle of normal VM<->Linux transition, so 
this context switching cannot use any global variable, it must 
save complete CPU/MMU state on stack. And it must not use any spinlock.

If you have any idea how it can be done with NMI unmasked all the way
around...
                                    Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
