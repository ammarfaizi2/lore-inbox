Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263467AbTC2Va5>; Sat, 29 Mar 2003 16:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263469AbTC2Va5>; Sat, 29 Mar 2003 16:30:57 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:1028
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S263467AbTC2Va4>; Sat, 29 Mar 2003 16:30:56 -0500
Message-ID: <004201c2f63c$25d4aa00$030aa8c0@unknown>
From: "Shawn Starr" <spstarr@sh0n.net>
To: "Robert Love" <rml@tech9.net>
Cc: <linux-kernel@vger.kernel.org>
References: <001c01c2f634$2e517da0$030aa8c0@unknown> <1048972543.13757.3.camel@localhost>
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings
Date: Sat, 29 Mar 2003 16:42:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I go about debugging this? How can I find the path causing the
problem?

Shawn.

----- Original Message -----
From: "Robert Love" <rml@tech9.net>
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, March 29, 2003 4:15 PM
Subject: Re: [PANIC][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings


> On Sat, 2003-03-29 at 15:45, Shawn Starr wrote:
>
> > In both panics below c012e9b4 does not exist as a kernel symbol in
> > System.map:
>
> The EIP need not exist itself in System.map.  System.map has the symbol
> to initial address mapping.  For example,
>
> 100 functionA
> 200 functionB
>
> If the EIP was "150" you would be 50 bytes into functionA().
>
> > Code: 89 50 04 89 02 c7 41 30 00 00 00 00 81 3d 60 98 41 c0 3c 4b
> >  kernel/timer.c:258: spin_lock(kernel/timer.c:c0419860) already locked
by
> > kernel/timer.c/398
> > Kernel panic: Aiee, killing interrupt handler!
> > In interrupt handler - not syncing
>
> This is not a panic, just an oops.  And it was just a debugging check
> from spin lock debugging, but unfortunately you were in an interrupt
> handler so the machine went bye bye.
>
> It is probably a simple double-lock deadlock, detected by spin lock
> debugging.  Knowing the EIP would help... but timer_interrupt() is a
> good first guess.
>
> Robert Love
>
>

