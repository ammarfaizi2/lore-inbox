Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292291AbSB0Jpl>; Wed, 27 Feb 2002 04:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSB0Jp1>; Wed, 27 Feb 2002 04:45:27 -0500
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:25100 "EHLO
	mail.ludost.net") by vger.kernel.org with ESMTP id <S292291AbSB0JpD>;
	Wed, 27 Feb 2002 04:45:03 -0500
Date: Wed, 27 Feb 2002 11:45:00 +0200 (EET)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in 2.2.20
Message-ID: <Pine.LNX.4.33.0202271139260.25189-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
I have a machine that runs debian woody, appended .config, dmesg and the
oops log. Last night i was editing bind9's config,and when
ran rndc reload, the machine oopsed, then my ssh connection died, and
shortly after, the machine went totally down ( no ping ). I've ran the
captured oopses through ksymoops and here's the resuls:

ksymoops 2.4.3 on i586 2.2.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.20/ (default)
     -m /boot/System.map-2.2.20 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Feb 26 21:47:48 fsa-bg kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Feb 26 21:47:48 fsa-bg kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Feb 26 21:47:48 fsa-bg kernel: *pde = 00000000
Feb 26 21:47:48 fsa-bg kernel: Oops: 0002
Feb 26 21:47:48 fsa-bg kernel: CPU:    0
Feb 26 21:47:48 fsa-bg kernel: EIP:    0010:[<c0123aca>]
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 26 21:47:48 fsa-bg kernel: EFLAGS: 00010002
Feb 26 21:47:48 fsa-bg kernel: eax: c024ace8   ebx: 00000581   ecx: c0221980   edx: 00000000
Feb 26 21:47:48 fsa-bg kernel: esi: 000002c0   edi: ffffffff   ebp: 00000000   esp: c232fdac
Feb 26 21:47:48 fsa-bg kernel: ds: 0018   es: 0018   ss: 0018
Feb 26 21:47:48 fsa-bg kernel: Process bind9 (pid: 5735, process nr: 10, stackpage=c232f000)
Feb 26 21:47:48 fsa-bg kernel: Stack: c22d2084 c22cb2e4 c1e9c010 c2495570 00000020 00000206 c232fe30 c0a96ad0
Feb 26 21:47:48 fsa-bg kernel:        c25fbf60 c012456d 004b2000 00000001 00000001 00000001 c1e9c010 080af000
Feb 26 21:47:48 fsa-bg kernel:        c25de2e0 c011c181 c0581000 c0a96ad0 04000001 c0127954 c223b280 080b2000
Feb 26 21:47:48 fsa-bg kernel: Call Trace: [<c012456d>] [<c011c181>] [<c0127954>] [<c011dd99>] [<c0114054>] [<c011404b>] [<c011400c>]
Feb 26 21:47:48 fsa-bg kernel:        [<c0118ede>] [<c0118ed5>] [<c0109fb7>] [<c010fb10>] [<c0110bb9>] [<c011ce6a>] [<c0110dc9>] [<c010afbe>]
Feb 26 21:47:48 fsa-bg kernel:        [<c010fc95>] [<c010fb10>] [<c010b374>] [<c010a1d5>] [<c010a100>]
Feb 26 21:47:48 fsa-bg kernel: Code: 89 42 04 89 10 01 ff 83 c1 10 d1 ee 21 fb 81 ff 00 fe ff ff

>>EIP; c0123aca <__free_pages+da/168>   <=====
Trace; c012456c <free_page_and_swap_cache+64/6c>
Trace; c011c180 <zap_page_range+14c/1c0>
Trace; c0127954 <fput+20/54>
Trace; c011dd98 <exit_mmap+b8/120>
Trace; c0114054 <mmput+24/48>
Trace; c011404a <mmput+1a/48>
Trace; c011400c <mm_release+10/34>
Trace; c0118ede <do_exit+da/2a4>
Trace; c0118ed4 <do_exit+d0/2a4>
Trace; c0109fb6 <do_signal+1fa/274>
Trace; c010fb10 <do_page_fault+0/3e0>
Trace; c0110bb8 <force_sig_info+80/90>
Trace; c011ce6a <handle_mm_fault+12a/158>
Trace; c0110dc8 <force_sig+14/1c>
Trace; c010afbe <do_8259A_IRQ+8e/98>
Trace; c010fc94 <do_page_fault+184/3e0>
Trace; c010fb10 <do_page_fault+0/3e0>
Trace; c010b374 <do_IRQ+40/44>
Trace; c010a1d4 <error_code+34/40>
Trace; c010a100 <signal_return+14/18>
Code;  c0123aca <__free_pages+da/168>
00000000 <_EIP>:
Code;  c0123aca <__free_pages+da/168>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c0123acc <__free_pages+dc/168>
   3:   89 10                     mov    %edx,(%eax)
