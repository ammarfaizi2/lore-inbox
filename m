Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTABPA0>; Thu, 2 Jan 2003 10:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbTABPA0>; Thu, 2 Jan 2003 10:00:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11973 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261963AbTABPAZ>; Thu, 2 Jan 2003 10:00:25 -0500
Date: Thu, 2 Jan 2003 16:08:40 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>, Christoph Hellwig <hch@lst.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, will@cs.earlham.edu
Subject: Re: Linux v2.5.54
Message-ID: <20030102150839.GN6114@fs.tum.de>
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 07:43:40PM -0800, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.53 to v2.5.54
> ============================================
>...
> Christoph Hellwig <hch@lst.de>:
>...
>   o include <linux/vfs.h> only in files actually needing it
>...

This change broke the compilation of fs/befs/linuxvfs.c:

<--  snip  -->

...
  gcc -Wp,-MD,fs/befs/.linuxvfs.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=linuxvfs -DKBUILD_MODNAME=befs   -c -o 
fs/befs/linuxvfs.o fs/befs/linuxvfs.c
fs/befs/linuxvfs.c:15: linux/statfs.h: No such file or directory
...
fs/befs/linuxvfs.c: In function `befs_statfs':
fs/befs/linuxvfs.c:901: dereferencing pointer to incomplete type
fs/befs/linuxvfs.c:902: dereferencing pointer to incomplete type
fs/befs/linuxvfs.c:903: dereferencing pointer to incomplete type
...
make[2]: *** [fs/befs/linuxvfs.o] Error 1
make[1]: *** [fs/befs] Error 2
make: *** [fs] Error 2

<--  snip  -->


I assume the following was intended?


--- linux-2.5.54/fs/befs/linuxvfs.c.old	2003-01-02 16:03:34.000000000 +0100
+++ linux-2.5.54/fs/befs/linuxvfs.c	2003-01-02 16:03:46.000000000 +0100
@@ -12,7 +12,7 @@
 #include <linux/stat.h>
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
-#include <linux/statfs.h>
+#include <linux/vfs.h>
 
 #include "befs.h"
 #include "btree.h"


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

