Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTJPAZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 20:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTJPAZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 20:25:53 -0400
Received: from netline-mail1.netline.ch ([195.141.226.27]:17677 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S262649AbTJPAZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 20:25:52 -0400
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20031015162056.018737f1.akpm@osdl.org>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
	 <20031015162056.018737f1.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Organization: Debian, XFree86
Message-Id: <1066263895.6065.143.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 16 Oct 2003 02:24:56 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 01:20, Andrew Morton wrote:
> 
> This one comes up again and again.  What should we do with it?
> 
> 
> --- 25/drivers/video/radeonfb.c~radeonfb-line_length-fix	2003-10-05 09:17:58.000000000 -0700
> +++ 25-akpm/drivers/video/radeonfb.c	2003-10-05 09:17:58.000000000 -0700
> @@ -2090,7 +2090,7 @@ static int radeonfb_set_par (struct fb_i
>  	
>  	}
>  	/* Update fix */
> -        info->fix.line_length = rinfo->pitch*64;
> +        info->fix.line_length = mode->xres_virtual*(mode->bits_per_pixel/8);
>          info->fix.visual = rinfo->depth == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
>  
>  #ifdef CONFIG_BOOTX_TEXT

I'd say drop it, as it's wrong. :) It's like this in Ben's tree:

	/* Update fix */
	if (accel)
        	info->fix.line_length = rinfo->pitch*64;
        else
		info->fix.line_length = mode->xres_virtual * ((mode->bits_per_pixel +
1) / 8);


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

