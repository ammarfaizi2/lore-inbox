Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTFFAI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 20:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbTFFAI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 20:08:57 -0400
Received: from mailadmin.live365.com ([216.235.80.39]:59662 "EHLO
	mailadmin.live365.com") by vger.kernel.org with ESMTP
	id S265261AbTFFAIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 20:08:51 -0400
Message-ID: <3EDFDDBA.2060706@live365.com>
Date: Thu, 05 Jun 2003 17:18:02 -0700
From: "John E. Leon Guerrero" <jguerrero@live365.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:  2.4.20 os hang when accessing local ide harddrive
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello folks, please let me know who i should be directing this to :)

thanks in advance,
jlg


[1.] One line summary of the problem:
entire 2.4.20 operating system hangs when accessing ide hard drive

[2.] Full description of the problem/report:
my root file system is on /dev/sda3.  i have /dev/hda1 & /dev/hdd1 
mounted on /u01 & /u02 respectively with ext2 filesystems on everything. 
  occasionally, i will try to access something on one of these 
filesystems and the entire operating system will freeze.  this includes 
the kde xwindows environment as well as ssh sessions that have no open 
file descriptors on /u01 & /u02.  when this happens, i notice the 
machine's ide hard drive light is stuck on...no flashing...just on 
solid.  when this typically happens, the machine will have been idle for 
a long time but all process not touching /u01 & /u02 are working just 
fine.  after one of these hangs happens and i reboot the machine, then 
accessing the ide hard drives works just fine.

i *do* believe the root problem involves hardware...however, i expect 
that the hanging behavior should be limited to only the processes trying 
to access the ide hard drives and not the ones that have been running 
fine off the root scsi drive.  similarly, i've seen this once before on 
a completely different machine where there was some problem with the 
floppy in the floppy drive.  again, the entire machine hung in that 
instance.

i built the kernel using the standard tools from a stable debian woody 
installation.  the full 2.4.20 source was downloaded from kernel.org.

[3.] Keywords (i.e., modules, networking, kernel):
hang, ide, hard drive

[4.] Kernel version (from /proc/version):
Linux version 2.4.20 (root@debianjlg) (gcc version 2.95.4 20011002 
(Debian prerelease)) #1 SMP Thu Apr 24 15:29:05 PDT 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
i have not seen any Oops messages anywhere (/var/log/messages, syslog)

[6.] A small shell script or example program which triggers the
      problem (if possible)
cd /u01

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux debianjlg 2.4.20 #1 SMP Thu Apr 24 15:29:05 PDT 2003 i686 unknown 
unknown GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.21
e2fsprogs              1.33
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.8
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         ext3 jbd 3c59x sb sb_lib uart401 sound

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 300.688
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov mmx
bogomips        : 599.65

[7.3.] Module information (from /proc/modules):
ext3                   59936   0 (autoclean)
jbd                    39144   0 (autoclean) [ext3]
3c59x                  25736   1 (autoclean)
sb                      7360   1
sb_lib                 33280   0 [sb]
uart401                 6112   0 [sb_lib]
sound                  55948   1 [sb_lib uart401]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(set)
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
b800-b87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
   b800-b87f : 00:0a.0
d000-d0ff : Adaptec AHA-2940U2/U2W / 7890/7891
   d000-d0fe : aic7xxx
d400-d41f : Intel Corp. 82371AB/EB/MB PIIX4 USB
   d400-d41f : usb-uhci
d800-d80f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
   d800-d807 : ide0
   d808-d80f : ide1
e400-e43f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
e800-e81f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0dffcfff : System RAM
   00100000-0027ef60 : Kernel code
   0027ef61-0032447f : Kernel data
0dffd000-0dffefff : ACPI Tables
0dfff000-0dffffff : ACPI Non-volatile Storage
de000000-de00007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
de800000-de800fff : Adaptec AHA-2940U2/U2W / 7890/7891
df000000-dfffffff : PCI Bus #01
   df000000-dfffffff : nVidia Corporation RIVA TNT2 Model 64
e0000000-e0007fff : US Robotics/3Com WinModem
e0800000-e080ffff : US Robotics/3Com WinModem
e1000000-e100003f : US Robotics/3Com WinModem
e1f00000-e3ffffff : PCI Bus #01
   e2000000-e3ffffff : nVidia Corporation RIVA TNT2 Model 64
e4000000-e7ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 02)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000e000-0000dfff
         Memory behind bridge: df000000-dfffffff
         Prefetchable memory behind bridge: e1f00000-e3ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin D routed to IRQ 9
         Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
         Subsystem: Adaptec 2940U2W SCSI Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (9750ns min, 6250ns max), cache line size 08
         Interrupt: pin A routed to IRQ 9
         BIST result: 00
         Region 0: I/O ports at d000 [size=256]
         Region 1: Memory at de800000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at b800 [size=128]
         Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Communication controller: US Robotics/3Com WinModem
         Subsystem: US Robotics/3Com: Unknown device 005d
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at e1000000 (32-bit, prefetchable) [size=64]
         Region 1: Memory at e0800000 (32-bit, prefetchable) [size=64K]
         Region 2: Memory at e0000000 (32-bit, prefetchable) [size=32K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=6 DScale=2 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 
Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
         Subsystem: nVidia Corporation: Unknown device 0001
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at e2000000 (32-bit, prefetchable) [size=32M]
         Expansion ROM at e1ff0000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: QUANTUM  Model: VIKING II 4.5WLS Rev: 4110
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
   Vendor: TOSHIBA  Model: XM6201TASUN32XCD Rev: 1103
   Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):


[X.] Other notes, patches, fixes, workarounds:
no patches applied.
debian version has been upgraded to sarge and the latest kde.  however, 
the kernel was built before that upgrade using debian woody.

no workaround.

i boot from floppy using syslinux.
there is a windows 2000 installation on the scsi drive which the machine 
will boot into if i do not use the floppy.  i haven't used the windows 
2000 installation in about 5 months.

i will be upgrading the root filesystem to ext3 (to lessen the chance of 
system hangs from corrupting the root filesystem) but leaving the ide 
hard drives on ext2 if that helps debug the problem.

it would be my pleasure to help debug this in anyway that i can.  i love 
linux and look forward to my chance to help out.

