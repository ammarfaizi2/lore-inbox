Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316885AbSFQKQi>; Mon, 17 Jun 2002 06:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSFQKQh>; Mon, 17 Jun 2002 06:16:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:7642 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316885AbSFQKQf>; Mon, 17 Jun 2002 06:16:35 -0400
Date: Mon, 17 Jun 2002 12:16:33 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rogier Wolff <R.E.Wolff@bitwizard.nl>
Subject: [2.5 patch] drivers/char/rio/func.h needs linux/kdev_t.h
Message-ID: <Pine.NEB.4.44.0206171213370.1866-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while compiling 2.5.22 the compilation failed with the following error:

<--  snip  -->

...
  gcc -Wp,-MD,./.rioinit.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.22-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=rioinit   -c -o
rioinit.o rioinit.c
In file included from rioinit.c:68:
func.h:167: parse error before `device'
func.h:167: warning: function declaration isn't a prototype
func.h:168: parse error before `device'
func.h:168: warning: function declaration isn't a prototype
make[3]: *** [rioinit.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.22-full/drivers/char/rio'

<--  snip  -->


It seems func.h needs to inlude linux/kdev_t.h:


--- drivers/char/rio/func.h.old	Mon Jun 17 12:08:02 2002
+++ drivers/char/rio/func.h	Mon Jun 17 12:10:09 2002
@@ -33,6 +33,8 @@
 #ifndef __func_h_def
 #define __func_h_def

+#include <linux/kdev_t.h>
+
 #ifdef SCCS_LABELS
 #ifndef lint
 static char *_func_h_sccs_ = "@(#)func.h	1.3";


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

