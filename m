Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288191AbSAHRhB>; Tue, 8 Jan 2002 12:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288192AbSAHRgv>; Tue, 8 Jan 2002 12:36:51 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:15374 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S288191AbSAHRgd>;
	Tue, 8 Jan 2002 12:36:33 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Chris Wedgwood <cw@f00f.org>
Date: Tue, 8 Jan 2002 18:35:35 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: "APIC error on CPUx" - what does this mean?
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        macro@ds2.pg.gda.pl
X-mailer: Pegasus Mail v3.40
Message-ID: <E542D8F46A1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Jan 02 at 1:30, Chris Wedgwood wrote:
> On Tue, Jan 08, 2002 at 01:12:04PM +0100, Maciej W. Rozycki wrote:
> 
>     A possible reason is the 8259A in the chipset deasserts its INT
>     output late enough for the Athlon CPU's local APIC to register
>     another ExtINTA interrupt sometimes, possibly under specific
>     circumstances.
> 
> Actully... we could potentially measure this... after an interrupt it
> serviced (or before, or both) we could store the interrupt source
> globally and the cycle counter... when a suprrious interrupt is
> received check the last interrupt and how long ago it was and then
> start looking for a pattern...

I instrumented kernel at home, and when spurious interrupt happens,
stack trace almost always says that spurious interrupt happened
during HLT in default_idle (if I disable ACPI...), ISR is always zero,
and IRR contains 0x00 (before parport driver is loaded) or 0x80
(after parport driver is loaded (without IRQ support)). Few times
stack trace was different, and pointed to ide__sti() in ide_do_request,
but it was < 5% of occurences. 

As spurious IRQ happens during HLT, and IRR is clear at the time
we are going to ack IRQ, it looks like real spurious IRQ (caused by
noise?). Or delay between spurious one and real IRQ is really long. 
I'll try some of your suggestions today night.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
