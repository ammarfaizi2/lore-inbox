Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUGWLIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUGWLIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 07:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267634AbUGWLIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 07:08:51 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:44515 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S267633AbUGWLIr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 07:08:47 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.7: page allocation failure
Date: Fri, 23 Jul 2004 13:08:43 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407231308.44485.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we currently get every morning when the cron-jobs start up page allocation 
failures. Is this a memory leak in the kernel? What can I do to find out 
more about it, which information are helpful to this list. I guess that I 
should provide a sequenze of data of  
/proc/meminfo and /proc/vmstat from around this time? What else is 
required to debug this issue?


Cheers,
	Bernd


Jul 23 06:26:13 hamilton1 kernel: drbd0_worker: page allocation failure. order:2, mode:0x20
Jul 23 06:26:13 hamilton1 kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 23 06:26:13 hamilton1 kernel:  [__alloc_pages+699/816] __alloc_pages+0x2bb/0x330
Jul 23 06:26:13 hamilton1 kernel:  [__get_free_pages+39/64] __get_free_pages+0x27/0x40
Jul 23 06:26:13 hamilton1 kernel:  [kmem_getpages+32/208] kmem_getpages+0x20/0xd0
Jul 23 06:26:13 hamilton1 kernel:  [cache_grow+211/656] cache_grow+0xd3/0x290
Jul 23 06:26:13 hamilton1 kernel:  [cache_alloc_refill+416/624] cache_alloc_refill+0x1a0/0x270
Jul 23 06:26:13 hamilton1 kernel:  [__kmalloc+131/144] __kmalloc+0x83/0x90
Jul 23 06:26:13 hamilton1 kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Jul 23 06:26:13 hamilton1 kernel:  [pg0+945079627/1068118016] FillRxDescriptor+0x2b/0xc0 [sk98lin]
Jul 23 06:26:13 hamilton1 kernel:  [pg0+945079564/1068118016] FillRxRing+0x6c/0x80 [sk98lin]
Jul 23 06:26:13 hamilton1 kernel:  [pg0+945077761/1068118016] SkGePoll+0x81/0x110 [sk98lin]
Jul 23 06:26:13 hamilton1 kernel:  [net_rx_action+139/288] net_rx_action+0x8b/0x120
Jul 23 06:26:13 hamilton1 kernel:  [__do_softirq+170/176] __do_softirq+0xaa/0xb0
Jul 23 06:26:13 hamilton1 kernel:  [do_softirq+51/64] do_softirq+0x33/0x40
Jul 23 06:26:13 hamilton1 kernel:  [do_IRQ+325/416] do_IRQ+0x145/0x1a0
Jul 23 06:26:13 hamilton1 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 23 06:26:13 hamilton1 kernel:  [free_buffer_head+44/112] free_buffer_head+0x2c/0x70
Jul 23 06:26:13 hamilton1 kernel:  [try_to_free_buffers+129/224] try_to_free_buffers+0x81/0xe0
Jul 23 06:26:13 hamilton1 kernel:  [shrink_list+1088/1440] shrink_list+0x440/0x5a0
Jul 23 06:26:13 hamilton1 kernel:  [shrink_cache+408/1040] shrink_cache+0x198/0x410
Jul 23 06:26:13 hamilton1 kernel:  [shrink_caches+108/112] shrink_caches+0x6c/0x70
Jul 23 06:26:13 hamilton1 kernel:  [try_to_free_pages+162/368] try_to_free_pages+0xa2/0x170
Jul 23 06:26:13 hamilton1 kernel:  [__alloc_pages+436/816] __alloc_pages+0x1b4/0x330
Jul 23 06:26:13 hamilton1 kernel:  [__get_free_pages+39/64] __get_free_pages+0x27/0x40
Jul 23 06:26:13 hamilton1 kernel:  [kmem_getpages+32/208] kmem_getpages+0x20/0xd0
Jul 23 06:26:13 hamilton1 kernel:  [cache_grow+211/656] cache_grow+0xd3/0x290
Jul 23 06:26:13 hamilton1 kernel:  [cache_alloc_refill+416/624] cache_alloc_refill+0x1a0/0x270
Jul 23 06:26:13 hamilton1 kernel:  [__kmalloc+131/144] __kmalloc+0x83/0x90
Jul 23 06:26:13 hamilton1 kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Jul 23 06:26:13 hamilton1 kernel:  [tcp_sendmsg+2347/4320] tcp_sendmsg+0x92b/0x10e0
Jul 23 06:26:13 hamilton1 kernel:  [inet_sendmsg+75/96] inet_sendmsg+0x4b/0x60
Jul 23 06:26:13 hamilton1 kernel:  [sock_sendmsg+146/176] sock_sendmsg+0x92/0xb0
Jul 23 06:26:13 hamilton1 kernel:  [pg0+946741833/1068118016] drbd_send+0xb9/0x270 [drbd]
Jul 23 06:26:13 hamilton1 kernel:  [pg0+946736514/1068118016] _drbd_send_cmd+0xb2/0x140 [drbd]
Jul 23 06:26:13 hamilton1 kernel:  [pg0+946736856/1068118016] drbd_send_cmd+0xc8/0x220 [drbd]
Jul 23 06:26:13 hamilton1 kernel:  [pg0+946685520/1068118016] w_send_write_hint+0x40/0x50 [drbd]
Jul 23 06:26:13 hamilton1 kernel:  [pg0+946688649/1068118016] drbd_worker+0x339/0x40e [drbd]
Jul 23 06:26:13 hamilton1 kernel:  [pg0+946735146/1068118016] drbd_thread_setup+0x7a/0x110 [drbd]
Jul 23 06:26:13 hamilton1 kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Jul 23 06:26:13 hamilton1 kernel: 
Jul 23 06:26:13 hamilton1 kernel: nfsd: page allocation failure. order:2, mode:0x20
Jul 23 06:26:13 hamilton1 kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jul 23 06:26:13 hamilton1 kernel:  [__alloc_pages+699/816] __alloc_pages+0x2bb/0x330
Jul 23 06:26:13 hamilton1 kernel:  [__get_free_pages+39/64] __get_free_pages+0x27/0x40
Jul 23 06:26:13 hamilton1 kernel:  [kmem_getpages+32/208] kmem_getpages+0x20/0xd0
Jul 23 06:26:13 hamilton1 kernel:  [cache_grow+211/656] cache_grow+0xd3/0x290
Jul 23 06:26:13 hamilton1 kernel:  [cache_alloc_refill+416/624] cache_alloc_refill+0x1a0/0x270
Jul 23 06:26:13 hamilton1 kernel:  [__kmalloc+131/144] __kmalloc+0x83/0x90
Jul 23 06:26:13 hamilton1 kernel:  [alloc_skb+72/240] alloc_skb+0x48/0xf0
Jul 23 06:26:13 hamilton1 kernel:  [pg0+945079627/1068118016] FillRxDescriptor+0x2b/0xc0 [sk98lin]
Jul 23 06:26:13 hamilton1 kernel:  [pg0+945079564/1068118016] FillRxRing+0x6c/0x80 [sk98lin]
Jul 23 06:26:13 hamilton1 kernel:  [pg0+945077761/1068118016] SkGePoll+0x81/0x110 [sk98lin]
Jul 23 06:26:13 hamilton1 kernel:  [net_rx_action+139/288] net_rx_action+0x8b/0x120
Jul 23 06:26:13 hamilton1 kernel:  [__do_softirq+170/176] __do_softirq+0xaa/0xb0
Jul 23 06:26:13 hamilton1 kernel:  [do_softirq+51/64] do_softirq+0x33/0x40
Jul 23 06:26:13 hamilton1 kernel:  [do_IRQ+325/416] do_IRQ+0x145/0x1a0
Jul 23 06:26:13 hamilton1 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 23 06:26:13 hamilton1 kernel:  [nfsd+549/1104] nfsd+0x225/0x450
Jul 23 06:26:13 hamilton1 kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Jul 23 06:26:13 hamilton1 kernel: 



-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
