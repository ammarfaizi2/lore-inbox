Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUCVWKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbUCVWKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:10:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63106 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263713AbUCVWKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:10:33 -0500
Date: Mon, 22 Mar 2004 17:13:43 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Robert_Hentosh@Dell.com,
       fleury@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.44.0403222105380.3493-100000@poirot.grange>
Message-ID: <Pine.LNX.4.53.0403221701460.24245@chaos>
References: <Pine.LNX.4.44.0403222105380.3493-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Guennadi Liakhovetski wrote:

> On Mon, 22 Mar 2004, Maciej W. Rozycki wrote:
>
> >  Do you really get "spurious 8259A interrupt" messages for the local APIC
> > timer???  They don't ever leave the unit bound to the processor -- it has
> > to be something else.  What is your contents of /proc/interrupts?
>
> Ok, here's exactly, what I see:
> 1) during start-up 1 message
> spurious 8259A interrupt: IRQ7.
> 2) at run-time ERR: count increases - sometimes several per
> second, sometimes it remains constant for some time.
> 3) No more "spurious" messages
> 4) I saw definitely situations, when between 2 /proc/interrupts snapshots
> the sum of all (except the timer) interrupts was smaller, than the number
> of errors, e.g.
>
>            CPU0 (2nd shot)
>   0:      36557  37638 +1081 XT-PIC  timer
>   1:         59     65    +6 XT-PIC  i8042
>   2:          0      0       XT-PIC  cascade
>   5:          0      0       XT-PIC  VIA686A
>   8:          3      3       XT-PIC  rtc
>   9:          0      0       XT-PIC  acpi, uhci_hcd, uhci_hcd
>  10:          0      0       XT-PIC  eth0
>  12:         84     84       XT-PIC  i8042
>  14:       1910   1918    +8 XT-PIC  ide0
>  15:          1      1       XT-PIC  ide1
> NMI:         18     18
> LOC:      36460  37541 +1081
> ERR:         36     57   +21
>

First, you are using the 8259A (XT-PIC). This means you have
IO-APIC turned off (or it doesn't exist).

> ide0 + i8042 (keyboard) = 14, whereas errors increased by 21. So, if you
> are right, than Alan's wrong (or my understanding of his statement), and
> those spurious interrupts occur not only after real ones, or, one real
> interrupt can produce several spurious ones.

Neither. They are not related. As previously stated, a spurious
interrupt occurs when the CPU INT line becomes active, but no
interrupt controller caused it to happen. It's just that simple.
There is no magic. Given that the CPU needs to have a vector
placed on the bus every time the INT line goes active, the
interrupt controller says; "What's a mother to do?". To placate
the CPU and terminate the INT/INTA cycle, the controller puts
its lowest-priority vector on the bus. The CPU will eventually
branch to the address specified for that vector. The code there
says; "I'm IRQ7, I'm not even hooked...This must be a spurious
interrupt..."

Again, it's a hardware problem. It can't be fixed in software.
Of course, you could get rid of the "!&@#)$^#$)!@^$" message
that's mucking everybody up. Then you could use defective hardware
just like Win$


>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


