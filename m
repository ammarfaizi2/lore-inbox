Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264069AbRFNVew>; Thu, 14 Jun 2001 17:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264071AbRFNVeo>; Thu, 14 Jun 2001 17:34:44 -0400
Received: from maild.telia.com ([194.22.190.101]:14075 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S264069AbRFNVe3>;
	Thu, 14 Jun 2001 17:34:29 -0400
Message-Id: <200106142134.f5ELYGA19032@maild.telia.com>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Roger Larsson <roger.larsson@norran.net>
To: root@chaos.analogic.com
Subject: Re: SMP spin-locks
Date: Thu, 14 Jun 2001 23:30:58 +0200
X-Mailer: KMail [version 1.2.2]
In-Reply-To: <Pine.LNX.3.95.1010614165153.16430A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010614165153.16430A-100000@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 23:05, you wrote:
> On Thu, 14 Jun 2001, Roger Larsson wrote:
> > Hi,
> >
> > Wait a minute...
> >
> > Spinlocks on a embedded system? Is it _really_ SMP?
>
> The embedded system is not SMP. However, there is definite
> advantage to using an unmodified kernel that may/may-not
> have been compiled for SMP. Of course spin-locks are used
> to prevent interrupts from screwing up buffer pointers, etc.
>

Not really - it prevents another processor entering the same code
segment  (spin_lock_irqsave prevents both another processor and
local interrupts).

An interrupt on UP can not wait on a spin lock - it will never be released
since no other code than the interrupt spinning will be able to execute)


> > What kind of performance problem do you have?
>
> The problem is that a data acquisition board across the PCI bus
> gives a data transfer rate of 10 to 11 megabytes per second
> with a UP kernel, and the transfer drops to 5-6 megabytes per
> second with a SMP kernel. The ISR is really simple and copies
> data, that's all.
>
> The 'read()' routine uses a spinlock when it modifies pointers.
>
> I started to look into where all the CPU clocks were going. The
> SMP spinlock code is where it's going. There is often contention
> for the lock because interrupts normally occur at 50 to 60 kHz.
>

SMP compiled kernel, but running on UP hardware - right?
Then this _should not_ happen!

see linux/Documentation/spinlocks.txt

Is it your spinlocks that are causing this, or?

> When there is contention, a very long........jump occurs into
> the test.lock segment. I think this is flushing queues.
>

It does not matter, if there is contention - let it take time. Waiting is what
spinlocking is about anyway...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
