Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbTIBQtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 12:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbTIBQtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:49:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26822 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264034AbTIBQtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:49:32 -0400
Date: Tue, 2 Sep 2003 18:49:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.23-pre2: 3c515.c doesn't compile non-modular
Message-ID: <20030902164917.GM23729@fs.tum.de>
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 12:48:22PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
> ============================================
>...
> Jeff Garzik:
>...
>   o [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe
>...

This change broke non-modular compile of 3c515.c ("debug" is declared 
inside an #ifdef MODULE):

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=3c515  -c -o 3c515.o 3c515.c
3c515.c: In function `netdev_get_msglevel':
3c515.c:1621: error: `debug' undeclared (first use in this function)
3c515.c:1621: error: (Each undeclared identifier is reported only once
3c515.c:1621: error: for each function it appears in.)
3c515.c: In function `netdev_set_msglevel':
3c515.c:1626: error: `debug' undeclared (first use in this function)
make[3]: *** [3c515.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/drivers/net'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Sat, Aug 30, 2003 at 12:48:22PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
> ============================================
>...
> Jeff Garzik:
>...
>   o [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe
>...

This change broke non-modular compile of 3c515.c ("debug" is declared 
inside an #ifdef MODULE):

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=3c515  -c -o 3c515.o 3c515.c
3c515.c: In function `netdev_get_msglevel':
3c515.c:1621: error: `debug' undeclared (first use in this function)
3c515.c:1621: error: (Each undeclared identifier is reported only once
3c515.c:1621: error: for each function it appears in.)
3c515.c: In function `netdev_set_msglevel':
3c515.c:1626: error: `debug' undeclared (first use in this function)
make[3]: *** [3c515.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/drivers/net'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

