Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUIIMFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUIIMFB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 08:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUIIMEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 08:04:32 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:17048 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S264377AbUIIMC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 08:02:29 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: 2.6.9-rc1-bk15: kernel BUG at net/ipv4/tcp_output.c:271!
Date: Thu, 9 Sep 2004 12:02:28 +0000 (UTC)
Organization: Cistron Group
Message-ID: <chpgok$pdq$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1094731348 26042 62.216.29.200 (9 Sep 2004 12:02:28 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.6.9-rc1-bk15 on one of my servers, and it soon crashes
with "kernel BUG at net/ipv4/tcp_output.c:271!". 2.6.9-rc1
is fine. Line 271 is

	BUG_ON(!TCP_SKB_CB(skb)->tso_factor);

.. it appears that the tso_factor stuff was added somewhere
after 2.6.9-rc1.


kernel BUG at net/ipv4/tcp_output.c:271!
invalid operand: 0000 [#1]
SMP
Modules linked in: nfsd exportfs lockd sunrpc xfs raid1 md sd_mod 3w_xxxx scsi_mod e1000
CPU:    0
EIP:    0060:[<c025fa82>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk15)
EIP is at tcp_transmit_skb+0x6af/0x6bc
eax: 00000000   ebx: f23bb080   ecx: 00000020   edx: f3245db8
esi: f27dab78   edi: 00000000   ebp: f27da980   esp: ee679d58
ds: 007b   es: 007b   ss: 0068
Process diablo (pid: 702, threadinfo=ee678000 task=f1547aa0)
Stack: c013a2fd c15f7f20 00000000 f6502a10 00000296 c15f7f20 f23bb080 00000020
       f3245db8 f27daae0 f23bb080 f27dab78 00000000 f27da980 c02603bb f27da980
       f3245d80 000005a8 00000000 efbf9000 f27da9e4 00001c48 00000000 f23bb080
Call Trace:
 [<c013a2fd>] buffered_rmqueue+0xff/0x1d4
 [<c02603bb>] tcp_write_xmit+0x186/0x305
 [<c02549c4>] tcp_sendmsg+0x50b/0x1116
 [<c01b9a43>] radix_tree_node_alloc+0x1f/0x62
 [<c0136110>] find_get_page+0x3d/0x4b
 [<c0275809>] inet_sendmsg+0x4d/0x59
 [<c022ce5d>] sock_aio_write+0xf5/0x111
 [<c0145121>] do_no_page+0x195/0x324
 [<c015312a>] do_sync_write+0xbe/0xeb
 [<c011a237>] autoremove_wake_function+0x0/0x57
 [<c0142fc4>] madvise_willneed+0x6b/0x81
 [<c015325b>] vfs_write+0x104/0x135
 [<c01430b4>] madvise_vma+0x36/0x6e
 [<c015335d>] sys_write+0x51/0x80
 [<c0103f7b>] syscall_call+0x7/0xb
Code: 09 fd ff e9 98 fa ff ff 0f b6 86 3f 01 00 00 84 c0 0f 84 20 fa ff ff 8b 4c 24 1c 0f b6 c0 8d 4c c1 04 89 4c 24 1c e9 0c fa ff ff <0f> 0b 0f 01 ca 89 30 c0 e9 9b f9 ff ff 53 8b 4c 24 0c 8b 5c 24
 ------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:271!
invalid operand: 0000 [#2]
SMP
Modules linked in: nfsd exportfs lockd sunrpc xfs raid1 md sd_mod 3w_xxxx scsi_mod e1000
CPU:    0
EIP:    0060:[<c025fa82>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk15)
EIP is at tcp_transmit_skb+0x6af/0x6bc
eax: 00000000   ebx: f0795480   ecx: 00000020   edx: f0915eb8
esi: efbdd478   edi: 00000000   ebp: efbdd280   esp: f16f1d58
ds: 007b   es: 007b   ss: 0068
Process diablo (pid: 708, threadinfo=f16f0000 task=ee02d000)
Stack: c013a2fd c16a1b00 00000000 00000046 00000296 c16a1b00 f0795480 00000020
       f0915eb8 efbdd3e0 f0795480 efbdd478 00000000 efbdd280 c02603bb efbdd280
       f0915e80 000005a8 00000000 f50d8000 efbdd2e4 00001c48 00000000 f0795480
Call Trace:
 [<c013a2fd>] buffered_rmqueue+0xff/0x1d4
 [<c02603bb>] tcp_write_xmit+0x186/0x305
 [<c02549c4>] tcp_sendmsg+0x50b/0x1116
 [<c0136110>] find_get_page+0x3d/0x4b
 [<c0275809>] inet_sendmsg+0x4d/0x59
 [<c022ce5d>] sock_aio_write+0xf5/0x111
 [<c0145121>] do_no_page+0x195/0x324
 [<c015312a>] do_sync_write+0xbe/0xeb
 [<c011a237>] autoremove_wake_function+0x0/0x57
 [<c0142fc4>] madvise_willneed+0x6b/0x81
 [<c015325b>] vfs_write+0x104/0x135
 [<c01430b4>] madvise_vma+0x36/0x6e
 [<c015335d>] sys_write+0x51/0x80
 [<c0103f7b>] syscall_call+0x7/0xb
Code: 09 fd ff e9 98 fa ff ff 0f b6 86 3f 01 00 00 84 c0 0f 84 20 fa ff ff 8b 4c 24 1c 0f b6 c0 8d 4c c1 04 89 4c 24 1c e9 0c fa ff ff <0f> 0b 0f 01 ca 89 30 c0 e9 9b f9 ff ff 53 8b 4c 24 0c 8b 5c 24
 ------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:271!
invalid operand: 0000 [#3]
SMP
Modules linked in: nfsd exportfs lockd sunrpc xfs raid1 md sd_mod 3w_xxxx scsi_mod e1000
CPU:    0
EIP:    0060:[<c025fa82>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk15)
EIP is at tcp_transmit_skb+0x6af/0x6bc
eax: 00000000   ebx: f155a480   ecx: 00000020   edx: ee6feab8
esi: f16ef8f8   edi: 00000000   ebp: f16ef700   esp: f62e7d58
ds: 007b   es: 007b   ss: 0068
Process diablo (pid: 710, threadinfo=f62e6000 task=f651a550)
Stack: c013a2fd c162dfa0 00000000 f16fca10 00000296 c162dfa0 f155a480 00000020
       ee6feab8 f16ef860 f155a480 f16ef8f8 00000000 f16ef700 c02603bb f16ef700
       ee6fea80 000005a8 00000000 f16fd000 f16ef764 00001c48 00000000 f155a480
Call Trace:
 [<c013a2fd>] buffered_rmqueue+0xff/0x1d4
 [<c02603bb>] tcp_write_xmit+0x186/0x305
 [<c02549c4>] tcp_sendmsg+0x50b/0x1116
 [<c0136110>] find_get_page+0x3d/0x4b
 [<c0275809>] inet_sendmsg+0x4d/0x59
 [<c022ce5d>] sock_aio_write+0xf5/0x111
 [<c0145121>] do_no_page+0x195/0x324
 [<c015312a>] do_sync_write+0xbe/0xeb
 [<c011a237>] autoremove_wake_function+0x0/0x57
 [<c0142fc4>] madvise_willneed+0x6b/0x81
 [<c015325b>] vfs_write+0x104/0x135
 [<c01430b4>] madvise_vma+0x36/0x6e
 [<c015335d>] sys_write+0x51/0x80
 [<c0103f7b>] syscall_call+0x7/0xb
Code: 09 fd ff e9 98 fa ff ff 0f b6 86 3f 01 00 00 84 c0 0f 84 20 fa ff ff 8b 4c 24 1c 0f b6 c0 8d 4c c1 04 89 4c 24 1c e9 0c fa ff ff <0f> 0b 0f 01 ca 89 30 c0 e9 9b f9 ff ff 53 8b 4c 24 0c 8b 5c 24
 ------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:271!
invalid operand: 0000 [#4]
SMP
Modules linked in: nfsd exportfs lockd sunrpc xfs raid1 md sd_mod 3w_xxxx scsi_mod e1000
CPU:    0
EIP:    0060:[<c025fa82>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk15)
EIP is at tcp_transmit_skb+0x6af/0x6bc
eax: 00000000   ebx: f203e080   ecx: 00000020   edx: f2fd5bb8
esi: f16eeff8   edi: 00000000   ebp: f16eee00   esp: f15d5d58
ds: 007b   es: 007b   ss: 0068
Process diablo (pid: 712, threadinfo=f15d4000 task=efa29550)
Stack: 00000283 c011a1fb f16eee00 7fffffff 00000296 c02336d5 f203e080 00000020
       f2fd5bb8 f16eef60 f203e080 f16eeff8 00000000 f16eee00 c02603bb f16eee00
       f2fd5b80 000005a8 00000000 f15c5a00 f16eee64 00001c48 00000000 f203e080
Call Trace:
 [<c011a1fb>] finish_wait+0x30/0x6c
 [<c02336d5>] sk_stream_wait_memory+0x16d/0x1c8
 [<c02603bb>] tcp_write_xmit+0x186/0x305
 [<c02549c4>] tcp_sendmsg+0x50b/0x1116
 [<c0173e39>] mpage_readpages+0xd8/0x165
 [<c0275809>] inet_sendmsg+0x4d/0x59
 [<c022ce5d>] sock_aio_write+0xf5/0x111
 [<f8b0a85c>] linvfs_get_block+0x0/0x43 [xfs]
 [<c015312a>] do_sync_write+0xbe/0xeb
 [<c011a237>] autoremove_wake_function+0x0/0x57
 [<c0142fc4>] madvise_willneed+0x6b/0x81
 [<c015325b>] vfs_write+0x104/0x135
 [<c01430b4>] madvise_vma+0x36/0x6e
 [<c015335d>] sys_write+0x51/0x80
 [<c0103f7b>] syscall_call+0x7/0xb
Code: 09 fd ff e9 98 fa ff ff 0f b6 86 3f 01 00 00 84 c0 0f 84 20 fa ff ff 8b 4c 24 1c 0f b6 c0 8d 4c c1 04 89 4c 24 1c e9 0c fa ff ff <0f> 0b 0f 01 ca 89 30 c0 e9 9b f9 ff ff 53 8b 4c 24 0c 8b 5c 24
 ------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:271!
invalid operand: 0000 [#5]
SMP
Modules linked in: nfsd exportfs lockd sunrpc xfs raid1 md sd_mod 3w_xxxx scsi_mod e1000
CPU:    0
EIP:    0060:[<c025fa82>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk15)
EIP is at tcp_transmit_skb+0x6af/0x6bc
eax: 00000000   ebx: f3b25b80   ecx: 00000020   edx: f34a25b8
esi: f291f478   edi: 00000000   ebp: f291f280   esp: f3267d58
ds: 007b   es: 007b   ss: 0068
Process diablo (pid: 718, threadinfo=f3266000 task=f16e0550)
Stack: f3b25780 00000000 00001c68 f3b25780 00000296 c1664e20 f3b25b80 00000020
       f34a25b8 f291f3e0 f3b25b80 f291f478 00000000 f291f280 c02603bb f291f280
       f34a2580 000005a8 00000000 f3271380 f291f2e4 00001c48 00000000 f3b25b80
Call Trace:
 [<c02603bb>] tcp_write_xmit+0x186/0x305
 [<c02549c4>] tcp_sendmsg+0x50b/0x1116
 [<c0173e39>] mpage_readpages+0xd8/0x165
 [<c0275809>] inet_sendmsg+0x4d/0x59
 [<c022ce5d>] sock_aio_write+0xf5/0x111
 [<f8b0a85c>] linvfs_get_block+0x0/0x43 [xfs]
 [<c015312a>] do_sync_write+0xbe/0xeb
 [<c011a237>] autoremove_wake_function+0x0/0x57
 [<c0142fc4>] madvise_willneed+0x6b/0x81
 [<c015325b>] vfs_write+0x104/0x135
 [<c01430b4>] madvise_vma+0x36/0x6e
 [<c015335d>] sys_write+0x51/0x80
 [<c0103f7b>] syscall_call+0x7/0xb
Code: 09 fd ff e9 98 fa ff ff 0f b6 86 3f 01 00 00 84 c0 0f 84 20 fa ff ff 8b 4c 24 1c 0f b6 c0 8d 4c c1 04 89 4c 24 1c e9 0c fa ff ff <0f> 0b 0f 01 ca 89 30 c0 e9 9b f9 ff ff 53 8b 4c 24 0c 8b 5c 24
 ------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:271!
invalid operand: 0000 [#6]
SMP
Modules linked in: nfsd exportfs lockd sunrpc xfs raid1 md sd_mod 3w_xxxx scsi_mod e1000
CPU:    0
EIP:    0060:[<c025fa82>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk15)
EIP is at tcp_transmit_skb+0x6af/0x6bc
eax: 00000000   ebx: f2025e80   ecx: 00000020   edx: f65c9bb8
esi: f1a118f8   edi: 00000000   ebp: f1a11700   esp: f1a17d58
ds: 007b   es: 007b   ss: 0068
Process diablo (pid: 724, threadinfo=f1a16000 task=f01e8550)
Stack: 00000287 c011a1fb f1a11700 7fffffff 00000296 c02336d5 f2025e80 00000020
       f65c9bb8 f1a11860 f2025e80 f1a118f8 00000000 f1a11700 c02603bb f1a11700
       f65c9b80 000005a8 00000000 f156aa00 f1a11764 00001c48 00000000 f2025e80
Call Trace:
 [<c011a1fb>] finish_wait+0x30/0x6c
 [<c02336d5>] sk_stream_wait_memory+0x16d/0x1c8
 [<c02603bb>] tcp_write_xmit+0x186/0x305
 [<c02549c4>] tcp_sendmsg+0x50b/0x1116
 [<c0136110>] find_get_page+0x3d/0x4b
 [<c0275809>] inet_sendmsg+0x4d/0x59
 [<c022ce5d>] sock_aio_write+0xf5/0x111
 [<c0164ea3>] fasync_helper+0x8f/0xd1
 [<c015312a>] do_sync_write+0xbe/0xeb
 [<c011a237>] autoremove_wake_function+0x0/0x57
 [<c0142fc4>] madvise_willneed+0x6b/0x81
 [<c015325b>] vfs_write+0x104/0x135
 [<c01430b4>] madvise_vma+0x36/0x6e
 [<c015335d>] sys_write+0x51/0x80
 [<c0103f7b>] syscall_call+0x7/0xb
Code: 09 fd ff e9 98 fa ff ff 0f b6 86 3f 01 00 00 84 c0 0f 84 20 fa ff ff 8b 4c 24 1c 0f b6 c0 8d 4c c1 04 89 4c 24 1c e9 0c fa ff ff <0f> 0b 0f 01 ca 89 30 c0 e9 9b f9 ff ff 53 8b 4c 24 0c 8b 5c 24
 ------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:271!
invalid operand: 0000 [#7]
SMP
Modules linked in: nfsd exportfs lockd sunrpc xfs raid1 md sd_mod 3w_xxxx scsi_mod e1000
CPU:    0
EIP:    0060:[<c025fa82>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk15)
EIP is at tcp_transmit_skb+0x6af/0x6bc
eax: 00000000   ebx: f290eb80   ecx: 00000020   edx: f290ecb8
esi: f291eb78   edi: 00000000   ebp: f291e980   esp: f156dd58
ds: 007b   es: 007b   ss: 0068
Process diablo (pid: 720, threadinfo=f156c000 task=f16e0000)
Stack: c013a2fd c162af80 00000000 f290e980 00000296 c162af80 f290eb80 00000020
       f290ecb8 f291eae0 f290eb80 f291eb78 00000000 f291e980 c02603bb f291e980
       f290ec80 000005a8 00000000 f157c000 f291e9e4 00001c48 00000000 f290eb80
Call Trace:
 [<c013a2fd>] buffered_rmqueue+0xff/0x1d4
 [<c02603bb>] tcp_write_xmit+0x186/0x305
 [<c02549c4>] tcp_sendmsg+0x50b/0x1116
 [<c01b9a43>] radix_tree_node_alloc+0x1f/0x62
 [<c0136110>] find_get_page+0x3d/0x4b
 [<c0275809>] inet_sendmsg+0x4d/0x59
 [<c022ce5d>] sock_aio_write+0xf5/0x111
 [<c0145121>] do_no_page+0x195/0x324
 [<c015312a>] do_sync_write+0xbe/0xeb
 [<c0116a60>] recalc_task_prio+0x93/0x188
 [<c011a237>] autoremove_wake_function+0x0/0x57
 [<c015325b>] vfs_write+0x104/0x135
 [<c01430b4>] madvise_vma+0x36/0x6e
 [<c015335d>] sys_write+0x51/0x80
 [<c0103f7b>] syscall_call+0x7/0xb
Code: 09 fd ff e9 98 fa ff ff 0f b6 86 3f 01 00 00 84 c0 0f 84 20 fa ff ff 8b 4c 24 1c 0f b6 c0 8d 4c c1 04 89 4c 24 1c e9 0c fa ff ff <0f> 0b 0f 01 ca 89 30 c0 e9 9b f9 ff ff 53 8b 4c 24 0c 8b 5c 24
 ------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:271!
invalid operand: 0000 [#8]
SMP
Modules linked in: nfsd exportfs lockd sunrpc xfs raid1 md sd_mod 3w_xxxx scsi_mod e1000
CPU:    0
EIP:    0060:[<c025fa82>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk15)
EIP is at tcp_transmit_skb+0x6af/0x6bc
eax: 00000000   ebx: f12f5e80   ecx: 00000020   edx: f07959b8
esi: f291e278   edi: 00000000   ebp: f291e080   esp: f1a13d58
ds: 007b   es: 007b   ss: 0068
Process diablo (pid: 722, threadinfo=f1a12000 task=f01e8aa0)
Stack: c013a2fd c1637500 00000000 7fffffff 00000296 c1637500 f12f5e80 00000020
       f07959b8 f291e1e0 f12f5e80 f291e278 00000000 f291e080 c02603bb f291e080
       f0795980 000005a8 00000000 f1ba8000 f291e0e4 00001c48 00000000 f12f5e80
Call Trace:
 [<c013a2fd>] buffered_rmqueue+0xff/0x1d4
 [<c02603bb>] tcp_write_xmit+0x186/0x305
 [<c02549c4>] tcp_sendmsg+0x50b/0x1116
 [<c0173e39>] mpage_readpages+0xd8/0x165
 [<c0275809>] inet_sendmsg+0x4d/0x59
 [<c022ce5d>] sock_aio_write+0xf5/0x111
 [<f8b0a85c>] linvfs_get_block+0x0/0x43 [xfs]
 [<c015312a>] do_sync_write+0xbe/0xeb
 [<c011a237>] autoremove_wake_function+0x0/0x57
 [<c0142fc4>] madvise_willneed+0x6b/0x81
 [<c015325b>] vfs_write+0x104/0x135
 [<c01430b4>] madvise_vma+0x36/0x6e
 [<c015335d>] sys_write+0x51/0x80
 [<c0103f7b>] syscall_call+0x7/0xb
Code: 09 fd ff e9 98 fa ff ff 0f b6 86 3f 01 00 00 84 c0 0f 84 20 fa ff ff 8b 4c 24 1c 0f b6 c0 8d 4c c1 04 89 4c 24 1c e9 0c fa ff ff <0f> 0b 0f 01 ca 89 30 c0 e9 9b f9 ff ff 53 8b 4c 24 0c 8b 5c 24
 ------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:271!
invalid operand: 0000 [#9]
SMP
Modules linked in: nfsd exportfs lockd sunrpc xfs raid1 md sd_mod 3w_xxxx scsi_mod e1000
CPU:    0
EIP:    0060:[<c025fa82>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk15)
EIP is at tcp_transmit_skb+0x6af/0x6bc
eax: 00000000   ebx: ee07f680   ecx: 00000020   edx: f0a8e0b8
esi: f16ee6f8   edi: 00000004   ebp: f16ee500   esp: c037bc10
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c037a000 task=c0324ac0)
Stack: f663a480 00000000 00000b70 f663a480 00000296 00010cb6 ee07f680 00000020
       f0a8e0b8 f16ee660 ee07f680 f16ee6f8 00000004 f16ee500 c02603bb f16ee500
       f0a8e080 000005a8 4fee56d0 00000286 f16ee564 000010f8 00000001 f16ee6f8
Call Trace:
 [<c02603bb>] tcp_write_xmit+0x186/0x305
 [<c025d640>] __tcp_data_snd_check+0xd7/0xe0
 [<c025dc5b>] tcp_rcv_established+0x22d/0x8c0
 [<c024947f>] ip_route_input_slow+0x28e/0xa8e
 [<c0266ae2>] tcp_v4_do_rcv+0x128/0x12d
 [<c02671aa>] tcp_v4_rcv+0x6c3/0x91f
 [<c024c2da>] ip_local_deliver_finish+0x0/0x1e5
 [<c024c39a>] ip_local_deliver_finish+0xc0/0x1e5
 [<c024c2da>] ip_local_deliver_finish+0x0/0x1e5
 [<c023ecf7>] nf_hook_slow+0xc4/0xf9
 [<c024c2da>] ip_local_deliver_finish+0x0/0x1e5
 [<c024bdd4>] ip_local_deliver+0x23b/0x259
 [<c024c2da>] ip_local_deliver_finish+0x0/0x1e5
 [<c024c6cf>] ip_rcv_finish+0x210/0x289
 [<c024c4bf>] ip_rcv_finish+0x0/0x289
 [<c024c4bf>] ip_rcv_finish+0x0/0x289
 [<c023ecf7>] nf_hook_slow+0xc4/0xf9
 [<c024c4bf>] ip_rcv_finish+0x0/0x289
 [<c024c213>] ip_rcv+0x421/0x4e8
 [<c024c4bf>] ip_rcv_finish+0x0/0x289
 [<c0235ffb>] netif_receive_skb+0x193/0x234
 [<f8930008>] tw_reset_sequence+0x54/0xc8 [3w_xxxx]
 [<f893ca84>] e1000_clean_rx_irq+0x12e/0x447 [e1000]
 [<c023073f>] __kfree_skb+0xb3/0x132
 [<f893c6c5>] e1000_clean+0x51/0xca [e1000]
 [<c023621e>] net_rx_action+0x77/0xf6
 [<c0120853>] __do_softirq+0xb7/0xc6
 [<c012088f>] do_softirq+0x2d/0x2f
 [<c01069b0>] do_IRQ+0x107/0x125
 [<c01048e8>] common_interrupt+0x18/0x20
 [<c010201e>] default_idle+0x0/0x2c
 [<c02d007b>] init_or_cleanup+0x83/0x179
 [<c0102047>] default_idle+0x29/0x2c
 [<c01020b0>] cpu_idle+0x33/0x3c
 [<c037c9e4>] start_kernel+0x173/0x18e
 [<c037c4bd>] unknown_bootoption+0x0/0x149
Code: 09 fd ff e9 98 fa ff ff 0f b6 86 3f 01 00 00 84 c0 0f 84 20 fa ff ff 8b 4c 24 1c 0f b6 c0 8d 4c c1 04 89 4c 24 1c e9 0c fa ff ff <0f> 0b 0f 01 ca 89 30 c0 e9 9b f9 ff ff 53 8b 4c 24 0c 8b 5c 24
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 <0>Rebooting in 30 seconds..


-- 
"In times of universal deceit, telling the truth becomes
 a revolutionary act." -- George Orwell.

