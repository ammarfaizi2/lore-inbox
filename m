Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVBYXFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVBYXFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVBYXE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:04:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34827 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262789AbVBYXCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:02:48 -0500
Date: Sat, 26 Feb 2005 00:02:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-ID: <20050225230246.GI3311@stusta.de>
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050225214326.GE3311@stusta.de> <20050225135504.7749942e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225135504.7749942e.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 01:55:04PM -0800, Andrew Morton wrote:
>...
> --- 25/include/linux/compiler.h~a	2005-02-25 13:53:32.000000000 -0800
> +++ 25-akpm/include/linux/compiler.h	2005-02-25 13:54:45.000000000 -0800
> @@ -86,6 +86,12 @@ extern void __chk_io_ptr(void __iomem *)
>  # define __deprecated		/* unimplemented */
>  #endif
>  
> +#ifdef MODULE
> +#define __deprecated_in_modules __deprecated
> +#else
> +#define __deprecated_in_modules /* OK in non-modular code */
> +#endif
> +
>...

Looks good.


One more question:

You get a false positive if the file containing the symbol is itself a 
module.

Is there any way to solve this without additional #define's and #ifdef's 
for each symbol?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

