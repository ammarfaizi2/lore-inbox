Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSA2E45>; Mon, 28 Jan 2002 23:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288756AbSA2E4u>; Mon, 28 Jan 2002 23:56:50 -0500
Received: from c007-h008.c007.snv.cp.net ([209.228.33.214]:26094 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S288736AbSA2E4h>;
	Mon, 28 Jan 2002 23:56:37 -0500
X-Sent: 29 Jan 2002 04:56:29 GMT
Message-ID: <3C562B7C.A9BF209C@bigfoot.com>
Date: Mon, 28 Jan 2002 20:56:28 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
CC: Krzysztof Oledzki <ole@ans.pl>
Subject: 2.2.21pre2; ide_set_handler; DMA timeout
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.21pre2 + ide.2.2.21.05042001-Ole.patch + raid-2.2.20-A0
Abit BP6 w EC10, RU BIOS, 1.28 hpt366 BIOS

Got this error

hdi: timeout waiting for DMA
hdi: ide_dma_timeout: Lets do it again!stat = 0x58, dma_stat = 0x20
hdi: DMA disabled
hdi: irq timeout: status=0xd0 { Busy }
hdi: DMA disabled
hdi: ide_set_handler: handler not null; old=c019c89c, new=c019c89c
bug: kernel timer added twice at c019c73e.
ide4: reset: success

during I/O testing on a RAID0 set but no freeze, crash or oops.
Hopefully there are not SMP spinlock problems still hanging around.
I am willing to do specific testing if requested.  Machine data below.

Also note CPU ID reporting changed from 2.2.20 as this board
has always running PGA370 Celeron 533's which used to be correctly
identified "Intel Celeron (Mendocino) stepping 05" and are now
incorrectly identified "Intel Mobile Pentium II stepping 05".
...
***************
*** 52,58 ****
  smp kernel: mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au) 
! smp kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
! smp kernel: CPU: L2 cache: 128K 
  smp kernel: Intel machine check reporting enabled on CPU#0. 
  smp kernel: per-CPU timeslice cutoff: 25.02 usecs. 
! smp kernel: CPU0: Intel Mobile Pentium II stepping 05 
  smp kernel: Getting VERSION: 40011 
--- 49,56 ----
  smp kernel: mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au) 
! smp kernel: Intel machine check architecture supported. 
  smp kernel: Intel machine check reporting enabled on CPU#0. 
+ smp kernel: 128K L2 cache (4 way) 
+ smp kernel: CPU: L2 Cache: 128K 
  smp kernel: per-CPU timeslice cutoff: 25.02 usecs. 
! smp kernel: CPU0: Intel Celeron (Mendocino) stepping 05 
  smp kernel: Getting VERSION: 40011 

Abit BP6 gets my vote for most interesting motherboard in history.  Please
let me know if there's any other info needed.
rgds,
tim.

[tim@smp src]# hdparm -iv /dev/hdi

/dev/hdi:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1027/255/63, sectors = 16514064, start = 0

 Model=FUJITSU MPE3084AE, FwRev=EE-C0-24, SerialNo=05341919
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=off
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=16514064
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 

[tim@smp src]# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 32 set
        Region 0: Memory at da000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d8000000-d9ffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at f000

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at 9000

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 01)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 9400
        Region 1: I/O ports at 9800
        Region 2: I/O ports at 9c00
        Region 3: I/O ports at a000
        Region 4: I/O ports at a400
        Region 5: Memory at dd000000 (32-bit, non-prefetchable)
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at a800
        Region 1: Memory at dd020000 (32-bit, non-prefetchable)

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at ac00
        Region 1: I/O ports at b000
        Region 4: I/O ports at b400

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at b800
        Region 1: I/O ports at bc00
        Region 4: I/O ports at c000

01:00.0 VGA compatible controller: S3 Inc. Savage 4 (rev 02) (prog-if 00 [VGA])
        Subsystem: S3 Inc.: Unknown device 8a22
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 4 min, 255 max, 248 set, cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d9000000 (32-bit, non-prefetchable)
        Region 1: Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

