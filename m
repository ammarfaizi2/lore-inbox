Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTEGMBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 08:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTEGMBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 08:01:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17362 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263185AbTEGMBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 08:01:39 -0400
Date: Wed, 7 May 2003 14:14:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>
Subject: kernel BUG at net/core/skbuff.c:1028!
Message-ID: <20030507121412.GI823@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Booting 2.5-BK on my little router BUG's out before the login is
reached. 100% reproduceable. Let me know if you want more detail.

kernel BUG at net/core/skbuff.c:1028!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0260774>]    Not tainted
EFLAGS: 00010206
EIP is at skb_checksum+0x244/0x260
eax: 00000000   ebx: 00000035   ecx: cee3a980   edx: cdbcfa80
esi: 00000014   edi: 00000049   ebp: c036dc9c   esp: c036dc78
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c036c000 task=c0326ca0)
Stack: cee3a8c0 00000206 cec76444 c036dc90 00000035 00000000 cdbcfa10
00000003 
       c036dda0 c036dcc8 c02ba71e cee3a980 00000049 00000049 b02e4fd1
cec764c0 
       cdbcfa24 cec76420 00000003 c036dda0 c036dd00 c02b9240 c036dda0
cec76420 
Call Trace:
 [<c02ba71e>] icmp_reply_translation+0x7e/0x220
 [<c02b9240>] ip_nat_fn+0x1e0/0x230
 [<c02b938f>] ip_nat_local_fn+0x5f/0xb0
 [<c0289010>] dst_output+0x0/0x30
 [<c026920c>] nf_iterate+0x5c/0xb0
 [<c0289010>] dst_output+0x0/0x30
 [<c02694f9>] nf_hook_slow+0x69/0x100
 [<c0289010>] dst_output+0x0/0x30
 [<c0288a19>] ip_push_pending_frames+0x329/0x3b0
 [<c0289010>] dst_output+0x0/0x30
 [<c02a87cf>] icmp_send+0x2bf/0x3b0
 [<c023c245>] __ide_dma_read+0xc5/0xe0
 [<c0234308>] do_rw_disk+0x6e8/0x800
 [<c022910f>] start_request+0x11f/0x180
 [<c0281323>] ipv4_link_failure+0x13/0x50
 [<c02a6753>] arp_error_report+0x63/0x70
 [<c0265e76>] neigh_timer_handler+0x96/0x180
 [<c0265de0>] neigh_timer_handler+0x0/0x180
 [<c011e2db>] run_timer_softirq+0x9b/0x150
 [<c010a731>] handle_IRQ_event+0x31/0xf0
 [<c011a96f>] do_softirq+0x6f/0xd0
 [<c010a9a5>] do_IRQ+0xc5/0xe0
 [<c01070d0>] default_idle+0x0/0x50
 [<c0109208>] common_interrupt+0x18/0x20
 [<c01070d0>] default_idle+0x0/0x50
 [<c01070f6>] default_idle+0x26/0x50
 [<c0107192>] cpu_idle+0x32/0x50
 [<c0105000>] _stext+0x0/0x20
 [<c036e6ca>] start_kernel+0x12a/0x130

Code: 0f 0b 04 04 99 f4 30 c0 8b 45 14 8d 65 f4 5b 5e 5f 5d c3 89 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


-- 
Jens Axboe

