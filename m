Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbTEBBAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 21:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbTEBBAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 21:00:20 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:64268
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262842AbTEBBAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 21:00:17 -0400
Date: Thu, 1 May 2003 18:12:34 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: oops with 2.4.20aa1 & VM
Message-ID: <20030502011234.GA24907@matchmail.com>
Reply-To: mfedyk@matchmail.com, linux-kernel@vger.kernel.org
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrea Arcangeli <andrea@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had another oops with 2.4.19 on the same machine, but I don't have it
anymore.

ksymoops 2.4.8 on i686 2.4.20aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20aa1/ (default)
     -m /boot/System.map-2.4.20aa1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

May  1 16:29:50 fileserver kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000001b
May  1 16:29:50 fileserver kernel: c01405a3
May  1 16:29:50 fileserver kernel: *pde = 00000000
May  1 16:29:50 fileserver kernel: Oops: 0000 2.4.20aa1 #1 SMP Mon Dec 23 14:03:16 PST 2002
May  1 16:29:50 fileserver kernel: CPU:    1
May  1 16:29:50 fileserver kernel: EIP:    0010:[try_to_release_page+35/80]    Not tainted
May  1 16:29:50 fileserver kernel: EFLAGS: 00010282
May  1 16:29:50 fileserver kernel: eax: ffffffff   ebx: c12f1d18   ecx: 000001d0   edx: 00000001
May  1 16:29:50 fileserver kernel: esi: 000001d0   edi: 00000012   ebp: 00000000   esp: dffcdf38
May  1 16:29:50 fileserver kernel: ds: 0018   es: 0018   ss: 0018
May  1 16:29:50 fileserver kernel: Process kswapd (pid: 7, stackpage=dffcd000)
May  1 16:29:50 fileserver kernel: Stack: dde7a250 c12f1d18 c0135b76 c12f1d18 000001d0 00000020 000001d0 c02dce1c 
May  1 16:29:50 fileserver kernel:        c02dce1c dffcc000 00000c80 00003096 000001d0 c02dce1c c0135f9c dffcdfa4 
May  1 16:29:50 fileserver kernel:        0000003c 000001d0 00000020 c0136008 dffcdfa4 c02dce1c 00000001 dffcc000 
May  1 16:29:50 fileserver kernel: Call Trace:    [shrink_cache+646/1152] [shrink_caches+60/80] [try_to_free_pages_zone+88/240] [kswapd_balance_pgdat+87/160] [kswapd_balance+22/48]
May  1 16:29:50 fileserver kernel: Code: 83 78 1c 00 74 17 56 53 8b 40 1c ff d0 83 c4 08 85 c0 75 09 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c12f1d18 <_end+f347e8/1e9cb30>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 78 1c 00               cmpl   $0x0,0x1c(%eax)
Code;  00000004 Before first symbol
   4:   74 17                     je     1d <_EIP+0x1d>
Code;  00000006 Before first symbol
   6:   56                        push   %esi
Code;  00000007 Before first symbol
   7:   53                        push   %ebx
Code;  00000008 Before first symbol
   8:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  0000000b Before first symbol
   b:   ff d0                     call   *%eax
Code;  0000000d Before first symbol
   d:   83 c4 08                  add    $0x8,%esp
Code;  00000010 Before first symbol
  10:   85 c0                     test   %eax,%eax
Code;  00000012 Before first symbol
  12:   75 09                     jne    1d <_EIP+0x1d>


1 warning issued.  Results may not be reliable.
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:02.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 01)
00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0e.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 7a)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:04.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891 (rev 01)
01:06.0 SCSI storage controller: Adaptec AIC-7880U (rev 02)
02:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
02:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
Personalities : [linear] [raid0] [raid1] [raid5] 
read_ahead 1024 sectors
md1 : active raid1 sdb1[0] sda1[1]
      48064 blocks [2/2] [UU]
      
md0 : active raid5 sdf2[4] sde2[3] sdd2[2] sdc2[1] sdb3[0] sda3[5]
      88397120 blocks level 5, 32k chunk, algorithm 2 [6/6] [UUUUUU]
      
unused devices: <none>
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 664.586
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1327.10

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 664.586
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1327.10

