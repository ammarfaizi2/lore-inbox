Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbTCZT3L>; Wed, 26 Mar 2003 14:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbTCZT3L>; Wed, 26 Mar 2003 14:29:11 -0500
Received: from mailer.jlab.org ([129.57.35.124]:47263 "EHLO mailer.jlab.org")
	by vger.kernel.org with ESMTP id <S261966AbTCZT3A>;
	Wed, 26 Mar 2003 14:29:00 -0500
From: Kelvin Edwards <kelvin@jlab.org>
Date: Wed, 26 Mar 2003 14:40:07 -0500 (EST)
Message-Id: <200303261940.h2QJe7nU004763@ccs2.jlab.org>
To: linux-kernel@vger.kernel.org
Subject: Ooops in 2.4.18 through 2.4.20, now kswapd is defunct
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a variety of systems running kernels ranging from
2.4.18 through 2.4.20 and am seeing fairly frequent 
kernel oopsen.  After the oops, kswapd is defunct, however
the systems are still running (they are dual CPU systems).
Has anyone seen this before, and is there a patch to fix
it yet ?  Thanks.

Kelvin Edwards
System Admin
Jefferson Lab

Here's some Ooops run through ksymoops:

Mar 21 15:20:00 MachX kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Mar 21 15:20:00 MachX kernel: c0152b51
Mar 21 15:20:00 MachX kernel: *pde = 00000000
Mar 21 15:20:00 MachX kernel: Oops: 0000
Mar 21 15:20:00 MachX kernel: CPU:    4
Mar 21 15:20:00 MachX kernel: EIP:    0010:[destroy_inode+33/80]    Not tainted
Mar 21 15:20:00 MachX kernel: EIP:    0010:[<c0152b51>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 21 15:20:00 MachX kernel: EFLAGS: 00010246
Mar 21 15:20:00 MachX kernel: eax: 00000000   ebx: e3c999c0   ecx: 00000000
edx: e3c999c0
Mar 21 15:20:00 MachX kernel: esi: e3c999c0   edi: 00000001   ebp: 00000a55
esp: f7a8fefc
Mar 21 15:20:00 MachX kernel: ds: 0018   es: 0018   ss: 0018
Mar 21 15:20:00 MachX kernel: Process kswapd (pid: 11, stackpage=f7a8f000)
Mar 21 15:20:00 MachX kernel: Stack: e3c999c0 c0154335 e3c999c0 d940e7a0 c034c700 00150c00 f8a09e9a ca60c738
Mar 21 15:20:00 MachX kernel:        ca60c720 e3c999c0 c0151a31 e3c999c0 e3c999c0 c0135e63 d7f4e400 f7a8e000
Mar 21 15:20:00 MachX kernel:        ffffffff 000001d0 c02e6308 f7a8e000 00000003 0000001f 000001d0 00000006
Mar 21 15:20:00 MachX kernel: Call Trace:    [iput+629/640] [appletalk:__insmod_appletalk_S.bss_L268+425722/117747542] [prune_dcache+225/368] [shrink_cache+819/976] [shrink_dcache_memory+32/48]
Mar 21 15:20:00 MachX kernel: Call Trace:    [<c0154335>] [<f8a09e9a>] [<c0151a31>] [<c0135e63>] [<c0151de0>]
Mar 21 15:20:00 MachX kernel:   [<c0136087>] [<c01360ec>] [<c01361ff>] [<c0136276>] [<c01363b1>] [<c0136310>]
Mar 21 15:20:00 MachX kernel:   [<c0105000>] [<c0107296>] [<c0136310>]
Mar 21 15:20:00 MachX kernel: Code: 8b 40 04 85 c0 74 08 53 ff d0 59 eb 11 89
f6 53 8b 15 b4 ae

>>EIP; c0152b51 <destroy_inode+21/50>   <=====
Trace; c0154335 <iput+275/280>
Trace; f8a09e9a <[nfs]nfs_dentry_iput+5a/80>
Trace; c0151a31 <prune_dcache+e1/170>
Trace; c0135e63 <shrink_cache+333/3d0>
Trace; c0151de0 <shrink_dcache_memory+20/30>
Trace; c0136087 <shrink_caches+67/90>
Trace; c01360ec <try_to_free_pages_zone+3c/60>
Trace; c01361ff <kswapd_balance_pgdat+4f/a0>
Trace; c0136276 <kswapd_balance+26/40>
Trace; c01363b1 <kswapd+a1/ba>
Trace; c0136310 <kswapd+0/ba>
Trace; c0105000 <_stext+0/0>
Trace; c0107296 <kernel_thread+26/30>
Trace; c0136310 <kswapd+0/ba>
Code;  c0152b51 <destroy_inode+21/50>
00000000 <_EIP>:
Code;  c0152b51 <destroy_inode+21/50>   <=====
   0:   8b 40 04                  mov    0x4(%eax),%eax   <=====
Code;  c0152b54 <destroy_inode+24/50>
   3:   85 c0                     test   %eax,%eax
Code;  c0152b56 <destroy_inode+26/50>
   5:   74 08                     je     f <_EIP+0xf> c0152b60 <destroy_inode+30/50>
Code;  c0152b58 <destroy_inode+28/50>
   7:   53                        push   %ebx
Code;  c0152b59 <destroy_inode+29/50>
   8:   ff d0                     call   *%eax
Code;  c0152b5b <destroy_inode+2b/50>
   a:   59                        pop    %ecx
Code;  c0152b5c <destroy_inode+2c/50>
   b:   eb 11                     jmp    1e <_EIP+0x1e> c0152b6f <destroy_inode+3f/50>
Code;  c0152b5e <destroy_inode+2e/50>
   d:   89 f6                     mov    %esi,%esi
Code;  c0152b60 <destroy_inode+30/50>
   f:   53                        push   %ebx
Code;  c0152b61 <destroy_inode+31/50>
  10:   8b 15 b4 ae 00 00         mov    0xaeb4,%edx

Mar 21 15:27:49 MachX kernel: Unable to handle kernel paging request at virtual address 41203999
Mar 21 15:27:49 MachX kernel: c01540fb
Mar 21 15:27:49 MachX kernel: *pde = 00000000
Mar 21 15:27:49 MachX kernel: Oops: 0000
Mar 21 15:27:49 MachX kernel: CPU:    3
Mar 21 15:27:49 MachX kernel: EIP:    0010:[iput+59/640]    Not tainted
Mar 21 15:27:49 MachX kernel: EIP:    0010:[<c01540fb>]    Not tainted
Mar 21 15:27:49 MachX kernel: EFLAGS: 00010206
Mar 21 15:27:49 MachX kernel: eax: 41203981   ebx: d12d75c0   ecx: d12d75d0
edx: d12d75c0
Mar 21 15:27:49 MachX kernel: esi: e0d52000   edi: 41203981   ebp: 00000994
esp: c0543dc0
Mar 21 15:27:49 MachX kernel: ds: 0018   es: 0018   ss: 0018
Mar 21 15:27:49 MachX kernel: Process cct0_nt (pid: 19045, stackpage=c0543000)Mar 21 15:27:49 MachX kernel: Stack: c0151637 d88305a0 c02e6320 f8a09e9a c9d8a4f8 c9d8a4e0 d12d75c0 c0151a31
Mar 21 15:27:49 MachX kernel:        d12d75c0 d12d75c0 c0135e63 f8a11c57 c0542000 ffffffff 000001d2 c02e6308
Mar 21 15:27:49 MachX kernel:        c0542000 00000000 00000016 000001d2 00000006 00000006 c0151de0 000009c1
Mar 21 15:27:49 MachX kernel: Call Trace:    [dput+71/352] [appletalk:__insmod_appletalk_S.bss_L268+425722/117747542] [prune_dcache+225/368] [shrink_cache+819/976] [appletalk:__insmod_appletalk_S.bss_L268+457911/117715353]
Mar 21 15:27:49 MachX kernel: Call Trace:    [<c0151637>] [<f8a09e9a>] [<c0151a31>] [<c0135e63>] [<f8a11c57>]
Mar 21 15:27:49 MachX kernel:   [<c0151de0>] [<c0136087>] [<c01360ec>] [<c0136be2>] [<c0136e9b>] [<c012e499>]
Mar 21 15:27:49 MachX kernel:   [<c012eb75>] [<c012ede8>] [<c01d6079>] [<c012f3dc>] [<c012f270>] [<f8a0b141>]
Mar 21 15:27:49 MachX kernel:   [<c013dbf6>] [<c013d850>] [<c013da3f>] [<c0108c53>]
Mar 21 15:27:49 MachX kernel: Code: 8b 47 18 85 c0 74 04 53 ff d0 58 68 1c 71
2e c0 8d 43 2c 50

>>EIP; c01540fb <iput+3b/280>   <=====
Trace; c0151637 <dput+47/160>
Trace; f8a09e9a <[nfs]nfs_dentry_iput+5a/80>
Trace; c0151a31 <prune_dcache+e1/170>
Trace; c0135e63 <shrink_cache+333/3d0>
Trace; f8a11c57 <[nfs]nfs_scan_commit+27/70>
Trace; c0151de0 <shrink_dcache_memory+20/30>
Trace; c0136087 <shrink_caches+67/90>
Trace; c01360ec <try_to_free_pages_zone+3c/60>
Trace; c0136be2 <balance_classzone+62/200>
Trace; c0136e9b <__alloc_pages+11b/170>
Trace; c012e499 <page_cache_read+79/d0>
Trace; c012eb75 <generic_file_readahead+f5/130>
Trace; c012ede8 <do_generic_file_read+1f8/460>
Trace; c01d6079 <netif_receive_skb+179/1b0>
Trace; c012f3dc <generic_file_read+7c/110>
Trace; c012f270 <file_read_actor+0/f0>
Trace; f8a0b141 <[nfs]nfs_file_read+91/a0>
Trace; c013dbf6 <sys_read+96/110>
Trace; c013d850 <generic_file_llseek+0/b0>
Trace; c013da3f <sys_lseek+af/c0>
Trace; c0108c53 <system_call+33/38>
Code;  c01540fb <iput+3b/280>
00000000 <_EIP>:
Code;  c01540fb <iput+3b/280>   <=====
   0:   8b 47 18                  mov    0x18(%edi),%eax   <=====
Code;  c01540fe <iput+3e/280>
   3:   85 c0                     test   %eax,%eax
Code;  c0154100 <iput+40/280>
   5:   74 04                     je     b <_EIP+0xb> c0154106 <iput+46/280>
Code;  c0154102 <iput+42/280>
   7:   53                        push   %ebx
Code;  c0154103 <iput+43/280>
   8:   ff d0                     call   *%eax
Code;  c0154105 <iput+45/280>
   a:   58                        pop    %eax
Code;  c0154106 <iput+46/280>
   b:   68 1c 71 2e c0            push   $0xc02e711c
Code;  c015410b <iput+4b/280>
  10:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  c015410e <iput+4e/280>
  13:   50                        push   %eax


