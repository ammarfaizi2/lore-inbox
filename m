Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265915AbRGEQze>; Thu, 5 Jul 2001 12:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265149AbRGEQzY>; Thu, 5 Jul 2001 12:55:24 -0400
Received: from zeus.kernel.org ([209.10.41.242]:8930 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265915AbRGEQzU>;
	Thu, 5 Jul 2001 12:55:20 -0400
Date: Thu, 5 Jul 2001 09:53:12 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200107051653.f65GrC400989@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: henry@borg.metroweb.co.za, linux-kernel@vger.kernel.org
Subject: Re: OOPS (kswapd) in 2.4.5 and 2.4.6
In-Reply-To: <01070516412506.06182@borg>
In-Reply-To: <01070516412506.06182@borg>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> We've noticed the following kernel error since 2.4 (2.4.1-2.4.6).
> It appears to be swap (kswapd thread specific?) related.  The same
> error is reported on several SMP machines after only a short period
> (an hour or less).

FYI, I see a similar problem under 2.4.5, also SMP, although only
intermittently.  Two oopses are below, from two different, although
similarly configured, machines.

A bit of warning: these kernels were patched with MOSIX-1.04
(www.mosix.org), but I don't believe that it touches the relevant
parts of the kernel.  Moreover, the MOSIX developers suggested these
oopses were not MOSIX-related, and they are usually pretty good about
that.

Cheers,
Wayne


ksymoops 2.3.4 on i686 2.4.5-mosix-1.0.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-mosix-1.0.4/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Jun 15 01:18:17 mf3 kernel: invalid operand: 0000
Jun 15 01:18:17 mf3 kernel: CPU:    0
Jun 15 01:18:17 mf3 kernel: EIP:    0010:[clear_inode+51/260]
Jun 15 01:18:17 mf3 kernel: EIP:    0010:[<c015bca7>]
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 15 01:18:17 mf3 kernel: EFLAGS: 00010292
Jun 15 01:18:17 mf3 kernel: eax: 0000001b   ebx: c42cdd60   ecx: 00000001   edx: 00000001
Jun 15 01:18:17 mf3 kernel: esi: e0937860   edi: c42cdd60   ebp: 00001e7c   esp: dff67f68
Jun 15 01:18:17 mf3 kernel: ds: 0018   es: 0018   ss: 0018
Jun 15 01:18:17 mf3 kernel: Process kswapd (pid: 4, stackpage=dff67000)
Jun 15 01:18:17 mf3 kernel: Stack: c023fea4 c023ff03 000001eb c42cdd60 c015c842 c42cdd60 c42f2940 c42f2920
Jun 15 01:18:17 mf3 kernel:        e0929ffd c42cdd60 c42f2940 c015a040 c42f2920 c42cdd60 00000482 00000004
Jun 15 01:18:17 mf3 kernel:        00000000 0008e000 c015a399 00002bc0 c013b2b7 00000006 00000004 00000004
Jun 15 01:18:17 mf3 kernel: Call Trace: [iput+342/360] [ide-scsi:__insmod_ide-scsi_S.bss_L96+377149/32977459] [prune_dcache+220/368] [shrink_dcache_memory+33/48] [do_try_to_free_pages+39/88] [kswapd+87/228] [prepare_namespace+0/8]
Jun 15 01:18:17 mf3 kernel: Call Trace: [<c015c842>] [<e0929ffd>] [<c015a040>] [<c015a399>] [<c013b2b7>] [<c013b33f>] [<c0105000>]
Jun 15 01:18:17 mf3 kernel:        [<c010550b>]
Jun 15 01:18:17 mf3 kernel: Code: 0f 0b 83 c4 0c 8d 74 26 00 8b 83 f4 00 00 00 a8 10 75 26 68

>>EIP; c015bca7 <clear_inode+33/104>   <=====
Trace; c015c842 <iput+156/168>
Trace; e0929ffd <[nfs]nfs_dentry_iput+75/7c>
Trace; c015a040 <prune_dcache+dc/170>
Trace; c015a399 <shrink_dcache_memory+21/30>
Trace; c013b2b7 <do_try_to_free_pages+27/58>
Trace; c013b33f <kswapd+57/e4>
Trace; c0105000 <prepare_namespace+0/8>
Trace; c010550b <kernel_thread+23/30>
Code;  c015bca7 <clear_inode+33/104>
00000000 <_EIP>:
Code;  c015bca7 <clear_inode+33/104>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015bca9 <clear_inode+35/104>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c015bcac <clear_inode+38/104>
   5:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c015bcb0 <clear_inode+3c/104>
   9:   8b 83 f4 00 00 00         mov    0xf4(%ebx),%eax
Code;  c015bcb6 <clear_inode+42/104>
   f:   a8 10                     test   $0x10,%al
Code;  c015bcb8 <clear_inode+44/104>
  11:   75 26                     jne    39 <_EIP+0x39> c015bce0 <clear_inode+6c/104>
Code;  c015bcba <clear_inode+46/104>
  13:   68 00 00 00 00            push   $0x0

1 warning issued.  Results may not be reliable.


ksymoops 2.3.4 on i686 2.4.5-mosix-1.0.4b.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-mosix-1.0.4b/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Jun 27 09:22:58 mf2 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000814
Jun 27 09:22:58 mf2 kernel: c015a045
Jun 27 09:22:58 mf2 kernel: *pde = 00000000
Jun 27 09:22:58 mf2 kernel: Oops: 0000
Jun 27 09:22:58 mf2 kernel: CPU:    0
Jun 27 09:22:58 mf2 kernel: EIP:    0010:[prune_dcache+209/368]
Jun 27 09:22:58 mf2 kernel: EIP:    0010:[<c015a045>]
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 27 09:22:58 mf2 kernel: EFLAGS: 00010206
Jun 27 09:22:58 mf2 kernel: eax: 00000800   ebx: e959a8e0   ecx: e9596df0   edx: e9596df0
Jun 27 09:22:58 mf2 kernel: esi: e959a8c0   edi: e9596de0   ebp: 0000101b   esp: c2225fa0
Jun 27 09:22:58 mf2 kernel: ds: 0018   es: 0018   ss: 0018
Jun 27 09:22:58 mf2 kernel: Process kswapd (pid: 4, stackpage=c2225000)
Jun 27 09:22:58 mf2 kernel: Stack: 000000c8 00000004 00000000 0008e000 c015a3a9 00002926 c013b2b7 00000006
Jun 27 09:22:58 mf2 kernel:        00000004 00000004 00000000 c2224000 c023bb31 c2224331 c013b33f 00000004
Jun 27 09:22:58 mf2 kernel:        00000000 00010f00 c2213fb4 c0105000 c010550b 00000000 c02bb080 c2212000
Jun 27 09:22:58 mf2 kernel: Call Trace: [shrink_dcache_memory+33/48] [do_try_to_free_pages+39/88] [kswapd+87/228] [prepare_namespace+0/8] [kernel_thread+35/48]
Jun 27 09:22:58 mf2 kernel: Call Trace: [<c015a3a9>] [<c013b2b7>] [<c013b33f>] [<c0105000>] [<c010550b>]
Jun 27 09:22:58 mf2 kernel: Code: 8b 40 14 85 c0 74 09 57 56 ff d0 83 c4 08 eb 12 57 e8 a1 26

>>EIP; c015a045 <prune_dcache+d1/170>   <=====
Trace; c015a3a9 <shrink_dcache_memory+21/30>
Trace; c013b2b7 <do_try_to_free_pages+27/58>
Trace; c013b33f <kswapd+57/e4>
Trace; c0105000 <prepare_namespace+0/8>
Trace; c010550b <kernel_thread+23/30>
Code;  c015a045 <prune_dcache+d1/170>
00000000 <_EIP>:
Code;  c015a045 <prune_dcache+d1/170>   <=====
   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
Code;  c015a048 <prune_dcache+d4/170>
   3:   85 c0                     test   %eax,%eax
Code;  c015a04a <prune_dcache+d6/170>
   5:   74 09                     je     10 <_EIP+0x10> c015a055 <prune_dcache+e1/170>
Code;  c015a04c <prune_dcache+d8/170>
   7:   57                        push   %edi
Code;  c015a04d <prune_dcache+d9/170>
   8:   56                        push   %esi
Code;  c015a04e <prune_dcache+da/170>
   9:   ff d0                     call   *%eax
Code;  c015a050 <prune_dcache+dc/170>
   b:   83 c4 08                  add    $0x8,%esp
Code;  c015a053 <prune_dcache+df/170>
   e:   eb 12                     jmp    22 <_EIP+0x22> c015a067 <prune_dcache+f3/170>
Code;  c015a055 <prune_dcache+e1/170>
  10:   57                        push   %edi
Code;  c015a056 <prune_dcache+e2/170>
  11:   e8 a1 26 00 00            call   26b7 <_EIP+0x26b7> c015c6fc <iput+0/168>

1 warning issued.  Results may not be reliable.
