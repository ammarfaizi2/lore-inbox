Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTDFKa4 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbTDFKa4 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:30:56 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:55376 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262906AbTDFKav convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 06:30:51 -0400
Message-Id: <5.1.0.14.2.20030406124921.02bfeac0@mail.flashmail.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 06 Apr 2003 12:54:42 +0200
To: linux-kernel@vger.kernel.org
From: Theodoor Scholte <t.a.h.scholte@student.utwente.nl>
Subject: Crash of the computer while running Linux kernel 2.4.18,
  2.4.19, 2.4.20
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My computer has some problems running Linux kernel 2.4.18. The kernel 
crashes after some time, usually after 4 to 25 days uptime. The same 
problems arise when I’m trying to run kernel 2.4.19 or kernel 2.4.20.

Before the computer is crashing, syslogd writes some oops-messages 
(hexadecimal code) to my /var/log/messages.
I traced the oops-messages with ksymoops. It also happened that the machine 
wasn't able to write the message to the logs and that the messages appeared 
on the standard output.

Ksymoops returned the following information:

[root@uno lib]# ksymoops
ksymoops 2.4.4 on i686 2.4.18.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.18/ (default)
      -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/aic7xxx.o for module aic7xxx has 
changed since load
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base 
says c01b4b20, System.map says c01502c0.  Ignoring ksyms_base
entry
Reading Oops report from the terminal
Apr  2 05:20:01 uno kernel: Unable to handle kernel paging request at 
virtual address 00b79470
Apr  2 05:20:01 uno kernel:  printing eip:
Apr  2 05:20:01 uno kernel: c013239a
Apr  2 05:20:01 uno kernel: *pde = 00000000
Apr  2 05:20:01 uno kernel: Oops: 0002
Apr  2 05:20:01 uno kernel: CPU:    0
Apr  2 05:20:01 uno kernel: EIP:    0010:[<c013239a>]    Not tainted
Apr  2 05:20:01 uno kernel: EFLAGS: 00010246
Apr  2 05:20:01 uno kernel: eax: 00b79470   ebx: ca55ddc0   ecx: 
ca55ddc0   edx: d648c7c0
Apr  2 05:20:01 uno kernel: esi: 00807380   edi: d0fb2140   ebp: 
cc923640   esp: d3ff1f70
Apr  2 05:20:01 uno kernel: ds: 0018   es: 0018   ss: 0018
Apr  2 05:20:01 uno kernel: Process rateup (pid: 1221, stackpage=d3ff1000)
Apr  2 05:20:01 uno kernel: Stack: ca55ddc0 ffffffea 00001000 00000000 
ca55ddc0 00000000 00000000 bffff9f8
Apr  2 05:20:01 uno kernel:        c01312e2 ca55ddc0 c61b5040 00000000 
ca55ddc0 00000000 ca55ddc0 0808c480
Apr  2 05:20:01 uno kernel:        c0131333 ca55ddc0 c61b5040 d3ff0000 
c0106f0b 00000003 00000003 4213030c
Apr  2 05:20:01 uno kernel: Call Trace: [<c01312e2>] [<c0131333>] [<c0106f0b>]
Apr  2 05:20:01 uno kernel:
Apr  2 05:20:01 uno kernel: Code: 89 10 a1 14 64 24 c0 89 58 04 89 03 c7 43 
04 14 64 24 c0 ff

…
<cut 3 or 4 times>
…

Apr  2 05:20:15 uno kernel:  <1>Unable to handle kernel paging request at 
virtual address 00b79470
Apr  2 05:20:15 uno kernel: c013239a
Apr  2 05:20:15 uno kernel: *pde = 00000000
Apr  2 05:20:15 uno kernel: Oops: 0002
Apr  2 05:20:15 uno kernel: CPU:    0
Apr  2 05:20:15 uno kernel: EIP:    0010:[<c013239a>]    Not tainted
Apr  2 05:20:15 uno kernel: EFLAGS: 00010246
Apr  2 05:20:15 uno kernel: eax: 00b79470   ebx: dd8e00c0   ecx: 
dd8e00c0   edx: dc2d56c0
Apr  2 05:20:15 uno kernel: esi: c1807380   edi: dfab9c40   ebp: 
dfa131c0   esp: c968bf28
Apr  2 05:20:15 uno kernel: ds: 0018   es: 0018   ss: 0018
Apr  2 05:20:15 uno kernel: Process mrtg (pid: 1217, stackpage=c968b000)
Apr  2 05:20:15 uno kernel: Stack: c82b8f40 c82b84c0 00001000 cfa2b9c0 
c82b84c0 00001000 cfa2b9c0 400ac000
Apr  2 05:20:15 uno kernel:        c0124137 d33cf1c0 dffc1d70 ddf2a4c0 
ddf2a4c0 00000000 cfa2b9c0 c968a000
Apr  2 05:20:15 uno kernel:        00000000 bffffdb8 c0114109 cfa2b9c0 
cfa2b9c0 c011818b cfa2b9c0 00000000
Apr  2 05:20:15 uno kernel: Call Trace: [<c0124137>] [<c0114109>] 
[<c011818b>] [<c01312e2>] [<c0112240>]
Apr  2 05:20:15 uno kernel:    [<c0106f0b>]
Apr  2 05:20:15 uno kernel: Code: 89 10 a1 14 64 24 c0 89 58 04 89 03 c7 43 
04 14 64 24 c0 ff

 >>EIP; c013239a <fput+8a/d0>   <=====
