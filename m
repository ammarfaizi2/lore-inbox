Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290047AbSBFE5w>; Tue, 5 Feb 2002 23:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290059AbSBFE5n>; Tue, 5 Feb 2002 23:57:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44806 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290047AbSBFE5b>; Tue, 5 Feb 2002 23:57:31 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: 2.4.17: kswap crash in prune_dcache()
Date: 5 Feb 2002 20:57:16 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3qd3c$2jk$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additional information at:

	http://userweb.kernel.org/~hpa/kswap/

After this event the machine was dead to userland, but still answered
pings.

2.4.17 SMP PAE kernel, modules disabled.

	-hpa



ksymoops 2.4.1 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014773c>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001c   ebx: c8b58a98     ecx: c035ba00       edx: 0000c87a
esi: c8b58a80   edi: c703737c     ebp: 0000d1a2       esp: c7059f28
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c7059000)
Stack: c03137a3 00000159 00000006 00000020 c02fee6c 00000020 00000006 d14846d0
       000001d0 00000006 00000007 000001d0 00000006 0000000d c0147b20 0001a1f6
       c012e027 00000006 000001d0 c035caa8 00000006 000001d0 c035caa8 00000000
Call Trace: [<c0147b20>] [<c012e027>] [<c012e07c>] [<c012e121>] [<c012e196>]
   [<c012e2d1>] [<c012e230>] [<c0105000>] [<c0105866>] [<c012e230>]
Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56

>>EIP; c014773c <prune_dcache+7c/170>   <=====
Trace; c0147b20 <shrink_dcache_memory+20/30>
Trace; c012e027 <shrink_caches+67/80>
Trace; c012e07c <try_to_free_pages+3c/60>
Trace; c012e121 <kswapd_balance_pgdat+51/a0>
Trace; c012e196 <kswapd_balance+26/40>
Trace; c012e2d1 <kswapd+a1/c0>
Trace; c012e230 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105866 <kernel_thread+26/30>
Trace; c012e230 <kswapd+0/c0>
Code;  c014773c <prune_dcache+7c/170>
00000000 <_EIP>:
Code;  c014773c <prune_dcache+7c/170>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014773e <prune_dcache+7e/170>
   2:   5f                        pop    %edi
Code;  c014773f <prune_dcache+7f/170>
   3:   58                        pop    %eax
Code;  c0147740 <prune_dcache+80/170>
   4:   8d 56 10                  lea    0x10(%esi),%edx
Code;  c0147743 <prune_dcache+83/170>
   7:   8b 4a 04                  mov    0x4(%edx),%ecx
Code;  c0147746 <prune_dcache+86/170>
   a:   8b 46 10                  mov    0x10(%esi),%eax
Code;  c0147749 <prune_dcache+89/170>
   d:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c014774c <prune_dcache+8c/170>
  10:   89 01                     mov    %eax,(%ecx)
Code;  c014774e <prune_dcache+8e/170>
  12:   89 56 00                  mov    %edx,0x0(%esi)


1 warning and 1 error issued.  Results may not be reliable.
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
