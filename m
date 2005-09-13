Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVIMSzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVIMSzl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVIMSzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:55:41 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:52027 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S964983AbVIMSzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:55:40 -0400
Date: Tue, 13 Sep 2005 20:57:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -git11 breaks parisc and sh even more
Message-ID: <20050913185759.GA17272@mars.ravnborg.org>
References: <20050913174754.GA13132@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913174754.GA13132@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey.

On Tue, Sep 13, 2005 at 09:47:54PM +0400, Alexey Dobriyan wrote:
> 2.6.13-git10 was OK (read: allmodconfig still broken, but not _that_
> early).
> 
> If anybody want to see full logs, they are at
> ftp://ftp.berlios.de/pub/linux-sparse/logs/2.6.13-git11/W_sparse_{parisc,sh}.bz2
> -----------------------------------------------------------------------
> parisc:
> 
> 2.6.13-git11
> hppa-unknown-linux-gnu-gcc (GCC) 3.4.4 (Gentoo 3.4.4-r1)
> which: no palo in ($PATH)
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-parisc
> which: no palo in ($PATH)
> scripts/kconfig/conf -s arch/parisc/Kconfig
> #
> # using defaults found in .config
> #
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   CC      arch/parisc/kernel/asm-offsets.s
> In file included from include/asm/spinlock.h:4,
>                  from include/asm/bitops.h:5,
>                  from include/linux/bitops.h:77,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/spinlock.h:53,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:7,
>                  from arch/parisc/kernel/asm-offsets.c:31:
> include/asm/system.h:174: error: parse error before "pa_tlb_lock"
> 	...
> -----------------------------------------------------------------------
> sh:
> 
> 2.6.13-git11
> sh-unknown-linux-gnu-gcc (GCC) 3.4.4 (Gentoo 3.4.4-r1)
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   Generating include/asm-sh/machtypes.h
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   SYMLINK include/asm-sh/cpu -> include/asm-sh/cpu-sh4
>   SYMLINK include/asm-sh/mach -> include/asm-sh/unknown
>   SYMLINK include/asm -> include/asm-sh
>   CC      arch/sh/kernel/asm-offsets.s
> In file included from include/linux/spinlock_types.h:13,
>                  from include/linux/spinlock.h:80,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:7,
>                  from include/linux/mm.h:4,
>                  from arch/sh/kernel/asm-offsets.c:13:
> include/asm/spinlock_types.h:16: error: parse error before "atomic_t"
> 	...
> -----------------------------------------------------------------------

I have tried to understand why this happens with no success..
Not much has changed in how we actually compile the .c -> .s files.
In both cases it looks like gcc is warning that a sane typedef is not
present.

Have you tried to dive more into this, or have you just reported the
breakage?

	Sam
