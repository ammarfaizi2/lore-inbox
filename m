Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSDPNEg>; Tue, 16 Apr 2002 09:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSDPNEg>; Tue, 16 Apr 2002 09:04:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:51074 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293135AbSDPNEf>; Tue, 16 Apr 2002 09:04:35 -0400
Date: Tue, 16 Apr 2002 08:42:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: BALBIR SINGH <balbir.singh@wipro.com>
cc: William Lee Irwin III <wli@holomorphy.com>, Olaf Fraczyk <olaf@navi.pl>,
        linux-kernel@vger.kernel.org
Subject: RE: Why HZ on i386 is 100 ?
In-Reply-To: <AAEGIMDAKGCBHLBAACGBEEONCEAA.balbir.singh@wipro.com>
Message-ID: <Pine.LNX.3.95.1020416083349.18369B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, BALBIR SINGH wrote:

> I remember seeing somewhere unix system VII used to have HZ set to 60
> for the machines built in the 70's. I wonder if todays pentium iiis and ivs
> should still use HZ of 100, though their internal clock is in GHz. 
> 

A different clock goes to the timer chip. It is always:

	CLOCK_TICK_RATE 1193180 Hz
unless an Elan SC-520 at which time the frequency is:
	CLOCK_TICK_RATE 1189200 Hz 

(from ../include/asm/timex.h)

> I think somethings in the kernel may be tuned for the value of HZ, these
> things would be arch specific.
> 
> Increasing the HZ on your system should change the scheduling behaviour,
> it could lead to more aggresive scheduling and could affect the
> behaviour of the VM subsystem if scheduling happens more frequently. I am
> just guessing, I do not know.
> 

It doesn't/can't change scheduling behavior. It changes only the rate
at which a CPU bound task will get the CPU taken away. It also changes
the rate it which it gets it back, in a 1:1 ratio, with a net effect
of nothing-gained/nothing-lost except for preemption overhead.

> Changing though trivial would require a good look at all the code that
> uses HZ.
> 

The reference to HZ seems to be correct in all the headers so changing
it is trivial.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

