Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVBXMQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVBXMQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVBXMQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:16:04 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:15499 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262300AbVBXMOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:14:49 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9: pptp: page allocation failure. order:1, mode:0x20
Date: Thu, 24 Feb 2005 13:14:46 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502241314.46421.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

this is probably already fixed for this happened on a:

-> uname -a
Linux gollum 2.6.9 #9 Fri Feb 18 12:12:42 CET 2005 i686 GNU/Linux

with the softwaresuspend patch of Nigel Cunningham and 
during a pretty heavy network load. The system remained stable after this so this seems
to be of minor concern but still ... Let me know if you need more sysinfo.

Regards,
Boris.


<snip>
Feb 24 12:57:52 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:395]: discarding duplicate or old packet 423215 (expecting 423216)
Feb 24 12:57:53 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:395]: discarding duplicate or old packet 423351 (expecting 423352)
Feb 24 12:57:53 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:395]: discarding duplicate or old packet 423363 (expecting 423364)
Feb 24 12:57:53 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:395]: discarding duplicate or old packet 423391 (expecting 423392)
Feb 24 12:57:53 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:395]: discarding duplicate or old packet 423397 (expecting 423398)
Feb 24 12:57:54 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423553 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423554 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423555 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423556 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423557 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423558 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423559 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423560 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423561 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423562 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423563 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423564 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423565 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423566 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423567 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum pptp[3888]: anon warn[pqueue_add:pqueue.c:139]: discarding duplicate packet 423585
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum kernel: pptp: page allocation failure. order:1, mode:0x20
Feb 24 12:57:55 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
Feb 24 12:57:55 gollum kernel:  [__alloc_pages+480/944] __alloc_pages+0x1e0/0x3b0
Feb 24 12:57:55 gollum kernel:  [__get_free_pages+34/80] __get_free_pages+0x22/0x50
Feb 24 12:57:55 gollum kernel:  [kmem_getpages+38/352] kmem_getpages+0x26/0x160
Feb 24 12:57:55 gollum kernel:  [cache_grow+347/976] cache_grow+0x15b/0x3d0
Feb 24 12:57:55 gollum kernel:  [cache_alloc_refill+613/912] cache_alloc_refill+0x265/0x390
Feb 24 12:57:55 gollum kernel:  [__kmalloc+178/224] __kmalloc+0xb2/0xe0
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423622 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Feb 24 12:57:55 gollum kernel:  [pg0+541149689/1068446720] ppp_async_input+0x299/0x340 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pg0+541144653/1068446720] ppp_asynctty_receive+0x9d/0x1f0 [ppp_async]
Feb 24 12:57:55 gollum kernel:  [pty_write+243/336] pty_write+0xf3/0x150
Feb 24 12:57:55 gollum kernel:  [write_chan+528/576] write_chan+0x210/0x240
Feb 24 12:57:55 gollum kernel:  [tty_write+972/1360] tty_write+0x3cc/0x550
Feb 24 12:57:55 gollum kernel:  [vfs_write+207/320] vfs_write+0xcf/0x140
Feb 24 12:57:55 gollum kernel:  [sys_write+75/128] sys_write+0x4b/0x80
Feb 24 12:57:55 gollum kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 12:57:55 gollum kernel: PPPasync: no memory (input pkt)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423623 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423624 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423625 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423626 (expecting 423547, lost or reordered)
Feb 24 12:57:55 gollum pptp[3888]: anon log[decaps_gre:pptp_gre.c:404]: buffering packet 423627 (expecting 423547, lost or reordered)
</snip>
