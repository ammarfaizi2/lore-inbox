Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRCPUXM>; Fri, 16 Mar 2001 15:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131351AbRCPUXB>; Fri, 16 Mar 2001 15:23:01 -0500
Received: from cpe.atm0-0-0-209183.boanxx5.customer.tele.dk ([62.242.151.103]:36959
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S131349AbRCPUWt>; Fri, 16 Mar 2001 15:22:49 -0500
Date: Fri, 16 Mar 2001 21:22:06 +0100
From: Henrik Størner <henrik@hswn.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2/2.4.3-pre4 IDE DMA problems w/ PDC20267+IBM DTLA
Message-ID: <20010316212206.A849@hswn.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am struggling to get an IBM DTLA-307045 drive attached to a 
promise pdc20267 controller to work in DMA mode. Right now, 
whenever I enable a DMA mode, I get timeouts when accessing 
the drive.

I am using an 80-pin cable, that came with the Promise controller.

Mar 16 20:57:43 ask kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Mar 16 20:57:43 ask kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar 16 20:57:43 ask kernel: PDC20267: IDE controller on PCI bus 00 dev 30
Mar 16 20:57:43 ask kernel: PDC20267: chipset revision 2
Mar 16 20:57:43 ask kernel: PDC20267: not 100%% native mode: will probe irqs later
Mar 16 20:57:43 ask kernel: PDC20267: ROM enabled at 0x80000000
Mar 16 20:57:43 ask kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
Mar 16 20:57:43 ask kernel:     ide2: BM-DMA at 0x8040-0x8047, BIOS settings: hde:DMA, hdf:pio
Mar 16 20:57:43 ask kernel:     ide3: BM-DMA at 0x8048-0x804f, BIOS settings: hdg:pio, hdh:pio
Mar 16 20:57:43 ask kernel: PIIX3: IDE controller on PCI bus 00 dev 61
Mar 16 20:57:43 ask kernel: PIIX3: chipset revision 0
Mar 16 20:57:43 ask kernel: PIIX3: not 100%% native mode: will probe irqs later
Mar 16 20:57:43 ask kernel: PIIX3: neither IDE port enabled (BIOS)
Mar 16 20:58:23 ask kernel: hde: IBM-DTLA-307045, ATA DISK drive
Mar 16 20:58:23 ask kernel: ide2 at 0x8000-0x8007,0x800a on irq 14
Mar 16 20:59:00 ask kernel: A Register SYNC_IN ERRDY_EN IORDY_EN PREFETCH_EN PA0 PIO(A) = 1 
Mar 16 20:59:00 ask kernel:         AP 11110001
Mar 16 20:59:00 ask kernel: B Register MB0 DMA(B) = 1 PB2 PIO(B) = 4 
Mar 16 20:59:00 ask kernel:         BP 00100100
Mar 16 20:59:00 ask kernel: C Register IORDYp MC0 DMA(C) = 1 
Mar 16 20:59:00 ask kernel:         CP 01000001
Mar 16 20:59:00 ask kernel: D Register 
Mar 16 20:59:00 ask kernel:         DP 00000000
Mar 16 20:59:00 ask kernel: hde: UDMA 5 drive0 0x004124f1 0x004124f1
Mar 16 20:59:00 ask kernel: hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
Mar 16 20:59:20 ask kernel:  hde:hde: timeout waiting for DMA
Mar 16 20:59:20 ask kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Mar 16 20:59:20 ask kernel: hde: irq timeout: status=0x50 { DriveReady SeekComplete }

Any ideas on how to improve the state of things ? The drive works
in non-DMA mode, but the performance is pretty poor (~ 5 MB/sec
on a 'hdparm -t') - I would like to make it somewhat snappier.

The system is a Pentium/166 with 64 MB RAM, and a built-in PIIX3
chipset. The IBM drive is the only IDE drive in the system, and I
have tried with both the built-in IDE controller disabled and
enabled. Here's the full dmesg:

Linux version 2.4.3-pre4 (henrik@ask.hswn.dk) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #19 Fri Mar 16 20:44:30 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009e800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000001800 @ 000000000009e800 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000003f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000040000 @ 00000000fffc0000 (reserved)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=test3 ro root=805 BOOT_FILE=/boot/test243-pdc20267-dma-module
Initializing CPU#0
Detected 166.588 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 332.59 BogoMIPS
Memory: 62184k/65536k available (1079k kernel code, 2960k reserved, 389k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU: After generic, caps: 000001bf 00000000 00000000 00000000
CPU: Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd83e, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41248kB/13749kB, 128 slots per queue
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Real Time Clock Driver v1.10d
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:02:B3:0F:D3:82, IRQ 11.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 7, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Tekram NVRAM
sym53c875-0: rev 0x26 on pci bus 0 device 7 function 0 irq 12
sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3a-20010304
  Vendor: IBM       Model: DORS-32160W       Rev: WA6A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DCAS-34330W       Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 12, lun 0
sym53c875-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
sym53c875-0-<12,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)
SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
 sdb: sdb1
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
ip_conntrack (512 buckets, 4096 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 205612k swap-space (priority -1)
reiserfs: checking transaction log (device 08:11) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
ide_setup: ide0=noprobe
ide_setup: ide2=noautotune
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 30
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0x80000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x8040-0x8047, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8048-0x804f, BIOS settings: hdg:pio, hdh:pio
PIIX3: IDE controller on PCI bus 00 dev 61
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
PIIX3: neither IDE port enabled (BIOS)
hde: IBM-DTLA-307045, ATA DISK drive
ide2 at 0x8000-0x8007,0x800a on irq 14
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
 hde: unknown partition table
A Register SYNC_IN ERRDY_EN IORDY_EN PREFETCH_EN PA0 PIO(A) = 1 
        AP 11110001
B Register MB0 DMA(B) = 1 PB2 PIO(B) = 4 
        BP 00100100
C Register IORDYp MC0 DMA(C) = 1 
        CP 01000001
D Register 
        DP 00000000
hde: PIO 4 drive0 0x004124f1 0x004124f1
hde: DMA disabled
reiserfs: checking transaction log (device 21:00) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25

