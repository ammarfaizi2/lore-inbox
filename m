Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbTCPNdJ>; Sun, 16 Mar 2003 08:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbTCPNdJ>; Sun, 16 Mar 2003 08:33:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44017 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262663AbTCPNdI>; Sun, 16 Mar 2003 08:33:08 -0500
Date: Sun, 16 Mar 2003 14:43:53 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.64-mm8: miropcm20-rds.c doesn't compile
Message-ID: <20030316134353.GM24791@fs.tum.de>
References: <20030316024239.484f8bda.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316024239.484f8bda.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 02:42:39AM -0800, Andrew Morton wrote:
>...
> All 124 patches:
> 
> linus.patch
>   Latest from Linus
>...

Another compile error that seems to come from Linus' tree:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/media/radio/.miropcm20-rds.o.d -D__KERNEL__ 
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=k6 -Iinclude/asm-i386/mach-default -g -nostdinc -iwithprefix include    -DKBUILD_BASENAME=miropcm20_rds 
-DKBUILD_MODNAME=miropcm20_rds -c -o drivers/media/radio/miropcm20-rds.o 
drivers/media/radio/miropcm20-rds.c
drivers/media/radio/miropcm20-rds.c:117: request for member `fops' in something not a structure or union
drivers/media/radio/miropcm20-rds.c:117: initializer element is not constant
drivers/media/radio/miropcm20-rds.c:117: (near initialization for `rds_miscdev.name')
drivers/media/radio/miropcm20-rds.c: In function `miropcm20_rds_init':
drivers/media/radio/miropcm20-rds.c:133: parse error before `return'
drivers/media/radio/miropcm20-rds.c: In function `miropcm20_rds_cleanup':
drivers/media/radio/miropcm20-rds.c:140: parse error before `}'
drivers/media/radio/miropcm20-rds.c:145: parse error at end of input
drivers/media/radio/miropcm20-rds.c:121: warning: `miropcm20_rds_init' defined but not used
make[3]: *** [drivers/media/radio/miropcm20-rds.o] Error 1

<--  snip  -->


It would be nice if everyone would try to compile the patched files
before submitting patches...


Below are the trivial fixes:


--- linux-2.5.64-mm8/drivers/media/radio/miropcm20-rds.c.old	2003-03-16 14:34:17.000000000 +0100
+++ linux-2.5.64-mm8/drivers/media/radio/miropcm20-rds.c	2003-03-16 14:35:05.000000000 +0100
@@ -113,7 +113,7 @@
 
 static struct miscdevice rds_miscdev = {
 	.minor		= MISC_DYNAMIC_MINOR,
-	.name		= "radiotext"
+	.name		= "radiotext",
 	.fops		= &rds_fops,
 };
 
@@ -128,7 +128,7 @@
 	error = devfs_mk_symlink(NULL, "v4l/rds/radiotext", 0,
 				 "../misc/radiotext", NULL, NULL);
 	if (error)
-		misc_deregister(&rds_miscdev)
+		misc_deregister(&rds_miscdev);
 
 	return error;
 }
@@ -136,7 +136,7 @@
 static void __exit miropcm20_rds_cleanup(void)
 {
 	devfs_remove("v4l/rds/radiotext");
-	misc_deregister(&rds_miscdev)
+	misc_deregister(&rds_miscdev);
 }
 
 module_init(miropcm20_rds_init);



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

