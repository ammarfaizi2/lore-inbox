Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbSLKBGx>; Tue, 10 Dec 2002 20:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSLKBGx>; Tue, 10 Dec 2002 20:06:53 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62436 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266955AbSLKBGw>; Tue, 10 Dec 2002 20:06:52 -0500
Date: Wed, 11 Dec 2002 02:14:35 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre1
Message-ID: <20021211011435.GP17522@fs.tum.de>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 06:37:14PM -0200, Marcelo Tosatti wrote:

> So here goes the first pre of 2.4.21 including the new IDE code merged
> from Alan's tree.
> 
> Test it carefully, since the new IDE code is not yet fully tested.
> 
> Do not use it with critical data.
> 
> Summary of changes from v2.4.20 to v2.4.21-pre1
> ============================================
>...
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>...
>   o ac IDE merge
>...

The ac IDE merge broke the compilation of hd.c (it was already broken in 
ac):

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.20/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -I../ 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=hd  -c -o hd.o hd.c
hd.c:78: conflicting types for `recal_intr'
/home/bunk/linux/kernel-2.4/linux-2.4.20/include/linux/ide.h:1487: 
previous declaration of `recal_intr'
hd.c: In function `dump_status':
hd.c:171: `QUEUE_EMPTY' undeclared (first use in this function)
hd.c:171: (Each undeclared identifier is reported only once
hd.c:171: for each function it appears in.)
hd.c:171: `CURRENT' undeclared (first use in this function)
hd.c:169: warning: `devc' might be used uninitialized in this function
hd.c: In function `hd_out':
hd.c:284: `DEVICE_INTR' undeclared (first use in this function)
hd.c:284: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c: In function `do_reset_hd':
...
make[4]: *** [hd.o] Error 1
make[4]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.20/drivers/ide/legacy'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

