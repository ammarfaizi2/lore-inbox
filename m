Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTLOLDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 06:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTLOLDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 06:03:25 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:16620 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S263510AbTLOLDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 06:03:21 -0500
Date: Mon, 15 Dec 2003 12:02:28 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 Oops
Message-ID: <20031215110228.GA15976@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <20031210084827.GA27823@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210084827.GA27823@iapetus.localdomain>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a new kernel oops. Same machine as the previous reported oops
in journal_try_to_free_buffers(). Something seems definately wrong
in 2.4.23.

Marcelo, I'll follow your suggestion te revert a particular change.

ksymoops 2.4.9 on i686 2.4.23-x91.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-x91/ (default)
     -m /boot/System.map-2.4.23-x91 (specified)

Dec 15 11:31:26 tornio kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Dec 15 11:31:26 tornio kernel: c0147c56
Dec 15 11:31:26 tornio kernel: *pde = 00000000
Dec 15 11:31:26 tornio kernel: Oops: 0000
Dec 15 11:31:26 tornio kernel: CPU:    0
Dec 15 11:31:26 tornio kernel: EIP:    0010:[<c0147c56>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 15 11:31:26 tornio kernel: EFLAGS: 00010217
Dec 15 11:31:26 tornio kernel: eax: 00000000   ebx: fffffff0   ecx: 0000000e   edx: a4946908
Dec 15 11:31:26 tornio kernel: esi: c4aecdd4   edi: c4aece40   ebp: c2973ec4   esp: c2973ea4
Dec 15 11:31:26 tornio kernel: ds: 0018   es: 0018   ss: 0018
Dec 15 11:31:26 tornio kernel: Process sh (pid: 17607, stackpage=c2973000)
Dec 15 11:31:27 tornio kernel: Stack: c2973f1c c4aecdd4 c4aece40 00000000 c11a1078 c442000f a4946908 0000000c 
Dec 15 11:31:27 tornio kernel:        c2973ee0 c013f8e7 c4b7fbf8 c2973f1c c2973f1c 00000000 c2973f84 c2973f28 
Dec 15 11:31:27 tornio kernel:        c0140055 c4b7fbf8 c2973f1c 00000000 c2973f84 c4420000 00000000 c2973fb4 
Dec 15 11:31:27 tornio kernel: Call Trace:    [<c013f8e7>] [<c0140055>] [<c0116230>] [<c01402ed>] [<c014044e>]
Dec 15 11:31:27 tornio kernel:   [<c01407e0>] [<c013654e>] [<c013688e>] [<c0108ab3>]
Dec 15 11:31:27 tornio kernel: Code: 8b 00 89 45 ec 39 53 44 75 78 8b 45 08 39 43 0c 75 70 8b 40 


>>EIP; c0147c56 <d_lookup+66/10c>   <=====

>>esi; c4aecdd4 <_end+4662d54/846ffe0>
>>edi; c4aece40 <_end+4662dc0/846ffe0>
>>ebp; c2973ec4 <_end+24e9e44/846ffe0>
>>esp; c2973ea4 <_end+24e9e24/846ffe0>

Trace; c013f8e7 <real_lookup+27/cc>
Trace; c0140055 <link_path_walk+5d5/850>
Trace; c0116230 <do_page_fault+1a4/4c7>
Trace; c01402ed <path_walk+1d/24>
Trace; c014044e <path_lookup+1e/2c>
Trace; c01407e0 <open_namei+64/4c8>
Trace; c013654e <filp_open+32/50>
Trace; c013688e <sys_open+36/88>
Trace; c0108ab3 <system_call+33/40>

Code;  c0147c56 <d_lookup+66/10c>
00000000 <_EIP>:
Code;  c0147c56 <d_lookup+66/10c>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c0147c58 <d_lookup+68/10c>
   2:   89 45 ec                  mov    %eax,0xffffffec(%ebp)
Code;  c0147c5b <d_lookup+6b/10c>
   5:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c0147c5e <d_lookup+6e/10c>
   8:   75 78                     jne    82 <_EIP+0x82>
Code;  c0147c60 <d_lookup+70/10c>
   a:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  c0147c63 <d_lookup+73/10c>
   d:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c0147c66 <d_lookup+76/10c>
  10:   75 70                     jne    82 <_EIP+0x82>
Code;  c0147c68 <d_lookup+78/10c>
  12:   8b 40 00                  mov    0x0(%eax),%eax

Dec 15 11:35:01 tornio kernel:  kernel BUG at slab.c:1218!
Dec 15 11:35:01 tornio kernel: invalid operand: 0000
Dec 15 11:35:01 tornio kernel: CPU:    0
Dec 15 11:35:01 tornio kernel: EIP:    0010:[<c012e38c>]    Not tainted
Dec 15 11:35:01 tornio kernel: EFLAGS: 00010002
Dec 15 11:35:01 tornio kernel: eax: 01b0a3db   ebx: 00000000   ecx: 00000074   edx: c11833f0
Dec 15 11:35:01 tornio kernel: esi: c40a3f60   edi: c40a3040   ebp: c11cbf18   esp: c11cbf04
Dec 15 11:35:01 tornio kernel: ds: 0018   es: 0018   ss: 0018
Dec 15 11:35:01 tornio kernel: Process kswapd (pid: 4, stackpage=c11cb000)
Dec 15 11:35:01 tornio kernel: Stack: c40a3040 c40a3f64 c11833f0 01b0a3db c1bf9424 c11cbf48 c012e921 c11833f0 
Dec 15 11:35:01 tornio kernel:        c40a3040 c40a3f60 c6542220 c40a3f64 c37cc254 c014998d 0000006c c40a3f60 
Dec 15 11:35:01 tornio kernel:        00000246 c11cbf64 c0147716 c11833f0 c40a3f64 0000003c 000001d0 0000000c 
Dec 15 11:35:01 tornio kernel: Call Trace:    [<c012e921>] [<c014998d>] [<c0147716>] [<c01479e0>] [<c012fe14>]
Dec 15 11:35:01 tornio kernel:   [<c012ff9b>] [<c0130007>] [<c013013d>] [<c01073b4>]
Dec 15 11:35:01 tornio kernel: Code: 0f 0b c2 04 e0 37 33 c0 0f af 4d f8 8d 04 19 39 c6 74 08 0f 


>>EIP; c012e38c <kmem_extra_free_checks+30/74>   <=====

>>edx; c11833f0 <_end+cf9370/846ffe0>
>>esi; c40a3f60 <_end+3c19ee0/846ffe0>
>>edi; c40a3040 <_end+3c18fc0/846ffe0>
>>ebp; c11cbf18 <_end+d41e98/846ffe0>
>>esp; c11cbf04 <_end+d41e84/846ffe0>

Trace; c012e921 <kmem_cache_free+1c9/270>
Trace; c014998d <iput+45/1d8>
Trace; c0147716 <prune_dcache+116/150>
Trace; c01479e0 <shrink_dcache_memory+1c/34>
Trace; c012fe14 <try_to_free_pages_zone+70/d8>
Trace; c012ff9b <kswapd_balance_pgdat+5f/b4>
Trace; c0130007 <kswapd_balance+17/34>
Trace; c013013d <kswapd+9d/c0>
Trace; c01073b4 <arch_kernel_thread+28/38>

Code;  c012e38c <kmem_extra_free_checks+30/74>
00000000 <_EIP>:
Code;  c012e38c <kmem_extra_free_checks+30/74>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012e38e <kmem_extra_free_checks+32/74>
   2:   c2 04 e0                  ret    $0xe004
Code;  c012e391 <kmem_extra_free_checks+35/74>
   5:   37                        aaa    
Code;  c012e392 <kmem_extra_free_checks+36/74>
   6:   33 c0                     xor    %eax,%eax
Code;  c012e394 <kmem_extra_free_checks+38/74>
   8:   0f af 4d f8               imul   0xfffffff8(%ebp),%ecx
Code;  c012e398 <kmem_extra_free_checks+3c/74>
   c:   8d 04 19                  lea    (%ecx,%ebx,1),%eax
Code;  c012e39b <kmem_extra_free_checks+3f/74>
   f:   39 c6                     cmp    %eax,%esi
Code;  c012e39d <kmem_extra_free_checks+41/74>
  11:   74 08                     je     1b <_EIP+0x1b>
Code;  c012e39f <kmem_extra_free_checks+43/74>
  13:   0f 00 00                  sldtl  (%eax)


-- 
Frank
