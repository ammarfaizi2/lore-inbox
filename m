Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSG1JAw>; Sun, 28 Jul 2002 05:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSG1JAv>; Sun, 28 Jul 2002 05:00:51 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:44689 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S315285AbSG1JAc>; Sun, 28 Jul 2002 05:00:32 -0400
Date: Sun, 28 Jul 2002 17:03:36 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at page_alloc.c:91 (2.4.19-rc2-xfs)
Message-ID: <20020728090336.GD1265@leathercollection.ph>
Mail-Followup-To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020728082542.GC1265@leathercollection.ph> <20020728084718.GW1548@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020728084718.GW1548@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
X-Organization: The Leather Collection, Inc.
X-Organization-URL: http://www.leathercollection.ph
X-Personal-URL: http://jijo.free.net.ph
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 11:47:19AM +0300, Ville Herva wrote:
> Please run these through ksymoops to get the hexadecimal addresses
> resolved to function names. See
> /usr/src/linux/Documentation/oops-tracing.txt.

Ah, yes, I had forgotten to do that. I hadn't realized that the same
requirement for reporting oopses held for reporting kernel BUGs.  My
sincerest apologies. I ran all four through ksymoops at once, and it
worked so I guess this is a valid thing to do. I am still running the
same configuration and haven't even rebooted, so I did not have to
change any of ksymoops's defaults.

The 'decoded' message follows.

Thanks for the help.

 --> Jijo

[1] Kernel BUG reports from dmesg passed through ksymoops:

ksymoops 2.4.5 on i686 2.4.19-rc2-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc2-xfs/ (default)
     -m /boot/System.map-2.4.19-rc2-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013536d>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210282
eax: c11c90fc   ebx: c11c73d4   ecx: 00000000   edx: c0333f40
esi: 00000000   edi: 000011b9   ebp: c0334050   esp: c12f3f08
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c12f3000)
Stack: 00000001 00200282 00000003 cf0dc8c0 cf0dc8c0 cf0dc8c0 c11c73d4 c013f0e2 
       cf0dc8c0 c0333f40 c11c73d4 000011b9 c0334050 c0134852 c11c73d4 000001d0 
       c12f2000 000001c7 000001d0 00000002 0000001f 000001d0 00000020 00000006 
Call Trace: [<c013f0e2>] [<c0134852>] [<c0134a11>] [<c0134a86>] [<c0134b36>] 
   [<c0134b98>] [<c0134ccd>] [<c0105000>] [<c01071fe>] [<c0134c30>] 
Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 


>>EIP; c013536d <__free_pages_ok+2d/260>   <=====

>>eax; c11c90fc <_end+e0baf8/104d29fc>
>>ebx; c11c73d4 <_end+e09dd0/104d29fc>
>>edx; c0333f40 <swapper_space+0/30>
>>edi; 000011b9 Before first symbol
>>ebp; c0334050 <contig_page_data+b0/340>
>>esp; c12f3f08 <_end+f36904/104d29fc>

Trace; c013f0e2 <try_to_free_buffers+82/f0>
Trace; c0134852 <shrink_cache+282/310>
Trace; c0134a11 <shrink_caches+61/a0>
Trace; c0134a86 <try_to_free_pages+36/60>
Trace; c0134b36 <kswapd_balance_pgdat+56/a0>
Trace; c0134b98 <kswapd_balance+18/30>
Trace; c0134ccd <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01071fe <kernel_thread+2e/40>
Trace; c0134c30 <kswapd+0/c0>

Code;  c013536d <__free_pages_ok+2d/260>
00000000 <_EIP>:
Code;  c013536d <__free_pages_ok+2d/260>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013536f <__free_pages_ok+2f/260>
   2:   5b                        pop    %ebx
Code;  c0135370 <__free_pages_ok+30/260>
   3:   00 f0                     add    %dh,%al
Code;  c0135372 <__free_pages_ok+32/260>
   5:   62 2f                     bound  %ebp,(%edi)
Code;  c0135374 <__free_pages_ok+34/260>
   7:   c0 89 d8 2b 05 d0 b0      rorb   $0xb0,0xd0052bd8(%ecx)
Code;  c013537b <__free_pages_ok+3b/260>
   e:   39 c0                     cmp    %eax,%eax
Code;  c013537d <__free_pages_ok+3d/260>
  10:   c1 f8 02                  sar    $0x2,%eax
Code;  c0135380 <__free_pages_ok+40/260>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax

 kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013536d>]    Tainted: P 
EFLAGS: 00210282
eax: c11ee984   ebx: c1261cc4   ecx: 00000000   edx: c0333f40
esi: 00000000   edi: 00001232   ebp: c0334050   esp: c72bddc0
ds: 0018   es: 0018   ss: 0018
Process http (pid: 14620, stackpage=c72bd000)
Stack: 00000001 00200282 00000003 cf0dc3c0 cf0dc3c0 cf0dc3c0 c1261cc4 c013f0e2 
       cf0dc3c0 c0333f40 c1261cc4 00001232 c0334050 c0134852 c1261cc4 000001d2 
       c72bc000 000001d1 000001d2 00000020 0000001e 000001d2 00000020 00000006 
