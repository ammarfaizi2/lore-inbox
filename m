Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263462AbTC2VEa>; Sat, 29 Mar 2003 16:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263463AbTC2VEa>; Sat, 29 Mar 2003 16:04:30 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:6407
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263462AbTC2VE3>; Sat, 29 Mar 2003 16:04:29 -0500
Subject: Re: [PANIC][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings
From: Robert Love <rml@tech9.net>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001c01c2f634$2e517da0$030aa8c0@unknown>
References: <001c01c2f634$2e517da0$030aa8c0@unknown>
Content-Type: text/plain
Organization: 
Message-Id: <1048972543.13757.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 29 Mar 2003 16:15:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 15:45, Shawn Starr wrote:

> In both panics below c012e9b4 does not exist as a kernel symbol in
> System.map:

The EIP need not exist itself in System.map.  System.map has the symbol
to initial address mapping.  For example,

	100	functionA
	200	functionB

If the EIP was "150" you would be 50 bytes into functionA().

> Code: 89 50 04 89 02 c7 41 30 00 00 00 00 81 3d 60 98 41 c0 3c 4b
>  kernel/timer.c:258: spin_lock(kernel/timer.c:c0419860) already locked by
> kernel/timer.c/398
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing

This is not a panic, just an oops.  And it was just a debugging check
from spin lock debugging, but unfortunately you were in an interrupt
handler so the machine went bye bye.

It is probably a simple double-lock deadlock, detected by spin lock
debugging.  Knowing the EIP would help... but timer_interrupt() is a
good first guess.

	Robert Love

