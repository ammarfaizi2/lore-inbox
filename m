Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbRFNVF7>; Thu, 14 Jun 2001 17:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264127AbRFNVFm>; Thu, 14 Jun 2001 17:05:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263137AbRFNVFW>; Thu, 14 Jun 2001 17:05:22 -0400
Date: Thu, 14 Jun 2001 17:05:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roger Larsson <roger.larsson@norran.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP spin-locks
In-Reply-To: <200106142045.f5EKjLI14289@mailf.telia.com>
Message-ID: <Pine.LNX.3.95.1010614165153.16430A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, Roger Larsson wrote:

> Hi,
> 
> Wait a minute...
> 
> Spinlocks on a embedded system? Is it _really_ SMP?
>

The embedded system is not SMP. However, there is definite
advantage to using an unmodified kernel that may/may-not
have been compiled for SMP. Of course spin-locks are used
to prevent interrupts from screwing up buffer pointers, etc.
 
> What kind of performance problem do you have?

The problem is that a data acquisition board across the PCI bus
gives a data transfer rate of 10 to 11 megabytes per second
with a UP kernel, and the transfer drops to 5-6 megabytes per
second with a SMP kernel. The ISR is really simple and copies
data, that's all.

The 'read()' routine uses a spinlock when it modifies pointers.

I started to look into where all the CPU clocks were going. The
SMP spinlock code is where it's going. There is often contention
for the lock because interrupts normally occur at 50 to 60 kHz.

When there is contention, a very long........jump occurs into
the test.lock segment. I think this is flushing queues. 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


