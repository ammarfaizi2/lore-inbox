Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318198AbSIJWqt>; Tue, 10 Sep 2002 18:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318202AbSIJWqt>; Tue, 10 Sep 2002 18:46:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25331 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318198AbSIJWqs>; Tue, 10 Sep 2002 18:46:48 -0400
Date: Wed, 11 Sep 2002 00:51:28 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <hch@lst.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre5
In-Reply-To: <Pine.LNX.4.44.0208281946150.5234-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0209110048250.26432-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002, Marcelo Tosatti wrote:

>...
> <hch@lst.de>:
>   o Merge ETHTOOL_GDRVINFO support for several pcmcia net drivers
>...

This change broke the compilation of wavelan_cs.c. The following error is
still present in -pre6:

<--  snip  -->

...
gcc -D__KERNEL__
-I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include -Wall -
Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=wavelan_cs  -c -o wavelan_cs.o wavelan_cs.c
In file included from wavelan_cs.c:66:
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/ethtool.h:18:
parse error before `u32'
...
make[4]: *** [wavelan_cs.o] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/net/pcmcia'

<--  snip  -->


The following patch (stolen from -ac) fixes it:


--- linux.20pre5/drivers/net/pcmcia/wavelan_cs.c	2002-08-29 18:39:55.000000000 +0100
+++ linux.20pre5-ac4/drivers/net/pcmcia/wavelan_cs.c	2002-08-30 13:45:09.000000000 +0100
@@ -63,6 +63,7 @@
  *
  */

+#include <linux/types.h>
 #include <linux/ethtool.h>
 #include <asm/uaccess.h>
 #include "wavelan_cs.h"		/* Private header */


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

