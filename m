Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSIDSUu>; Wed, 4 Sep 2002 14:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSIDSUu>; Wed, 4 Sep 2002 14:20:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313571AbSIDSUt>; Wed, 4 Sep 2002 14:20:49 -0400
Date: Wed, 4 Sep 2002 14:25:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Problem on a kernel driver(SuSE, SMP)
In-Reply-To: <8C18139EDEBC274AAD8F2671105F0E8E121766@cacexc02.americas.cpqcorp.net>
Message-ID: <Pine.LNX.3.95.1020904141906.425A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002, Libershteyn, Vladimir wrote:

> > 
> > You are not too specific, which makes it hard to understand what may
> > be going wrong so I'll assume that you probably did a bad thing.
> 
> I think I gave all the specific information
> 
> > 
> > (1)  You cannot sleep in an interrupt, which means you can't use
> > down_*() and friends inside an ISR.
> 
> I DO NOT sleep in ISR, the up*() routine is inside the ISR, dut not down*()
> This is a standard use of the mechanism
> 
> > 
> > (2)  Wait queues should work fine from the 'user-side' of a driver,
> > but again, you cannot ever sleep in an interrupt service routine.
> > Look in ../linux/drivers/* for examples of code that works.
> > 
> 
> Again there is NO sleep in ISR, and I know that queues should work fine, 
> but they don't, that why I have a problem, but problem only on
> SMP machine.
> 
> > (3)  You can't use any wait-queue or sleep on a semaphore while
> > holding a spin-lock or while the interrupts are disabled. You can
> > manage your own lock against re-entry in your procedure, but you
> > can't allow two tasks to try the same semaphore at (nearly) the
> > same time or you can dead-lock.
> 
> I DO NOT hold any spinlocks, while use down_interruptible
> 
> > 
> > 
> > (4)	The fact that 'down' hangs means that there is nothing
> > that the CPU can do. This is direct evidence that you have the
> > interrupts disabled when down executes.
> 
> To be more specific, here is a code:
> ----------------------------------------------------
> function when thread go to sleep, if data not ready 
> ---------------------------------------------------

Snipped code.

How do you know that 
 	up(&a->sem[enumerator]);
in the ISR and...
 	down_interruptible(&a->sem[enumerator]);
In axl_get_response...
	... have the same value of 'enumerator', therefore the same
semaphore?

One comes from a modulus and another from indirection off from 'board
address'?

I think there is a bug there.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

