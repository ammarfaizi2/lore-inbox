Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSFSVb5>; Wed, 19 Jun 2002 17:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSFSVb4>; Wed, 19 Jun 2002 17:31:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:38100 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318017AbSFSVb4>; Wed, 19 Jun 2002 17:31:56 -0400
Date: Wed, 19 Jun 2002 23:31:50 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>, <greg@kroah.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] drivers/hotplug/cpqphp.h must include tqueue.h
Message-ID: <Pine.NEB.4.44.0206192327530.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

another tqueue.h compile problem: It's needed in drivers/hotplug/cpqphp.h,
otherwise compilation fails:

<--  snip  -->

...
  gcc -Wp,-MD,./.cpqphp_core.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=cpqphp_core   -c -o
cpqphp_core.o cpqphp_core.c
In file included from cpqphp_core.c:39:
cpqphp.h:322: field `int_task_event' has incomplete type
make[2]: *** [cpqphp_core.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.23/drivers/hotplug'

<--  snip  -->



--- drivers/hotplug/cpqphp.h.old	Wed Jun 19 23:19:02 2002
+++ drivers/hotplug/cpqphp.h	Wed Jun 19 23:20:15 2002
@@ -29,6 +29,7 @@
 #define _CPQPHP_H

 #include "pci_hotplug.h"
+#include <linux/tqueue.h>
 #include <asm/io.h>		/* for read? and write? functions */


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

