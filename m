Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283749AbRK3TsB>; Fri, 30 Nov 2001 14:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283711AbRK3Trv>; Fri, 30 Nov 2001 14:47:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15488 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S283719AbRK3Trp>; Fri, 30 Nov 2001 14:47:45 -0500
Date: Fri, 30 Nov 2001 14:47:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: Chris Meadors <clubneon@hereintown.net>,
        Martin Eriksson <nitrax@giron.wox.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        martin@jtrix.com
Subject: Re: 'spurious 8259A interrupt: IRQ7' -> read the 8259 datasheet !
In-Reply-To: <3C07DDC6.5FAE4E35@t-online.de>
Message-ID: <Pine.LNX.3.95.1011130142654.2054A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Gunther Mayer wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Wed, 28 Nov 2001, Chris Meadors wrote:
> > 
> > > On Wed, 28 Nov 2001, Martin Eriksson wrote:
> 
> ...
> ... rumours deleted (e.g. "printer status bits are all ORed into irq7")
> ...
> 
> >From "Harris Semiconductor 82C59A Interrupt Controller Datasheet":
>   If no interrupt request is present at step 4 of either sequence
>   (i.e., the request was too short in duration), the 82C59A will
>   issue an interrupt level 7. 
> 
> 1. The irq controller sees an interrupt.
> 2. The irq controller signals "there is _some_ interrupt" to the cpu.
> 3. The CPU acks via INTA
> 4. The irq controller looks if the irq is still there
>    (and signals IRQ7 if the line is no longer active).
> 
> You have some device which doesn't keep the IRQ raised long enough !
> (or the CPU doesn't service the irq for a too long time and the 
>  edge triggered irq is de-asserted or even serviced by a polling routine)
> -

In the first place I HAVE not only read the data-sheet, but probably
was one of the first to report the affect when first observed in
the days of XT machines, before there was a second cascaded controller.

If the effect was caused by the transient condition you describe, then
the second controller would also suffer from the same problem, i.e.,
its "IRQ7" is really IRQ15 when cascaded.

The problems with "spurious IRQ7" reared its head when the new
boards and cards became available with CMOS inputs with weak and/or
no pull-ups. If you leave a connector off the printer port, the
status bits will float and generate interrupts on IRQ7. You can
stop this, as previously taught, by disabling the IRQ enable
by writing bit 4 of the control-port (offset 1) to zero. You do
this on all known printer ports and you no longer get the kernel
messages.

So, before you issue another "rumors deleted" know-it-all retort,
observe that you can "mysteriously" stop the problem by mucking
with the printer control port. This certainly seems to disprove
your INTA theory.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


