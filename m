Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271635AbRHPUwX>; Thu, 16 Aug 2001 16:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271636AbRHPUwN>; Thu, 16 Aug 2001 16:52:13 -0400
Received: from port488.ds1-ynoe.adsl.cybercity.dk ([217.157.176.117]:23363
	"EHLO athena.colding.adsl.dk") by vger.kernel.org with ESMTP
	id <S271635AbRHPUv6>; Thu, 16 Aug 2001 16:51:58 -0400
Date: Thu, 16 Aug 2001 22:48:30 +0200 (CEST)
From: Jules Colding <dsl11814@vip.cybercity.dk>
X-X-Sender: <jules@athena.colding.adsl.dk>
Reply-To: Jules Colding <dsl11814@vip.cybercity.dk>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] NTFS compile fix
Message-ID: <Pine.LNX.4.33.0108162217001.1870-100000@athena.colding.adsl.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.9 says:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686  -DNTFS_VERSION=\"1.1.16\"   -c -o unistr.o unistr.c
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[3]: *** [unistr.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.9/fs/ntfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.9/fs/ntfs'
make[1]: *** [_subdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/fs'
make: *** [_dir_fs] Error 2


This fixes it:

--- fs/ntfs/unistr.c.orig	Thu Aug 16 22:28:07 2001
+++ fs/ntfs/unistr.c	Thu Aug 16 22:28:28 2001
@@ -23,6 +23,7 @@

 #include <linux/string.h>
 #include <asm/byteorder.h>
+#include <linux/kernel.h>

 #include "unistr.h"
 #include "macros.h"



- jules



