Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTAPVQX>; Thu, 16 Jan 2003 16:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTAPVQX>; Thu, 16 Jan 2003 16:16:23 -0500
Received: from ns0.cobite.com ([208.222.80.10]:15630 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S266453AbTAPVQD>;
	Thu, 16 Jan 2003 16:16:03 -0500
Date: Thu, 16 Jan 2003 16:24:56 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: aic7xxx fails to boot in 2.5.58
Message-ID: <Pine.LNX.4.44.0301161613160.18452-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Justin, lists:

I am attempting to boot 2.5.58 vanilla on an HP3000 U3 with on-board 
adaptec controller.  It won't boot past the SCSI initialization.  

It run's great, even under high loads, with 2.4.20aa2 which is running 
driver version 6.2.8 (according to boot logs).  It also has run fine under 
every Red Hat kernel so far (all 2.4.18-xxx).

System is dual 866 Pentium III, 2gb ram.  Kernel is compiled with:

gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-112)

(/proc/pci output and .config follow the serial-console bootup capture)

Here's what I get when booting:

Linux version 2.5.58 (root@theo.cobite.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-112)) #4 SMP Sun Dec 15 11:31:24 EST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
 BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffffc00 (ACPI data)
 BIOS-e820: 000000007ffffc00 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fffe6400 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7630
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
On node 0 totalpages: 524272
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294896 pages, LIFO batch:16
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f75c0
ACPI: RSDT (v001 PTLTD  HWPC221  00000.00001) @ 0x7fffbac7
ACPI: FADT (v001 HP     HWPC20A  00000.00001) @ 0x7ffffadd
ACPI: MADT (v001 PTLTD    APIC   00000.00001) @ 0x7ffffb51
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 00000.00001) @ 0x7ffffbd9
ACPI: DSDT (v001     HP LH3000U3 00000.00001) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-15
ACPI: IOAPIC (id[0x03] address[0xfec01000] global_irq_base[0x10])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, IRQ 16-31
ACPI: INT_SRC_OVR (bus[0] irq[0x5] global_irq[0x5] polarity[0x3] trigger[0x3])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
ACPI: INT_SRC_OVR (bus[0] irq[0xa] global_irq[0xa] polarity[0x3] trigger[0x3])
ACPI: INT_SRC_OVR (bus[0] irq[0xb] global_irq[0xb] polarity[0x3] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: ro root=/dev/md2 console=ttyS0,9600n8
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 866.414 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1712.12 BogoMIPS
Memory: 2071476k/2097088k available (2368k kernel code, 24480k reserved, 718k data, 320k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.68 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1728.51 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3440.64 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
testing the IO APIC.......................


.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 866.0131 MHz.
..... host bus clock speed is 133.0250 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd9a9, last bus=6
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030109
    ACPI-0258: *** Info: GPE Block0 defined as GPE0 to GPE31
    ACPI-1101: *** Error: Method execution failed [\_SB_.PCI0.ISA_.LINK] (Node c24772e0), AE_AML_INTERNAL
    ACPI-1101: *** Error: Method execution failed [\_SB_.PCI0.INIT] (Node f7ff1fe0), AE_AML_INTERNAL
    ACPI-1101: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node f7ff1f60), AE_AML_INTERNAL
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKU] (IRQs 5, disabled)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNK4] (IRQs 9 *11)
ACPI: PCI Interrupt Link [LNK5] (IRQs 9 11, enabled at IRQ 5)
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK9] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Root Bridge [PCI1] (00:03)
PCI: Probing PCI hardware (bus 03)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem driver Revision: 1.00
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK9] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0
Enabling SEP on CPU 1
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.1.29-k1
Copyright (c) 2002 Intel Corporation