Code;  c0123ace <__free_pages+de/168>
   5:   01 ff                     add    %edi,%edi
Code;  c0123ad0 <__free_pages+e0/168>
   7:   83 c1 10                  add    $0x10,%ecx
Code;  c0123ad4 <__free_pages+e4/168>
   a:   d1 ee                     shr    %esi
Code;  c0123ad6 <__free_pages+e6/168>
   c:   21 fb                     and    %edi,%ebx
Code;  c0123ad8 <__free_pages+e8/168>
   e:   81 ff 00 fe ff ff         cmp    $0xfffffe00,%edi

Feb 26 21:47:59 fsa-bg kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000020
Feb 26 21:47:59 fsa-bg kernel: current->tss.cr3 = 0063c000, %%cr3 = 0063c000
Feb 26 21:47:59 fsa-bg kernel: *pde = 00000000
Feb 26 21:47:59 fsa-bg kernel: Oops: 0000
Feb 26 21:47:59 fsa-bg kernel: CPU:    0
Feb 26 21:47:59 fsa-bg kernel: EIP:    0010:[<c012250a>]
Feb 26 21:47:59 fsa-bg kernel: EFLAGS: 00010092
Feb 26 21:47:59 fsa-bg kernel: eax: 00000000   ebx: c1bf0410   ecx: c1bf0f90   edx: 00000020
Feb 26 21:47:59 fsa-bg kernel: esi: c26ff620   edi: 00000282   ebp: 00000008   esp: c232fe9c
Feb 26 21:47:59 fsa-bg kernel: ds: 0018   es: 0018   ss: 0018
Feb 26 21:47:59 fsa-bg kernel: Process sshd (pid: 5736, process nr: 10, stackpage=c232f000)
Feb 26 21:47:59 fsa-bg kernel: Stack: c1bf0410 bffff3ec c1bf0410 c1ec6000 c1bf0410 bffff3ec c1ec60a0 bffff37c
Feb 26 21:47:59 fsa-bg kernel:        fffffffe c0132a10 c26ff620 c1bf0410 00000000 bffff3ec c1e9c1f0 c1ec6000
Feb 26 21:47:59 fsa-bg kernel:        0000006e 00000002 00000002 00000003 40235e60 c01267c2 c1bf0410 c1e9c1f0
Feb 26 21:47:59 fsa-bg kernel: Call Trace: [<c0132a10>] [<c01267c2>] [<c0127954>] [<c012794b>] [<c012682a>] [<c016286e>] [<c0126899>]
Feb 26 21:47:59 fsa-bg kernel:        [<c010a1d5>] [<c010a0b8>]
Feb 26 21:47:59 fsa-bg kernel: Code: 39 1a 0f 84 2e ff ff ff 57 9d 83 c4 fc 56 53 68 e0 ed 1c c0

>>EIP; c012250a <kmem_cache_free+fe/164>   <=====
Trace; c0132a10 <dput+f0/158>
Trace; c01267c2 <__fput+4a/54>
Trace; c0127954 <fput+20/54>
Trace; c012794a <fput+16/54>
Trace; c012682a <filp_close+5e/6c>
Trace; c016286e <sys_socketcall+92/200>
Trace; c0126898 <sys_close+60/70>
Trace; c010a1d4 <error_code+34/40>
Trace; c010a0b8 <system_call+34/38>
Code;  c012250a <kmem_cache_free+fe/164>
00000000 <_EIP>:
Code;  c012250a <kmem_cache_free+fe/164>   <=====
   0:   39 1a                     cmp    %ebx,(%edx)   <=====
Code;  c012250c <kmem_cache_free+100/164>
   2:   0f 84 2e ff ff ff         je     ffffff36 <_EIP+0xffffff36> c0122440 <kmem_cache_free+34/164>
Code;  c0122512 <kmem_cache_free+106/164>
   8:   57                        push   %edi
