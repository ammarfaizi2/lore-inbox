Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTFTBjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 21:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbTFTBjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 21:39:36 -0400
Received: from rosdorff.xs4all.nl ([213.84.29.108]:45065 "EHLO
	rosdorff.xs4all.nl") by vger.kernel.org with ESMTP id S262143AbTFTBje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 21:39:34 -0400
Date: Fri, 20 Jun 2003 03:53:33 +0200 (CEST)
From: Coen Rosdorff <coen@rosdorff.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Recent kernel oops: kernel BUG at dcache.c:345!
Message-ID: <Pine.LNX.4.44.0306200341420.1263-100000@rosdorff.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the last months I had some kernel oopses. All of them looks the 
same. [1]

I have seen this also with kernel 2.4.19, 2.4.20 and 2.4.21rc2.

Hardware:
cpu: pentium 166mmx
ram: 96mb sdram
io: 3ware 6410 (ata-raid) with 2x 60GB IBM disks in raid 1
nic: 2x 3com 3c509

Software:
distri: Redhat 7.3 with al relevant updates
kernel: custom build 2.4.21 kernel

Is it possible for someone to give me a direction to help me solve this 
problem?

gr,
Coen

[1]:

# ksymoops -k ksyms.20030618 -l lsmod.20030618 < oops.20030618 
ksymoops 2.4.4 on i586 2.4.21.  Options used
     -V (default)
     -k ksyms.20030618 (specified)
     -l lsmod.20030618 (specified)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.4.21 (default)

Warning (compare_ksyms_lsmod): module Module is in lsmod but not in ksyms, 
probably no symbols exported
Jun 18 05:00:06 rosdorff kernel: kernel BUG at dcache.c:345!
Jun 18 05:00:06 rosdorff kernel: invalid operand: 0000
Jun 18 05:00:06 rosdorff kernel: CPU:    0
Jun 18 05:00:06 rosdorff kernel: EIP:    0010:[<c0141264>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 18 05:00:06 rosdorff kernel: EFLAGS: 00010206
Jun 18 05:00:06 rosdorff kernel: eax: 00000100   ebx: c17a8958   ecx: 
c110ff84   edx: c17a89d8
Jun 18 05:00:06 rosdorff kernel: esi: c17a8940   edi: 000019c1   ebp: 
00000393   esp: c1163f20
Jun 18 05:00:06 rosdorff kernel: ds: 0018   es: 0018   ss: 0018
Jun 18 05:00:06 rosdorff kernel: Process kswapd (pid: 4, 
stackpage=c1163000)
Jun 18 05:00:06 rosdorff kernel: Stack: 00000000 c10ddf38 0000001c 
000005fb c012a5f8 00000000 c1162000 ffffffff 
Jun 18 05:00:06 rosdorff kernel:        000001d0 c027abb0 c110e2dc 
c18f2004 0000001c 000001d0 00000006 0000000d 
Jun 18 05:00:06 rosdorff kernel:        c0141605 0000046f c012a7d7 
00000006 000001d0 c027abb0 00000006 000001d0 
Jun 18 05:00:06 rosdorff kernel: Call Trace:    [<c012a5f8>] [<c0141605>] 
[<c012a7d7>] [<c012a830>] [<c012a945>]
Jun 18 05:00:06 rosdorff kernel:   [<c012a9a6>] [<c012aae1>] [<c012aa40>] 
[<c0105000>] [<c0107176>] [<c012aa40>]
Jun 18 05:00:06 rosdorff kernel: Code: 0f 0b 59 01 71 41 24 c0 8d 56 10 8b 
46 10 8b 4a 04 89 48 04 

>>EIP; c0141264 <prune_dcache+74/160>   <=====
Trace; c012a5f8 <shrink_cache+298/310>
Trace; c0141605 <shrink_dcache_memory+25/40>
Trace; c012a7d7 <shrink_caches+67/90>
Trace; c012a830 <try_to_free_pages_zone+30/50>
Trace; c012a945 <kswapd_balance_pgdat+45/90>
Trace; c012a9a6 <kswapd_balance+16/30>
Trace; c012aae1 <kswapd+a1/c0>
Trace; c012aa40 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0107176 <arch_kernel_thread+26/30>
Trace; c012aa40 <kswapd+0/c0>
Code;  c0141264 <prune_dcache+74/160>
00000000 <_EIP>:
Code;  c0141264 <prune_dcache+74/160>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0141266 <prune_dcache+76/160>
   2:   59                        pop    %ecx
Code;  c0141267 <prune_dcache+77/160>
   3:   01 71 41                  add    %esi,0x41(%ecx)
Code;  c014126a <prune_dcache+7a/160>
   6:   24 c0                     and    $0xc0,%al
Code;  c014126c <prune_dcache+7c/160>
   8:   8d 56 10                  lea    0x10(%esi),%edx
Code;  c014126f <prune_dcache+7f/160>
   b:   8b 46 10                  mov    0x10(%esi),%eax
Code;  c0141272 <prune_dcache+82/160>
   e:   8b 4a 04                  mov    0x4(%edx),%ecx
Code;  c0141275 <prune_dcache+85/160>
  11:   89 48 04                  mov    %ecx,0x4(%eax)


1 warning issued.  Results may not be reliable.

