Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbTCPLe7>; Sun, 16 Mar 2003 06:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbTCPLe7>; Sun, 16 Mar 2003 06:34:59 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37363 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262655AbTCPLe6>; Sun, 16 Mar 2003 06:34:58 -0500
Date: Sun, 16 Mar 2003 12:45:45 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.64-mm8: fs/affs/dir.c doesn't compile
Message-ID: <20030316114545.GJ24791@fs.tum.de>
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
> +affs-lock_kernel-fix.patch
> 
>  Missing an unlock_kernel().  (Why didn't any of the checkers notice this?)
>...

It seems noone tried to compile the patched file:

<--  snip  -->

...
  gcc -Wp,-MD,fs/affs/.dir.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -g -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=dir -DKBUILD_MODNAME=affs -c -o fs/affs/dir.o 
fs/affs/dir.c
fs/affs/dir.c: In function `affs_readdir':
fs/affs/dir.c:81: `ret' undeclared (first use in this function)
fs/affs/dir.c:81: (Each undeclared identifier is reported only once
fs/affs/dir.c:81: for each function it appears in.)
make[2]: *** [fs/affs/dir.o] Error 1

<--  snip  -->


The following patch solves it:


--- linux-2.5.64-mm8/fs/affs/dir.c.old	2003-03-16 12:39:54.000000000 +0100
+++ linux-2.5.64-mm8/fs/affs/dir.c	2003-03-16 12:43:30.000000000 +0100
@@ -78,7 +78,7 @@
 	if (f_pos == 0) {
 		filp->private_data = (void *)0;
 		if (filldir(dirent, ".", 1, f_pos, inode->i_ino, DT_DIR) < 0) {
-			ret = 0;
+			res = 0;
 			goto out;
 		}
 		filp->f_pos = f_pos = 1;




cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

