Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUI2Nnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUI2Nnk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbUI2Nnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:43:39 -0400
Received: from mproxy.gmail.com ([216.239.56.240]:53923 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268438AbUI2NlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:41:17 -0400
Message-ID: <21d7e99704092906415ddca034@mail.gmail.com>
Date: Wed, 29 Sep 2004 23:41:16 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@gmail.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
In-Reply-To: <20040929133759.A11891@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <20040929133759.A11891@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>  - once we have Alan's idea of the graphics core implemented drm_init()
>    should go awaw
>  - drm_probe (and it's call to drm_fill_in_dev) looks a little fishy,
>    what about doing the full ->probe callback in each driver where it
>    can do basic hw setup, dealing with pci and calls back into the drm
>    core for minor number allocation and common structure allocations.

We have mentioned this but 90% of the work done by the drivers would
be common, we might do it the otherway I suppose have a driver probe
that calls a function in the core,

>    This would get rid of the ->preinit and ->postinit hooks.
>  - isn't drm_order just a copy of get_order()?
>  - any chance to use proper kernel-doc comments instead of the bastdized
>    and hard to read version you have currently?

I think we have doxygen comments in there at the moment - the Mesa/DRI
documentation is done with doxygen...

>  - the coding style is a little strange, like spurious whitespaces inside
>    braces, maybe you could run it through scripts/Lindent

there are a fair few of these in there in the kernel, it could
probably do with a Lindent at some stage over the whole thing...

>  - care to use linux/lists.h instead of opencoded lists, e.g. in
>    dev->file_last/dev->file_first or dev->vmalist
>  - drm_flush is a noop.  a NULL ->flush does the same thing, just easier
>  - dito or ->poll
>  - dito for ->read
>  - why do you use DRM_COPY_FROM_USER_IOCTL in Linux-specific code?
>  - drm__mem_info should be converted to fs/seq_file.c functions
>  - dito for functions in drm_proc.c

I think I can apply a lot of these to the current kernel code so I'll
probably just start doing patches up for these sort of issues
separately....

I'll get time to create a bitkeeper tree taking Jons changes ready for
merging to Andrew at least, and maybe Linus for 2.6.10.

Dave.
