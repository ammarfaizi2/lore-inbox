Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317867AbSFSMYF>; Wed, 19 Jun 2002 08:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317868AbSFSMYE>; Wed, 19 Jun 2002 08:24:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:20194 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317867AbSFSMYD>; Wed, 19 Jun 2002 08:24:03 -0400
Date: Wed, 19 Jun 2002 14:24:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>, <ecd@atecom.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] drivers/atm/idt77252.h needs linux/tqueue.h
Message-ID: <Pine.NEB.4.44.0206191421240.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 2.5.23 tq_struct moved from sched.h to tqueue.h. This caused the
following compile error:

<--  snip  -->

...
  gcc -Wp,-MD,./.idt77252.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2
.5.23-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-poi
nter -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=
k6 -nostdinc -iwithprefix include  -g  -DKBUILD_BASENAME=idt77252   -c -o
idt772
52.o idt77252.c
In file included from idt77252.c:60:
idt77252.h:367: field `tqueue' has incomplete type
idt77252.c: In function `alloc_scq':
...
idt77252.c:2899: warning: implicit declaration of function `queue_task'
idt77252.c:2899: `tq_immediate' undeclared (first use in this function)
idt77252.c:2899: (Each undeclared identifier is reported only once
idt77252.c:2899: for each function it appears in.)
make[2]: *** [idt77252.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.23-full/driver
s/atm'

<--  snip  -->


The fix is simple:


--- drivers/atm/idt77252.h.old	Wed Jun 19 14:13:25 2002
+++ drivers/atm/idt77252.h	Wed Jun 19 14:14:21 2002
@@ -36,6 +36,7 @@

 #include <linux/ptrace.h>
 #include <linux/skbuff.h>
+#include <linux/tqueue.h>


 /*****************************************************************************/

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


