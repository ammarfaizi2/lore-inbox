Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbSJaOcF>; Thu, 31 Oct 2002 09:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSJaOcF>; Thu, 31 Oct 2002 09:32:05 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:15114 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S262006AbSJaOb5>; Thu, 31 Oct 2002 09:31:57 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200210311430.g9VEUh3p014195@wildsau.idv.uni.linz.at>
Subject: need h/e/l/p:  PM -> RM in machine_real_start
To: linux-kernel@vger.kernel.org
Date: Thu, 31 Oct 2002 15:30:43 +0100 (MET)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
hello,

arch/i386/kernel/process.c exports a "machine_real_start" function, which
can be used to execute arbitary 16bit realmode code. I've got this to
work so far, by writing a small helper-module which copies 16bit code
supplied from userland and passes it to "machine_real_start", which in
turn, after switching to real mode, executes that particular code.

"machine_real_start" is currently only used to make real mode APM BIOS
calls to power off the machine. but as pointed out above, it can be
used to execute any 16bit code. of course, there's no way to go back to
linux, but that's not required (for me).

to show this approach works, I wrote some small assembly routines,
which do nothing but draw some characters on 0xb800 (text mode video),
hexdump the real mode interrupt vectors and so on. that's nice, but
that's not all I need.

what is needed is the BIOS. I wonder if it is at all possible to use
the BIOS again after linux once had run without jumping to 0xffff:0
does linux make use of the memory at 0x40? I'm pretty sure that it
will be possible to e.g. invoke 0x10 (video), since that is located
in ROM, but what about RAM. does linux make use of <1Mb area anyway,
that is, 2^20 (A20) the area which can be addresses with 20 bits of
address-lines (4bit segreg + 16bit offset).

well, BIOS is one thing, hardware is another. I seem not to be able
to get *any* interrupt, allthough I really tried in various ways.
write an ISR which increments a character in the upper left corner,
modify all 256 interrupt vectors to point to the ISR, re-enable interrupts,
(sti), unmask all interrupts (out 0x21,0; out 0xa1,0). but no matter
what I do - press a key (IRQ1) or program 8253 (IRQ0) - I just can't
see the ISR is being called.

is it neccessary to reset the pics? does linux change the operation
mode of the pics at all?

I also seem to have a very obsolete paper the port assignment of the
PC. do you know of any sources (perferrably on the web) which gives
a complete overview of portadresses used by the PC?

seveal years ago, I had an orignal bios listing for the IBM PC
directly from IBM. but not only have I lost that listing, it also
seems to be impossible to find any up-to-date bios listing ... well,
I guess the companies wont give them out, but at least I expected some
disassmbled code out there on the net... hm...!

any helpful response is welcome!
thanks in advance,
h.rosmanith













