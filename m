Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbTCKM2S>; Tue, 11 Mar 2003 07:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbTCKM2S>; Tue, 11 Mar 2003 07:28:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41091 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262908AbTCKM2R>; Tue, 11 Mar 2003 07:28:17 -0500
Date: Tue, 11 Mar 2003 07:40:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: uaca@alumni.uv.es
cc: linux-kernel@vger.kernel.org
Subject: Re: is irq smp affinity good for anything?
In-Reply-To: <20030311121916.GA12625@pusa.informat.uv.es>
Message-ID: <Pine.LNX.3.95.1030311073427.16779A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003 uaca@alumni.uv.es wrote:

> 
> 
> if IRQ affinity cannot help in interrupt latency and
> interrupt auto/balancing get's the same throughtput 
> as irq binding... what is irq smp affinity for???
> 
> from this mail from intel
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.0/1886.html
> I understand that intel's interrupt auto/balancing works equal that manually
> tunning the interrupts....
> 
> so?
> 
> 	Ulisses
> 
> 
> 
> On Mon, Mar 10, 2003 at 11:22:22PM +0100, uaca@alumni.uv.es wrote:
> > 
> > Hi all
> > 
> > I have measured interrupt latency of a bi-processor system with akpm's intlat/timepeg
> > utilities and kernel 2.4.20. The system uses is a two-way PIII@800Mhz
> > -- Intel motherboard, ISP 2100 if I remember ok, with a SCSI disk on a aic-7896
> > 
> > I tried to know if I could reduce the latency of an interrupt handler by
> > binding this handler to a particular cpu and not allowing any other
> > interrupt to execute in that cpu.
> > 
> > I found that overall latency increases, but also the latency on both cpus,
> > that is, I could not reduce the latency on the interrupt I was interested
> > 
> > I also tried to disallowing just scsi & ethernet handlers to execute on the
> > cpu in wich I'm binding the interrupt handler I'm insterested with, I get
> > similar results
> > 
> > the interrupt handler I'm interested with is an ATM card receiving
> > around 6000 interrupts/second
> > 
[SNIPPED...]

33 MHz machines easily handle 6,000 interrupts per second --
unless you are trying to execute code within that interrupt
that requires 1/6000th of a second to execute!  Perhaps it's
not a "latency" problem, but an interrupt code-bloat problem
where most of the stuff should be executed out of the interrupt
context.

There are timer queues and kernel threads available that might
help you. Also a tightly-coupled user-mode daemon that uses
your driver only to interface with the hardware and not do
any "logic" is probably the way to go.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


