Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268110AbTBYR1y>; Tue, 25 Feb 2003 12:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268120AbTBYR1x>; Tue, 25 Feb 2003 12:27:53 -0500
Received: from gw.linuxforce.net ([207.106.35.93]:13836 "EHLO
	linux00.LinuxForce.net") by vger.kernel.org with ESMTP
	id <S268110AbTBYR10>; Tue, 25 Feb 2003 12:27:26 -0500
From: Tim Peeler <thp@linux00.LinuxForce.net>
Date: Tue, 25 Feb 2003 12:37:38 -0500
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:217!
Message-ID: <20030225173738.GA29371@LinuxForce.net>
Reply-To: thp@linuxforce.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

   2.4.20 kernel lockup/crash in page_alloc.c:217

[2.] Full description of the problem/report:

   We recently compiled a 2.4.20 kernel for several systems we maintain.
   After about 19 hours the kernel crashed when trying to allocate
   memory. 4 Processes (clamscan, amavisd, spamd, and freespace.monitor) each
   tried to run generating 4 oopses in the logs before the kernel panic.
   The system is a remotely maintained server, more (or better) oopses
   are probably missing.

[3.] Keywords (i.e., modules, networking, kernel):

   kernel, page_alloc, memory, mm

[4.] Kernel version (from /proc/version):

   Linux version 2.4.20 (root@linux01) (gcc version 2.95.4 20011002 (Debian
   prerelease)) #1 Tue Jan 28 16:23:54 EST 2003


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.5 on i686 2.4.20.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.20/ (specified)
     -m /boot/System.map-2.4.20 (specified)

Warning (compare_maps): mismatch on symbol zeroes  , ipsec says c80f58a0, /lib/modules/2.4.20/kernel/net/ipsec/ipsec.o says c80f57a0.  Ignoring /lib/modules/2.4.20/kernel/net/ipsec/ipsec.o entry
Feb 21 18:28:42 mail kernel: kernel BUG at page_alloc.c:217!
Feb 21 18:28:42 mail kernel: invalid operand: 0000
Feb 21 18:28:42 mail kernel: CPU:    0
Feb 21 18:28:42 mail kernel: EIP:    0010:[rmqueue+116/572]    Not tainted
Feb 21 18:28:42 mail kernel: EFLAGS: 00010082
Feb 21 18:28:42 mail kernel: eax: 00000034   ebx: c1000830   ecx: 00000000   edx: 0000002b
Feb 21 18:28:42 mail kernel: esi: c1000830   edi: 00000000   ebp: c028e320   esp: c4b8fe50
Feb 21 18:28:42 mail kernel: ds: 0018   es: 0018   ss: 0018
Feb 21 18:28:42 mail kernel: Process clamscan (pid: 4251, stackpage=c4b8f000)
Feb 21 18:28:42 mail kernel: Stack: c028e564 000001df 00000001 00000000 00001000 00000a0d 00000286 c028e338 
Feb 21 18:28:42 mail kernel:        00000000 c028e320 c012afa0 000001d2 c2177e60 00000001 c2177e60 c028e3d4 
Feb 21 18:28:42 mail kernel:        c028e55c 000001d2 c011900a c012ad96 00104025 c0121f30 0809f32c c2177e60 
Feb 21 18:28:42 mail kernel: Call Trace:    [__alloc_pages+64/352] [do_softirq+90/164] [_alloc_pages+22/24] [do_anonymous_page+52/228] [do_no_page+51/424]
Feb 21 18:28:42 mail kernel: Code: 0f 0b d9 00 b0 27 24 c0 8b 53 04 8b 03 89 50 04 89 02 c7 03 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c1000830 <_end+ce8cfc/7da44cc>
>>esi; c1000830 <_end+ce8cfc/7da44cc>
>>ebp; c028e320 <contig_page_data+0/340>
>>esp; c4b8fe50 <_end+487831c/7da44cc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   d9 00                     flds   (%eax)
Code;  00000004 Before first symbol
   4:   b0 27                     mov    $0x27,%al
Code;  00000006 Before first symbol
   6:   24 c0                     and    $0xc0,%al
Code;  00000008 Before first symbol
   8:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  0000000b Before first symbol
   b:   8b 03                     mov    (%ebx),%eax
Code;  0000000d Before first symbol
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000010 Before first symbol
  10:   89 02                     mov    %eax,(%edx)
Code;  00000012 Before first symbol
  12:   c7 03 00 00 00 00         movl   $0x0,(%ebx)

Feb 21 18:28:42 mail kernel:  kernel BUG at page_alloc.c:217!
Feb 21 18:28:42 mail kernel: invalid operand: 0000
Feb 21 18:28:42 mail kernel: CPU:    0
Feb 21 18:28:42 mail kernel: EIP:    0010:[rmqueue+116/572]    Not tainted
Feb 21 18:28:42 mail kernel: EFLAGS: 00010082
Feb 21 18:28:42 mail kernel: eax: 00000034   ebx: c1000830   ecx: 00000000   edx: 0000002b
Feb 21 18:28:42 mail kernel: esi: c1000830   edi: 00000000   ebp: c028e320   esp: c3b2be78
Feb 21 18:28:42 mail kernel: ds: 0018   es: 0018   ss: 0018
Feb 21 18:28:42 mail kernel: Process amavisd (pid: 4250, stackpage=c3b2b000)
Feb 21 18:28:42 mail kernel: Stack: c028e564 000001df 00000001 00000000 00001000 00000f40 00000296 c028e338 
Feb 21 18:28:42 mail kernel:        00000000 c028e320 c012afa0 000001d2 00000000 00000001 c080c3e0 c028e3d4 
Feb 21 18:28:42 mail kernel:        c028e55c 000001d2 c10b9330 c012ad96 c10b9330 c0121aaf 08158a68 c76c9bc0 
Feb 21 18:28:42 mail kernel: Call Trace:    [__alloc_pages+64/352] [_alloc_pages+22/24] [do_wp_page+147/568] [handle_mm_fault+123/180] [do_page_fault+352/1152]
Feb 21 18:28:42 mail kernel: Code: 0f 0b d9 00 b0 27 24 c0 8b 53 04 8b 03 89 50 04 89 02 c7 03 


>>ebx; c1000830 <_end+ce8cfc/7da44cc>
>>esi; c1000830 <_end+ce8cfc/7da44cc>
>>ebp; c028e320 <contig_page_data+0/340>
>>esp; c3b2be78 <_end+3814344/7da44cc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   d9 00                     flds   (%eax)
Code;  00000004 Before first symbol
   4:   b0 27                     mov    $0x27,%al
Code;  00000006 Before first symbol
   6:   24 c0                     and    $0xc0,%al
Code;  00000008 Before first symbol
   8:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  0000000b Before first symbol
   b:   8b 03                     mov    (%ebx),%eax
Code;  0000000d Before first symbol
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000010 Before first symbol
  10:   89 02                     mov    %eax,(%edx)
Code;  00000012 Before first symbol
  12:   c7 03 00 00 00 00         movl   $0x0,(%ebx)

Feb 21 18:28:42 mail kernel:  <1>Unable to handle kernel paging request at virtual address 3434343c
Feb 21 18:28:42 mail kernel: c012440f
Feb 21 18:28:42 mail kernel: Oops: 0000
Feb 21 18:28:42 mail kernel: CPU:    0
Feb 21 18:28:42 mail kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Feb 21 18:28:42 mail kernel: EFLAGS: 00010202
Feb 21 18:28:42 mail kernel: eax: 34343434   ebx: c028e2a0   ecx: c028e2a0   edx: 0003bf00
Feb 21 18:28:42 mail kernel: esi: 0003bf00   edi: c42484d4   ebp: 00000001   esp: c6b9deac
Feb 21 18:28:42 mail kernel: ds: 0018   es: 0018   ss: 0018
Feb 21 18:28:42 mail kernel: Process spamd (pid: 4256, stackpage=c6b9d000)
Feb 21 18:28:42 mail kernel: Stack: c012b550 c028e2a0 0003bf00 c77b94d8 0003bf00 c2177b40 c0121e33 0003bf00 
Feb 21 18:28:42 mail kernel:        085354dc c2177b40 00000000 c27406e0 c01221eb c2177b40 c27406e0 085354dc 
Feb 21 18:28:42 mail kernel:        c42484d4 0003bf00 00000000 c2177b40 00000000 c27406e0 085354dc c0112164 
Feb 21 18:28:42 mail kernel: Call Trace:    [lookup_swap_cache+56/80] [do_swap_page+23/224] [handle_mm_fault+99/180] [do_page_fault+352/1152] [do_page_fault+0/1152]
Feb 21 18:28:42 mail kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 


>>eax; 34343434 Before first symbol
>>ebx; c028e2a0 <swapper_space+0/40>
>>ecx; c028e2a0 <swapper_space+0/40>
>>edx; 0003bf00 Before first symbol
>>esi; 0003bf00 Before first symbol
>>edi; c42484d4 <_end+3f309a0/7da44cc>
>>esp; c6b9deac <_end+6886378/7da44cc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 48 08                  cmp    %ecx,0x8(%eax)
Code;  00000003 Before first symbol
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> fffffff9 <END_OF_CODE+37d72c7a/????>
Code;  00000005 Before first symbol
   5:   39 50 0c                  cmp    %edx,0xc(%eax)
Code;  00000008 Before first symbol
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> fffffff9 <END_OF_CODE+37d72c7a/????>
Code;  0000000a Before first symbol
   a:   85 c0                     test   %eax,%eax
Code;  0000000c Before first symbol
   c:   74 03                     je     11 <_EIP+0x11> 00000011 Before first symbol
Code;  0000000e Before first symbol
   e:   ff 40 14                  incl   0x14(%eax)
Code;  00000011 Before first symbol
  11:   c3                        ret    
Code;  00000012 Before first symbol
  12:   8d 76 00                  lea    0x0(%esi),%esi

Feb 21 18:33:06 mail kernel: kernel BUG at page_alloc.c:217!
Feb 21 18:33:06 mail kernel: invalid operand: 0000
Feb 21 18:33:06 mail kernel: CPU:    0
Feb 21 18:33:06 mail kernel: EIP:    0010:[rmqueue+116/572]    Not tainted
Feb 21 18:33:06 mail kernel: EFLAGS: 00010082
Feb 21 18:33:06 mail kernel: eax: 00000034   ebx: c1000830   ecx: 00000000   edx: 0000002b
Feb 21 18:33:06 mail kernel: esi: c1000830   edi: 00000000   ebp: c028e320   esp: c4c43e50
Feb 21 18:33:06 mail kernel: ds: 0018   es: 0018   ss: 0018
Feb 21 18:33:06 mail kernel: Process freespace.monit (pid: 4284, stackpage=c4c43000)
Feb 21 18:33:06 mail kernel: Stack: c028e564 000001df 00000001 00000000 00000001 00000a6e 00000286 c028e338 
Feb 21 18:33:06 mail kernel:        00000000 c028e320 c012afa0 000001d2 c76c9bc0 00000001 c76c9bc0 c028e3d4 
Feb 21 18:33:06 mail kernel:        c028e55c 000001d2 00000000 c012ad96 00104025 c0121f30 0815f004 c76c9bc0 
Feb 21 18:33:06 mail kernel: Call Trace:    [__alloc_pages+64/352] [_alloc_pages+22/24] [do_anonymous_page+52/228] [do_no_page+51/424] [handle_mm_fault+82/180]
Feb 21 18:33:06 mail kernel: Code: 0f 0b d9 00 b0 27 24 c0 8b 53 04 8b 03 89 50 04 89 02 c7 03 


>>ebx; c1000830 <_end+ce8cfc/7da44cc>
>>esi; c1000830 <_end+ce8cfc/7da44cc>
>>ebp; c028e320 <contig_page_data+0/340>
>>esp; c4c43e50 <_end+492c31c/7da44cc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   d9 00                     flds   (%eax)
Code;  00000004 Before first symbol
   4:   b0 27                     mov    $0x27,%al
Code;  00000006 Before first symbol
   6:   24 c0                     and    $0xc0,%al
Code;  00000008 Before first symbol
   8:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  0000000b Before first symbol
   b:   8b 03                     mov    (%ebx),%eax
Code;  0000000d Before first symbol
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000010 Before first symbol
  10:   89 02                     mov    %eax,(%edx)
Code;  00000012 Before first symbol
  12:   c7 03 00 00 00 00         movl   $0x0,(%ebx)


1 warning issued.  Results may not be reliable.


[6.] A small shell script or example program which triggers the
     problem (if possible)
None Available.


[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

   * Kernel Build Environment:
   (We build our kernels on one machine, then export them to others.)

Linux linux01 2.4.19 #1 Tue Dec 31 13:58:27 EST 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         ipsec ipchains


[7.1.] Software (add the output of the ver_linux script here)

   * Kernel Run Environment:

Linux mail 2.4.20 #1 Tue Jan 28 16:23:54 EST 2003 i686 unknown
 
Gnu C                  command
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ipt_REDIRECT ipt_state ipt_multiport ipt_TOS
ipt_MASQUERADE ipt_REJECT ipt_LOG ip_nat_ftp ip_conntrack_ftp iptable_nat
ip_conntrack iptable_mangle iptable_filter ip_tables ipsec


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 902.075
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1795.68


[7.3.] Module information (from /proc/modules):

ipt_REDIRECT             896   2 (autoclean)
ipt_state                672   3
ipt_multiport            768   0 (unused)
ipt_TOS                 1152   0 (unused)
ipt_MASQUERADE          1312   1
ipt_REJECT              2880  13
ipt_LOG                 3232  10
ip_nat_ftp              2912   0 (unused)
ip_conntrack_ftp        3840   1
iptable_nat            14484   2 [ipt_REDIRECT ipt_MASQUERADE
ip_nat_ftp]
ip_conntrack           17036   3 [ipt_REDIRECT ipt_state ipt_MASQUERADE
ip_nat_ftp ip_conntrack_ftp iptable_nat]
iptable_mangle          2272   0 (unused)
iptable_filter          1792   1
ip_tables              10464  12 [ipt_REDIRECT ipt_state ipt_multiport
ipt_TOS ipt_MASQUERADE ipt_REJECT ipt_LOG iptable_nat iptable_mangle
iptable_filter]
ipsec                 236032   2

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

   * /proc/ioports: 

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
a400-a4ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit (#2)
  a400-a4ff : dmfe
a800-a8ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  a800-a8ff : dmfe
b000-b003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
b400-b403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
b800-b8ff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
d000-d01f : VIA Technologies, Inc. USB (#2)
d400-d41f : VIA Technologies, Inc. USB
d800-d80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e200-e27f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

   * /proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-077fbfff : System RAM
  00100000-0023b0fd : Kernel code
  0023b0fe-002c6c9f : Kernel data
077fc000-077fefff : ACPI Tables
077ff000-077fffff : ACPI Non-volatile Storage
f5000000-f50000ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
(#2)
  f5000000-f50000ff : dmfe
f5800000-f58000ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  f5800000-f58000ff : dmfe
f6000000-f7dfffff : PCI Bus #01
  f6000000-f67fffff : Trident Microsystems CyberBlade/i1
  f6800000-f681ffff : Trident Microsystems CyberBlade/i1
  f7000000-f77fffff : Trident Microsystems CyberBlade/i1
f7f00000-f7ffffff : PCI Bus #01
f8000000-fbffffff : VIA Technologies, Inc. VT8601 [Apollo ProMedia]
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
	Subsystem: Asustek Computer, Inc.: Unknown device 806e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: f6000000-f7dfffff
	Prefetchable memory behind bridge: f7f00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 806e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at b800 [size=256]
	Region 1: I/O ports at b400 [size=4]
	Region 2: I/O ports at b000 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
	Subsystem: Unknown device 3030:5032
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (5000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at f5800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
	Subsystem: Unknown device 3030:5032
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (5000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a400 [size=256]
	Region 1: Memory at f5000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 6a) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 806e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f7000000 (32-bit, non-prefetchable) [size=8M]
	Region 1: Memory at f6800000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at f6000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at f7ff0000 [disabled] [size=64K]
	Capabilities: [80] AGP version 1.0
		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

   None Available.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

   Standard 2.4.20 kernel patched with FreeS/WAN IPSEC implementation from 
   ftp://ftp.xs4all.nl/pub/crypto/freeswan/freeswan-1.99.tar.gz

   Standard 2.4.20 kernel patched with lm-sensors patches from 
   http://home.attbi.com/~ac9410/albert/patches/2.4.20-i2c_sensors.tar.gz

[X.] Other notes, patches, fixes, workarounds:

   We noticed an apparent memory leak with the 2.4.19 kernel as well as
   the 2.4.20 kernel - attempts at tracing the problem have failed.



-- 
Timothy Peeler <thp@LinuxForce.net>
Senior Programmer, Systems Administrator
LinuxForce Inc.        (http://www.LinuxForce.net)
AdminForce Remote LLC. (http://www.AdminForce.net)
