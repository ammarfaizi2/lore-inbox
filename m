Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUA0PXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUA0PXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:23:51 -0500
Received: from chico.rediris.es ([130.206.1.3]:58361 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S264420AbUA0PXr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:23:47 -0500
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kernel BUG at include/linux/list.h:148!
Date: Tue, 27 Jan 2004 16:23:41 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, ender@debian.org
References: <200401270042.02840.ender@debian.org> <20040126161615.143b23b2.akpm@osdl.org>
In-Reply-To: <20040126161615.143b23b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401271623.41932.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Martes, 27 de Enero de 2004 01:16, Andrew Morton escribió:

	Andrew, sorry, but it seems that sysfs-pin-object is not guilty:

[...]
b44: eth0: Flow control is on for TX and on for RX.
eth0: no IPv6 routers present
- ------------[ cut here ]------------
kernel BUG at include/linux/list.h:148!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c012ee1d>]    Not tainted VLI
EFLAGS: 00010202
EIP is at __remove_from_page_cache+0x71/0x7b
eax: c13e22b8   ebx: c844b13c   ecx: c13e22c0   edx: c12ed480
esi: c13e22b8   edi: dfdb5e60   ebp: c844b13c   esp: dfdb5d88
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=dfdb4000 task=dfdbace0)
Stack: c844b140 00005850 00000001 c13e22b8 c0137e0b c13e22b8 c02fcdbe cc636380
       00000001 00000029 00000000 dfdb5db4 dfdb5db4 dfdb5dc0 0000012c 00000001
       00000001 c10e73b0 c03d58b4 00000001 c04b05c0 00000009 00000001 c114a078
Call Trace:
 [<c0137e0b>] shrink_list+0x2c0/0x476
 [<c02fcdbe>] __kfree_skb+0x68/0xd9
 [<c013813f>] shrink_cache+0x17e/0x2df
 [<c0138774>] shrink_zone+0x77/0x9b
 [<c0138b4a>] balance_pgdat+0x18e/0x21e
 [<c0138cec>] kswapd+0x112/0x122
 [<c011add5>] autoremove_wake_function+0x0/0x4f
 [<c011add5>] autoremove_wake_function+0x0/0x4f
 [<c0138bda>] kswapd+0x0/0x122
 [<c0108d45>] kernel_thread_helper+0x5/0xb

Code: 01 10 00 c7 46 10 00 00 00 00 83 6b 30 01 83 05 80 04 4b c0 ff 8b 74 24 0c 8b 5c 24 08 83 c4 10 c3 0f 0b 95 00 96 e8 38 c0 eb c5 <0f> 0b 94 00 96 e8 38 c0 eb b3 8b 54 24 04 8b 02 f7 d0 a8 01 75

	The box keeps running, but it seems that starts to
degrade itself until becomes unresponsive.

	Now it's running 2.6.2-rc1-mm1 without sysfs-pin-kobject.patch.

	Any other hint?

> David Martínez Moreno <ender@debian.org> wrote:
> > 	Hello, I'm using -mm branch since 2.6.0-pre kernels, and now I'm finding
> > problems (well, *another* type of problems) since 2.6.1-rc1-mm2. Last
> > kernel without this error was 2.6.1-rc2-mm1.
> >
> > 	The error is always the same (at least to me, poor non kernel-hacker):
> >
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/list.h:148!
> > invalid operand: 0000 [#1]
> > CPU:    0
> > EIP:    0060:[<c012ee1d>]    Not tainted VLI
> > EFLAGS: 00010203
> > EIP is at __remove_from_page_cache+0x71/0x7b
> > eax: c13e22b8   ebx: dd2058bc   ecx: c13e22c0   edx: c1122c90
> > esi: c13e22b8   edi: dfdb5e60   ebp: dd2058bc   esp: dfdb5d88
> > ds: 007b   es: 007b   ss: 0068
> > Process kswapd0 (pid: 8, threadinfo=dfdb4000 task=dfdbace0)
> > Stack: dd2058c0 000145cd 00000001 c13e22b8 c0137e0b c13e22b8 c02fce0a
> > d6df1480 00000001 000000b1 00000000 dfdb5db4 dfdb5db4 dfdb5dc0 00000003
> > c04ade88 00000001 c10502f8 c03d58b4 00000003 c04b0560 00000001 00000001
> > c13a7c80 Call Trace:
> >  [<c0137e0b>] shrink_list+0x2c0/0x476
> >  [<c02fce0a>] __kfree_skb+0x68/0xd9
> >  [<c013813f>] shrink_cache+0x17e/0x2df
> >  [<c015b74b>] shrink_dcache_memory+0x23/0x25
> >  [<c0137a76>] shrink_slab+0x11b/0x15e
>
> Someone else was seeing something similar.  Reverting
>
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.
>6.2-rc1-mm1/broken-out/sysfs-pin-kobject.patch
>
> apparently fixed it.

- -- 
Yes I'm old. Old enough to remember when the MCP was just a chess program!
		-- Dumont (Tron)
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.51.50
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAFoJ9Ws/EhA1iABsRAv1RAJ0ZKC74oEWXWpU/JtDdSozixeGgHACglUUe
20+W3HIHAgSZIv4I8hXeLHM=
=s8BQ
-----END PGP SIGNATURE-----

