Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312880AbSCYXrc>; Mon, 25 Mar 2002 18:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312881AbSCYXrN>; Mon, 25 Mar 2002 18:47:13 -0500
Received: from zeus.kernel.org ([204.152.189.113]:39643 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S312880AbSCYXrB>;
	Mon, 25 Mar 2002 18:47:01 -0500
Message-ID: <3C9FB40B.9060203@yahoo.com>
Date: Tue, 26 Mar 2002 02:34:35 +0300
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.19-pre3-ac6
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Just got this Oops:
---
ksymoops 2.4.3 on i686 2.4.19-pre3-ac6.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.19-pre3-ac6/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol 
GPLONLY_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Mar 26 01:11:26 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Mar 26 01:11:26 localhost kernel: c0131fb3
Mar 26 01:11:26 localhost kernel: *pde = 00000000
Mar 26 01:11:26 localhost kernel: Oops: 0002
Mar 26 01:11:26 localhost kernel: CPU:    0
Mar 26 01:11:26 localhost kernel: EIP: 0010:[page_referenced+51/80]    Not tainted
Mar 26 01:11:26 localhost kernel: EIP:    0010:[<c0131fb3>]     Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 26 01:11:26 localhost kernel: EFLAGS: 00210286
Mar 26 01:11:26 localhost kernel: eax: 00000000   ebx: 00000005   ecx: c9211d48   edx: ffffffff
Mar 26 01:11:26 localhost kernel: esi: 00000002   edi: c0267bdc   ebp: 00000222   esp: c1375fa0
Mar 26 01:11:26 localhost kernel: ds: 0018   es: 0018   ss: 0018
Mar 26 01:11:26 localhost kernel: Process kswapd (pid: 4, stackpage=c1375000)
Mar 26 01:11:26 localhost kernel: Stack: c117601c c1176038 c012c5f7 ffffbd1e c1374000 c0267c04 00000000 000004aa
Mar 26 01:11:26 localhost kernel:        00009a1b c0267bdc 000004aa 0008e000 c012cf2c c0267bdc 00000006 00000000
Mar 26 01:11:26 localhost kernel:        00010f00 cffe7fb8 c0105000 0008e000 c0105596 00000000 c012ccc0 c027dfdc
Mar 26 01:11:26 localhost kernel: Call Trace: [refill_inactive_zone+535/704] [kswapd+620/704] 
[_stext+0/32] [kernel_thread+38/48] [kswapd+0/704]
Mar 26 01:11:26 localhost kernel: Call Trace: [<c012c5f7>] [<c012cf2c>] [<c0105000>] [<c0105596>] [<c012ccc0>]
Mar 26 01:11:27 localhost kernel: Code: 0f b3 18 19 d2 8b 09 85 d2 8d 46 01 0f 45 f0 85 c9 75 ea 5b

 >>EIP; c0131fb2 <page_referenced+32/50>   <=====
Trace; c012c5f6 <refill_inactive_zone+216/2c0>
Trace; c012cf2c <kswapd+26c/2c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105596 <kernel_thread+26/30>
Trace; c012ccc0 <kswapd+0/2c0>
Code;  c0131fb2 <page_referenced+32/50>
00000000 <_EIP>:
Code;  c0131fb2 <page_referenced+32/50>   <=====
    0:   0f b3 18                  btr    %ebx,(%eax)   <=====
Code;  c0131fb4 <page_referenced+34/50>
    3:   19 d2                     sbb    %edx,%edx
Code;  c0131fb6 <page_referenced+36/50>
    5:   8b 09                     mov    (%ecx),%ecx
Code;  c0131fb8 <page_referenced+38/50>
    7:   85 d2                     test   %edx,%edx
Code;  c0131fba <page_referenced+3a/50>
    9:   8d 46 01                  lea    0x1(%esi),%eax
Code;  c0131fbe <page_referenced+3e/50>
    c:   0f 45 f0                  cmovne %eax,%esi
Code;  c0131fc0 <page_referenced+40/50>
    f:   85 c9                     test   %ecx,%ecx
Code;  c0131fc2 <page_referenced+42/50>
   11:   75 ea                     jne    fffffffd 
<_EIP+0xfffffffd> c0131fae <page_referenced+2e/50>
Code;  c0131fc4 <page_referenced+44/50>
   13:   5b                        pop    %ebx


2 warnings issued.  Results may not be reliable.
---

page_referenced() is really very small
function, so I beleive finding the faulting
place would not be difficult:)
The strange thing, however, that swap was
completely empty and the load was about
zero, so I don't have any ideas about what
kswapd were doing at that moment.

/proc/meminfo:
        total:    used:    free:  shared: buffers:  cached:
Mem:  262750208 258428928  4321280        0 27529216 79020032
Swap: 542826496        0 542826496
MemTotal:       256592 kB
MemFree:          4220 kB
MemShared:           0 kB
Buffers:         26884 kB
Cached:          77168 kB
SwapCached:          0 kB
Active:         218456 kB
Inact_dirty:      4384 kB
Inact_clean:      6660 kB
Inact_target:    45900 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256592 kB
LowFree:          4220 kB
SwapTotal:      530104 kB
SwapFree:       530104 kB
Committed_AS:   205908 kB
