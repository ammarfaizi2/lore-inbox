Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316391AbSEZVGc>; Sun, 26 May 2002 17:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316439AbSEZVGb>; Sun, 26 May 2002 17:06:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:14550 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316391AbSEZVG3>; Sun, 26 May 2002 17:06:29 -0400
Date: Sun, 26 May 2002 23:06:14 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] ide-tape.c must include buffer_head.h
Message-ID: <Pine.NEB.4.44.0205262258180.20535-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

after your removal of #include <linux/buffer_head.h> from fs.h ide-tape.c
no longer compiles:

<--  snip  -->

...
gcc -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.18-modular/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -DMODVERSIONS
-include /home/bunk/linux/kernel-2.5/linux-2.5.18-modular/include/linux/modversions.h
-DKBUILD_BASENAME=ide_tape  -c -o ide-tape.o ide-tape.c
ide-tape.c: In function `__idetape_kmalloc_stage':
ide-tape.c:2810: `BH_Lock' undeclared (first use in this function)
ide-tape.c:2810: (Each undeclared identifier is reported only once
ide-tape.c:2810: for each function it appears in.)
...

<--  snip  -->


The following patch (made against 2.5.18-dj1 but it should apply cleanly
against 2.5.18) fixes it (I wasn't able to find an obvious ordering of the
"#include <linux/*>" so I placed it at the end):


--- drivers/ide/ide-tape.c.old	Sun May 26 22:55:56 2002
+++ drivers/ide/ide-tape.c	Sun May 26 22:56:42 2002
@@ -417,6 +417,7 @@
 #include <linux/completion.h>
 #include <linux/ide.h>
 #include <linux/atapi.h>
+#include <linux/buffer_head.h>

 #include <asm/byteorder.h>
 #include <asm/irq.h>


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


