Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264632AbRF3Pts>; Sat, 30 Jun 2001 11:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264637AbRF3Pti>; Sat, 30 Jun 2001 11:49:38 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:14352 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S264632AbRF3Pt3>;
	Sat, 30 Jun 2001 11:49:29 -0400
Message-ID: <3B3DF519.FDC11523@vioro.nl>
Date: Sat, 30 Jun 2001 17:49:45 +0200
From: Marc Kool <M.Kool@vioro.nl>
Organization: Vioro Consultancy BV
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en, nl, pt-BR, pt
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug? dd on /dev/sdb makes system *incredibly* slow
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I don't where else to send this ... so please send it to the right person if this is the wrong address.

Below is a bug report.  Please let me know if you can look at it.

Thanks
Marc

[1.] One line summary of the problem:
dd if=/dev/sdb of=/dev/null bs=64k  makes fast system *slow*

[2.] Full description of the problem/report:
I had 2 I/O errors on my second SCSI disk (/dev/sdbx).
To verify the whole disk, I did
	dd if=/dev/sdb of=/dev/null bs=64k
It turned the fast system into a 4.77 MHz XT

[3.] Keywords (i.e., modules, networking, kernel):
kernel, raw I/O, SCSI disk, buffering

[4.] Kernel version (from /proc/version):
Linux version 2.4.5 (root@adamsrv1) (gcc version 2.95.3 20010315 (release)) #12 Thu Jun 28 02:06:13 CEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
no OOPS

[6.] A small shell script or example program which triggers the
     problem (if possible)
dd if=/dev/sdb of=/dev/null bs=64k

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux 2.4.5 no modifications
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 400.914
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 799.53          

[7.3.] Module information (from /proc/modules):
vmnet                  18272   3
vmmon                  18832   0 (unused)                                         
These are VMware modules

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
c000-cfff : PCI Bus #01
d000-d01f : Intel Corporation 82371AB PIIX4 USB
  d000-d01f : usb-uhci
d400-d47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  d400-d47f : eth0
d800-d87f : Eicon Technology Corporation DIVA 20
dc00-dc1f : Eicon Technology Corporation DIVA 20
  dc00-dc1f : diva isdn
e000-e0ff : Adaptec AIC-7881U
f000-f00f : Intel Corporation 82371AB PIIX4 IDE  

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-00268e87 : Kernel code
  00268e88-002f175f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e4000000-e7ffffff : PCI Bus #01
  e4000000-e4003fff : Matrox Graphics, Inc. MGA G200 AGP
  e5000000-e57fffff : Matrox Graphics, Inc. MGA G200 AGP
e8000000-ebffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
ed000000-edffffff : PCI Bus #01
  ed000000-edffffff : Matrox Graphics, Inc. MGA G200 AGP
ef000000-ef00007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ef001000-ef001fff : Adaptec AIC-7881U
  ef001000-ef001fff : aic7xxx
ef002000-ef00207f : Eicon Technology Corporation DIVA 20
ffff0000-ffffffff : reserved     

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e4000000-e7ffffff
        Prefetchable memory behind bridge: ed000000-edffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d400 [size=128]
        Region 1: Memory at ef000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at ec000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Network controller: Eicon Technology Corporation DIVA 20 (rev 01)
        Subsystem: Eicon Technology Corporation DIVA 2.0 S/T
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at ef002000 (32-bit, non-prefetchable) [size=128]
        Region 1: I/O ports at d800 [size=128]
        Region 2: I/O ports at dc00 [size=32]
 
00:0f.0 SCSI storage controller: Adaptec AIC-7881U (rev 01)
        Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [disabled] [size=256]
        Region 1: Memory at ef001000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at ee000000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-     

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ed000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2  


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DGHS09U          Rev: 03B0
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DGHS09U          Rev: 03B0
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: C1537A           Rev: L708
  Type:   Sequential-Access                ANSI SCSI revision: 02       

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
I Have Linux 2.4.x on /dev/sdb and Linux 2.0.x on sda. /dev/sda is not used by any program.
/dev/sdb contains / /boot swap and /local.
My system is reasonably fast with 400 MHz Pentium II, 256 MB memory and 2 * 9GB SCSI disks
When the system is idle, top shows 4M free, 91M buffers, 110M cached

test A.
After dd is started (on an idle system) on the idle disk (/dev/sda), 
top shows after a short while 4M free 2104M buffers, 17M cached.
interactive performance: barely acceptable (typing this in netscape is slow and the window manager responds after 8 seconds). The CPU is 90% idle.

test B.
After dd is started on the disk where the OS and programs are (/dev/sdb)
The interactive response is worse and still the CPU is 90% idle. Even the mouse responds late.
Doing a additional compilation job in the background brings the system on its knees where interaction with netscape is almost impossible.
top shows again 4M free 204M buffers, 17M cached.

It seems that the I/O for the raw device takes too many buffers which are not freed in time (they are freed, of course, since dd completes normally after reading the 9 GB). The abnormal consumption of buffers makes the system slow.

In a normal day, one does not quickly do dd on a raw disk, so you might be tempted to give this issue a low priority but there are applications like VMware and Sybase that use raw partitions.
