Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135666AbRDSNZ6>; Thu, 19 Apr 2001 09:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135667AbRDSNZz>; Thu, 19 Apr 2001 09:25:55 -0400
Received: from ascomax.hasler.ascom.ch ([139.79.135.1]:52472 "EHLO
	ascomax.hasler.ascom.ch") by vger.kernel.org with ESMTP
	id <S135594AbRDSNZn>; Thu, 19 Apr 2001 09:25:43 -0400
Date: Thu, 19 Apr 2001 15:25:33 +0200
From: Martin Buck <martin.buck@ascom.ch>
To: linux-kernel@vger.kernel.org
Subject: Strange Oops in free_wait()/do_select()
Message-ID: <20010419152533.A22922@tux.ma.tech.ascom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
X-Filter-Version: 1.2 (ascomax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting strange Oopses with 2.2.17 on an AMD Athlon 1.2 GHz machine.
They all happen in about the same place in free_wait() called by
do_select(). I don't see a special pattern when I look at the failing
addresses, but then, I'm not a kernel expert...

The strange thing is that exactly this kernel ran fine for months on a
Pentium II/300 machine. I then copied the whole disk from the old to the
new machine and started getting the Oopses (every few days). Differences
between both machines: CPUs/motherboards of course, 512MB RAM instead of
256MB, SCSI instead of IDE disk.

I first suspected memory or power supply problems, but memtest86 ran fine
for 2 days. Also, in those cases, I would expect random crashes in
different places, not always in do_select().

Any hints what I could try next? Hardware/software problem? More
information required? I could probably dig out a few more of those Oopses
from backup, if that helps. Here are the ones I currently have:

---------------------

ksymoops 2.3.4 on i686 2.2.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17/ (default)
     -m /boot/System.map-2.2.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.


Mar 21 01:02:46 tux kernel: Unable to handle kernel paging request at virtual address f6f300b4
Mar 21 01:02:46 tux kernel: current->tss.cr3 = 1c3a1000, %%cr3 = 1c3a1000
Mar 21 01:02:46 tux kernel: *pde = 00000000
Mar 21 01:02:46 tux kernel: Oops: 0000
Mar 21 01:02:46 tux kernel: CPU:    0
Mar 21 01:02:46 tux kernel: EIP:    0010:[free_wait+44/116]
Mar 21 01:02:46 tux kernel: EFLAGS: 00010087
Mar 21 01:02:46 tux kernel: eax: 8200000b   ebx: f6f300b0   ecx: d6f30000   edx: c5bdff98
Mar 21 01:02:46 tux kernel: esi: f6f300ac   edi: d6f30000   ebp: 00000287   esp: c5bdfeec
Mar 21 01:02:46 tux kernel: ds: 0018   es: 0018   ss: 0018
Mar 21 01:02:46 tux kernel: Process Xvnc (pid: 14195, process nr: 54, stackpage=c5bdf000)
Mar 21 01:02:46 tux kernel: Stack: 00000800 0000000c 00000010 00000000 00000000 c012e047 d6f30000 00000000 
Mar 21 01:02:46 tux kernel:        0000000c c012e018 00000004 00000010 c3e26dc0 00000000 00000001 d81220b4 
Mar 21 01:02:46 tux kernel:        bffff990 c5bde000 c5bde000 0000464c 00000000 d6f30000 c99b880c c5bdff68 
Mar 21 01:02:46 tux kernel: Call Trace: [do_select+487/512] [do_select+440/512] [sys_select+881/1176] [sys_select+993/1176] [sys_gettimeofday+32/148] [sys_gettimeofday+0/148] [system_call+52/56] 
Mar 21 01:02:46 tux kernel: Code: 8b 4b 04 89 ca 8b 41 04 39 d8 74 09 89 c2 8b 42 04 39 d8 75 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 4b 04                  mov    0x4(%ebx),%ecx
Code;  00000003 Before first symbol
   3:   89 ca                     mov    %ecx,%edx
Code;  00000005 Before first symbol
   5:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  00000008 Before first symbol
   8:   39 d8                     cmp    %ebx,%eax
Code;  0000000a Before first symbol
   a:   74 09                     je     15 <_EIP+0x15> 00000015 Before first symbol
Code;  0000000c Before first symbol
   c:   89 c2                     mov    %eax,%edx
Code;  0000000e Before first symbol
   e:   8b 42 04                  mov    0x4(%edx),%eax
Code;  00000011 Before first symbol
  11:   39 d8                     cmp    %ebx,%eax
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Mar 29 13:39:48 tux kernel: Unable to handle kernel paging request at virtual address 90000003
Mar 29 13:39:48 tux kernel: current->tss.cr3 = 1dc86000, %%cr3 = 1dc86000
Mar 29 13:39:48 tux kernel: *pde = 00000000
Mar 29 13:39:48 tux kernel: Oops: 0000
Mar 29 13:39:48 tux kernel: CPU:    0
Mar 29 13:39:48 tux kernel: EIP:    0010:[free_wait+49/116]
Mar 29 13:39:48 tux kernel: EFLAGS: 00010087
Mar 29 13:39:48 tux kernel: eax: 00000001   ebx: c3760000   ecx: 8fffffff   edx: 8fffffff
Mar 29 13:39:48 tux kernel: esi: c375fffc   edi: c3760000   ebp: 00000287   esp: ddc85eec
Mar 29 13:39:48 tux kernel: ds: 0018   es: 0018   ss: 0018
Mar 29 13:39:48 tux kernel: Process ntpd (pid: 309, process nr: 35, stackpage=ddc85000)
Mar 29 13:39:48 tux kernel: Stack: 00000080 00000008 00000004 c48872d8 00000000 c012e047 c3760000 00000000 
Mar 29 13:39:48 tux kernel:        00000008 c012e018 00000001 00000004 c48872d8 00000000 00000001 c48872d4 
Mar 29 13:39:48 tux kernel:        bffffbc0 ddc84000 ddc84000 7fffffff 00000000 c3760000 dfe735a0 ddc85ec8 
Mar 29 13:39:48 tux kernel: Call Trace: [do_select+487/512] [do_select+440/512] [sys_select+881/1176] [sys_select+993/1176] [sys_gettimeofday+32/148] [system_call+52/56] 
Mar 29 13:39:48 tux kernel: Code: 8b 41 04 39 d8 74 09 89 c2 8b 42 04 39 d8 75 f7 89 4a 04 55 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  00000003 Before first symbol
   3:   39 d8                     cmp    %ebx,%eax
Code;  00000005 Before first symbol
   5:   74 09                     je     10 <_EIP+0x10> 00000010 Before first symbol
Code;  00000007 Before first symbol
   7:   89 c2                     mov    %eax,%edx
Code;  00000009 Before first symbol
   9:   8b 42 04                  mov    0x4(%edx),%eax
Code;  0000000c Before first symbol
   c:   39 d8                     cmp    %ebx,%eax
Code;  0000000e Before first symbol
   e:   75 f7                     jne    7 <_EIP+0x7> 00000007 Before first symbol
Code;  00000010 Before first symbol
  10:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  00000013 Before first symbol
  13:   55                        push   %ebp

Mar 29 15:20:03 tux kernel: Unable to handle kernel paging request at virtual address e5aa8084
Mar 29 15:20:03 tux kernel: current->tss.cr3 = 1e4e0000, %%cr3 = 1e4e0000
Mar 29 15:20:03 tux kernel: *pde = 00000000
Mar 29 15:20:03 tux kernel: Oops: 0000
Mar 29 15:20:03 tux kernel: CPU:    0
Mar 29 15:20:03 tux kernel: EIP:    0010:[free_wait+44/116]
Mar 29 15:20:03 tux kernel: EFLAGS: 00010083
Mar 29 15:20:03 tux kernel: eax: 82000008   ebx: e5aa8080   ecx: c5aa8000   edx: de4dff98
Mar 29 15:20:03 tux kernel: esi: e5aa807c   edi: c5aa8000   ebp: 00000283   esp: de4dfeec
Mar 29 15:20:03 tux kernel: ds: 0018   es: 0018   ss: 0018
Mar 29 15:20:03 tux kernel: Process nmbd (pid: 287, process nr: 28, stackpage=de4df000)
Mar 29 15:20:03 tux kernel: Stack: 00001000 0000000d 00000080 00000000 00000000 c012e047 c5aa8000 00000000 
Mar 29 15:20:03 tux kernel:        0000000d c012e018 00000020 00000080 dffce700 00000000 00000020 dffce680 
Mar 29 15:20:03 tux kernel:        bffffcbc de4de000 de4de000 0000039d 00000000 c5aa8000 ded388c0 de4dfec8 
Mar 29 15:20:03 tux kernel: Call Trace: [do_select+487/512] [do_select+440/512] [sys_select+881/1176] [sys_select+993/1176] [error_code+45/52] [system_call+52/56] 
Mar 29 15:20:03 tux kernel: Code: 8b 4b 04 89 ca 8b 41 04 39 d8 74 09 89 c2 8b 42 04 39 d8 75 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 4b 04                  mov    0x4(%ebx),%ecx
Code;  00000003 Before first symbol
   3:   89 ca                     mov    %ecx,%edx
Code;  00000005 Before first symbol
   5:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  00000008 Before first symbol
   8:   39 d8                     cmp    %ebx,%eax
Code;  0000000a Before first symbol
   a:   74 09                     je     15 <_EIP+0x15> 00000015 Before first symbol
Code;  0000000c Before first symbol
   c:   89 c2                     mov    %eax,%edx
Code;  0000000e Before first symbol
   e:   8b 42 04                  mov    0x4(%edx),%eax
Code;  00000011 Before first symbol
  11:   39 d8                     cmp    %ebx,%eax
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Apr 11 13:57:44 tux kernel: Unable to handle kernel paging request at virtual address 90000003
Apr 11 13:57:44 tux kernel: current->tss.cr3 = 133ac000, %%cr3 = 133ac000
Apr 11 13:57:44 tux kernel: *pde = 00000000
Apr 11 13:57:44 tux kernel: Oops: 0000
Apr 11 13:57:44 tux kernel: CPU:    0
Apr 11 13:57:44 tux kernel: EIP:    0010:[free_wait+49/116]
Apr 11 13:57:44 tux kernel: EFLAGS: 00010087
Apr 11 13:57:44 tux kernel: eax: 00000001   ebx: ca3a4000   ecx: 8fffffff   edx: 8fffffff
Apr 11 13:57:44 tux kernel: esi: ca3a3ffc   edi: ca3a4000   ebp: 00000287   esp: d52a7eec
Apr 11 13:57:44 tux kernel: ds: 0018   es: 0018   ss: 0018
Apr 11 13:57:44 tux kernel: Process Xvnc (pid: 16646, process nr: 194, stackpage=d52a7000)
Apr 11 13:57:44 tux kernel: Stack: 00002000 0000000e 00000010 00000000 00000000 c012e047 ca3a4000 00000000 
Apr 11 13:57:44 tux kernel:        0000000e c012e018 00000004 00000010 ce3d45a0 00000000 00000001 c5126614 
Apr 11 13:57:44 tux kernel:        bffff990 d52a6000 d52a6000 00004650 00000000 ca3a4000 0825d738 00000020 
Apr 11 13:57:44 tux kernel: Call Trace: [do_select+487/512] [do_select+440/512] [sys_select+881/1176] [sys_select+993/1176] [sys_gettimeofday+32/148] [system_call+52/56] 
Apr 11 13:57:44 tux kernel: Code: 8b 41 04 39 d8 74 09 89 c2 8b 42 04 39 d8 75 f7 89 4a 04 55 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  00000003 Before first symbol
   3:   39 d8                     cmp    %ebx,%eax
Code;  00000005 Before first symbol
   5:   74 09                     je     10 <_EIP+0x10> 00000010 Before first symbol
Code;  00000007 Before first symbol
   7:   89 c2                     mov    %eax,%edx
Code;  00000009 Before first symbol
   9:   8b 42 04                  mov    0x4(%edx),%eax
Code;  0000000c Before first symbol
   c:   39 d8                     cmp    %ebx,%eax
Code;  0000000e Before first symbol
   e:   75 f7                     jne    7 <_EIP+0x7> 00000007 Before first symbol
Code;  00000010 Before first symbol
  10:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  00000013 Before first symbol
  13:   55                        push   %ebp

Apr 17 16:57:59 tux kernel: Unable to handle kernel paging request at virtual address e33b40c4
Apr 17 16:57:59 tux kernel: current->tss.cr3 = 03689000, %%cr3 = 03689000
Apr 17 16:57:59 tux kernel: *pde = 00000000
Apr 17 16:57:59 tux kernel: Oops: 0000
Apr 17 16:57:59 tux kernel: CPU:    0
Apr 17 16:57:59 tux kernel: EIP:    0010:[free_wait+44/116]
Apr 17 16:57:59 tux kernel: EFLAGS: 00010083
Apr 17 16:57:59 tux kernel: eax: 9080000c   ebx: e33b40c0   ecx: db3b4000   edx: de7a5f98
Apr 17 16:57:59 tux kernel: esi: e33b40bc   edi: db3b4000   ebp: 00000283   esp: de7a5eec
Apr 17 16:57:59 tux kernel: ds: 0018   es: 0018   ss: 0018
Apr 17 16:57:59 tux kernel: Process Xvnc (pid: 13658, process nr: 118, stackpage=de7a5000)
Apr 17 16:57:59 tux kernel: Stack: 00001000 0000000d 00000010 00000000 00000000 c012e047 db3b4000 00000000 
Apr 17 16:57:59 tux kernel:        0000000d c012e018 00000004 00000010 d8b2da00 00000000 00000001 cd2b0cf4 
Apr 17 16:57:59 tux kernel:        bffff990 de7a4000 de7a4000 000045a1 00000000 db3b4000 0847ef58 00000020 
Apr 17 16:57:59 tux kernel: Call Trace: [do_select+487/512] [do_select+440/512] [sys_select+881/1176] [sys_select+993/1176] [sys_gettimeofday+32/148] [sys_gettimeofday+0/148] [system_call+52/56] 
Apr 17 16:57:59 tux kernel: Code: 8b 4b 04 89 ca 8b 41 04 39 d8 74 09 89 c2 8b 42 04 39 d8 75 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 4b 04                  mov    0x4(%ebx),%ecx
Code;  00000003 Before first symbol
   3:   89 ca                     mov    %ecx,%edx
Code;  00000005 Before first symbol
   5:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  00000008 Before first symbol
   8:   39 d8                     cmp    %ebx,%eax
Code;  0000000a Before first symbol
   a:   74 09                     je     15 <_EIP+0x15> 00000015 Before first symbol
Code;  0000000c Before first symbol
   c:   89 c2                     mov    %eax,%edx
Code;  0000000e Before first symbol
   e:   8b 42 04                  mov    0x4(%edx),%eax
Code;  00000011 Before first symbol
  11:   39 d8                     cmp    %ebx,%eax
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol


1 warning issued.  Results may not be reliable.



Thanks,
Martin
