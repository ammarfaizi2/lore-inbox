Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbTCZKs4>; Wed, 26 Mar 2003 05:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbTCZKs4>; Wed, 26 Mar 2003 05:48:56 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18883 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261627AbTCZKsy>; Wed, 26 Mar 2003 05:48:54 -0500
Date: Wed, 26 Mar 2003 12:00:01 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5 patch] fix sound/oss/mad16.c compile
Message-ID: <20030326110001.GJ24744@fs.tum.de>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 03:26:47PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.65 to v2.5.66
> ============================================
>...
> Dave Jones <davej@codemonkey.org.uk>:
>...
>   o guard mad16 debug macro
>...


This change broke the compilation of sound/oss/mad16.c:

<--  snip  -->

...
  gcc -Wp,-MD,sound/oss/.mad16.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=mad16 -DKBUILD_MODNAME=mad16 -c -o 
sound/oss/mad16.o sound/oss/mad16.c
...
sound/oss/mad16.c: In function `probe_mad16':
sound/oss/mad16.c:541: syntax error before "else"
sound/oss/mad16.c:604: syntax error before "else"
make[2]: *** [sound/oss/mad16.o] Error 1

<--  snip  -->


The following patch is needed:


--- linux-2.5.66-notfull/sound/oss/mad16.c.old	2003-03-26 11:52:13.000000000 +0100
+++ linux-2.5.66-notfull/sound/oss/mad16.c	2003-03-26 11:55:06.000000000 +0100
@@ -537,7 +537,7 @@
 
 	for (i = 0xf8d; i <= 0xf93; i++) {
 		if (!c924pnp)
-			DDB(printk("port %03x = %02x\n", i, mad_read(i)))
+			DDB(printk("port %03x = %02x\n", i, mad_read(i)));
 		else
 			DDB(printk("port %03x = %02x\n", i-0x80, mad_read(i)));
 	}
@@ -600,7 +600,7 @@
 
 	for (i = 0xf8d; i <= 0xf93; i++) {
 		if (!c924pnp)
-			DDB(printk("port %03x after init = %02x\n", i, mad_read(i)))
+			DDB(printk("port %03x after init = %02x\n", i, mad_read(i)));
 		else
 			DDB(printk("port %03x after init = %02x\n", i-0x80, mad_read(i)));
 	}


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

