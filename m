Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281571AbRKPWYD>; Fri, 16 Nov 2001 17:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281572AbRKPWXy>; Fri, 16 Nov 2001 17:23:54 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:54401 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S281571AbRKPWXq>;
	Fri, 16 Nov 2001 17:23:46 -0500
Date: Fri, 16 Nov 2001 14:23:44 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: VM-related Oops: 2.4.15pre1
Message-ID: <20011116142344.A7316@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This box has Oopsed twice but is still running.  Both Oopses followed a
BUG() report (same in both cases):

kernel BUG at page_alloc.c:76!

Which maps to:

        if (page->mapping)
		BUG();

...in __free_pages_ok() in mm/page_alloc.c.

This box has the same setup as I've reported for previous Oopses -- dual
PIII 800 CPUs, 512MB ECC SDRAM, etc.

Decoded oopses for backtraces:

ksymoops 0.7c on i686 2.4.15-pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre1/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0203460, System.map says c0152f70.  Ignoring ksyms_base entry
Reading Oops report from the terminal
invalid operand: 0000
CPU:    1
EIP:    0010:[<c012bf34>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001f   ebx: c108b040   ecx: c02c9040   edx: 000044ae
esi: c108b040   edi: 00000000   ebp: 00000000   esp: c1829f1c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1829000)
Stack: c0270d09 0000004c c108b040 c108b040 00000000 0000001d c0135b3a c108b05c 
       c108b040 00000000 c012b066 c012c855 c108b05c c012b757 00000020 000001d0 
       00000020 00000006 c1828000 00000100 00002263 000001d0 c02ca268 c012ba10 
Call Trace: [<c0135b3a>] [<c012b066>] [<c012c855>] [<c012b757>] [<c012ba10>] 
   [<c012ba5d>] [<c012baf3>] [<c012bb4e>] [<c012bc5d>] [<c01055b4>] 
Code: 0f 0b 83 c4 08 8d b4 26 00 00 00 00 89 f0 2b 05 6c 99 34 c0 

>>EIP; c012bf34 <__free_pages_ok+34/2b8>   <=====
Trace; c0135b3a <try_to_free_buffers+12e/18c>
Trace; c012b066 <lru_cache_del+12/1c>
Trace; c012c855 <page_cache_release+2d/30>
Trace; c012b757 <shrink_cache+26f/3a8>
Trace; c012ba10 <shrink_caches+5c/8c>
Trace; c012ba5d <try_to_free_pages+1d/3c>
Trace; c012baf3 <kswapd_balance_pgdat+43/8c>
Trace; c012bb4e <kswapd_balance+12/28>
Trace; c012bc5d <kswapd+99/bc>
Trace; c01055b4 <kernel_thread+28/38>
Code;  c012bf34 <__free_pages_ok+34/2b8>
00000000 <_EIP>:
Code;  c012bf34 <__free_pages_ok+34/2b8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012bf36 <__free_pages_ok+36/2b8>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012bf39 <__free_pages_ok+39/2b8>
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c012bf40 <__free_pages_ok+40/2b8>
   c:   89 f0                     mov    %esi,%eax
Code;  c012bf42 <__free_pages_ok+42/2b8>
   e:   2b 05 6c 99 34 c0         sub    0xc034996c,%eax


1 warning issued.  Results may not be reliable.

Second Oops:

ksymoops 0.7c on i686 2.4.15-pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre1/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0203460, System.map says c0152f70.  Ignoring ksyms_base entry
Reading Oops report from the terminal
invalid operand: 0000
CPU:    1
EIP:    0010:[<c012bf34>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001f   ebx: c108b040   ecx: c02c9040   edx: 000047e6
esi: c108b040   edi: dbc21330   ebp: 00000000   esp: d1487f00
ds: 0018   es: 0018   ss: 0018
Process getdomainpasswo (pid: 26743, stackpage=d1487000)
Stack: c0270d09 0000004c c108b040 00000073 dbc21330 00000000 c0125d0a 00000010 
       00010203 c108b040 c1885020 c012c855 c108b040 c0125acb d1487f8c c108b040 
       00000000 00000073 00000000 40016000 00000000 00001000 00000073 00000001 
Call Trace: [<c0125d0a>] [<c012c855>] [<c0125acb>] [<c0125da5>] [<c0125cdc>] 
   [<c01321ab>] [<c0106dbb>] 
Code: 0f 0b 83 c4 08 8d b4 26 00 00 00 00 89 f0 2b 05 6c 99 34 c0 

>>EIP; c012bf34 <__free_pages_ok+34/2b8>   <=====
Trace; c0125d0a <file_read_actor+2e/58>
Trace; c012c855 <page_cache_release+2d/30>
Trace; c0125acb <do_generic_file_read+23f/450>
Trace; c0125da5 <generic_file_read+71/8c>
Trace; c0125cdc <file_read_actor+0/58>
Trace; c01321ab <sys_read+8f/c4>
Trace; c0106dbb <system_call+33/38>
Code;  c012bf34 <__free_pages_ok+34/2b8>
00000000 <_EIP>:
Code;  c012bf34 <__free_pages_ok+34/2b8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012bf36 <__free_pages_ok+36/2b8>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012bf39 <__free_pages_ok+39/2b8>
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c012bf40 <__free_pages_ok+40/2b8>
   c:   89 f0                     mov    %esi,%eax
Code;  c012bf42 <__free_pages_ok+42/2b8>
   e:   2b 05 6c 99 34 c0         sub    0xc034996c,%eax


1 warning issued.  Results may not be reliable.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
