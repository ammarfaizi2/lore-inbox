Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUAJNxe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 08:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbUAJNxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 08:53:34 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:19102 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S265163AbUAJNxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 08:53:31 -0500
Date: Sat, 10 Jan 2004 14:53:29 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.2. ELF loader mystery
Message-Id: <20040110145329.36ecaa38@argon.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__10_Jan_2004_14_53_29_+0100_L30PvIr0+qhg1mcX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__10_Jan_2004_14_53_29_+0100_L30PvIr0+qhg1mcX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Hi,

Linux 2.2 refuses to allocate certain .bss ELF sections in memory if there
are PT_LOAD sections following them. Is there any convention saying that
.bss must always be the last section and must not be followed by PT_LOAD
sections? OTOH both Linux 2.4 and 2.6 have no trouble getting this right
and load the binary just fine.

Here is an example. There is an .initcall section following .bss and
.bss (sections 13 and 14) are not being allocated with zero-pages on startup.
Program thus crashes with SIGSEGV.

Any hints welcome.

-Udo.



prog:     file format elf32-i386

Program Header:
    LOAD off    0x00000000 vaddr 0x00001000 paddr 0x00001000 align 2**12
         filesz 0x000a6468 memsz 0x000b8818 flags rwx
    LOAD off    0x000a7000 vaddr 0x000ba000 paddr 0x000ba000 align 2**12
         filesz 0x00005000 memsz 0x00005000 flags rwx

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .init         00000017  00001200  00001200  00000200  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .text         0007d640  00001220  00001220  00000220  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .fini         0000001b  0007e860  0007e860  0007d860  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  3 .rodata       00027228  0007e880  0007e880  0007d880  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .eh_frame     00000000  000a5aa8  000a5aa8  000a4aa8  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .preinit_array 00000000  000a5aa8  000a5aa8  000ac000  2**0
                  CONTENTS
  6 .init_array   00000000  000a5aa8  000a5aa8  000ac000  2**0
                  CONTENTS
  7 .fini_array   00000000  000a5aa8  000a5aa8  000ac000  2**0
                  CONTENTS
  8 .data         000018f0  000a5ac0  000a5ac0  000a4ac0  2**5
                  CONTENTS, ALLOC, LOAD, DATA
  9 .jcr          00000000  000a73b0  000a73b0  000a63b0  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 10 .ctors        000000a0  000a73b0  000a73b0  000a63b0  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 11 .dtors        00000008  000a7450  000a7450  000a6450  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 12 .got          00000010  000a7458  000a7458  000a6458  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 13 .bss          00011800  000a8000  000a8000  000a7000  2**5
                  ALLOC
 14 __libc_freeres_ptrs 00000018  000b9800  000b9800  000a7000  2**2
                  ALLOC
 15 .initcall     00005000  000ba000  000ba000  000a7000  2**5
                  CONTENTS, ALLOC, LOAD, CODE
 16 .debug_pubnames 00000025  00000000  00000000  000ac000  2**0
                  CONTENTS, READONLY, DEBUGGING
 17 .debug_info   0000096c  00000000  00000000  000ac025  2**0
                  CONTENTS, READONLY, DEBUGGING
 18 .debug_abbrev 00000124  00000000  00000000  000ac991  2**0
                  CONTENTS, READONLY, DEBUGGING
 19 .debug_line   000001c8  00000000  00000000  000acab5  2**0
                  CONTENTS, READONLY, DEBUGGING
 20 .debug_str    00000674  00000000  00000000  000acc7d  2**0
                  CONTENTS, READONLY, DEBUGGING
 21 .debug_aranges 00000058  00000000  00000000  000ad2f8  2**3
                  CONTENTS, READONLY, DEBUGGING
 22 .stab         000dba14  00000000  00000000  000ad350  2**2
                  CONTENTS, READONLY, DEBUGGING
 23 .stabstr      002ddbd6  00000000  00000000  00188d64  2**0
                  CONTENTS, READONLY, DEBUGGING

results in the following memory map after startup:

00001000-000a8000 rwxp 00000000 03:07 62988      /tmp/prog
000ba000-000bf000 rwxp 000a7000 03:07 62988      /tmp/prog
bffff000-c0000000 rwxp 00000000 00:00 0

--Signature=_Sat__10_Jan_2004_14_53_29_+0100_L30PvIr0+qhg1mcX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAAPZnhRzXSM7nSkRAkOLAJ9GnBvOK42zQmDRNoqlQ0rj2zqH0QCfZwik
BiON4GmsY8EmvhcJnk73xVI=
=bnND
-----END PGP SIGNATURE-----

--Signature=_Sat__10_Jan_2004_14_53_29_+0100_L30PvIr0+qhg1mcX--
