Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130636AbQLWDDv>; Fri, 22 Dec 2000 22:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131698AbQLWDDl>; Fri, 22 Dec 2000 22:03:41 -0500
Received: from bill.trinity.unimelb.edu.au ([203.28.240.2]:61703 "HELO
	bill.trinity.unimelb.edu.au") by vger.kernel.org with SMTP
	id <S130636AbQLWDDe>; Fri, 22 Dec 2000 22:03:34 -0500
Date: Sat, 23 Dec 2000 13:33:02 +1100
From: Tim Bell <bhat@trinity.unimelb.edu.au>
To: linux-kernel@vger.kernel.org
Subject: "kernel bug at buffer.c:765" in 2.4.0-test12
Message-ID: <20001223133302.A8615@trinity.unimelb.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] One line summary of the problem:    

"kernel bug at buffer.c:765" in 2.4.0-test12

[2.] Full description of the problem/report:

While running mke2fs on a SCSI software RAID-5 array, the message "kernel
bug at buffer.c:765!" was printed, along with an oops (below).  The system
doesn't hang, but the mke2fs process is unkillable.  The problem has
occurred every time I've tried using mke2fs on the RAID device.

[3.] Keywords (i.e., modules, networking, kernel):

filesystems, raid

[4.] Kernel version (from /proc/version):

Linux version 2.4.0-test12 (root@vite) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Sat Dec 23 09:35:40 EST 2000

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c012da12>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001c   ebx: f609ce88   ecx: c028cf68   edx: 00000000
esi: f7a9c160   edi: f7a9c000   ebp: f609ce40   esp: f7da9e8c
ds: 0018   es: 0018   ss: 0018
Process raid5d (pid: 10, stackpage=f7da9000)
Stack: c0232b31 c0232e1a 000002fd 00000004 c01e0888 f609ce40 00000001 00000004 
       f7a9c000 00000001 00000000 c01e1399 f7a9c000 00000001 00000001 f7a9c000 
       f7dc8400 f7a9c000 00000004 00000004 f7dc8400 c01e1ee2 f7a9c000 f7a9c000 
Call Trace: [<c0232b31>] [<c0232e1a>] [<c01e0888>] [<c01e1399>] [<c01e1ee2>] [<c01be91c>] [<c01aefa9>] 
       [<c0114b66>] [<c01e2416>] [<c01e9176>] [<c0107404>] 
Code: 0f 0b 83 c4 0c 5b c3 8d 76 00 55 57 56 53 8b 74 24 14 8b 54 

>>EIP; c012da12 <end_buffer_io_bad+52/5c>   <=====
Trace; c0232b31 <tvecs+35bd/1c58c>
Trace; c0232e1a <tvecs+38a6/1c58c>
Trace; c01e0888 <raid5_end_buffer_io+44/84>
Trace; c01e1399 <complete_stripe+9d/11c>
Trace; c01e1ee2 <handle_stripe+14a/428>
Trace; c01be91c <sym53c8xx_queue_command+54/90>
Trace; c01aefa9 <scsi_dispatch_cmd+10d/150>
Trace; c0114b66 <schedule+26a/394>
Trace; c01e2416 <raid5d+8a/cc>
Trace; c01e9176 <md_thread+fa/190>
Trace; c0107404 <kernel_thread+28/38>
Code;  c012da12 <end_buffer_io_bad+52/5c>
00000000 <_EIP>:
Code;  c012da12 <end_buffer_io_bad+52/5c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012da14 <end_buffer_io_bad+54/5c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012da17 <end_buffer_io_bad+57/5c>
   5:   5b                        pop    %ebx
Code;  c012da18 <end_buffer_io_bad+58/5c>
   6:   c3                        ret    
Code;  c012da19 <end_buffer_io_bad+59/5c>
   7:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c012da1c <end_buffer_io_async+0/f4>
   a:   55                        push   %ebp
Code;  c012da1d <end_buffer_io_async+1/f4>
   b:   57                        push   %edi
Code;  c012da1e <end_buffer_io_async+2/f4>
   c:   56                        push   %esi
