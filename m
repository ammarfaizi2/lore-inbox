Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311273AbSDDHoY>; Thu, 4 Apr 2002 02:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311403AbSDDHoO>; Thu, 4 Apr 2002 02:44:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:37619 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S311273AbSDDHoH>; Thu, 4 Apr 2002 02:44:07 -0500
Date: Thu, 4 Apr 2002 09:42:31 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] hdreg.h must include types.h
Message-ID: <Pine.NEB.4.44.0204040938300.7845-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while compiling 2.5.7-dj3 I got the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.7/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -DKBUILD_BASENAME=ide_pnp
-c -o ide-pnp.o ide-pnp.c
In file included from /home/bunk/linux/kernel-2.5/linux-2.5.7/include/linux/ide.h:10,
                 from ide-pnp.c:19:
/home/bunk/linux/kernel-2.5/linux-2.5.7/include/linux/hdreg.h:71: parse
error before `u8'

<--  snip  -->

The problem is that in 2.5.8-pre1 hdreg.h uses u8 but it doesn't include
types.h. I didn't tried it but since the code is the same I expect the
same problem in 2.5.8-pre1, too.

The fix is simple:

--- include/linux/hdreg.h.old	Thu Apr  4 09:33:48 2002
+++ include/linux/hdreg.h	Thu Apr  4 09:34:44 2002
@@ -1,6 +1,8 @@
 #ifndef _LINUX_HDREG_H
 #define _LINUX_HDREG_H

+#include <linux/types.h>
+
 /*
  * This file contains some defines for the AT-hd-controller.
  * Various sources.

cu
Adrian


