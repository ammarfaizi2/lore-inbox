Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133071AbRECTvg>; Thu, 3 May 2001 15:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133097AbRECTv3>; Thu, 3 May 2001 15:51:29 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:8674 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S133040AbRECTvI>; Thu, 3 May 2001 15:51:08 -0400
Message-Id: <200105031951.OAA09136@asooo.flowerfire.com>
Date: Thu, 3 May 2001 12:51:04 -0700
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
X-Mailer: Apple Mail (2.388)
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v388)
In-Reply-To: <200105031751.LAA24795@iiwi.lanl.gov>
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just wanted to throw in my two cents and say that there appear to be 
widespread issues with the APIC code in 2.4.x.  I'm tempted to stick my 
neck out and say that it might be best to disable SMP IOAPIC by default 
until APIC can be massaged, at least for a wider variety of hardware.

I'm getting many replies to my "Persistent 2.4.x stability problem" 
post.  Manfred Spraul has been extremely helpful in working through the 
issue with me and providing the "noapic" work-around, but this problem 
is fairly subtle and is most likely effecting a lot more people than 
those reporting the issue.

It seems like some Tyan motherboards and _all_ HP hardware do not play 
well with the APIC code.  That's a pretty big subset of hardware; Asus 
also seems to be effected now, and many other platforms may also suffer 
from APICitis.  I realize there are different failure modes and I assume 
different issues are involved within the APIC code.

I have HP hardware that I can make available for patches and tests -- I 
want to help solve this and contribute what I can.  Using "noapic" does 
take the pressure off the issue, but I guess this problem remains 
insidious in my mind.  I realize I'm not fully familiar with the general 
issues, so I apologize if I'm re-covering old ground or missing any 
relevant issues.

Thanks,
--
Ken.

On Thursday, May 3, 2001, at 10:51 AM, David A. Neal wrote:

