Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbTF0Wfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbTF0Wfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:35:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51939 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264868AbTF0WfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:35:01 -0400
Date: Sat, 28 Jun 2003 00:49:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: compat_sys_old_getrlimit() depends on sys_old_getrlimit()
Message-ID: <20030627224905.GL24661@fs.tum.de>
References: <200306240001.h5O01IjH011137@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306240001.h5O01IjH011137@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 05:01:18PM -0700, David Mosberger wrote:
> compat_sys_old_getrlimit() depends on sys_old_getrlimit() and the patch
> below updates the guarding #ifdef accordingly.
> 
> 	--david
> 
> ===== kernel/sys.c 1.47 vs edited =====
> --- 1.47/kernel/sys.c	Thu Jun 12 15:53:14 2003
> +++ edited/kernel/sys.c	Mon Jun 23 16:01:39 2003
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/config.h>
> +#include <linux/compat.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
>  #include <linux/utsname.h>
> @@ -1219,7 +1220,7 @@
>  			? -EFAULT : 0;
>  }
>  
> -#if !defined(__ia64__) && !defined(CONFIG_V850)
> +#if defined(COMPAT_RLIM_OLD_INFINITY) || !(defined(CONFIG_IA64) || defined(CONFIG_V850))
> 
>  /*
>   *	Back compatibility for getrlimit. Needed for some apps.

s/||/&&/  ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

