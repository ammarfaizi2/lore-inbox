Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVECSDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVECSDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVECSDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:03:43 -0400
Received: from mail.native-instruments.de ([217.9.41.138]:58788 "EHLO
	mail.native-instruments.de") by vger.kernel.org with ESMTP
	id S261491AbVECSC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:02:58 -0400
From: Andreas Roedl <andreas.roedl@native-instruments.de>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at lib/radix-tree.c:344 and 575
Date: Tue, 3 May 2005 20:03:20 +0200
User-Agent: KMail/1.7.2
Organization: Native Instruments
Cc: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505032003.23147.andreas.roedl@native-instruments.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

A fresh machine (hardware/software) freezes frequently after about 30 hours. 
Its main purpose is being a database server (postgresql). All the partitions 
are reiserfs formatted logical volumes. A reboot is needed.

Linux sdbs 2.6.11-gentoo-r6 #3 Fri Apr 22 19:11:35 CEST 2005 i686 Intel(R) 
Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux

Gnu C                  3.3.5-20050130
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.19
reiser4progs           line
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.4
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   045
Modules Loaded         8139cp ipv6 8139too mii

Distribution           Gentoo

19:02:42 host kernel BUG at lib/radix-tree.c:344!
19:02:42 host invalid operand: 0000 [#1]
19:02:42 host Modules linked in: ipv6 8139cp 8139too mii
19:02:42 host CPU:    0
19:02:42 host EIP:    0060:[<c01db957>]    Not tainted VLI
19:02:42 host EFLAGS: 00010046   (2.6.11-gentoo-r6)
19:02:42 host EIP is at radix_tree_tag_set+0x87/0xa0
19:02:42 host eax: d23f7f14   ebx: d23f7e38   ecx: 00000000   edx: 00000037
19:02:42 host esi: 00000001   edi: 00000000   ebp: d23f7f18   esp: f7e19d38
19:02:42 host ds: 007b   es: 007b   ss: 0068
19:02:42 host Process kswapd0 (pid: 66, threadinfo=f7e18000 task=f7c77020)
19:02:42 host Stack: 00000008 cd5aabd0 00000000 c12ffd60 00000282 c013519b 
cd5aabd4 000004f7
19:02:42 host 00000001 000004f8 c0c7089c c0c7089c 00000000 c0191cf7 c12ffd60 
c15269c0
19:02:42 host 0002834e 00000001 f24ab000 00000000 c02f05fc cd5aab30 f7e19dbc 
00000202
19:02:42 host Call Trace:
19:02:42 host [<c013519b>] test_set_page_writeback+0x6b/0x100
19:02:42 host [<c0191cf7>] reiserfs_write_full_page+0x1b7/0x470
19:02:42 host [<c0191ff6>] reiserfs_writepage+0x26/0x40
19:02:42 host [<c0139064>] pageout+0xb4/0x100
19:02:42 host [<c012e634>] __remove_from_page_cache+0x24/0x50
19:02:42 host [<c0139293>] shrink_list+0x1e3/0x3f0
19:02:42 host [<c013960c>] shrink_cache+0x16c/0x300
19:02:42 host [<c0139cfa>] shrink_zone+0xba/0xf0
19:02:42 host [<c013a208>] balance_pgdat+0x2b8/0x3b0
19:02:42 host [<c013a3dd>] kswapd+0xdd/0xf0
19:02:42 host [<c0125590>] autoremove_wake_function+0x0/0x60
19:02:42 host [<c0125590>] autoremove_wake_function+0x0/0x60
19:02:42 host [<c013a300>] kswapd+0x0/0xf0
19:02:42 host [<c010085d>] kernel_thread_helper+0x5/0x18
19:02:42 host Code: c0 85 c0 75 0a 0f ab 91 04 01 00 00 8b 5d 00 8d 04 93 8b 
48 04 8d 68 04 85 c9 74 0f 83 ef 06 4e 75 c2 8b 45 00 5a 5b 5e 5f 5d c3 <0f> 
0b 58 01
7e b4 2c c0 eb e7 31 c0 eb ec 8d 74 26 00 8d bc 27


19:19:17 host kernel BUG at lib/radix-tree.c:575!
19:19:17 host invalid operand: 0000 [#2]
19:19:17 host Modules linked in: ipv6 8139cp 8139too mii
19:19:17 host CPU:    0
19:19:17 host EIP:    0060:[<c01dbcfc>]    Not tainted VLI
19:19:17 host EFLAGS: 00010046   (2.6.11-gentoo-r6)
19:19:17 host EIP is at __lookup_tag+0x14c/0x160
19:19:17 host eax: 00000000   ebx: 000004f7   ecx: 00000037   edx: d23f7e40
19:19:17 host esi: 00000001   edi: d23f7e38   ebp: 00000001   esp: de5d7e88
19:19:17 host ds: 007b   es: 007b   ss: 0068
19:19:17 host Process postmaster (pid: 15046, threadinfo=de5d6000 
task=f7c77a20)
19:19:17 host Stack: 00000037 00000008 d23f7e38 00000000 00000000 00000000 
0000000e 00000fff
19:19:17 host cd5aabd4 c01dbd73 cd5aabd4 de5d7f40 00000000 0000000e de5d7ec8 
00000001
19:19:17 host f7ea0d14 de5d7f40 de5d7f34 d8504480 00000fff c012f157 cd5aabd4 
de5d7f40
19:19:17 host Call Trace:
19:19:17 host [<c01dbd73>] radix_tree_gang_lookup_tag+0x63/0x80
19:19:17 host [<c012f157>] find_get_pages_tag+0x37/0x70
19:19:17 host [<c0138556>] pagevec_lookup_tag+0x36/0x40
19:19:17 host [<c012e8f6>] wait_on_page_writeback_range+0x76/0x130
19:19:17 host [<c023c7d6>] dm_table_flush_all+0x66/0x68
19:19:17 host [<c023a1f1>] dm_flush_all+0x41/0x60
19:19:17 host [<c012ebcc>] filemap_fdatawait+0x4c/0x50
19:19:17 host [<c014d873>] sys_fdatasync+0xb3/0xd0
19:19:17 host [<c01024a3>] syscall_call+0x7/0xb
19:19:17 host Code: 44 24 38 89 18 8b 44 24 10 83 c4 14 5b 5e 5f 5d c3 0f 0b 
50 02 7e b4 2c c0 eb 9e 8b 7c 24 08 8b 44 8f 04 85 c0 0f 85 4b ff ff ff <0f> 
0b 3f 02
7e b4 2c c0 e9 3e ff ff ff 8d b4 26 00 00 00 00 55

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 3007.743
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor 
ds_cpl cid xtpr
bogomips        : 5947.39

0000:00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM 
Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller 
(rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC 
Interface Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE 
Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller 
(rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 
4000 AGP 8x] (rev c1)
0000:02:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)




Andreas
-- 
-> Andreas Roedl            -> Senior IT Manager
-> NATIVE INSTRUMENTS       -> andreas.roedl@native-instruments.de
-> Schlesische Strasse 28   -> http://www.native-instruments.de/
-> D-10997 Berlin           -> Tel. +49-30-61 10 35-1711
-> Germany                  -> Fax  +49-30-61 10 35-2711
