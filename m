Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWIXMTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWIXMTf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 08:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWIXMTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 08:19:35 -0400
Received: from cweiske.de ([80.237.146.62]:21379 "EHLO mail.cweiske.de")
	by vger.kernel.org with ESMTP id S1750718AbWIXMTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 08:19:34 -0400
Message-ID: <451677FE.2070409@cweiske.de>
Date: Sun, 24 Sep 2006 14:20:14 +0200
From: Christian Weiske <cweiske@cweiske.de>
User-Agent: My own hands[TM] Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference
 at virtual address 000,0000a
References: <45155915.7080107@cweiske.de> <20060923134244.e7b73826.akpm@osdl.org>
In-Reply-To: <20060923134244.e7b73826.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1BB5663EFA1E5E320E96A859"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1BB5663EFA1E5E320E96A859
Content-Type: multipart/mixed;
 boundary="------------070006030200090102080806"

This is a multi-part message in MIME format.
--------------070006030200090102080806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andrew,

> It would be interesting to find out if enabling CONFIG_4KSTACKS makes t=
his
> go away (although I'm not sure why).
So, here are the results from the 4K runs:

Beside one Oops message, I got a "kernel BUG at mm/slab.c:2747!" in log
#1. Call traces as usual.

Further, logs #2 and #3 show funny things; the thing just rebooted. Log
#2 has some oversized ethernet frames before the reboot.



Sorry for the CC, I thought you were subscribed to lkml and removed you.

--=20
Regards/MfG,
Christian Weiske

--------------070006030200090102080806
Content-Type: text/plain;
 name="dojo kernelpanic debug 4k 1.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dojo kernelpanic debug 4k 1.log"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: possible recursive locking detected ]
---------------------------------------------
java/6750 is trying to acquire lock:
 (slock-AF_INET6){-+..}, at: [<c03be6f4>] sk_clone+0xf4/0x310

but task is already holding lock:
 (slock-AF_INET6){-+..}, at: [<c0444eaf>] tcp_v6_rcv+0x34f/0x6f0

other info that might help us debug this:
1 lock held by java/6750:
 #0:  (slock-AF_INET6){-+..}, at: [<c0444eaf>] tcp_v6_rcv+0x34f/0x6f0

stack backtrace:
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0131454>] print_deadlock_bug+0xa4/0xb0
 [<c01314ca>] check_deadlock+0x6a/0x80
 [<c0132cf7>] __lock_acquire+0x4f7/0x950
 [<c01337cd>] lock_acquire+0x5d/0x80
 [<c0483415>] _spin_lock+0x25/0x30
 [<c03be6f4>] sk_clone+0xf4/0x310
 [<c03e6b31>] inet_csk_clone+0x11/0x70
 [<c03fb3c5>] tcp_create_openreq_child+0x15/0x3e0
 [<c04442c2>] tcp_v6_syn_recv_sock+0x142/0x610
 [<c03fb8a9>] tcp_check_req+0x119/0x420
 [<c0443d75>] tcp_v6_hnd_req+0x45/0x130
 [<c0444af7>] tcp_v6_do_rcv+0x247/0x2b0
 [<c0445136>] tcp_v6_rcv+0x5d6/0x6f0
 [<c04272df>] ip6_input+0x16f/0x340
 [<c0427004>] ipv6_rcv+0x114/0x280
 [<c03c6eb1>] netif_receive_skb+0x1b1/0x1f0
 [<c03c6f80>] process_backlog+0x90/0x120
 [<c03c707d>] net_rx_action+0x6d/0x100
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d5d9>] local_bh_enable_ip+0xb9/0x100
 [<c0483661>] _spin_unlock_bh+0x31/0x40
 [<c03bf750>] release_sock+0x50/0xb0
 [<c0405647>] inet_wait_for_connect+0x67/0xd0
 [<c0405748>] inet_stream_connect+0x98/0x1d0
 [<c03bc6d7>] sys_connect+0x67/0xa0
 [<c03bd1c6>] sys_socketcall+0xc6/0x1e0
 [<c0102e77>] syscall_call+0x7/0xb