smp syslogd 1.3-3: restart.
smp syslog: syslogd startup succeeded
smp kernel: klogd 1.3-3, log source = /proc/kmsg started.
smp kernel: Inspecting /boot/System.map
smp syslog: klogd startup succeeded
smp kernel: Loaded 8104 symbols from /boot/System.map.
smp kernel: Symbols match kernel version 2.2.21.
smp kernel: No module symbols loaded.
smp kernel: Linux version 2.2.21pre2-iOR (root@smp) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #8 SMP Sun Jan 27 1
smp kernel: BIOS-provided physical RAM map: 
smp kernel:  BIOS-e820: 0009e000 @ 00000000 (usable) 
smp kernel:  BIOS-e820: 0ff00000 @ 00100000 (usable) 
smp kernel: Scan SMP from c0000000 for 1024 bytes. 
smp kernel: Scan SMP from c009fc00 for 1024 bytes. 
smp kernel: Scan SMP from c00f0000 for 65536 bytes. 
smp kernel: Intel MultiProcessor Specification v1.4 
smp kernel:     Virtual Wire compatibility mode. 
smp kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000 
smp kernel: Processor #0 Pentium(tm) Pro APIC version 17 
smp kernel:     Floating point unit present. 
smp kernel:     Machine Exception supported. 
smp kernel:     64 bit compare & exchange supported. 
smp kernel:     Internal APIC present. 
smp kernel:     Bootup CPU 
smp kernel: Processor #1 Pentium(tm) Pro APIC version 17 
smp kernel:     Floating point unit present. 
smp kernel:     Machine Exception supported. 
smp kernel:     64 bit compare & exchange supported. 
smp kernel:     Internal APIC present. 
smp kernel: Bus #0 is PCI    
smp kernel: Bus #1 is PCI    
smp kernel: Bus #2 is ISA    
smp kernel: I/O APIC #2 Version 17 at 0xFEC00000. 
smp kernel: Processors: 2 
smp kernel: mapped APIC to ffffe000 (fee00000) 
smp kernel: mapped IOAPIC to ffffd000 (fec00000) 
smp kernel: Detected 575919 kHz processor. 
smp kernel: ide_setup: idebus=36 
smp kernel: Console: colour VGA+ 80x25 
smp kernel: Calibrating delay loop... 1150.15 BogoMIPS 
smp kernel: Memory: 257336k/262144k available (1304k kernel code, 424k reserved, 3000k data, 80k init) 
smp kernel: Dentry hash table entries: 32768 (order 6, 256k) 
smp kernel: Buffer cache hash table entries: 262144 (order 8, 1024k) 
smp kernel: Page cache hash table entries: 65536 (order 6, 256k) 
smp kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
smp kernel: CPU: L2 cache: 128K 
smp kernel: Intel machine check architecture supported. 
smp kernel: Intel machine check reporting enabled on CPU#0. 
smp kernel: Checking 386/387 coupling... OK, FPU using exception 16 error reporting. 
smp kernel: Checking 'hlt' instruction... OK. 
smp kernel: POSIX conformance testing by UNIFIX 
smp kernel: mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au) 
smp kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
smp kernel: CPU: L2 cache: 128K 
smp kernel: Intel machine check reporting enabled on CPU#0. 
smp kernel: per-CPU timeslice cutoff: 25.02 usecs. 
smp kernel: CPU0: Intel Mobile Pentium II stepping 05 
smp kernel: Getting VERSION: 40011 
smp kernel: Getting VERSION: 40011 
smp kernel: Getting LVT0: 700 
smp kernel: Getting LVT1: 400 
smp kernel: setup_APIC_clock() called. 
smp kernel: calibrating APIC timer ...  
smp kernel: ..... 5759061 CPU clocks in 1 timer chip tick. 
smp kernel: ..... 719881 APIC bus clocks in 1 timer chip tick. 
smp kernel: ..... CPU clock speed is 575.9061 MHz. 
smp kernel: ..... system bus clock speed is 71.9881 MHz. 
smp kernel: CPU map: 3 
smp kernel: Booting processor 1 eip 2000 
smp kernel: Setting warm reset code and vector. 
smp kernel: 1. 
smp kernel: 2. 
smp kernel: 3. 
smp kernel: Asserting INIT. 
smp kernel: Deasserting INIT. 
smp kernel: Sending STARTUP #1. 
smp kernel: After apic_write. 
smp kernel: Before start apic_write. 
smp kernel: Startup point 1. 
smp kernel: CPU#1 waiting for CALLOUT 
smp kernel: Waiting for send to finish... 
smp kernel: +Sending STARTUP #2. 
smp kernel: After apic_write. 
smp kernel: Before start apic_write. 
smp kernel: Startup point 1. 
smp kernel: Waiting for send to finish... 
smp kernel: +After Startup. 
smp kernel: Before Callout 1. 
smp kernel: After Callout 1. 
smp kernel: CALLIN, before enable_local_APIC(). 
smp kernel: setup_APIC_clock() called. 
smp kernel: waiting for other CPU calibrating APIC ... done, continuing. 
smp kernel: Calibrating delay loop... 1150.15 BogoMIPS 
smp kernel: Stack at about cfffbfbc 
smp kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
smp kernel: CPU: L2 cache: 128K 
smp kernel: Intel machine check reporting enabled on CPU#1. 
smp kernel: OK. 
smp kernel: CPU1: Intel Mobile Pentium II stepping 05 
smp kernel: CPU has booted. 
smp kernel: Before bogomips. 
smp kernel: Total of 2 processors activated (2300.31 BogoMIPS). 
smp kernel: Before bogocount - setting activated=1. 
smp kernel: Boot done. 
smp kernel: enabling symmetric IO mode... ...done. 
smp kernel: ENABLING IO-APIC IRQs 
smp kernel: init IO_APIC IRQs 
smp kernel:  IO-APIC (apicid-pin) 2-0, 2-7, 2-10, 2-11, 2-19, 2-20, 2-21, 2-22, 2-23 not connected. 
smp kernel: number of MP IRQ sources: 19. 
smp kernel: number of IO-APIC #2 registers: 24. 
smp kernel: testing the IO APIC....................... 
smp kernel:  
smp kernel: IO APIC #2...... 
smp kernel: .... register #00: 02000000 
smp kernel: .......    : physical APIC id: 02 
smp kernel: .... register #01: 00170011 
smp kernel: .......     : max redirection entries: 0017 
smp kernel: .......     : IO APIC version: 0011 
smp kernel: .... register #02: 00000000 
smp kernel: .......     : arbitration: 00 
smp kernel: .... IRQ redirection table: 
smp kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:    
smp kernel:  00 000 00  1    0    0   0   0    0    0    00 
smp kernel:  01 0FF 0F  1    0    0   0   0    1    1    59 
smp kernel:  02 0FF 0F  0    0    0   0   0    1    1    51 
smp kernel:  03 0FF 0F  1    0    0   0   0    1    1    61 
smp kernel:  04 0FF 0F  1    0    0   0   0    1    1    69 
smp kernel:  05 0FF 0F  1    0    0   0   0    1    1    71 
smp kernel:  06 0FF 0F  1    0    0   0   0    1    1    79 
smp kernel:  07 000 00  1    0    0   0   0    0    0    00 
smp kernel:  08 0FF 0F  1    0    0   0   0    1    1    81 
smp kernel:  09 0FF 0F  1    0    0   0   0    1    1    89 
smp kernel:  0a 000 00  1    0    0   0   0    0    0    00 
smp kernel:  0b 000 00  1    0    0   0   0    0    0    00 
smp kernel:  0c 0FF 0F  1    0    0   0   0    1    1    91 
smp kernel:  0d 000 00  1    0    0   0   0    0    0    00 
smp kernel:  0e 0FF 0F  1    0    0   0   0    1    1    99 
smp kernel:  0f 0FF 0F  1    0    0   0   0    1    1    A1 
smp kernel:  10 0FF 0F  1    1    0   1   0    1    1    A9 
smp kernel:  11 0FF 0F  1    1    0   1   0    1    1    B1 
smp kernel:  12 0FF 0F  1    1    0   1   0    1    1    B9 
smp kernel:  13 000 00  1    0    0   0   0    0    0    00 
smp kernel:  14 000 00  1    0    0   0   0    0    0    00 
smp kernel:  15 000 00  1    0    0   0   0    0    0    00 
smp kernel:  16 000 00  1    0    0   0   0    0    0    00 
smp kernel:  17 000 00  1    0    0   0   0    0    0    00 
smp nscd: nscd startup succeeded
smp kernel: .................................... done. 
smp kernel: checking TSC synchronization across CPUs: passed. 
smp kernel: Setting commenced=1, go go go 
smp kernel: mtrr: your CPUs had inconsistent fixed MTRR settings 
smp kernel: mtrr: probably your BIOS does not setup all CPUs 
smp kernel: PCI: Using configuration type 1 
smp kernel: PCI: Probing PCI hardware 
smp kernel: PCI->APIC IRQ transform: (B0,I13,P0) -> 17 
smp kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 16 
smp kernel: PCI->APIC IRQ transform: (B0,I19,P0) -> 18 
smp kernel: PCI->APIC IRQ transform: (B0,I19,P1) -> 18 
smp kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16 
smp kernel: Linux NET4.0 for Linux 2.2 
smp kernel: Based upon Swansea University Computer Society NET3.039 
smp kernel: NET4: Unix domain sockets 1.0 for Linux NET4.0. 
smp kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
smp kernel: IP Protocols: ICMP, UDP, TCP 
smp kernel: TCP: Hash tables configured (ehash 262144 bhash 65536) 
smp kernel: Starting kswapd v 1.5  
smp kernel: Detected PS/2 Mouse Port. 
smp kernel: Serial driver version 4.27 with no serial options enabled 
smp kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
smp kernel: Real Time Clock Driver v1.09 
smp kernel: loop: registered device at major 7 
smp kernel: Uniform Multi-Platform E-IDE driver Revision: 6.30 
smp kernel: ide: Assuming 36MHz system bus speed for PIO modes 
smp kernel: PIIX4: IDE controller on PCI bus 00 dev 39 
smp kernel: PIIX4: chipset revision 1 
smp kernel: PIIX4: not 100% native mode: will probe irqs later 
smp kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio 
smp kernel: PDC20262: IDE controller on PCI bus 00 dev 68 
smp kernel: PDC20262: chipset revision 1 
smp kernel: PDC20262: not 100% native mode: will probe irqs later 
smp kernel: PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode. 
smp kernel:     ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:DMA, hdf:DMA 
smp kernel:     ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:DMA, hdh:pio 
smp kernel: HPT366: onboard version of chipset, pin1=1 pin2=2 
smp kernel: PCI: HPT366: Fixing interrupt 18 pin 2 to ZERO  
smp kernel: HPT366: IDE controller on PCI bus 00 dev 98 
smp kernel: HPT366: chipset revision 1 
smp rc.sysinit: Mounting proc filesystem succeeded 
smp kernel: HPT366: not 100% native mode: will probe irqs later 
smp sysctl: net.ipv4.ip_forward = 0 
smp kernel:     ide1: BM-DMA at 0xb400-0xb407, BIOS settings: hdc:pio, hdd:pio 
smp sysctl: net.ipv4.conf.all.rp_filter = 1 
smp sysctl: net.ipv4.ip_always_defrag = 0 
smp sysctl: kernel.sysrq = 0 
smp rc.sysinit: Configuring kernel parameters succeeded 
smp date: Sun Jan 27 19:43:16 PST 2002 
smp rc.sysinit: Setting clock : Sun Jan 27 19:43:16 PST 2002 succeeded 
smp kernel: HPT366: IDE controller on PCI bus 00 dev 99 
smp kernel: HPT366: chipset revision 1 
smp kernel: HPT366: not 100% native mode: will probe irqs later 
smp kernel:     ide4: BM-DMA at 0xc000-0xc007, BIOS settings: hdi:pio, hdj:pio 
smp kernel: hda: FUJITSU MPD3084AT, ATA DISK drive 
smp kernel: hdc: FUJITSU MPE3084AE, ATA DISK drive 
smp kernel: hde: IBM-DTLA-307020, ATA DISK drive 
smp kernel: hdg: IBM-DTLA-307020, ATA DISK drive 
smp kernel: hdi: FUJITSU MPE3084AE, ATA DISK drive 
smp kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
smp kernel: ide1 at 0xac00-0xac07,0xb002 on irq 18 
smp kernel: ide2 at 0x9400-0x9407,0x9802 on irq 17 
smp kernel: ide3 at 0x9c00-0x9c07,0xa002 on irq 17 
smp kernel: ide4 at 0xb800-0xb807,0xbc02 on irq 18 
smp kernel: hda: FUJITSU MPD3084AT, 8063MB w/512kB Cache, CHS=1027/255/63, UDMA(33) 
smp kernel: hdc: FUJITSU MPE3084AE, 8063MB w/512kB Cache, CHS=16383/16/63, UDMA(33) 
smp kernel: hde: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=39870/16/63, UDMA(66) 
smp kernel: hdg: IBM-DTLA-307020, 19623MB w/1916kB Cache, CHS=39870/16/63, UDMA(66) 
smp kernel: hdi: FUJITSU MPE3084AE, 8063MB w/512kB Cache, CHS=16383/16/63, UDMA(33) 
smp kernel: Floppy drive(s): fd0 is 1.44M 
smp kernel: FDC 0 is a post-1991 82077 
smp kernel: md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12 
smp kernel: raid0 personality registered 
smp kernel: 3ware Storage Controller device driver for Linux v1.02.00.010. 
smp kernel: 3w-xxxx: tw_findcards(): No cards found. 
smp kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices 
smp kernel: scsi : 1 host. 
smp kernel: scsi : detected total. 
smp kernel: tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov 
smp kernel: eth0: Lite-On 82c168 PNIC rev 32 at 0xa800, 00:A0:CC:58:BD:19, IRQ 16. 
smp kernel: eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1. 
smp kernel: md.c: sizeof(mdp_super_t) = 4096 
smp kernel: Partition check: 
smp kernel:  hda: hda1 hda2 hda3 hda4 
smp kernel:  hdc: [PTBL] [1027/255/63] hdc1 hdc2 
smp kernel:  hde: [PTBL] [2501/255/63] hde1 hde2 hde3 
smp kernel:  hdg: [PTBL] [2501/255/63] hdg1 hdg2 hdg3 
smp kernel:  hdi: [PTBL] [1027/255/63] hdi1 hdi2 
smp kernel: VFS: Mounted root (ext2 filesystem) readonly. 
smp kernel: Freeing unused kernel memory: 80k freed 
smp kernel: Adding Swap: 257032k swap-space (priority 1) 


--
