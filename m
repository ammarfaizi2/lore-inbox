Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVEFH3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVEFH3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 03:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVEFH3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 03:29:53 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:50304 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S261159AbVEFH22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 03:28:28 -0400
Date: Fri, 6 May 2005 10:28:20 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: Willy Tarreau <willy@w.ods.org>
cc: openafs-info@openafs.org, linux-kernel@vger.kernel.org
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and
 openafs 1.3.82
In-Reply-To: <20050506052803.GE777@alpha.home.local>
Message-ID: <Pine.LNX.4.62.0505061024070.450@tassadar.physics.auth.gr>
References: <Pine.LNX.4.62.0505060209040.31479@tassadar.physics.auth.gr>
 <20050506052803.GE777@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.30.0.12; VDF: 6.30.0.157; host: tassadar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Oopses on an openafs client system using openafs 1.3.78 and kernel 2.4.29.
>> Oopses also occur afer moving to kernel 2.4.30 and openafs 1.3.82
>
> The problem you encounter on 2.4.30 is not the same as on 2.4.29. The problem
> in 2.4.29 is related to link_path_walk, which has been fixed in 2.4.30.
>
> You might want to try 1.3.78 (or other) with 2.4.29-hf7 to check if your
> 2.4.30 problem was brought by kernel 2.4.30 or openafs 1.3.82, as the
> link_path_walk bug is also fixed in hf7. The patch is available on :
>
>     http://linux.exosec.net/kernel/2.4-hf/
>
> Regards,
> Willy

 	Hi

Thanks I will give it a try. Meanwhile when I woke up this morning I found 
the system frozen once more , and 4 new oopses :

