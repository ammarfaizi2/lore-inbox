Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSKZNwT>; Tue, 26 Nov 2002 08:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265974AbSKZNwT>; Tue, 26 Nov 2002 08:52:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54238 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265705AbSKZNwS>; Tue, 26 Nov 2002 08:52:18 -0500
Date: Tue, 26 Nov 2002 14:59:29 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.49-ac1
Message-ID: <20021126135929.GP24796@fs.tum.de>
References: <200211252352.gAPNqnt09081@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211252352.gAPNqnt09081@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 06:52:49PM -0500, Alan Cox wrote:

>...
> Linux 2.5.49-ac1
>...
> o	Remove dead swsuspend defines			(Geert Uytterhoeven)
>...

This broke the compilation of kernel/sys.c:

<--  snip  -->

...
  gcc -Wp,-MD,kernel/.sys.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -p -Iarch/i386/mach-generic
-Iarch/i386/mach-defaults -nostdinc -iwithprefix include
-DKBUILD_BASENAME=sys -DKBUILD_MODNAME=sys   -c -o kernel/sys.o
kernel/sys.c
kernel/sys.c: In function `sys_reboot':
kernel/sys.c:473: `software_suspend_enabled' undeclared (first use in
this function)
kernel/sys.c:473: (Each undeclared identifier is reported only once
kernel/sys.c:473: for each function it appears in.)
kernel/sys.c:477: warning: implicit declaration of function
`software_suspend'
make[1]: *** [kernel/sys.o] Error 1

<--  snip  -->

The fix is simple:

--- linux-2.5.49-ac/kernel/sys.c.old	2002-11-26 14:57:54.000000000 +0100
+++ linux-2.5.49-ac/kernel/sys.c	2002-11-26 14:58:14.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/unistd.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

