Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbUAZXrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUAZXqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:46:47 -0500
Received: from smtp02.ya.com ([62.151.11.161]:12198 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S265406AbUAZXpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:45:53 -0500
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: kernel BUG at include/linux/list.h:148!
Date: Tue, 27 Jan 2004 00:42:02 +0100
User-Agent: KMail/1.5.4
Cc: ender@debian.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401270042.02840.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, I'm using -mm branch since 2.6.0-pre kernels, and now I'm finding
problems (well, *another* type of problems) since 2.6.1-rc1-mm2. Last kernel
without this error was 2.6.1-rc2-mm1.

	The error is always the same (at least to me, poor non kernel-hacker):

------------[ cut here ]------------
kernel BUG at include/linux/list.h:148!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c012ee1d>]    Not tainted VLI
EFLAGS: 00010203
EIP is at __remove_from_page_cache+0x71/0x7b
eax: c13e22b8   ebx: dd2058bc   ecx: c13e22c0   edx: c1122c90
esi: c13e22b8   edi: dfdb5e60   ebp: dd2058bc   esp: dfdb5d88
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=dfdb4000 task=dfdbace0)
Stack: dd2058c0 000145cd 00000001 c13e22b8 c0137e0b c13e22b8 c02fce0a d6df1480
       00000001 000000b1 00000000 dfdb5db4 dfdb5db4 dfdb5dc0 00000003 c04ade88
       00000001 c10502f8 c03d58b4 00000003 c04b0560 00000001 00000001 c13a7c80
Call Trace:
 [<c0137e0b>] shrink_list+0x2c0/0x476
 [<c02fce0a>] __kfree_skb+0x68/0xd9
 [<c013813f>] shrink_cache+0x17e/0x2df
 [<c015b74b>] shrink_dcache_memory+0x23/0x25
 [<c0137a76>] shrink_slab+0x11b/0x15e
 [<c0138b4a>] balance_pgdat+0x18e/0x21e
 [<c0138cec>] kswapd+0x112/0x122
 [<c011add5>] autoremove_wake_function+0x0/0x4f
 [<c011add5>] autoremove_wake_function+0x0/0x4f
 [<c0138bda>] kswapd+0x0/0x122
 [<c0108d45>] kernel_thread_helper+0x5/0xb

Code: 01 10 00 c7 46 10 00 00 00 00 83 6b 30 01 83 05 80 04 4b c0 ff 8b 74 24 0c 8b 5c 24 08 83 c4 10 c3 0f 0b 95 00 f6 e8 38 c0 eb c5 <0f> 0b 94 00 f6 e8 38 c0 eb b3 8b 54 24 04 8b 02 f7 d0 a8 01 75

	This error, for example, is printed with the server's current kernel,
2.6.2-rc1-mm1.

	The machine is P4 with XFS over RAID0 by software, Apache2 in thread mode,
and root filesystem on ext3.

	Please don't hesitate to request further info.

	Kind regards,


		Ender.

