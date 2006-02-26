Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWBZRAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWBZRAj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWBZRAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:00:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46606 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750859AbWBZRAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:00:38 -0500
Date: Sun, 26 Feb 2006 18:00:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Message-ID: <20060226170038.GF3674@stusta.de>
References: <200602261721.17373.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602261721.17373.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 05:21:17PM +0100, Jesper Juhl wrote:
> 
> Hi everyone,

Hi Jesper,

> I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)
> 
> 	95 kernels were build with 'make randconfig'.
> 	1 kernel was build with the config I normally use for my own box.
> 	1 kernel was build from 'make defconfig'.
> 	1 kernel was build from 'make allmodconfig'.
> 	1 kernel was build from 'make allnoconfig'.
> 	1 kernel was build from 'make allyesconfig'.
> 
> That was an interresting experience. 
> 
> First of all not very many of the kernels actually build correctly and 
> secondly, if I grep the build logs for warnings I'm swamped.
> 
> Out of 100 kernels 82 failed to build - that's an 18% success rate people, 
> not very impressive.
> 
> Some of the failed builds are due to things like CONFIG_STANDALONE that 
> will break the build if not set to Y (unless you have the firmware 
> available ofcourse), but looking at the config files I find that only 26 
> kernels have CONFIG_STANDALONE unset, so that only accounts for a quarter
> of the kernels.
> 
> A lot of failed builds are due to invalid combinations of some stuff 
> being build-in and some stuff being build as modules.
> This, as far as I'm concerned, is something that the dependencies in 
> Kconfig should make impossible - hence my conclusion that we suck at deps.

Yes, it should be fixed.

Our dependencies are usually relatively good in all the normal cases. 
I'd expect e.g. half of your randconfig builds to have EMBEDDED=y set, 
and this often exposes problems. They should be fixed, but it is far 
from the .config's most users use.

And then there's the usual problem with numbers, e.g. each of
CONFIG_STANDALONE=n or breakage of the OSS sonicvibes driver will 
account for a two digit number of build failures. I'd guess fixing two 
or three problems will bring your 18% number > 50%.

> >From 100 kernel builds there was a total of 16152 warnings and 645 of those
> are unique warnings, the rest are duplicates.
> 
> We are drowning in warnings people. Sure, many of the warnings are due to 
> gcc getting something wrong and shouldn't really be emitted, but a lot of 
> them point to actual problems or deficiencies (I obviously haven't looked 
> at them all in detail yet, so take that with a grain of salt please).
>...

It's well-known that BROKEN_ON_SMP drivers often spit 50 warnings in one 
warning. If you remove the dozen worst drivers the numbers should look 
much better.

Not that our current situation was perfect, but the number of warnings 
in .config's people usually use isn't that bad.

> Jesper Juhl <jesper.juhl@gmail.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