Code;  c0122512 <kmem_cache_free+106/164>
   9:   9d                        popf
Code;  c0122514 <kmem_cache_free+108/164>
   a:   83 c4 fc                  add    $0xfffffffc,%esp
Code;  c0122516 <kmem_cache_free+10a/164>
   d:   56                        push   %esi
Code;  c0122518 <kmem_cache_free+10c/164>
   e:   53                        push   %ebx
Code;  c0122518 <kmem_cache_free+10c/164>
   f:   68 e0 ed 1c c0            push   $0xc01cede0

Feb 26 21:47:59 fsa-bg kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb 26 21:47:59 fsa-bg kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Feb 26 21:47:59 fsa-bg kernel: *pde = 00000000
Feb 26 21:47:59 fsa-bg kernel: Oops: 0002
Feb 26 21:47:59 fsa-bg kernel: CPU:    0
Feb 26 21:47:59 fsa-bg kernel: EIP:    0010:[<c0123acd>]
Feb 26 21:47:59 fsa-bg kernel: EFLAGS: 00010002
Feb 26 21:47:59 fsa-bg kernel: eax: 00000000   ebx: 000020fa   ecx: c0221980   edx: c028c800
Feb 26 21:47:59 fsa-bg kernel: esi: 0000107d   edi: ffffffff   ebp: 00000000   esp: c232fc90
Feb 26 21:47:59 fsa-bg kernel: ds: 0018   es: 0018   ss: 0018
Feb 26 21:47:59 fsa-bg kernel: Process sshd (pid: 5736, process nr: 10, stackpage=c232f000)
Feb 26 21:47:59 fsa-bg kernel: Stack: c063c084 c2425250 c029cbcc 00000000 00000019 00000206 c029cbcc c0239760
Feb 26 21:47:59 fsa-bg kernel:        00000000 c012456d 00481000 00000000 0000000e 00000000 00481000 00000008
Feb 26 21:47:59 fsa-bg kernel:        c0239760 c011c181 c20fa000 ffffffff 00000019 c011c195 c223b500 08081000
Feb 26 21:47:59 fsa-bg kernel: Call Trace: [<c012456d>] [<c011c181>] [<c011c195>] [<c011dd99>] [<c0114054>] [<c011404b>] [<c011400c>]
Feb 26 21:47:59 fsa-bg kernel:        [<c0118ede>] [<c0118ed5>] [<c010a590>] [<c01cd2ee>] [<c01cd2a0>] [<c010fde7>] [<c01cd2ee>] [<c010fb10>]
Feb 26 21:47:59 fsa-bg kernel:        [<c0185af3>] [<c0185f24>] [<c010a1d5>] [<c012250a>] [<c0132a10>] [<c01267c2>] [<c0127954>] [<c012794b>]
Feb 26 21:47:59 fsa-bg kernel:        [<c012682a>] [<c016286e>] [<c0126899>] [<c010a1d5>] [<c010a0b8>]
Feb 26 21:47:59 fsa-bg kernel: Code: 89 10 01 ff 83 c1 10 d1 ee 21 fb 81 ff 00 fe ff ff 74 0c 8b

>>EIP; c0123acc <__free_pages+dc/168>   <=====
Trace; c012456c <free_page_and_swap_cache+64/6c>
Trace; c011c180 <zap_page_range+14c/1c0>
Trace; c011c194 <zap_page_range+160/1c0>
Trace; c011dd98 <exit_mmap+b8/120>
Trace; c0114054 <mmput+24/48>
Trace; c011404a <mmput+1a/48>
Trace; c011400c <mm_release+10/34>
Trace; c0118ede <do_exit+da/2a4>
Trace; c0118ed4 <do_exit+d0/2a4>
Trace; c010a590 <die_if_no_fixup+0/4c>
Trace; c01cd2ee <error_table+24ee/2660>
Trace; c01cd2a0 <error_table+24a0/2660>
Trace; c010fde6 <do_page_fault+2d6/3e0>
Trace; c01cd2ee <error_table+24ee/2660>
Trace; c010fb10 <do_page_fault+0/3e0>
Trace; c0185af2 <unix_release_sock+96/b0>
Trace; c0185f24 <unix_find_other+2c/9c>
Trace; c010a1d4 <error_code+34/40>
Trace; c012250a <kmem_cache_free+fe/164>
Trace; c0132a10 <dput+f0/158>
Trace; c01267c2 <__fput+4a/54>
Trace; c0127954 <fput+20/54>
Trace; c012794a <fput+16/54>
Trace; c012682a <filp_close+5e/6c>
Trace; c016286e <sys_socketcall+92/200>
Trace; c0126898 <sys_close+60/70>
Trace; c010a1d4 <error_code+34/40>
Trace; c010a0b8 <system_call+34/38>
Code;  c0123acc <__free_pages+dc/168>
00000000 <_EIP>:
Code;  c0123acc <__free_pages+dc/168>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c0123ace <__free_pages+de/168>
   2:   01 ff                     add    %edi,%edi
