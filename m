Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313124AbSDDKVH>; Thu, 4 Apr 2002 05:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSDDKU5>; Thu, 4 Apr 2002 05:20:57 -0500
Received: from [195.63.194.11] ([195.63.194.11]:527 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313124AbSDDKUv>;
	Thu, 4 Apr 2002 05:20:51 -0500
Message-ID: <3CAC1A49.9040509@evision-ventures.com>
Date: Thu, 04 Apr 2002 11:18:01 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 patch] hdreg.h must include types.h
In-Reply-To: <Pine.NEB.4.44.0204040938300.7845-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Hi,
> 
> while compiling 2.5.7-dj3 I got the following compile error:
> 
> <--  snip  -->
> 
> ...
> gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.7/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -DKBUILD_BASENAME=ide_pnp
> -c -o ide-pnp.o ide-pnp.c
> In file included from /home/bunk/linux/kernel-2.5/linux-2.5.7/include/linux/ide.h:10,
>                  from ide-pnp.c:19:
> /home/bunk/linux/kernel-2.5/linux-2.5.7/include/linux/hdreg.h:71: parse
> error before `u8'
> 
> <--  snip  -->
> 
> The problem is that in 2.5.8-pre1 hdreg.h uses u8 but it doesn't include
> types.h. I didn't tried it but since the code is the same I expect the
> same problem in 2.5.8-pre1, too.
> 
> The fix is simple:
> 
> --- include/linux/hdreg.h.old	Thu Apr  4 09:33:48 2002
> +++ include/linux/hdreg.h	Thu Apr  4 09:34:44 2002
> @@ -1,6 +1,8 @@
>  #ifndef _LINUX_HDREG_H
>  #define _LINUX_HDREG_H
> 
> +#include <linux/types.h>
> +
>  /*
>   * This file contains some defines for the AT-hd-controller.
>   * Various sources.
> 
> cu
> Adrian
> 

The proper fix is to add linux/types.h in ide-pnp.c in front
of linux/hdreg.h inclusion. Nested includes are *nasty*.

