Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSKOLrJ>; Fri, 15 Nov 2002 06:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSKOLrJ>; Fri, 15 Nov 2002 06:47:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36616 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265250AbSKOLrI>; Fri, 15 Nov 2002 06:47:08 -0500
Date: Fri, 15 Nov 2002 12:54:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115115402.GB25902@atrey.karlin.mff.cuni.cz>
References: <20021115081044.GI18180@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115081044.GI18180@conectiva.com.br>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=suspend -DKBUILD_MODNAME=suspend -DEXPORT_SYMTAB  -c -o kernel/suspend.o kernel/suspend.c
> kernel/suspend.c:295: warning: #warning This might be broken. We need to somehow wait for data to reach the disk
> kernel/suspend.c: In function `free_some_memory':
> kernel/suspend.c:627: `contig_page_data' undeclared (first use in this function)
> kernel/suspend.c:627: (Each undeclared identifier is reported only once
> kernel/suspend.c:627: for each function it appears in.)
> make[1]: ** [kernel/suspend.o] Erro 1
> make: ** [kernel] Erro 2
> [acme@oops hell_header-2.5]$ grep CONFIG_DISCONTIGMEM .config
> CONFIG_DISCONTIGMEM=y
> 
> and in ./mm/page_alloc.c
> 
> #ifndef CONFIG_DISCONTIGMEM
> static bootmem_data_t contig_bootmem_data;
> struct pglist_data contig_page_data = { .bdata = &contig_bootmem_data };
> 
> void __init free_area_init(unsigned long *zones_size)
> {
>         free_area_init_node(0, &contig_page_data, NULL, zones_size, 0, NULL);
>         mem_map = contig_page_data.node_mem_map;
> }
> #endif
> 
> So perhaps the following patch is in order? Its kind of brute force, disabling it
> altogether, but it at least fixes it for now.

Please don't, better patch is pending to fix that.
									Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
