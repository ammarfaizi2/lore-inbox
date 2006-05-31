Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWEaQ6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWEaQ6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWEaQ6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:58:09 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:48397 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751290AbWEaQ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:58:08 -0400
Message-ID: <447DCB05.5040002@shadowen.org>
Date: Wed, 31 May 2006 17:57:41 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Chad Reese <creese@caviumnetworks.com>
Subject: Re: [PATCH] Sparsemem build fix.
References: <20060531132750.GA9504@linux-mips.org>
In-Reply-To: <20060531132750.GA9504@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> <linux/mmzone.h> uses PAGE_SIZE, PAGE_SHIFT from <asm/page.h> without
> including that header itself.  For some sparsemem configurations this
> may result in build errors like:
> 
>   CC      init/initramfs.o
> In file included from include/linux/gfp.h:4,
>                  from include/linux/slab.h:15,
>                  from include/linux/percpu.h:4,
>                  from include/linux/rcupdate.h:41,
>                  from include/linux/dcache.h:10,
>                  from include/linux/fs.h:226,
>                  from init/initramfs.c:2:
> include/linux/mmzone.h:498:22: warning: "PAGE_SHIFT" is not defined
> In file included from include/linux/gfp.h:4,
>                  from include/linux/slab.h:15,
>                  from include/linux/percpu.h:4,
>                  from include/linux/rcupdate.h:41,
>                  from include/linux/dcache.h:10,
>                  from include/linux/fs.h:226,
>                  from init/initramfs.c:2:
> include/linux/mmzone.h:526: error: `PAGE_SIZE' undeclared here (not in a function)
> include/linux/mmzone.h: In function `__pfn_to_section':
> include/linux/mmzone.h:573: error: `PAGE_SHIFT' undeclared (first use in this function)
> include/linux/mmzone.h:573: error: (Each undeclared identifier is reported only once
> include/linux/mmzone.h:573: error: for each function it appears in.)
> include/linux/mmzone.h: In function `pfn_valid':
> include/linux/mmzone.h:578: error: `PAGE_SHIFT' undeclared (first use in this function)
> make[1]: *** [init/initramfs.o] Error 1
> make: *** [init] Error 2
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 3674035..2d83371 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -15,6 +15,7 @@ #include <linux/init.h>
>  #include <linux/seqlock.h>
>  #include <linux/nodemask.h>
>  #include <asm/atomic.h>
> +#include <asm/page.h>
>  
>  /* Free memory management - zoned buddy allocator.  */
>  #ifndef CONFIG_FORCE_MAX_ZONEORDER
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Seems completely reasonable.

-apw
