Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbUEKLB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUEKLB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 07:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUEKLB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 07:01:59 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:58492 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262862AbUEKLB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 07:01:56 -0400
Date: Tue, 11 May 2004 13:01:54 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 Oops on kswapd
Message-ID: <Pine.LNX.4.58LT.0405111254440.29569@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel

First question is, how to use correctly ksymoops on 2.6.X? What about
-k parametr?

Anyway, below is oops from 2.6.6 on i686 (3 hours after reboot) (Pentium 
4), 525MB RAM, 700MB Swap area, ide disks, ext3 & ext2 area. Linux Fedora Core
1. With 2.6.4  that machine has worked 30 days without any problems.

ksymoops 2.4.9 on i686 2.6.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6/ (default)
     -m /lib/modules/2.6.6/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
May 11 02:31:43 space-themes kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
May 11 02:31:43 space-themes kernel: 00000000
May 11 02:31:43 space-themes kernel: *pde = 00000000
May 11 02:31:43 space-themes kernel: Oops: 0000 [#1]
May 11 02:31:43 space-themes kernel: CPU:    0
May 11 02:31:43 space-themes kernel: EIP:    0060:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
May 11 02:31:43 space-themes kernel: EFLAGS: 00010246   (2.6.6) 
May 11 02:31:43 space-themes kernel: eax: c03bedb8   ebx: df96a000   ecx: df96a0a4   edx: df96a0a0
May 11 02:31:43 space-themes kernel: esi: df79e9b0   edi: df79e990   ebp: c1561d4c   esp: c1561d28
May 11 02:31:43 space-themes kernel: ds: 007b   es: 007b   ss: 0068
May 11 02:31:43 space-themes kernel: Stack: c0184e12 df79e990 00000077 df96a0a4 df96a0a0 00000000 df79e990 c1560000 
May 11 02:31:43 space-themes kernel:        de08b8f0 c1561d6c c018538f df79e990 c13b73a0 00000286 c13b7360 00000000 
May 11 02:31:43 space-themes kernel:        df96a0cc c1561d88 c01860b8 df79e990 00000042 de08b8f0 c1561dd8 00000020 
May 11 02:31:43 space-themes kernel: Call Trace:
May 11 02:31:43 space-themes kernel:  [<c0184e12>] dquot_release+0xad/0xc8
May 11 02:31:43 space-themes kernel:  [<c018538f>] dqput+0xd7/0x1ec
May 11 02:31:43 space-themes kernel:  [<c01860b8>] dquot_drop+0x95/0xa2
May 11 02:31:43 space-themes kernel:  [<c016faa1>] clear_inode+0x62/0xcd
May 11 02:31:43 space-themes kernel:  [<c016fb4f>] dispose_list+0x43/0xc5
May 11 02:31:43 space-themes kernel:  [<c016ff22>] prune_icache+0xf1/0x26e
May 11 02:31:43 space-themes kernel:  [<c01700c3>] shrink_icache_memory+0x24/0x26
May 11 02:31:43 space-themes kernel:  [<c01426ba>] shrink_slab+0x142/0x18a
May 11 02:31:43 space-themes kernel:  [<c0143d8b>] balance_pgdat+0x207/0x268
May 11 02:31:43 space-themes kernel:  [<c0143eea>] kswapd+0xfe/0x11f
May 11 02:31:43 space-themes kernel:  [<c011b337>] autoremove_wake_function+0x0/0x4b
May 11 02:31:43 space-themes kernel:  [<c0104f3a>] ret_from_fork+0x6/0x14
May 11 02:31:43 space-themes kernel:  [<c011b337>] autoremove_wake_function+0x0/0x4b
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; 00000000 Before first symbol

>>eax; c03bedb8 <v1_format_ops+0/1c>
>>ebx; df96a000 <__crc_fs_overflowgid+40c90/13130f>
>>ecx; df96a0a4 <__crc_fs_overflowgid+40d34/13130f>
>>edx; df96a0a0 <__crc_fs_overflowgid+40d30/13130f>
>>esi; df79e9b0 <__crc_hpsb_write+8a13/11bef2>
>>edi; df79e990 <__crc_hpsb_write+89f3/11bef2>
>>ebp; c1561d4c <__crc_find_inode_number+f0429/4bbb6e>
>>esp; c1561d28 <__crc_find_inode_number+f0405/4bbb6e>

Trace; c0184e12 <dquot_release+ad/c8>
Trace; c018538f <dqput+d7/1ec>
Trace; c01860b8 <dquot_drop+95/a2>
Trace; c016faa1 <clear_inode+62/cd>
Trace; c016fb4f <dispose_list+43/c5>
Trace; c016ff22 <prune_icache+f1/26e>
Trace; c01700c3 <shrink_icache_memory+24/26>
Trace; c01426ba <shrink_slab+142/18a>
Trace; c0143d8b <balance_pgdat+207/268>
Trace; c0143eea <kswapd+fe/11f>
Trace; c011b337 <autoremove_wake_function+0/4b>
Trace; c0104f3a <ret_from_fork+6/14>
Trace; c011b337 <autoremove_wake_function+0/4b>


1 warning and 1 error issued.  Results may not be reliable.

-- 
*[ £ukasz Tr±biñski ]*
