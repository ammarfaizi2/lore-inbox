Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSEHVre>; Wed, 8 May 2002 17:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315296AbSEHVrd>; Wed, 8 May 2002 17:47:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:65266 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315293AbSEHVrd>; Wed, 8 May 2002 17:47:33 -0400
Date: Wed, 8 May 2002 23:42:37 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-dev@micro-solutions.com, <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: [patch] remove an unused variable from bpck6.c
Message-ID: <Pine.NEB.4.44.0205082338100.19321-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

compiling bpck6.c gives the following warning:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/i
nclude -DKBUILD_BASENAME=bpck6  -c -o bpck6.o bpck6.c
bpck6.c: In function `bpck6_init_proto':
bpck6.c:228: warning: unused variable `i'
...

<--  snip  -->

And the compiler is right, this variable isn't used anywhere. The
following patch (made against 2.4.19-pre8-ac1 but it applies to all 2.4
and 2.5 kernels) removes this variable:

--- drivers/block/paride/bpck6.c.old	Wed May  8 23:40:18 2002
+++ drivers/block/paride/bpck6.c	Wed May  8 23:41:21 2002
@@ -225,8 +225,6 @@

 static void bpck6_init_proto(PIA *pi)
 {
-	int i;
-
 	/* allocate a state structure for this item */
 	pi->privptr=kmalloc(sizeof(PPC_STORAGE),GFP_KERNEL);


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


