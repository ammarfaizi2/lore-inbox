Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271712AbRI0HoK>; Thu, 27 Sep 2001 03:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271825AbRI0HoB>; Thu, 27 Sep 2001 03:44:01 -0400
Received: from cpe.atm0-0-0-116231.albnxx4.customer.tele.dk ([193.89.241.184]:48464
	"EHLO calithturon.fanitas.com") by vger.kernel.org with ESMTP
	id <S271712AbRI0Hny>; Thu, 27 Sep 2001 03:43:54 -0400
Message-Id: <200109270747.f8R7lEP04226@calithturon.fanitas.com>
Content-Type: text/plain; charset=US-ASCII
From: Morten Green Hermansen <mortengh@fanitas.com>
Organization: Fanitas
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Mounting /dev/hdh1 deletes /dev/hda1
Date: Thu, 27 Sep 2001 09:42:36 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
-- (I'M NOT ON THE MAILINGLIST SO PLEASE CC ME)
--

1. Mounting /dev/hdh1 deletes /dev/hda1

2. I have inserted a new PCI based IDE adapter so I am able to use 8 IDE 
disks. When mounting them one of the disks on the second controller 
over-shadows a disk on the first (build-in)

See following trace:

[root@calithturon scripts]# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda1              3111408   2448976    504380  83% /
/dev/hdc1              4134900   2703864   1220988  69% /home
/dev/hdc2              4134932    817688   3107196  21% /usr/local/packages
/dev/hdc3              1565424   1002960    562464  65% /mnt/files
/dev/hdb2              3301944      7060   3127156   1% /var/www

[root@calithturon scripts]# mount /dev/hde1 /mnt/hde
[root@calithturon scripts]# mount /dev/hdf1 /mnt/hdf
[root@calithturon scripts]# mount /dev/hdg1 /mnt/hdg
[root@calithturon scripts]# mount /dev/hdh1 /mnt/hdh

[root@calithturon scripts]# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hdh1              3111408   2448976    504380  83% /
/dev/hdc1              4134900   2703864   1220988  69% /home
/dev/hdc2              4134932    817688   3107196  21% /usr/local/packages
/dev/hdc3              1565424   1002960    562464  65% /mnt/files
/dev/hdb2              3301944      7060   3127156   1% /var/www
/dev/hde1              1769968    651956   1028100  39% /mnt/hde
/dev/hdf1              2071576    989692    976652  51% /mnt/hdf
/dev/hdg1              2579600    537516   1911048  22% /mnt/hdg
/dev/hdh1              1771928    752468    929448  45% /mnt/hdh

[root@calithturon scripts]# df | grep hdh
/dev/hdh1              3111408   2448976    504380  83% /
/dev/hdh1              1771928    752468    929448  45% /mnt/hdh

(Now hdh1 has shadowed hda1. hdh1 is listed two times and with two different 
disk sizes)
See this:

[root@calithturon scripts]# umount /dev/hda1 (which used to be /)
umount: /dev/hda1: not mounted

3. Keywords: Mount, /dev/hdh1, shadow

4. Kernel version: Linux version 2.4.10 (root@calithturon.fanitas.com) (gcc 
version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #1 Wed Sep 26 18:59:20 
CEST 2001

5. Not an oops!

6. Failure demo (only works on systems with 8 drives):
[root@calithturon scripts]# df | grep hdh
/dev/hdh1              3111408   2448976    504380  83% /
/dev/hdh1              1771928    752468    929448  45% /mnt/hdh

7. Environment

7.1 Output of the ver_linux script:

[root@calithturon scripts]# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux calithturon.fanitas.com 2.4.10 #1 Wed Sep 26 18:59:20 CEST 2001 i686 
unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         vmnet vmmon
[root@calithturon scripts]#

7.2 Processor information
[root@calithturon scripts]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 264.888
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips        : 527.56

7.3 Module information
[root@calithturon scripts]# cat /proc/modules
vmnet                  16448   1
vmmon                  18224   0 (unused)

7.4 Loaded driver and hardware information
[root@calithturon scripts]# cat /proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0800-083f : Intel Corporation 82371AB PIIX4 ACPI
0840-085f : Intel Corporation 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
d400-d4ff : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE 
Controller (#2)
  d400-d407 : ide3
  d410-d4ff : HPT366
d800-d8ff : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE 
Controller
  d800-d807 : ide2
  d810-d8ff : HPT366
dc80-dcbf : 3Com Corporation 3c905 100BaseTX [Boomerang]
  dc80-dcbf : 00:11.0
dcc8-dccf : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE 
Controller (#2)
  dcc8-dccf : ide3
dcd0-dcd3 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE 
Controller
  dcd2-dcd2 : ide2
dcd4-dcd7 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE 
Controller (#2)
  dcd6-dcd6 : ide3
dcd8-dcdf : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE 
Controller
  dcd8-dcdf : ide2
dce0-dcff : Intel Corporation 82371AB PIIX4 USB
  dce0-dcff : usb-uhci
e000-efff : PCI Bus #01
  ec00-ecff : ATI Technologies Inc 3D Rage Pro AGP 1X
ffa0-ffaf : Intel Corporation 82371AB PIIX4 IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

[root@calithturon scripts]# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-17ffffff : System RAM
  00100000-0022b347 : Kernel code
  0022b348-0027f817 : Kernel data
f4000000-f7ffffff : Intel Corporation 440LX/EX - 82443LX/EX Host bridge
f9000000-f9ffffff : PCI Bus #01
fc000000-feffffff : PCI Bus #01
  fcfff000-fcffffff : ATI Technologies Inc 3D Rage Pro AGP 1X
  fd000000-fdffffff : ATI Technologies Inc 3D Rage Pro AGP 1X
ffe00000-ffffffff : reserved

7.5 PCI information
[root@calithturon scripts]# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge (rev 
03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fc000000-feffffff
        Prefetchable memory behind bridge: f9000000-f9ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 
00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at dce0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dcd8 [size=8]
        Region 1: I/O ports at dcd0 [size=4]
        Region 4: I/O ports at d800 [size=256]
        Expansion ROM at fb000000 [disabled] [size=128K]

00:0e.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 
(rev
01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dcc8 [size=8]
        Region 1: I/O ports at dcd4 [size=4]
        Region 4: I/O ports at d400 [size=256]

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:11.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
        Subsystem: Dell Computer Corporation: Unknown device 006f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at dc80 [size=64]
        Expansion ROM at fb000000 [disabled] [size=64K]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X 
(rev
5c) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 806f
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+ ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at ec00 [size=256]
        Region 2: Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

7.6 SCSI information
[root@calithturon scripts]# cat /proc/scsi/scsi
Attached devices: none

8. Help offered
If the developers do not have access to the failing hardware, software or 
anything I can provide an SSH account on the failing machine. It is on the 
Internet and always up!

-- 
Best regards / Venlig hilsen
- Morten Green Hermansen, Fanitas
