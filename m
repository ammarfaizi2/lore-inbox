Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVG0WWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVG0WWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVG0WWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:22:14 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17419 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261190AbVG0WUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:20:34 -0400
Date: Thu, 28 Jul 2005 00:20:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2 doesn't boot
Message-ID: <20050727222033.GA3528@stusta.de>
References: <20050727024330.78ee32c2.akpm@osdl.org> <20050727203527.GA3679@stusta.de> <20050727141646.1852a505.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727141646.1852a505.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 02:16:46PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> >  2.6.13-rc3-mm2 doesn't boot on my computer:
> >    Badness in nr_blockdev_pages at fs/block_dev.c:399
> >    ...
> >    kmem_cache_create: Early error in slab inet_peer_cache
> > 
> >  A screenshot is available at [1].
> > 
> >  My .config is attached.
> > 
> >  2.6.13-rc3-mm1 boots and works without problems.
> > 
> >  cu
> >  Adrian
> > 
> >  [1] http://www.fs.tum.de/~bunk/kernel/boot_failure.jpg
> 
> I'd be suspecting there's been a huge preempt_count() windup and the kernel
> thinks that it's running in_interrupt(), so various checks are triggering.
> 
> Please try this one:
>...

Thanks, this fixed it.

> And if that doesn't fix, enable CONFIG_DEBUG_PREEMPT and see if the
> sub_preempt_count() check triggers.

This wouldn't have been possible since I'm using CONFIG_PREEMPT_NONE=y.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