a)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.30/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): libafs-2.4.30.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
May  6 04:55:29 system kernel: kernel BUG at inode.c:1204!
May  6 04:55:29 system kernel: invalid operand: 0000
May  6 04:55:29 system kernel: CPU:    1
May  6 04:55:29 system kernel: EIP:    0010:[<c015a980>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May  6 04:55:29 system kernel: EFLAGS: 00010246
May  6 04:55:29 system kernel: eax: 00000000   ebx: d68521c0   ecx: d68521d0   edx: d68521d0
May  6 04:55:29 system kernel: esi: ee48e800   edi: 00000000   ebp: 0001a590   esp: effddf04
May  6 04:55:29 system kernel: ds: 0018   es: 0018   ss: 0018
May  6 04:55:29 system kernel: Process kswapd (pid: 5, stackpage=effdd000)
May  6 04:55:29 system kernel: Stack: 00000000 c0157571 ddeba560 ea88c978 ea88c960 d68521c0 c01579ce d68521c0
May  6 04:55:29 system kernel:        c7f876c0 00000002 c1234984 c03a3a7c 00000966 c0157da4 000222b7 c0138e80
May  6 04:55:29 system kernel:        00000006 000001d0 ffffffff 000001d0 00000002 0000001e 000001d0 c03a3a7c
May  6 04:55:29 system kernel: Call Trace:    [<c0157571>] [<c01579ce>] [<c0157da4>] [<c0138e80>] [<c01392ea>]
May  6 04:55:29 system kernel:   [<c0139362>] [<c0139526>] [<c0139598>] [<c01396d8>] [<c0105000>] [<c010740e>]
May  6 04:55:29 system kernel:   [<c0139640>]
May  6 04:55:29 system kernel: Code: 0f 0b b4 04 72 bd 34 c0 e9 0a fd ff ff 8d 76 00 8b 54 24 04


>>EIP; c015a980 <iput+310/320>   <=====

>>ebx; d68521c0 <_end+163e9d80/3042bc20>
>>ecx; d68521d0 <_end+163e9d90/3042bc20>
>>edx; d68521d0 <_end+163e9d90/3042bc20>
>>esi; ee48e800 <_end+2e0263c0/3042bc20>
>>esp; effddf04 <_end+2fb75ac4/3042bc20>

Trace; c0157571 <dput+31/190>
Trace; c01579ce <prune_dcache+fe/190>
Trace; c0157da4 <shrink_dcache_memory+24/40>
Trace; c0138e80 <shrink_cache+170/430>
Trace; c01392ea <shrink_caches+4a/60>
Trace; c0139362 <try_to_free_pages_zone+62/100>
Trace; c0139526 <kswapd_balance_pgdat+66/b0>
Trace; c0139598 <kswapd_balance+28/40>
Trace; c01396d8 <kswapd+98/b9>
Trace; c0105000 <_stext+0/0>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c0139640 <kswapd+0/b9>

Code;  c015a980 <iput+310/320>
00000000 <_EIP>:
Code;  c015a980 <iput+310/320>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c015a982 <iput+312/320>
    2:   b4 04                     mov    $0x4,%ah
Code;  c015a984 <iput+314/320>
    4:   72 bd                     jb     ffffffc3 <_EIP+0xffffffc3>
Code;  c015a986 <iput+316/320>
    6:   34 c0                     xor    $0xc0,%al
Code;  c015a988 <iput+318/320>
    8:   e9 0a fd ff ff            jmp    fffffd17 <_EIP+0xfffffd17>
Code;  c015a98d <iput+31d/320>
    d:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c015a990 <force_delete+0/20>
   10:   8b 54 24 04               mov    0x4(%esp),%edx


7 warnings issued.  Results may not be reliable.


b)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.30/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): libafs-2.4.30.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
May  6 04:55:29 system kernel:  <1>Unable to handle kernel paging request at virtual address 32343656
May  6 04:55:29 system kernel: 32343656
May  6 04:55:29 system kernel: *pde = 00000000
May  6 04:55:29 system kernel: Oops: 0000
May  6 04:55:29 system kernel: CPU:    0
May  6 04:55:29 system kernel: EIP:    0010:[<32343656>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May  6 04:55:29 system kernel: EFLAGS: 00010206
May  6 04:55:29 system kernel: eax: 32343656   ebx: d6137de0   ecx: d6137df0   edx: d6137df0
May  6 04:55:29 system kernel: esi: d6137e88   edi: d6137ea4   ebp: 00000003   esp: e5387c18
May  6 04:55:29 system kernel: ds: 0018   es: 0018   ss: 0018
May  6 04:55:29 system kernel: Process rsync (pid: 548, stackpage=e5387000)
May  6 04:55:29 system kernel: Stack: c015a97b d6137de0 c0157571 dc7259a0 ea88c8f8 ea88c8e0 d6137de0 c01579ce
May  6 04:55:30 system kernel:        d6137de0 d36da9c0 c79ebb20 c79ebb30 c79ebb20 f0ac356c c0157d74 0000000d
May  6 04:55:30 system kernel:        c79ebb20 c0157763 c79ebb20 f0ac3438 f0ac3448 f09840ab c79ebb20 f0a734a0
May  6 04:55:30 system kernel: Call Trace:    [<c015a97b>] [<c0157571>] [<c01579ce>] [<c0157d74>] [<c0157763>]
May  6 04:55:30 system kernel:   [<f09840ab>] [<f0987b47>] [<f098a23b>] [<f09b943c>] [<f09bb55e>] [<f09dc900>]
May  6 04:55:30 system kernel:   [<f09bdf19>] [<c014e2ed>] [<c014ea20>] [<c0140d5e>] [<c0141163>] [<c0108ebb>]
May  6 04:55:30 system kernel: Code:  Bad EIP value.


>>EIP; 32343656 Before first symbol   <=====

>>ebx; d6137de0 <_end+15ccf9a0/3042bc20>
>>ecx; d6137df0 <_end+15ccf9b0/3042bc20>
>>edx; d6137df0 <_end+15ccf9b0/3042bc20>
>>esi; d6137e88 <_end+15ccfa48/3042bc20>
>>edi; d6137ea4 <_end+15ccfa64/3042bc20>
>>esp; e5387c18 <_end+24f1f7d8/3042bc20>

Trace; c015a97b <iput+30b/320>
Trace; c0157571 <dput+31/190>
Trace; c01579ce <prune_dcache+fe/190>
Trace; c0157d74 <shrink_dcache_parent+24/30>
Trace; c0157763 <d_invalidate+93/b0>
Trace; f09840ab <[smbfs].data.end+141fc/2f1b1>
Trace; f0987b47 <[smbfs].data.end+17c98/2f1b1>
Trace; f098a23b <[smbfs].data.end+1a38c/2f1b1>
Trace; f09b943c <[libafs-2.4.30.mp]afs_TruncateAllSegments+38c/69b>
Trace; f09bb55e <[libafs-2.4.30.mp]RemoveUserConns+4e/140>
Trace; f09dc900 <[libafs-2.4.30.mp]RXAFS_CallBackRxConnAddr+60/140>
Trace; f09bdf19 <[libafs-2.4.30.mp]afs_NewVCache+5d9/7e0>
Trace; c014e2ed <vfs_create+10d/1e0>
Trace; c014ea20 <open_namei+660/6c0>
Trace; c0140d5e <filp_open+3e/70>
Trace; c0141163 <sys_open+53/c0>
Trace; c0108ebb <system_call+33/38>


7 warnings issued.  Results may not be reliable.

c)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.30/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): libafs-2.4.30.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
y  6 04:55:51 system kernel: Unable to handle kernel paging request at virtual address 32343656
May  6 04:55:51 system kernel: 32343656
May  6 04:55:51 system kernel: *pde = 00000000
May  6 04:55:51 system kernel: Oops: 0000
May  6 04:55:51 system kernel: CPU:    0
May  6 04:55:51 system kernel: EIP:    0010:[<32343656>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May  6 04:55:51 system kernel: EFLAGS: 00010206
May  6 04:55:51 system kernel: eax: 32343656   ebx: d6137be0   ecx: d6137bf0   edx: d6137bf0
May  6 04:55:51 system kernel: esi: d6137c88   edi: d6137ca4   ebp: 00000002   esp: cfd41f18
May  6 04:55:51 system kernel: ds: 0018   es: 0018   ss: 0018
May  6 04:55:51 system kernel: Process avmilter (pid: 1751, stackpage=cfd41000)
May  6 04:55:51 system kernel: Stack: c015a97b d6137be0 00000000 c014cc6a ea88c878 ea88c860 d6137be0 c01579ce
May  6 04:55:51 system kernel:        d6137be0 00000002 cf0059c0 00000003 eca14630 eca145a0 c0157d74 00000002
May  6 04:55:51 system kernel:        cf0059c0 c014f17b cf0059c0 c0179260 c014f2cd cf0059c0 00000003 cf0059c0
May  6 04:55:51 system kernel: Call Trace:    [<c015a97b>] [<c014cc6a>] [<c01579ce>] [<c0157d74>] [<c014f17b>]
May  6 04:55:51 system kernel:   [<c0179260>] [<c014f2cd>] [<c014f59c>] [<c0108ebb>]
May  6 04:55:52 system kernel: Code:  Bad EIP value.


>>EIP; 32343656 Before first symbol   <=====

>>ebx; d6137be0 <_end+15ccf7a0/3042bc20>
>>ecx; d6137bf0 <_end+15ccf7b0/3042bc20>
>>edx; d6137bf0 <_end+15ccf7b0/3042bc20>
>>esi; d6137c88 <_end+15ccf848/3042bc20>
>>edi; d6137ca4 <_end+15ccf864/3042bc20>
>>esp; cfd41f18 <_end+f8d9ad8/3042bc20>

Trace; c015a97b <iput+30b/320>
Trace; c014cc6a <vfs_permission+8a/130>
Trace; c01579ce <prune_dcache+fe/190>
Trace; c0157d74 <shrink_dcache_parent+24/30>
Trace; c014f17b <d_unhash+3b/90>
Trace; c0179260 <ext3_rmdir+0/290>
Trace; c014f2cd <vfs_rmdir+fd/2e0>
Trace; c014f59c <sys_rmdir+ec/110>
Trace; c0108ebb <system_call+33/38>


7 warnings issued.  Results may not be reliable.

d)

