Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270912AbTGPPUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270919AbTGPPUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:20:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:26605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270912AbTGPPUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:20:41 -0400
Date: Wed, 16 Jul 2003 08:33:26 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1: problems with modules
Message-Id: <20030716083326.0c92c4f6.rddunlap@osdl.org>
In-Reply-To: <20030715113610.371df42b.martin.zwickel@technotrend.de>
References: <20030715113610.371df42b.martin.zwickel@technotrend.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 11:36:10 +0200 Martin Zwickel <martin.zwickel@technotrend.de> wrote:

| Hi there!
| 
| I try to compile my driver for 2.6.0-t1.
| 
| I can insmod 2 modules out of 3, and i dont know why the 3rd fails.
| 
| Changes I did for 2.6.0-t1 to my driver:
|  - added -DKBUILD_MODNAME=<name>
|  - renamed MINOR() to minor()
|  - removed MOD_INC/DEC_USE_COUNT
|  - removed MODULE_PARM*
| 
| ---------------------------------
| A module thats working:
| gcc:
| gcc -Wall -O3 -finline-functions -Wstrict-prototypes -falign-functions=4
| -I/lib/modules/2.6.0-test1-ac1/build/include
| -I/lib/modules/2.6.0-test1-ac1/build/include/asm/mach-default -I./include
| -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -DKBUILD_MODNAME=working -c working.c -o
| working.o

Use correct build/make for 2.5/2.6.  See linux/Documentation/modules.txt
and linux/Documentation/kbuild/makefiles.txt .

It's very simple and works well.

| insmod:
| # insmod ./working.o

You should insmod working.ko, not working.o .
(after building modules correctly)

| kmsg:
| Jul 15 11:26:28 phoebee working: no version magic, tainting kernel.
| Jul 15 11:26:28 phoebee working: module license 'TechnoTrend' taints kernel.
| 
| objdump -h:
| # objdump -h working.o
| working.o:     file format elf32-i386
| Sections:
| Idx Name          Size      VMA       LMA       File off  Algn
|   0 .text         00000166  00000000  00000000  00000040  2**4
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   1 .data         00000078  00000000  00000000  000001c0  2**5
|                   CONTENTS, ALLOC, LOAD, RELOC, DATA
|   2 .bss          00000018  00000000  00000000  00000238  2**2
|                   ALLOC
|   3 .gnu.linkonce.this_module 00000200  00000000  00000000  00000280  2**7
|                   CONTENTS, ALLOC, LOAD, RELOC, DATA, LINK_ONCE_DISCARD
|   4 .modinfo      0000004a  00000000  00000000  00000480  2**5
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   5 .rodata.str1.1 0000004c  00000000  00000000  000004ca  2**0
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   6 .rodata.str1.32 00000025  00000000  00000000  00000520  2**5
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   7 .init.text    000000d8  00000000  00000000  00000550  2**4
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   8 .exit.text    0000006a  00000000  00000000  00000630  2**4
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   9 .comment      00000042  00000000  00000000  0000069a  2**0
|                   CONTENTS, READONLY
| --------------------------------
| The module thats not working:
| gcc:
| gcc -Wall -O3 -finline-functions -Wstrict-prototypes -falign-functions=4
| -I/lib/modules/2.6.0-test1-ac1/build/include
| -I/lib/modules/2.6.0-test1-ac1/build/include/asm/mach-default -I./include
| -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -DKBUILD_MODNAME=not_working -c
| not_working.c -o not_working.o
| 
| insmod:
| # insmod ./not_working.o
| Error inserting './not_working.o': -1 Invalid module format
| 
| kmsg:
| Jul 15 11:27:55 phoebee not_working: no version magic, tainting kernel.
| Jul 15 11:27:55 phoebee not_working: module license 'TechnoTrend' taints kernel.
| 
| objdump -h:
| # objdump -h not_working.o
| not_working.o:     file format elf32-i386
| Sections:
| Idx Name          Size      VMA       LMA       File off  Algn
|   0 .text         00000bb3  00000000  00000000  00000040  2**4
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   1 .data         00000080  00000000  00000000  00000c00  2**5
|                   CONTENTS, ALLOC, LOAD, RELOC, DATA
|   2 .bss          00000004  00000000  00000000  00000c80  2**2
|                   ALLOC
|   3 .gnu.linkonce.this_module 00000200  00000000  00000000  00000c80  2**7
|                   CONTENTS, ALLOC, LOAD, RELOC, DATA, LINK_ONCE_DISCARD
|   4 .modinfo      0000004a  00000000  00000000  00000e80  2**5
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   5 .rodata.str1.32 00000378  00000000  00000000  00000ee0  2**5
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   6 .rodata.str1.1 0000000c  00000000  00000000  00001258  2**0
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   7 .rodata       0000004c  00000000  00000000  00001264  2**2
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
|   8 .fixup        00000068  00000000  00000000  000012b0  2**0
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   9 __ex_table    00000040  00000000  00000000  00001318  2**2
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
|  10 .init.text    000000cc  00000000  00000000  00001360  2**4
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|  11 .exit.text    00000050  00000000  00000000  00001430  2**4
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|  12 .comment      00000042  00000000  00000000  00001480  2**0
|                   CONTENTS, READONLY
| --------------------------------
| 
| What is wrong with the not_working.o?

Don't know exactly, but insmod not_working.ko after it is built.

| And do I have to use try_module_get(mod) & module_put(mod) since
| MOD_INC/DEC_USE_COUNT are deprecated?
| What about the MODULE_PARM? any replacement?

Here is the FAQ for 2.5/2.6 modules:
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/FAQ

| Sorry if I'm asking already answered questions.

--
~Randy
