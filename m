Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314318AbSD0SBV>; Sat, 27 Apr 2002 14:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314321AbSD0SBV>; Sat, 27 Apr 2002 14:01:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:62715 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314318AbSD0SBU>; Sat, 27 Apr 2002 14:01:20 -0400
Date: Sat, 27 Apr 2002 19:57:28 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [patch stolen from -ac] fix IKCONFIG compile in 2.5.10-dj1 for
 non-modular kernels
Message-ID: <Pine.NEB.4.44.0204271950360.3103-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I got the following error when trying to compile kernel 2.5.10-dj1 with
CONFIG_IKCONFIG enabled and CONFIG_MODULES disabled:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.10/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6   -DEXPORT_SYMTAB -c
-o configs.o configs.c
In file included from configs.c:2:
/home/bunk/linux/kernel-2.5/linux-2.5.10/include/linux/module.h:21:
linux/modversions.h: No such file or directory
make[2]: *** [configs.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.10/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.10/kernel'
make: *** [_dir_kernel] Error 2

<--  snip  -->

A similar problem was in early -ac kernels and it seems the solution was
the following patch (this is btw the only difference between the
mkconfigs.c in 2.4.19-pre7-ac2 and 2.5.10-dj1):

--- linux.19pre3-ac2/scripts/mkconfigs.c	Fri Mar 15 22:34:00 2002
+++ linux.19pre3-ac4/scripts/mkconfigs.c	Wed Mar 20 15:47:46 2002
@@ -69,7 +69,7 @@
 void make_intro (FILE *sourcefile)
 {
 	fprintf (sourcefile, "#include <linux/init.h>\n");
-	fprintf (sourcefile, "#include <linux/module.h>\n");
+/////	fprintf (sourcefile, "#include <linux/module.h>\n");
 	fprintf (sourcefile, "\n");
 /////	fprintf (sourcefile, "char *configs[] __initdata = {\n");
 	fprintf (sourcefile, "static char __attribute__ ((unused)) *configs[] __initdata = {\n");

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

