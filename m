Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVFYQVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVFYQVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 12:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVFYQVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 12:21:45 -0400
Received: from node-40240a4a.sjc.onnet.us.uu.net ([64.36.10.74]:15123 "EHLO
	sphinx.zankel.net") by vger.kernel.org with ESMTP id S261273AbVFYQVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 12:21:40 -0400
Message-ID: <42BD8622.8060506@zankel.net>
Date: Sat, 25 Jun 2005 09:28:18 -0700
From: Christian Zankel <chris@zankel.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050210)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: czankel@tensilica.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: arch xtensa does not compile
References: <42BD6557.9070102@ppp0.net>
In-Reply-To: <42BD6557.9070102@ppp0.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> Hello Chris,
> 
> the recently merged xtensa arch does not (cross) compile successfully.
> I'm using 2.6.12-git7 which seems to have all patches (1-8) merged.

I did have to make some more changes because of the other changes in 
Andrew's tree, but wasn't sure what other patches would make it in.
I'll submit the Xtensa patches shortly.

Thanks for the report.
~Chris

> 
> 1. numnodes.h missing
> $ make mrproper
> $ make ARCH=xtensa CROSS_COMPILE=xtensa-linux- defconfig
> $ make ARCH=xtensa CROSS_COMPILE=xtensa-linux-
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-xtensa
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   Setting up cpu (linux_be) and platform (xt2000) symlinks
>   HOSTCC  scripts/genksyms/genksyms.o
>   SHIPPED scripts/genksyms/lex.c
>   SHIPPED scripts/genksyms/parse.h
>   SHIPPED scripts/genksyms/keywords.c
>   HOSTCC  scripts/genksyms/lex.o
>   SHIPPED scripts/genksyms/parse.c
>   HOSTCC  scripts/genksyms/parse.o
>   HOSTLD  scripts/genksyms/genksyms
>   CC      scripts/mod/empty.o
>   HOSTCC  scripts/mod/mk_elfconfig
>   MKELF   scripts/mod/elfconfig.h
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/modpost.o
>   HOSTCC  scripts/mod/sumversion.o
>   HOSTLD  scripts/mod/modpost
>   HOSTCC  scripts/kallsyms
>   HOSTCC  scripts/conmakehash
>   CC      arch/xtensa/kernel/asm-offsets.s
> In file included from include/linux/nodemask.h:82,
>                  from include/linux/sched.h:17,
>                  from arch/xtensa/kernel/asm-offsets.c:18:
> include/linux/numa.h:7:26: asm/numnodes.h: No such file or directory
> make[1]: *** [arch/xtensa/kernel/asm-offsets.s] Error 1
> make: *** [arch/xtensa/kernel/asm-offsets.s] Error 2
> 
> 2. O= support
> $ mkdir /tmp/x
> $ make mrproper
> $ make ARCH=xtensa CROSS_COMPILE=xtensa-linux- O=/tmp/x defconfig
> [ ... ]
> $ make ARCH=xtensa CROSS_COMPILE=xtensa-linux- O=/tmp/x
>   Using /usr/src/ctest/oo/kernel as source for kernel
>   GEN    /tmp/x/Makefile
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-xtensa
>   GEN    /tmp/x/Makefile
> scripts/kconfig/conf -s arch/xtensa/Kconfig
> #
> # using defaults found in .config
> #
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   Setting up cpu (linux_be) and platform (xt2000) symlinks
> /bin/sh: line 1: cd: include/asm-xtensa/: No such file or directory
> /bin/sh: line 1: cd: include/asm-xtensa/xtensa: No such file or directory
> 
> then a lots of follow up errors.
> 
> $ xtensa-linux-gcc -v
> Reading specs from /usr/cc/xtensa/lib/gcc-lib/xtensa-linux/3.3.6/specs
> Configured with: ../configure --prefix=/usr/cc --exec-prefix=/usr/cc/xtensa --target=xtensa-linux --disable-shared --disable-werror --disable-nls
> --disable-threads --disable-werror --with-newlib --with-gnu-as --with-gnu-ld --enable-languages=c
> Thread model: single
> gcc version 3.3.6
> $ xtensa-linux-ld -v
> GNU ld version 2.15.94.0.2.2 20041220
> 
> It would be nice if you could fix these issues.
> 
> Thanks,
> 