Code;  c0123ad0 <__free_pages+e0/168>
   4:   83 c1 10                  add    $0x10,%ecx
Code;  c0123ad2 <__free_pages+e2/168>
   7:   d1 ee                     shr    %esi
Code;  c0123ad4 <__free_pages+e4/168>
   9:   21 fb                     and    %edi,%ebx
Code;  c0123ad6 <__free_pages+e6/168>
   b:   81 ff 00 fe ff ff         cmp    $0xfffffe00,%edi
Code;  c0123adc <__free_pages+ec/168>
  11:   74 0c                     je     1f <_EIP+0x1f> c0123aea <__free_pages+fa/168>
Code;  c0123ade <__free_pages+ee/168>
  13:   8b 00                     mov    (%eax),%eax

Feb 26 21:47:59 fsa-bg kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000044
Feb 26 21:47:59 fsa-bg kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Feb 26 21:47:59 fsa-bg kernel: *pde = 00000000
Feb 26 21:47:59 fsa-bg kernel: Oops: 0000
Feb 26 21:47:59 fsa-bg kernel: CPU:    0
Feb 26 21:47:59 fsa-bg kernel: EIP:    0010:[<c012250a>]
Feb 26 21:47:59 fsa-bg kernel: EFLAGS: 00010017
Feb 26 21:47:59 fsa-bg kernel: eax: 00000000   ebx: c1f718a0   ecx: c1f71fa0   edx: 00000044
Feb 26 21:47:59 fsa-bg kernel: esi: c26ff620   edi: 00000286   ebp: 00000011   esp: c232faa4
Feb 26 21:47:59 fsa-bg kernel: ds: 0018   es: 0018   ss: 0018
Feb 26 21:47:59 fsa-bg kernel: Process sshd (pid: 5736, process nr: 10, stackpage=c232f000)
Feb 26 21:47:59 fsa-bg kernel: Stack: c1f718a0 00000001 c1f718a0 c242a188 c1f718a0 00000001 00000000 00000000
Feb 26 21:47:59 fsa-bg kernel:        c0239760 c0132a10 c26ff620 c1f718a0 00000000 00000001 c1e9c010 c242a188
Feb 26 21:47:59 fsa-bg kernel:        00000019 c01a896c 0000000a c0239760 00000000 c01267c2 c1f718a0 c1e9c010
Feb 26 21:47:59 fsa-bg kernel: Call Trace: [<c0132a10>] [<c01a896c>] [<c01267c2>] [<c0127954>] [<c012794b>] [<c0115335>] [<c011536d>]
Feb 26 21:47:59 fsa-bg kernel:        [<c012682a>] [<c0118f50>] [<c010fb10>] [<c0118e7c>] [<c010fb10>] [<c010a590>] [<c01cd2ee>] [<c01cd2a0>]
Feb 26 21:47:59 fsa-bg kernel:        [<c010fde7>] [<c01cd2ee>] [<c010fb10>] [<c0163cac>] [<c010a1d5>] [<c0123acd>] [<c012456d>] [<c011c181>]
Feb 26 21:47:59 fsa-bg kernel:        [<c011c195>] [<c011dd99>] [<c0114054>] [<c011404b>] [<c011400c>] [<c0118ede>] [<c0118ed5>] [<c010a590>]
Feb 26 21:47:59 fsa-bg kernel:        [<c01cd2ee>] [<c01cd2a0>] [<c010fde7>] [<c01cd2ee>] [<c010fb10>] [<c0185af3>] [<c0185f24>] [<c010a1d5>]
Feb 26 21:47:59 fsa-bg kernel:        [<c012250a>] [<c0132a10>] [<c01267c2>] [<c0127954>] [<c012794b>] [<c012682a>] [<c016286e>] [<c0126899>]
Feb 26 21:47:59 fsa-bg kernel:        [<c010a1d5>] [<c010a0b8>]
Feb 26 21:47:59 fsa-bg kernel: Code: 39 1a 0f 84 2e ff ff ff 57 9d 83 c4 fc 56 53 68 e0 ed 1c c0

