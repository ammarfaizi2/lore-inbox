Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266952AbTGOJV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266966AbTGOJV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:21:27 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:10624 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S266952AbTGOJVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:21:23 -0400
Date: Tue, 15 Jul 2003 11:36:10 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-t1: problems with modules
Message-Id: <20030715113610.371df42b.martin.zwickel@technotrend.de>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.0claws93 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.aNXIGr1nH+4bc0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.aNXIGr1nH+4bc0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi there!

I try to compile my driver for 2.6.0-t1.

I can insmod 2 modules out of 3, and i dont know why the 3rd fails.

Changes I did for 2.6.0-t1 to my driver:
 - added -DKBUILD_MODNAME=<name>
 - renamed MINOR() to minor()
 - removed MOD_INC/DEC_USE_COUNT
 - removed MODULE_PARM*

---------------------------------
A module thats working:
gcc:
gcc -Wall -O3 -finline-functions -Wstrict-prototypes -falign-functions=4
-I/lib/modules/2.6.0-test1-ac1/build/include
-I/lib/modules/2.6.0-test1-ac1/build/include/asm/mach-default -I./include
-D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -DKBUILD_MODNAME=working -c working.c -o
working.o

insmod:
# insmod ./working.o

kmsg:
Jul 15 11:26:28 phoebee working: no version magic, tainting kernel.
Jul 15 11:26:28 phoebee working: module license 'TechnoTrend' taints kernel.

objdump -h:
# objdump -h working.o
working.o:     file format elf32-i386
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000166  00000000  00000000  00000040  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .data         00000078  00000000  00000000  000001c0  2**5
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  2 .bss          00000018  00000000  00000000  00000238  2**2
                  ALLOC
  3 .gnu.linkonce.this_module 00000200  00000000  00000000  00000280  2**7
                  CONTENTS, ALLOC, LOAD, RELOC, DATA, LINK_ONCE_DISCARD
  4 .modinfo      0000004a  00000000  00000000  00000480  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .rodata.str1.1 0000004c  00000000  00000000  000004ca  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .rodata.str1.32 00000025  00000000  00000000  00000520  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 .init.text    000000d8  00000000  00000000  00000550  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  8 .exit.text    0000006a  00000000  00000000  00000630  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  9 .comment      00000042  00000000  00000000  0000069a  2**0
                  CONTENTS, READONLY
--------------------------------
The module thats not working:
gcc:
gcc -Wall -O3 -finline-functions -Wstrict-prototypes -falign-functions=4
-I/lib/modules/2.6.0-test1-ac1/build/include
-I/lib/modules/2.6.0-test1-ac1/build/include/asm/mach-default -I./include
-D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -DKBUILD_MODNAME=not_working -c
not_working.c -o not_working.o

insmod:
# insmod ./not_working.o
Error inserting './not_working.o': -1 Invalid module format

kmsg:
Jul 15 11:27:55 phoebee not_working: no version magic, tainting kernel.
Jul 15 11:27:55 phoebee not_working: module license 'TechnoTrend' taints kernel.

objdump -h:
# objdump -h not_working.o
not_working.o:     file format elf32-i386
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000bb3  00000000  00000000  00000040  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .data         00000080  00000000  00000000  00000c00  2**5
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  2 .bss          00000004  00000000  00000000  00000c80  2**2
                  ALLOC
  3 .gnu.linkonce.this_module 00000200  00000000  00000000  00000c80  2**7
                  CONTENTS, ALLOC, LOAD, RELOC, DATA, LINK_ONCE_DISCARD
  4 .modinfo      0000004a  00000000  00000000  00000e80  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .rodata.str1.32 00000378  00000000  00000000  00000ee0  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .rodata.str1.1 0000000c  00000000  00000000  00001258  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 .rodata       0000004c  00000000  00000000  00001264  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  8 .fixup        00000068  00000000  00000000  000012b0  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  9 __ex_table    00000040  00000000  00000000  00001318  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
 10 .init.text    000000cc  00000000  00000000  00001360  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
 11 .exit.text    00000050  00000000  00000000  00001430  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
 12 .comment      00000042  00000000  00000000  00001480  2**0
                  CONTENTS, READONLY
--------------------------------

What is wrong with the not_working.o?
And do I have to use try_module_get(mod) & module_put(mod) since
MOD_INC/DEC_USE_COUNT are deprecated?
What about the MODULE_PARM? any replacement?

Sorry if I'm asking already answered questions.

Regards,
Martin

-- 
MyExcuse:
backup tape overwritten with copy of system manager's favourite CD

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--=.aNXIGr1nH+4bc0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/E8sMmjLYGS7fcG0RAlBpAJ47njbUk0gtfWzdZTBoWgPKBk1Y6QCgrNFH
sS7EM6pdoTRt7buJfBzvgmw=
=bhr6
-----END PGP SIGNATURE-----

--=.aNXIGr1nH+4bc0--