Freeing alive device f7f15000, eth%d
e100: eth0: Intel(R) 8255x-based Ethernet Adapter
  Hardware receive checksums enabled
  cpu cycle saver enabled

Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:pio, hdd:pio
hda: LTN486S, ATAPI CD/DVD-ROM drive
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hda, sector 0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.26
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Message-out phase, at SEQADDR 0xcf
ACCUM = 0xa0, SINDEX = 0x61, DINDEX = 0xc0, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
ERROR[0x0] SCSIPHASE[0x0] SCSIBUSL[0xc0] LASTPHASE[0xa0]:(MSGI|CDI) 
SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) SBLKCTL[0x2]:(SELWIDE) 
SEQCTL[0x10]:(FASTMODE) SEQ_FLAGS[0x40]:(NO_CDB_SENT) 
SSTAT0[0x7]:(DMADONE|SPIORDY|SDONE) SSTAT1[0x3]:(REQINIT|PHASECHG) 
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
SXFRCTL0[0xa8]:(SPIOEN|FAST20|DFON) DFCNTRL[0x4]:(DIRECTION) 
DFSTATUS[0x6d]:(FIFOEMP|DFTHRESH|HDONE|FIFOQWDEMP|DFCACHETH) 
STACK: 0x0 0x153 0x194 0xce
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Sequencer SCB Info: 
  0 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) SCB_SCSIID[0x7] SCB_LUN[0x0] 
SCB_TAG[0x3] 
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(LID) SCB_TAG[0xff] 
Pending list: 
  3 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) SCB_SCSIID[0x7] SCB_LUN[0x0] 
Kernel Free SCB list: 1 0 
Untagged Q(0): 3 
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping

<nothing more after this>


-------------------------
Here's /proc/pci:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: ServerWorks CNB20LE Host Bridge (rev 6).
      Master Capable.  Latency=64.  
  Bus  0, device   0, function  1:
    Host bridge: ServerWorks CNB20LE Host Bridge (#2) (rev 6).
      Master Capable.  Latency=64.  
  Bus  0, device   6, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 8).
      IRQ 18.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xe4f80000 [0xe4f80fff].
      I/O at 0x1800 [0x183f].
      Non-prefetchable 32 bit memory at 0xe6000000 [0xe60fffff].
  Bus  0, device   7, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 122).
      IRQ 19.
      Master Capable.  Latency=66.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe5ffffff].
      I/O at 0x1400 [0x14ff].
      Non-prefetchable 32 bit memory at 0xe4f81000 [0xe4f81fff].
  Bus  0, device  15, function  0:
    ISA bridge: ServerWorks OSB4 South Bridge (rev 80).
  Bus  0, device  15, function  1:
    IDE interface: ServerWorks OSB4 IDE Controller (rev 0).
      Master Capable.  Latency=64.  
      I/O at 0x1840 [0x184f].
  Bus  3, device   2, function  0:
    System peripheral: Hewlett-Packard Company NetServer PCI Hot-Plug Controller (rev 11).
      IRQ 16.
      I/O at 0x4000 [0x40ff].
  Bus  3, device   2, function  1:
    InfiniBand: Hewlett-Packard Company NetServer SMIC Controller (rev 11).
      IRQ 17.
      I/O at 0x4400 [0x44ff].
  Bus  3, device   3, function  0:
    PCI bridge: Intel Corp. 80960RP [i960 RP Microprocessor/Bridge] (rev 2).
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=2.
  Bus  3, device   3, function  1:
    I2O: Intel Corp. 80960RP [i960RP Microprocessor] (rev 9).
      IRQ 20.
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
  Bus  4, device   7, function  0:
    SCSI storage controller: Adaptec AIC-7880U (rev 2).
      IRQ 21.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0x5000 [0x50ff].
      Non-prefetchable 32 bit memory at 0xe9100000 [0xe9100fff].
  Bus  4, device   8, function  0:
    System peripheral: Hewlett-Packard Company NetServer Smart IRQ Router (rev 160).
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xe9108000 [0xe910ffff].

--------------------
Config:

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT_15=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_X86_PC=y
CONFIG_MPENTIUMII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NR_CPUS=2
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_MEGARAID=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_BLK_DEV_DM=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_XFRM_USER=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_TUN=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_PCI=y
CONFIG_E100=y
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
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_RAW_DRIVER=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_JFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SMB_FS=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRC32=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y


-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

