Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290113AbSBFGQW>; Wed, 6 Feb 2002 01:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSBFGQN>; Wed, 6 Feb 2002 01:16:13 -0500
Received: from cpe.atm2-0-104230.0xc2b68001.albnxx10.customer.tele.dk ([194.182.128.1]:48997
	"EHLO mailsrv.muh-ko.dk") by vger.kernel.org with ESMTP
	id <S290113AbSBFGQD>; Wed, 6 Feb 2002 01:16:03 -0500
Date: Wed, 6 Feb 2002 07:16:00 +0100
From: Morten Holm <mho.REMOVE-THIS@muh-ko.dk>
To: linux-kernel@vger.kernel.org
Subject: Oopses 2.4.17
Message-ID: <20020206061600.GA2090@muh-ko.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: Muh-ko Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I got these oopses over the night:

ksymoops 2.4.3 on i686 2.4.17.  Options used
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

Warning (compare_maps): ksyms_base symbol sk_chk_filter_R__ver_sk_chk_filter not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol sk_run_filter_R__ver_sk_run_filter not found in System.map.  Ignoring ksyms_base entry
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Unable to handle kernel paging request at virtual address c866ac70
c0120347
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0120347>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c866ac50   ebx: c431e8e0   ecx: 00000001   edx: c431e8e0
esi: ffffffea   edi: 00000000   ebp: 00000eae   esp: c0c63f5c
ds: 0018   es: 0018   ss: 0018
Process gzip (pid: 1813, stackpage=c0c63000)
Stack: c431e8e0 ffffffea 00000000 00000eae 080a6000 080a8000 00000077 080a6000 
       00002000 c432f500 080a9000 00000002 00000000 c866ac50 c432f500 c3664480 
       c0128ceb c431e8e0 08095060 00000eae c431e900 c0c62000 00000eae 08095060 
Call Trace: [<c0128ceb>] [<c0106b0b>] 
Code: 8b 48 20 b8 00 e0 ff ff 21 e0 89 4c 24 30 8b b0 f0 01 00 00 

>>EIP; c0120346 <generic_file_write+1a/664>   <=====
Trace; c0128cea <sys_write+8e/c4>
Trace; c0106b0a <system_call+32/38>
Code;  c0120346 <generic_file_write+1a/664>
00000000 <_EIP>:
Code;  c0120346 <generic_file_write+1a/664>   <=====
   0:   8b 48 20                  mov    0x20(%eax),%ecx   <=====
Code;  c0120348 <generic_file_write+1c/664>
   3:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c012034e <generic_file_write+22/664>
   8:   21 e0                     and    %esp,%eax
Code;  c0120350 <generic_file_write+24/664>
   a:   89 4c 24 30               mov    %ecx,0x30(%esp,1)
Code;  c0120354 <generic_file_write+28/664>
   e:   8b b0 f0 01 00 00         mov    0x1f0(%eax),%esi

 <1>Unable to handle kernel paging request at virtual address c866ac6c
c011def7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011def7>]    Not tainted
EFLAGS: 00010202
eax: c866ac50   ebx: 00000007   ecx: c066aba8   edx: c5f6f000
esi: c866ac50   edi: c5f6f060   ebp: c5f6f000   esp: c11e5fb8
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 6, stackpage=c11e5000)
Stack: 00000007 c066aba0 c5f6f060 c0138e29 c866ac50 c11e4000 c01de557 c11e424b 
       0008e000 c012c091 c012c305 00010f00 c11f9fb0 c021b8f8 c0105478 c021b8f8 
       00000078 c020ffd4 
Call Trace: [<c0138e29>] [<c012c091>] [<c012c305>] [<c0105478>] 
Code: 8b 46 1c 8b 38 eb 57 89 f6 8b 5e 08 8b 53 04 8b 03 89 50 04 

>>EIP; c011def6 <filemap_fdatasync+6/74>   <=====
Trace; c0138e28 <sync_unlocked_inodes+78/154>
Trace; c012c090 <sync_old_buffers+4/40>
Trace; c012c304 <kupdate+e0/e8>
Trace; c0105478 <kernel_thread+28/38>
Code;  c011def6 <filemap_fdatasync+6/74>
00000000 <_EIP>:
Code;  c011def6 <filemap_fdatasync+6/74>   <=====
   0:   8b 46 1c                  mov    0x1c(%esi),%eax   <=====
Code;  c011def8 <filemap_fdatasync+8/74>
   3:   8b 38                     mov    (%eax),%edi
Code;  c011defa <filemap_fdatasync+a/74>
   5:   eb 57                     jmp    5e <_EIP+0x5e> c011df54 <filemap_fdatasync+64/74>
Code;  c011defc <filemap_fdatasync+c/74>
   7:   89 f6                     mov    %esi,%esi
Code;  c011defe <filemap_fdatasync+e/74>
   9:   8b 5e 08                  mov    0x8(%esi),%ebx
