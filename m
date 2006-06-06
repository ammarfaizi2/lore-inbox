Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWFFQH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWFFQH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWFFQH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:07:58 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:33158 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751044AbWFFQH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:07:57 -0400
Message-ID: <4485A85B.3080102@dgreaves.com>
Date: Tue, 06 Jun 2006 17:07:55 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Oops and panic running xfs_fsr on 2.6.16.9
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan

I was running xfs_fsr on 2.6.16.9 on a 1.2Tb raid5 using xfs_fsr version
2.2.30

The filesystem is very heavily fragmented:

cu:~# xfs_db -c frag -r /dev/huge_vg/huge_lv
actual 110636, ideal 3856, fragmentation factor 96.51%

I've appended the oopses and an image of the panic that occurred.

Just so you know (in case it's related) I also got lots of:
  could not allocate buf: /huge/.fsr/ag2/tmp681
(I've since seen
http://marc.theaimsgroup.com/?l=linux-xfs&m=114380655102639&w=2 but not
applied the patch)

Can I supply anything else?

David

cu kernel: Oops: 0002 [#1]
cu kernel: CPU:    0
cu kernel: EIP is at __page_cache_release+0x35/0xa0
cu kernel: eax: b151d678   ebx: b1056040   ecx: b1056058   edx: 03056078
cu kernel: esi: b03cee10   edi: 00000212   ebp: ffffffff   esp: c7761d5c
cu kernel: ds: 007b   es: 007b   ss: 0068
cu kernel: Process xfs_fsr (pid: 27562, threadinfo=c7760000 task=eeeab070)
cu kernel: Stack: <0>16001c68 00000005 b1056040 b013feed b1056040
b1056040 00001c62 0000000e
cu kernel:        00000000 00000000 00000000 0000000e 00000000 b12ac1e0
b1760b00 b1760b20
cu kernel:        b151d640 b151d660 b1056040 b1056060 b11a7e80 b11a7ea0
b1716b00 b1716b20
cu kernel:  [truncate_inode_pages_range+269/736]
truncate_inode_pages_range+0x10d/0x2e0
cu kernel:  [truncate_inode_pages+47/64] truncate_inode_pages+0x2f/0x40
cu kernel:  [xfs_swapext+1052/2368] xfs_swapext+0x41c/0x940
cu kernel:  [xfs_ioctl+2058/2128] xfs_ioctl+0x80a/0x850
cu kernel:  [notify_change+508/662] notify_change+0x1fc/0x296
cu kernel:  [linvfs_ioctl_invis+71/144] linvfs_ioctl_invis+0x47/0x90
cu kernel:  [do_ioctl+104/128] do_ioctl+0x68/0x80
cu kernel:  [vfs_ioctl+141/464] vfs_ioctl+0x8d/0x1d0
cu kernel:  [sys_ioctl+69/128] sys_ioctl+0x45/0x80
cu kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
cu kernel: Call Trace:
cu kernel: Code: 89 7c 24 08 89 c3 8b 00 c1 e8 1e 8b 34 85 c8 79 41 b0
9c 5f fa 0f ba 33 05 19 c0 85 c0 74 2c 8d 4b 18 8b 43 18 8b 51 04 89 50
04 <89> 02 c7 41 04 00 02 20 00 8b 03 c7 43 18 00 01 10 00 a8 40 74

cu kernel: Oops: 0002 [#2]
cu kernel: CPU:    0
cu kernel: EIP is at isolate_lru_pages+0x4c/0xb0
cu kernel: eax: b03ceee4   ebx: b03ceee4   ecx: b151d678   edx: 03056078
cu kernel: esi: 00000014   edi: 00000013   ebp: efc17e9c   esp: efc17e6c
cu kernel: ds: 007b   es: 007b   ss: 0068
cu kernel: Process kswapd0 (pid: 114, threadinfo=efc16000 task=efeef070)
cu kernel: Stack: <0>b03cee10 b03cee10 efc17e9c efc17f40 b0140f53
00000020 b03ceee4 efc17e9c
cu kernel:        efc17e98 b03ceee4 00000020 00000296 b151d658 b127dd38
00000000 00000001
cu kernel:        efa38420 00000000 efc17ec8 b011703e b19cfab0 0000000f
00000000 efc2b9e0
cu kernel: Call Trace:
cu kernel:  [shrink_cache+115/640] shrink_cache+0x73/0x280
cu kernel:  [wake_up_process+30/32] wake_up_process+0x1e/0x20
cu kernel:  [xfsbufd_wakeup+79/96] xfsbufd_wakeup+0x4f/0x60
cu kernel:  [shrink_slab+132/496] shrink_slab+0x84/0x1f0
cu kernel:  [shrink_zone+182/224] shrink_zone+0xb6/0xe0
cu kernel:  [balance_pgdat+667/944] balance_pgdat+0x29b/0x3b0
cu kernel:  [kswapd+244/272] kswapd+0xf4/0x110
cu kernel:  [autoremove_wake_function+0/96]
autoremove_wake_function+0x0/0x60
cu kernel:  [autoremove_wake_function+0/96]
autoremove_wake_function+0x0/0x60
cu kernel:  [kswapd+0/272] kswapd+0x0/0x110
cu kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
cu kernel: Code: 4b 04 8b 41 04 39 d8 74 07 83 e8 18 0f 0d 08 90 0f ba
71 e8 05 19 c0 85 c0 75 08 0f 0b 41 04 0b ea 37 b0 8b 51 04 8b 01 89 50
04 <89> 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 ff 41 ec 0f 94 c0

Crash image:
http://www.dgreaves.com/pics/xfs_crash.jpg