ksymoops 2.4.11 on i686 2.4.30.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.30/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): libafs-2.4.30.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
Warning (compare_maps): libafs-2.4.30.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.30.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.30.mp.o entry
May  6 05:47:13 system kernel: Unable to handle kernel paging request at virtual address 32343656
May  6 05:47:13 system kernel: 32343656
May  6 05:47:13 system kernel: *pde = 00000000
May  6 05:47:13 system kernel: Oops: 0000
May  6 05:47:13 system kernel: CPU:    1
May  6 05:47:13 system kernel: EIP:    0010:[<32343656>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
May  6 05:47:13 system kernel: EFLAGS: 00010206
May  6 05:47:13 system kernel: eax: 32343656   ebx: d61379e0   ecx: d61379f0   edx: d61379f0
May  6 05:47:13 system kernel: esi: d6137a88   edi: d6137aa4   ebp: 000240f7   esp: e1141998
May  6 05:47:13 system kernel: ds: 0018   es: 0018   ss: 0018
May  6 05:47:13 system kernel: Process pure-ftpd (pid: 25838, stackpage=e1141000)
May  6 05:47:13 system kernel: Stack: c015a97b d61379e0 efffc198 c9bec160 ea88c7f8 ea88c7e0 d61379e0 c01579ce
May  6 05:47:13 system kernel:        d61379e0 00000003 00000005 c153cf44 c03a3a7c 00000811 c0157da4 000240f7
May  6 05:47:13 system kernel:        c0138e80 00000006 000001d2 ffffffff 000001d2 00000005 00000016 000001d2
May  6 05:47:13 system kernel: Call Trace:    [<c015a97b>] [<c01579ce>] [<c0157da4>] [<c0138e80>] [<c01392ea>]
May  6 05:47:13 system kernel:   [<c0139362>] [<f096c8a2>] [<c0139fed>] [<f09720be>] [<c013a308>] [<c013145a>]
May  6 05:47:13 system kernel:   [<c0131850>] [<c01319a7>] [<c0131850>] [<f09bb55e>] [<f09b943c>] [<f09dc900>]
May  6 05:47:13 system kernel:   [<f0993383>] [<c0299ff5>] [<c010af16>] [<f09dc8d0>] [<f09bece5>] [<c0138662>]
May  6 05:47:13 system kernel:   [<c0130862>] [<c01308c9>] [<c01321ed>] [<c01320d0>] [<c012dafe>] [<c012dcf5>]
May  6 05:47:13 system kernel:   [<c0118708>] [<c0299ff5>] [<c0119831>] [<c01194c5>] [<c010d5b8>] [<c0118360>]
May  6 05:47:13 system kernel:   [<c0108fac>] [<c0335301>] [<c02e0738>] [<c0301a82>] [<c0291a78>] [<c012e83a>]
May  6 05:47:13 system kernel:   [<c0291ce7>] [<c0141a69>] [<c0108ebb>]
May  6 05:47:13 system kernel: Code:  Bad EIP value.


>>EIP; 32343656 Before first symbol   <=====

>>ebx; d61379e0 <_end+15ccf5a0/3042bc20>
>>ecx; d61379f0 <_end+15ccf5b0/3042bc20>
>>edx; d61379f0 <_end+15ccf5b0/3042bc20>
>>esi; d6137a88 <_end+15ccf648/3042bc20>
>>edi; d6137aa4 <_end+15ccf664/3042bc20>
>>esp; e1141998 <_end+20cd9558/3042bc20>

Trace; c015a97b <iput+30b/320>
Trace; c01579ce <prune_dcache+fe/190>
Trace; c0157da4 <shrink_dcache_memory+24/40>
Trace; c0138e80 <shrink_cache+170/430>
Trace; c01392ea <shrink_caches+4a/60>
Trace; c0139362 <try_to_free_pages_zone+62/100>
Trace; f096c8a2 <[smbfs]smb_revalidate_inode+82/a0>
Trace; c0139fed <balance_classzone+4d/1f0>
Trace; f09720be <[smbfs].data.end+220f/2f1b1>
Trace; c013a308 <__alloc_pages+178/280>
Trace; c013145a <do_generic_file_read+3ca/490>
Trace; c0131850 <file_read_actor+0/a0>
Trace; c01319a7 <generic_file_read+b7/1b0>
Trace; c0131850 <file_read_actor+0/a0>
Trace; f09bb55e <[libafs-2.4.30.mp]RemoveUserConns+4e/140>
Trace; f09b943c <[libafs-2.4.30.mp]afs_TruncateAllSegments+38c/69b>
Trace; f09dc900 <[libafs-2.4.30.mp]RXAFS_CallBackRxConnAddr+60/140>
Trace; f0993383 <[smbfs].data.end+234d4/2f1b1>
Trace; c0299ff5 <net_rx_action+d5/180>
Trace; c010af16 <do_IRQ+e6/f0>
Trace; f09dc8d0 <[libafs-2.4.30.mp]RXAFS_CallBackRxConnAddr+30/140>
Trace; f09bece5 <[libafs-2.4.30.mp]afs_SimpleVStat+85/1c0>
Trace; c0138662 <lru_cache_add+72/80>
Trace; c0130862 <page_cache_read+c2/f0>
Trace; c01308c9 <read_cluster_nonblocking+39/50>
Trace; c01321ed <filemap_nopage+11d/230>
Trace; c01320d0 <filemap_nopage+0/230>
Trace; c012dafe <do_no_page+8e/210>
Trace; c012dcf5 <handle_mm_fault+75/100>
Trace; c0118708 <do_page_fault+3a8/555>
Trace; c0299ff5 <net_rx_action+d5/180>
Trace; c0119831 <schedule+2c1/550>
Trace; c01194c5 <schedule_timeout+a5/b0>
Trace; c010d5b8 <call_do_IRQ+5/d>
Trace; c0118360 <do_page_fault+0/555>
Trace; c0108fac <error_code+34/3c>
Trace; c0335301 <csum_partial_copy_generic+3d/fc>
Trace; c02e0738 <tcp_sendmsg+998/1270>
Trace; c0301a82 <inet_sendmsg+42/50>
Trace; c0291a78 <sock_sendmsg+68/b0>
Trace; c012e83a <do_mmap_pgoff+36a/5d0>
Trace; c0291ce7 <sock_write+97/c0>
Trace; c0141a69 <sys_write+99/110>
Trace; c0108ebb <system_call+33/38>


7 warnings issued.  Results may not be reliable.


Best regards ,


--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=============================================================================
