Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbQKOLoR>; Wed, 15 Nov 2000 06:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbQKOLoI>; Wed, 15 Nov 2000 06:44:08 -0500
Received: from chiara.elte.hu ([157.181.150.200]:2063 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130335AbQKOLn5>;
	Wed, 15 Nov 2000 06:43:57 -0500
Date: Wed, 15 Nov 2000 13:23:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] removal of oops->printk deadlocks
In-Reply-To: <3A126E84.B77704FD@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0011151318060.2374-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Nov 2000, Andrew Morton wrote:

> [...] Problem is, we're getting some reported lockups in which we need
> to know what the other CPUs are doing (the other 1%). If a critical
> spinlock is stuck on, we don't get to type `dmesg'.

i know - but we cannot please everyone, so i went for the 99% :-)

> So...  In this updated patch the console_silent() call remains
> as you designed it, but the nmi_watchdog kernel boot parameter has
> been overloaded so that
> 
> 	nmi_watchdog=2
> 
> will now cause _all_ NMI oops messages to be displayed on the console.
> 
> Is this OK?

this collides with the UP-IOAPIC path's use of nmi_watchdog == 2 ...

i'd rather suggest a cleaner, "nmi_watchdog=2,verbose" (default: silent)
type of boot parameter, it looks like the NMI watchdog needs more
parameters.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
