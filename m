Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSJPUD0>; Wed, 16 Oct 2002 16:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbSJPUD0>; Wed, 16 Oct 2002 16:03:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3590 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261293AbSJPUDR>;
	Wed, 16 Oct 2002 16:03:17 -0400
Date: Wed, 16 Oct 2002 21:09:14 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.43 oops in adaptec driver
Message-ID: <20021016210914.P15163@parcelfarce.linux.theplanet.co.uk>
References: <20021016184122.J15163@parcelfarce.linux.theplanet.co.uk> <20021016175754.GA8112@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021016175754.GA8112@redhat.com>; from dledford@redhat.com on Wed, Oct 16, 2002 at 01:57:54PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 01:57:54PM -0400, Doug Ledford wrote:
> Duh, forgot to add INIT_LIST_HEAD(&p->aic_devs); to aic7xxx_register() so 
> the list_add() is oopsing.  Patch attached.  Let me know if this *doesn't* 
> solve the problem (I'm not at work where I can test this yet).

well, it partially solves the problem.  it doesn't oops any more, but
it still offlines all the devices.

here's the boot log:

LILO 22.3.3 Loading linux-2.5......................
BIOS data check successful
Linux version 2.5.43 (willy@cl010) (gcc version 2.95.4 20011002 (Debian prerelease)) #20 SMP Wed Oct 16 11:01:56 PDT 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
 BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000ea000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
3712MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009e1d0
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!
On node 0 totalpages: 1179648
  DMA zone: 4096 pages
  Normal zone: 225280 pages
  HighMem zone: 950272 pages
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM ENSW Product ID: NF 6000R SMP APIC at: 0xFEE00000
Processor #3 6:10 APIC version 17
Processor #0 6:10 APIC version 17
Processor #1 6:10 APIC version 17
Processor #2 6:10 APIC version 17
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFEC01000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 4
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux-2.5 ro root=806 console=ttyS0,38400n8 console=tty1
Initializing CPU#0
Detected 702.168 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 970.75 BogoMIPS
Memory: 4308276k/4718592k available (1643k kernel code, 49468k reserved, 704k data, 120k init, 3440640k highmem)
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace: [<c0118f93>]  [<c01325c7>]  [<c0131ba4>]  [<c0105000>] 
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace: [<c0118f93>]  [<c01325c7>]  [<c0105000>]  [<c0131ba4>]  [<c0105000>]  [<c0105000>]  [<c0156124>] 
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Cascades) stepping 01
per-CPU timeslice cutoff: 2923.38 usecs.
task migration cache decay timeout: 3 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1380.35 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Cascades) stepping 01
Booting processor 2/1 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1380.35 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel Pentium III (Cascades) stepping 01
Booting processor 3/2 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1376.25 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel Pentium III (Cascades) stepping 01
Total of 4 processors activated (5107.71 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 14 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 14 ... ok.
Setting 13 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 13 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
testing the IO APIC.......................


.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 701.0558 MHz.
..... host bus clock speed is 100.0217 MHz.
checking TSC synchronization across 4 CPUs: 
BIOS BUG: CPU#0 improperly initialized, has -5 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 2 usecs TSC skew! FIXED.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd32c, last bus=8
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered peer bus 02
PCI: Discovered peer bus 05
PCI->APIC IRQ transform: (B0,I1,P0) -> 20
PCI->APIC IRQ transform: (B0,I5,P0) -> 16
PCI->APIC IRQ transform: (B0,I15,P0) -> 19
PCI->APIC IRQ transform: (B2,I1,P0) -> 17
PCI->APIC IRQ transform: (B2,I1,P1) -> 18
PCI->APIC IRQ transform: (B2,I5,P0) -> 24
PCI->APIC IRQ transform: (B2,I6,P0) -> 25
PCI->APIC IRQ transform: (B5,I2,P0) -> 21
PCI->APIC IRQ transform: (B5,I3,P0) -> 22
PCI->APIC IRQ transform: (B5,I4,P0) -> 23
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
VFS: Disk quotas vdquot_6.5.1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Capability LSM initialized
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Intel(R) PRO/100 Network Driver - version 2.1.15-k1
Copyright (c) 2002 Intel Corporation

e100: eth0: Intel(R) PRO/100+ Server Adapter (PILA8470B)
  Mem:0xfebff000  IRQ:20  Speed:0 Mbps  Dx:N/A
  Failed to detect cable link
  Speed and duplex will be determined at time of connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: CRD-8481B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev 03:00, sector 0
end_request: I/O error, dev 03:00, sector 0
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 2/1/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 396 instructions downloaded
(scsi1) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 2/1/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 396 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.5/5.2.0
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.5/5.2.0
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 1 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 1 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 2 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 2 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 3 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 3 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 4 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 4 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 5 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 5 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 6 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 6 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 8 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 8 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 9 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 9 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 10 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 10 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 11 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 11 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 12 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 12 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 13 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 13 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 14 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 14 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 15 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 15 lun 0
  Vendor: IBM       Model: YGHv3 S2          Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 12 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 13 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 13 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 14 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 14 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 15 lun 0
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 15 lun 0
megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001)
megaraid: no BIOS enabled.
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
st: Version 20021015, fixed bufsize 32768, wrt 30720, s/g segs 256
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdf at scsi0, channel 0, id 5 lun 0
Attached scsi disk sdg at scsi0, channel 0, id 6, lun 0scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
SCSI device sda: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
sda : sector size 0 reported, assuming 512.
SCSI device sda: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 1 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 1 lun 0
SCSI device sdb: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 1 lun 0
sdb : sector size 0 reported, assuming 512.
SCSI device sdb: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 2 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 2 lun 0
SCSI device sdc: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 2 lun 0
sdc : sector size 0 reported, assuming 512.
SCSI device sdc: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 3 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 3 lun 0
SCSI device sdd: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 3 lun 0
sdd : sector size 0 reported, assuming 512.
SCSI device sdd: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 4 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 4 lun 0
SCSI device sde: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 4 lun 0
sde : sector size 0 reported, assuming 512.
SCSI device sde: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 5 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 5 lun 0
SCSI device sdf: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 5 lun 0
sdf : sector size 0 reported, assuming 512.
SCSI device sdf: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 6 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 6 lun 0
SCSI device sdg: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 6 lun 0
sdg : sector size 0 reported, assuming 512.
SCSI device sdg: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 8 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 8 lun 0
SCSI device sdh: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 8 lun 0
sdh : sector size 0 reported, assuming 512.
SCSI device sdh: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 9 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 9 lun 0
SCSI device sdi: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 9 lun 0
sdi : sector size 0 reported, assuming 512.
SCSI device sdi: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 10 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 10 lun 0
SCSI device sdj: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 10 lun 0
sdj : sector size 0 reported, assuming 512.
SCSI device sdj: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 11 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 11 lun 0
SCSI device sdk: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 11 lun 0
sdk : sector size 0 reported, assuming 512.
SCSI device sdk: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 12 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 12 lun 0
SCSI device sdl: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 12 lun 0
sdl : sector size 0 reported, assuming 512.
SCSI device sdl: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 13 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 13 lun 0
SCSI device sdm: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 13 lun 0
sdm : sector size 0 reported, assuming 512.
SCSI device sdm: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 14 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 14 lun 0
SCSI device sdn: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 14 lun 0
sdn : sector size 0 reported, assuming 512.
SCSI device sdn: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 15 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 15 lun 0
SCSI device sdo: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 15 lun 0
sdo : sector size 0 reported, assuming 512.
SCSI device sdo: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 12 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 12 lun 0
SCSI device sdp: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 12 lun 0
sdp : sector size 0 reported, assuming 512.
SCSI device sdp: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 13 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 13 lun 0
SCSI device sdq: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 13 lun 0
sdq : sector size 0 reported, assuming 512.
SCSI device sdq: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 14 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 14 lun 0
SCSI device sdr: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 14 lun 0
sdr : sector size 0 reported, assuming 512.
SCSI device sdr: 1 512-byte hdwr sectors (0 MB)
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 15 lun 0
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 15 lun 0
SCSI device sds: drive cache: write through
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 1 channel 0 id 15 lun 0
sds : sector size 0 reported, assuming 512.
SCSI device sds: 1 512-byte hdwr sectors (0 MB)
Attached scsi generic sg15 at scsi1, channel 0, id 9, lun 0,  type 3
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 65536 buckets, 512Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Cannot open root device "806" or 08:06
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:06
 

-- 
Revolutions do not require corporate support.