Slab corruption: start=3Dc62fae5c, len=3D172
Redzone: 0x6b6b6b6b/0xc0411ac8.
Last user: [<170fc2a5>](0x170fc2a5)
0a0: 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a
Prev obj: start=3Dc62facf8, len=3D172
Redzone: 0xc0d36b48/0xc04110a0.
Last user: [<0000000e>](0xe)
000: 90 6a d3 c0 f3 81 01 00 80 11 41 c0 ec ac 2f c6
010: e0 1c 61 c0 00 00 00 00 00 00 00 00 33 02 00 00
slab error in cache_alloc_debugcheck_after(): cache `ip_conntrack': doubl=
e freen
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0160d81>] __slab_error+0x21/0x30
 [<c0162e11>] cache_alloc_debugcheck_after+0x121/0x1a0
 [<c016316b>] kmem_cache_alloc+0x6b/0xc0
 [<c04119bc>] ip_conntrack_alloc+0x3c/0x130
 [<c0411afa>] init_conntrack+0x2a/0x110
 [<c0411dbe>] ip_conntrack_in+0x1de/0x230
 [<c03d7707>] nf_iterate+0x57/0xa0
 [<c03d77a6>] nf_hook_slow+0x56/0xe0
 [<c03dd3c9>] ip_rcv+0x239/0x440
 [<c03c6eb1>] netif_receive_skb+0x1b1/0x1f0
 [<c03c6f80>] process_backlog+0x90/0x120
 [<c03c707d>] net_rx_action+0x6d/0x100
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d773>] irq_exit+0x53/0x60
 [<c0104c5a>] do_IRQ+0x6a/0xb0
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e30b>] memcpy+0x3b/0x50
 [<c028e378>] memmove+0x38/0x50
 [<c01bf9cd>] leaf_paste_in_buffer+0x7d/0x320
 [<c01a879c>] balance_leaf+0x24c/0x27d0
 [<c01ab050>] do_balance+0x60/0xf0
 [<c01c5854>] reiserfs_paste_into_item+0x164/0x190
 [<c01b3c25>] reiserfs_allocate_blocks_for_region+0x925/0x12e0
 [<c01b5c9c>] reiserfs_file_write+0x72c/0x7c0
 [<c01668d8>] vfs_write+0x88/0x170
 [<c0166a6c>] sys_write+0x3c/0x70
 [<c0102e77>] syscall_call+0x7/0xb
c62fae58: redzone 1:0x6b6b6b6b, redzone 2:0xc0411ac8
------------[ cut here ]------------
kernel BUG at mm/slab.c:2747!
invalid opcode: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c01629d1>]    Not tainted VLI
EFLAGS: 00010087   (2.6.18 #3)
EIP is at cache_free_debugcheck+0x241/0x250
eax: 0113bcc5   ebx: 00010c00   ecx: 000000b8   edx: cf660500
esi: 00000014   edi: c62fae58   ebp: c05f7f70   esp: c05f7f5c
ds: 007b   es: 007b   ss: 0068
Process java (pid: 6848, ti=3Dc05f7000 task=3Dc6934b00 task.ti=3Dc69e6000=
)
Stack: 0113bcc5 c62fa040 c13dc7d8 c62fae5c cf660500 c05f7f94 c0163581 cf6=
60500
       c62fae5c c0411ac8 00000246 c62fae5c c69ad904 00000009 c05f7fa4 c04=
11ac8
       cf660500 c62fae5c c05f7fb4 c0411131 c62fae5c cd8acb30 c05f7fc8 c03=
c06b4
Call Trace:
 [<c010354e>] show_stack_log_lvl+0x8e/0xb0
 [<c010370a>] show_registers+0x14a/0x1d0
 [<c0103987>] die+0x167/0x210
 [<c0103aac>] do_trap+0x7c/0xc0
 [<c0103d40>] do_invalid_op+0x90/0xa0
 [<c0103199>] error_code+0x39/0x40
 [<c0163581>] kmem_cache_free+0x61/0xf0
 [<c0411ac8>] ip_conntrack_free+0x18/0x20
 [<c0411131>] destroy_conntrack+0x91/0xe0
 [<c03c06b4>] __kfree_skb+0x74/0xf0
 [<c03c6c36>] net_tx_action+0x56/0x120
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d773>] irq_exit+0x53/0x60
 [<c0104c5a>] do_IRQ+0x6a/0xb0
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e30b>] memcpy+0x3b/0x50
 [<c028e378>] memmove+0x38/0x50
 [<c01bf9cd>] leaf_paste_in_buffer+0x7d/0x320
 [<c01a879c>] balance_leaf+0x24c/0x27d0
 [<c01ab050>] do_balance+0x60/0xf0
 [<c01c5854>] reiserfs_paste_into_item+0x164/0x190
 [<c01b3c25>] reiserfs_allocate_blocks_for_region+0x925/0x12e0
 [<c01b5c9c>] reiserfs_file_write+0x72c/0x7c0
 [<c01668d8>] vfs_write+0x88/0x170
 [<c0166a6c>] sys_write+0x3c/0x70
 [<c0102e77>] syscall_call+0x7/0xb
Code: 47 ff ff ff e9 68 ff ff ff 0f 0b 60 02 cd e6 4a c0 e9 1b fe ff ff 8=
b 52 0
EIP: [<c01629d1>] cache_free_debugcheck+0x241/0x250 SS:ESP 0068:c05f7f5c
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 <3>Slab corruption: start=3Dc62a8d58, len=3D2048
Redzone: 0x6b6b6b6b/0xc03c0543.
Last user: [<170fc2a5>](0x170fc2a5)
7f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a
Prev obj: start=3Dc62a8487, len=3D2048
Redzone: 0x0/0x5a5a5a5a.
Last user: [<5a5a5a5a>](0x5a5a5a5a)
000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double f=
ree, on
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0160d81>] __slab_error+0x21/0x30
 [<c0162e11>] cache_alloc_debugcheck_after+0x121/0x1a0
 [<c01634c8>] __kmalloc_track_caller+0xa8/0x100
 [<c03c029d>] __alloc_skb+0x4d/0x110
 [<c030438b>] rhine_rx+0x29b/0x490
 [<c0303db3>] rhine_interrupt+0x193/0x240
 [<c0144807>] handle_IRQ_event+0x27/0x70
 [<c01448d3>] __do_IRQ+0x83/0x110
 [<c0104c53>] do_IRQ+0x63/0xb0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0103145>] common_interrupt+0x25/0x30
 [<c0103a21>] die+0x201/0x210
 [<c0103aac>] do_trap+0x7c/0xc0
 [<c0103d40>] do_invalid_op+0x90/0xa0
 [<c0103199>] error_code+0x39/0x40
 [<c0163581>] kmem_cache_free+0x61/0xf0
 [<c0411ac8>] ip_conntrack_free+0x18/0x20
 [<c0411131>] destroy_conntrack+0x91/0xe0
 [<c03c06b4>] __kfree_skb+0x74/0xf0
 [<c03c6c36>] net_tx_action+0x56/0x120
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d773>] irq_exit+0x53/0x60
 [<c0104c5a>] do_IRQ+0x6a/0xb0
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e30b>] memcpy+0x3b/0x50
 [<c028e378>] memmove+0x38/0x50
 [<c01bf9cd>] leaf_paste_in_buffer+0x7d/0x320
 [<c01a879c>] balance_leaf+0x24c/0x27d0
 [<c01ab050>] do_balance+0x60/0xf0
 [<c01c5854>] reiserfs_paste_into_item+0x164/0x190
 [<c01b3c25>] reiserfs_allocate_blocks_for_region+0x925/0x12e0
 [<c01b5c9c>] reiserfs_file_write+0x72c/0x7c0
 [<c01668d8>] vfs_write+0x88/0x170
 [<c0166a6c>] sys_write+0x3c/0x70
 [<c0102e77>] syscall_call+0x7/0xb
c62a8d54: redzone 1:0x6b6b6b6b, redzone 2:0xc03c0543
 
--------------070006030200090102080806
Content-Type: text/plain;
 name="dojo kernelpanic debug 4k 2.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dojo kernelpanic debug 4k 2.log"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: possible recursive locking detected ]
---------------------------------------------
java/6736 is trying to acquire lock:
 (slock-AF_INET6){-+..}, at: [<c03be6f4>] sk_clone+0xf4/0x310

but task is already holding lock:
 (slock-AF_INET6){-+..}, at: [<c0444eaf>] tcp_v6_rcv+0x34f/0x6f0

other info that might help us debug this:
1 lock held by java/6736:
 #0:  (slock-AF_INET6){-+..}, at: [<c0444eaf>] tcp_v6_rcv+0x34f/0x6f0

stack backtrace:
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0131454>] print_deadlock_bug+0xa4/0xb0
 [<c01314ca>] check_deadlock+0x6a/0x80
 [<c0132cf7>] __lock_acquire+0x4f7/0x950
 [<c01337cd>] lock_acquire+0x5d/0x80
 [<c0483415>] _spin_lock+0x25/0x30
 [<c03be6f4>] sk_clone+0xf4/0x310
 [<c03e6b31>] inet_csk_clone+0x11/0x70
 [<c03fb3c5>] tcp_create_openreq_child+0x15/0x3e0
 [<c04442c2>] tcp_v6_syn_recv_sock+0x142/0x610
 [<c03fb8a9>] tcp_check_req+0x119/0x420
 [<c0443d75>] tcp_v6_hnd_req+0x45/0x130
 [<c0444af7>] tcp_v6_do_rcv+0x247/0x2b0
 [<c0445136>] tcp_v6_rcv+0x5d6/0x6f0
 [<c04272df>] ip6_input+0x16f/0x340
 [<c0427004>] ipv6_rcv+0x114/0x280
 [<c03c6eb1>] netif_receive_skb+0x1b1/0x1f0
 [<c03c6f80>] process_backlog+0x90/0x120
 [<c03c707d>] net_rx_action+0x6d/0x100
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d5d9>] local_bh_enable_ip+0xb9/0x100
 [<c0483661>] _spin_unlock_bh+0x31/0x40
 [<c03bf750>] release_sock+0x50/0xb0
 [<c0405647>] inet_wait_for_connect+0x67/0xd0
 [<c0405748>] inet_stream_connect+0x98/0x1d0
 [<c03bc6d7>] sys_connect+0x67/0xa0
 [<c03bd1c6>] sys_socketcall+0xc6/0x1e0
 [<c0102e77>] syscall_call+0x7/0xb
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0xb length=
 0 sta!
eth0: Oversized Ethernet frame cd4810b0 vs cd4810b0.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0xc length=
 0 sta!
eth0: Oversized Ethernet frame cd4810c0 vs cd4810c0.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0xd length=
 0 sta!
eth0: Oversized Ethernet frame cd4810d0 vs cd4810d0.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0xe length=
 0 sta!
eth0: Oversized Ethernet frame cd4810e0 vs cd4810e0.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0xf length=
 0 sta!
eth0: Oversized Ethernet frame cd4810f0 vs cd4810f0.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x0 length=
 0 sta!
eth0: Oversized Ethernet frame cd481000 vs cd481000.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x1 length=
 0 sta!
eth0: Oversized Ethernet frame cd481010 vs cd481010.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x2 length=
 0 sta!
eth0: Oversized Ethernet frame cd481020 vs cd481020.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x3 length=
 0 sta!
eth0: Oversized Ethernet frame cd481030 vs cd481030.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x4 length=
 0 sta!
eth0: Oversized Ethernet frame cd481040 vs cd481040.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x5 length=
 0 sta!
eth0: Oversized Ethernet frame cd481050 vs cd481050.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x6 length=
 0 sta!
eth0: Oversized Ethernet frame cd481060 vs cd481060.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x7 length=
 0 sta!
eth0: Oversized Ethernet frame cd481070 vs cd481070.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x8 length=
 0 sta!
eth0: Oversized Ethernet frame cd481080 vs cd481080.
eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x9 length=
 0 sta!
eth0: Oversized Ethernet frame cd481090 vs cd481090.

[followed by a restart!]
--------------070006030200090102080806
Content-Type: text/plain;
 name="dojo kernelpanic debug 4k 3.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dojo kernelpanic debug 4k 3.log"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: possible recursive locking detected ]
---------------------------------------------
java/6743 is trying to acquire lock:
 (slock-AF_INET6){-+..}, at: [<c03be6f4>] sk_clone+0xf4/0x310

but task is already holding lock:
 (slock-AF_INET6){-+..}, at: [<c0444eaf>] tcp_v6_rcv+0x34f/0x6f0

other info that might help us debug this:
1 lock held by java/6743:
 #0:  (slock-AF_INET6){-+..}, at: [<c0444eaf>] tcp_v6_rcv+0x34f/0x6f0

stack backtrace:
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0131454>] print_deadlock_bug+0xa4/0xb0
 [<c01314ca>] check_deadlock+0x6a/0x80
 [<c0132cf7>] __lock_acquire+0x4f7/0x950
 [<c01337cd>] lock_acquire+0x5d/0x80
 [<c0483415>] _spin_lock+0x25/0x30
 [<c03be6f4>] sk_clone+0xf4/0x310
 [<c03e6b31>] inet_csk_clone+0x11/0x70
 [<c03fb3c5>] tcp_create_openreq_child+0x15/0x3e0
 [<c04442c2>] tcp_v6_syn_recv_sock+0x142/0x610
 [<c03fb8a9>] tcp_check_req+0x119/0x420
 [<c0443d75>] tcp_v6_hnd_req+0x45/0x130
 [<c0444af7>] tcp_v6_do_rcv+0x247/0x2b0
 [<c0445136>] tcp_v6_rcv+0x5d6/0x6f0
 [<c04272df>] ip6_input+0x16f/0x340
 [<c0427004>] ipv6_rcv+0x114/0x280
 [<c03c6eb1>] netif_receive_skb+0x1b1/0x1f0
 [<c03c6f80>] process_backlog+0x90/0x120
 [<c03c707d>] net_rx_action+0x6d/0x100
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d5d9>] local_bh_enable_ip+0xb9/0x100
 [<c0483661>] _spin_unlock_bh+0x31/0x40
 [<c03bf750>] release_sock+0x50/0xb0
 [<c0405647>] inet_wait_for_connect+0x67/0xd0
 [<c0405748>] inet_stream_connect+0x98/0x1d0
 [<c03bc6d7>] sys_connect+0x67/0xa0
 [<c03bd1c6>] sys_socketcall+0xc6/0x1e0
 [<c0102e77>] syscall_call+0x7/0xb

[reboot]
--------------070006030200090102080806
Content-Type: text/plain;
 name="dojo kernelpanic debug 4k 4.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dojo kernelpanic debug 4k 4.log"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: possible recursive locking detected ]
---------------------------------------------
java/6746 is trying to acquire lock:
 (slock-AF_INET6){-+..}, at: [<c03be6f4>] sk_clone+0xf4/0x310

but task is already holding lock:
 (slock-AF_INET6){-+..}, at: [<c0444eaf>] tcp_v6_rcv+0x34f/0x6f0

other info that might help us debug this:
1 lock held by java/6746:
 #0:  (slock-AF_INET6){-+..}, at: [<c0444eaf>] tcp_v6_rcv+0x34f/0x6f0

stack backtrace:
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0131454>] print_deadlock_bug+0xa4/0xb0
 [<c01314ca>] check_deadlock+0x6a/0x80
 [<c0132cf7>] __lock_acquire+0x4f7/0x950
 [<c01337cd>] lock_acquire+0x5d/0x80
 [<c0483415>] _spin_lock+0x25/0x30
 [<c03be6f4>] sk_clone+0xf4/0x310
 [<c03e6b31>] inet_csk_clone+0x11/0x70
 [<c03fb3c5>] tcp_create_openreq_child+0x15/0x3e0
 [<c04442c2>] tcp_v6_syn_recv_sock+0x142/0x610
 [<c03fb8a9>] tcp_check_req+0x119/0x420
 [<c0443d75>] tcp_v6_hnd_req+0x45/0x130
 [<c0444af7>] tcp_v6_do_rcv+0x247/0x2b0
 [<c0445136>] tcp_v6_rcv+0x5d6/0x6f0
 [<c04272df>] ip6_input+0x16f/0x340
 [<c0427004>] ipv6_rcv+0x114/0x280
 [<c03c6eb1>] netif_receive_skb+0x1b1/0x1f0
 [<c03c6f80>] process_backlog+0x90/0x120
 [<c03c707d>] net_rx_action+0x6d/0x100
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d5d9>] local_bh_enable_ip+0xb9/0x100
 [<c0483661>] _spin_unlock_bh+0x31/0x40
 [<c03bf750>] release_sock+0x50/0xb0
 [<c0405647>] inet_wait_for_connect+0x67/0xd0
 [<c0405748>] inet_stream_connect+0x98/0x1d0
 [<c03bc6d7>] sys_connect+0x67/0xa0
 [<c03bd1c6>] sys_socketcall+0xc6/0x1e0
 [<c0102e77>] syscall_call+0x7/0xb
BUG: unable to handle kernel paging request at virtual address 170fc2c3
 printing eip:
c03d958a
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c03d958a>]    Not tainted VLI
EFLAGS: 00010286   (2.6.18 #3)
EIP is at __ip_select_ident+0x4a/0xa0
eax: c6b78050   ebx: c613d8bc   ecx: ffffffff   edx: c05f7000
esi: 170fc2a5   edi: c13f1814   ebp: c05f7e70   esp: c05f7e64
ds: 007b   es: 007b   ss: 0068
Process java (pid: 6844, ti=3Dc05f7000 task=3Dc6b78050 task.ti=3Dc0eb3000=
)
Stack: c3fd3254 c13f1814 c8a62034 c05f7f38 c03e0df8 c13f1814 c613d8bc 000=
00000
       00000000 c613d8bc c05f7ea0 c03bf290 cdfc85dc c05f7ea0 c05f7ebc c01=
334dd
       fffffff5 c8a62034 c05f7f70 c0406027 c8a62034 00000000 c05f7ed4 c61=
3d8bc
Call Trace:
 [<c010354e>] show_stack_log_lvl+0x8e/0xb0
 [<c010370a>] show_registers+0x14a/0x1d0
 [<c0103987>] die+0x167/0x210
 [<c010eef3>] do_page_fault+0x173/0x580
 [<c0103199>] error_code+0x39/0x40
 [<c03e0df8>] ip_queue_xmit+0x468/0x520
 [<c03f26df>] tcp_transmit_skb+0x27f/0x4b0
 [<c03f4a93>] tcp_retransmit_skb+0x153/0x2d0
 [<c03f66af>] tcp_retransmit_timer+0xdf/0x3f0
 [<c03f6a91>] tcp_write_timer+0xd1/0x100
 [<c0122154>] run_timer_softirq+0xb4/0x1a0
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d773>] irq_exit+0x53/0x60
 [<c0104c5a>] do_IRQ+0x6a/0xb0
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e30b>] memcpy+0x3b/0x50
 [<c028e378>] memmove+0x38/0x50
 [<c01bf9cd>] leaf_paste_in_buffer+0x7d/0x320
 [<c01a879c>] balance_leaf+0x24c/0x27d0
 [<c01ab050>] do_balance+0x60/0xf0
 [<c01c5854>] reiserfs_paste_into_item+0x164/0x190
 [<c01b3c25>] reiserfs_allocate_blocks_for_region+0x925/0x12e0
 [<c01b5c9c>] reiserfs_file_write+0x72c/0x7c0
 [<c01668d8>] vfs_write+0x88/0x170
 [<c0166a6c>] sys_write+0x3c/0x70
 [<c0102e77>] syscall_call+0x7/0xb
Code: fe ff ff 8b b3 ec 00 00 00 58 85 f6 5a 75 12 57 e8 7c ff ff ff 8d 6=
5 f4 5
EIP: [<c03d958a>] __ip_select_ident+0x4a/0xa0 SS:ESP 0068:c05f7e64
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 <3>Slab corruption: start=3Dc6403564, len=3D2048
Redzone: 0x6b6b6b6b/0xc03c0543.
Last user: [<00000000>](0x0)
7f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a
Prev obj: start=3Dc6402cd3, len=3D2048
Redzone: 0x6b6b6b6b/0x6b6b6b6b.
Last user: [<6b6b6b6b>](0x6b6b6b6b)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double f=
ree, on
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0160d81>] __slab_error+0x21/0x30
 [<c0162e11>] cache_alloc_debugcheck_after+0x121/0x1a0
 [<c01634c8>] __kmalloc_track_caller+0xa8/0x100
 [<c03c029d>] __alloc_skb+0x4d/0x110
 [<c030438b>] rhine_rx+0x29b/0x490
 [<c0303db3>] rhine_interrupt+0x193/0x240
 [<c0144807>] handle_IRQ_event+0x27/0x70
 [<c01448d3>] __do_IRQ+0x83/0x110
 [<c0104c53>] do_IRQ+0x63/0xb0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e1dd>] __delay+0xd/0x10
 [<c028e205>] __const_udelay+0x25/0x30
 [<c0117ce8>] panic+0xf8/0x100
 [<c0103a21>] die+0x201/0x210
 [<c010eef3>] do_page_fault+0x173/0x580
 [<c0103199>] error_code+0x39/0x40
 [<c03e0df8>] ip_queue_xmit+0x468/0x520
 [<c03f26df>] tcp_transmit_skb+0x27f/0x4b0
 [<c03f4a93>] tcp_retransmit_skb+0x153/0x2d0
 [<c03f66af>] tcp_retransmit_timer+0xdf/0x3f0
 [<c03f6a91>] tcp_write_timer+0xd1/0x100
 [<c0122154>] run_timer_softirq+0xb4/0x1a0
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d773>] irq_exit+0x53/0x60
 [<c0104c5a>] do_IRQ+0x6a/0xb0
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e30b>] memcpy+0x3b/0x50
 [<c028e378>] memmove+0x38/0x50
 [<c01bf9cd>] leaf_paste_in_buffer+0x7d/0x320
 [<c01a879c>] balance_leaf+0x24c/0x27d0
 [<c01ab050>] do_balance+0x60/0xf0
 [<c01c5854>] reiserfs_paste_into_item+0x164/0x190
 [<c01b3c25>] reiserfs_allocate_blocks_for_region+0x925/0x12e0
 [<c01b5c9c>] reiserfs_file_write+0x72c/0x7c0
 [<c01668d8>] vfs_write+0x88/0x170
 [<c0166a6c>] sys_write+0x3c/0x70
 [<c0102e77>] syscall_call+0x7/0xb
c6403560: redzone 1:0x6b6b6b6b, redzone 2:0xc03c0543
Slab corruption: start=3Dc6402d58, len=3D2048
Redzone: 0x6b6b6b6b/0x0.
Last user: [<5a2cf071>](0x5a2cf071)
7f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a
Prev obj: start=3Dc64024c7, len=3D2048
Redzone: 0x656c7564/0x6b6b6b6b.
Last user: [<6b6b6b6b>](0x6b6b6b6b)
000: 3d 63 6f 6d 6d 75 6e 69 74 79 26 61 63 74 69 6f
010: 6e 3d 76 69 65 77 5f 74 6f 70 69 63 26 74 6f 70
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double f=
ree, on
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0160d81>] __slab_error+0x21/0x30
 [<c0162e11>] cache_alloc_debugcheck_after+0x121/0x1a0
 [<c01634c8>] __kmalloc_track_caller+0xa8/0x100
 [<c03c029d>] __alloc_skb+0x4d/0x110
 [<c030438b>] rhine_rx+0x29b/0x490
 [<c0303db3>] rhine_interrupt+0x193/0x240
 [<c0144807>] handle_IRQ_event+0x27/0x70
 [<c01448d3>] __do_IRQ+0x83/0x110
 [<c0104c53>] do_IRQ+0x63/0xb0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e1dd>] __delay+0xd/0x10
 [<c028e205>] __const_udelay+0x25/0x30
 [<c0117ce8>] panic+0xf8/0x100
 [<c0103a21>] die+0x201/0x210
 [<c010eef3>] do_page_fault+0x173/0x580
 [<c0103199>] error_code+0x39/0x40
 [<c03e0df8>] ip_queue_xmit+0x468/0x520
 [<c03f26df>] tcp_transmit_skb+0x27f/0x4b0
 [<c03f4a93>] tcp_retransmit_skb+0x153/0x2d0
 [<c03f66af>] tcp_retransmit_timer+0xdf/0x3f0
 [<c03f6a91>] tcp_write_timer+0xd1/0x100
 [<c0122154>] run_timer_softirq+0xb4/0x1a0
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d773>] irq_exit+0x53/0x60
 [<c0104c5a>] do_IRQ+0x6a/0xb0
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e30b>] memcpy+0x3b/0x50
 [<c028e378>] memmove+0x38/0x50
 [<c01bf9cd>] leaf_paste_in_buffer+0x7d/0x320
 [<c01a879c>] balance_leaf+0x24c/0x27d0
 [<c01ab050>] do_balance+0x60/0xf0
 [<c01c5854>] reiserfs_paste_into_item+0x164/0x190
 [<c01b3c25>] reiserfs_allocate_blocks_for_region+0x925/0x12e0
 [<c01b5c9c>] reiserfs_file_write+0x72c/0x7c0
 [<c01668d8>] vfs_write+0x88/0x170
 [<c0166a6c>] sys_write+0x3c/0x70
 [<c0102e77>] syscall_call+0x7/0xb
c6402d54: redzone 1:0x6b6b6b6b, redzone 2:0x0
Slab corruption: start=3Dc640254c, len=3D2048
Redzone: 0x6b6b6b6b/0x0.
Last user: [<5a2cf071>](0x5a2cf071)
7f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a
Prev obj: start=3Dc6401cbb, len=3D2048
Redzone: 0x19a60cb7/0x68702e78.
Last user: [<6f6d3f70>](0x6f6d3f70)
000: b7 f8 a5 19 b7 00 13 00 00 f4 90 48 08 7c a4 19
010: b7 70 a4 19 b7 01 00 00 00 00 13 00 00 01 00 00
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double f=
ree, on
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0160d81>] __slab_error+0x21/0x30
 [<c0162e11>] cache_alloc_debugcheck_after+0x121/0x1a0
 [<c01634c8>] __kmalloc_track_caller+0xa8/0x100
 [<c03c029d>] __alloc_skb+0x4d/0x110
 [<c030438b>] rhine_rx+0x29b/0x490
 [<c0303db3>] rhine_interrupt+0x193/0x240
 [<c0144807>] handle_IRQ_event+0x27/0x70
 [<c01448d3>] __do_IRQ+0x83/0x110
 [<c0104c53>] do_IRQ+0x63/0xb0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e1dd>] __delay+0xd/0x10
 [<c028e205>] __const_udelay+0x25/0x30
 [<c0117ce8>] panic+0xf8/0x100
 [<c0103a21>] die+0x201/0x210
 [<c010eef3>] do_page_fault+0x173/0x580
 [<c0103199>] error_code+0x39/0x40
 [<c03e0df8>] ip_queue_xmit+0x468/0x520
 [<c03f26df>] tcp_transmit_skb+0x27f/0x4b0
 [<c03f4a93>] tcp_retransmit_skb+0x153/0x2d0
 [<c03f66af>] tcp_retransmit_timer+0xdf/0x3f0
 [<c03f6a91>] tcp_write_timer+0xd1/0x100
 [<c0122154>] run_timer_softirq+0xb4/0x1a0
 [<c011d68f>] __do_softirq+0x6f/0x100
 [<c0104de7>] do_softirq+0x87/0xe0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<c011d773>] irq_exit+0x53/0x60
 [<c0104c5a>] do_IRQ+0x6a/0xb0
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e30b>] memcpy+0x3b/0x50
 [<c028e378>] memmove+0x38/0x50
 [<c01bf9cd>] leaf_paste_in_buffer+0x7d/0x320
 [<c01a879c>] balance_leaf+0x24c/0x27d0
 [<c01ab050>] do_balance+0x60/0xf0
 [<c01c5854>] reiserfs_paste_into_item+0x164/0x190
 [<c01b3c25>] reiserfs_allocate_blocks_for_region+0x925/0x12e0
 [<c01b5c9c>] reiserfs_file_write+0x72c/0x7c0
 [<c01668d8>] vfs_write+0x88/0x170
 [<c0166a6c>] sys_write+0x3c/0x70
 [<c0102e77>] syscall_call+0x7/0xb
c6402548: redzone 1:0x6b6b6b6b, redzone 2:0x0

--------------070006030200090102080806--

--------------enig1BB5663EFA1E5E320E96A859
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFFngDFMhaCCTq+CMRAvWsAJ9F/O6VWSvesGImYLMgZ1MxOGhBSACgh221
J8ReDmZKOCEO2f8G23uAGoE=
=VAVU
-----END PGP SIGNATURE-----

--------------enig1BB5663EFA1E5E320E96A859--
