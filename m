Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSFENTV>; Wed, 5 Jun 2002 09:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSFENTU>; Wed, 5 Jun 2002 09:19:20 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:54160 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S315413AbSFENTU>; Wed, 5 Jun 2002 09:19:20 -0400
Date: Wed, 5 Jun 2002 15:19:09 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, release 3.0 is available
Message-ID: <20020605131909.GC29455@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020604091646.GB29455@riesen-pc.gr05.synopsys.com> <17931.1023231335@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 08:55:35AM +1000, Keith Owens wrote:
> On Tue, 4 Jun 2002 11:16:46 +0200, 
> Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
> >Got this trying to compile 2.5.20 with Debian's gcc 2.95.4.
> >Why it took the system-wide zlib.h?
> >In file included from /export/home/riesen-pc0/riesen/compile/v2.5/fs/isofs/compress.c:38:
> >include/linux/zlib.h:34: zconf.h: No such file or directory
> 
> In order to do separate source and object correctly, kbuild 2.5
> enforces the rule that #include "" comes from the local directory,
> #include <> comes from the include path.  include/linux/zlib.h
> incorrectly does #include "zconf.h" instead of #include <linux/zconf.h>,
> breaking the rules.
> 
> This was not detected by common-2.5.20-1 because the nostdinc check was
> incomplete, common-2.5.20-2 does nostdinc correctly.  I avoid changing
> the source code for kbuild 2.5, instead I workaround these incorrect
> includes by adding extra_cflags() with FIXME comments to correct the
> code later.  I will do a common-2.5.20-3 to workaround zlib.h, in the
> meantime try this quick and dirty fix

Sorry for delay. The patch fixed things, indeed.
And i personally prefer the way you did it here
much more to any workarounds.

> --- 2.5.20-pristine/include/linux/zlib.h	Mon Apr 15 05:18:43 2002
> +++ 2.5.20-kbuild-2.5/include/linux/zlib.h	Tue Jun  4 11:03:05 2002
> @@ -31,7 +31,7 @@
>  #ifndef _ZLIB_H
>  #define _ZLIB_H
>  
> -#include "zconf.h"
> +#include <linux/zconf.h>
>  
>  #ifdef __cplusplus
>  extern "C" {
> 