>>EIP; c012250a <kmem_cache_free+fe/164>   <=====
Trace; c0132a10 <dput+f0/158>
Trace; c01a896c <set_cursor+4c/94>
Trace; c01267c2 <__fput+4a/54>
Trace; c0127954 <fput+20/54>
Trace; c012794a <fput+16/54>
Trace; c0115334 <printk+120/168>
Trace; c011536c <printk+158/168>
Trace; c012682a <filp_close+5e/6c>
Trace; c0118f50 <do_exit+14c/2a4>
Trace; c010fb10 <do_page_fault+0/3e0>
Trace; c0118e7c <do_exit+78/2a4>
Trace; c010fb10 <do_page_fault+0/3e0>
Trace; c010a590 <die_if_no_fixup+0/4c>
Trace; c01cd2ee <error_table+24ee/2660>
Trace; c01cd2a0 <error_table+24a0/2660>
Trace; c010fde6 <do_page_fault+2d6/3e0>
Trace; c01cd2ee <error_table+24ee/2660>
Trace; c010fb10 <do_page_fault+0/3e0>
Trace; c0163cac <__kfree_skb+ac/b8>
Trace; c010a1d4 <error_code+34/40>
Trace; c0123acc <__free_pages+dc/168>
Trace; c012456c <free_page_and_swap_cache+64/6c>
Trace; c011c180 <zap_page_range+14c/1c0>
Trace; c011c194 <zap_page_range+160/1c0>
Trace; c011dd98 <exit_mmap+b8/120>
Trace; c0114054 <mmput+24/48>
Trace; c011404a <mmput+1a/48>
Trace; c011400c <mm_release+10/34>
Trace; c0118ede <do_exit+da/2a4>
Trace; c0118ed4 <do_exit+d0/2a4>
Trace; c010a590 <die_if_no_fixup+0/4c>
Trace; c01cd2ee <error_table+24ee/2660>
Trace; c01cd2a0 <error_table+24a0/2660>
Trace; c010fde6 <do_page_fault+2d6/3e0>
Trace; c01cd2ee <error_table+24ee/2660>
Trace; c010fb10 <do_page_fault+0/3e0>
Trace; c0185af2 <unix_release_sock+96/b0>
Trace; c0185f24 <unix_find_other+2c/9c>
Trace; c010a1d4 <error_code+34/40>
Trace; c012250a <kmem_cache_free+fe/164>
Trace; c0132a10 <dput+f0/158>
Trace; c01267c2 <__fput+4a/54>
Trace; c0127954 <fput+20/54>
Trace; c012794a <fput+16/54>
Trace; c012682a <filp_close+5e/6c>
Trace; c016286e <sys_socketcall+92/200>
Trace; c0126898 <sys_close+60/70>
Trace; c010a1d4 <error_code+34/40>
Trace; c010a0b8 <system_call+34/38>
Code;  c012250a <kmem_cache_free+fe/164>
00000000 <_EIP>:
Code;  c012250a <kmem_cache_free+fe/164>   <=====
   0:   39 1a                     cmp    %ebx,(%edx)   <=====
Code;  c012250c <kmem_cache_free+100/164>
   2:   0f 84 2e ff ff ff         je     ffffff36 <_EIP+0xffffff36> c0122440 <kmem_cache_free+34/164>
Code;  c0122512 <kmem_cache_free+106/164>
   8:   57                        push   %edi
Code;  c0122512 <kmem_cache_free+106/164>
   9:   9d                        popf
Code;  c0122514 <kmem_cache_free+108/164>
   a:   83 c4 fc                  add    $0xfffffffc,%esp
Code;  c0122516 <kmem_cache_free+10a/164>
   d:   56                        push   %esi
Code;  c0122518 <kmem_cache_free+10c/164>
   e:   53                        push   %ebx
Code;  c0122518 <kmem_cache_free+10c/164>
   f:   68 e0 ed 1c c0            push   $0xc01cede0

