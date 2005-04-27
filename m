Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVD0OLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVD0OLc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVD0OLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:11:32 -0400
Received: from smtp06.auna.com ([62.81.186.16]:34258 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261624AbVD0OJy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:09:54 -0400
Date: Wed, 27 Apr 2005 14:09:30 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: gcc-4.0: a couple oopses
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
X-Mailer: Balsa 2.3.0
Message-Id: <1114610970l.5419l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I have just built 2.6.12-rc2-mm3 with gcc4 final. I got this couple oopses on boot.
This is almost plain rc3-mm3, the only patches applied are the syscall traps
changes by Stas Sergeev and the segment loading patch from Ingo.
Apart from this, things _seem_ to work...

Oopses follow:

ksymoops 2.4.9 on i686 2.6.11-jam14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.11-jam14/ (default)
     -m /boot/System.map-2.6.11-jam14 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr 27 15:52:44 werewolf kernel: Unable to handle kernel paging request at virtual address 10a316b4
Apr 27 15:52:44 werewolf kernel: b011f5d5
Apr 27 15:52:44 werewolf kernel: *pde = 00000000
Apr 27 15:52:44 werewolf kernel: Oops: 0002 [#1]
Apr 27 15:52:44 werewolf kernel: CPU:    0
Apr 27 15:52:44 werewolf kernel: EIP:    0060:[do_proc_dointvec_conv+15/58]    Not tainted VLI
Apr 27 15:52:44 werewolf kernel: EIP:    0060:[<b011f5d5>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 27 15:52:44 werewolf kernel: EFLAGS: 00010246   (2.6.11-jam14) 
Apr 27 15:52:44 werewolf kernel: eax: 00000000   ebx: 00000001   ecx: 10a316b4   edx: ef4eef1c
Apr 27 15:52:44 werewolf kernel: esi: a7f5f001   edi: ef4eef03   ebp: 00000001   esp: ef4eeedc
Apr 27 15:52:44 werewolf kernel: ds: 007b   es: 007b   ss: 0068
Apr 27 15:52:44 werewolf kernel: Stack: b011f8b2 00000001 00000000 00000001 eed6332c 10a316b4 00000001 00000001 
Apr 27 15:52:44 werewolf kernel:        00000000 30000000 0000000a ef4eefbc ef507550 a7f5f000 00000001 ef4eef04 
Apr 27 15:52:44 werewolf kernel:        00000000 00000000 a7f5f000 a7f5f000 00000001 efd9e8e0 b011f95c a7f5f000 
Apr 27 15:52:44 werewolf kernel: Call Trace:
Apr 27 15:52:44 werewolf kernel:  [<b011f8b2>] do_proc_dointvec+0x2b2/0x32c
Apr 27 15:52:44 werewolf kernel:  [<b011f95c>] proc_dointvec+0x30/0x35
Apr 27 15:52:44 werewolf kernel:  [<b011f5c6>] do_proc_dointvec_conv+0x0/0x3a
Apr 27 15:52:44 werewolf kernel:  [<b011f311>] do_rw_proc+0x78/0x84
Apr 27 15:52:44 werewolf kernel:  [<b011f354>] proc_writesys+0x0/0x24
Apr 27 15:52:44 werewolf kernel:  [<b011f373>] proc_writesys+0x1f/0x24
Apr 27 15:52:44 werewolf kernel:  [<b0152032>] vfs_write+0x89/0x12a
Apr 27 15:52:44 werewolf kernel:  [<b015217e>] sys_write+0x41/0x6a
Apr 27 15:52:44 werewolf kernel:  [<b0102993>] sysenter_past_esp+0x54/0x75
Apr 27 15:52:44 werewolf kernel: Code: c1 89 d8 ba ff ff 00 00 f0 0f c1 10 0f 85 9a 12 00 00 89 c8 83 c4 0c 5b 5e 5f 5d c3 83 7c 24 04 00 74 0d 8b 00 85 c0 75 18 8b 02 <89> 01 31 c0 c3 8b 09 85 c9 78 13 c7 00 00 00 00 00 89 0a 31 c0 


>>EIP; b011f5d5 <do_proc_dointvec_conv+f/3a>   <=====

>>ecx; 10a316b4 <phys_startup_32+109316b4/b0000000>
>>edx; ef4eef1c <pg0+3f0ddf1c/4fbed400>
>>esi; a7f5f001 <phys_startup_32+a7e5f001/b0000000>
>>edi; ef4eef03 <pg0+3f0ddf03/4fbed400>
>>esp; ef4eeedc <pg0+3f0ddedc/4fbed400>

Trace; b011f8b2 <do_proc_dointvec+2b2/32c>
Trace; b011f95c <proc_dointvec+30/35>
Trace; b011f5c6 <do_proc_dointvec_conv+0/3a>
Trace; b011f311 <do_rw_proc+78/84>
Trace; b011f354 <proc_writesys+0/24>
Trace; b011f373 <proc_writesys+1f/24>
Trace; b0152032 <vfs_write+89/12a>
Trace; b015217e <sys_write+41/6a>
Trace; b0102993 <sysenter_past_esp+54/75>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  b011f5aa <proc_doutsstring+8c/a8>
00000000 <_EIP>:
Code;  b011f5aa <proc_doutsstring+8c/a8>
   0:   c1 89 d8 ba ff ff 00      rorl   $0x0,0xffffbad8(%ecx)
Code;  b011f5b1 <proc_doutsstring+93/a8>
   7:   00 f0                     add    %dh,%al
Code;  b011f5b3 <proc_doutsstring+95/a8>
   9:   0f c1 10                  xadd   %edx,(%eax)
Code;  b011f5b6 <proc_doutsstring+98/a8>
   c:   0f 85 9a 12 00 00         jne    12ac <_EIP+0x12ac>
Code;  b011f5bc <proc_doutsstring+9e/a8>
  12:   89 c8                     mov    %ecx,%eax
Code;  b011f5be <proc_doutsstring+a0/a8>
  14:   83 c4 0c                  add    $0xc,%esp
Code;  b011f5c1 <proc_doutsstring+a3/a8>
  17:   5b                        pop    %ebx
Code;  b011f5c2 <proc_doutsstring+a4/a8>
  18:   5e                        pop    %esi
Code;  b011f5c3 <proc_doutsstring+a5/a8>
  19:   5f                        pop    %edi
Code;  b011f5c4 <proc_doutsstring+a6/a8>
  1a:   5d                        pop    %ebp
Code;  b011f5c5 <proc_doutsstring+a7/a8>
  1b:   c3                        ret    
Code;  b011f5c6 <do_proc_dointvec_conv+0/3a>
  1c:   83 7c 24 04 00            cmpl   $0x0,0x4(%esp)
Code;  b011f5cb <do_proc_dointvec_conv+5/3a>
  21:   74 0d                     je     30 <_EIP+0x30>
Code;  b011f5cd <do_proc_dointvec_conv+7/3a>
  23:   8b 00                     mov    (%eax),%eax
Code;  b011f5cf <do_proc_dointvec_conv+9/3a>
  25:   85 c0                     test   %eax,%eax
Code;  b011f5d1 <do_proc_dointvec_conv+b/3a>
  27:   75 18                     jne    41 <_EIP+0x41>
Code;  b011f5d3 <do_proc_dointvec_conv+d/3a>
  29:   8b 02                     mov    (%edx),%eax

This decode from eip onwards should be reliable

Code;  b011f5d5 <do_proc_dointvec_conv+f/3a>
00000000 <_EIP>:
Code;  b011f5d5 <do_proc_dointvec_conv+f/3a>   <=====
   0:   89 01                     mov    %eax,(%ecx)   <=====
Code;  b011f5d7 <do_proc_dointvec_conv+11/3a>
   2:   31 c0                     xor    %eax,%eax
Code;  b011f5d9 <do_proc_dointvec_conv+13/3a>
   4:   c3                        ret    
Code;  b011f5da <do_proc_dointvec_conv+14/3a>
   5:   8b 09                     mov    (%ecx),%ecx
Code;  b011f5dc <do_proc_dointvec_conv+16/3a>
   7:   85 c9                     test   %ecx,%ecx
Code;  b011f5de <do_proc_dointvec_conv+18/3a>
   9:   78 13                     js     1e <_EIP+0x1e>
Code;  b011f5e0 <do_proc_dointvec_conv+1a/3a>
   b:   c7 00 00 00 00 00         movl   $0x0,(%eax)
Code;  b011f5e6 <do_proc_dointvec_conv+20/3a>
  11:   89 0a                     mov    %ecx,(%edx)
Code;  b011f5e8 <do_proc_dointvec_conv+22/3a>
  13:   31 c0                     xor    %eax,%eax


1 warning and 1 error issued.  Results may not be reliable.


ksymoops 2.4.9 on i686 2.6.11-jam14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.11-jam14/ (default)
     -m /boot/System.map-2.6.11-jam14 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr 27 15:52:44 werewolf kernel: Unable to handle kernel paging request at virtual address 10a316b4
Apr 27 15:52:44 werewolf kernel: b011f5d5
Apr 27 15:52:44 werewolf kernel: *pde = 00000000
Apr 27 15:52:44 werewolf kernel: Oops: 0002 [#2]
Apr 27 15:52:44 werewolf kernel: CPU:    3
Apr 27 15:52:44 werewolf kernel: EIP:    0060:[do_proc_dointvec_conv+15/58]    Not tainted VLI
Apr 27 15:52:44 werewolf kernel: EIP:    0060:[<b011f5d5>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 27 15:52:44 werewolf kernel: EFLAGS: 00010246   (2.6.11-jam14) 
Apr 27 15:52:44 werewolf kernel: eax: 00000000   ebx: 00000001   ecx: 10a316b4   edx: eeee0f1c
Apr 27 15:52:45 werewolf kernel: esi: a7fa3001   edi: eeee0f03   ebp: 00000001   esp: eeee0edc
Apr 27 15:52:45 werewolf kernel: ds: 007b   es: 007b   ss: 0068
Apr 27 15:52:45 werewolf kernel: Stack: b011f8b2 00000001 00000000 00000001 ef3410ac 10a316b4 00000001 00000001 
Apr 27 15:52:45 werewolf kernel:        00000000 30000000 0000000a eeee0fbc ef245a70 a7fa3000 00000001 eeee0f04 
Apr 27 15:52:45 werewolf kernel:        00000000 00000000 a7fa3000 a7fa3000 00000001 efd9e8e0 b011f95c a7fa3000 
Apr 27 15:52:45 werewolf kernel: Call Trace:
Apr 27 15:52:45 werewolf kernel:  [<b011f8b2>] do_proc_dointvec+0x2b2/0x32c
Apr 27 15:52:45 werewolf kernel:  [<b011f95c>] proc_dointvec+0x30/0x35
Apr 27 15:52:45 werewolf kernel:  [<b011f5c6>] do_proc_dointvec_conv+0x0/0x3a
Apr 27 15:52:45 werewolf kernel:  [<b011f311>] do_rw_proc+0x78/0x84
Apr 27 15:52:45 werewolf kernel:  [<b011f354>] proc_writesys+0x0/0x24
Apr 27 15:52:45 werewolf kernel:  [<b011f373>] proc_writesys+0x1f/0x24
Apr 27 15:52:45 werewolf kernel:  [<b0152032>] vfs_write+0x89/0x12a
Apr 27 15:52:45 werewolf kernel:  [<b015217e>] sys_write+0x41/0x6a
Apr 27 15:52:45 werewolf kernel:  [<b0102993>] sysenter_past_esp+0x54/0x75
Apr 27 15:52:45 werewolf kernel: Code: c1 89 d8 ba ff ff 00 00 f0 0f c1 10 0f 85 9a 12 00 00 89 c8 83 c4 0c 5b 5e 5f 5d c3 83 7c 24 04 00 74 0d 8b 00 85 c0 75 18 8b 02 <89> 01 31 c0 c3 8b 09 85 c9 78 13 c7 00 00 00 00 00 89 0a 31 c0 


>>EIP; b011f5d5 <do_proc_dointvec_conv+f/3a>   <=====

>>ecx; 10a316b4 <phys_startup_32+109316b4/b0000000>
>>edx; eeee0f1c <pg0+3eacff1c/4fbed400>
>>esi; a7fa3001 <phys_startup_32+a7ea3001/b0000000>
>>edi; eeee0f03 <pg0+3eacff03/4fbed400>
>>esp; eeee0edc <pg0+3eacfedc/4fbed400>

Trace; b011f8b2 <do_proc_dointvec+2b2/32c>
Trace; b011f95c <proc_dointvec+30/35>
Trace; b011f5c6 <do_proc_dointvec_conv+0/3a>
Trace; b011f311 <do_rw_proc+78/84>
Trace; b011f354 <proc_writesys+0/24>
Trace; b011f373 <proc_writesys+1f/24>
Trace; b0152032 <vfs_write+89/12a>
Trace; b015217e <sys_write+41/6a>
Trace; b0102993 <sysenter_past_esp+54/75>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  b011f5aa <proc_doutsstring+8c/a8>
00000000 <_EIP>:
Code;  b011f5aa <proc_doutsstring+8c/a8>
   0:   c1 89 d8 ba ff ff 00      rorl   $0x0,0xffffbad8(%ecx)
Code;  b011f5b1 <proc_doutsstring+93/a8>
   7:   00 f0                     add    %dh,%al
Code;  b011f5b3 <proc_doutsstring+95/a8>
   9:   0f c1 10                  xadd   %edx,(%eax)
Code;  b011f5b6 <proc_doutsstring+98/a8>
   c:   0f 85 9a 12 00 00         jne    12ac <_EIP+0x12ac>
Code;  b011f5bc <proc_doutsstring+9e/a8>
  12:   89 c8                     mov    %ecx,%eax
Code;  b011f5be <proc_doutsstring+a0/a8>
  14:   83 c4 0c                  add    $0xc,%esp
Code;  b011f5c1 <proc_doutsstring+a3/a8>
  17:   5b                        pop    %ebx
Code;  b011f5c2 <proc_doutsstring+a4/a8>
  18:   5e                        pop    %esi
Code;  b011f5c3 <proc_doutsstring+a5/a8>
  19:   5f                        pop    %edi
Code;  b011f5c4 <proc_doutsstring+a6/a8>
  1a:   5d                        pop    %ebp
Code;  b011f5c5 <proc_doutsstring+a7/a8>
  1b:   c3                        ret    
Code;  b011f5c6 <do_proc_dointvec_conv+0/3a>
  1c:   83 7c 24 04 00            cmpl   $0x0,0x4(%esp)
Code;  b011f5cb <do_proc_dointvec_conv+5/3a>
  21:   74 0d                     je     30 <_EIP+0x30>
Code;  b011f5cd <do_proc_dointvec_conv+7/3a>
  23:   8b 00                     mov    (%eax),%eax
Code;  b011f5cf <do_proc_dointvec_conv+9/3a>
  25:   85 c0                     test   %eax,%eax
Code;  b011f5d1 <do_proc_dointvec_conv+b/3a>
  27:   75 18                     jne    41 <_EIP+0x41>
Code;  b011f5d3 <do_proc_dointvec_conv+d/3a>
  29:   8b 02                     mov    (%edx),%eax

This decode from eip onwards should be reliable

Code;  b011f5d5 <do_proc_dointvec_conv+f/3a>
00000000 <_EIP>:
Code;  b011f5d5 <do_proc_dointvec_conv+f/3a>   <=====
   0:   89 01                     mov    %eax,(%ecx)   <=====
Code;  b011f5d7 <do_proc_dointvec_conv+11/3a>
   2:   31 c0                     xor    %eax,%eax
Code;  b011f5d9 <do_proc_dointvec_conv+13/3a>
   4:   c3                        ret    
Code;  b011f5da <do_proc_dointvec_conv+14/3a>
   5:   8b 09                     mov    (%ecx),%ecx
Code;  b011f5dc <do_proc_dointvec_conv+16/3a>
   7:   85 c9                     test   %ecx,%ecx
Code;  b011f5de <do_proc_dointvec_conv+18/3a>
   9:   78 13                     js     1e <_EIP+0x1e>
Code;  b011f5e0 <do_proc_dointvec_conv+1a/3a>
   b:   c7 00 00 00 00 00         movl   $0x0,(%eax)
Code;  b011f5e6 <do_proc_dointvec_conv+20/3a>
  11:   89 0a                     mov    %ecx,(%edx)
Code;  b011f5e8 <do_proc_dointvec_conv+22/3a>
  13:   31 c0                     xor    %eax,%eax


1 warning and 1 error issued.  Results may not be reliable.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam14 (gcc 4.0.0 (4.0.0-1mdk for Mandriva Linux


