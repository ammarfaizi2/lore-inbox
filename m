Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbRBHLnl>; Thu, 8 Feb 2001 06:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131050AbRBHLnb>; Thu, 8 Feb 2001 06:43:31 -0500
Received: from topaz.cns.mpg.de ([194.95.183.253]:60683 "HELO mail.cns.mpg.de")
	by vger.kernel.org with SMTP id <S130431AbRBHLnY>;
	Thu, 8 Feb 2001 06:43:24 -0500
Message-ID: <3A82878B.D1E1B313@cns.mpg.de>
Date: Thu, 08 Feb 2001 12:48:27 +0100
From: Gert Wollny <wollny@cns.mpg.de>
Organization: http://www.cns.mpg.de
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugo Kohmann <hugo@dolphinics.no>, linux-bugs@nvidia.com
Cc: linux-kernel@vger.kernel.org
Subject: BUG() hit in ioremap.c(i386) with non-standart kernel modules
In-Reply-To: <Pine.GSO.4.21.0102081005440.6150-100000@sciste.dolphinics.no>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I've hit a Kernel BUG with the combination of nonstandart kernel
modules. So dear linux-kernel readers, this bug report may or may not
apply to the standart kernel. But if you have any comments, please CC
me.

We use the dolphinics psb66 clustering card and a GForce 256 graphics
card. 
We are not able to load both kernel the NVDriver (0.9-6) and the pcisci
- (DIS-Feb-07) together. 
The second one loaded always hits a kernel bug in ioremap stating the
page already exists.

The Oops reports and the machine info follow.

Thanks for your time

Gert