Feb 26 21:48:00 fsa-bg kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000020
Feb 26 21:48:00 fsa-bg kernel: current->tss.cr3 = 00584000, %%cr3 = 00584000
Feb 26 21:48:00 fsa-bg kernel: *pde = 00000000
Feb 26 21:48:00 fsa-bg kernel: Oops: 0000
Feb 26 21:48:00 fsa-bg kernel: CPU:    0
Feb 26 21:48:00 fsa-bg kernel: EIP:    0010:[<c012250a>]
Feb 26 21:48:00 fsa-bg kernel: EFLAGS: 00010092
Feb 26 21:48:00 fsa-bg kernel: eax: 00000000   ebx: c1a6f440   ecx: c1a6ffc0   edx: 00000020
Feb 26 21:48:00 fsa-bg kernel: esi: c26ff620   edi: 00000282   ebp: 00000008   esp: c232fe9c
Feb 26 21:48:00 fsa-bg kernel: ds: 0018   es: 0018   ss: 0018
Feb 26 21:48:00 fsa-bg kernel: Process sshd (pid: 5737, process nr: 10, stackpage=c232f000)
Feb 26 21:48:00 fsa-bg kernel: Stack: c1a6f440 bffff55c c1a6f440 c1a15b90 c1a6f440 bffff55c c25f36e0 bffff37c
Feb 26 21:48:00 fsa-bg kernel:        fffffffe c0132a10 c26ff620 c1a6f440 00000000 bffff55c c1e9cc10 c1a15b90
Feb 26 21:48:00 fsa-bg kernel:        c0288548 c1f55000 c232e000 01f55067 01f55065 c01267c2 c1a6f440 c1e9cc10
Feb 26 21:48:00 fsa-bg kernel: Call Trace: [<c0132a10>] [<c01267c2>] [<c011c8ce>] [<c0127954>] [<c012794b>] [<c011ce6a>] [<c012682a>]
Feb 26 21:48:00 fsa-bg kernel:        [<c0126899>] [<c010a1d5>] [<c010a0b8>]
Feb 26 21:48:00 fsa-bg kernel: Code: 39 1a 0f 84 2e ff ff ff 57 9d 83 c4 fc 56 53 68 e0 ed 1c c0

>>EIP; c012250a <kmem_cache_free+fe/164>   <=====
Trace; c0132a10 <dput+f0/158>
Trace; c01267c2 <__fput+4a/54>
Trace; c011c8ce <do_wp_page+d6/198>
Trace; c0127954 <fput+20/54>
Trace; c012794a <fput+16/54>
Trace; c011ce6a <handle_mm_fault+12a/158>
Trace; c012682a <filp_close+5e/6c>
Trace; c0126898 <sys_close+60/70>
Trace; c010a1d4 <error_code+34/40>
Trace; c010a0b8 <system_call+34/38>
Code;  c012250a <kmem_cache_free+fe/164>
00000000 <_EIP>:
Code;  c012250a <kmem_cache_free+fe/164>   <=====
   0:   39 1a                     cmp    %ebx,(%edx)   <=====
Code;  c012250c <kmem_cache_free+100/164>
   2:   0f 84 2e ff ff ff         je     ffffff36 <_EIP+0xffffff36> c0122440 <kmem_cache_free+34/164>
Code;  c0122512 <kmem_cache_free+106/164>
   8:   57                        push   %edi
Code;  c0122512 <kmem_cache_free+106/164>
   9:   9d                        popf
Code;  c0122514 <kmem_cache_free+108/164>
   a:   83 c4 fc                  add    $0xfffffffc,%esp
Code;  c0122516 <kmem_cache_free+10a/164>
   d:   56                        push   %esi
Code;  c0122518 <kmem_cache_free+10c/164>
   e:   53                        push   %ebx
Code;  c0122518 <kmem_cache_free+10c/164>
   f:   68 e0 ed 1c c0            push   $0xc01cede0

