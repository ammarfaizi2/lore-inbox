Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWGGGmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWGGGmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 02:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWGGGmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 02:42:40 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:45462 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751201AbWGGGmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 02:42:39 -0400
Date: Fri, 7 Jul 2006 08:42:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Valdis.Kletnieks@vt.edu
Cc: Adrian Bunk <bunk@stusta.de>, kai@germaschewski.name,
       linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20060707064218.GA29981@mars.ravnborg.org>
References: <20060706163728.GN26941@stusta.de> <20060707033630.GA15967@mars.ravnborg.org> <200607070502.k6752IqY007285@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607070502.k6752IqY007285@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 01:02:18AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 07 Jul 2006 05:36:30 +0200, Sam Ravnborg said:
> > On Thu, Jul 06, 2006 at 06:37:28PM +0200, Adrian Bunk wrote:
> > > With -Werror-implicit-function-declaration we are getting an immediate
> > > compile error instead.
> > This patch broke (-rc1):
> ...
> > I did not try other architectures. We need to fix the allnoconfig cases
> > at least for the popular architectures before applying this patch
> > otherwise it will create too much trouble/noise.
> 
> What source files did it break on, and with what error message?  And is
> there a reason to focus on 'allnoconfig', or do the other canned config
> targets (allyes, allmod, rand, and so on) matter too?

The other configs matters too - but it just seemed most logical to start
out with the config that deselected the most.
One could say that passing 'allnoconfig' was the minimal test.

The error messages follows (for ia64, sparc and ppc64).
I have not tried to fix any of them.

	Sam

make -C /home/sam/kernel/kbuild.git O=/home/sam/kernel/oia64
  Using /home/sam/kernel/kbuild.git as source for kernel
  GEN     /home/sam/kernel/oia64/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC      arch/ia64/kernel/asm-offsets.s
In file included from /home/sam/kernel/kbuild.git/include/linux/poll.h:11,
                 from /home/sam/kernel/kbuild.git/include/linux/rtc.h:113,
                 from /home/sam/kernel/kbuild.git/include/linux/efi.h:19,
                 from include2/asm/sal.h:40,
                 from /home/sam/kernel/kbuild.git/include/asm-ia64/mca.h:20,
                 from /home/sam/kernel/kbuild.git/arch/ia64/kernel/asm-offsets.c:15:
/home/sam/kernel/kbuild.git/include/linux/mm.h: In function `lowmem_page_address':
/home/sam/kernel/kbuild.git/include/linux/mm.h:530: error: implicit declaration of function `page_to_pfn'
In file included from /home/sam/kernel/kbuild.git/include/linux/poll.h:12,
                 from /home/sam/kernel/kbuild.git/include/linux/rtc.h:113,
                 from /home/sam/kernel/kbuild.git/include/linux/efi.h:19,
                 from include2/asm/sal.h:40,
                 from /home/sam/kernel/kbuild.git/include/asm-ia64/mca.h:20,
                 from /home/sam/kernel/kbuild.git/arch/ia64/kernel/asm-offsets.c:15:
