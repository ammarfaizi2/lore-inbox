Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317803AbSFSHUk>; Wed, 19 Jun 2002 03:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317804AbSFSHUj>; Wed, 19 Jun 2002 03:20:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:5865 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317803AbSFSHUi>; Wed, 19 Jun 2002 03:20:38 -0400
Date: Wed, 19 Jun 2002 09:20:36 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>, <willy@debian.org>,
       <urban@teststation.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] fs/smbfs/sock.c mut include linux/tqueue.h
Message-ID: <Pine.NEB.4.44.0206190914060.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 2.5.23 tq_struct moved from sched.h to tqueue.h. This caused the
following compile error:

<--  snip  -->

...
  gcc -Wp,-MD,./.sock.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.23-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer
 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include  -DSMBFS_PARANOIA  -DKBUILD_BASENAME=sock
-c -o sock.o sock.c
sock.c:87: field `cb' has incomplete type
sock.c: In function `smb_data_ready':
sock.c:173: warning: implicit declaration of function `schedule_task'
make[2]: *** [sock.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.23-full/fs/smbfs'

<--  snip  -->


The fix is simple:


--- fs/smbfs/sock.c.old	Wed Jun 19 09:14:25 2002
+++ fs/smbfs/sock.c	Wed Jun 19 09:14:53 2002
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/netdevice.h>
 #include <linux/smp_lock.h>
+#include <linux/tqueue.h>
 #include <net/scm.h>
 #include <net/ip.h>

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