Feb 26 21:48:00 fsa-bg kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000002c
Feb 26 21:48:00 fsa-bg kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Feb 26 21:48:00 fsa-bg kernel: *pde = 00000000
Feb 26 21:48:00 fsa-bg kernel: Oops: 0000
Feb 26 21:48:00 fsa-bg kernel: CPU:    0
Feb 26 21:48:00 fsa-bg kernel: EIP:    0010:[<c012250a>]
Feb 26 21:48:00 fsa-bg kernel: EFLAGS: 00010012
Feb 26 21:48:00 fsa-bg kernel: eax: 00000000   ebx: c1bf0590   ecx: c1bf0f90   edx: 0000002c
Feb 26 21:48:00 fsa-bg kernel: esi: c26ff620   edi: 00000286   ebp: 0000000b   esp: c232fcb0
Feb 26 21:48:00 fsa-bg kernel: ds: 0018   es: 0018   ss: 0018
Feb 26 21:48:00 fsa-bg kernel: Process sshd (pid: 5737, process nr: 10, stackpage=c232f000)
Feb 26 21:48:00 fsa-bg kernel: Stack: c1bf0590 00000001 c1bf0590 c242a188 c1bf0590 00000001 007fc000 00000003
Feb 26 21:48:00 fsa-bg kernel:        c0239760 c0132a10 c26ff620 c1bf0590 00000000 00000001 c25f3c80 c242a188
Feb 26 21:48:00 fsa-bg kernel:        c16a40c0 c011bd64 00000000 bfffc000 c16a40c0 c01267c2 c1bf0590 c25f3c80
Feb 26 21:48:00 fsa-bg kernel: Call Trace: [<c0132a10>] [<c011bd64>] [<c01267c2>] [<c011ddf5>] [<c0127954>] [<c012794b>] [<c011406f>]
Feb 26 21:48:00 fsa-bg kernel:        [<c012682a>] [<c011400c>] [<c0118f50>] [<c0118ed5>] [<c010a590>] [<c01cd2ee>] [<c01cd2a0>] [<c010fde7>]
Feb 26 21:48:00 fsa-bg kernel:        [<c01cd2ee>] [<c010fb10>] [<c0180434>] [<c010a1d5>] [<c012250a>] [<c0132a10>] [<c01267c2>] [<c011c8ce>]
Feb 26 21:48:00 fsa-bg kernel:        [<c0127954>] [<c012794b>] [<c011ce6a>] [<c012682a>] [<c0126899>] [<c010a1d5>] [<c010a0b8>]
Feb 26 21:48:00 fsa-bg kernel: Code: 39 1a 0f 84 2e ff ff ff 57 9d 83 c4 fc 56 53 68 e0 ed 1c c0

>>EIP; c012250a <kmem_cache_free+fe/164>   <=====
Trace; c0132a10 <dput+f0/158>
Trace; c011bd64 <clear_page_tables+b4/bc>
Trace; c01267c2 <__fput+4a/54>
Trace; c011ddf4 <exit_mmap+114/120>
Trace; c0127954 <fput+20/54>
Trace; c012794a <fput+16/54>
Trace; c011406e <mmput+3e/48>
Trace; c012682a <filp_close+5e/6c>
Trace; c011400c <mm_release+10/34>
Trace; c0118f50 <do_exit+14c/2a4>
Trace; c0118ed4 <do_exit+d0/2a4>
Trace; c010a590 <die_if_no_fixup+0/4c>
Trace; c01cd2ee <error_table+24ee/2660>
Trace; c01cd2a0 <error_table+24a0/2660>
Trace; c010fde6 <do_page_fault+2d6/3e0>
Trace; c01cd2ee <error_table+24ee/2660>
Trace; c010fb10 <do_page_fault+0/3e0>
Trace; c0180434 <inet_release+30/94>
Trace; c010a1d4 <error_code+34/40>
Trace; c012250a <kmem_cache_free+fe/164>
Trace; c0132a10 <dput+f0/158>
Trace; c01267c2 <__fput+4a/54>
Trace; c011c8ce <do_wp_page+d6/198>
Trace; c0127954 <fput+20/54>
Trace; c012794a <fput+16/54>
Trace; c011ce6a <handle_mm_fault+12a/158>
Trace; c012682a <filp_close+5e/6c>
Trace; c0126898 <sys_close+60/70>
Trace; c010a1d4 <error_code+34/40>
Trace; c010a0b8 <system_call+34/38>
Code;  c012250a <kmem_cache_free+fe/164>
00000000 <_EIP>:
Code;  c012250a <kmem_cache_free+fe/164>   <=====
   0:   39 1a                     cmp    %ebx,(%edx)   <=====
