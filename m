Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUCCR6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 12:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbUCCR6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 12:58:10 -0500
Received: from mail.xor.at ([62.99.218.147]:8386 "EHLO merkur.xor.at")
	by vger.kernel.org with ESMTP id S262538AbUCCR57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 12:57:59 -0500
Message-ID: <40461C95.7040603@xor.at>
Date: Wed, 03 Mar 2004 18:57:41 +0100
From: Johannes Resch <jr@xor.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multiple oopses with 2.4.25
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.24.0.6; VDF: 6.24.0.37; host: mail.xor.at)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[please CC me on replies]

I found the following output on a box running 2.4.25-grsec today.
This is a P2-350 (i440BX), 384MB RAM, 2 ide disks on raid1 (md) with 
reiserfs.

Those oopses happened while dpkg was running. I then tried to reboot the 
machine but had to do a hard reset as it wouldn't shut down properly.

Any ideas what could be the cause?

This box has been running without any problems (and hardware changes) 
24/7 for about 1 year, only rebooted for kernel updates.

TIA,
Johannes Resch


Mar  3 17:45:05 merkur kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Mar  3 17:45:05 merkur kernel:  printing eip:
Mar  3 17:45:05 merkur kernel: c01f07cd
Mar  3 17:45:05 merkur kernel: *pde = 00000000
Mar  3 17:45:05 merkur kernel: Oops: 0002
Mar  3 17:45:05 merkur kernel: CPU:    0
Mar  3 17:45:05 merkur kernel: EIP:    0010:[prune_dcache+45/336]    Not 
tainted
Mar  3 17:45:05 merkur kernel: EFLAGS: 00010206
Mar  3 17:45:05 merkur kernel: eax: c0103700   ebx: c25540b8   ecx: 
00000015   edx: 00000000
Mar  3 17:45:05 merkur kernel: esi: c25540a0   edi: 00000000   ebp: 
000036e6   esp: d7fe7f14
Mar  3 17:45:05 merkur kernel: ds: 0018   es: 0018   ss: 0018
Mar  3 17:45:05 merkur kernel: Process kswapd (pid: 4, stackpage=d7fe7000)
Mar  3 17:45:05 merkur kernel: Stack: d780f5c0 c4fe2b60 0000000d 
c10a0660 c01029b8 000025ba c01f0bd4 00003c6c
Mar  3 17:45:05 merkur kernel:        c01d4446 00000006 000001d0 
ffffffff 000001d0 0000000d 00000020 000001d0
Mar  3 17:45:05 merkur kernel:        c01029b8 c01029b8 c01d480d 
d7fe7f80 000001d0 0000003c 00000020 c01d4892
Mar  3 17:45:05 merkur kernel: Call Trace: 
[shrink_dcache_memory+36/64] [shrink_cache+358/912] 
[shrink_caches+61/96] [try_to_free_pages_zone+98/256] [kswa
pd_balance_pgdat+102/176]
Mar  3 17:45:05 merkur kernel:   [kswapd_balance+40/64] [kswapd+152/192] 
[kswapd+0/192] [arch_kernel_thread+46/64] [kswapd+0/192]
Mar  3 17:45:05 merkur kernel:
Mar  3 17:45:05 merkur kernel: Code: 89 02 89 5b 04 89 1b 8b 46 54 a8 08 
74 25 83 e0 f7 89 46 54


