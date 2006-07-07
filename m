Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWGGHzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWGGHzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWGGHza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:55:30 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:266 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S1750972AbWGGHza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:55:30 -0400
Date: Fri, 7 Jul 2006 02:53:28 -0500 (CDT)
Message-Id: <200607070753.k677rSVT027033@sullivan.realtime.net>
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
References: <20060706163728.GN26941@stusta.de>
	<20060707064218.GA29981@mars.ravnborg.org>
	<20060707033630.GA15967@mars.ravnborg.org>
	<200607070502.k6752IqY007285@turing-police.cc.vt.edu>
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
From: Milton Miller <miltonm@bga.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, 07 Jul 2006 05:36:30 +0200, Sam Ravnborg said:
> > On Thu, Jul 06, 2006 at 06:37:28PM +0200, Adrian Bunk wrote:
> > > With -Werror-implicit-function-declaration we are getting an immediate
> > > compile error instead.
> > This patch broke (-rc1):
> ...
> > I did not try other architectures. We need to fix the allnoconfig cases
> > at least for the popular architectures before applying this patch
> > otherwise it will create too much trouble/noise.


Sam wrote on Fri Jul 07 2006 - 02:40:55 EST::
> The error messages follows (for ia64, sparc and ppc64).
> make -C /home/sam/kernel/kbuild.git O=/home/sam/kernel/oppc64
> Using /home/sam/kernel/kbuild.git as source for kernel
> GEN /home/sam/kernel/oppc64/Makefile
> CHK include/linux/version.h
> CHK include/linux/utsrelease.h
> SYMLINK include/asm -> include/asm-powerpc
> CHK include/linux/compile.h
> CC arch/powerpc/mm/tlb_32.o
> In file included from include2/asm/tlb.h:52,
> from /home/sam/kernel/kbuild.git/arch/powerpc/mm/tlb_32.c:31:
> /home/sam/kernel/kbuild.git/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
> /home/sam/kernel/kbuild.git/include/asm-generic/tlb.h:76: error: implicit declaration of function `release_pages'
> /home/sam/kernel/kbuild.git/include/asm-generic/tlb.h: In function `tlb_remove_page':
> /home/sam/kernel/kbuild.git/include/asm-generic/tlb.h:105: error: implicit declaration of function `page_cache_release'
> make[3]: *** [arch/powerpc/mm/tlb_32.o] Error 1
> make[2]: *** [arch/powerpc/mm] Error 2
> make[1]: *** [_all] Error 2
> make: *** [all] Error 2
> 


That is cross architcture (asm-generic) CONFIG_SWAP=n

http://marc.theaimsgroup.com/?l=linux-kernel&m=106674447120368&w=2

My vote is if the file needs it in an inline, add the include.   Otherwise
split the definition to a new file..

miton
