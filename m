Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVCHU3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVCHU3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVCHU12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:27:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5333 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262119AbVCHTnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:43:42 -0500
Date: Tue, 8 Mar 2005 19:43:38 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: linux-fbdev-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [announce 5/7] fbsplash - fbdev updates
In-Reply-To: <20050308021417.GF26249@spock.one.pl>
Message-ID: <Pine.LNX.4.56.0503081943060.15646@pentafluge.infradead.org>
References: <20050308021417.GF26249@spock.one.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -Nru a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> --- a/drivers/video/fbcmap.c	2005-03-07 16:50:34 +01:00
> +++ b/drivers/video/fbcmap.c	2005-03-07 16:50:34 +01:00
> @@ -16,6 +16,7 @@
>  #include <linux/tty.h>
>  #include <linux/fb.h>
>  #include <linux/slab.h>
> +#include "fbsplash.h"
>  
>  #include <asm/uaccess.h>
>  
> @@ -235,6 +236,10 @@
>  					      info))
>  			break;
>  	}
> +	fb_copy_cmap(cmap, &info->cmap);
> +	if (fbsplash_active(info, vc_cons[fg_console].d) &&
> +	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) 
> +		fbsplash_fix_pseudo_pal(info, vc_cons[fg_console].d);
>  	return 0;
>  }
>  
> @@ -265,6 +270,9 @@
>  		if (transp)
>  			transp++;
>  	}
> +	if (fbsplash_active(info, vc_cons[fg_console].d) &&
> +	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) 
> +		fbsplash_fix_pseudo_pal(info, vc_cons[fg_console].d);
>  	return 0;
>  }

That is just gross. You are putting console code back into the fbdev core. 

