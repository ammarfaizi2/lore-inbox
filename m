Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUCVXfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUCVXfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:35:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1923 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261582AbUCVXfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:35:10 -0500
Date: Mon, 22 Mar 2004 18:38:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Robert_Hentosh@Dell.com,
       fleury@cs.auc.dk, Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.44.0403222354280.1902-100000@poirot.grange>
Message-ID: <Pine.LNX.4.53.0403221822230.24444@chaos>
References: <Pine.LNX.4.44.0403222354280.1902-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004, Guennadi Liakhovetski wrote:

> On Mon, 22 Mar 2004, Richard B. Johnson wrote:
>
> > On Mon, 22 Mar 2004, Guennadi Liakhovetski wrote:
> >
> > >            CPU0 (2nd shot)
> > >   0:      36557  37638 +1081 XT-PIC  timer
> > >   1:         59     65    +6 XT-PIC  i8042
> > >   2:          0      0       XT-PIC  cascade
> > >   5:          0      0       XT-PIC  VIA686A
> > >   8:          3      3       XT-PIC  rtc
> > >   9:          0      0       XT-PIC  acpi, uhci_hcd, uhci_hcd
> > >  10:          0      0       XT-PIC  eth0
> > >  12:         84     84       XT-PIC  i8042
> > >  14:       1910   1918    +8 XT-PIC  ide0
> > >  15:          1      1       XT-PIC  ide1
> > > NMI:         18     18
> > > LOC:      36460  37541 +1081
> > > ERR:         36     57   +21
> >
> > First, you are using the 8259A (XT-PIC). This means you have
> > IO-APIC turned off (or it doesn't exist).
>
> I know. I never said there was one. I said, that the local APIC is used
> for timer interupts - at least, this is how I interpret
>
> Using local APIC timer interrupts.
> calibrating APIC timer ...
>
> Am I missing anything trivial?
>

Yes. The interrupt status, above, clearly shows that the XT-PIC is
being used for timer interrupts. The local APIC timer is being used
instead of the PIT (Programmable Interval Timer at port 0x40,
channel 0).  The IO-APIC contains, several timers as well as a
programmable interrupt controller and router, etc. You are not
using its interrupt controller, but you are using its timer,
best I can see.

> > > ide0 + i8042 (keyboard) = 14, whereas errors increased by 21. So, if you
> > > are right, than Alan's wrong (or my understanding of his statement), and
> > > those spurious interrupts occur not only after real ones, or, one real
> > > interrupt can produce several spurious ones.
> >
> > Neither. They are not related. As previously stated, a spurious
> > interrupt occurs when the CPU INT line becomes active, but no
> > interrupt controller caused it to happen. It's just that simple.
>
> Yes, I saw this your explanation. Thanks again. But, I am not getting
> those errors with local APIC disabled. That's why I thought "local APIC ->
> timer -> spurious interrupts." Maybe I am wrong. But I also can't see how
> enabling the lapic can cause, e.g., power supply glitches to become
> visible. I would be happy and grateful to hear an explanation.
>

Once you enable some other path to the CPUs INT line, you can
get some other condition. These paths may pick up different
noise or their logic returns may have different ground-bounce
conditions. Sometimes you can fix glitches like this by:

(1)	Putting a metal post and a screw in every mounting
	hole in your motherboard.... OR.

(2)	Using only 1 or 2 metal posts to mount your motherboard
	and using plastic insulators for the other holes.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