##########################################################################################################################
The Oops if NVdriver is loaded first, and then pcisci 
kernel: SCI Driver : Linux SMP support enabled
kernel: SCI Driver : using MTRR
kernel: PCI SCI Bridge - device id 0xd667 found
kernel: 1 supported PCI-SCI bridges (PSB's) found on the system
kernel: Define PSB 1 key: Bus:  0 DevFn: 96
kernel: Key 1: Key: (Bus:  0,DevFn: 96), Device No. 1, irq 11
kernel: Mapping address space non cacheable CSR space: phaddr d3000000
sz 131072 out of 131072
kernel: Mapping address space non cacheabel CSR space: vaddr fda41000
kernel: Mapping address space non cacheable IO space: phaddr d2000000 sz
16777216 out of 16777216
kernel: remap_area_pte: page already exists
kernel: kernel BUG at ioremap.c:29!
kernel: invalid operand: 0000
kernel: CPU:    1
kernel: EIP:    0010:[remap_area_pages+563/692]
kernel: EFLAGS: 00010286
kernel: eax: 0000001c   ebx: 00000000   ecx: c027c048   edx: 00000000
kernel: esi: 00400000   edi: c0004000   ebp: 00400000   esp: f7647dd8
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process modprobe (pid: 421, stackpage=f7647000)
kernel: Stack: c022d465 c022d585 0000001d fda62000 01000000 d2000000
00000000 00000073 
kernel:        c0101fe4 d259e000 00400000 d259e000 c0101fe0 fea62000
c0101fe0 d459e000 
kernel:        c0113583 fe000000 d2000000 01000000 00000010 f75d0000
fda0828f 00000000 
kernel: Call Trace: [<fda62000>] 
				[swapper_pg_dir+4068/4096] 
				[swapper_pg_dir+4064/4096] 
				[<fea62000>] 
				[swapper_pg_dir+4064/4096] 
				[__ioremap+207/240] 
				[<fe000000>] 
kernel: [<fda0828f>] [<fd9c3234>] [<fd9c3a8e>] [<fda30940>]
[printk+366/380] [<fda30958>] [<fd9c4001>] 
				[pcibios_find_device+69/88] 
kernel:        [<fd9c465c>] [<fda086ec>] [<fd9c464f>] [<fda086d4>]
[<fd9c2dc2>] [<fda07767>] [<fd9c2de7>] [<fd9c1000>] 
kernel:        [<fd9c1067>] 
				[free_pages+58/60] 
				[sys_init_module+1309/1528] 
				[<f88e0000>] [<fd9c1060>] 
				[system_call+51/56] 
kernel: 
kernel: Code: 0f 0b 83 c4 0c 8b 44 24 18 25 00 f0 ff ff 0b 44 24 10 89
07 

##########################################################################
the oops when the pcisci driver is loaded first, and then NVdriver 
no driver output :-(
kernel: remap_area_pte: page already exists
kernel: kernel BUG at ioremap.c:29!
kernel: invalid operand: 0000
kernel: CPU:    1
kernel: EIP:    0010:[remap_area_pages+563/692]
kernel: EFLAGS: 00013282
kernel: eax: 0000001c   ebx: 00000000   ecx: c027b808   edx: 00000000
kernel: esi: 00400000   edi: c0004000   ebp: 00400000   esp: f69ede68
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process X (pid: 3770, stackpage=f69ed000)
kernel: Stack: c022d045 c022d165 0000001d fba1d000 04000000 d8000000
00000000 00000063 
kernel:        c0101fe4 da5e3000 00400000 da5e3000 c0101fe0 ffa1d000
c0101fe0 dc5e3000 
kernel:        c0113583 fe000000 d8000000 04000000 00000000 f89601a0
04000000 f742e580 
kernel: Call Trace: [<fba1d000>] 
			[swapper_pg_dir+4068/4096]
			[swapper_pg_dir+4064/4096] [<ffa1d000>] 
			[swapper_pg_dir+4064/4096] [__ioremap+207/240] [<fe000000>] 
kernel: [<f89601a0>] [<f88e1366>] [<f89601a0>] [<f88e1589>] [<f89601a0>] 
				[permission+139/148] 
				[chrdev_open+100/172] 
				[dentry_open+189/344] 
kernel: [filp_open+82/92] 
				[sys_open+60/240] 
				[system_call+51/56] 
				[startup_32+43/203] 
kernel: 
kernel: Code: 0f 0b 83 c4 0c 8b 44 24 18 25 00 f0 ff ff 0b 44 24 10 89
07 
kernel:  printing eip:
kernel: f88e3fe4
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[<f88e3fe4>]
kernel: EFLAGS: 00013246
kernel: eax: 00000000   ebx: 00000000   ecx: d8000000   edx: f699b878
kernel: esi: ffa1e000   edi: f89601a0   ebp: f69edefc   esp: f69ededc
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process X (pid: 3772, stackpage=f69ed000)
kernel: Stack: ffa1e000 f69edef8 f89601a0 f76aadc0 00000000 f76aadc0
00000000 d8000000 
kernel:        f69edf2c f88e15b1 f89601a0 00000007 f7a08480 ffffffed
f69ec000 f7a08480 
kernel:        00000000 00000002 c013e377 f76818a0 f76aadc0 c0133f08
f76aadc0 f7a08480 
kernel: Call Trace: [<ffa1e000>] [<f89601a0>] [<f88e15b1>] [<f89601a0>]
[permission+139/148] [chrdev_open+100/172] [dentry_open+189/344] 
kernel:        [filp_open+82/92] [sys_open+60/240] [system_call+51/56] 
kernel: 
kernel: Code: 8b 83 04 18 00 00 0c 04 89 83 04 18 00 00 c7 83 40 01 60
00 
########################################################################################################################
machine-info follows:

/dev/version:
Linux version 2.4.0 (root@finnwal) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #1 SMP 

Kernel modules         2.4.0
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0i

/dev/modules:
NVdriver              609552  11 (autoclean) #version 0.9.6
rtc                     5904   0 (autoclean)

/dev/mtrr:
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0xd8000000 (3456MB), size=  32MB: write-combining, count=1
/dev/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 501.146
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 999.42

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 501.146
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 999.42

/proc/meminfo:
        total:    used:    free:  shared: buffers:  cached:
Mem:  1053474816 152285184 901189632        0  6021120 106954752
Swap: 1784668160        0 1784668160
MemTotal:      1028784 kB
MemFree:        880068 kB
MemShared:           0 kB
Buffers:          5880 kB
Cached:         104448 kB
Active:           6372 kB
Inact_dirty:    103956 kB
Inact_clean:         0 kB
Inact_target:        4 kB
HighTotal:      131060 kB
HighFree:        12396 kB
LowTotal:       897724 kB
LowFree:        867672 kB
SwapTotal:     1742840 kB
SwapFree:      1742840 kB

/proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
3).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   4, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   4, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd80f].
  Bus  0, device   4, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 15.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
  Bus  0, device   9, function  0:
    Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 48).
      IRQ 15.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xd000 [0xd07f].
      Non-prefetchable 32 bit memory at 0xd4800000 [0xd480007f].
  Bus  0, device  11, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895
(rev 2).
      IRQ 10.
      Master Capable.  Latency=72.  Min Gnt=30.Max Lat=64.
      I/O at 0xb800 [0xb8ff].
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd40000ff].
      Non-prefetchable 32 bit memory at 0xd3800000 [0xd3800fff].
  Bus  0, device  12, function  0:
    Bridge: Dolphin Interconnect Solutions AS PSB66 SCI-Adapter D33x
(rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=4.
      Non-prefetchable 32 bit memory at 0xd3000000 [0xd301ffff].
      Non-prefetchable 32 bit memory at 0xd2000000 [0xd2ffffff].
      Prefetchable 32 bit memory at 0xd6000000 [0xd6ffffff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation GeForce 256 (rev 16).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd5ffffff].
      Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
