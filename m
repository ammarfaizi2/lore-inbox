Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbTIJGl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 02:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbTIJGl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 02:41:59 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:12947
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S261337AbTIJGl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 02:41:57 -0400
Date: Tue, 9 Sep 2003 23:41:58 -0700
To: linux-kernel@vger.kernel.org
Subject: bttv bug
Message-ID: <20030910064158.GA19930@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After upgrading to -test5, my bt878 card ceased to function properly. My
kernel is tainted with the nvidia kernel module but I know for a fact that 
bttv worked just fine not too long ago and I have not upgraded my nvidia
drivers since.

I have the following message in my dmesg:

kernel BUG at drivers/media/video/btcx-risc.c:66!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<e096b0a1>]    Tainted: P  
EFLAGS: 00010286
EIP is at btcx_riscmem_alloc+0xa1/0xb0 [btcx_risc]
eax: 00000000   ebx: 000008b8   ecx: cdaed000   edx: ce59a000
esi: db5607dc   edi: ce59a8b8   ebp: 00000280   esp: dbb95b54
ds: 007b   es: 007b   ss: 0068
Process motv (pid: 757, threadinfo=dbb94000 task=dc7c0140)
Stack: dfe8f054 000008b8 dbb95b64 00000020 0e59a000 00000280 00000000 db560740 
       e09b2a3e dfe8f000 db5607dc 000008b8 00000280 00012c00 db560740 00000001 
       e09b40f4 e09c1d00 db5607dc dd8cb400 00000000 00000280 00000000 000000f0 
Call Trace:
 [<e09b2a3e>] bttv_risc_packed+0x3e/0x150 [bttv]
 [<e09b40f4>] bttv_buffer_risc+0x514/0x630 [bttv]
 [<e0986846>] videobuf_waiton+0xb6/0xf0 [video_buf]
 [<e09ab194>] bttv_prepare_buffer+0x104/0x1a0 [bttv]
 [<e09ab2f2>] buffer_prepare+0x42/0x50 [bttv]
 [<e0986dc2>] videobuf_qbuf+0xa2/0x110 [video_buf]
 [<c044560f>] wait_hpet_tick+0xf/0x30
 [<e09ad769>] bttv_do_ioctl+0x1109/0x1410 [bttv]
 [<c013bb50>] __alloc_pages+0x90/0x300
 [<c0262bbd>] do_rw_taskfile+0x1bd/0x2b0
 [<c01456b2>] do_anonymous_page+0x122/0x230
 [<c0145df9>] handle_mm_fault+0xf9/0x190
 [<c011ab77>] try_to_wake_up+0xa7/0x150
 [<e0a530fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<e0a530fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<e0a71ee4>] __nvsym01575+0x28/0x34 [nvidia]
 [<e0a53179>] __nvsym01540+0x49/0x90 [nvidia]
 [<c011ab77>] try_to_wake_up+0xa7/0x150
 [<c011b66a>] default_wake_function+0x2a/0x30
 [<c011b3d0>] schedule+0x1c0/0x3e0
 [<c02c01f4>] kfree_skbmem+0x24/0x30
 [<c02c0282>] __kfree_skb+0x82/0x100
 [<c031b57d>] unix_stream_recvmsg+0x28d/0x580
 [<c011b61a>] preempt_schedule+0x2a/0x50
 [<c02bc798>] sock_aio_read+0xb8/0xd0
 [<c01520bb>] do_sync_read+0x8b/0xc0
 [<c044560f>] wait_hpet_tick+0xf/0x30
 [<c0258588>] video_usercopy+0xc8/0x1c0
 [<c044560f>] wait_hpet_tick+0xf/0x30
 [<c01649b0>] __pollwait+0x0/0xd0
 [<c0165094>] sys_select+0x234/0x4c0
 [<e09adaae>] bttv_ioctl+0x3e/0x70 [bttv]
 [<c044560f>] wait_hpet_tick+0xf/0x30
 [<e09ac660>] bttv_do_ioctl+0x0/0x1410 [bttv]
 [<c044560f>] wait_hpet_tick+0xf/0x30
 [<c01641e3>] sys_ioctl+0xf3/0x290
 [<c044560f>] wait_hpet_tick+0xf/0x30
 [<c010915b>] syscall_call+0x7/0xb
 [<c044560f>] wait_hpet_tick+0xf/0x30

Code: 0f 0b 42 00 e0 b5 96 e0 eb b7 90 8d 74 26 00 83 ec 18 89 7c 
 bttv0: skipped frame. no signal? high irq latency?

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
