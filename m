Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQKSR6Z>; Sun, 19 Nov 2000 12:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129157AbQKSR6O>; Sun, 19 Nov 2000 12:58:14 -0500
Received: from pausch-111.htp-tel.de ([212.59.61.111]:10624 "EHLO
	pausch-111.htp-tel.de") by vger.kernel.org with ESMTP
	id <S129249AbQKSR54>; Sun, 19 Nov 2000 12:57:56 -0500
From: Peter Rottengatter <peter@rottengatter.de>
To: linux-kernel@vger.kernel.org
Cc: perot@arisia.rottengatter.de
Reply-To: peter@rottengatter.de
Subject: PROBLEM: 3c509 driver broken in 2.4.0-test10, not in -test9
Date: Sun, 19 Nov 2000 18:27:50 +0100 (CET)
X-Mailer: XCmail 1.2 - with PGP support, PGP engine version 0.5 (Linux)
X-Mailerorigin: http://www.fsai.fh-trier.de/~schmitzj/Xclasses/XCmail/
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <E13xYFr-0000FO-00@pausch-111.htp-tel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for using this address, there does not appear to be a special maintainer
for the 3c509 network driver.

1.
3c509 driver broken in 2.4.0-test10, not in -test9

2.
The 3c509 network driver worked fine for decades almost ;-) that is 2.0.x,
2.2.x, and 2.4.0-test up to 9. In 2.4.0-test10 it ooooopes upon modprobing.
lsmod says "initializing" in the 3c509 entry, forever.

3.
3c509, 3C509, Ethernet, networking, 2.4.0-test10

