Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbTAUNnu>; Tue, 21 Jan 2003 08:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267068AbTAUNnu>; Tue, 21 Jan 2003 08:43:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59789 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267065AbTAUNns>; Tue, 21 Jan 2003 08:43:48 -0500
Date: Tue, 21 Jan 2003 08:54:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: AnonimoVeneziano <voloterreno@tin.it>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
In-Reply-To: <3E2D4D15.4080001@tin.it>
Message-ID: <Pine.LNX.3.95.1030121084206.20505A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, AnonimoVeneziano wrote:

> David D. Hagood wrote:
> 
> > AnonimoVeneziano wrote:
> >
> >> What does it mean this message?
> >>
> >> Of what problem is the signal?
> >
> >
> > It is most likely a hardware problem.
> >
> > When a device signals an interrupt, it asserts its interrupt pin. When 
> > the CPU asks the interrupt controller what device generated the 
> > interrupt, the interrupt controller tells the CPU.
> >
> > But if the interrupt line "goes away" before the CPU fetches the 
> > vector, then the interrupt controller doesn't "know" what IRQ caused 
> > the interrupt. So the interrupt controller sends an IRQ #7 to the CPU, 
> > along with setting a bit in the interrupt controller's status register 
> > that says in effect "this isn't really an IRQ 7, but I have no idea 
> > what it was. Sorry."
> >
> > If you have ISA cards in your system, remove them from the system and 
> > re-insert them (with the power off, of course) - they may have 
> > developed some oxidization on the card edge connector. You can also 
> > try scrubbing the card edge with some plain paper (a US dollar bill 
> > works even better, but you might not have access to dead presidents in 
> > Italy.)
> >
> > Ditto with PCI cards - remove them, polish the connector, then 
> > re-insert them.
> >
> >
> >
> Thank you very much all of you for the answers.So, this should be an 
> harmless message, I've tried to attach something to the parallel port , 
> or disable it in the bios, but doesn't work, the only way to remove this 
> problem is to load the parport_pc module, this message with the module 
> loaded doesn't appear. I've tried with other bioses , and the problem 
> appears on all of them. If I compile in the kernel UP-IO-ACPI the 
> problem disappears, but I have a lot of other problems, because my 
> system is quite young and the support for IO-APIC is not added yet for 
> me.If I use only UP-APIC this problem appears, and if don't use apic 
> this disappears.
> 
> I'll try to remove some HW and retry. Someone had this problem without 
> APIC enabled?
> 
> Thank you
> 
> Bye
> 
> Marcello

If it bothers you, just comment out the message in the kernel.
A "catch-all" for interrupt glitches is the IRQ7. It can be
caused by real problems (unlikely if the rest of the machine
works), or the occasional glitch where some hardware didn't
assert its IRQ line long enough for it to be recognized. This
is a hardware glitch and they happen. They started to happen
more often once level interrupts, necessary for PCI interrupt
sharing, started to become common. Level interrupts, as opposed
to edge interrupts are not latched. If a glitch occurs on a
edge interrupt, the event is latched. If enabled, the interrupt
is handled just like a "real" one and nobody is the wiser. With
level interrupts, the CPU can become "confused" with a glitch
if, by the time the CPU starts to handle the interrupt, it no-
longer exists. The result is that the CPU executes the IRQ7
handler, the "catch-all", which is also used for the printer.

Bottom line, it's normal. It's being handled. You probably should
just comment out the message in "production" software so it doesn't
bother anybody.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


