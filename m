Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbTADXHk>; Sat, 4 Jan 2003 18:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbTADXHk>; Sat, 4 Jan 2003 18:07:40 -0500
Received: from head.linpro.no ([80.232.36.1]:54442 "EHLO head.linpro.no")
	by vger.kernel.org with ESMTP id <S261721AbTADXHe>;
	Sat, 4 Jan 2003 18:07:34 -0500
To: linux-kernel@vger.kernel.org
Subject: filesystem corruption with 2.4.20-ac2
From: Per Andreas Buer <perbu@linpro.no>
Organization: Linpro AS
Date: 05 Jan 2003 00:16:07 +0100
Message-ID: <PERBUMSGID-ul6znqgh5fs.fsf@nfsd.linpro.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Score: 0.0 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18UxWR-0001Bo-00*s2gBhonTq0k*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


I'm running Linux 2.4.20 with the ac2 patch (I have a couple of Samsung
Harddrives with hangs the unpatched 2.4.20). I am experiecing quite
servere corruption.  The system has IDE-devices. I have only seen the
corruption on some Maxtor drives (but these are the only ones in use).
The same corruption was also noticed with 2.4.20-pre10-ac1.

I noticed a lot of these: 

Dec  8 19:31:54 beige kernel: attempt to access beyond end of device
Dec  8 19:31:54 beige kernel: 3a:07: rw=0, want=1153720904,limit=222859264
Dec  8 19:31:54 beige kernel: attempt to access beyond end of device
Dec  8 19:31:54 beige kernel: 3a:07: rw=0, want=1613332580,limit=222859264
Dec  8 19:31:54 beige kernel: attempt to access beyond end of device
Dec  8 19:31:55 beige kernel: attempt to access beyond end of device
Dec  8 19:31:55 beige kernel: 3a:07 rw=0, want=1613332580,limit=222859264
Dec  9 06:28:21 beige kernel: init_special_inode: bogus imod (0)
Dec  9 06:28:21 beige kernel: init_special_inode: bogus imo


If I write ~ 1GB of data and re-read it, it is usually corrupted. 2.4.18
shows no sign of this corruption. 

Attached dmesg should show all relevant hardware. 


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=dmesg-beige
Content-Description: dmesg 2.4.20-ac2

