Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317484AbSGJG3W>; Wed, 10 Jul 2002 02:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSGJG3V>; Wed, 10 Jul 2002 02:29:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:65520 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317484AbSGJG3U>; Wed, 10 Jul 2002 02:29:20 -0400
Date: Wed, 10 Jul 2002 08:32:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.25-dj1
In-Reply-To: <20020709004643.GA21880@suse.de>
Message-ID: <Pine.NEB.4.44.0207100820220.24665-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The -dj patch changes three occurances of minor in ixj.c to minor_no:


<--  snip  -->

...
-               printk("phone%d ioctl, cmd: 0x%x, arg: 0x%lx\n", minor, cmd, arg);
-       if (minor >= IXJMAX) {
-               clear_bit(board, &j->busyflags);
+               printk("phone%d ioctl, cmd: 0x%x, arg: 0x%lx\n", minor_no, cmd, arg);
+       if (minor_no >= IXJMAX) {
+               clear_bit(board, j->busyflags);
...
-               printk("phone%d ioctl end, cmd: 0x%x, arg: 0x%lx\n", minor, cmd, arg);
-       clear_bit(board, &j->busyflags);
+               printk("phone%d ioctl end, cmd: 0x%x, arg: 0x%lx\n", minor_no, cmd, arg);
+       clear_bit(board, j->busyflags);
...

<--  snip  -->


This causes the following compile error:


<--  snip  -->

...
  gcc -Wp,-MD,./.phonedev.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.25-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=phonedev   -c -o phonedev.o phonedev.c
  gcc -Wp,-MD,./.ixj.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.25-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=ixj   -c -o ixj.o ixj.c
ixj.c: In function `ixj_ioctl':
ixj.c:6220: `minor_no' undeclared (first use in this function)
ixj.c:6220: (Each undeclared identifier is reported only once
ixj.c:6220: for each function it appears in.)
ixj.c:6204: warning: unused variable `minor'
ixj.c: At top level:
ixj.c:794: warning: `ixj_register' defined but not used
ixj.c:849: warning: `ixj_unregister' defined but not used
make[2]: *** [ixj.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.25-full/drivers/telephony'

<--  snip  -->


After changing the three minor_no back to minor it compiles.


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

