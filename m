Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312634AbSEDMeR>; Sat, 4 May 2002 08:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312691AbSEDMeQ>; Sat, 4 May 2002 08:34:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:56795 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312634AbSEDMeP>; Sat, 4 May 2002 08:34:15 -0400
Date: Sat, 4 May 2002 14:29:44 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>, NeilBrown <neilb@cse.unsw.edu.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.13-dj1
In-Reply-To: <20020503185811.GA4846@suse.de>
Message-ID: <Pine.NEB.4.44.0205041424390.283-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Dave Jones wrote:

>...
> 2.5.13-dj1
> o   Merge 2.4.19pre7 & pre8
>...

Just FYI:
drivers/block/umem.c that comes from 2.4 doesn't compile:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.13/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=umem  -c -o
umem.o umem.c
umem.c:170: unknown field `max_p' specified in initializer
umem.c:170: warning: initialization makes pointer from integer without a
cast
umem.c: In function `add_bh':
umem.c:413: structure has no member named `b_reqnext'
umem.c:416: structure has no member named `b_rdev'
umem.c:427: structure has no member named `b_reqnext'
umem.c:428: structure has no member named `b_reqnext'
umem.c:433: structure has no member named `b_rsector'
umem.c:404: warning: `rw' might be used uninitialized in this function
umem.c: In function `process_page':
umem.c:480: structure has no member named `b_reqnext'
umem.c:487: structure has no member named `b_reqnext'
umem.c:491: structure has no member named `b_reqnext'
umem.c:494: structure has no member named `b_rsector'
umem.c:521: structure has no member named `b_reqnext'
umem.c:522: structure has no member named `b_reqnext'
umem.c:527: structure has no member named `b_reqnext'
umem.c:528: structure has no member named `b_reqnext'
umem.c: In function `mm_make_request':
umem.c:541: structure has no member named `b_rdev'
umem.c:543: structure has no member named `b_rsector'
umem.c:543: structure has no member named `b_rdev'
umem.c:544: structure has no member named `b_rdev'
umem.c:548: structure has no member named `b_reqnext'
umem.c:549: structure has no member named `b_reqnext'
umem.c: In function `mm_revalidate':
umem.c:809: incompatible type for argument 1 of `grok_partitions'
umem.c:809: too many arguments to function `grok_partitions'
umem.c: In function `mm_ioctl':
umem.c:823: wrong type argument to unary exclamation mark
umem.c:845: `read_ahead' undeclared (first use in this function)
umem.c:845: (Each undeclared identifier is reported only once
umem.c:845: for each function it appears in.)
umem.c:845: invalid operands to binary >>
umem.c:845: invalid operands to binary >>
umem.c:851: invalid operands to binary >>
umem.c:877: incompatible type for argument 1 of `blk_ioctl'
umem.c: In function `mm_end_buffer_io_sync':
umem.c:947: warning: implicit declaration of function
`mark_buffer_uptodate'
umem.c: In function `mm_init_mem':
umem.c:976: `bh_cachep' undeclared (first use in this function)
umem.c:979: structure has no member named `b_next'
umem.c:985: structure has no member named `b_dev'
umem.c:985: structure has no member named `b_rdev'
umem.c:987: structure has no member named `b_wait'
umem.c:1003: structure has no member named `b_next'
umem.c:1007: structure has no member named `b_next'
umem.c:1012: structure has no member named `b_next'
umem.c:1015: structure has no member named `b_rsector'
umem.c:1019: structure has no member named `b_next'
umem.c:1024: structure has no member named `b_next'
umem.c:1026: structure has no member named `b_next'
umem.c:1035: structure has no member named `b_next'
umem.c: In function `mm_init':
umem.c:1355: `read_ahead' undeclared (first use in this function)
umem.c:1373: `gendisk_head' undeclared (first use in this function)
umem.c:1377: warning: passing arg 2 of `blk_queue_make_request' from
incompatible pointer type
umem.c:1384: `hardsect_size' undeclared (first use in this function)
umem.c:1385: `blksize_size' undeclared (first use in this function)
umem.c: In function `mm_cleanup':
umem.c:1420: `hardsect_size' undeclared (first use in this function)
umem.c:1421: `blksize_size' undeclared (first use in this function)
umem.c:1422: `read_ahead' undeclared (first use in this function)
make[3]: *** [umem.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.13/drivers/block'

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



