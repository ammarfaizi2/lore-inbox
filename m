Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311756AbSCTQRe>; Wed, 20 Mar 2002 11:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311745AbSCTQRZ>; Wed, 20 Mar 2002 11:17:25 -0500
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:11417 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S311756AbSCTQRQ>; Wed, 20 Mar 2002 11:17:16 -0500
Date: Wed, 20 Mar 2002 17:19:50 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.GSO.3.96.1020320142929.13532B-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0203201701480.9609-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Maciej W. Rozycki wrote:

> Why do you need to fiddle with the 8259A's IMR at all?  What's wrong with
> cli?

Only Phoenix developers can answer this.

In principle not even cli is necessary because, all interrupts are
automatically disabled upon entry into SMM mode. The bios does mask
the PIC, though, probably because it is possible for SMI handlers to
reenable interrupts while in SMM mode. AFAIK, our BIOS does _not_
include such handlers, but Phoenix seems to have put in that code
so that it is possible to write them if desired. It appears that the
Phoenix programmers overlooked the fact that the PIC might be in poll
mode when they try to read the IMR. Our Bios people are trying to
contact Phoenix about this.

>  The current code is correct, written to 8259A's specs.  I used original
> ones ("8259A Programmable Interrupt Controller (8259A/8259A-2)", Intel's
> order number 231468) as a reference to assure whatever happens is
> well-specified and not an implementation-specific quirk.  The SMI code is
> broken for not being transparent (or for existing at all, but that's
> another matter).

Can you tell me how the SMI code could correctly transparently reestablish
the 8259A state in the situation we are facing?
I can't think of an algorithm that would put the PIC in exactly the same
state that it was in before the SMI, not to talk about the time elapsed
during SMI, which easily comes up to a few 100 us on our system.

>  That's not the normal mode -- that's the through-8259A mode workaround
> designed originally for i82357 (ISP) based EISA systems.  The chip
> predates the APIC and does not make IRQ 0 from its internal 8254 core
> available externally.  I am actually very surprised to see new systems not
> connecting IRQ 0 to the I/O APIC.

Oops - I will contact our hardware guys about this.

Thanks for your comments,
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





