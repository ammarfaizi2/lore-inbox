Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWGGHtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWGGHtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWGGHtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:49:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47369 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750939AbWGGHtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:49:49 -0400
Date: Fri, 7 Jul 2006 09:49:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Valdis.Kletnieks@vt.edu, kai@germaschewski.name,
       linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20060707074949.GB26941@stusta.de>
References: <20060706163728.GN26941@stusta.de> <20060707033630.GA15967@mars.ravnborg.org> <200607070502.k6752IqY007285@turing-police.cc.vt.edu> <20060707064218.GA29981@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707064218.GA29981@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 08:42:18AM +0200, Sam Ravnborg wrote:
>...
> make -C /home/sam/kernel/kbuild.git O=/home/sam/kernel/osparc
>   Using /home/sam/kernel/kbuild.git as source for kernel
>   GEN     /home/sam/kernel/osparc/Makefile
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CHK     include/linux/compile.h
>   CC      arch/sparc/mm/init.o
> In file included from include2/asm/tlb.h:22,
>                  from /home/sam/kernel/kbuild.git/arch/sparc/mm/init.c:32:
> /home/sam/kernel/kbuild.git/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
> /home/sam/kernel/kbuild.git/include/asm-generic/tlb.h:76: error: implicit declaration of function `release_pages'
> /home/sam/kernel/kbuild.git/include/asm-generic/tlb.h: In function `tlb_remove_page':
> /home/sam/kernel/kbuild.git/include/asm-generic/tlb.h:105: error: implicit declaration of function `page_cache_release'
> make[3]: *** [arch/sparc/mm/init.o] Error 1
> make[2]: *** [arch/sparc/mm] Error 2
> make[1]: *** [_all] Error 2
> make: *** [all] Error 2
>...

OK, I tried starting with this one.

The problem is that in the CONFIG_SWAP=n case, linux/swap.h uses these 
functions.

These implicit declarations are bugs that should be fixed.

I tried adding an #include <linux/pagemap.h> to linux/swap.h, but this 
broke things faster than I could fix them.

Does anyone know our header mess good enough for being able to help me 
with this issue?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

