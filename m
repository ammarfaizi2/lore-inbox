Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273831AbRJQCAO>; Tue, 16 Oct 2001 22:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273888AbRJQCAF>; Tue, 16 Oct 2001 22:00:05 -0400
Received: from mamona.cetuc.puc-rio.br ([139.82.74.4]:36553 "EHLO
	mamona.cetuc.puc-rio.br") by vger.kernel.org with ESMTP
	id <S273831AbRJQB74>; Tue, 16 Oct 2001 21:59:56 -0400
Message-ID: <63253.200.224.138.37.1003284435.squirrel@mamona.cetuc.puc-rio.br>
Date: Wed, 17 Oct 2001 00:07:15 -0200 (BRST)
Subject: PROBLEM: oops in scsi with preempt patch
From: "Marcelo Roberto Jimenez" <mroberto@cetuc.puc-rio.br>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having an oops on initialization of the system, apparently on scsi or sb. The problem only appears with the preempt patched kernels, either AC or Linus.

Kernel version:
Linux version 2.4.12-ac2prempt (root@phoenix.inx.com.br) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #2 Mon Oct 15 19:20:37 BRST 2001

ksymoops 2.4.3 on i686 2.4.12-ac2prempt.  Options used
     -v /usr/src/linux-2.4.12/ac2-preempt/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-ac2prempt/ (default)
     -m /usr/src/linux-2.4.12/ac2-preempt/linux/System.map (specified)

Output of oops: 
Oct 16 23:07:24 phoenix kernel: cpu: 0, clocks: 664796, slice: 332398
Oct 16 23:07:30 phoenix kernel: Unable to handle kernel paging request at virtual address c89b1b71
Oct 16 23:07:30 phoenix kernel: c89b1b71
Oct 16 23:07:30 phoenix kernel: *pde = 01282067
Oct 16 23:07:30 phoenix kernel: Oops: 0000
Oct 16 23:07:30 phoenix kernel: CPU:    0
Oct 16 23:07:30 phoenix kernel: EIP:    0010:[sound:num_midis_Ra1eae7cf+874345/85647335]    Not tainted
Oct 16 23:07:30 phoenix kernel: EIP:    0010:[<c89b1b71>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 16 23:07:30 phoenix kernel: EFLAGS: 00010296
Oct 16 23:07:31 phoenix kernel: eax: c729c000   ebx: c7683000   ecx: c7347f3c   edx: c89b81e3
Oct 16 23:07:31 phoenix kernel: esi: c729c000   edi: c7683000   ebp: c89c46a0   esp: c729dfa8
Oct 16 23:07:31 phoenix kernel: ds: 0018   es: 0018   ss: 0018
Oct 16 23:07:31 phoenix kernel: Process scsi_eh_0 (pid: 228, stackpage=c729d000)
Oct 16 23:07:31 phoenix kernel: Stack: 00000000 00000000 00000000 c729dfd4 c729dfd4 c0106eee c76d0000 00000100
Oct 16 23:07:31 phoenix kernel:        00000000 00000000 00000000 c729dfd4 c729dfd4 00000000 c0120018 00000018
Oct 16 23:07:31 phoenix kernel:        00000100 c734beb4 c01055a6 c7683000 c89ac9f0 c734bef0
Oct 16 23:07:31 phoenix kernel: Call Trace: [ret_from_fork+6/32] [timer_bh+296/736] [kernel_thread+38/48]
Oct 16 23:07:31 phoenix kernel: Call Trace: [<c0106eee>] [<c0120018>] [<c01055a6>]
Oct 16 23:07:32 phoenix kernel: Code:  Bad EIP value.
 
>>EIP; c89b1b70 <END_OF_CODE+c3e52/????>   <=====
Trace; c0106eee <ret_from_fork+6/20>
Trace; c0120018 <timer_bh+128/2e0>
Trace; c01055a6 <kernel_thread+26/30>

[root@phoenix preempt]# cat verlinux.txt
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux phoenix.inx.com.br 2.4.12-ac2prempt #2 Mon Oct 15 19:20:37 BRST 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11b
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         aha152x sr_mod scsi_mod sb sb_lib uart401 sound soundcore

[root@phoenix preempt]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 3
cpu MHz         : 299.153
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx
bogomips        : 596.37

[root@phoenix preempt]# cat /proc/modules
aha152x                31280   1 (autoclean)
sr_mod                 11904   1 (autoclean)
scsi_mod               83632   2 (autoclean) [aha152x sr_mod]
sb                      7536   0
sb_lib                 34352   0 [sb]
uart401                 6160   0 [sb_lib]
sound                  55520   0 [sb_lib uart401]
soundcore               3792   5 [sb_lib sound]

[root@phoenix preempt]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0140-015f : aha152x
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
0290-0297 : PnPBIOS PNP0c02
02e8-02ef : serial(auto)
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
ff20-ff3f : Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II]
  ff20-ff3f : usb-uhci
ff40-ff5f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  ff40-ff5f : ne2k-pci
ff80-ff9f : Realtek Semiconductor Co., Ltd. RTL-8029(AS) (#2)
  ff80-ff9f : ne2k-pci
ffa0-ffaf : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

[root@phoenix preempt]# cat /proc/iomem
00000000-0009fbff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00242341 : Kernel code
  00242342-00299c9f : Kernel data
f8000000-fbffffff : S3 Inc. 86c988 [ViRGE/VX]
fff80000-ffffffff : reserved

00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II] (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ff20 [size=32]

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at ff40 [size=32]

00:0f.0 VGA compatible controller: S3 Inc. 86c988 [ViRGE/VX] (rev 02) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at ff80 [size=32]

[root@phoenix preempt]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: MATSHITA Model: CD-R   CW-7502   Rev: 4.17
  Type:   CD-ROM                           ANSI SCSI revision: 02


Hope that s all you need.

Regards,

Marcelo Jimenez.


