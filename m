Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130368AbQKORCV>; Wed, 15 Nov 2000 12:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129750AbQKORCC>; Wed, 15 Nov 2000 12:02:02 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:65194 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S129187AbQKORBx>; Wed, 15 Nov 2000 12:01:53 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Andrea Arcangeli <andrea@suse.de>
cc: Josue.Amaro@oracle.com, linux-kernel@vger.kernel.org
Message-ID: <80256998.005AB377.00@d06mta06.portsmouth.uk.ibm.com>
Date: Wed, 15 Nov 2000 15:22:56 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Andrea,

I am very greatful for your detailed analysis. I have yet to digest
everything you commented but will get back to you on all points you raise
very soon. Here are my thoughts so far:

> I think gkhi should be renamed to something like "Fast Unregistered
Kernel
> Hook Interface" to avoid confusion and wrong usage of it that would
otherwise
> leads to lower performance.



A fair point.


On point 3):

> 3)
>
> gkhi apparently doesn't yet know the word "SMP" 8).


When I announced GKHI I did state that SMP support was to follow. The
updates are trivial but I didn't wan't to release the code until I had had
a chance to test it.

On point 4)

> 4)
>
> gkh_iflush should be done with flush_icache_range that is infact
implemented
> wrong for IA32 and it should be implemented as regs trashing cpuid (the
fact
> it's wrongly implemented means that in theory modules can break in IA32
> on 2.4.x 2.2.x even on UP).


Are you claiming that flush_icache_range has an error and should implement
the IA32 instruction flush as I did using CPUID? If this is the case has
this error been officially reported?

On point 5)
5)

> Current dprobes v1.1.1 against 2.2.16 cames with a syscall collision:
> sys_dprobes collides with ugetrlimit (not implemented in 2.2.x). That's
fine
> for internal use and to show the code, but make _sure_ not to ship any
binary
> to anybody implementing ugetrlimit as sys_dprobes 8).
>
> Richard please ask Linus to reserve a syscall for dprobes. I recommend to
> allocate the syscall out of the way (I mean using syscall 255 or even
better
> enlarging the syscall table from 256 to 512 and using number 511) so we
make
> sure not to waste precious dcachelines for debugging stuff.

Thanks for this information. Reserving a syscall will become irrelvant when
we release Dprobes as a module using gkhi since we will use ioctl() as the
application interface.

> BTW, for things like lkcd there's no reason to use gkhi to make it
completly
> modular since lkcd gets recalled in a completly slow path.

Well, not necessarily so while lkcd is not get accepted into the standard
kernel source. But also, even when lkcd becomes accepted, using gkhi with
lkcd will allow a crash dump capability to be actived dynamically. That
gives the user more fexibility. Even enterprise customers can sometimes
hedge their bets when it comes to RAS-like features.



Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