Call Trace: [<c013f0e2>] [<c0134852>] [<c0134a11>] [<c0134a86>] [<c0135827>] 
   [<c0135a7d>] [<c01306b2>] [<c029e04d>] [<c01fd88f>] [<c029e420>] [<c01f90c4>] 
   [<c013ae93>] [<c0108db7>] 
Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 


>>EIP; c013536d <__free_pages_ok+2d/260>   <=====

>>eax; c11ee984 <_end+e31380/104d29fc>
>>ebx; c1261cc4 <_end+ea46c0/104d29fc>
>>edx; c0333f40 <swapper_space+0/30>
>>edi; 00001232 Before first symbol
>>ebp; c0334050 <contig_page_data+b0/340>
>>esp; c72bddc0 <_end+6f007bc/104d29fc>

Trace; c013f0e2 <try_to_free_buffers+82/f0>
Trace; c0134852 <shrink_cache+282/310>
Trace; c0134a11 <shrink_caches+61/a0>
Trace; c0134a86 <try_to_free_pages+36/60>
Trace; c0135827 <balance_classzone+57/1c0>
Trace; c0135a7d <__alloc_pages+ed/190>
Trace; c01306b2 <do_generic_file_write+332/6e0>
Trace; c029e04d <ip_local_deliver+4d/70>
Trace; c01fd88f <xfs_write+24f/860>
Trace; c029e420 <ip_rcv_finish+0/220>
Trace; c01f90c4 <linvfs_write+e4/120>
Trace; c013ae93 <sys_write+a3/130>
Trace; c0108db7 <system_call+33/38>

Code;  c013536d <__free_pages_ok+2d/260>
00000000 <_EIP>:
Code;  c013536d <__free_pages_ok+2d/260>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013536f <__free_pages_ok+2f/260>
   2:   5b                        pop    %ebx
Code;  c0135370 <__free_pages_ok+30/260>
   3:   00 f0                     add    %dh,%al
Code;  c0135372 <__free_pages_ok+32/260>
   5:   62 2f                     bound  %ebp,(%edi)
Code;  c0135374 <__free_pages_ok+34/260>
   7:   c0 89 d8 2b 05 d0 b0      rorb   $0xb0,0xd0052bd8(%ecx)
Code;  c013537b <__free_pages_ok+3b/260>
   e:   39 c0                     cmp    %eax,%eax
Code;  c013537d <__free_pages_ok+3d/260>
  10:   c1 f8 02                  sar    $0x2,%eax
Code;  c0135380 <__free_pages_ok+40/260>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax

 kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013536d>]    Tainted: P 
EFLAGS: 00210282
eax: c128cef4   ebx: c1209ea8   ecx: 00000000   edx: c0333f40
esi: 00000000   edi: 00001234   ebp: c0334050   esp: cd2ffdec
ds: 0018   es: 0018   ss: 0018
Process ssh (pid: 14631, stackpage=cd2ff000)
Stack: 00000001 00200282 00000003 cf0dc340 cf0dc340 cf0dc340 c1209ea8 c013f0e2 
       cf0dc340 c0333f40 c1209ea8 00001234 c0334050 c0134852 c1209ea8 000001d2 
       cd2fe000 000001d2 000001d2 00000020 0000001f 000001d2 00000020 00000006 
Call Trace: [<c013f0e2>] [<c0134852>] [<c0134a11>] [<c0134a86>] [<c0135827>] 
   [<c0135a7d>] [<c012b638>] [<c012b8e7>] [<c011897e>] [<d0966c00>] [<d0966c00>] 
   [<d08a1586>] [<c012cfc8>] [<c012be88>] [<c0118820>] [<c0108ea8>] 
Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 


>>EIP; c013536d <__free_pages_ok+2d/260>   <=====

>>eax; c128cef4 <_end+ecf8f0/104d29fc>
>>ebx; c1209ea8 <_end+e4c8a4/104d29fc>
>>edx; c0333f40 <swapper_space+0/30>
>>edi; 00001234 Before first symbol
>>ebp; c0334050 <contig_page_data+b0/340>
>>esp; cd2ffdec <_end+cf427e8/104d29fc>

Trace; c013f0e2 <try_to_free_buffers+82/f0>
Trace; c0134852 <shrink_cache+282/310>
Trace; c0134a11 <shrink_caches+61/a0>
Trace; c0134a86 <try_to_free_pages+36/60>
Trace; c0135827 <balance_classzone+57/1c0>
Trace; c0135a7d <__alloc_pages+ed/190>
Trace; c012b638 <do_anonymous_page+68/f0>
Trace; c012b8e7 <handle_mm_fault+77/110>
Trace; c011897e <do_page_fault+15e/4e9>
Trace; d0966c00 <[NVdriver]nv_linux_devices+0/4a0>
Trace; d0966c00 <[NVdriver]nv_linux_devices+0/4a0>
Trace; d08a1586 <[NVdriver]__nvsym00486+82/90>
Trace; c012cfc8 <do_brk+118/210>
Trace; c012be88 <sys_brk+108/140>
Trace; c0118820 <do_page_fault+0/4e9>
Trace; c0108ea8 <error_code+34/3c>

