Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTEYTt2 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 15:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbTEYTt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 15:49:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:58925 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263705AbTEYTt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 15:49:27 -0400
Date: Sun, 25 May 2003 13:06:01 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm9
Message-Id: <20030525130601.5a105fa8.akpm@digeo.com>
In-Reply-To: <3ED0CE0E.4080403@wmich.edu>
References: <20030525042759.6edacd62.akpm@digeo.com>
	<200305251456.39404.rudmer@legolas.dynup.net>
	<3ED0CE0E.4080403@wmich.edu>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2003 20:02:37.0376 (UTC) FILETIME=[96CD0C00:01C322F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <ed.sweetman@wmich.edu> wrote:
>
> got this with my current config. Along with other misc gcc 3 warnings.
> 
>  Compiling with gcc (GCC) 3.3 (Debian)
> 
>            ld -m elf_i386  -T arch/i386/vmlinux.lds.s
>  arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
>  --start-group  usr/built-in.o  arch/i386/kernel/built-in.o
>  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o
>  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
>  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a
>  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
>  net/built-in.o --end-group  -o vmlinux
>  kernel/built-in.o(.text+0x1708e): In function `free_module':
>  : undefined reference to `percpu_modfree'
>  kernel/built-in.o(.text+0x17873): In function `load_module':
>  : undefined reference to `find_pcpusec'
>  kernel/built-in.o(.text+0x179a9): In function `load_module':
>  : undefined reference to `percpu_modalloc'
>  kernel/built-in.o(.text+0x17c52): In function `load_module':
>  : undefined reference to `percpu_modcopy'
>  kernel/built-in.o(.text+0x17d3d): In function `load_module':
>  : undefined reference to `percpu_modfree'

Well that is strange.  The functions are there, inlined, in the right
place.

static inline unsigned int find_pcpusec(Elf_Ehdr *hdr,
					Elf_Shdr *sechdrs,
					const char *secstrings)
{
	return 0;
}
static inline void percpu_modcopy(void *pcpudst, const void *src,
				  unsigned long size)
{
	/* pcpusec should be 0, and size of that section should be 0. */
	BUG_ON(size != 0);
}
static inline void percpu_modfree(void *freeme)
{
}

It compiles OK here, uniproc and SMP.  Possibly gcc-3.3 has done something
wrong, or differently.

Does your tree build OK with earlier compilers?
