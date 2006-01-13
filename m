Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422684AbWAMOL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWAMOL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbWAMOL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:11:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4363 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422684AbWAMOLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:11:55 -0500
Date: Fri, 13 Jan 2006 15:11:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, adobriyan@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
Message-ID: <20060113141154.GL29663@stusta.de>
References: <20060107052221.61d0b600.akpm@osdl.org> <20060107210646.GA26124@mipter.zuzino.mipt.ru> <20060107154842.5832af75.akpm@osdl.org> <20060110182422.d26c5d8b.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110182422.d26c5d8b.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 06:24:22PM -0800, Paul Jackson wrote:
> Andrew wrote:
> > This is caused by the inclusion of user.h in kernel.h added by
> > dump_thread-cleanup.patch.
> 
> This same build breakage showed up on ia64 sn2_defconfig,
> and your patch fixes it nicely.  Thanks.
> 
> Acked-by: Paul Jackson <pj@sgi.com>
> 
> 
> Andrian - I think that was your dump_thread-cleanup patch.

s/Andrian/Adrian/

> Please be sure to cross build other arch's when making non-local
> changes, such as this one that affected the files:
> 
>     arch/alpha/kernel/alpha_ksyms.c
>     arch/arm26/kernel/armksyms.c
>     arch/cris/kernel/crisksyms.c
>     arch/cris/kernel/process.c
>     arch/frv/kernel/frv_ksyms.c
>     arch/frv/kernel/process.c
>     arch/h8300/kernel/h8300_ksyms.c
>     arch/h8300/kernel/process.c
>     arch/m32r/kernel/m32r_ksyms.c
>     arch/m32r/kernel/process.c
>     arch/m68k/kernel/m68k_ksyms.c
>     arch/m68knommu/kernel/m68k_ksyms.c
>     arch/m68knommu/kernel/process.c
>     arch/s390/kernel/process.c
>     arch/sh64/kernel/process.c
>     arch/sh64/kernel/sh_ksyms.c
>     arch/sh/kernel/process.c
>     arch/sh/kernel/sh_ksyms.c
>     arch/sparc64/kernel/binfmt_aout32.c
>     arch/sparc64/kernel/sparc64_ksyms.c
>     arch/sparc/kernel/sparc_ksyms.c
>     arch/v850/kernel/process.c
>     arch/v850/kernel/v850_ksyms.c
>     fs/binfmt_aout.c
>     fs/binfmt_flat.c
>     include/asm-um/processor-generic.h

None of the above was the problem.

>     include/linux/kernel.h

This was the problem.

> Sure, it consumes some time, but better you do it once, then each of
> several of us have to first do a bisection on Andrew's gazillion
> patches to find the culprit, and then stare at the patch until the light
> bulb goes on in our dimm brains, only to grep back through the lkml
> messages to find that we are not alone in our misery.

It can always happen that one out of fifty patches breaks compilation on 
some architectures, and I'm for sure not the one with the worst 
errors/patches ratio.

-mm is an experimental kernel and although breakages are unfortunate, 
they do happen.

I'm already compiling every single patch with both a non-modular and a 
completely modular .config for i386. This is the amout of testing I can 
afford. If this isn't considered enough I have to stop submtting 
patches.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