Code;  c012250c <kmem_cache_free+100/164>
   2:   0f 84 2e ff ff ff         je     ffffff36 <_EIP+0xffffff36> c0122440 <kmem_cache_free+34/164>
Code;  c0122512 <kmem_cache_free+106/164>
   8:   57                        push   %edi
Code;  c0122512 <kmem_cache_free+106/164>
   9:   9d                        popf
Code;  c0122514 <kmem_cache_free+108/164>
   a:   83 c4 fc                  add    $0xfffffffc,%esp
Code;  c0122516 <kmem_cache_free+10a/164>
   d:   56                        push   %esi
Code;  c0122518 <kmem_cache_free+10c/164>
   e:   53                        push   %ebx
Code;  c0122518 <kmem_cache_free+10c/164>
   f:   68 e0 ed 1c c0            push   $0xc01cede0

1 warning issued.  Results may not be reliable.

------------------------------------------------
dmesg
------------------------------------------------


Linux version 2.2.20 (root@doom) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 Mon Dec 3 16:31:00 EET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000a0000 @ 00000000 (usable)
 BIOS-e820: 02600000 @ 00100000 (usable)
Detected 199740 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 398.95 BogoMIPS
Memory: 37892k/39936k available (984k kernel code, 408k reserved, 604k data, 48k init)
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
CPU: Intel Pentium MMX stepping 04
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf04b0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
SIS5513: IDE controller on PCI bus 00 dev 09
SIS5513: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: ST31722A, ATA DISK drive
hdb: SAMSUNG SV0432D, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ST31722A, 1625MB w/128kB Cache, CHS=825/64/63
hdb: SAMSUNG SV0432D, 4112MB w/480kB Cache, CHS=524/255/63
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ne2k-pci.c: v1.02 for Linux 2.2, 10/19/2000, D. Becker/P. Gortmaker, http://www.scyld.com/network/ne2k-pci.html
ne2k-pci.c: PCI NE2000 clone 'RealTek RTL-8029' at I/O 0xb800, IRQ 11.
eth0: RealTek RTL-8029 found at 0xb800, IRQ 11, 00:A0:4B:07:81:E4.
Partition check:
 hda: hda1 hda2
 hdb: hdb1
apm: BIOS version 1.2 Flags 0x0b (Driver version 1.13)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 48k freed
Adding Swap: 74588k swap-space (priority -1)

----------------------------------------------------------
.config
----------------------------------------------------------
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Processor type and features
#
CONFIG_M386=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M686 is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_OPTIMIZE is not set
CONFIG_PCI_OLD_PROC=y
# CONFIG_MCA is not set
# CONFIG_VISWS is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_BINFMT_JAVA is not set
# CONFIG_PARPORT is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
# CONFIG_TOSHIBA is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_VIA82C586 is not set
# CONFIG_BLK_DEV_CMD646 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_PARIDE_PARPORT=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_FIREWALL=y
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_IP_FIREWALL=y
CONFIG_IP_FIREWALL_NETLINK=y
CONFIG_NETLINK_DEV=y
# CONFIG_IP_TRANSPARENT_PROXY is not set
# CONFIG_IP_MASQUERADE is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_RARP is not set
CONFIG_SKB_LARGE=y
# CONFIG_IPV6 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
# CONFIG_CPU_IS_SLOW is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_RTL8139 is not set
# CONFIG_RTL8139TOO is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_EISA=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_LP486E is not set
# CONFIG_CS89x0 is not set
# CONFIG_DM9102 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DEC_ELCP is not set
# CONFIG_DEC_ELCP_OLD is not set
# CONFIG_DGRS is not set
# CONFIG_EEXPRESS_PRO100 is not set
# CONFIG_LNE390 is not set
# CONFIG_NE3210 is not set
CONFIG_NE2K_PCI=y
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SIS900 is not set
# CONFIG_ES3210 is not set
# CONFIG_EPIC100 is not set
# CONFIG_ZNET is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_RADIO is not set

#
# Token ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_HOSTESS_SV11 is not set
# CONFIG_COSA is not set
# CONFIG_SEALEVEL_4021 is not set
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_LANMEDIA is not set
# CONFIG_COMX is not set
# CONFIG_HDLC is not set
# CONFIG_DLCI is not set
# CONFIG_XPEED is not set
# CONFIG_SBNI is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_INTEL_RNG is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SMD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_RU is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

