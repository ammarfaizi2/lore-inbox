Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSH0Ryx>; Tue, 27 Aug 2002 13:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSH0Ryx>; Tue, 27 Aug 2002 13:54:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:47745 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316594AbSH0Ryw>; Tue, 27 Aug 2002 13:54:52 -0400
Date: Tue, 27 Aug 2002 14:01:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Hounschell <markh@compro.net>
cc: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
In-Reply-To: <3D6BB9E2.DE71FE2C@compro.net>
Message-ID: <Pine.LNX.3.95.1020827135107.10631A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002, Mark Hounschell wrote:

> "Wessler, Siegfried" wrote:
> > 
> > Hello,
> > 
> > I am running and will in near future kernel 2.4.18 on an embedded system.
> > 
> > I have to speed up interrupt latency and need to understand how in what
> > timing tasklets are called and arbitraded.
> > 
> > I have to dig deep, but the kernel tree is quiet huge. As a non kernel
> > programmer I ask you, if anyone could give me a hint, where to start reading
> > from and which kernel source to pick first.
> > 
> > Any help highly appreaciated.
> > (BTW: I will not bother you personaly with further questions unless you give
> > permission.)
> > 
> > What's behind it: We patched NMI and do some stuff we have to do very
> > regularly in there. After NMI we have to quiet fast start a kernel or even a
> > user space function with low latency. Also I measured 8 milliseconds after a
> > hardware interrupt before the corresponding interrupt function is called. At
> > RTI time it is even longer (around 12 microseconds). Need to find a way to
> > exactly understand why, and maybe speed up a bit.
> > 
> > Thank You.
> > Siegfried.
> 
> I've found that with the combination of process affinity and irq affinity you
> can get very good interrupt latency/determinism. We use a pci card that has
> some external interrupts and some 250ns resolution timers and have found the
> interrupt latency/determinism of the external interrupts to be more than 
> exceptable as long as the process and irq of that pci card are forced
> to one cpu and ALL other processes/irq's are forced to another cpu. Of coarse
> you need an SMP box for best results. We found that with a UMP box you can
> get the latency but there is no determinism to that latency.
> 
> Mark

> > user space function with low latency. Also I measured 8 milliseconds after a
                                                ^^^^^^^^^^^^^^^^^^^^^^^^

This cannot be. A stock kernel-2.4.18, running a 133 MHz AMD-SC520,
(like a i586) with a 33 MHz bus, handles interrupts off IRQ7 (the lowest
priority), from the 'printer port' at well over 75,000 per second without
skipping a beat or missing an edge. This means that latency is at least
as good as 1/57,000 sec = 0.013 microseconds.

To get data into user-space is not 'interrupt latency'. If that's what
is meant, you could lose a whole (worse case) HZ on a single CPU machine
before any user would even know that data was available or an interrupt
occurred.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

