Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUIXENx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUIXENx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUIXENw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:13:52 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:51129 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S267165AbUIXEMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:12:49 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 03/21]  video/radeon_base: replace MS_TO_HZ() 	with msecs_to_jiffies()
Date: Fri, 24 Sep 2004 00:12:47 -0400
User-Agent: KMail/1.7
Cc: janitor@sternwelten.at, akpm@digeo.com, nacc@us.ibm.com
References: <E1CAaFx-0000wQ-2B@sputnik>
In-Reply-To: <E1CAaFx-0000wQ-2B@sputnik>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409240012.47738.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.51.220] at Thu, 23 Sep 2004 23:12:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2004 16:31, janitor@sternwelten.at wrote:
>I would appreciate any comments from the janitors list.

Well, I'm not a janitor, but this patch tickled my fancy enough to 
apply it just for grins, and there is now a wide one here at the 
Heskett digs.  Running 2.6.9-rc2-mm2 without this patch, my glxgears 
speeds are fixed +- a half a frame a second from 10 fps.  Thats real 
exciting, like watching grass grow or paint dry.

However, after applying this patch only, my glxgears performance is 
looking up a bit, as follows:
root@coyote root]# glxgears
1254 frames in 5.0 seconds = 250.800 FPS
1260 frames in 5.0 seconds = 252.000 FPS
1276 frames in 5.0 seconds = 255.200 FPS
1260 frames in 5.0 seconds = 252.000 FPS
1260 frames in 5.0 seconds = 252.000 FPS
1134 frames in 5.0 seconds = 226.800 FPS
1260 frames in 5.0 seconds = 252.000 FPS
1262 frames in 5.0 seconds = 252.400 FPS
1182 frames in 5.0 seconds = 236.400 FPS
1260 frames in 5.0 seconds = 252.000 FPS
1134 frames in 5.0 seconds = 226.800 FPS
1260 frames in 5.0 seconds = 252.000 FPS
X connection to :0.0 broken (explicit kill or server shutdown).

The 2 stumbles visible were probably kmail related.

And the exit message when clicking on it to close it is changed from 
the former "Broken pipe" to the above, so there is a side effect of 
this 2 line patch observed here.

Humm, another effect I just noticed, tvtime had a just barely 
noticeable stutter, frame skips I think, that was much worse when 
running the unpatched rc2-mm2.  They seem to be gone, its as smooth 
as the hubble mirror at the moment.

I don't know what other side efects this particular patch might have 
but it sure seems like its all plus for this user.

>Description: Replace MS_TO_HZ() with msecs_to_jiffies().
>
>Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
>
>---
>
> linux-2.6.9-rc2-bk7-max/drivers/video/aty/radeon_base.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletion(-)
>
>diff -puN
> drivers/video/aty/radeon_base.c~use-msecs-to-jiffies-drivers_video_
>aty_radeon_base drivers/video/aty/radeon_base.c ---
> linux-2.6.9-rc2-bk7/drivers/video/aty/radeon_base.c~use-msecs-to-ji
>ffies-drivers_video_aty_radeon_base 2004-09-21 20:51:45.000000000
> +0200 +++
> linux-2.6.9-rc2-bk7-max/drivers/video/aty/radeon_base.c 2004-09-21
> 20:51:45.000000000 +0200 @@ -61,6 +61,7 @@
> #include <linux/tty.h>
> #include <linux/slab.h>
> #include <linux/delay.h>
>+#include <linux/time.h>
> #include <linux/fb.h>
> #include <linux/ioport.h>
> #include <linux/init.h>
>@@ -1286,7 +1287,7 @@ static void radeon_write_mode (struct ra
>      OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl | LVDS_BLON);
>     rinfo->pending_lvds_gen_cntl = mode->lvds_gen_cntl;
>     mod_timer(&rinfo->lvds_timer,
>-       jiffies + MS_TO_HZ(rinfo->panel_info.pwr_delay));
>+       jiffies + msecs_to_jiffies(rinfo->panel_info.pwr_delay));
>    }
>   }
>  }
>_

Nice catch guys.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
