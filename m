Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUA0AO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUA0AO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:14:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:2186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265692AbUA0AOw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:14:52 -0500
Date: Mon, 26 Jan 2004 16:16:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: David =?ISO-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at include/linux/list.h:148!
Message-Id: <20040126161615.143b23b2.akpm@osdl.org>
In-Reply-To: <200401270042.02840.ender@debian.org>
References: <200401270042.02840.ender@debian.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Martínez Moreno <ender@debian.org> wrote:
>
> 	Hello, I'm using -mm branch since 2.6.0-pre kernels, and now I'm finding
> problems (well, *another* type of problems) since 2.6.1-rc1-mm2. Last kernel
> without this error was 2.6.1-rc2-mm1.
> 
> 	The error is always the same (at least to me, poor non kernel-hacker):
> 
> ------------[ cut here ]------------
> kernel BUG at include/linux/list.h:148!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c012ee1d>]    Not tainted VLI
> EFLAGS: 00010203
> EIP is at __remove_from_page_cache+0x71/0x7b
> eax: c13e22b8   ebx: dd2058bc   ecx: c13e22c0   edx: c1122c90
> esi: c13e22b8   edi: dfdb5e60   ebp: dd2058bc   esp: dfdb5d88
> ds: 007b   es: 007b   ss: 0068
> Process kswapd0 (pid: 8, threadinfo=dfdb4000 task=dfdbace0)
> Stack: dd2058c0 000145cd 00000001 c13e22b8 c0137e0b c13e22b8 c02fce0a d6df1480
>        00000001 000000b1 00000000 dfdb5db4 dfdb5db4 dfdb5dc0 00000003 c04ade88
>        00000001 c10502f8 c03d58b4 00000003 c04b0560 00000001 00000001 c13a7c80
> Call Trace:
>  [<c0137e0b>] shrink_list+0x2c0/0x476
>  [<c02fce0a>] __kfree_skb+0x68/0xd9
>  [<c013813f>] shrink_cache+0x17e/0x2df
>  [<c015b74b>] shrink_dcache_memory+0x23/0x25
>  [<c0137a76>] shrink_slab+0x11b/0x15e

Someone else was seeing something similar.  Reverting

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm1/broken-out/sysfs-pin-kobject.patch

apparently fixed it.

