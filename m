Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSKGQuZ>; Thu, 7 Nov 2002 11:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSKGQuZ>; Thu, 7 Nov 2002 11:50:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:24705 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261506AbSKGQuY>; Thu, 7 Nov 2002 11:50:24 -0500
Date: Thu, 7 Nov 2002 11:59:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Corey Minyard <cminyard@mvista.com>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: NMI handling rework
In-Reply-To: <Pine.LNX.4.44.0211071134190.27141-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.3.95.1021107115259.9343A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Zwane Mwaikambo wrote:

> On Thu, 7 Nov 2002, Corey Minyard wrote:
> 
> > NMIs cannot be masked, they are by definition non-maskable :-).  You can 
> > get an NMI while executing an NMI.
> 
> "After an NMI interrupt is recognized by the P6 family, Pentium, Intel486, 
> Intel386, and Intel 286 processors, the NMI interrupt is masked until the 
> first IRET instruction is executed, unlike the 8086 processor."
> 
> - 18.22.2 NMI Interrupts, Intel IA32 System Developer's Manual vol3
> 
> > An NMI-based timer?  I can see the use if you REALLY need accurate 
> > intervals, but you can't do much in an NMI, no spinlocks, even.
> 
[SNIPPED...]

You can use a spinlock and, in fact, that's the only way you can
protect a critical section. The other CPU will spin of course, just
like the other CPU in a maskable interrupt. That's what spin-locks
are for. With maskable interrupts, the "cli" affects only the CPU
that actually fetches that instruction. That's why you need spin-lock
protection when you have more than one CPU. With NMI, no CPU has
the effect a "cli" would provide, so they just spin at the lock
until the lock is released.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


