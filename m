Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266656AbUF3NE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266656AbUF3NE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUF3NE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:04:58 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:23402 "EHLO
	mwinf1003.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266656AbUF3NEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:04:42 -0400
Date: Wed, 30 Jun 2004 15:04:38 +0200 (CEST)
From: Mathieu CLABAUT <mathieu.clabaut@free.fr>
X-X-Sender: clabaut@polka.aix.systerel.fr
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.26
Message-ID: <Pine.LNX.4.60.0406301458220.4707@polka.aix.systerel.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello,

   (It is my first kernel bug submition, Hope I post to the goo dlist).

   I recently compile the 2.4.26 kernel, with gcc3.3.3 and get several
   oops. I once suspected a memory problem, but the 3 first passes of
   memtest86 didn't report any problem.

   I compiled it with himem (1.5Gb of ram).

   The Oops follows :

ksymoops 2.4.4 on i686 2.4.26.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.26/ (default)
      -m /boot/System.map-2.4.26 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jun 30 14:31:20 polka kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jun 30 14:31:20 polka kernel: c01175b7
Jun 30 14:31:20 polka kernel: *pde = 00000000
Jun 30 14:31:20 polka kernel: Oops: 0000
Jun 30 14:31:20 polka kernel: CPU:    0
Jun 30 14:31:20 polka kernel: EIP:    0010:[<c01175b7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 30 14:31:20 polka kernel: EFLAGS: 00210097
Jun 30 14:31:20 polka kernel: eax: f52975bc   ebx: f5297500   ecx: 00000000   edx: f5297500
Jun 30 14:31:20 polka kernel: esi: f52975bc   edi: 00000001   ebp: f524fe8c   esp: f524fe70
Jun 30 14:31:20 polka kernel: ds: 0018   es: 0018   ss: 0018
Jun 30 14:31:20 polka kernel: Process kdeinit (pid: 3668, stackpage=f524f000)
Jun 30 14:31:20 polka kernel: Stack: 00200246 00200296 00000001 00200282 f5273440 f524ff20 00000020 00000000
Jun 30 14:31:20 polka kernel:        c02b0a53 f524ff64 00000020 00000020 f5273440 c0268e19 f5273440 f5ca2180
Jun 30 14:31:20 polka kernel:        c0269f92 f5ca2180 f524ff20 00000020 f5ca2180 c02b2a3a f5ca2180 f302b8c0
Jun 30 14:31:20 polka kernel: Call Trace:    [<c02b0a53>] [<c0268e19>] [<c0269f92>] [<c02b2a3a>] [<c0266828>]
Jun 30 14:31:20 polka kernel:   [<c0266957>] [<c013ac13>] [<c0107273>]
Jun 30 14:31:20 polka kernel: Code: 8b 01 85 c7 75 19 8b 02 89 d3 89 c2 0f 0d 00 39 f3 75 ea ff

>>EIP; c01175b7 <__wake_up+27/70>   <=====
Trace; c02b0a53 <unix_write_space+63/70>
Trace; c0268e19 <sock_wfree+49/50>
Trace; c0269f92 <__kfree_skb+42/160>
Trace; c02b2a3a <unix_stream_recvmsg+1ea/3a0>
Trace; c0266828 <sock_recvmsg+58/f0>
Trace; c0266957 <sock_read+97/b0>
Trace; c013ac13 <sys_read+a3/130>
Trace; c0107273 <system_call+33/38>
Code;  c01175b7 <__wake_up+27/70>
00000000 <_EIP>:
Code;  c01175b7 <__wake_up+27/70>   <=====
    0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01175b9 <__wake_up+29/70>
    2:   85 c7                     test   %eax,%edi
Code;  c01175bb <__wake_up+2b/70>
    4:   75 19                     jne    1f <_EIP+0x1f> c01175d6 <__wake_up+46/70>
Code;  c01175bd <__wake_up+2d/70>
    6:   8b 02                     mov    (%edx),%eax
Code;  c01175bf <__wake_up+2f/70>
    8:   89 d3                     mov    %edx,%ebx
Code;  c01175c1 <__wake_up+31/70>
    a:   89 c2                     mov    %eax,%edx
Code;  c01175c3 <__wake_up+33/70>
    c:   0f 0d 00                  prefetch (%eax)
Code;  c01175c6 <__wake_up+36/70>
    f:   39 f3                     cmp    %esi,%ebx
Code;  c01175c8 <__wake_up+38/70>
   11:   75 ea                     jne    fffffffd <_EIP+0xfffffffd> c01175b4 <__wake_up+24/70>
Code;  c01175ca <__wake_up+3a/70>
   13:   ff 00                     incl   (%eax)

Jun 30 11:19:02 polka kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jun 30 11:19:02 polka kernel: c01175b7
Jun 30 11:19:02 polka kernel: *pde = 36c8b067
Jun 30 11:19:02 polka kernel: Oops: 0000
Jun 30 11:19:02 polka kernel: CPU:    0
Jun 30 11:19:02 polka kernel: EIP:    0010:[<c01175b7>]    Not tainted
Jun 30 11:19:02 polka kernel: EFLAGS: 00013097
Jun 30 11:19:02 polka kernel: eax: f4f621bc   ebx: f4f62100   ecx: 00000000   edx: f4f62100
Jun 30 11:19:02 polka kernel: esi: f4f621bc   edi: 00000001   ebp: f59bff4c   esp: f59bff30
Jun 30 11:19:02 polka kernel: ds: 0018   es: 0018   ss: 0018
Jun 30 11:19:02 polka kernel: Process X (pid: 2073, stackpage=f59bf000)
Jun 30 11:19:02 polka kernel: Stack: f4fd1e60 f5202a40 00000000 00003282 f4f98dc0 f4f99100 00000003 bfffefe8 
Jun 30 11:19:02 polka kernel:        c02b2c2b f4f98dc0 c02665ac 00000000 f4f621a0 0000001a 090d86d0 c0267b22 
Jun 30 11:19:02 polka kernel:        f4f621a0 00000002 0000001a 0000000d c026812b 0000001a 00000002 00000008 
Jun 30 11:19:02 polka kernel: Call Trace:    [<c02b2c2b>] [<c02665ac>] [<c0267b22>] [<c026812b>] [<c013b187>]
Jun 30 11:19:02 polka kernel:   [<c0107273>]
Jun 30 11:19:02 polka kernel: Code: 8b 01 85 c7 75 19 8b 02 89 d3 89 c2 0f 0d 00 39 f3 75 ea ff

>>EIP; c01175b7 <__wake_up+27/70>   <=====
Trace; c02b2c2b <unix_shutdown+3b/100>
Trace; c02665ac <sockfd_lookup+1c/80>
Trace; c0267b22 <sys_shutdown+32/50>
Trace; c026812b <sys_socketcall+1cb/260>
Trace; c013b187 <sys_writev+67/80>
Trace; c0107273 <system_call+33/38>
Code;  c01175b7 <__wake_up+27/70>
00000000 <_EIP>:
Code;  c01175b7 <__wake_up+27/70>   <=====
    0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01175b9 <__wake_up+29/70>
    2:   85 c7                     test   %eax,%edi
Code;  c01175bb <__wake_up+2b/70>
    4:   75 19                     jne    1f <_EIP+0x1f> c01175d6 <__wake_up+46/70>
Code;  c01175bd <__wake_up+2d/70>
    6:   8b 02                     mov    (%edx),%eax
Code;  c01175bf <__wake_up+2f/70>
    8:   89 d3                     mov    %edx,%ebx
Code;  c01175c1 <__wake_up+31/70>
    a:   89 c2                     mov    %eax,%edx
Code;  c01175c3 <__wake_up+33/70>
    c:   0f 0d 00                  prefetch (%eax)
Code;  c01175c6 <__wake_up+36/70>
    f:   39 f3                     cmp    %esi,%ebx
Code;  c01175c8 <__wake_up+38/70>
   11:   75 ea                     jne    fffffffd <_EIP+0xfffffffd> c01175b4 <__wake_up+24/70>
Code;  c01175ca <__wake_up+3a/70>
   13:   ff 00                     incl   (%eax)

Jun 30 11:00:51 polka kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jun 30 11:00:51 polka kernel: c01175b7
Jun 30 11:00:51 polka kernel: *pde = 00000000
Jun 30 11:00:51 polka kernel: Oops: 0000
Jun 30 11:00:51 polka kernel: CPU:    0
Jun 30 11:00:51 polka kernel: EIP:    0010:[<c01175b7>]    Not tainted
Jun 30 11:00:51 polka kernel: EFLAGS: 00210097
Jun 30 11:00:51 polka kernel: eax: f4f62100   ebx: f4f62100   ecx: 00000000   edx: f4f62100
Jun 30 11:00:51 polka kernel: esi: f4f621bc   edi: 00000001   ebp: f4f95e8c   esp: f4f95e70
Jun 30 11:00:51 polka kernel: ds: 0018   es: 0018   ss: 0018
Jun 30 11:00:51 polka kernel: Process kdeinit (pid: 2186, stackpage=f4f95000)
Jun 30 11:00:51 polka kernel: Stack: f68cee34 00200296 00000001 00200282 f4f98dc0 f4f95f20 00000020 00000000 
Jun 30 11:00:51 polka kernel:        c02b0a53 f4f95f64 00000020 00000020 f4f98dc0 c0268e19 f4f98dc0 f4f7cc80 
Jun 30 11:00:51 polka kernel:        c0269f92 f4f7cc80 f4f95f20 00000020 f4f7cc80 c02b2a3a f4f7cc80 f4c8cac0 
Jun 30 11:00:51 polka kernel: Call Trace:    [<c02b0a53>] [<c0268e19>] [<c0269f92>] [<c02b2a3a>] [<c0266828>]
Jun 30 11:00:51 polka kernel:   [<c0266957>] [<c013ac13>] [<c0107273>]
Jun 30 11:00:51 polka kernel: Code: 8b 01 85 c7 75 19 8b 02 89 d3 89 c2 0f 0d 00 39 f3 75 ea ff

>>EIP; c01175b7 <__wake_up+27/70>   <=====
Trace; c02b0a53 <unix_write_space+63/70>
Trace; c0268e19 <sock_wfree+49/50>
Trace; c0269f92 <__kfree_skb+42/160>
Trace; c02b2a3a <unix_stream_recvmsg+1ea/3a0>
Trace; c0266828 <sock_recvmsg+58/f0>
Trace; c0266957 <sock_read+97/b0>
Trace; c013ac13 <sys_read+a3/130>
Trace; c0107273 <system_call+33/38>
Code;  c01175b7 <__wake_up+27/70>
00000000 <_EIP>:
Code;  c01175b7 <__wake_up+27/70>   <=====
    0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01175b9 <__wake_up+29/70>
    2:   85 c7                     test   %eax,%edi
Code;  c01175bb <__wake_up+2b/70>
    4:   75 19                     jne    1f <_EIP+0x1f> c01175d6 <__wake_up+46/70>
Code;  c01175bd <__wake_up+2d/70>
    6:   8b 02                     mov    (%edx),%eax
Code;  c01175bf <__wake_up+2f/70>
    8:   89 d3                     mov    %edx,%ebx
Code;  c01175c1 <__wake_up+31/70>
    a:   89 c2                     mov    %eax,%edx
Code;  c01175c3 <__wake_up+33/70>
    c:   0f 0d 00                  prefetch (%eax)
Code;  c01175c6 <__wake_up+36/70>
    f:   39 f3                     cmp    %esi,%ebx
Code;  c01175c8 <__wake_up+38/70>
   11:   75 ea                     jne    fffffffd <_EIP+0xfffffffd> c01175b4 <__wake_up+24/70>
Code;  c01175ca <__wake_up+3a/70>
   13:   ff 00                     incl   (%eax)

Jun 30 09:51:48 polka kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000064
Jun 30 09:51:48 polka kernel: c01175b7
Jun 30 09:51:48 polka kernel: *pde = 359fc067
Jun 30 09:51:48 polka kernel: Oops: 0000
Jun 30 09:51:48 polka kernel: CPU:    0
Jun 30 09:51:48 polka kernel: EIP:    0010:[<c01175b7>]    Not tainted
Jun 30 09:51:48 polka kernel: EFLAGS: 00013093
Jun 30 09:51:48 polka kernel: eax: f4b47afc   ebx: f4b47a00   ecx: 00000064   edx: 00000000
Jun 30 09:51:48 polka kernel: esi: f4b47afc   edi: 00000001   ebp: f5625f4c   esp: f5625f30
Jun 30 09:51:48 polka kernel: ds: 0018   es: 0018   ss: 0018
Jun 30 09:51:48 polka kernel: Process X (pid: 2028, stackpage=f5625000)
Jun 30 09:51:49 polka kernel: Stack: f4b12660 dee548d8 00000000 00003286 f4b2a440 f4b2a100 00000003 bfffefe8 
Jun 30 09:51:50 polka kernel:        c02b2c2b f4b2a440 c02665ac 00000000 f4b47ae0 0000001b 08f1d8e0 c0267b22 
Jun 30 09:51:50 polka kernel:        f4b47ae0 00000002 0000001b 0000000d c026812b 0000001b 00000002 00000008 
Jun 30 09:51:50 polka kernel: Call Trace:    [<c02b2c2b>] [<c02665ac>] [<c0267b22>] [<c026812b>] [<c013b187>]
Jun 30 09:51:50 polka kernel:   [<c0107273>]
Jun 30 09:51:51 polka kernel: Code: 8b 01 85 c7 75 19 8b 02 89 d3 89 c2 0f 0d 00 39 f3 75 ea ff

>>EIP; c01175b7 <__wake_up+27/70>   <=====
Trace; c02b2c2b <unix_shutdown+3b/100>
Trace; c02665ac <sockfd_lookup+1c/80>
Trace; c0267b22 <sys_shutdown+32/50>
Trace; c026812b <sys_socketcall+1cb/260>
Trace; c013b187 <sys_writev+67/80>
Trace; c0107273 <system_call+33/38>
Code;  c01175b7 <__wake_up+27/70>
00000000 <_EIP>:
Code;  c01175b7 <__wake_up+27/70>   <=====
    0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01175b9 <__wake_up+29/70>
    2:   85 c7                     test   %eax,%edi
Code;  c01175bb <__wake_up+2b/70>
    4:   75 19                     jne    1f <_EIP+0x1f> c01175d6 <__wake_up+46/70>
Code;  c01175bd <__wake_up+2d/70>
    6:   8b 02                     mov    (%edx),%eax
Code;  c01175bf <__wake_up+2f/70>
    8:   89 d3                     mov    %edx,%ebx
Code;  c01175c1 <__wake_up+31/70>
    a:   89 c2                     mov    %eax,%edx
Code;  c01175c3 <__wake_up+33/70>
    c:   0f 0d 00                  prefetch (%eax)
Code;  c01175c6 <__wake_up+36/70>
    f:   39 f3                     cmp    %esi,%ebx
Code;  c01175c8 <__wake_up+38/70>
   11:   75 ea                     jne    fffffffd <_EIP+0xfffffffd> c01175b4 <__wake_up+24/70>
Code;  c01175ca <__wake_up+3a/70>
   13:   ff 00                     incl   (%eax)

Jun 28 18:04:04 polka kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000064
Jun 28 18:04:04 polka kernel: c01175b7
Jun 28 18:04:04 polka kernel: *pde = 00000000
Jun 28 18:04:04 polka kernel: Oops: 0000
Jun 28 18:04:04 polka kernel: CPU:    0
Jun 28 18:04:04 polka kernel: EIP:    0010:[<c01175b7>]    Not tainted
Jun 28 18:04:04 polka kernel: EFLAGS: 00210093
Jun 28 18:04:04 polka kernel: eax: 00000000   ebx: f4b47a00   ecx: 00000064   edx: 00000000
Jun 28 18:04:04 polka kernel: esi: f4b47afc   edi: 00000001   ebp: f4b63e8c   esp: f4b63e70
Jun 28 18:04:04 polka kernel: ds: 0018   es: 0018   ss: 0018
Jun 28 18:04:04 polka kernel: Process kdeinit (pid: 2311, stackpage=f4b63000)
Jun 28 18:04:04 polka kernel: Stack: 00000001 00200296 00000001 00200286 f4b2a440 f4b63f20 00000020 00000000 
Jun 28 18:04:04 polka kernel:        c02b0a53 f4b63f64 00000020 00000020 f4b2a440 c0268e19 f4b2a440 f5314c00 
Jun 28 18:04:04 polka kernel:        c0269f92 f5314c00 f4b63f20 00000020 f5314c00 c02b2a3a f5314c00 f5f83b40 
Jun 28 18:04:04 polka kernel: Call Trace:    [<c02b0a53>] [<c0268e19>] [<c0269f92>] [<c02b2a3a>] [<c0266828>]
Jun 28 18:04:05 polka kernel:   [<c0266957>] [<c013ac13>] [<c0107273>]
Jun 28 18:04:05 polka kernel: Code: 8b 01 85 c7 75 19 8b 02 89 d3 89 c2 0f 0d 00 39 f3 75 ea ff

>>EIP; c01175b7 <__wake_up+27/70>   <=====
Trace; c02b0a53 <unix_write_space+63/70>
Trace; c0268e19 <sock_wfree+49/50>
Trace; c0269f92 <__kfree_skb+42/160>
Trace; c02b2a3a <unix_stream_recvmsg+1ea/3a0>
Trace; c0266828 <sock_recvmsg+58/f0>
Trace; c0266957 <sock_read+97/b0>
Trace; c013ac13 <sys_read+a3/130>
Trace; c0107273 <system_call+33/38>
Code;  c01175b7 <__wake_up+27/70>
00000000 <_EIP>:
Code;  c01175b7 <__wake_up+27/70>   <=====
    0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01175b9 <__wake_up+29/70>
    2:   85 c7                     test   %eax,%edi
Code;  c01175bb <__wake_up+2b/70>
    4:   75 19                     jne    1f <_EIP+0x1f> c01175d6 <__wake_up+46/70>
Code;  c01175bd <__wake_up+2d/70>
    6:   8b 02                     mov    (%edx),%eax
Code;  c01175bf <__wake_up+2f/70>
    8:   89 d3                     mov    %edx,%ebx
Code;  c01175c1 <__wake_up+31/70>
    a:   89 c2                     mov    %eax,%edx
Code;  c01175c3 <__wake_up+33/70>
    c:   0f 0d 00                  prefetch (%eax)
Code;  c01175c6 <__wake_up+36/70>
    f:   39 f3                     cmp    %esi,%ebx
Code;  c01175c8 <__wake_up+38/70>
   11:   75 ea                     jne    fffffffd <_EIP+0xfffffffd> c01175b4 <__wake_up+24/70>
Code;  c01175ca <__wake_up+3a/70>
   13:   ff 00                     incl   (%eax)

Jun 28 17:56:47 polka kernel: Unable to handle kernel paging request at virtual address fb38ed88
Jun 28 17:56:47 polka kernel: c01320aa
Jun 28 17:56:47 polka kernel: *pde = 00000000
Jun 28 17:56:47 polka kernel: Oops: 0000
Jun 28 17:56:47 polka kernel: CPU:    0
Jun 28 17:56:47 polka kernel: EIP:    0010:[<c01320aa>]    Tainted: PF
Jun 28 17:56:47 polka kernel: EFLAGS: 00010006
Jun 28 17:56:47 polka kernel: eax: 414d5f4c   ebx: 414d5f4c   ecx: f6037040   edx: 00000000
Jun 28 17:56:47 polka kernel: esi: c2216858   edi: 00000246   ebp: 000000f0   esp: eb263a70
Jun 28 17:56:47 polka kernel: ds: 0018   es: 0018   ss: 0018
Jun 28 17:56:47 polka kernel: Process prouveur (pid: 1068, stackpage=eb263000)
Jun 28 17:56:47 polka kernel: Stack: f601fda8 00002000 00000001 eb263ae8 f0299ac0 eb263ae8 c0191d4f c2216858 
Jun 28 17:56:47 polka kernel:        000000f0 00000000 00000001 0000000a c010ae18 00000000 00000003 00000002 
Jun 28 17:56:47 polka kernel:        eb263b14 c018e1cf f6b49e40 eb263ae8 f6b49e40 00000002 eb263ae8 eb263b14 
Jun 28 17:56:47 polka kernel: Call Trace:    [<c0191d4f>] [<c010ae18>] [<c018e1cf>] [<c0192037>] [<c0192cc3>]
Jun 28 17:56:47 polka kernel:   [<c0191864>] [<c0191b56>] [<c012e510>] [<c012ea5e>] [<c018a1b0>] [<c0128278>]
Jun 28 17:56:47 polka kernel:   [<c015cc3b>] [<c015d64a>] [<c0143ee1>] [<c0123080>] [<c0123125>] [<c0106fda>]
Jun 28 17:56:47 polka kernel:   [<c01d3066>] [<c01d73d0>] [<c0117464>] [<c0116490>] [<c01072ac>]
Jun 28 17:56:47 polka kernel: Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89

>>EIP; c01320aa <__kmem_cache_alloc+4a/f0>   <=====
Trace; c0191d4f <nfs_flush_one+4f/2e0>
Trace; c010ae18 <call_do_IRQ+5/d>
Trace; c018e1cf <nfs_coalesce_requests+7f/c0>
Trace; c0192037 <nfs_flush_list+57/170>
Trace; c0192cc3 <nfs_flush_file+73/80>
Trace; c0191864 <nfs_strategy+54/70>
Trace; c0191b56 <nfs_updatepage+216/290>
Trace; c012e510 <do_generic_file_write+280/470>
Trace; c012ea5e <generic_file_write+11e/130>
Trace; c018a1b0 <nfs_file_write+80/e0>
Trace; c0128278 <get_user_pages+98/1a0>
Trace; c015cc3b <dump_write+2b/40>
Trace; c015d64a <elf_core_dump+87a/9f0>
Trace; c0143ee1 <do_coredump+171/180>
Trace; c0123080 <collect_signal+b0/f0>
Trace; c0123125 <dequeue_signal+65/d0>
Trace; c0106fda <do_signal+1fa/2a0>
Trace; c01d3066 <tty_write+c6/140>
Trace; c01d73d0 <write_chan+0/200>
Trace; c0117464 <schedule+204/330>
Trace; c0116490 <do_page_fault+0/4e7>
Trace; c01072ac <signal_return+14/18>
Code;  c01320aa <__kmem_cache_alloc+4a/f0>
00000000 <_EIP>:
Code;  c01320aa <__kmem_cache_alloc+4a/f0>   <=====
    0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c01320ae <__kmem_cache_alloc+4e/f0>
    4:   0f af 5e 18               imul   0x18(%esi),%ebx
Code;  c01320b2 <__kmem_cache_alloc+52/f0>
    8:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c01320b5 <__kmem_cache_alloc+55/f0>
    b:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c01320b8 <__kmem_cache_alloc+58/f0>
    e:   40                        inc    %eax
Code;  c01320b9 <__kmem_cache_alloc+59/f0>
    f:   74 18                     je     29 <_EIP+0x29> c01320d3 <__kmem_cache_alloc+73/f0>
Code;  c01320bb <__kmem_cache_alloc+5b/f0>
   11:   57                        push   %edi
Code;  c01320bc <__kmem_cache_alloc+5c/f0>
   12:   9d                        popf 
Code;  c01320bd <__kmem_cache_alloc+5d/f0>
   13:   89 00                     mov    %eax,(%eax)

Jun 28 17:56:47 polka kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
Jun 28 17:56:47 polka kernel: c0132181
Jun 28 17:56:47 polka kernel: *pde = 00000000
Jun 28 17:56:47 polka kernel: Oops: 0000
Jun 28 17:56:47 polka kernel: CPU:    0
Jun 28 17:56:47 polka kernel: EIP:    0010:[<c0132181>]    Tainted: PF
Jun 28 17:56:47 polka kernel: EFLAGS: 00210012
Jun 28 17:56:47 polka kernel: eax: 00a205d0   ebx: c2216858   ecx: 00000000   edx: 00000000
Jun 28 17:56:47 polka kernel: esi: f601fc80   edi: 00000000   ebp: f746e000   esp: f746ff2c
Jun 28 17:56:47 polka kernel: ds: 0018   es: 0018   ss: 0018
Jun 28 17:56:47 polka kernel: Process rpciod (pid: 1237, stackpage=f746f000)
Jun 28 17:56:47 polka kernel: Stack: 00200296 f601fc80 00000000 c0131aae c2216858 f601fc80 f601fc80 c0190bdb 
Jun 28 17:56:47 polka kernel:        c2216858 f601fc80 c02bb5a4 f601fc80 f601fc80 f601fc80 c03a2f48 00002000 
Jun 28 17:56:47 polka kernel:        c02bae0e f601fc80 ec185000 c0370000 f746e000 0000001e c0117464 f746ffbc 
Jun 28 17:56:47 polka kernel: Call Trace:    [<c0131aae>] [<c0190bdb>] [<c02bb5a4>] [<c02bae0e>] [<c0117464>]
Jun 28 17:56:47 polka kernel:   [<c02bb143>] [<c02bb886>] [<c02bb7f0>] [<c010576b>] [<c02bb7f0>]
Jun 28 17:56:47 polka kernel: Code: 2b 71 0c 89 f0 f7 73 18 89 c6 8b 41 14 89 44 b1 18 8b 51 10

>>EIP; c0132181 <kmem_cache_free_one+31/ac>   <=====
Trace; c0131aae <kmem_cache_free+1e/30>
Trace; c0190bdb <nfs_writedata_release+1b/20>
Trace; c02bb5a4 <rpc_release_task+144/1d0>
Trace; c02bae0e <__rpc_execute+be/2c0>
Trace; c0117464 <schedule+204/330>
Trace; c02bb143 <__rpc_schedule+b3/120>
Trace; c02bb886 <rpciod+96/210>
Trace; c02bb7f0 <rpciod+0/210>
Trace; c010576b <arch_kernel_thread+2b/40>
Trace; c02bb7f0 <rpciod+0/210>
Code;  c0132181 <kmem_cache_free_one+31/ac>
00000000 <_EIP>:
Code;  c0132181 <kmem_cache_free_one+31/ac>   <=====
    0:   2b 71 0c                  sub    0xc(%ecx),%esi   <=====
Code;  c0132184 <kmem_cache_free_one+34/ac>
    3:   89 f0                     mov    %esi,%eax
Code;  c0132186 <kmem_cache_free_one+36/ac>
    5:   f7 73 18                  divl   0x18(%ebx)
Code;  c0132189 <kmem_cache_free_one+39/ac>
    8:   89 c6                     mov    %eax,%esi
Code;  c013218b <kmem_cache_free_one+3b/ac>
    a:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c013218e <kmem_cache_free_one+3e/ac>
    d:   89 44 b1 18               mov    %eax,0x18(%ecx,%esi,4)
Code;  c0132192 <kmem_cache_free_one+42/ac>
   11:   8b 51 10                  mov    0x10(%ecx),%edx


    Hope it may be of some use...


-mathieu

--
________________http://www.gnu.org/philosophy/no-word-attachments.fr.html
Mathieu CLABAUT                            mailto:mathieu.clabaut@free.fr
            F2F5 442F F2AC E1D5 9D31  3EFC 842A BC4A 123B 9A65
