Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264023AbRF2KmJ>; Fri, 29 Jun 2001 06:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265855AbRF2Kl6>; Fri, 29 Jun 2001 06:41:58 -0400
Received: from [211.108.47.117] ([211.108.47.117]:11785 "EHLO progress.plw.net")
	by vger.kernel.org with ESMTP id <S264023AbRF2Klk>;
	Fri, 29 Jun 2001 06:41:40 -0400
Date: Fri, 29 Jun 2001 19:41:06 +0900 (KST)
From: Byeong-ryeol Kim <jinbo21@hananet.net>
Reply-To: Byeong-ryeol Kim <jinbo21@hananet.net>
To: <linux-kernel@vger.kernel.org>
Subject: compile error about do_softirq in 2.4.5-ac21
Message-ID: <Pine.LNX.4.33.0106291939100.8064-100000@progress.plw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I met following error while compiling 2.4.5-ac21:

I know, of course, this error was reported several times as the
compile problem of 2.4.6-preX, and there posted a patch about it
by Mr. Keith Owens. I confirmed It had been applied to
include/asm-i386/softirq.h of 2.4.5-ac21).
But I see this in 2.4.5-ac21 again, and confused so much.

I use Red Hat 7.1 (with up to latest errata updates + kernel-2.4.5-ac19,
glibc-2.2.3, gcc-2.96-88, binutils-2.11.90.0.15, etc.)
BTW, this error ocurred on both K6-II+ desktop(no-name) and Pentium III
500 MHZ noteboot(IBM ThkinPad 600X), and compiler was the same on both
machines.

Before trying to compile, I applied a patch about drivers/net/Config.in
posted to this list by Mr. Keith Owens.

Long lines were wrapped by me.

...
make[2]: Leaving directory `/usr/src/linux-2.4.5-ac21/fs/jffs'
make -C jffs2 modules
...
gcc -D__KERNEL__ -I/usr/src/linux-2.4.5-ac21/include -Wall \
   -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
   -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 \
   -march=k6 -DMODULE -DMODVERSIONS \
   -include /usr/src/linux-2.4.5-ac21/include/linux/modversions.h \
   -c -o background.o background.c
background.c: In function `jffs2_garbage_collect_trigger':
background.c:57: `do_softirq_Rf0a529b7' undeclared (first use in \
                this function)
background.c:57: (Each undeclared identifier is reported only once
background.c:57: for each function it appears in.)
background.c: In function `jffs2_stop_garbage_collect_thread':
background.c:87: `do_softirq_Rf0a529b7' undeclared (first use in this \
                function)
background.c: In function `jffs2_garbage_collect_thread':
background.c:141: `do_softirq_Rf0a529b7' undeclared (first use in this \
                function)
make[2]: *** [background.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.5-ac21/fs/jffs2'
make[1]: *** [_modsubdir_jffs2] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.5-ac21/fs'
make: *** [_mod_fs] Error 2

-- 
Where there is a will, there is a way.       jinbo21@hananet.net
  For the future of you and me!              jinbo21@hitel.net
fingerprint = 1429 8AAF 8A2C 6043 DA2E  BD4C 964C 2698 687D 4B7D

