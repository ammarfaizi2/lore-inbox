Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWBIWkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWBIWkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 17:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWBIWkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 17:40:42 -0500
Received: from btr0x1.rz.uni-bayreuth.de ([132.180.8.29]:53228 "EHLO
	btr0x1.rz.uni-bayreuth.de") by vger.kernel.org with ESMTP
	id S1750701AbWBIWkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 17:40:41 -0500
From: Andreas Herrmann <Andreas.Herrmann@uni-bayreuth.de>
To: linux-kernel@vger.kernel.org
Subject: Probably a BUG: kswapd0[116] exited with preempt_count 1
Date: Thu, 9 Feb 2006 23:40:36 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602092340.36427.andreas.herrmann@uni-bayreuth.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got probably a kernel bug on my servers. I'm using following kernel:
Linux mrpink 2.6.15 #2 PREEMPT Tue Jan 3 15:03:06 CET 2006 i686 Pentium II (Deschutes) GenuineIntel GNU/Linux

After an uptime of about 33 days the server, only used for Heimdal kerberos and OpenLDAP, crashed partly and I found this error log:

Feb  6 07:16:37 mrpink Unable to handle kernel NULL pointer dereference at virtual address 00000010
Feb  6 07:16:37 mrpink printing eip:
Feb  6 07:16:37 mrpink c0132830
Feb  6 07:16:37 mrpink *pde = 00000000
Feb  6 07:16:37 mrpink Oops: 0000 [#1]
Feb  6 07:16:37 mrpink PREEMPT
Feb  6 07:16:37 mrpink Modules linked in:
Feb  6 07:16:37 mrpink CPU:    0
Feb  6 07:16:37 mrpink EIP:    0060:[<c0132830>]    Not tainted VLI
Feb  6 07:16:37 mrpink EFLAGS: 00010093   (2.6.15)
Feb  6 07:16:37 mrpink EIP is at find_get_pages+0x35/0x61
Feb  6 07:16:37 mrpink eax: 8000082c   ebx: 00000004   ecx: 00000001   edx: 00000010
Feb  6 07:16:37 mrpink esi: cfcd9e48   edi: cfcd8000   ebp: 00000000   esp: cfcd9e0c
Feb  6 07:16:37 mrpink ds: 007b   es: 007b   ss: 0068
Feb  6 07:16:37 mrpink Process kswapd0 (pid: 116, threadinfo=cfcd8000 task=cfcd1a70)
Feb  6 07:16:37 mrpink Stack: cfcd9e40 00000000 c013ad82 c2dc4770 00000000 0000000e cfcd9e48 c2dc46d0
Feb  6 07:16:37 mrpink c013b100 cfcd9e40 c2dc4770 00000000 0000000e 00000000 00000000 c1159ee0
Feb  6 07:16:37 mrpink 00000010 00000010 00000010 c4d36b88 c011b678 c01044c6 c0102fca c4d36b88
Feb  6 07:16:37 mrpink Call Trace:
Feb  6 07:16:37 mrpink [<c013ad82>] pagevec_lookup+0x1a/0x21
Feb  6 07:16:37 mrpink [<c013b100>] invalidate_mapping_pages+0x9c/0xb1
Feb  6 07:16:37 mrpink [<c011b678>] irq_exit+0x29/0x34
Feb  6 07:16:37 mrpink [<c01044c6>] do_IRQ+0x1e/0x24
Feb  6 07:16:37 mrpink [<c0102fca>] common_interrupt+0x1a/0x20
Feb  6 07:16:37 mrpink [<c013b122>] invalidate_inode_pages+0xd/0x11
Feb  6 07:16:37 mrpink [<c016036f>] prune_icache+0xdb/0x193
Feb  6 07:16:37 mrpink [<c016043f>] shrink_icache_memory+0x18/0x30
Feb  6 07:16:37 mrpink [<c013b4fa>] shrink_slab+0x13c/0x197
Feb  6 07:16:37 mrpink [<c013c660>] balance_pgdat+0x216/0x347
Feb  6 07:16:37 mrpink [<c013c87e>] kswapd+0xed/0xf2
Feb  6 07:16:37 mrpink [<c0127db2>] autoremove_wake_function+0x0/0x3a
Feb  6 07:16:37 mrpink [<c01024da>] ret_from_fork+0x6/0x14
Feb  6 07:16:37 mrpink [<c0127db2>] autoremove_wake_function+0x0/0x3a
Feb  6 07:16:37 mrpink [<c013c791>] kswapd+0x0/0xf2
Feb  6 07:16:37 mrpink [<c0100d25>] kernel_thread_helper+0x5/0xb
Feb  6 07:16:37 mrpink Code: ff ff 21 e0 ff 40 14 ff 74 24 14 ff 74 24 14 56 8b 44 24 18 83 c0 04 50 e8 b8 1c 0b 00 89 c3 31 c9 83 c4 10 39 d9 73 13 8b 14 8e <8b> 02 f6 c4 40 74 03 8b 52 0c ff 42 04 41 eb e9 fb b8 00 e0 ff
Feb  6 07:16:37 mrpink <6>note: kswapd0[116] exited with preempt_count 1

If you need more information feel free to ask. But for first steps it should be enough.

Andi
