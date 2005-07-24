Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVGXV1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVGXV1b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 17:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVGXV1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 17:27:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261354AbVGXV13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 17:27:29 -0400
Date: Sun, 24 Jul 2005 23:27:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Grant Coady <lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Message-ID: <20050724212721.GA3160@stusta.de>
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com> <20050724091327.GQ3160@stusta.de> <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com> <20050724203932.GX3160@stusta.de> <0fv7e11ejvimjkfqib95n93hl34icavnbu@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fv7e11ejvimjkfqib95n93hl34icavnbu@4ax.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 07:13:02AM +1000, Grant Coady wrote:
> On Sun, 24 Jul 2005 22:39:32 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> 
> >On Mon, Jul 25, 2005 at 05:42:58AM +1000, Grant Coady wrote:
> >> On Sun, 24 Jul 2005 11:13:27 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> >> >
> >> >it's generally useful, but the target kernel should be the latest -mm
> >> >kernel. 
> >> 097-error:drivers/char/drm/drm_memory.h:163: error: redefinition of `drm_ioremap_nocache'
> >> 097-error:drivers/char/drm/drm_memory.h:163: error: `drm_ioremap_nocache' previously defined here
> >> 097-error:drivers/char/drm/drm_memory.h:174: error: redefinition of `drm_ioremapfree'
> >> 097-error:drivers/char/drm/drm_memory.h:174: error: `drm_ioremapfree' previously defined here
> >
> >This requires the .config for debugging.
> Here:
>   ftp://ftp.scatter.mine.nu/develop/trial4-097-config.gz
> 
> >My first guess is that drm_memory.h requires a simple #ifdef to allow 
> >multiple inclusions.
> 
> I can tell you:
> --- linux-2.6.12.3b/drivers/char/drm/drm_memory.h.orig	2005-06-18 05:48:29.000000000 +1000
> +++ linux-2.6.12.3b/drivers/char/drm/drm_memory.h	2005-07-25 06:57:41.000000000 +1000
> @@ -33,6 +33,9 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
> +#ifndef DRM_MEMORY_H
> +#define DRM_MEMORY_H
> +
>  #include <linux/config.h>
>  #include <linux/highmem.h>
>  #include <linux/vmalloc.h>
> @@ -194,4 +197,5 @@
>  	iounmap(pt);
>  }
>  
> +#endif
> 
> does not fix it, though it's probably not what you had in mind, first try...

That's what I had in mind.

> Simple fix didn't...  Now I got to read the code, takes a little more 
> effort :)
>...

Looking at the .config, the problem is actually:
  CONFIG_BROKEN=y

You should edit init/Kconfig to disallow CONFIG_CLEAN_COMPILE=n, since 
any errors you see with CONFIG_BROKEN=y aren't interesting.

> Grant.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