Code;  c012da1f <end_buffer_io_async+3/f4>
   d:   53                        push   %ebx
Code;  c012da20 <end_buffer_io_async+4/f4>
   e:   8b 74 24 14               mov    0x14(%esp,1),%esi
Code;  c012da24 <end_buffer_io_async+8/f4>
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx

[6.] A small shell script or example program which triggers the
     problem (if possible)

The command which triggered it was:
mke2fs -m 0 -b 4096 -R stride=32 /dev/md0

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux vite 2.4.0-test12 #1 Sat Dec 23 09:35:40 EST 2000 i686 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 800.070
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 3
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1595.80

[7.3.] Module information (from /proc/modules):

[no modules]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(set)
0500-0503 : acpi
0504-0505 : acpi
0508-050b : acpi
0514-051b : acpi
0540-0543 : acpi
0544-0545 : acpi
0550-0557 : acpi
0cf8-0cff : PCI conf1
d000-d03f : Intel Corporation 82557 [Ethernet Pro 100]
  d000-d03f : eepro100
d400-d43f : Intel Corporation 82557 [Ethernet Pro 100] (#2)
  d400-d43f : eepro100
d800-d8ff : ATI Technologies Inc Rage XL
e400-e4ff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter
  e400-e4ff : sym53c8xx
e800-e8ff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter (#2)
  e800-e8ff : sym53c8xx
ffa0-ffaf : PCI device 1166:0211 (ServerWorks)
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
  00100000-0028a7af : Kernel code
  0028a7b0-002a3343 : Kernel data
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe800000-fe8fffff : Intel Corporation 82557 [Ethernet Pro 100]
fe900000-fe9fffff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
feafc000-feafcfff : Intel Corporation 82557 [Ethernet Pro 100]
  feafc000-feafcfff : eepro100
feafd000-feafdfff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
  feafd000-feafdfff : eepro100
feafe000-feafefff : PCI device 1166:0220 (ServerWorks)
feaff000-feafffff : ATI Technologies Inc Rage XL
febfa000-febfbfff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter
febfc000-febfdfff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter (#2)
febff800-febffbff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter
febffc00-febfffff : Symbios Logic Inc. (formerly NCR) 53c1010 Ultra3 SCSI Adapter (#2)

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set, cache line size 08

00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 set, cache line size 08

00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Asustek Computer, Inc.: Unknown device 1043
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 56 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at feafc000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d000 [size=64]
	Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe700000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation: Unknown device 1030
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 56 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at feafd000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d400 [size=64]
	Region 2: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:07.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4752 (rev 65) (prog-if 00 [VGA])
	Subsystem: Gateway 2000: Unknown device 6400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 64 set, cache line size 08
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 4f)
	Subsystem: Relience Computer: Unknown device 0200
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at ffa0 [size=16]

00:0f.2 USB Controller: Relience Computer: Unknown device 0220 (rev 04) (prog-if 10 [OHCI])
	Subsystem: Relience Computer: Unknown device 0220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]

01:05.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0020 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 17 min, 18 max, 72 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at febff800 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at febfa000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0020 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 17 min, 18 max, 72 set, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at febffc00 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at febfc000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DPSS-309170N     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: ARCHIVE  Model: Python 06240-XXX Rev: 8040
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DDYS-T18350M     Rev: S93E
  Type:   Direct-Access                    ANSI SCSI revision: 03

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Bug triggered by both mke2fs 1.18 and 1.19.

/etc/raidtab:
raiddev /dev/md0
	raid-level      5
	nr-raid-disks   4
	nr-spare-disks  0
	persistent-superblock 1
	parity-algorithm        left-symmetric
	chunk-size      128
	device          /dev/sdb1
	raid-disk       0
	device          /dev/sdc1
	raid-disk       1
	device          /dev/sdd1
	raid-disk       2
	device          /dev/sde1
	raid-disk       3

Thanks in advance...

Tim.
-- 
Tim Bell - bhat@trinity.unimelb.edu.au - System Administrator & Programmer
    Trinity College, Royal Parade, Parkville, Victoria, 3052, Australia
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