> I am encountering a problem I am having a little difficulty
> trying to solve. I have a system with a ASUS CUV4X-DLS system
> board, Bios 1004, 1GB of memory. dual P3 933MHz processors,
> a G450 Matrox card in the AGP slot, and a SBLive! sound
> card in PCI Slot 4.
>
> I have provided the output from dmesg below and the .config
> file I used in compiling the 2.4.4 kernel on this system
> with a Redhat 7.1 (Seawolf) distribution.
>
> The problem is that the system will boot everytime if and only
> if I use "noapic". If I do not use "noapic", the system will
> boot sometimes. The dmesg info below is from a successful boot
> when I did not use "noapic". When I do not use "noapic"
> __and__ it does not boot, the boot sequence stops at
>
>    ..TIMER: vector=49 pin1=2 pin2=0
>
> Matter of fact, the first boot after installing Redhat 7.1 stop
> at the same message/location with the 2.4.2 kernel.
>
> I thought about "append"(ing) some "pirq" arguments to the boot
> but I really not sure how to do this and whether or not it
> would fix the problem.
>
> What is the impact on performance by disabling APIC? Is there
> something wrong with the .config file that might fix this.
>
>
> =================== Begin dmesg 
> info ======================================
> Linux version 2.4.4 (root@ouzel) (gcc version 2.96 20000731 (Red Hat 
> Linux 7.1 2.96-81)) #2 SMP Wed May 2 17:19:43 MDT 2001
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
>  BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
>  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 127MB HIGHMEM available.
> Scan SMP from c0000000 for 1024 bytes.
> Scan SMP from c009fc00 for 1024 bytes.
> Scan SMP from c00f0000 for 65536 bytes.
> found SMP MP-table at 000f54c0
> hm, page 000f5000 reserved twice.
> hm, page 000f6000 reserved twice.
> hm, page 000f5000 reserved twice.
> hm, page 000f6000 reserved twice.
> On node 0 totalpages: 262140
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 32764 pages.
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
> Processor #3 Pentium(tm) Pro APIC version 17
>     Floating point unit present.
>     Machine Exception supported.
>     64 bit compare & exchange supported.
>     Internal APIC present.
>     SEP present.
>     MTRR  present.
>     PGE  present.
>     MCA  present.
>     CMOV  present.
>     PAT  present.
>     PSE  present.
>     MMX  present.
>     FXSR  present.
>     XMM  present.
>     Bootup CPU
> Processor #0 Pentium(tm) Pro APIC version 17
>     Floating point unit present.
>     Machine Exception supported.
>     64 bit compare & exchange supported.
>     Internal APIC present.
>     SEP present.
>     MTRR  present.
>     PGE  present.
>     MCA  present.
>     CMOV  present.
>     PAT  present.
>     PSE  present.
>     MMX  present.
>     FXSR  present.
>     XMM  present.
> Bus #0 is PCI
> Bus #1 is PCI
> Bus #2 is ISA
> I/O APIC #2 Version 17 at 0xFEC00000.
> Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
> Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
> Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
> Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
> Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
> Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
> Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
> Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
> Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
> Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
> Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
> Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
> Int: type 0, pol 3, trig 3, bus 2, IRQ 00, APIC ID 2, APIC INT 00
> Int: type 0, pol 3, trig 3, bus 0, IRQ 13, APIC ID 2, APIC INT 12
> Int: type 0, pol 3, trig 3, bus 0, IRQ 1c, APIC ID 2, APIC INT 11
> Int: type 0, pol 3, trig 3, bus 0, IRQ 20, APIC ID 2, APIC INT 13
> Int: type 0, pol 3, trig 3, bus 0, IRQ 21, APIC ID 2, APIC INT 10
> Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 2, APIC INT 12
> Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
> Lint: type 1, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
> Processors: 2
> mapped APIC to ffffe000 (fee00000)
> mapped IOAPIC to ffffd000 (fec00000)
> Kernel command line: auto BOOT_IMAGE=linux ro root=801 
> BOOT_FILE=/boot/vmlinuz-2.4.4
> Initializing CPU#0
> Detected 937.577 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 1867.77 BogoMIPS
> Memory: 1028188k/1048560k available (1353k kernel code, 19984k 
> reserved, 560k data, 228k init, 131056k highmem)
> Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
> Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
> CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
> CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU: Common caps: 0383fbff 00000000 00000000 00000000
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> Intel machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
> CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU: Common caps: 0383fbff 00000000 00000000 00000000
> CPU0: Intel Pentium III (Coppermine) stepping 06
> per-CPU timeslice cutoff: 731.39 usecs.
> Getting VERSION: 40011
> Getting VERSION: 40011
> Getting ID: 3000000
> Getting ID: c000000
> Getting LVT0: 8700
> Getting LVT1: 400
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> CPU present map: 9
> Booting processor 1/0 eip 2000
> Setting warm reset code and vector.
> 1.
> 2.
> 3.
> Asserting INIT.
> Waiting for send to finish...
> +Deasserting INIT.
> Waiting for send to finish...
> +#startup loops: 2.
> Sending STARTUP #1.
> After apic_write.
> Initializing CPU#1
> CPU#1 (phys ID: 0) waiting for CALLOUT
> Startup point 1.
> Waiting for send to finish...
> +Sending STARTUP #2.
> After apic_write.
> Startup point 1.
> Waiting for send to finish...
> +After Startup.
> Before Callout 1.
> After Callout 1.
> CALLIN, before setup_local_APIC().
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 1874.32 BogoMIPS
> Stack at about c211dfb8
> CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> Intel machine check reporting enabled on CPU#1.
> CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
> CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
> CPU: Common caps: 0383fbff 00000000 00000000 00000000
> OK.
> CPU1: Intel Pentium III (Coppermine) stepping 06
> CPU has booted.
> Before bogomips.
> Total of 2 processors activated (3742.10 BogoMIPS).
> Before bogocount - setting activated=1.
> Boot done.
> ENABLING IO-APIC IRQs
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> Synchronizing Arb IDs.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-5, 2-9, 2-10, 2-11, 2-13, 2-20, 2-21, 2-22, 
> 2-23 not connected.
> ..TIMER: vector=49 pin1=2 pin2=0
> number of MP IRQ sources: 18.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
>
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .... register #01: 00178011
> .......     : max redirection entries: 0017
> .......     : IO APIC version: 0011
>  WARNING: unexpected IO-APIC, please mail
>           to linux-smp@vger.kernel.org
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 003 03  0    1    1   1   1    1    1    31
>  01 003 03  0    0    0   0   0    1    1    39
>  02 003 03  0    0    0   0   0    1    1    31
>  03 003 03  0    0    0   0   0    1    1    41
>  04 003 03  0    0    0   0   0    1    1    49
>  05 000 00  1    0    0   0   0    0    0    00
>  06 003 03  0    0    0   0   0    1    1    51
>  07 003 03  0    0    0   0   0    1    1    59
>  08 003 03  0    0    0   0   0    1    1    61
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 000 00  1    0    0   0   0    0    0    00
>  0c 003 03  0    0    0   0   0    1    1    69
>  0d 000 00  1    0    0   0   0    0    0    00
>  0e 003 03  0    0    0   0   0    1    1    71
>  0f 003 03  0    0    0   0   0    1    1    79
>  10 003 03  1    1    0   1   0    1    1    81
>  11 003 03  1    1    0   1   0    1    1    89
>  12 003 03  1    1    0   1   0    1    1    91
>  13 003 03  1    1    0   1   0    1    1    99
>  14 000 00  1    0    0   0   0    0    0    00
>  15 000 00  1    0    0   0   0    0    0    00
>  16 000 00  1    0    0   0   0    0    0    00
>  17 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0-> 2
> IRQ1 -> 1
> IRQ3 -> 3
> IRQ4 -> 4
> IRQ6 -> 6
> IRQ7 -> 7
> IRQ8 -> 8
> IRQ12 -> 12
> IRQ14 -> 14
> IRQ15 -> 15
> IRQ16 -> 16
> IRQ17 -> 17
> IRQ18 -> 18
> IRQ19 -> 19
> .................................... done.
> calibrating APIC timer ...
> ..... CPU clock speed is 937.6805 MHz.
> ..... host bus clock speed is 133.9542 MHz.
> cpu: 0, clocks: 1339542, slice: 446514
> CPU0<T0:1339536,T1:893008,D:14,S:446514,C:1339542>
> cpu: 1, clocks: 1339542, slice: 446514
> CPU1<T0:1339536,T1:445552,D:956,S:446514,C:1339542>
> checking TSC synchronization across CPUs: passed.
> Setting commenced=1, go go go
> PCI: PCI BIOS revision 2.10 entry at 0xf0d00, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Disabled enhanced CPU to PCI posting
> PCI: Disabled enhanced CPU to PCI posting #2
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router VIA [1106/0686] at 00:04.0
> PCI->APIC IRQ transform: (B0,I4,P3) -> 18
> PCI->APIC IRQ transform: (B0,I4,P3) -> 18
> PCI->APIC IRQ transform: (B0,I7,P0) -> 17
> PCI->APIC IRQ transform: (B0,I8,P0) -> 19
> PCI->APIC IRQ transform: (B0,I8,P1) -> 16
> PCI->APIC IRQ transform: (B0,I10,P0) -> 18
> PCI->APIC IRQ transform: (B1,I0,P0) -> 16
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> i2c-core.o: i2c core module
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> pty: 256 Unix98 ptys configured
> block: queued sectors max/low 683440kB/552368kB, 2048 slots per queue
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 21
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> hda: RICOH CD-R/RW MP7120A, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache
> Uniform CD-ROM driver Revision: 3.12
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> Loading I2O Core - (c) Copyright 1999 Red Hat Software
> Linux I2O PCI support (c) 1999 Red Hat Software.
> i2o: Checking for PCI I2O controllers...
> I2O configuration manager v 0.04.
>   (C) Copyright 1999 Red Hat Software
> I2O Block Storage OSM v0.9
>    (c) Copyright 1999, 2000 Red Hat Software.
> I2O LAN OSM (C) 1999 University of Helsinki.
> loop: loaded (max 8 devices)
> Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ 
> SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Real Time Clock Driver v1.10d
> eepro100.c:v1.09j-t 9/29/99 Donald Becker 
> http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. 
> Savochkin <saw@saw.sw.com.sg> and others
> eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:E0:18:06:E3:F7, 
> IRQ 17.
>   Board assembly 733470-006, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0x04f4518b).
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 816M
> agpgart: Detected Via Apollo Pro chipset
> agpgart: AGP aperture is 32M @ 0xfc000000
> [drm] AGP 0.99 on VIA Apollo Pro @ 0xfc000000 32MB
> [drm] Initialized tdfx 1.0.0 20000928 on minor 63
> [drm] AGP 0.99 on VIA Apollo Pro @ 0xfc000000 32MB
> [drm] Initialized radeon 1.0.0 20010105 on minor 62
> SCSI subsystem driver Revision: 1.00
> sym53c8xx: at PCI bus 0, device 8, function 0
> sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
> sym53c8xx: 53c1010-33 detected with Symbios NVRAM
> sym53c8xx: at PCI bus 0, device 8, function 1
> sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
> sym53c8xx: 53c1010-33 detected with Symbios NVRAM
> sym53c1010-33-0: rev 0x1 on pci bus 0 device 8 function 0 irq 19
> sym53c1010-33-0: Symbios format NVRAM, ID 7, Fast-80, Parity Checking
> sym53c1010-33-0: on-chip RAM at 0xf6800000
> sym53c1010-33-0: restart (scsi reset).
> sym53c1010-33-0: handling phase mismatch from SCRIPTS.
> sym53c1010-33-0: Downloading SCSI SCRIPTS.
> sym53c1010-33-1: rev 0x1 on pci bus 0 device 8 function 1 irq 16
> sym53c1010-33-1: Symbios format NVRAM, ID 7, Fast-80, Parity Checking
> sym53c1010-33-1: on-chip RAM at 0xf5800000
> sym53c1010-33-1: restart (scsi reset).
> sym53c1010-33-1: handling phase mismatch from SCRIPTS.
> sym53c1010-33-1: Downloading SCSI SCRIPTS.
> scsi0 : sym53c8xx-1.7.3a-20010304
> scsi1 : sym53c8xx-1.7.3a-20010304
>   Vendor: WDIGTL    Model: WDE18310 ULTRA3   Rev: 1.30
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> sym53c1010-33-0-<0,0>: tagged command queue depth set to 4
> Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
> sym53c1010-33-0-<0,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
> SCSI device sda: 35761710 512-byte hdwr sectors (18310 MB)
> Partition check:
>  sda: sda1 sda2 sda3 sda4
> Creative EMU10K1 PCI Audio Driver, version 0.7, 16:51:09 May  2 2001
> emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xa800-0xa81f, IRQ 18
> usb.c: registered new driver hub
> uhci.c: USB UHCI at I/O 0xd400, IRQ 18
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> uhci.c: USB UHCI at I/O 0xd000, IRQ 18
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> i2o_scsi.c: Version 0.0.1
>   chain_pool: 0 bytes @ f7cc5e00
>   (512 byte buffers X 4 can_queue X 0 i2o controllers)
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 228k freed
> Adding Swap: 2097136k swap-space (priority -1)
>
>
> ==================== Begin .config ============================
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_ISA=y
> # CONFIG_SBUS is not set
> CONFIG_UID16=y
>
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
>
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
>
> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_HIGHMEM=y
> # CONFIG_MATH_EMULATION is not set
> # CONFIG_MTRR is not set
> CONFIG_SMP=y
> CONFIG_HAVE_DEC_LOCK=y
>
> #
> # General setup
> #
> CONFIG_NET=y
> # CONFIG_VISWS is not set
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_NAMES=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_HOTPLUG is not set
> # CONFIG_PCMCIA is not set
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> CONFIG_BINFMT_AOUT=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=y
> # CONFIG_PM is not set
> # CONFIG_ACPI is not set
> # CONFIG_APM is not set
>
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
>
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
>
> #
> # Plug and Play configuration
> #
> # CONFIG_PNP is not set
> # CONFIG_ISAPNP is not set
>
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_NBD is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
>
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> # CONFIG_BLK_DEV_MD is not set
> # CONFIG_MD_LINEAR is not set
> # CONFIG_MD_RAID0 is not set
> # CONFIG_MD_RAID1 is not set
> # CONFIG_MD_RAID5 is not set
> # CONFIG_BLK_DEV_LVM is not set
>
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> # CONFIG_NETLINK is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_FILTER is not set
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_INET_ECN is not set
> CONFIG_SYN_COOKIES=y
> # CONFIG_IPV6 is not set
> # CONFIG_KHTTPD is not set
> # CONFIG_ATM is not set
>
> #
> #
> #
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_LLC is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
>
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
>
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> # CONFIG_PHONE_IXJ is not set
>
> #
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=y
>
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
>
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> # CONFIG_BLK_DEV_IDEDISK is not set
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
> # CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
> # CONFIG_BLK_DEV_IDEDISK_IBM is not set
> # CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
> # CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
> # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
> # CONFIG_BLK_DEV_IDEDISK_WD is not set
> # CONFIG_BLK_DEV_COMMERIAL is not set
> # CONFIG_BLK_DEV_TIVO is not set
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
>
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_BLK_DEV_CMD640=y
> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> # CONFIG_BLK_DEV_ISAPNP is not set
> CONFIG_BLK_DEV_RZ1000=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_IDEDMA_PCI is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_IDEDMA_PCI_AUTO is not set
> # CONFIG_BLK_DEV_IDEDMA is not set
> # CONFIG_IDEDMA_PCI_WIP is not set
> # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_AEC62XX_TUNING is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_WDC_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD7409 is not set
> # CONFIG_AMD7409_OVERRIDE is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_HPT34X_AUTODMA is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_PIIX_TUNING is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX is not set
> # CONFIG_PDC202XX_BURST is not set
> # CONFIG_BLK_DEV_OSB4 is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> # CONFIG_IDEDMA_AUTO is not set
> # CONFIG_DMA_NONPCI is not set
> CONFIG_BLK_DEV_IDE_MODES=y
>
> #
> # SCSI support
> #
> CONFIG_SCSI=y
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_SD_EXTRA_DEVS=40
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> # CONFIG_CHR_DEV_SG is not set
>
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_DEBUG_QUEUES=y
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> # CONFIG_SCSI_LOGGING is not set
>
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> CONFIG_SCSI_SYM53C8XX=y
> CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
> CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
> CONFIG_SCSI_NCR53C8XX_SYNC=20
> # CONFIG_SCSI_NCR53C8XX_PROFILE is not set
> # CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
> # CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
> # CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_DEBUG is not set
>
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
>
> #
> # I2O device support
> #
> CONFIG_I2O=y
> CONFIG_I2O_PCI=y
> CONFIG_I2O_BLOCK=y
> CONFIG_I2O_LAN=y
> CONFIG_I2O_SCSI=y
> CONFIG_I2O_PROC=y
>
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
>
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_NET_SB1000 is not set
>
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_TULIP is not set
> # CONFIG_DE4X5 is not set
> # CONFIG_DGRS is not set
> # CONFIG_DM9102 is not set
> CONFIG_EEPRO100=y
> # CONFIG_EEPRO100_PM is not set
> # CONFIG_LNE390 is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_NE3210 is not set
> # CONFIG_ES3210 is not set
> # CONFIG_8139TOO is not set
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_NET_POCKET is not set
>
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
>
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
>
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
>
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
>
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
>
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
>
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
>
> #
> # Input core support
> #
> # CONFIG_INPUT is not set
>
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> # CONFIG_SERIAL_CONSOLE is not set
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
>
> #
> # I2C support
> #
> CONFIG_I2C=y
> # CONFIG_I2C_ALGOBIT is not set
> # CONFIG_I2C_ALGOPCF is not set
> CONFIG_I2C_CHARDEV=y
>
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> # CONFIG_82C710_MOUSE is not set
> # CONFIG_PC110_PAD is not set
>
> #
> # Joysticks
> #
> # CONFIG_JOYSTICK is not set
>
> #
> # Input core support is needed for joysticks
> #
> # CONFIG_QIC02_TAPE is not set
>
> #
> # Watchdog Cards
> #
> CONFIG_WATCHDOG=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> # CONFIG_SOFT_WATCHDOG is not set
> # CONFIG_WDT is not set
> # CONFIG_WDTPCI is not set
> # CONFIG_PCWATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_MIXCOMWD is not set
> # CONFIG_I810_TCO is not set
> # CONFIG_MACHZ_WDT is not set
> # CONFIG_INTEL_RNG is not set
> # CONFIG_NVRAM is not set
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
>
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=y
> CONFIG_AGP_INTEL=y
> CONFIG_AGP_I810=y
> CONFIG_AGP_VIA=y
> CONFIG_AGP_AMD=y
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_ALI is not set
> CONFIG_DRM=y
> CONFIG_DRM_TDFX=y
> # CONFIG_DRM_GAMMA is not set
> # CONFIG_DRM_R128 is not set
> CONFIG_DRM_RADEON=y
> # CONFIG_DRM_I810 is not set
> # CONFIG_DRM_MGA is not set
>
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
>
> #
> # File systems
> #
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_ADFS_FS_RW is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BFS_FS is not set
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> # CONFIG_UMSDOS_FS is not set
> CONFIG_VFAT_FS=y
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS_FS is not set
> # CONFIG_CRAMFS is not set
> CONFIG_TMPFS=y
> # CONFIG_RAMFS is not set
> CONFIG_ISO9660_FS=y
> # CONFIG_JOLIET is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS_RW is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVFS_MOUNT is not set
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=y
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX4FS_RW is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=y
> # CONFIG_SYSV_FS is not set
> # CONFIG_SYSV_FS_WRITE is not set
> # CONFIG_UDF_FS is not set
> # CONFIG_UDF_RW is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_UFS_FS_WRITE is not set
>
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFSD is not set
> # CONFIG_NFSD_V3 is not set
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> # CONFIG_SMB_FS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_NCPFS_PACKET_SIGNING is not set
> # CONFIG_NCPFS_IOCTL_LOCKING is not set
> # CONFIG_NCPFS_STRONG is not set
> # CONFIG_NCPFS_NFS_NS is not set
> # CONFIG_NCPFS_OS2_NS is not set
> # CONFIG_NCPFS_SMALLDOS is not set
> # CONFIG_NCPFS_NLS is not set
> # CONFIG_NCPFS_EXTRAS is not set
>
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_SMB_NLS is not set
> CONFIG_NLS=y
>
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
>
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_VIDEO_SELECT is not set
> # CONFIG_MDA_CONSOLE is not set
>
> #
> # Frame-buffer support
> #
> # CONFIG_FB is not set
>
> #
> # Sound
> #
> CONFIG_SOUND=y
> # CONFIG_SOUND_CMPCI is not set
> CONFIG_SOUND_EMU10K1=y
> # CONFIG_SOUND_FUSION is not set
> # CONFIG_SOUND_CS4281 is not set
> # CONFIG_SOUND_ES1370 is not set
> # CONFIG_SOUND_ES1371 is not set
> # CONFIG_SOUND_ESSSOLO1 is not set
> # CONFIG_SOUND_MAESTRO is not set
> # CONFIG_SOUND_MAESTRO3 is not set
> # CONFIG_SOUND_ICH is not set
> # CONFIG_SOUND_SONICVIBES is not set
> # CONFIG_SOUND_TRIDENT is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_VIA82CXXX is not set
> # CONFIG_SOUND_OSS is not set
> # CONFIG_SOUND_TVMIXER is not set
>
> #
> # USB support
> #
> CONFIG_USB=y
> # CONFIG_USB_DEBUG is not set
>
> #
> # Miscellaneous USB options
> #
> # CONFIG_USB_DEVICEFS is not set
> # CONFIG_USB_BANDWIDTH is not set
>
> #
> # USB Controllers
> #
> CONFIG_USB_UHCI_ALT=y
> # CONFIG_USB_OHCI is not set
>
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_AUDIO is not set
> # CONFIG_USB_BLUETOOTH is not set
> CONFIG_USB_STORAGE=y
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
>
> #
> # USB Human Interface Devices (HID)
> #
>
> #
> #   Input core support is needed for USB HID
> #
>
> #
> # USB Imaging devices
> #
> # CONFIG_USB_DC2XX is not set
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_SCANNER is not set
> # CONFIG_USB_MICROTEK is not set
>
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_IBMCAM is not set
> # CONFIG_USB_OV511 is not set
> # CONFIG_USB_DSBR is not set
> # CONFIG_USB_DABUSB is not set
>
> #
> # USB Network adaptors
> #
> # CONFIG_USB_PLUSB is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_NET1080 is not set
>
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
>
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
>
> #
> # USB misc drivers
> #
> # CONFIG_USB_RIO500 is not set
>
> #
> # Kernel hacking
> #
> # CONFIG_MAGIC_SYSRQ is not set
>
> --
> ++++++++++++++++++++++++++++++++++++++++++++++
> Dave Neal,        Center for Nonlinear Studies
> Phone w/ Voice Mail             (505) 665-6471
> Digital Pager - (505) 664-8666
> Wirth's Law: Software gets slower faster than
> Hardware gets faster!
> ++++++++++++++++++++++++++++++++++++++++++++++
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
