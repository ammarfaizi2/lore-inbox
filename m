Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbSJNGrj>; Mon, 14 Oct 2002 02:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261922AbSJNGrj>; Mon, 14 Oct 2002 02:47:39 -0400
Received: from angband.namesys.com ([212.16.7.85]:29625 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261921AbSJNGrh>; Mon, 14 Oct 2002 02:47:37 -0400
Date: Mon, 14 Oct 2002 10:53:23 +0400
From: Oleg Drokin <green@namesys.com>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] 2.5.42: UML build error
Message-ID: <20021014105323.A5883@namesys.com>
References: <877kgn7kmk.fsf@goat.bogus.local> <Pine.LNX.4.44.0210121145510.17947-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210121145510.17947-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Oct 12, 2002 at 11:49:35AM -0500, Kai Germaschewski wrote:

> > When building 2.5.42 UML it fails with:
> > [...]
> Okay, so here's a patch which fixes the UML build for me (i386) -
> generally, UML could use some more kbuild work, but I'll leave that for
> post-freeze ;)

Actually this patch does not work for make ARCH=um distclean (at least it does
not work for me) because there is no Makefile in arch/um/include/sysdep/
(something like a fix attached).
Also after "distclean", you cannot build UML anymore.
It fails to execute "prepare" target and therefore include/asm/arch
symlink (and others ) is not made and build fails.

  gcc -Wp,-MD,arch/um/sys-i386/util/.mk_thread_kern.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2  -fno-strict-aliasing -fno-common -g  -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE -I/home/green/bk/linux-2.5/arch/um/include -Derrno=kernel_errno -nostdinc -iwithprefix include    -DKBUILD_BASENAME=mk_thread_kern   -c -o arch/um/sys-i386/util/mk_thread_kern.o arch/um/sys-i386/util/mk_thread_kern.c
In file included from include/linux/posix_types.h:46,
                 from include/linux/types.h:11,
                 from include/linux/capability.h:16,
                 from include/linux/sched.h:9,
                 from arch/um/sys-i386/util/mk_thread_kern.c:2:
include/asm/posix_types.h:4: asm/arch/posix_types.h: No such file or directory


===== arch/um/Makefile-i386 1.2 vs edited =====
--- 1.2/arch/um/Makefile-i386	Sat Oct 12 20:47:35 2002
+++ edited/arch/um/Makefile-i386	Mon Oct 14 09:54:09 2002
@@ -28,4 +28,4 @@
 
 sysclean :
 	rm -f $(SYS_HEADERS)
-	@$(call descend,$(SYS_DIR),clean)
+	@$(call descend,$(SYS_UTIL_DIR),clean)


Bye,
    Oleg
