Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTLLM1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 07:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTLLM1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 07:27:33 -0500
Received: from ns1.q-leap.de ([153.94.51.193]:49871 "EHLO mail.q-leap.de")
	by vger.kernel.org with ESMTP id S264547AbTLLM10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 07:27:26 -0500
From: Peter Kruse <pkruse@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16345.46124.475998.229968@gargle.gargle.HOWL>
Date: Fri, 12 Dec 2003 13:27:24 +0100
To: linux-kernel@vger.kernel.org
Subject: several oopses with 2.4.23
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: pkruse@arcor.de
X-Face: "HSWKA_'Lr\(@D}NQgU@jZukje>!f;VO]4Tj%~+[PY$M"=CmMyN.x6&X`p_X|q9.||#uM0mH%/3kBIxN-@(lB?3\_)J+ms63HsTY0{WmL3_K+
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

several oopses occured on my machine.

I cannot say when or why this happens.

here is the output of ksymoops (its vanilla 2.4.23 - the -pk1 is just
my own versioning) - compiled with modules disabled:

--------------------------------------8<--------------------------------------

ksymoops 2.4.5 on i586 2.4.23-pk1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pk1/ (default)
     -m /boot/System.map-2.4.23-pk1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000028
c014135b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c014135b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010217
eax: 0000ec72   ebx: 00000000   ecx: 0000000d   edx: c1170000
esi: 00000000   edi: 00000000   ebp: c1176b78   esp: c46bfec4
ds: 0018   es: 0018   ss: 0018
Process find (pid: 1167, stackpage=c46bf000)
Stack: c253dec0 c1176b78 0000ec72 c7d9e000 c0141700 c7d9e000 0000ec72 c1176b78 
       00000000 00000000 c253dec0 c4297980 c253dec0 c3fb56e0 c0165a43 c7d9e000 
       0000ec72 00000000 00000000 fffffff4 c4297980 c013789b c4297980 c253dec0 
Call Trace:    [<c0141700>] [<c0165a43>] [<c013789b>] [<c0137fc7>] [<c0138266>]
  [<c01383d7>] [<c0138612>] [<c0135499>] [<c012eab3>] [<c0108853>]
Code: 39 46 28 75 38 8b 44 24 14 39 86 ac 00 00 00 75 2c 85 ff 74 


>>EIP; c014135b <find_inode+17/64>   <=====

>>eax; 0000ec72 Before first symbol
>>edx; c1170000 <END_OF_CODE+d33400/????>
>>ebp; c1176b78 <END_OF_CODE+d39f78/????>
>>esp; c46bfec4 <END_OF_CODE+42832c4/????>

Trace; c0141700 <iget4+40/d8>
Trace; c0165a43 <ext2_lookup+43/68>
Trace; c013789b <real_lookup+53/c4>
Trace; c0137fc7 <link_path_walk+5cf/854>
Trace; c0138266 <path_walk+1a/1c>
Trace; c01383d7 <path_lookup+1b/24>
Trace; c0138612 <__user_walk+26/40>
Trace; c0135499 <sys_lstat64+19/70>
Trace; c012eab3 <sys_close+43/54>
Trace; c0108853 <system_call+33/40>

Code;  c014135b <find_inode+17/64>
00000000 <_EIP>:
Code;  c014135b <find_inode+17/64>   <=====
   0:   39 46 28                  cmp    %eax,0x28(%esi)   <=====
Code;  c014135e <find_inode+1a/64>
   3:   75 38                     jne    3d <_EIP+0x3d> c0141398 <find_inode+54/64>
Code;  c0141360 <find_inode+1c/64>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c0141364 <find_inode+20/64>
   9:   39 86 ac 00 00 00         cmp    %eax,0xac(%esi)
Code;  c014136a <find_inode+26/64>
   f:   75 2c                     jne    3d <_EIP+0x3d> c0141398 <find_inode+54/64>
Code;  c014136c <find_inode+28/64>
  11:   85 ff                     test   %edi,%edi
Code;  c014136e <find_inode+2a/64>
  13:   74 00                     je     15 <_EIP+0x15> c0141370 <find_inode+2c/64>

 <1>Unable to handle kernel paging request at virtual address ce17f6ec
c01412ab
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01412ab>]    Not tainted
EFLAGS: 00013246
eax: c798b148   ebx: c617f8e8   ecx: 00000000   edx: ce17f6e8
esi: c617f8e0   edi: c798b148   ebp: c11c5f34   esp: c11c5f1c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c11c5000)
Stack: 00000000 c10268cc 00000016 000000d9 c798bb48 c1fba0a8 ffffffff c014132f 
       0000065a c01283aa 00000006 000001d0 00000006 000001d0 0000001f 000001d0 
       c037d5fc c037d5fc c11c4000 000002db 000001d0 c037d5fc c012860b c11c5fa8 
Call Trace:    [<c014132f>] [<c01283aa>] [<c012860b>] [<c0128670>] [<c01287fa>]
  [<c0128866>] [<c012898d>] [<c0107180>]
Code: 89 42 04 89 10 c7 03 00 00 00 00 c7 43 04 00 00 00 00 8b 45 


>>EIP; c01412ab <prune_icache+5f/c8>   <=====

>>eax; c798b148 <END_OF_CODE+754e548/????>
>>ebx; c617f8e8 <END_OF_CODE+5d42ce8/????>
>>edx; ce17f6e8 <END_OF_CODE+dd42ae8/????>
>>esi; c617f8e0 <END_OF_CODE+5d42ce0/????>
>>edi; c798b148 <END_OF_CODE+754e548/????>
>>ebp; c11c5f34 <END_OF_CODE+d89334/????>
>>esp; c11c5f1c <END_OF_CODE+d8931c/????>

Trace; c014132f <shrink_icache_memory+1b/30>
Trace; c01283aa <shrink_cache+292/364>
Trace; c012860b <shrink_caches+2f/3c>
Trace; c0128670 <try_to_free_pages_zone+58/d8>
Trace; c01287fa <kswapd_balance_pgdat+56/a4>
Trace; c0128866 <kswapd_balance+1e/34>
Trace; c012898d <kswapd+99/bc>
Trace; c0107180 <arch_kernel_thread+28/38>

Code;  c01412ab <prune_icache+5f/c8>
00000000 <_EIP>:
Code;  c01412ab <prune_icache+5f/c8>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01412ae <prune_icache+62/c8>
   3:   89 10                     mov    %edx,(%eax)
Code;  c01412b0 <prune_icache+64/c8>
   5:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c01412b6 <prune_icache+6a/c8>
   b:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c01412bd <prune_icache+71/c8>
  12:   8b 45 00                  mov    0x0(%ebp),%eax

 <1>Unable to handle kernel paging request at virtual address ce17f6ec
c01412ab
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01412ab>]    Not tainted
EFLAGS: 00013246
eax: c798b148   ebx: c617f8e8   ecx: 00000000   edx: ce17f6e8
esi: c617f8e0   edi: c798b148   ebp: c644fe18   esp: c644fe00
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 735, stackpage=c644f000)
Stack: 00000000 c106b130 00000004 00000000 c644fe10 c644fe10 ffffffff c014132f 
       00000855 c01283aa 00000006 000001f0 00000006 000001f0 0000001e 000001f0 
       c037d5fc c037d5fc c644e000 00000399 000001f0 c037d5fc c012860b c644fe8c 
Call Trace:    [<c014132f>] [<c01283aa>] [<c012860b>] [<c0128670>] [<c01291ad>]
  [<c01294e1>] [<c012916e>] [<c01295ef>] [<c013bd47>] [<c02f8047>] [<c02a9bdf>]
  [<c013bf26>] [<c013c37c>] [<c0108853>]
Code: 89 42 04 89 10 c7 03 00 00 00 00 c7 43 04 00 00 00 00 8b 45 


>>EIP; c01412ab <prune_icache+5f/c8>   <=====

>>eax; c798b148 <END_OF_CODE+754e548/????>
>>ebx; c617f8e8 <END_OF_CODE+5d42ce8/????>
>>edx; ce17f6e8 <END_OF_CODE+dd42ae8/????>
>>esi; c617f8e0 <END_OF_CODE+5d42ce0/????>
>>edi; c798b148 <END_OF_CODE+754e548/????>
>>ebp; c644fe18 <END_OF_CODE+6013218/????>
>>esp; c644fe00 <END_OF_CODE+6013200/????>

Trace; c014132f <shrink_icache_memory+1b/30>
Trace; c01283aa <shrink_cache+292/364>
Trace; c012860b <shrink_caches+2f/3c>
Trace; c0128670 <try_to_free_pages_zone+58/d8>
Trace; c01291ad <balance_classzone+3d/1e8>
Trace; c01294e1 <__alloc_pages+189/28c>
Trace; c012916e <_alloc_pages+16/18>
Trace; c01295ef <__get_free_pages+b/60>
Trace; c013bd47 <__pollwait+33/8c>
Trace; c02f8047 <unix_poll+23/84>
Trace; c02a9bdf <sock_poll+23/28>
Trace; c013bf26 <do_select+e2/1dc>
Trace; c013c37c <sys_select+334/484>
Trace; c0108853 <system_call+33/40>

Code;  c01412ab <prune_icache+5f/c8>
00000000 <_EIP>:
Code;  c01412ab <prune_icache+5f/c8>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01412ae <prune_icache+62/c8>
   3:   89 10                     mov    %edx,(%eax)
Code;  c01412b0 <prune_icache+64/c8>
   5:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c01412b6 <prune_icache+6a/c8>
   b:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c01412bd <prune_icache+71/c8>
  12:   8b 45 00                  mov    0x0(%ebp),%eax


1 warning and 1 error issued.  Results may not be reliable.



--------------------------------------8<--------------------------------------

regards and thanks,

    Peter

-- 
.signature: No such file or directory.