Mar  3 17:45:05 merkur kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Mar  3 17:45:05 merkur kernel:  printing eip:
Mar  3 17:45:05 merkur kernel: c01f07c2
Mar  3 17:45:05 merkur kernel: *pde = 00000000
Mar  3 17:45:05 merkur kernel: Oops: 0000
Mar  3 17:45:05 merkur kernel: CPU:    0
Mar  3 17:45:05 merkur kernel: EIP:    0010:[prune_dcache+34/336]    Not 
tainted
Mar  3 17:45:05 merkur kernel: EFLAGS: 00010207
Mar  3 17:45:05 merkur kernel: eax: 00003b84   ebx: 00000000   ecx: 
00000006   edx: 00000001
Mar  3 17:45:05 merkur kernel: esi: c126859c   edi: c01029b8   ebp: 
00003b84   esp: c8045ddc
Mar  3 17:45:05 merkur kernel: ds: 0018   es: 0018   ss: 0018
Mar  3 17:45:05 merkur kernel: Process rrdtool (pid: 26403, 
stackpage=c8045000)
Mar  3 17:45:05 merkur kernel: Stack: d7ffcc90 00000001 0000000f 
c126859c c01029b8 00002612 c01f0bd4 00003b84
Mar  3 17:45:05 merkur kernel:        c01d4446 00000006 000001d2 
ffffffff 000001d2 0000000f 00000020 000001d2
Mar  3 17:45:05 merkur kernel:        c01029b8 c01029b8 c01d480d 
c8045e48 000001d2 0000003c 00000020 c01d4892
Mar  3 17:45:05 merkur kernel: Call Trace: 
[shrink_dcache_memory+36/64] [shrink_cache+358/912] 
[shrink_caches+61/96] [try_to_free_pages_zone+98/256] [bala
nce_classzone+66/480]
Mar  3 17:45:05 merkur kernel:   [__alloc_pages+376/640] 
[do_anonymous_page+108/272] [handle_mm_fault+119/256] 
[do_page_fault+552/1454] [generic_file_read+18
3/432] [file_read_actor+0/160]
Mar  3 17:45:05 merkur kernel:   [sys_read+247/320] 
[do_page_fault+0/1454] [error_code+52/64]
Mar  3 17:45:05 merkur kernel:
Mar  3 17:45:05 merkur kernel: Code: 8b 03 8d 73 e8 8b 53 04 89 50 04 89 
02 89 5b 04 89 1b 8b 46


Mar  3 17:45:06 merkur kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Mar  3 17:45:06 merkur kernel:  printing eip:
Mar  3 17:45:06 merkur kernel: c01f0b3c
Mar  3 17:45:06 merkur kernel: *pde = 00000000
Mar  3 17:45:06 merkur kernel: Oops: 0000
Mar  3 17:45:06 merkur kernel: CPU:    0
Mar  3 17:45:06 merkur kernel: EIP:    0010:[select_parent+92/160] 
Not tainted
Mar  3 17:45:06 merkur kernel: EFLAGS: 00010246
Mar  3 17:45:06 merkur kernel: eax: 00000000   ebx: d7027220   ecx: 
d7027238   edx: d7027138
Mar  3 17:45:06 merkur kernel: esi: d7027140   edi: d7027820   ebp: 
d7027848   esp: cb25ff34
Mar  3 17:45:06 merkur kernel: ds: 0018   es: 0018   ss: 0018
Mar  3 17:45:06 merkur kernel: Process avgatefwd (pid: 30304, 
stackpage=cb25f000)
Mar  3 17:45:06 merkur kernel: Stack: 00000000 d7027820 d7746348 
d77462c0 d7027820 c01f0b98 d7027820 d7027820
Mar  3 17:45:06 merkur kernel:        c01e8ca6 d7027820 cb25e000 
c01e8da1 d7027820 00000003 fffffff3 cb26d000
Mar  3 17:45:06 merkur kernel:        d7027820 00000000 c01e901a 
d77462c0 d7027820 00000000 d780f5c0 d7ffa320
Mar  3 17:45:06 merkur kernel: Call Trace: 
[shrink_dcache_parent+24/48] [d_unhash+38/96] [vfs_rmdir+193/576] 
[sys_rmdir+250/368] [system_call+51/64]
Mar  3 17:45:06 merkur kernel:
Mar  3 17:45:06 merkur kernel: Code: 8b 10 89 4a 04 89 53 18 89 41 04 89 
08 ff 04 24 8d 43 28 39



