Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTAaULt>; Fri, 31 Jan 2003 15:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTAaULs>; Fri, 31 Jan 2003 15:11:48 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62963 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262224AbTAaULq>; Fri, 31 Jan 2003 15:11:46 -0500
Date: Fri, 31 Jan 2003 21:21:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre4-ac1
Message-ID: <20030131202105.GF21599@fs.tum.de>
References: <200301311430.h0VEUKr31316@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301311430.h0VEUKr31316@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 09:30:20AM -0500, Alan Cox wrote:

>...
> Linux 2.4.21pre4-ac1
>...
> o	Clean up radio_cadet locking and other bugs	(me)
>...

This causes the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=radio_cadet  -c -o radio-cadet.o 
radio-cadet.c
radio-cadet.c: In function `cadet_init':
radio-cadet.c:561: `cadet_lock' undeclared (first use in this function)
radio-cadet.c:561: (Each undeclared identifier is reported only once
radio-cadet.c:561: for each function it appears in.)
make[4]: *** [radio-cadet.o] Error 1
make[4]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/drivers/media/radio'

<--  snip  -->

It seems the following was intended?

--- linux-2.4.20-ac/drivers/media/radio/radio-cadet.c.old	2003-01-31 21:04:17.000000000 +0100
+++ linux-2.4.20-ac/drivers/media/radio/radio-cadet.c	2003-01-31 21:04:34.000000000 +0100
@@ -558,7 +558,7 @@
 static int __init cadet_init(void)
 {
 
-	spin_lock_init(&cadet_lock);
+	spin_lock_init(&cadet_io_lock);
 	
 	/*
 	 *	If a probe was requested then probe ISAPnP first (safest)



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