Code;  c011df02 <filemap_fdatasync+12/74>
   c:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c011df04 <filemap_fdatasync+14/74>
   f:   8b 03                     mov    (%ebx),%eax
Code;  c011df06 <filemap_fdatasync+16/74>
  11:   89 50 04                  mov    %edx,0x4(%eax)

 <1>Unable to handle kernel paging request at virtual address c866a428
c0139c89
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0139c89>]    Not tainted
EFLAGS: 00010246
eax: c066a068   ebx: c066a240   ecx: c866a428   edx: c066a248
esi: c5f6f000   edi: c0203d40   ebp: 00000d32   esp: c11e9f4c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c11e9000)
Stack: c0831ed8 c0831ec0 c066a240 c0137e0d c066a240 0000001b 000001d0 00000020 
       00000006 c01380cb 00000e93 c0123d50 00000006 000001d0 00000006 000001d0 
       c02018a8 00000000 c02018a8 c0123d9f 00000020 c02018a8 00000001 c11e8000 
Call Trace: [<c0137e0d>] [<c01380cb>] [<c0123d50>] [<c0123d9f>] [<c0123e33>] 
   [<c0123e8e>] [<c0123f9d>] [<c0105478>] 
Code: 89 01 a1 e4 24 20 c0 89 50 04 89 43 08 c7 42 04 e4 24 20 c0 

>>EIP; c0139c88 <iput+f8/198>   <=====
Trace; c0137e0c <prune_dcache+bc/128>
Trace; c01380ca <shrink_dcache_memory+1a/34>
Trace; c0123d50 <shrink_caches+6c/84>
Trace; c0123d9e <try_to_free_pages+36/58>
Trace; c0123e32 <kswapd_balance_pgdat+42/8c>
Trace; c0123e8e <kswapd_balance+12/28>
Trace; c0123f9c <kswapd+98/bc>
Trace; c0105478 <kernel_thread+28/38>
Code;  c0139c88 <iput+f8/198>
00000000 <_EIP>:
Code;  c0139c88 <iput+f8/198>   <=====
   0:   89 01                     mov    %eax,(%ecx)   <=====
Code;  c0139c8a <iput+fa/198>
   2:   a1 e4 24 20 c0            mov    0xc02024e4,%eax
Code;  c0139c8e <iput+fe/198>
   7:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0139c92 <iput+102/198>
   a:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c0139c94 <iput+104/198>
   d:   c7 42 04 e4 24 20 c0      movl   $0xc02024e4,0x4(%edx)

 <1>Unable to handle kernel paging request at virtual address c866a428
c0139ad9
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0139ad9>]    Not tainted
EFLAGS: 00010246
eax: c066a068   ebx: c066a240   ecx: c866a428   edx: c066a248
esi: c11960d8   edi: 0000231d   ebp: c5f6f000   esp: c596fe58
ds: 0018   es: 0018   ss: 0018
Process find (pid: 1890, stackpage=c596f000)
Stack: 00000000 c596ff08 c596fea4 c2446a20 c014acb0 c5f6f000 0000231d 00000000 
       c596fe84 00000000 00000001 00002297 c0147508 c5f6f000 c596ff08 fffffff4 
       c367b280 c2446a20 c3884540 00000001 00000000 00000000 00000000 00000000 
Call Trace: [<c014acb0>] [<c0147508>] [<c01309fb>] [<c0130ffe>] [<c013077d>] 
   [<c013123a>] [<c0131595>] [<c012e989>] [<c01288b7>] [<c0106b0b>] 
Code: 89 01 a1 dc 24 20 c0 89 50 04 89 43 08 c7 42 04 dc 24 20 c0 

>>EIP; c0139ad8 <iget4+6c/cc>   <=====
Trace; c014acb0 <reiserfs_iget+24/68>
Trace; c0147508 <reiserfs_lookup+94/cc>
Trace; c01309fa <real_lookup+52/c4>
Trace; c0130ffe <link_path_walk+4b6/6d8>
Trace; c013077c <getname+5c/9c>
Trace; c013123a <path_walk+1a/1c>
Trace; c0131594 <__user_walk+34/50>
Trace; c012e988 <sys_lstat64+18/70>
Trace; c01288b6 <sys_close+42/54>
Trace; c0106b0a <system_call+32/38>
Code;  c0139ad8 <iget4+6c/cc>
00000000 <_EIP>:
Code;  c0139ad8 <iget4+6c/cc>   <=====
   0:   89 01                     mov    %eax,(%ecx)   <=====
Code;  c0139ada <iget4+6e/cc>
   2:   a1 dc 24 20 c0            mov    0xc02024dc,%eax
Code;  c0139ade <iget4+72/cc>
   7:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0139ae2 <iget4+76/cc>
   a:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c0139ae4 <iget4+78/cc>
   d:   c7 42 04 dc 24 20 c0      movl   $0xc02024dc,0x4(%edx)


3 warnings issued.  Results may not be reliable.

Morten
