Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTEEMqR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbTEEMqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:46:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262165AbTEEMqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:46:15 -0400
Date: Mon, 5 May 2003 09:12:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sneaker@gmx.net
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: questions regarding arch/i386/boot/setup.S
In-Reply-To: <23912.1052135086@www4.gmx.net>
Message-ID: <Pine.LNX.4.53.0305050856430.140@chaos>
References: <23912.1052135086@www4.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003 Sneaker@gmx.net wrote:

> I write this to the kernel mailing list, because my question couldn't be
> answered on irc (eg. irc.kernelnewbie.org):
> ____________________________________________________________________________
> arch/i386/boot/setup.S:
>
> 164 trampoline:     call    start_of_setup
> 165                 .space  1024
> 166 # End of setup header
> #####################################################
> 167
> 168 start_of_setup:
> 169 # Bootlin depends on this being done early
> 170         movw    $0x01500, %ax
> ____________________________________________________________________________
> my questions are:
>
> -)    Why is there a call on line 164 and not a jmp?
> -)    Why does line 165 reserve 1024 bytes? what is it for?
> -)    On line 170: Why $0x01500 and not $0x1500?
>
> I would appreciate if someone could answer this mail, or if someone can
> provide ressources where I can find detailed description of the kernel code
> (didn't find anything, just overall information)
>
> regards,
>
> andy

This is just one of life's little mysteries! Actually, if you
compile the code without the call, or just bypass with a jump
from the start to _start_of_setup, without the jump to trampoline,
it looks like it would sill work. But, LILO will declare that
the kernel is too big (large) because LILO, the usual boot loader,
assumes bad things about the starting code layout. Maybe the new
GRUB boot loader is better behaved, but the image, bzImage needs
to be able to do several things in addition to the obvious.

(1)	Copy bzImage to a floppy and the floppy will boot.
(2)	Be able to use `rdev` to modify the boot parameters.
(3)	Use bzImage with LILO for a loader.
(4)	Use bzImage with GRUB for a loader.
(5)	Put the kernel image at it's start address by any other
	means (embedded systems) and have it start when control
	is passed to it in protected mode.
(5)	Boot an intermediate RAM disk in the above circumstances.

All these requirements make it necessary for labels (locations)
to not be changed from the original boot methods. This means that
there may be some strange ways of accomplishing this. FYI, there
are several 'more correct' ways of maintaining the compatibility
of the startup code. If you are an expert in assembly-language,
you might want to clean up this area. I'm sure your help would
be appreciated. However, this stuff gets executed only once during
startup and then the RAM is used for kernel and user memory.
It might not be worthwhile to do very much with it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

