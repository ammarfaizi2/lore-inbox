Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRD1D6D>; Fri, 27 Apr 2001 23:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRD1D5y>; Fri, 27 Apr 2001 23:57:54 -0400
Received: from shell.aros.net ([207.173.16.19]:30985 "EHLO shell.aros.net")
	by vger.kernel.org with ESMTP id <S131899AbRD1D5s>;
	Fri, 27 Apr 2001 23:57:48 -0400
Date: Fri, 27 Apr 2001 21:57:47 -0600 (MDT)
From: Lawrence Gold <gold@aros.net>
To: linux-kernel@vger.kernel.org
Subject: Oopses under 2.4.4pre8 with Tbird 1.2GHz/Epox 8kta3
Message-ID: <Pine.BSF.4.05.10104272140320.50513-100000@shell.aros.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

About a week ago, I bought an AMD Thunderbird 1.2GHz CPU with a 266MHz
frontside bus, along with an Epox 8KTA3 motherboard.

If I boot into 2.2.18pre2, which was the version on the old hard drive I'm
using for testing, everything runs just fine.  However, if I boot into a
2.4.x kernel, either 2.4.2 or 2.4.4pre8, I will usually receive an oops
within a few minutes of running and sometimes a kernel panic during the
boot process.

At the end of this message, you'll find the output of one of the oopses I
received; it occurred a few seconds into building gpm.

Here's a list of facts which may or may not be pertinent:

- The kernel does NOT have DMA support or the VIA IDE driver enabled.
  (I will send my .config file it it'd be helpful.)
- The kernel was compiled with egcs-1.1.2 for Athlon (-mcpu-i686
  -malign-functions=4)
- The BIOS is the latest version from 17 April 2001.
- The BIOS has default rather than optimal settings enabled.
- The 128Mb DIMM in the machine was tested with memtest86 on the same
  hardware and checked out with no problems.  The panics/oopses also occur
  if I run with a different 128Mb DIMM.  Both are rated for 133MHz
  operation.
- The CPU and system temperature as reported by the BIOS seem to be well
  within reason: ~107 Fahrenheit for the CPU and ~80 Fahrenheit for the
  system.

Since I couldn't get gpm running and I didn't see the output of the oops
in my system logs, I took a picture with my digicam and typed it out by
hand.  :-)  If there's anything that looks REALLY screwy, I will
double-check the picture in my camera.

P.S. I'm not subscribed to the mailing list, so I'd appreciate being CC'd.

Thanks!


ksymoops 2.4.1 on i686 2.4.4-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-pre8/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address ca4ef810
c0127a83
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0127a83>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010012
eax: 00005555  ebx: 55d17f93  ecx: c4f1e000  edx: 00000013
esi: c1227c14  edi: 00000282  ebp: 015745fe  esp: c45dfc10
ds: 0018  es: 0018  ss: 0018
Process sh (pid: 578, stackpage=c45df000)
Stack: c4f1e2c0 c1240a40 4010d000 00004000 c4690404 0004f1e0 c0121c10 c1227c14
       c4f1e2c0 c45de000 c45dfdac c45de000 c1240a40 c4f1e640 c0138455 c1240a40
       c45de000 c45dfdac c538cac0 c45dfe6c c01385b5 ffffffb0 c45dfdac c01cf832
Call Trace: [<c0121c10>] [<c0138455>] [<c01385b5>] [<c0146f94>] [<c0146a50>]
[<c0138aa7>] [<c0138d3a>]
          [<c0138d51>] [c01058ff>] [<c0106c4f>]
Code: 89 44 a9 18 89 69 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 09

>>EIP; c0127a83 <kmem_cache_free+43/c0>   <=====
Trace; c0121c10 <exit_mmap+d0/120>
Trace; c0138455 <exec_mmap+25/110>
Trace; c01385b5 <flush_old_exec+75/220>
Trace; c0146f94 <load_elf_binary+544/da0>
Trace; c0146a50 <load_elf_binary+0/da0>
Trace; c0138aa7 <search_binary_handler+67/180>
Trace; c0138d3a <do_execve+17a/1f0>
Trace; c0138d51 <do_execve+191/1f0>
Code;  c0127a83 <kmem_cache_free+43/c0>
00000000 <_EIP>:
Code;  c0127a83 <kmem_cache_free+43/c0>   <=====
   0:   89 44 a9 18               mov    %eax,0x18(%ecx,%ebp,4)   <=====
Code;  c0127a87 <kmem_cache_free+47/c0>
   4:   89 69 14                  mov    %ebp,0x14(%ecx)
Code;  c0127a8a <kmem_cache_free+4a/c0>
   7:   8b 56 14                  mov    0x14(%esi),%edx
Code;  c0127a8d <kmem_cache_free+4d/c0>
   a:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  c0127a90 <kmem_cache_free+50/c0>
   d:   ff 49 10                  decl   0x10(%ecx)
Code;  c0127a93 <kmem_cache_free+53/c0>
  10:   39 d0                     cmp    %edx,%eax
Code;  c0127a95 <kmem_cache_free+55/c0>
  12:   74 09                     je     1d <_EIP+0x1d> c0127aa0 <kmem_cache_free+60/c0>


2 warnings issued.  Results may not be reliable.


