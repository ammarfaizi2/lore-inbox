Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbRBIVCr>; Fri, 9 Feb 2001 16:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbRBIVCg>; Fri, 9 Feb 2001 16:02:36 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:38318 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129041AbRBIVCX>; Fri, 9 Feb 2001 16:02:23 -0500
Date: Fri, 9 Feb 2001 21:59:24 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection o
In-Reply-To: <14FD47597566@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1010209215041.13007D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Petr Vandrovec wrote:

> >  Why do you need to mask NMI at all? 
> 
> Because of you must provide some function which handles NMI, and as
> you cannot switch IDT and CR3 atomically together, NMI handler has
> to be on same address in both address spaces - at least temporary. 

 Can't it be?

> And in addition NMI handler in VM would have to switch address spaces 
> back, execute NMI handler, and return CPU/MMU back to previous state - 
> which may be just in the middle of normal VM<->Linux transition, so 
> this context switching cannot use any global variable, it must 
> save complete CPU/MMU state on stack. And it must not use any spinlock.

 Do you need to pass NMIs to VM at all?  NMIs as defined by the PC/AT
architecture are delivered as a result of memory parity errors or ISA
IOCHK errors.  Is that functionality really needed in VM?

> If you have any idea how it can be done with NMI unmasked all the way
> around...

 It depends on the application -- you may avoid problems by careful coding
and a nested NMI will never happen -- the CPU masks the NMI line
internally, from accepting an NMI till a subsequent iret. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
