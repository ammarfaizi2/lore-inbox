Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUBVXmR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 18:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUBVXmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 18:42:17 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:45009 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261236AbUBVXmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 18:42:15 -0500
Date: Mon, 23 Feb 2004 10:41:17 +1100
From: Nathan Scott <nathans@sgi.com>
To: R Dicaire <rdicair@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 and xfs compile errors
Message-ID: <20040222234117.GB3213@frodo>
References: <1077423230.1589.8.camel@ws.rdb.linux-help.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077423230.1589.8.camel@ws.rdb.linux-help.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 11:13:50PM -0500, R Dicaire wrote:
> While trying to compile 2.4.25, I get the following:
> 
> ld -m elf_i386 -T /usr/src/linux-2.4.25/arch/i386/vmlinux.lds -e stext
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> init/version.o init/do_mounts.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
> mm/mm.o fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
> drivers/net/net.o drivers/ide/idedriver.o drivers/cdrom/driver.o
> drivers/pci/driver.o drivers/video/video.o drivers/media/media.o
> drivers/md/mddev.o \
>         net/network.o \
>         /usr/src/linux-2.4.25/arch/i386/lib/lib.a
> /usr/src/linux-2.4.25/lib/lib.a
> /usr/src/linux-2.4.25/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> fs/fs.o(.text+0x6fa94): In function `xfs_bmap_add_attrfork_local':
> : undefined reference to `__constant_c_and_count_memset'
> fs/fs.o(.text+0x72d2b): In function `xfs_bmap_alloc':
> : undefined reference to `xfs_do_div'
> ...
> fs/fs.o(.text+0x78afe): In function `xfs_getbmap':
> : undefined reference to `__constant_copy_to_user'
> make: *** [vmlinux] Error 1

> gcc -v
> Reading specs from /usr/lib/gcc-lib/i486-slackware-linux/3.2.3/specs
> Configured with: ../gcc-3.2.3/configure --prefix=/usr --enable-shared
> --enable-threads=posix --enable-__cxa_atexit --disable-checking
> --with-gnu-ld --verbose --target=i486-slackware-linux
> --host=i486-slackware-linux
> Thread model: posix
> gcc version 3.2.3
> 

Looks like your compiler is getting confused by routines
that have been declared "static inline" in a header - you
probably need to upgrade/downgrade your compiler.

cheers.

-- 
Nathan
