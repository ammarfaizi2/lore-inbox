Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318854AbSHET4B>; Mon, 5 Aug 2002 15:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318855AbSHET4B>; Mon, 5 Aug 2002 15:56:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33489 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318854AbSHETz7>; Mon, 5 Aug 2002 15:55:59 -0400
Date: Mon, 5 Aug 2002 21:59:29 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-ac4
In-Reply-To: <200208051147.g75Blh720012@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0208052149400.27501-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Alan Cox wrote:

>...
> Linux 2.4.19-ac2
>...
> o	Fix __FUNCTION__ warnings in reiserfs		(me)
>...

The change to include/linux/reiserfs_fs.h broke the compilation of
fs/reiserfs/bitmap.c (args in RASSERT can be nonexistant):

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-modular/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -DMODVERSIONS
-include /home/bunk/linux/kernel-2.4/linux-2.4.19-modular/include/linux/modversions.h
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=bitmap  -c -o bitmap.o bitmap.c
bitmap.c: In function `reiserfs_free_block':
bitmap.c:132: parse error before `)'
bitmap.c:133: parse error before `)'
bitmap.c: In function `reiserfs_free_prealloc_block':
bitmap.c:142: parse error before `)'
bitmap.c:143: parse error before `)'
bitmap.c: In function `do_reiserfs_new_blocknrs':
bitmap.c:326: parse error before `)'
bitmap.c:341: parse error before `)'
bitmap.c:417: parse error before `)'
make[2]: *** [bitmap.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-modular/fs/reiserfs'

<--  snip  -->

cu
Adrian

