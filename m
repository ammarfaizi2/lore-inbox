Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266068AbSKFUaK>; Wed, 6 Nov 2002 15:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266072AbSKFUaK>; Wed, 6 Nov 2002 15:30:10 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:707 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S266068AbSKFUaI>; Wed, 6 Nov 2002 15:30:08 -0500
Date: Wed, 6 Nov 2002 21:36:44 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>
Subject: 2.5.46 crashes (TCP / VM / acenic ?)
Message-ID: <20021106213644.B12287@cistron.nl>
References: <aq8r78$v1m$1@ncc1701.cistron.net> <3DC7F38F.6D8CB0E2@digeo.com> <20021105175956.A29826@cistron.nl> <3DC7FBBD.6E8AABD3@digeo.com> <20021105234728.A12569@cistron.nl> <3DC84CC3.B323E9D@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DC84CC3.B323E9D@digeo.com>; from akpm@digeo.com on Tue, Nov 05, 2002 at 02:57:07PM -0800
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying 2.5.x on and off on our newsserver. It's a dual
PIII/450, 1 GB RAM, acenic GigE adapter, and it does lots
of I/O: 40 mbit/sec sustained in, 110 mbit/sec sustained out,
all from/to disk and history database.

Under 2.4.x the box is dead stable.

But in 2.5, after a few hours the box usually spontaneously
reboots. Last night it didn't reboot, it just hung after a:

Attempt to release TCP socket in state 1 ce921b40
Attempt to release TCP socket in state 1 ce921b40
Attempt to release TCP socket in state 1 ce921b40
Attempt to release TCP socket in state 1 ce921b40
Attempt to release TCP socket in state 1 ce921b40
Attempt to release TCP socket in state 1 ce921b40
Attempt to release TCP socket in state 1 ce921b40

I tried again today and it crashed, produced a nice (slightly
garbled, alas) crash message and rebooted.

Log is below. c1a15abe etc addresses are outside of anything in
System.map, and the only module I have loaded is the acenic
module. Could that be the problem ?

Unable to handle kernel paging request at virtual address a15ac0c1
 printing eip:
c1a15abe
*pde = 00000000
Oops: 0000
eepro100 mii acenic  <
>ACttPeU:m p t   t0o
eElIePa:s e  T C P0 0s60o:c[k<ect 1ian15 sabte>at]e   1   fN7ot7 28ta4i00n
ed
EFLAGS: 00010286
EIP is at E ipv4_config_Rsmp_26b99782+0x15d243e/0xffddb400
eax: b8c1a15a   ebx: c1a15ab0   ecx: c1a15ab8   edx: c0122d4f
esi: c1a144e0   edi: f772e000   ebp: c1a15ac0   esp: f772fbd8
ds: 0068   es: 0068   ss: 0068
Process innd (pid: 220, threadinfo=f772e000 task=f774d360)
Stack: c1a15ac0 c1a15500 00000000 f772e000 00000001 c1a15ab8 c011f7d5 00000000
       00000001 c03d1660 fffffffe 00000000 c03f1424 c03f1424 c011f4da c03d1660
       00000000 00000000 f772fc40 00001000 00000046 c0112adf caec2c80 d8e75660
Call Trace:
 [<c011f7d5>] tasklet_hi_action+0x85/0xe0
 [<c011f4da>] do_softirq+0x5a/0xac
 [<c0112adf>] smp_apic_timer_interrupt+0x113/0x124
 [<c0109476>] apic_timer_interrupt+0x1a/0x20
 [<c0148934>] bio_add_page+0xd0/0x114
 [<c0160b66>] do_mpage_readpage+0x22e/0x2a0
 [<c0226100>] nf_hook_slow+0x118/0x1c4
 [<c012ec41>] add_to_page_cache+0x39/0xd8
 [<c0160c52>] mpage_readpages+0x7a/0x11c
 [<c018b8f4>] ext2_get_block+0x0/0x3c8
 [<c0241073>] tcp_cwnd_restart+0x17/0x98
 [<c02415f7>] tcp_transmit_skb+0x503/0x5b0
 [<c018bcfd>] ext2_readpages+0x19/0x20
 [<c018b8f4>] ext2_get_block+0x0/0x3c8
 [<c013ccd4>] read_pages+0x38/0x104
 [<c01373f5>] buffered_rmqueue+0x101/0x110
 [<c01374b2>] __alloc_pages+0xae/0x288
 [<c013cefb>] do_page_cache_readahead+0x15b/0x180
 [<c013cff2>] page_cache_readahead+0xd2/0x124
 [<c013d085>] page_cache_readaround+0x41/0x48
 [<c012fd64>] filemap_nopage+0xdc/0x2b4
 [<c012cbeb>] do_no_page+0x7b/0x27c
 [<c012b474>] pte_alloc_map+0xdc/0xf4
 [<c012ce71>] handle_mm_fault+0x85/0x130
 [<c0114247>] do_page_fault+0x137/0x434
 [<c0114110>] do_page_fault+0x0/0x434
 [<c019aa4f>] copy_to_user+0x33/0x40
 [<c011ee79>] sys_gettimeofday+0x25/0x54
 [<c01094f1>] error_code+0x2d/0x38

Code: 39 e9 c0 5a a1 c1 00 00 00 00 c8 5a a1 c1 c8 5a a1 c1 44 31
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 30 seconds..

