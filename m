Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310916AbSCSX54>; Tue, 19 Mar 2002 18:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSCSX5r>; Tue, 19 Mar 2002 18:57:47 -0500
Received: from air-2.osdl.org ([65.201.151.6]:16395 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S310916AbSCSX5f>;
	Tue, 19 Mar 2002 18:57:35 -0500
Date: Tue, 19 Mar 2002 15:56:36 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Adrian Bunk <bunk@fs.tum.de>, <davej@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19pre3-ac2
In-Reply-To: <Pine.NEB.4.44.0203191852570.3932-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33L2.0203191552030.8339-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Adrian Bunk wrote:

| On Tue, 19 Mar 2002, Alan Cox wrote:
|
| > Linux 2.4.19pre3-ac2
| >...
| > o	Add iconfig  (save/extract config from kernel	(Randy Dunlap)
| > 	image file)
| >...
|
| This sounds like a nice feature. Unfortunately it doesn't compile when you
| are building a kernel without module support (CONFIG_MODULES is not set):
|
| <--  snip  -->
|
| ...
| gcc -D__KERNEL__ -I/home/bunk/linux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -DEXPORT_SYMTAB -c -o configs.o configs.c
| In file included from configs.c:2:
| /home/bunk/linux/linux/include/linux/module.h:21: linux/modversions.h: No such file or directory
| make[2]: *** [configs.o] Error 1
| make[2]: Leaving directory `/home/bunk/linux/linux/kernel'
| make[1]: *** [first_rule] Error 2
| make[1]: Leaving directory `/home/bunk/linux/linux/kernel'
| make: *** [_dir_kernel] Error 2
|
| <--  snip  -->

Adrian-

Maybe you've already fixed it...
Anyway, here's a patch that fixes it.

Alan, Dave-
can you add "kernel/configs.c" to your "dontdiff" list?
Or is there another way that I should handle this generated file?

Thanks,
-- 
~Randy



--- linux/scripts/mkconfigs.c0	Tue Feb 19 00:29:36 2002
+++ linux/scripts/mkconfigs.c	Tue Mar 19 15:29:56 2002
@@ -67,7 +67,7 @@
 void make_intro (FILE *sourcefile)
 {
 	fprintf (sourcefile, "#include <linux/init.h>\n");
-	fprintf (sourcefile, "#include <linux/module.h>\n");
+/////	fprintf (sourcefile, "#include <linux/module.h>\n");
 	fprintf (sourcefile, "\n");
 /////	fprintf (sourcefile, "char *configs[] __initdata = {\n");
 	fprintf (sourcefile, "static char __attribute__ ((unused)) *configs[] __initdata = {\n");



### the end ###

