Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUFUQvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUFUQvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 12:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266321AbUFUQvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 12:51:08 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:5650 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S265773AbUFUQvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 12:51:04 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Mon, 21 Jun 2004 18:50:46 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Cannot compile linux-2.4.27-rc1 ... ipt_REJECT.c
In-Reply-To: <16598.56442.254480.281844@alkaid.it.uu.se>
Message-ID: <Pine.OSF.4.51.0406211848480.202417@tao.natur.cuni.cz>
References: <Pine.OSF.4.51.0406211343160.157782@tao.natur.cuni.cz>
 <16598.56442.254480.281844@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004, Mikael Pettersson wrote:

> Martin MOKREJ? writes:
>  > Hi,
>  >   has someone seen the following error? I can provide .config if required.
>  > I think I've seen this in 2.4.27-pre6, not in -pre3.
>  > Please Cc: me in replies. Thanks.
>  > Martin
>  >
>  > gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.27-rc1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ipt_REJECT  -c -o ipt_REJECT.o ipt_REJECT.c
>  > In file included from ipt_REJECT.c:8:
>  > /usr/src/linux-2.4.27-rc1/include/linux/skbuff.h: In function `kmap_skb_frag':
>  > /usr/src/linux-2.4.27-rc1/include/linux/skbuff.h:1121: warning: use of compound expressions as lvalues is deprecated
> ...
>  > $ gcc --version
>  > gcc (GCC) 3.4.0 20040601 (Gentoo Linux 3.4.0-r6, ssp-3.4-2, pie-8.7.6.3)
>
> For this error you need to apply
> <http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-rc1>.
>
> If you're using ACPI you should also apply
> <http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-mpparse-fix-2.4.27-rc1>.


Great, only 2 problems left:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -fno-unit-at-a-time   -nostdinc -iwithprefix include -DKBUILD_BASENAME=vt  -c -o vt.o vt.c
vt.c: In function `do_kdsk_ioctl':
vt.c:166: warning: comparison is always false due to limited range of data type
vt.c: In function `do_kdgkb_ioctl':
vt.c:283: warning: comparison is always false due to limited range of data type

<cut>

gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -fno-unit-at-a-time   -nostdinc -iwithprefix include -DKBUILD_BASENAME=highmem  -c -o highmem.o highmem.c
highmem.c:133: error: conflicting types for 'kmap_high'
/usr/src/linux-2.4.27-rc1/include/asm/highmem.h:59: error: previous declaration of 'kmap_high' was here
highmem.c:133: error: conflicting types for 'kmap_high'
/usr/src/linux-2.4.27-rc1/include/asm/highmem.h:59: error: previous declaration of 'kmap_high' was here
highmem.c:158: error: conflicting types for 'kunmap_high'
/usr/src/linux-2.4.27-rc1/include/asm/highmem.h:60: error: previous declaration of 'kunmap_high' was here
highmem.c:158: error: conflicting types for 'kunmap_high'
/usr/src/linux-2.4.27-rc1/include/asm/highmem.h:60: error: previous declaration of 'kunmap_high' was here
make[2]: *** [highmem.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.27-rc1/mm'

-- 
Martin Mokrejs
GPG key is at http://www.natur.cuni.cz/~mmokrejs
