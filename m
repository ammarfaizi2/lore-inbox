Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbSKRMb7>; Mon, 18 Nov 2002 07:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSKRMb7>; Mon, 18 Nov 2002 07:31:59 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55766 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262363AbSKRMam>; Mon, 18 Nov 2002 07:30:42 -0500
Date: Mon, 18 Nov 2002 13:37:39 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, bcollins@debian.org
Subject: Re: Linux v2.5.48
Message-ID: <20021118123738.GB5420@fs.tum.de>
References: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 08:41:05PM -0800, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.47 to v2.5.48
> ============================================
>...
> Alexander Viro <viro@math.psu.edu>:
>...
>   o dv1394 devfs use
>...

This patch broke the compilation of dv1394:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/ieee1394/.dv1394.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=dv1394 -DKBUILD_MODNAME=dv1394   -c -o
drivers/ieee1394/dv1394.o drivers/ieee1394/dv1394.c
drivers/ieee1394/dv1394.c:2586: parse error before `return'
make[2]: *** [drivers/ieee1394/dv1394.o] Error 1

<--  snip  -->

The fix is trivial:

--- linux-2.5.48/drivers/ieee1394/dv1394.c.old	2002-11-18 13:32:02.000000000 +0100
+++ linux-2.5.48/drivers/ieee1394/dv1394.c	2002-11-18 13:35:55.000000000 +0100
@@ -2579,7 +2579,7 @@
 
 static int dv1394_devfs_add_dir(char *name)
 {
-	if (!devfs_mk_dir(NULL, name, NULL))
+	if (!devfs_mk_dir(NULL, name, NULL)) {
 		printk(KERN_ERR "dv1394: unable to create /dev/%s\n", name);
 		return -ENOMEM;
 	}


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

