Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSFNC2O>; Thu, 13 Jun 2002 22:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317875AbSFNC2N>; Thu, 13 Jun 2002 22:28:13 -0400
Received: from h004.c003.snv.cp.net ([209.228.32.218]:65447 "HELO
	c003.snv.cp.net") by vger.kernel.org with SMTP id <S317874AbSFNC2I>;
	Thu, 13 Jun 2002 22:28:08 -0400
X-Sent: 14 Jun 2002 02:28:03 GMT
Message-ID: <3D0954B2.C4DF869@telocity.com>
Date: Thu, 13 Jun 2002 22:28:02 -0400
From: "Paul Clements (home)" <pclements@telocity.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem: Kernel 2.4.18, Promise 20269 cannot do UDMA Mode 6
In-Reply-To: <Pine.LNX.4.33.0206131428140.10531-100000@charon.clements.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I cannot seem to set my Promise 20269 to UDMA Mode6. The driver
initially sets my drive to UDMA Mode2 on boot. Using hdparm I have 
tried to set the drive to UDMA Mode6 (which it claims to support and
which the controller should support, since it's a 133TX2). Does anyone
know if I am doing something wrong? Or is there a driver/kernel/hardware
limitation here that I'm not quite grokking?

I'm running the RedHat 7.3, 2.4.18 kernel.

Thanks,
Paul

--

gemini:~# uname -r
2.4.18-3smp
gemini:~# cat /proc/ide/
drivers   hdc       hde       ide1      ide2      pdc202xx  piix
gemini:~# cat /proc/ide/pdc202xx

                                PDC20269 TX2 Chipset.
gemini:~# cat /proc/ide/ide2/hde/settings
name                    value           min             max            
mode
----                    -----           ---             ---            
----
acoustic                0               0               254            
rw
address                 0               0               2              
rw
bios_cyl                155114          0               65535          
rw
bios_head               16              0               255            
rw
bios_sect               63              0               63             
rw
breada_readahead        8               0               255            
rw
bswap                   0               0               1              
r
current_speed           66              0               69             
rw
failures                0               0               65535          
rw
file_readahead          508             0               16384          
rw
ide_scsi                0               0               1              
rw
init_speed              66              0               69             
rw
io_32bit                0               0               3              
rw
keepsettings            0               0               1              
rw
lun                     0               0               7              
rw
max_failures            1               0               65535          
rw
max_kb_per_request      128             1               255            
rw
multcount               16              0               16             
rw
nice1                   1               0               1              
rw
nowerr                  0               0               1              
rw
number                  0               0               3              
rw
pio_mode                write-only      0               255            
w
slow                    0               0               1              
rw
unmaskirq               0               0               1              
rw
using_dma               1               0               1              
rw
wcache                  0               0               1              
rw
gemini:~# hdparm -i /dev/hde

/dev/hde:

 Model=MAXTOR 6L080L4, FwRev=A93.0500, SerialNo=664135718147
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156355584
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6
 AdvancedPM=no WriteCache=enabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3
ATA-4 ATA
-5

gemini:~# hdparm -X70 /dev/hde

/dev/hde:
 setting xfermode to 70 (UltraDMA mode6)
gemini:~# tail -1 /var/log/messages
Jun 13 13:37:31 gemini kernel: ide2: Speed warnings UDMA 3/4/5 is not
functional
.

----------------------

May 27 15:13:42 gemini kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
May 27 15:13:42 gemini kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
May 27 15:13:42 gemini kernel: PIIX4: IDE controller on PCI bus 00 dev
11
May 27 15:13:42 gemini kernel: PIIX4: chipset revision 1
May 27 15:13:42 gemini kernel: PIIX4: not 100%% native mode: will probe
irqs later
May 27 15:13:42 gemini kernel:     ide1: BM-DMA at 0x10d8-0x10df, BIOS
settings: hdc:pio, hdd:pio
May 27 15:13:42 gemini kernel: PDC20269: IDE controller on PCI bus 00
dev 98
May 27 15:13:42 gemini kernel: PDC20269: chipset revision 2
May 27 15:13:42 gemini kernel: PDC20269: not 100%% native mode: will
probe irqs later
May 27 15:13:42 gemini kernel:     ide2: BM-DMA at 0x10a0-0x10a7, BIOS
settings: hde:pio, hdf:pio
May 27 15:13:42 gemini kernel:     ide3: BM-DMA at 0x10a8-0x10af, BIOS
settings: hdg:pio, hdh:pio
May 27 15:13:42 gemini kernel: hdc: FX322M, ATAPI CD/DVD-ROM drive
May 27 15:13:42 gemini kernel: hde: MAXTOR 6L080L4, ATA DISK drive
May 27 15:13:42 gemini kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 27 15:13:42 gemini kernel: ide2 at 0x10c0-0x10c7,0x10b6 on irq 17

----------------------


00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
[size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:02.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 10d0 [size=16]

00:02.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at 1080 [size=32]

00:02.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 05)
        Subsystem: Intel Corp. EtherExpress PRO/100+
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fc105000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at 1060 [size=32]
        Region 2: Memory at fc000000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:04.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev
22) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=16M]

00:05.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 04)
(prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=68
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: fc200000-fc2fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

00:13.0 Unknown mass storage controller: Promise Technology, Inc. 20269
(rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 10c0 [size=8]
        Region 1: I/O ports at 10b4 [size=4]
        Region 2: I/O ports at 10b8 [size=8]
        Region 3: I/O ports at 10b0 [size=4]
        Region 4: I/O ports at 10a0 [size=16]
        Region 5: Memory at fc100000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet
10/100 model NC100 (rev 11)
        Subsystem: Linksys: Unknown device 0570
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 1400 [size=256]
        Region 1: Memory at fc104000 (32-bit, non-prefetchable)
[size=1K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.0 Network controller: PROXIM Inc Symphony 4110 (rev 02)
        Subsystem: PROXIM Inc Symphony 4110
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at fc200000 (32-bit, non-prefetchable)
[disabled] [size=128]
        Region 1: I/O ports at 2080 [disabled] [size=128]
        Region 3: I/O ports at 2000 [disabled] [size=16]
