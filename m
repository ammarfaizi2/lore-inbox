Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLRTR0>; Mon, 18 Dec 2000 14:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129663AbQLRTRR>; Mon, 18 Dec 2000 14:17:17 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:48774 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130017AbQLRTRC>; Mon, 18 Dec 2000 14:17:02 -0500
Date: Mon, 18 Dec 2000 19:44:44 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu
Subject: Re: Startup IPI (was: Re: test13-pre3)
In-Reply-To: <1009FFDF1491@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1001218192414.4900A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Petr Vandrovec wrote:

> It is possible. But it is hard to track, as it works with serial console,
> and it is not possible to paint characters to VGA screen, as vgacon uses
> hardware panning instead of scrolling :-( And if it dies, shift-pageup
> apparently does not work... And filling whole 32KB with some char
> does not work, as it changes timing too much...

 Just disable the problematic printk()s for making tests (you may just
undefine APIC_DEBUG in include/asm-i386/apic.h) -- we already know what is
going to be printed here. ;-)

> No, I'll try. It occured with either AGP (Matrox G200/G400/G450) or
> PCI (S3, CL5434) VGA adapter. I did not tried real ISA VGA...

 Oops, I've forgotten there exist non-ISA display adapters. ;-)  Just try
if accessing one bus or another changes the behaviour. 

> Yes. I could understand if I had to place bigger udelay() after INIT IPI,
> as this can cause some specific PIII initialization and Intel says that
> there should not be any MESI traffic during this init (at least I understand

 Hmm, weird -- for integrated APICs an INIT IPI is about the same as
shutdown apart from the fact an NMI won't wake up a CPU (that might
actually be the local APIC not passing NMIs to the CPU in this case,
though). 

> it that way). But after startup IPI it should just start executing code...
> I tried to put 'wbinvd' here and there, but it did not make any change,
> only udelay() between startup IPI cmd and first printk() did.

 Hmm, a startup IPI is rather fast so the code just after issuing it may
somehow interact with the application's CPU trampoline.  But try to
disable CONFIG_X86_GOOD_APIC, yet (you may configure for classic Pentium,
for example), and see if that changes anything (it shouldn't, but who
knows...). 

> I have no idea. I know that board has VT82C694X (rev c4) host and PCI bridge,

 Just look at the board and search for an I/O APIC chip. ;-) 

> and VT82C686 (rev 22) ISA bridge. I tried to request documentation
> of 694X from VIA, but I did not heard from them. They have probably
> some secrets hidden in their hardware...

 They wan't to keep the competition from being bug-compatible, it would
seem...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