Trace; c0124137 <exit_mmap+c7/120>
Trace; c0114109 <mmput+39/60>
Trace; c011818b <do_exit+8b/1c0>
Trace; c01312e2 <filp_close+52/60>
Trace; c0112240 <do_page_fault+0/4ab>
Trace; c0106f0b <system_call+33/38>
Code;  c013239a <fput+8a/d0>
00000000 <_EIP>:
Code;  c013239a <fput+8a/d0>   <=====
    0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c013239c <fput+8c/d0>
    2:   a1 14 64 24 c0            mov    0xc0246414,%eax
Code;  c01323a1 <fput+91/d0>
    7:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c01323a4 <fput+94/d0>
    a:   89 03                     mov    %eax,(%ebx)
Code;  c01323a6 <fput+96/d0>
    c:   c7 43 04 14 64 24 c0      movl   $0xc0246414,0x4(%ebx)
Code;  c01323ad <fput+9d/d0>
   13:   ff 00                     incl   (%eax)


Further information about my Linux installation/configuration:

Kernel version
Linux version 2.4.18 (root@uno) (gcc version 2.96 20000731 (Red Hat Linux 
7.3 2.96-110)) #2 Mon Mar 10 15:32:23 CET 2003

CPU info
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 2000+
stepping        : 2
cpu MHz         : 1673.823
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3342.33

Module information
autofs                 11172   0 (autoclean) (unused)
eepro100               19472   1
st                     28692   0 (unused)
aic7xxx               118112   5

IO-ports
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
d800-d83f : Intel Corp. 82557 [Ethernet Pro 100]
   d800-d83f : eepro100
dc00-dcff : Adaptec 7892A
   dc00-dcff : aic7xxx
ff00-ff0f : VIA Technologies, Inc. Bus Master IDE

IO-mem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d1000-000d27ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
   00100000-0020b1fe : Kernel code
   0020b1ff-0025a36b : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
d9800000-dd8fffff : PCI Bus #01
   da000000-dbffffff : nVidia Corporation Vanta [NV6]
dda00000-dfafffff : PCI Bus #01
   de000000-deffffff : nVidia Corporation Vanta [NV6]
dfe00000-dfefffff : Intel Corp. 82557 [Ethernet Pro 100]
dfffe000-dfffefff : Intel Corp. 82557 [Ethernet Pro 100]
   dfffe000-dfffefff : eepro100
dffff000-dfffffff : Adaptec 7892A
   dffff000-dfffffff : aic7xxx
e0000000-e7ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

PCI devices
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: VIA Technologies, Inc. VT8367 [KT266] (rev 0).
       Master Capable.  Latency=8.
       Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
   Bus  0, device   1, function  0:
     PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (rev 0).
       Master Capable.  No bursts.  Min Gnt=12.
   Bus  0, device  10, function  0:
     Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 8).
       IRQ 5.
       Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
       Non-prefetchable 32 bit memory at 0xdfffe000 [0xdfffefff].
       I/O at 0xd800 [0xd83f].
       Non-prefetchable 32 bit memory at 0xdfe00000 [0xdfefffff].
   Bus  0, device  11, function  0:
     SCSI storage controller: Adaptec 7892A (rev 2).
       IRQ 10.
       Master Capable.  Latency=32.  Min Gnt=40.Max Lat=25.
       I/O at 0xdc00 [0xdcff].
       Non-prefetchable 64 bit memory at 0xdffff000 [0xdfffffff].
   Bus  0, device  17, function  0:
     ISA bridge: PCI device 1106:3147 (VIA Technologies, Inc.) (rev 0).
   Bus  0, device  17, function  1:
     IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
       IRQ 14.
       Master Capable.  Latency=32.
       I/O at 0xff00 [0xff0f].
   Bus  1, device   0, function  0:
     VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 21).
       IRQ 11.
       Master Capable.  Latency=32.  Min Gnt=5.Max Lat=1.
       Non-prefetchable 32 bit memory at 0xde000000 [0xdeffffff].
       Prefetchable 32 bit memory at 0xda000000 [0xdbffffff].

SCSI peripherals
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: IBM      Model: DDYS-T36950N     Rev: SA2A
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 06 Lun: 00
   Vendor: TANDBERG Model:  SLR5 4/8GB      Rev: 0913
   Type:   Sequential-Access                ANSI SCSI revision: 02

Kernel parameters (options) in grub.conf:
kernel /kernel-2.4.18custom ro root=/dev/sda5 mem=nopentium

Software
The computer runs on Red Hat 7.3 with Progress 9.1C10, Progress Webspeed, 
mrtg-2.9.25, Apache 1.3.19, Samba 2.2.7.

This problem has been appearing for over half a year now. In the meantime, 
I tried everything: compiling new kernels, adding and removing some 
parameters of the kernel without any concrete and positive results. I’ve 
also tried to run memtest86 on it, and it did not show that there were any 
errors in the main memory. I don’t think that the hardware is causing 
troubles.

Why does my kernel crash after some time? What am I doing wrong?

Thank you very much in advance for your replies.

Theodoor Scholte. 


