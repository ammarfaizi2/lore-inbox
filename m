Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269697AbUJAFPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269697AbUJAFPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 01:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269699AbUJAFPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 01:15:43 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:33799 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269697AbUJAFPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 01:15:40 -0400
Message-ID: <9e473391040930221574bf687b@mail.gmail.com>
Date: Fri, 1 Oct 2004 01:15:39 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
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

On Wed, 29 Sep 2004 13:37:59 +0100, Christoph Hellwig <hch@infradead.org> wrote:
> Some ideas that would be nice improvements still (not that some may be
> inherited from the old drm code, I just looked at the CVS checkout):
> 
>  - once we have Alan's idea of the graphics core implemented drm_init()
>    should go awaw
>  - drm_probe (and it's call to drm_fill_in_dev) looks a little fishy,
>    what about doing the full ->probe callback in each driver where it
>    can do basic hw setup, dealing with pci and calls back into the drm
>    core for minor number allocation and common structure allocations.
>    This would get rid of the ->preinit and ->postinit hooks.

This has to stay the way it currently is because of the stealth mode code

>  - isn't drm_order just a copy of get_order()?
switched to get_order

>  - any chance to use proper kernel-doc comments instead of the bastdized
>    and hard to read version you have currently?
doc people don't want to switch 

>  - the coding style is a little strange, like spurious whitespaces inside
>    braces, maybe you could run it through scripts/Lindent
ran most of it through Lindent. check out CVS for results.

>  - care to use linux/lists.h instead of opencoded lists, e.g. in
>    dev->file_last/dev->file_first or dev->vmalist
There are about 20 open coded lists. I started to fix some of these
but the code involved can be touchy and it's already well tested.
It would be better to wait on these until someone is working on
the code involved. I don't want to introduce bugs because I don't
understand the code 100%.

>  - drm_flush is a noop.  a NULL ->flush does the same thing, just easier
>  - dito or ->poll
>  - dito for ->read
Changed these to use kernel defaults.

>  - why do you use DRM_COPY_FROM_USER_IOCTL in Linux-specific code?
That can probably be fixed. I believe it is because it is hiding a
2.4/2.6 change.

>  - drm__mem_info should be converted to fs/seq_file.c functions
>  - dito for functions in drm_proc.c
I started to do this to but I didn't want to disrupt know working code. These
may get rewritten for sysfs.
> 

-- 
Jon Smirl
jonsmirl@gmail.com
