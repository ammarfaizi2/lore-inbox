Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317474AbSFDKNo>; Tue, 4 Jun 2002 06:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSFDKNn>; Tue, 4 Jun 2002 06:13:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:26072 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317474AbSFDKNm>; Tue, 4 Jun 2002 06:13:42 -0400
Date: Tue, 4 Jun 2002 12:13:39 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: [patch] remove 8253x tools from the Makefile
Message-ID: <Pine.NEB.4.44.0206041209230.8847-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the 8253x tools were removed from the kernel source but the Makefile still
tries to build them. The result is the following compile error in
2.4.19-pre10:

<--  snip  -->

...
ld -m elf_i386  -r -o ASLX.o 8253xini.o 8253xnet.o 8253xsyn.o crc32.o
8253xdbg.o 8253xplx.o 8253xtty.o 8253xchr.o 8253xint.o amcc5920.o 8253xmcs.o
8253xutl.o
make[4]: *** No rule to make target `8253xcfg', needed by `all'.  Stop.
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-full/drivers/net/wan/8253x'

<--  snip  -->


The fix is simple:


--- drivers/net/wan/8253x/Makefile.old	Tue Jun  4 12:05:21 2002
+++ drivers/net/wan/8253x/Makefile	Tue Jun  4 12:06:24 2002
@@ -11,7 +11,7 @@
 # Specifically the 2520, 4020, 4520, 8520
 #

-all: ASLX.o 8253xcfg 8253xmac eprom9050 8253xspeed 8253xpeer eprom9050
+all: ASLX.o

 O_TARGET := ASLX.o

@@ -24,5 +24,5 @@
 include $(TOPDIR)/Rules.make

 clean:
-	rm -f core *.o *.a *.s 8253xcfg 8253xmac eprom9050 *~
+	rm -f core *.o *.a *.s *~


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

