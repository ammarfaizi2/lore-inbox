Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbSLDWZ1>; Wed, 4 Dec 2002 17:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267125AbSLDWZ1>; Wed, 4 Dec 2002 17:25:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:58098 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267124AbSLDWZ0>;
	Wed, 4 Dec 2002 17:25:26 -0500
Message-ID: <3DEE822D.385D2664@mvista.com>
Date: Wed, 04 Dec 2002 14:31:09 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: dan@debian.org, torvalds@transmeta.com, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <3DEE5DE1.762699E3@mvista.com>
		<Pine.LNX.4.44.0212041203230.1676-100000@penguin.transmeta.com>
		<20021204205609.GA29953@nevyn.them.org> <20021204.140954.89672437.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Daniel Jacobowitz <dan@debian.org>
>    Date: Wed, 4 Dec 2002 15:56:09 -0500
> 
>    Is the necessary information recoverable in
>    Alpha et al.?
> 
> No, and Sparc is the same.  It's kept in local registers
> in the assembler of the trap return path.

One solution would then appear to be that we need arch
wrappers for nano_sleep and clock_nanosleep (when and if).  

On the PARISC I did this (a long time ago in a far away
place) by unwinding the stack to pick up the registers that
were saved along the way.  Is this at all feasible?

It might help to understand just what registers do_signal
needs.  It doesn't need them all, I suspect.

Yet another idea, do_signal does not actually call the user
handler (the only case where it needs the regs) but sets up
the stack to make it happen when the system call returns. 
If there were a function that could be called to find out if
a signal was going to be delivered, the right thing could be
done in nano_sleep() and the actual do_signal call could
come from the system call return path as it does now.

Yes, I like that...
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