include2/asm/uaccess.h: In function `xlate_dev_mem_ptr':
include2/asm/uaccess.h:374: error: implicit declaration of function `pfn_to_page'
include2/asm/uaccess.h:374: warning: assignment makes pointer from integer without a cast
include2/asm/uaccess.h: In function `xlate_dev_kmem_ptr':
include2/asm/uaccess.h:392: warning: assignment makes pointer from integer without a cast
make[3]: *** [arch/ia64/kernel/asm-offsets.s] Error 1
make[2]: *** [prepare0] Error 2
make[1]: *** [_all] Error 2
make: *** [all] Error 2

make -C /home/sam/kernel/kbuild.git O=/home/sam/kernel/oia64
  Using /home/sam/kernel/kbuild.git as source for kernel
  GEN     /home/sam/kernel/oia64/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC      arch/ia64/kernel/asm-offsets.s
In file included from /home/sam/kernel/kbuild.git/include/linux/poll.h:11,
                 from /home/sam/kernel/kbuild.git/include/linux/rtc.h:113,
                 from /home/sam/kernel/kbuild.git/include/linux/efi.h:19,
                 from include2/asm/sal.h:40,
                 from /home/sam/kernel/kbuild.git/include/asm-ia64/mca.h:20,
                 from /home/sam/kernel/kbuild.git/arch/ia64/kernel/asm-offsets.c:15:
/home/sam/kernel/kbuild.git/include/linux/mm.h: In function `lowmem_page_address':
/home/sam/kernel/kbuild.git/include/linux/mm.h:530: error: implicit declaration of function `page_to_pfn'
In file included from /home/sam/kernel/kbuild.git/include/linux/poll.h:12,
                 from /home/sam/kernel/kbuild.git/include/linux/rtc.h:113,
                 from /home/sam/kernel/kbuild.git/include/linux/efi.h:19,
                 from include2/asm/sal.h:40,
                 from /home/sam/kernel/kbuild.git/include/asm-ia64/mca.h:20,
                 from /home/sam/kernel/kbuild.git/arch/ia64/kernel/asm-offsets.c:15:
include2/asm/uaccess.h: In function `xlate_dev_mem_ptr':
include2/asm/uaccess.h:374: error: implicit declaration of function `pfn_to_page'
include2/asm/uaccess.h:374: warning: assignment makes pointer from integer without a cast
include2/asm/uaccess.h: In function `xlate_dev_kmem_ptr':
include2/asm/uaccess.h:392: warning: assignment makes pointer from integer without a cast
make[3]: *** [arch/ia64/kernel/asm-offsets.s] Error 1
make[2]: *** [prepare0] Error 2
make[1]: *** [_all] Error 2
make: *** [all] Error 2
make -C /home/sam/kernel/kbuild.git O=/home/sam/kernel/osparc
  Using /home/sam/kernel/kbuild.git as source for kernel
  GEN     /home/sam/kernel/osparc/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  CC      arch/sparc/mm/init.o
In file included from include2/asm/tlb.h:22,
                 from /home/sam/kernel/kbuild.git/arch/sparc/mm/init.c:32:
/home/sam/kernel/kbuild.git/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
/home/sam/kernel/kbuild.git/include/asm-generic/tlb.h:76: error: implicit declaration of function `release_pages'
/home/sam/kernel/kbuild.git/include/asm-generic/tlb.h: In function `tlb_remove_page':
/home/sam/kernel/kbuild.git/include/asm-generic/tlb.h:105: error: implicit declaration of function `page_cache_release'
make[3]: *** [arch/sparc/mm/init.o] Error 1
make[2]: *** [arch/sparc/mm] Error 2
make[1]: *** [_all] Error 2
make: *** [all] Error 2


make -C /home/sam/kernel/kbuild.git O=/home/sam/kernel/oppc64
  Using /home/sam/kernel/kbuild.git as source for kernel
  GEN     /home/sam/kernel/oppc64/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-powerpc
  CHK     include/linux/compile.h
  CC      arch/powerpc/mm/tlb_32.o
In file included from include2/asm/tlb.h:52,
                 from /home/sam/kernel/kbuild.git/arch/powerpc/mm/tlb_32.c:31:
/home/sam/kernel/kbuild.git/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
/home/sam/kernel/kbuild.git/include/asm-generic/tlb.h:76: error: implicit declaration of function `release_pages'
/home/sam/kernel/kbuild.git/include/asm-generic/tlb.h: In function `tlb_remove_page':
/home/sam/kernel/kbuild.git/include/asm-generic/tlb.h:105: error: implicit declaration of function `page_cache_release'
make[3]: *** [arch/powerpc/mm/tlb_32.o] Error 1
make[2]: *** [arch/powerpc/mm] Error 2
make[1]: *** [_all] Error 2
make: *** [all] Error 2
