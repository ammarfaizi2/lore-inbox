Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289328AbSAOAsv>; Mon, 14 Jan 2002 19:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289334AbSAOAsn>; Mon, 14 Jan 2002 19:48:43 -0500
Received: from pc-62-31-78-67-ed.blueyonder.co.uk ([62.31.78.67]:26752 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S289328AbSAOAsh>;
	Mon, 14 Jan 2002 19:48:37 -0500
Date: Tue, 15 Jan 2002 00:47:12 +0000
From: rob@mur.org.uk
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.17
Message-ID: <20020115004712.GA695@scot-mur.demon.co.uk>
Mail-Followup-To: rob@mur.org.uk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The ksymoops output is below

This happened when I started screen after logging in just after
booting. I'm not able to reproduce it. I've had a few hangs recently
on this machine so I'm trying to find out if it's software or
hardware.

config at http://mur.org.uk/~robbie/config-2.4.17

Script started on Tue Jan 15 00:29:48 2002
linux:~#uname -a
Linux linux 2.4.17 #1 SMP Mon Dec 31 00:09:27 GMT 2001 i686 unknown
linux:~#cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 451.028
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 897.84

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 451.028
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 901.12

linux:~#lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:0b.0 SCSI storage controller: Adaptec AIC-7880U
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
00:12.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
00:13.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
00:14.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
linux:~#cat oops2.txt
ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01f3160, System.map says c01530b0.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0145df1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 5a5a5a00   ebx: dc418c40   ecx: dc454d60   edx: dc418c70
esi: dcbf2d40   edi: c1941f20   ebp: dc418c40   esp: dc45feb8
ds: 0018   es: 0018   ss: 0018
Process screen (pid: 716, stackpage=dc45f000)
Stack: dc454d60 c016bd29 dc418c40 dc454d60 fffffff4 df32fb80 dc45e000 dc418c40 
       c1941f28 c02abba0 de3a7001 0023ee05 df6dbf40 c180ae20 c0145549 00000246 
       00000000 df32fb80 df32fbe8 df330b40 00000246 c0145c83 c1806288 000001f0 
Call Trace: [<c016bd29>] [<c0145549>] [<c0145c83>] [<c013d67e>] [<c013ddb7>] 
   [<c013e01a>] [<c013e491>] [<c013b0cd>] [<c0141626>] [<c0106d7b>] 
Code: 0f 0b f0 fe 0d a0 e6 2f c0 0f 88 bb bc 10 00 85 c9 74 12 8b 

>>EIP; c0145df0 <d_instantiate+10/44>   <=====
Trace; c016bd28 <devfs_lookup+1c0/20c>
Trace; c0145548 <dput+18/144>
Trace; c0145c82 <d_alloc+1a/178>
Trace; c013d67e <real_lookup+7a/108>
Trace; c013ddb6 <link_path_walk+596/7e0>
Trace; c013e01a <path_walk+1a/1c>
Trace; c013e490 <__user_walk+34/50>
Trace; c013b0cc <sys_stat64+18/70>
Trace; c0141626 <sys_ioctl+1ea/1f4>
Trace; c0106d7a <system_call+32/38>
Code;  c0145df0 <d_instantiate+10/44>
00000000 <_EIP>:
Code;  c0145df0 <d_instantiate+10/44>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0145df2 <d_instantiate+12/44>
   2:   f0 fe 0d a0 e6 2f c0      lock decb 0xc02fe6a0
Code;  c0145df8 <d_instantiate+18/44>
   9:   0f 88 bb bc 10 00         js     10bcca <_EIP+0x10bcca> c0251aba <stext_lock+2cf2/8d98>
Code;  c0145dfe <d_instantiate+1e/44>
   f:   85 c9                     test   %ecx,%ecx
Code;  c0145e00 <d_instantiate+20/44>
  11:   74 12                     je     25 <_EIP+0x25> c0145e14 <d_instantiate+34/44>
Code;  c0145e02 <d_instantiate+22/44>
  13:   8b 00                     mov    (%eax),%eax


2 warnings issued.  Results may not be reliable.
linux:~#exit

Script done on Tue Jan 15 00:38:14 2002


-- 
Rob Murray
