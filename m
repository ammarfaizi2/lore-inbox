Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTKFQFD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTKFQFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:05:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:58496 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263688AbTKFQEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:04:50 -0500
Date: Thu, 6 Nov 2003 11:03:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Robert Bird <rbird@Atlanticpositioners.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: reassigning IRQs for specific PCI slots...
In-Reply-To: <13811E54B99D7C4AA403E725583A356F0BBB72@mail-server.atlanticpositioners.com>
Message-ID: <Pine.LNX.4.53.0311061042180.6923@chaos>
References: <13811E54B99D7C4AA403E725583A356F0BBB72@mail-server.atlanticpositioners.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, Robert Bird wrote:


First. Fix your mailer. The world was NOT redefined by Microsoft.
Each line of text is supposed to contain a character that defines
the end-of-line '\n'. This must occur on or before the 80th column.
Your email contained only 4 '\n' characters but contained 24 lines.

>
> Hi,
>
> We are trying to use RTLinux thread to service a PCI-based multi-port
> serial card.  I have read several documents regarding "sharing IRQs",
> using boot-prompt parameters, IO-APIC.txt, etc.  I am being told by the
> RTLinux community that I must not share interrupts when using real-time

What does sharing interrupts have to do with realtime? All PCI boards
and their software must be capable of sharing an interrupt line.
It's in the PCI specification. The IRQ latency at the end of an
IRQ chain will be dependent upon the length of the code execution
path for the previous devices sharing the interrupt, but a properly-
written ISR will (usually) provide a low-enough latency so the
ISR behavior is deteministic, which is what "realtime" is all about.

> thread to service a PCI-based function.  I have tried using several
> combinations of boot-prompt parameters (we are using GRUB) but have had
> no success in redirecting IRQ assignment during boot-time!
>
> I have tried to use "pirq=" boot parameter.....the booting kernel
> does acknowledge the parameter but appears to forget about it when
> PCI  probing occurs.  It assigns my two PCI-based boards the same way
> each time: slot #1=5, slot #2=11.  I have made some semi-smart attempts
> to use the "pci=" parameters "nobios", "noapic" (my kernel does not
> recognize this one), and "nosort" in conjunction with the "pirq="
> parameter.  [I guess my "semi-smart attempts" are not that smart].
>
> Is it possible to do what I want to do?  Would you have any ideas
> on what I could try next.
>
> I am not using a multi-processor board but have selected the IO-APIC
> option before making the compiler.
>
>

Most motherboards, perhaps all, have one and only one IRQ line
going to each slot. It connects to "PIN A", no other IRQ pins
are used.  Any reselection or redefinition of which IRQ line
goes to which slot, if it is programmable at all, is handled
by a MUX that only the BIOS knows about. There is no way
for it to be changed except through that BIOS.

If your PCI board(s) software cares about which IRQ they are
using, then the software is broken. It __must__ not. It's
part of the PCI definition. When your ISR gets control, it
must check the hardware to determine if the hardware requested
the interrupt. If so, it must service that interrupt. If not,
it must ignore the interrupt. It's really that simple.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