Mar  3 17:48:52 merkur kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Mar  3 17:48:52 merkur kernel:  printing eip:
Mar  3 17:48:52 merkur kernel: c01f0b3c
Mar  3 17:48:52 merkur kernel: *pde = 00000000
Mar  3 17:48:52 merkur kernel: Oops: 0000
Mar  3 17:48:52 merkur kernel: CPU:    0
Mar  3 17:48:52 merkur kernel: EIP:    0010:[select_parent+92/160] 
Not tainted
Mar  3 17:48:52 merkur kernel: EFLAGS: 00010246
Mar  3 17:48:52 merkur kernel: eax: 00000000   ebx: c72fc9a0   ecx: 
c72fc9b8   edx: ce6e46b8
Mar  3 17:48:52 merkur kernel: esi: ce6e46c0   edi: c4e08de0   ebp: 
c4e08e08   esp: cfd8df34
Mar  3 17:48:52 merkur kernel: ds: 0018   es: 0018   ss: 0018
Mar  3 17:48:52 merkur kernel: Process ctl_cyrusdb (pid: 29171, 
stackpage=cfd8d000)
Mar  3 17:48:52 merkur kernel: Stack: 00000000 c4e08de0 d401de48 
d401ddc0 c4e08de0 c01f0b98 c4e08de0 c4e08de0
Mar  3 17:48:52 merkur kernel:        c01e8ca6 c4e08de0 00000003 
c01e8da1 c4e08de0 00000003 fffffff3 d165d000
Mar  3 17:48:52 merkur kernel:        c4e08de0 00000000 c01e901a 
d401ddc0 c4e08de0 00000000 d42133c0 d7ffa320
Mar  3 17:48:52 merkur kernel: Call Trace: 
[shrink_dcache_parent+24/48] [d_unhash+38/96] [vfs_rmdir+193/576] 
[sys_rmdir+250/368] [system_call+51/64]
Mar  3 17:48:52 merkur kernel:
Mar  3 17:48:52 merkur kernel: Code: 8b 10 89 4a 04 89 53 18 89 41 04 89 
08 ff 04 24 8d 43 28 39


Mar  3 18:22:22 merkur kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Mar  3 18:22:22 merkur kernel:  printing eip:
Mar  3 18:22:22 merkur kernel: c01f0b3c
Mar  3 18:22:22 merkur kernel: *pde = 00000000
Mar  3 18:22:22 merkur kernel: Oops: 0000
Mar  3 18:22:22 merkur kernel: CPU:    0
Mar  3 18:22:22 merkur kernel: EIP:    0010:[select_parent+92/160] 
Not tainted
Mar  3 18:22:22 merkur kernel: EFLAGS: 00010246
Mar  3 18:22:22 merkur kernel: eax: 00000000   ebx: d375e360   ecx: 
d375e378   edx: ca8243b8
Mar  3 18:22:22 merkur kernel: esi: d375e200   edi: ca824620   ebp: 
ca824648   esp: ca04ff34
Mar  3 18:22:22 merkur kernel: ds: 0018   es: 0018   ss: 0018
Mar  3 18:22:22 merkur kernel: Process dpkg (pid: 25114, stackpage=ca04f000)
Mar  3 18:22:22 merkur kernel: Stack: 00000000 ca824620 cab124e8 
cab12460 ca824620 c01f0b98 ca824620 ca824620
Mar  3 18:22:22 merkur kernel:        c01e8ca6 ca824620 00000003 
c01e8da1 ca824620 00000003 fffffff3 c7d2c000
Mar  3 18:22:22 merkur kernel:        ca824620 00000000 c01e901a 
cab12460 ca824620 00000000 d2120640 d7ffa320
Mar  3 18:22:22 merkur kernel: Call Trace: 
[shrink_dcache_parent+24/48] [d_unhash+38/96] [vfs_rmdir+193/576] 
[sys_rmdir+250/368] [system_call+51/64]
Mar  3 18:22:22 merkur kernel:
Mar  3 18:22:22 merkur kernel: Code: 8b 10 89 4a 04 89 53 18 89 41 04 89 
08 ff 04 24 8d 43 28 39

