Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWHMQk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWHMQk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 12:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWHMQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 12:40:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49164 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751313AbWHMQk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 12:40:58 -0400
Date: Sun, 13 Aug 2006 18:40:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: 2.6.18-rc4-mm1: drivers/video/sis/ compile error
Message-ID: <20060813164056.GF3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813153034.GD3543@stusta.de> <6bffcb0e0608130929k28ea4974sbced3374067d6794@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0608130929k28ea4974sbced3374067d6794@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 06:29:46PM +0200, Michal Piotrowski wrote:
> On 13/08/06, Adrian Bunk <bunk@stusta.de> wrote:
> >On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> >>...
> >> Changes since 2.6.18-rc3-mm2:
> >>...
> >> +drivers-video-sis-sis_mainh-removal-of-old.patch
> >>...
> >>  fbdev updates
> >>...
> >
> >This patch removes too much:
> >...
> 
> I'll take a closer look at this. I have tested this with allyesconfig
> on 2006-08-08-00-59 mm snapshot, but now it doesn't build when
> CONFIG_FB_SIS=y (CONFIG_FB_SIS=m builds fine for me).
> 
> Thanks for pointing that out.

The problem is here:

<--  snip  -->

...
 #ifdef MODULE
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-static int sisfb_mode_idx = -1;
-#else
-static int sisfb_mode_idx = MODE_INDEX_NONE;  /* Don't use a mode by default if we are a module */
-#endif
-#else
 static int sisfb_mode_idx = -1;               /* Use a default mode if we are inside the kernel */
 #endif
...

<--  snip  -->

It's easy to see that you removed too much (or too few, since the
#ifdef MODULE can be removed - there's also a similar no longer 
required #ifdef MODULE in sis_main.c).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