Code;  c013536d <__free_pages_ok+2d/260>
00000000 <_EIP>:
Code;  c013536d <__free_pages_ok+2d/260>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013536f <__free_pages_ok+2f/260>
   2:   5b                        pop    %ebx
Code;  c0135370 <__free_pages_ok+30/260>
   3:   00 f0                     add    %dh,%al
Code;  c0135372 <__free_pages_ok+32/260>
   5:   62 2f                     bound  %ebp,(%edi)
Code;  c0135374 <__free_pages_ok+34/260>
   7:   c0 89 d8 2b 05 d0 b0      rorb   $0xb0,0xd0052bd8(%ecx)
Code;  c013537b <__free_pages_ok+3b/260>
   e:   39 c0                     cmp    %eax,%eax
Code;  c013537d <__free_pages_ok+3d/260>
  10:   c1 f8 02                  sar    $0x2,%eax
Code;  c0135380 <__free_pages_ok+40/260>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax

 kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013536d>]    Tainted: P 
EFLAGS: 00210282
eax: c12987b8   ebx: c10b9ba8   ecx: 00000000   edx: c0333f40
esi: 00000000   edi: 00001235   ebp: c0334050   esp: cd2ffdd0
ds: 0018   es: 0018   ss: 0018
Process ssh (pid: 14633, stackpage=cd2ff000)
Stack: 00000001 00200282 00000003 cf0dc1c0 cf0dc1c0 cf0dc1c0 c10b9ba8 c013f0e2 
       cf0dc1c0 c0333f40 c10b9ba8 00001235 c0334050 c0134852 c10b9ba8 000001d2 
       cd2fe000 000001d2 000001d2 0000001f 00000020 000001d2 00000020 00000006 
Call Trace: [<c013f0e2>] [<c0134852>] [<c0134a11>] [<c0134a86>] [<c0135827>] 
   [<c0135a7d>] [<c012b7c1>] [<c012b8e7>] [<c011897e>] [<c010e601>] [<c013a3cd>] 
   [<c0118820>] [<c0108ea8>] 
Code: 0f 0b 5b 00 f0 62 2f c0 89 d8 2b 05 d0 b0 39 c0 c1 f8 02 69 


>>EIP; c013536d <__free_pages_ok+2d/260>   <=====

>>eax; c12987b8 <_end+edb1b4/104d29fc>
>>ebx; c10b9ba8 <_end+cfc5a4/104d29fc>
>>edx; c0333f40 <swapper_space+0/30>
>>edi; 00001235 Before first symbol
>>ebp; c0334050 <contig_page_data+b0/340>
>>esp; cd2ffdd0 <_end+cf427cc/104d29fc>

Trace; c013f0e2 <try_to_free_buffers+82/f0>
Trace; c0134852 <shrink_cache+282/310>
Trace; c0134a11 <shrink_caches+61/a0>
Trace; c0134a86 <try_to_free_pages+36/60>
Trace; c0135827 <balance_classzone+57/1c0>
Trace; c0135a7d <__alloc_pages+ed/190>
Trace; c012b7c1 <do_no_page+101/1b0>
Trace; c012b8e7 <handle_mm_fault+77/110>
Trace; c011897e <do_page_fault+15e/4e9>
Trace; c010e601 <old_mmap+101/120>
Trace; c013a3cd <filp_close+4d/80>
Trace; c0118820 <do_page_fault+0/4e9>
Trace; c0108ea8 <error_code+34/3c>

Code;  c013536d <__free_pages_ok+2d/260>
00000000 <_EIP>:
Code;  c013536d <__free_pages_ok+2d/260>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013536f <__free_pages_ok+2f/260>
   2:   5b                        pop    %ebx
Code;  c0135370 <__free_pages_ok+30/260>
   3:   00 f0                     add    %dh,%al
Code;  c0135372 <__free_pages_ok+32/260>
   5:   62 2f                     bound  %ebp,(%edi)
Code;  c0135374 <__free_pages_ok+34/260>
   7:   c0 89 d8 2b 05 d0 b0      rorb   $0xb0,0xd0052bd8(%ecx)
Code;  c013537b <__free_pages_ok+3b/260>
   e:   39 c0                     cmp    %eax,%eax
Code;  c013537d <__free_pages_ok+3d/260>
  10:   c1 f8 02                  sar    $0x2,%eax
Code;  c0135380 <__free_pages_ok+40/260>
  13:   69 00 00 00 00 00         imul   $0x0,(%eax),%eax


1 warning issued.  Results may not be reliable.



-- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE
