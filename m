Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSIJWgU>; Tue, 10 Sep 2002 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSIJWgU>; Tue, 10 Sep 2002 18:36:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31987 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318190AbSIJWgT>; Tue, 10 Sep 2002 18:36:19 -0400
Date: Wed, 11 Sep 2002 00:40:59 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6
In-Reply-To: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0209102322290.18902-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Marcelo Tosatti wrote:

>...
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>...
>   o more irda __FUNCTION__ stuff
>...

This adds the use of TIOCM_MODEM_BITS to irtty.c but not the corresponding
addition of it to asm-i386/termios.h:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc
-iwithprefix include -DKBUILD_BASENAME=irtty  -c -o irtty.o irtty.c
irtty.c: In function `irtty_set_dtr_rts':
irtty.c:761: `TIOCM_MODEM_BITS' undeclared (first use in this function)
irtty.c:761: (Each undeclared identifier is reported only once
irtty.c:761: for each function it appears in.)
make[4]: *** [irtty.o] Error 1
make[4]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/net/irda'

<--  snip  -->


The following part of -ac is also needed:


--- linux.20pre5/include/asm-i386/termios.h	2002-08-29 18:39:31.000000000 +0100
+++ linux.20pre5-ac4/include/asm-i386/termios.h	2002-08-06 15:41:52.000000000 +0100
@@ -37,6 +37,8 @@
 #define TIOCM_OUT2	0x4000
 #define TIOCM_LOOP	0x8000

+#define TIOCM_MODEM_BITS       TIOCM_OUT2      /* IRDA support */
+
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */

 /* line disciplines */


cu
Adrian