Jan  4 18:04:33 beige kernel: Linux version 2.4.20-ac2 (root@beige.perbu.home.linpro.net) (gcc version 2.95.4 20011002 (Debian prerelease)) #4 SMP Thu Dec 19 00:22:46 CET 2002
Jan  4 18:04:33 beige kernel: BIOS-provided physical RAM map:
Jan  4 18:04:33 beige kernel:  BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
Jan  4 18:04:33 beige kernel:  BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
Jan  4 18:04:33 beige kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  4 18:04:33 beige kernel:  BIOS-e820: 0000000000100000 - 0000000016000000 (usable)
Jan  4 18:04:33 beige kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jan  4 18:04:33 beige kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jan  4 18:04:33 beige kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jan  4 18:04:33 beige kernel: 352MB LOWMEM available.
Jan  4 18:04:33 beige kernel: found SMP MP-table at 000f6a50
Jan  4 18:04:33 beige kernel: hm, page 000f6000 reserved twice.
Jan  4 18:04:33 beige kernel: hm, page 000f7000 reserved twice.
Jan  4 18:04:33 beige kernel: hm, page 000f6000 reserved twice.
Jan  4 18:04:33 beige kernel: hm, page 000f7000 reserved twice.
Jan  4 18:04:33 beige kernel: On node 0 totalpages: 90112
Jan  4 18:04:33 beige kernel: zone(0): 4096 pages.
Jan  4 18:04:33 beige kernel: zone(1): 86016 pages.
Jan  4 18:04:33 beige kernel: zone(2): 0 pages.
Jan  4 18:04:33 beige kernel: Intel MultiProcessor Specification v1.4
Jan  4 18:04:33 beige kernel:     Virtual Wire compatibility mode.
Jan  4 18:04:33 beige kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Jan  4 18:04:33 beige kernel: Processor #1 Pentium(tm) Pro APIC version 17
Jan  4 18:04:33 beige kernel: Processor #0 Pentium(tm) Pro APIC version 17
Jan  4 18:04:33 beige kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Jan  4 18:04:33 beige kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jan  4 18:04:33 beige kernel: Processors: 2
Jan  4 18:04:33 beige kernel: Kernel command line: root=/dev/hda1 ro console=ttyS0,57600n8
Jan  4 18:04:33 beige kernel: Initializing CPU#0
Jan  4 18:04:33 beige kernel: Detected 267.276 MHz processor.
Jan  4 18:04:33 beige kernel: Console: colour *CGA 80x25
Jan  4 18:04:33 beige kernel: Calibrating delay loop... 532.48 BogoMIPS
Jan  4 18:04:33 beige kernel: Memory: 350976k/360448k available (1173k kernel code, 6904k reserved, 318k data, 268k init, 0k highmem)
Jan  4 18:04:33 beige kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Jan  4 18:04:33 beige kernel: Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Jan  4 18:04:33 beige kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Jan  4 18:04:33 beige kernel: ramfs: mounted with options: <defaults>
Jan  4 18:04:33 beige kernel: ramfs: max_pages=44144 max_file_pages=0 max_inodes=0 max_dentries=44144
Jan  4 18:04:33 beige kernel: Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Jan  4 18:04:33 beige kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Jan  4 18:04:33 beige kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jan  4 18:04:33 beige kernel: CPU: L2 cache: 512K
Jan  4 18:04:33 beige kernel: Intel machine check architecture supported.
Jan  4 18:04:33 beige kernel: Intel machine check reporting enabled on CPU#0.
Jan  4 18:04:33 beige kernel: CPU:     After generic, caps: 0080fbff 00000000 00000000 00000000
Jan  4 18:04:33 beige kernel: CPU:             Common caps: 0080fbff 00000000 00000000 00000000
Jan  4 18:04:33 beige kernel: Checking 'hlt' instruction... OK.
Jan  4 18:04:33 beige kernel: POSIX conformance testing by UNIFIX
Jan  4 18:04:33 beige kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jan  4 18:04:33 beige kernel: mtrr: detected mtrr type: Intel
Jan  4 18:04:33 beige kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jan  4 18:04:33 beige kernel: CPU: L2 cache: 512K
Jan  4 18:04:33 beige kernel: Intel machine check reporting enabled on CPU#0.
Jan  4 18:04:33 beige kernel: CPU:     After generic, caps: 0080fbff 00000000 00000000 00000000
Jan  4 18:04:33 beige kernel: CPU:             Common caps: 0080fbff 00000000 00000000 00000000
Jan  4 18:04:33 beige kernel: CPU0: Intel Pentium II (Klamath) stepping 04
Jan  4 18:04:33 beige kernel: per-CPU timeslice cutoff: 1464.30 usecs.
Jan  4 18:04:33 beige kernel: task migration cache decay timeout: 10 msecs.
Jan  4 18:04:33 beige kernel: enabled ExtINT on CPU#0
Jan  4 18:04:33 beige kernel: ESR value before enabling vector: 00000000
Jan  4 18:04:33 beige kernel: ESR value after enabling vector: 00000000
Jan  4 18:04:33 beige kernel: Booting processor 1/2 eip 2000
Jan  4 18:04:33 beige kernel: Initializing CPU#1
Jan  4 18:04:33 beige kernel: masked ExtINT on CPU#1
Jan  4 18:04:33 beige kernel: ESR value before enabling vector: 00000000
Jan  4 18:04:33 beige kernel: ESR value after enabling vector: 00000000
Jan  4 18:04:33 beige kernel: Calibrating delay loop... 534.11 BogoMIPS
Jan  4 18:04:33 beige kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jan  4 18:04:33 beige kernel: CPU: L2 cache: 512K
Jan  4 18:04:33 beige kernel: Intel machine check reporting enabled on CPU#1.
Jan  4 18:04:33 beige kernel: CPU:     After generic, caps: 0080fbff 00000000 00000000 00000000
Jan  4 18:04:33 beige kernel: CPU:             Common caps: 0080fbff 00000000 00000000 00000000
Jan  4 18:04:33 beige kernel: CPU1: Intel Pentium II (Klamath) stepping 03
Jan  4 18:04:33 beige kernel: Total of 2 processors activated (1066.59 BogoMIPS).
Jan  4 18:04:33 beige kernel: ENABLING IO-APIC IRQs
Jan  4 18:04:33 beige kernel: Setting 2 in the phys_id_present_map
Jan  4 18:04:33 beige kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Jan  4 18:04:33 beige kernel: init IO_APIC IRQs
Jan  4 18:04:33 beige kernel:  IO-APIC (apicid-pin) 2-0, 2-5, 2-7, 2-9, 2-10, 2-13, 2-20, 2-21, 2-22, 2-23 not connected.
Jan  4 18:04:33 beige kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Jan  4 18:04:33 beige kernel: number of MP IRQ sources: 16.
Jan  4 18:04:33 beige kernel: number of IO-APIC #2 registers: 24.
Jan  4 18:04:33 beige kernel: testing the IO APIC.......................
Jan  4 18:04:33 beige kernel: 
Jan  4 18:04:33 beige kernel: IO APIC #2......
Jan  4 18:04:33 beige kernel: .... register #00: 02000000
Jan  4 18:04:33 beige kernel: .......    : physical APIC id: 02
Jan  4 18:04:33 beige kernel: .... register #01: 00170011
Jan  4 18:04:33 beige kernel: .......     : max redirection entries: 0017
Jan  4 18:04:33 beige kernel: .......     : PRQ implemented: 0
Jan  4 18:04:33 beige kernel: .......     : IO APIC version: 0011
Jan  4 18:04:33 beige kernel: .... register #02: 00000000
Jan  4 18:04:33 beige kernel: .......     : arbitration: 00
Jan  4 18:04:33 beige kernel: .... IRQ redirection table:
Jan  4 18:04:33 beige kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jan  4 18:04:33 beige kernel:  00 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel:  01 003 03  0    0    0   0   0    1    1    39
Jan  4 18:04:33 beige kernel:  02 001 01  0    0    0   0   0    1    1    31
Jan  4 18:04:33 beige kernel:  03 003 03  0    0    0   0   0    1    1    41
Jan  4 18:04:33 beige kernel:  04 003 03  0    0    0   0   0    1    1    49
Jan  4 18:04:33 beige kernel:  05 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel:  06 003 03  0    0    0   0   0    1    1    51
Jan  4 18:04:33 beige kernel:  07 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel:  08 003 03  0    0    0   0   0    1    1    59
Jan  4 18:04:33 beige kernel:  09 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel:  0a 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel:  0b 003 03  0    0    0   0   0    1    1    61
Jan  4 18:04:33 beige kernel:  0c 003 03  0    0    0   0   0    1    1    69
Jan  4 18:04:33 beige kernel:  0d 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel:  0e 003 03  0    0    0   0   0    1    1    71
Jan  4 18:04:33 beige kernel:  0f 003 03  0    0    0   0   0    1    1    79
Jan  4 18:04:33 beige kernel:  10 003 03  1    1    0   1   0    1    1    81
Jan  4 18:04:33 beige kernel:  11 003 03  1    1    0   1   0    1    1    89
Jan  4 18:04:33 beige kernel:  12 003 03  1    1    0   1   0    1    1    91
Jan  4 18:04:33 beige kernel:  13 003 03  1    1    0   1   0    1    1    99
Jan  4 18:04:33 beige kernel:  14 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel:  15 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel:  16 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel:  17 000 00  1    0    0   0   0    0    0    00
Jan  4 18:04:33 beige kernel: IRQ to pin mappings:
Jan  4 18:04:33 beige kernel: IRQ0 -> 0:2
Jan  4 18:04:33 beige kernel: IRQ1 -> 0:1
Jan  4 18:04:33 beige kernel: IRQ3 -> 0:3
Jan  4 18:04:33 beige kernel: IRQ4 -> 0:4
Jan  4 18:04:33 beige kernel: IRQ6 -> 0:6
Jan  4 18:04:33 beige kernel: IRQ8 -> 0:8
Jan  4 18:04:33 beige kernel: IRQ11 -> 0:11
Jan  4 18:04:33 beige kernel: IRQ12 -> 0:12
Jan  4 18:04:33 beige kernel: IRQ14 -> 0:14
Jan  4 18:04:33 beige kernel: IRQ15 -> 0:15
Jan  4 18:04:33 beige kernel: IRQ16 -> 0:16
Jan  4 18:04:33 beige kernel: IRQ17 -> 0:17
Jan  4 18:04:33 beige kernel: IRQ18 -> 0:18
Jan  4 18:04:33 beige kernel: IRQ19 -> 0:19
Jan  4 18:04:33 beige kernel: .................................... done.
Jan  4 18:04:33 beige kernel: Using local APIC timer interrupts.
Jan  4 18:04:33 beige kernel: calibrating APIC timer ...
Jan  4 18:04:33 beige kernel: ..... CPU clock speed is 267.2900 MHz.
Jan  4 18:04:33 beige kernel: ..... host bus clock speed is 66.8224 MHz.
Jan  4 18:04:33 beige kernel: cpu: 0, clocks: 668224, slice: 222741
Jan  4 18:04:33 beige kernel: CPU0<T0:668224,T1:445472,D:11,S:222741,C:668224>
Jan  4 18:04:33 beige kernel: cpu: 1, clocks: 668224, slice: 222741
Jan  4 18:04:33 beige kernel: CPU1<T0:668224,T1:222736,D:6,S:222741,C:668224>
Jan  4 18:04:33 beige kernel: migration_task 0 on cpu=0
Jan  4 18:04:33 beige kernel: migration_task 1 on cpu=1
Jan  4 18:04:33 beige kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Jan  4 18:04:33 beige kernel: mtrr: probably your BIOS does not setup all CPUs
Jan  4 18:04:33 beige kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0510, last bus=1
Jan  4 18:04:33 beige kernel: PCI: Using configuration type 1
Jan  4 18:04:33 beige kernel: PCI: Probing PCI hardware
Jan  4 18:04:33 beige kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Jan  4 18:04:33 beige kernel: PCI->APIC IRQ transform: (B0,I4,P3) -> 19
Jan  4 18:04:33 beige kernel: PCI->APIC IRQ transform: (B0,I9,P0) -> 19
Jan  4 18:04:33 beige kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18
Jan  4 18:04:33 beige kernel: PCI->APIC IRQ transform: (B0,I11,P0) -> 17
Jan  4 18:04:33 beige kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> 16
Jan  4 18:04:33 beige kernel: Limiting direct PCI/PCI transfers.
Jan  4 18:04:33 beige kernel: Linux NET4.0 for Linux 2.4
Jan  4 18:04:33 beige kernel: Based upon Swansea University Computer Society NET3.039
Jan  4 18:04:33 beige kernel: Initializing RT netlink socket
Jan  4 18:04:33 beige kernel: Starting kswapd
Jan  4 18:04:33 beige kernel: VFS: Disk quotas vdquot_6.5.1
Jan  4 18:04:33 beige kernel: Journalled Block Device driver loaded
Jan  4 18:04:33 beige kernel: devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
Jan  4 18:04:33 beige kernel: devfs: boot_options: 0x1
Jan  4 18:04:33 beige kernel: ACPI: System description tables not found
Jan  4 18:04:33 beige kernel:     ACPI-0068: *** Error: Acpi_load_tables: Could not get RSDP, AE_ERROR
Jan  4 18:04:33 beige kernel:     ACPI-0116: *** Error: Acpi_load_tables: Could not load tables: AE_ERROR
Jan  4 18:04:33 beige kernel: ACPI: System description table load failed
Jan  4 18:04:33 beige kernel: keyboard: Timeout - AT keyboard not present?(ed)
Jan  4 18:04:33 beige kernel: keyboard: Timeout - AT keyboard not present?(f4)
Jan  4 18:04:33 beige kernel: pty: 256 Unix98 ptys configured
Jan  4 18:04:33 beige kernel: Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
Jan  4 18:04:33 beige kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jan  4 18:04:33 beige kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jan  4 18:04:33 beige kernel: Floppy drive(s): fd0 is 1.44M
Jan  4 18:04:33 beige kernel: FDC 0 is a post-1991 82077
Jan  4 18:04:33 beige kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
Jan  4 18:04:33 beige kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan  4 18:04:33 beige kernel: PIIX4: IDE controller at PCI slot 00:04.1
Jan  4 18:04:33 beige kernel: PIIX4: chipset revision 1
Jan  4 18:04:33 beige kernel: PIIX4: not 100%% native mode: will probe irqs later
Jan  4 18:04:33 beige kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
Jan  4 18:04:33 beige kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
Jan  4 18:04:33 beige kernel: PDC20246: IDE controller at PCI slot 00:09.0
Jan  4 18:04:33 beige kernel: PDC20246: chipset revision 1
Jan  4 18:04:33 beige kernel: PDC20246: not 100%% native mode: will probe irqs later
Jan  4 18:04:33 beige kernel: PDC20246: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
Jan  4 18:04:33 beige kernel: PDC20246: FORCING BURST BIT 0x00->0x01 ACTIVE
Jan  4 18:04:33 beige kernel:     ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
Jan  4 18:04:33 beige kernel:     ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:DMA
Jan  4 18:04:33 beige kernel: PDC20262: IDE controller at PCI slot 00:0a.0
Jan  4 18:04:33 beige kernel: PDC20262: chipset revision 1
Jan  4 18:04:33 beige kernel: PDC20262: not 100%% native mode: will probe irqs later
Jan  4 18:04:33 beige kernel: PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
Jan  4 18:04:33 beige kernel:     ide4: BM-DMA at 0x9000-0x9007, BIOS settings: hdi:pio, hdj:DMA
Jan  4 18:04:33 beige kernel:     ide5: BM-DMA at 0x9008-0x900f, BIOS settings: hdk:pio, hdl:DMA
Jan  4 18:04:33 beige kernel: hda: IBM-DHEA-36481, ATA DISK drive
Jan  4 18:04:33 beige kernel: blk: queue c0328360, I/O limit 4095Mb (mask 0xffffffff)
Jan  4 18:04:33 beige kernel: hde: SAMSUNG SV8004H, ATA DISK drive
Jan  4 18:04:33 beige kernel: blk: queue c0328c38, I/O limit 4095Mb (mask 0xffffffff)
Jan  4 18:04:33 beige kernel: hdg: SAMSUNG SV8004H, ATA DISK drive
Jan  4 18:04:33 beige kernel: blk: queue c03290a4, I/O limit 4095Mb (mask 0xffffffff)
Jan  4 18:04:33 beige kernel: hdi: Maxtor 4G120J6, ATA DISK drive
Jan  4 18:04:33 beige kernel: blk: queue c0329510, I/O limit 4095Mb (mask 0xffffffff)
Jan  4 18:04:33 beige kernel: hdk: Maxtor 4G120J6, ATA DISK drive
Jan  4 18:04:33 beige kernel: blk: queue c032997c, I/O limit 4095Mb (mask 0xffffffff)
Jan  4 18:04:33 beige kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan  4 18:04:33 beige kernel: ide2 at 0xd000-0xd007,0xb802 on irq 19
Jan  4 18:04:33 beige kernel: ide3 at 0xb400-0xb407,0xb002 on irq 19
Jan  4 18:04:33 beige kernel: ide4 at 0xa400-0xa407,0xa002 on irq 18
Jan  4 18:04:33 beige kernel: ide5 at 0x9800-0x9807,0x9402 on irq 18
Jan  4 18:04:33 beige kernel: hda: 12692736 sectors (6499 MB) w/472KiB Cache, CHS=790/255/63, UDMA(33)
Jan  4 18:04:33 beige kernel: hde: host protected area => 1
Jan  4 18:04:33 beige kernel: hde: 156368016 sectors (80060 MB) w/1945KiB Cache, CHS=155127/16/63, UDMA(33)
Jan  4 18:04:33 beige kernel: hdg: host protected area => 1
Jan  4 18:04:33 beige kernel: hdg: 156368016 sectors (80060 MB) w/1945KiB Cache, CHS=155127/16/63, UDMA(33)
Jan  4 18:04:33 beige kernel: hdi: host protected area => 1
Jan  4 18:04:33 beige kernel: hdi: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(66)
Jan  4 18:04:33 beige kernel: hdk: host protected area => 1
Jan  4 18:04:33 beige kernel: hdk: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(66)
Jan  4 18:04:33 beige kernel: Partition check:
Jan  4 18:04:33 beige kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 >
Jan  4 18:04:33 beige kernel:  /dev/ide/host2/bus0/target0/lun0:<6> [PTBL] [9733/255/63] p1 p2
Jan  4 18:04:33 beige kernel:  /dev/ide/host2/bus1/target0/lun0:<6> [PTBL] [9733/255/63] p1 p2
Jan  4 18:04:33 beige kernel:  /dev/ide/host4/bus0/target0/lun0: p1
Jan  4 18:04:33 beige kernel:  /dev/ide/host4/bus1/target0/lun0: p1
Jan  4 18:04:33 beige kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jan  4 18:04:33 beige kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jan  4 18:04:33 beige kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Jan  4 18:04:33 beige kernel: TCP: Hash tables configured (established 32768 bind 32768)
Jan  4 18:04:33 beige kernel: Linux IP multicast router 0.06 plus PIM-SM
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jan  4 18:04:33 beige kernel: Mounted devfs on /dev
Jan  4 18:04:33 beige kernel: Freeing unused kernel memory: 268k freed
Jan  4 18:04:33 beige kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Jan  4 18:04:33 beige kernel: Adding Swap: 498004k swap-space (priority -1)
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
Jan  4 18:04:33 beige kernel: Real Time Clock Driver v1.10e
Jan  4 18:04:33 beige kernel: LVM version 1.0.5+(22/07/2002) module loaded
Jan  4 18:04:33 beige kernel: loop: loaded (max 8 devices)
Jan  4 18:04:33 beige kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: EXT3-fs: unable to read superblock
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,10), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,7), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,1), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,0), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,2), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,3), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,4), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: kjournald starting.  Commit interval 5 seconds
Jan  4 18:04:33 beige kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,5), internal journal
Jan  4 18:04:33 beige kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan  4 18:04:33 beige kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
Jan  4 18:04:33 beige kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jan  4 18:04:33 beige kernel: eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:A0:C9:B6:E8:5E, IRQ 16.
Jan  4 18:04:33 beige kernel:   Receiver lock-up bug exists -- enabling work-around.
Jan  4 18:04:33 beige kernel:   Board assembly 668081-004, Physical connectors present: RJ45
Jan  4 18:04:33 beige kernel:   Primary interface chip i82555 PHY #1.
Jan  4 18:04:33 beige kernel:   General self-test: passed.
Jan  4 18:04:33 beige kernel:   Serial sub-system self-test: passed.
Jan  4 18:04:33 beige kernel:   Internal registers self-test: passed.
Jan  4 18:04:33 beige kernel:   ROM checksum self-test: passed (0x3c15c8f1).
Jan  4 18:04:33 beige kernel:   Receiver lock-up workaround activated.
Jan  4 18:04:33 beige kernel: Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
Jan  4 18:04:33 beige kernel: tulip0:  EEPROM default media type Autosense.
Jan  4 18:04:33 beige kernel: tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Jan  4 18:04:33 beige kernel: tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
Jan  4 18:04:33 beige kernel: eth1: Digital DS21143 Tulip rev 65 at 0x8800, 00:C0:F0:4C:08:5D, IRQ 17.
Jan  4 18:04:33 beige kernel: HTB init, kernel part version 3.7
Jan  4 18:04:33 beige kernel: htb*g j=2276
Jan  4 18:04:33 beige kernel: htb*r7 m=0
Jan  4 18:04:33 beige kernel: htb*r6 m=0
Jan  4 18:04:33 beige kernel: htb*r5 m=0
Jan  4 18:04:33 beige kernel: htb*r4 m=0
Jan  4 18:04:33 beige kernel: htb*r3 m=0
Jan  4 18:04:33 beige kernel: htb*r2 m=0
Jan  4 18:04:33 beige kernel: htb*r1 m=0
Jan  4 18:04:33 beige kernel: htb*r0 m=0
Jan  4 18:04:33 beige kernel: eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
Jan  4 18:04:33 beige kernel: ip_tables: (C) 2000-2002 Netfilter core team

--=-=-=



-- 
Per Andreas Buer

--=-=-=--
