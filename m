Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268707AbUJTRjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268707AbUJTRjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUJTRjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:39:15 -0400
Received: from mproxy.gmail.com ([216.239.56.240]:2258 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268775AbUJTRdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:33:45 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=PFbJQDqp/pIHbk8d4pM9kBIMx/4HzGDWvqd62opxwgmsRxoHPQgtNzNb4fJNskChs0gvUQlbT5Oj18fPKMa8uS0i4FVMCcbub3wegkA731+plBj0Pbym6Sq8CP+BsQjMajS6KcnQk6pRmgLyIg1KWx2F0Ua/UYBMnmqRTihC1ss
Message-ID: <8ea6b54a041020103338194a59@mail.gmail.com>
Date: Wed, 20 Oct 2004 10:33:43 -0700
From: "Victor B." <biques@gmail.com>
Reply-To: "Victor B." <biques@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1 kernel panicking (free_hot_cold_page in kswapd0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings All,

I have a production web server which is panicking about once a week. 
I see the following in our log file:

Oct 20 04:40:41 mina kernel: Bad page state at free_hot_cold_page (in
process 'kswapd0', page c15478c0)
Oct 20 04:40:41 mina kernel: flags:0x20000008 mapping:eec45cb8
mapcount:0 count:0
Oct 20 04:40:41 mina kernel: Backtrace:
Oct 20 04:40:41 mina kernel:  [<c0105337>] dump_stack+0x1e/0x22
Oct 20 04:40:41 mina kernel:  [<c01356af>] bad_page+0x6e/0x9b
Oct 20 04:40:41 mina kernel:  [<c0135c40>] free_hot_cold_page+0x65/0x130
Oct 20 04:40:41 mina kernel:  [<c0136337>] __pagevec_free+0x1b/0x24
Oct 20 04:40:41 mina kernel:  [<c013c506>] release_pages+0x159/0x1d9
Oct 20 04:40:41 mina kernel:  [<c013c5af>] __pagevec_release+0x29/0x36
Oct 20 04:40:41 mina kernel:  [<c013df76>] shrink_cache+0x326/0x44e
Oct 20 04:40:41 mina kernel:  [<c013e7da>] shrink_zone+0xc0/0xdd
Oct 20 04:40:41 mina kernel:  [<c013ec01>] balance_pgdat+0x20b/0x29b
Oct 20 04:40:41 mina kernel:  [<c013ed6e>] kswapd+0xdd/0xdf
Oct 20 04:40:41 mina kernel:  [<c0102661>] kernel_thread_helper+0x5/0xb
Oct 20 04:40:41 mina kernel: Trying to fix it up, but a reboot is needed

This may be repeated more than once.  The server seems to be fine
until I try a reboot at which point it freezes and requires a power
cycle.

I've read oops-tracing.txt, but running ksymoops outputs information
identical to the above log message.

The server hardware is pretty standard (single hyperthreading p4 cpu
with smp kernel).  The most unusual piece of hardware is a 3ware SATA
RAID controller set up with a RAID 5 array (5 disks) off of which the
system is running.

I've tried various kernel setups with very little success.  I'm
currently running kernel version 2.6.8.1, compiled statically
(loadable module support disabled).

I haven't been able to determine what triggers the problem, however as
a very general rule, it seems to happen more often during periods of
heavy server load (such as during a system backup or while grepping
through a 500+ MB text file).

I've read the FAQs and searched the archive but haven't come up with
any helpful information.  I welcome any suggestions, RTFMs, etc.  I'm
out of ideas.

I've included dmesg and my kernel .config at the end of the message.

Thanks to anyone with any suggestions.

Victor B.

**** kernel .config (comments stripped out)
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_NR_CPUS=8
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_ACPI_BOOT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_PCMCIA_PROBE=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_8139TOO=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

**** DMESG:
Linux version 2.6.8.1 (root@mina) (gcc version 3.2.3) #1 SMP Thu Sep
23 08:22:42 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff30000 (usable)
 BIOS-e820: 000000007ff30000 - 000000007ff40000 (ACPI data)
 BIOS-e820: 000000007ff40000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f5b20
ACPI: RSDT (v001 INTEL  D865PERL 0x20030520 MSFT 0x00000097) @ 0x7ff30000
ACPI: FADT (v002 INTEL  D865PERL 0x20030520 MSFT 0x00000097) @ 0x7ff30200
ACPI: MADT (v001 INTEL  D865PERL 0x20030520 MSFT 0x00000097) @ 0x7ff30300
ACPI: WDDT (v001 INTEL  OEMWDDT  0x00000001 MSFT 0x0100000d) @ 0x7ff34470
ACPI: DSDT (v001 INTEL  D865PERL 0x00000006 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:  Product ID: Springdale-G APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux-2.6.8.1-s ro root=801
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2593.894 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 904940k/917504k available (2264k kernel code, 11784k reserved,
931k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5128.19 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
per-CPU timeslice cutoff: 1463.30 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5177.34 BogoMIPS
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Total of 2 processors activated (10305.53 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-20, 2-21 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 27.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B1
 12 001 01  1    1    0   1   0    1    1    B9
 13 001 01  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 001 01  1    1    0   1   0    1    1    C9
 17 001 01  1    1    0   1   0    1    1    D1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2593.0119 MHz.
..... host bus clock speed is 199.0470 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 03
  groups: 01 02
CPU1:  online
 domain 0: span 03
  groups: 02 01
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I1,P0) -> 22
PCI->APIC IRQ transform: (B2,I3,P0) -> 19
PCI->APIC IRQ transform: (B2,I4,P0) -> 18
PCI->APIC IRQ transform: (B2,I7,P0) -> 17
Machine check exception polling timer started.
Starting balanced_irq
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
eth0: 0000:02:03.0, 00:02:B3:CA:EA:40, IRQ 19.
  Board assembly 751767-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x3258698e).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: PIONEER DVD-RW DVR-104, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:6): 40.000MB/s transfers (20.000MHz, offset 32, 16bit)
  Vendor: SEAGATE   Model: DAT    9SP40-000  Rev: 9100
  Type:   Sequential-Access                  ANSI SCSI revision: 03
3ware Storage Controller device driver for Linux v1.26.00.039.
scsi1 : Found a 3ware Storage Controller at 0xb400, IRQ: 18, P-chip: 1.3
scsi1 : 3ware Storage Controller
  Vendor: 3ware     Model: Logical Disk 1    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
st: Version 20040403, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 6, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
SCSI device sda: 216898944 512-byte hdwr sectors (111052 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
Attached scsi disk sda at scsi1, channel 0, id 1, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 6, lun 0,  type 1
Attached scsi generic sg1 at scsi1, channel 0, id 1, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 2097136k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sda8: found reiserfs format "3.6" with standard journal
ReiserFS: sda8: using ordered data mode
ReiserFS: sda8: journal params: device sda8, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda8: checking transaction log (sda8)
ReiserFS: sda8: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
