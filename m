Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRBFSN5>; Tue, 6 Feb 2001 13:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129838AbRBFSNr>; Tue, 6 Feb 2001 13:13:47 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:7326 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S129826AbRBFSNh>;
	Tue, 6 Feb 2001 13:13:37 -0500
Date: Tue, 6 Feb 2001 19:10:31 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Manfred Spraul <manfred@colorfullife.com>
cc: macro@ds2.pg.gda.pl, linux-kernel@vger.kernel.org
Subject: Re: APIC lockup in 2.4.x-x
In-Reply-To: <3A8031AA.1FFDF6AE@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0102061903520.31716-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Manfred Spraul wrote:

> Martin Josefsson wrote:
> > 
> > Hi
> > 
> > I saw your patch for the APIC lockup and I saw that it was included in
> > 2.4.1-ac2 so I tried that one.. but it didn't help..
> > 
> > I can begin with describing my machine:
> > 
> > dual pIII 800 (133MHz FSB)
> > Asus P3C-D mainboard with i820 chipset
> > 256MB rimm (rambus)
> > Dlink DFE570TX (4 port tulip card)
> > Adaptec 29160 scsicard and 18GB scsidisk.
> >
> 
> Could you apply the attached patch, enable sysrq, compile & install the
> kernel, reboot and press sysrq-q after ifup?
> 
> We assumed that only the old io apic for 440 BX boards is affected, but
> your board contains a newer apic intrated in the ICH.
> 
> But probably you ran into another bug - the tulip driver doesn't use
> disable_irq()

Ok I applied the patches and I'm going to test it now, I'll probably don't
know if it helped until tomorrow.

Here the output from dmesg:

#0
Detected 803.423 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1602.35 BogoMIPS
Memory: 255280k/262128k available (1165k kernel code, 6460k reserved, 410k data, 196k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.26 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 1000000
Getting ID: e000000
Getting LVT0: 8700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
Startup point 1.
CPU#1 (phys ID: 0) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1605.63 BogoMIPS
Stack at about cfff5fbc
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Coppermine) stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (3207.98 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-7, 2-10, 2-11, 2-12, 2-13, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170020
.......     : max redirection entries: 0017
.......     : IO APIC version: 0020
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 000 00  1    0    0   0   0    0    0    00
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    71
 0f 003 03  0    0    0   0   0    1    1    79
 10 003 03  1    1    0   1   0    1    1    81
 11 003 03  1    1    0   1   0    1    1    89
 12 003 03  1    1    0   1   0    1    1    91
 13 003 03  1    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 19
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 17
IRQ11 -> 16
IRQ12 -> 18
IRQ14 -> 14
IRQ15 -> 15
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 803.4187 MHz.
..... host bus clock speed is 133.9030 MHz.
cpu: 0, clocks: 1339030, slice: 446343
CPU0<T0:1339024,T1:892672,D:9,S:446343,C:1339030>
cpu: 1, clocks: 1339030, slice: 446343
CPU1<T0:1339024,T1:446336,D:2,S:446343,C:1339030>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xf06d0, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169554kB/56518kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:pio, hdd:pio
hda: SanDisk SDCFB-128, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 250880 sectors (128 MB) w/1KiB Cache, CHS=980/8/32, DMA
Partition check:
 hda:hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x04 { DriveStatusError }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x04 { DriveStatusError }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x04 { DriveStatusError }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x04 { DriveStatusError }
hda: DMA disabled
ide0: reset: success
 hda1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI 2/8/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
(scsi0:0:6:0) Synchronous at 160.0 Mbyte/sec, offset 63.
  Vendor: IBM       Model: DDYS-T18350N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
 sda: sda1 sda2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Disk change detected on device ide0(3,1)
 hda: hda1
VFS: Disk change detected on device ide0(3,1)
 hda: hda1
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
pcwd: v1.10 (06/05/99) Ken Hollis (kenji@bitgate.com)
pcwd: No card detected, or port not available.
Linux Tulip driver version 0.9.4.3 (Apr 14, 2000) + fr+fc 010111
eth0: Digital DS21143 Tulip rev 65 at 0xa800, 00:80:C8:CA:51:DD, IRQ 12.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
eth0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0xa400, 00:80:C8:CA:51:DE, IRQ 7.
eth1:  EEPROM default media type Autosense.
eth1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
eth1:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
eth2: Digital DS21143 Tulip rev 65 at 0xa000, 00:80:C8:CA:51:DF, IRQ 11.
eth2:  EEPROM default media type Autosense.
eth2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
eth2:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth3: Digital DS21143 Tulip rev 65 at 0x9800, 00:80:C8:CA:51:E0, IRQ 10.
eth3:  EEPROM default media type Autosense.
eth3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
eth3:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
ip_tables: (c)2000 Netfilter core team
ip_conntrack (32768 buckets, 262144 max)
reiserfs: checking transaction log (device 08:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
eth3: Setting full-duplex based on MII#1 link partner capability of 45e1.
SysRq: 
printing local APIC contents on CPU#1/0:
... APIC ID:      00000000 (0)
... APIC VERSION: 00040011
... APIC TASKPRI: 00000000 (00)
... APIC ARBPRI: 000000e0 (e0)
... APIC PROCPRI: 00000000
... APIC EOI: 00000000
... APIC LDR: 02000000
... APIC DFR: ffffffff
... APIC SPIV: 000001ff
... APIC ISR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC TMR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000010000000000000001000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC IRR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000100000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000010000000000000000
... APIC ESR: 00000000
... APIC ICR: 000008fc
... APIC ICR2: 01000000
... APIC LVTT: 000200ef
... APIC LVTPC: 00010000
... APIC LVT0: 00000400
... APIC LVT1: 00010400
... APIC LVTERR: 000000fe
... APIC TMICT: 000146e9
... APIC TMCCT: 00003ca2
... APIC TDCR: 00000003


printing local APIC contents on CPU#0/1:
... APIC ID:      01000000 (1)
... APIC VERSION: 00040011
... APIC TASKPRI: 00000000 (00)
... APIC ARBPRI: 000000f0 (f0)
... APIC PROCPRI: 00000000
... APIC EOI: 00000000
... APIC LDR: 01000000
... APIC DFR: ffffffff
... APIC SPIV: 000001ff
... APIC ISR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC TMR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000010000000000000001000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC IRR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000001000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000010000000000001000
... APIC ESR: 00000000
... APIC ICR: 000c08fb
... APIC ICR2: 02000000
... APIC LVTT: 000200ef
... APIC LVTPC: 00010000
... APIC LVT0: 00000400
... APIC LVT1: 00000400
... APIC LVTERR: 000000fe
... APIC TMICT: 000146e9
... APIC TMCCT: 0000eed8
... APIC TDCR: 00000003

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170020
.......     : max redirection entries: 0017
.......     : IO APIC version: 0020
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 000 00  1    0    0   0   0    0    0    00
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    71
 0f 003 03  0    0    0   0   0    1    1    79
 10 003 03  0    1    0   1   0    1    1    81
 11 003 03  0    1    0   1   0    1    1    89
 12 003 03  1    1    0   1   0    1    1    91
 13 003 03  0    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 19
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 17
IRQ11 -> 16
IRQ12 -> 18
IRQ14 -> 14
IRQ15 -> 15
.................................... done.


/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