4. 
Linux version 2.4.0-test10
compiled by root@arisia (#3 Fri Nov 17 22:37:22 CET 2000)
using gcc version 2.95.2 20000220 (Debian GNU/Linux)

5.
Nov 19 17:26:37 arisia kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000070
Nov 19 17:26:37 arisia kernel:  printing eip:
Nov 19 17:26:37 arisia kernel: ca8e635c
Nov 19 17:26:37 arisia kernel: *pde = 00000000
Nov 19 17:26:37 arisia kernel: Oops: 0002
Nov 19 17:26:37 arisia kernel: CPU:    0
Nov 19 17:26:37 arisia kernel: EIP:    0010:[sg:sg_big_buff+484244/85376260]
Nov 19 17:26:37 arisia kernel: EFLAGS: 00010202
Nov 19 17:26:37 arisia kernel: eax: 2e976000   ebx: 00000004   ecx: c01fd8f0   edx: 00000070
Nov 19 17:26:37 arisia kernel: esi: 00000003   edi: 00000300   ebp: c6d57f3c   esp: c6d57f0c
Nov 19 17:26:37 arisia kernel: ds: 0018   es: 0018   ss: 0018
Nov 19 17:26:37 arisia kernel: Process modprobe (pid: 448, stackpage=c6d57000)
Nov 19 17:26:37 arisia kernel: Stack: 00000000 00000000 ca8e604e ca8e6048 c6d57f2c 00000070 00000003 0000000f
Nov 19 17:26:37 arisia kernel:        ca8e604e ca8e6048 c1044010 c01fea6c 2e976000 fffff987 ca8e6fb9 00000000
Nov 19 17:26:37 arisia kernel:        ca8e6000 00000000 c011689b c6d56000 400279c8 bfffdf94 bfffdf54 c6078000
Nov 19 17:26:37 arisia kernel: Call Trace: [sg:sg_big_buff+483462/85377042] [sg:sg_big_buff+483456/85377048] [sg:sg_big_buff+483462/85377042] [sg:sg_big_buff+483456/85377048] [sg:sg_big_buff+487409/85373095] [sg:sg_big_buff+483384/85377120] [sys_init_module+979/1104]
Nov 19 17:26:37 arisia kernel:        [sg:sg_big_buff+446520/85413984] [sg:sg_big_buff+483456/85377048] [system_call+51/64]
Nov 19 17:26:37 arisia kernel: Code: 89 02 8b 44 24 34 66 89 42 04 8b 44 24 3c 89 78 20 8b 54 24

ksymoops adds:

Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 02                     mov    %eax,(%edx)
Code;  00000002 Before first symbol
   2:   8b 44 24 34               mov    0x34(%esp,1),%eax   
Code;  00000006 Before first symbol
   6:   66 89 42 04               mov    %ax,0x4(%edx)
Code;  0000000a Before first symbol
   a:   8b 44 24 3c               mov    0x3c(%esp,1),%eax
Code;  0000000e Before first symbol
   e:   89 78 20                  mov    %edi,0x20(%eax)
Code;  00000011 Before first symbol
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx

6.
Just issue "modprobe 3c509" like this:
# modprobe 3c509
Segmentation fault
# lsmod
Module                  Size  Used by
3c509                   5920   1  (initializing)
af_packet               7904   0  (autoclean)
parport_pc             13280   1  (autoclean)
lp                      4464   0  (autoclean)
parport                14848   1  (autoclean) [parport_pc lp]
hisax                 143760   5
ramfs                   2208   1  (autoclean)
serial                 40816   0  (autoclean)
opl3                   11088   0  (unused)
sb                      1744   0
sb_lib                 33328   0  [sb]
uart401                 6224   0  [sb_lib]
sound                  55648   0  [opl3 sb_lib uart401]
sg                     20960   0  (unused)
slip                    6080   0  (unused)
dummy                   1152   1   
isdn                  102704   6  [hisax]
ipv6                  115120  -1   
binfmt_misc             3296   0

7.
7.1
# sh /usr/src/linux/scripts/ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux arisia 2.4.0-test10 #3 Fri Nov 17 22:37:22 CET 2000 i586 unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Gnu Make               3.78.1
Binutils               2.9.5.0.37
Linux C Library        2.1.95
Dynamic linker         ldd (GNU libc) 2.1.95
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         3c509 af_packet parport_pc lp parport hisax ramfs
serial opl3 sb sb_lib uart401 sound sg slip dummy isdn ipv6 binfmt_misc

7.2
# cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 9
model name      : AMD-K6(tm) 3D+ Processor
stepping        : 1
cpu MHz         : 400.000915
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
bogomips        : 799.54

7.3
see 6.

7.4
# cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0160-0167 : elsa isdn
0220-022f : soundblaster
02f8-02ff : serial(set)
0300-030f : 3c509
0330-0333 : MPU-401 UART
0378-037a : parport0
0388-038b : Yamaha OPL3
03c0-03df : vga+
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
e000-e0ff : Adaptec AIC-7880U
  e000-e0fe : aic7xxx
e800-e80f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
# cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-09ffffff : System RAM
  00100000-001fb99f : Kernel code
  001fb9a0-0020b1db : Kernel data
e5800000-e5803fff : Matrox Graphics, Inc. MGA 2064W [Millennium]
e6000000-e6000fff : Adaptec AIC-7880U
e7000000-e77fffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
ffff0000-ffffffff : reserved
# cat /proc/interrupts
           CPU0       
  0:     312319          XT-PIC  timer
  1:      12472          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:         19          XT-PIC  soundblaster
  7:          0          XT-PIC  parport0
  9:       5903          XT-PIC  aic7xxx
 11:         17          XT-PIC  HiSax
 12:      65163          XT-PIC  PS/2 Mouse
 13:          0          XT-PIC  fpu
NMI:          0 
ERR:          0

7.5
# lspci -vvv
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 set

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 4: I/O ports at e800 [disabled] [size=16]

00:09.0 SCSI storage controller: Adaptec AIC-7880U
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=16K]
        Region 1: Memory at e7000000 (32-bit, prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

7.6
# cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-309170      Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DORS-32160       Rev: WA6A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: J.03
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TEAC     Model: CD-R55S          Rev: 1.0J
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DR-124X   Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02

7.7
eth0 was not installed by the driver, ifconfig does not find it.

X.
Three notes.

I thought the 3c509 driver would very rarely see any changes. Apparently a
recent one broke it, since with -test9 all was ok.

The 3c509 is configured to use interrupt 15. Both IDE channels are
disabled in the BIOS, IDE support is _not_ compiled into the kernel.
In 7.4 you can see the interrupt was not registered by the driver.

The 7.4 /proc/ioports output shows a line that puzzles me: 
> Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
I suppose this means parts of the chipset. However I use an old Asus
P55T2P4 mainboard with the 430HX chipset. I believe Natoma/Triton was a
lot later ? So I wonder if the chipset recognition is faulty. After
writing this up, I will reboot with -test9 and check what it recognized
then. I'll add a sequel to this mail if it's different.

Cheers  Peter



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
