Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311808AbSCNVmA>; Thu, 14 Mar 2002 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311813AbSCNVlu>; Thu, 14 Mar 2002 16:41:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311808AbSCNVla>; Thu, 14 Mar 2002 16:41:30 -0500
Date: Thu, 14 Mar 2002 16:41:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
cc: John Heil <kerndev@sc-software.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <3C9121EB.11632.26F0805@localhost>
Message-ID: <Pine.LNX.3.95.1020314163533.382A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Pedro M. Rodrigues wrote:

> 
>    This piece of code is taken from an old Minix source code tree, the file being 
> boothead.s . Notice the port 0xED usage and the comment.
> 
> 
> ! Enable (ah = 0xDF) or disable (ah = 0xDD) the A20 address line.
> gate_A20:
>         call    kb_wait
>         movb    al, #0xD1       ! Tell keyboard that a command is coming
>         outb    0x64
>         call    kb_wait
>         movb    al, ah          ! Enable or disable code
>         outb    0x60
>         call    kb_wait
> 
> 
>         mov     ax, #25         ! 25 microsec delay for slow keyboard chip
> 0:      out     0xED            ! Write to an unused port (1us)
>         dec     ax
>         jne     0b
> 
>         ret
> kb_wait:
>         inb     0x64
>         testb   al, #0x02       ! Keyboard input buffer full?
>         jnz     kb_wait         ! If so, wait
>         ret
> 
> 
> 
> /Pedro
> 

Well I see the comment. Writing to IO Space where there are no devices
is basically a no-op. The ISA/PC/AT bus is asynchronous, it is not
clocked. If there's is no contention due to bus activity from some
hardware read, it's just some address lines and data bits that are
eventually sinked by the bus capacity. The CPU isn't forced to wait
for anything. Since it's in I/O space, you don't even get the delay
from a cache-line reload. No thanks, it's bogus as a delay mechanism.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

