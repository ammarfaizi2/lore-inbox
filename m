Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289559AbSBEO7q>; Tue, 5 Feb 2002 09:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289563AbSBEO7h>; Tue, 5 Feb 2002 09:59:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:63449 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S289559AbSBEO7R>; Tue, 5 Feb 2002 09:59:17 -0500
Date: Tue, 5 Feb 2002 15:56:32 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, Jan Yenya Kasprzak <kas@fi.muni.cz>
Subject: [patch] fix 2.4.18-pre8 compile error in cosa.c
Message-ID: <Pine.NEB.4.44.0202051546330.24218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch below fixes the following compile error in 2.4.18-pre8:

<--  snip  -->

gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6   -DKBUILD_BASENAME=cosa  -c -o cosa.o cosa.c
cosa.c:109: parse error

<--  snip  -->

Line 109 is
  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)

I was first thinking about including linux/version.h to fix it but since
in another place where there's in the cosa.c in kernel 2.2.20 a check for
2.2 kernels the code for the older kernels was already removed in the
cosa.c in kernel 2.4.18-pre8 I assume that it's no longer intended to use
this version of the file in 2.2 kernels.

--- drivers/net/wan/cosa.c.old	Tue Feb  5 15:37:20 2002
+++ drivers/net/wan/cosa.c	Tue Feb  5 15:47:37 2002
@@ -105,13 +105,6 @@
 #include <net/syncppp.h>
 #include "cosa.h"

-/* Linux version stuff */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-typedef struct wait_queue *wait_queue_head_t;
-#define DECLARE_WAITQUEUE(wait, current) \
-	struct wait_queue wait = { current, NULL }
-#endif
-
 /* Maximum length of the identification string. */
 #define COSA_MAX_ID_STRING	128


cu
Adrian



