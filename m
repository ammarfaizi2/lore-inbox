Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSH1Qvq>; Wed, 28 Aug 2002 12:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSH1Qvp>; Wed, 28 Aug 2002 12:51:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35063 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313060AbSH1Qvo>; Wed, 28 Aug 2002 12:51:44 -0400
Date: Wed, 28 Aug 2002 18:55:59 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: paulsch@us.ibm.com, <sullivam@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] tp3780i.c must include sched.h
Message-ID: <Pine.NEB.4.44.0208281846130.2879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's the following compile error in kernel 2.5.32 (caused by Ingo's
recent changes to ptrace.h):

<--  snip  -->

...
  gcc -Wp,-MD,./.tp3780i.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.
5.32-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include  -DMW_TRACE  -DKBUILD_BASENAME=tp3780i
-c -o tp3780i.o tp3780i.c
In file included from tp3780i.c:51:
/home/bunk/linux/kernel-2.5/linux-2.5.32-full/include/linux/ptrace.h:28:
warning
: `struct task_struct' declared inside parameter list
/home/bunk/linux/kernel-2.5/linux-2.5.32-full/include/linux/ptrace.h:28:
warning
: its scope is only this definition or declaration, which is probably not
what you want.
...
make[3]: *** [tp3780i.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.32-full/drivers/char/mwave'

<--  snip  -->


The following fixes it:


--- drivers/char/mwave/tp3780i.c.old	2002-08-28 17:56:24.000000000 +0200
+++ drivers/char/mwave/tp3780i.c	2002-08-28 17:58:10.000000000 +0200
@@ -48,6 +48,7 @@

 #include <linux/version.h>
 #include <linux/kernel.h>
+#include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <linux/ioport.h>
 #include <asm/io.h>


cu
Adrian


