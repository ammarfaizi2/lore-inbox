Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbTFUD5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 23:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265076AbTFUD5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 23:57:11 -0400
Received: from fmr06.intel.com ([134.134.136.7]:58577 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265074AbTFUD4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 23:56:55 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780E040C95@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'gibss@scsiguy.com'" <gibss@scsiguy.com>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: AIC7(censored) card gone wild?
Date: Fri, 20 Jun 2003 21:10:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C337AB.1C5E6730"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C337AB.1C5E6730
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Justin, list ...

I have a 2xPIII 797 Mhz with an AIC-7899P U160/m; I have=20
been running it under 2.5.66 since it was released, always=20
using the AIC7XXXX driver (new one).

However, suddenly something weird happened; since one week
ago, I get panics (in the serial console) like
the one attached (milikk.panic.txt) always caused or having
an rsync process as current (rsync is used for backup).

I also noticed that at about the same time I started to
get got those panics, I get the following when booting=20
the kernel:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: QUANTUM   Model: ATLAS10K2-TY184L  Rev: DA40
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: QUANTUM   Model: ATLAS10K2-TY367L  Rev: DDD6
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 8
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=3D7, 32/253 SCBs

scsi1: Unexpected busfree while idle
SEQADDR =3D=3D 0x31
scsi1:0:4:0: Attempting to queue an ABORT message
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State while idle, at SEQADDR 0x9
Card was paused
ACCUM =3D 0x2, SINDEX =3D 0x48, DINDEX =3D 0xe4, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x0
SCSIPHASE[0x0] SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0]=20
LASTPHASE[0x1] SCSISEQ[0x12] SBLKCTL[0x6] SCSIRATE[0x0]=20
SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] SSTAT1[0x0]=20
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xa4]
..... <SNIPPED- full version @ attached milikk.dump> ...

So I wonder, what does that error mean? SCSI1 has attached a=20
CDRW (Sony Yamaha CDRW 8/4/24) but now it doesn't show up=20
anymore (and so, I cannot get the model). .

Could it mean by SCSI Adapter is hosed? or my CDRW drive?
or something else? I see this same behavior with 2.5.72,
although it gets stuck in "scsi1: Unexpected busfree while
idle\nSEQADDR =3D=3D 0x31", repeats it, goes up to 0x32,
back to 0x31 again, repeats 0x31 ...=20

Removing the CDRW helps (no more message) so I tend to assume
the CDRW is dead; but I am still waiting to see a panic again.

Thanks,

I=F1aky P=E9rez-Gonz=E1lez -- Not speaking for Intel -- all opinions =
are my own
(and my fault)

 <<milikk.dump>>=20

------_=_NextPart_000_01C337AB.1C5E6730
Content-Type: text/plain;
	name="milikk.panic.txt"
Content-Disposition: attachment;
	filename="milikk.panic.txt"

kernel BUG at kernel/timer.c:376!60/serio0
invalid operand: 0000 [#1]plorer Mouse on isa0060/serio1
CPU:    0---[ cut here ]------------
EIP:    0060:[<c012dd08>]    Not tainted
EFLAGS: 00010007
eax: f0ebdf68   ebx: f0ebdf68   ecx: 00eb9f00   edx: c1a135dc
esi: c1a13da4   edi: c1a134a0   ebp: 0000001f   esp: d89f3704
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 9968, threadinfo=d89f2000 task=f5be0040)
Stack: c1a134a0 f71cded4 c1a134a0 015c0060 fffffffd d89f2000 c012e301 c1a134a0
       c1a13cac 0000001f d89f2000 00000000 00000001 00000001 c042e228 fffffffd
       00000000 c0129be5 c042e228 00000046 c0453088 00000000 c0453084 d89f3780
Call Trace: [<c012e301>]  [<c0129be5>]  [<c011a317>]  [<c010bf3a>]  [<c0205f4d>
Code: 0f 0b 78 01 1f c2 38 c0 eb d5 8d b4 26 00 00 00 00 8d bc 27
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

------_=_NextPart_000_01C337AB.1C5E6730
Content-Type: application/octet-stream;
	name="milikk.dump"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="milikk.dump"

kernel BUG at kernel/timer.c:376!60/serio0
invalid operand: 0000 [#1]plorer Mouse on isa0060/serio1
CPU:    0---[ cut here ]------------
EIP:    0060:[<c012dd08>]    Not tainted
EFLAGS: 00010007
eax: f0ebdf68   ebx: f0ebdf68   ecx: 00eb9f00   edx: c1a135dc
esi: c1a13da4   edi: c1a134a0   ebp: 0000001f   esp: d89f3704
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 9968, threadinfo=3Dd89f2000 task=3Df5be0040)
Stack: c1a134a0 f71cded4 c1a134a0 015c0060 fffffffd d89f2000 c012e301 =
c1a134a0
       c1a13cac 0000001f d89f2000 00000000 00000001 00000001 c042e228 =
fffffffd
       00000000 c0129be5 c042e228 00000046 c0453088 00000000 c0453084 =
d89f3780
Call Trace: [<c012e301>]  [<c0129be5>]  [<c011a317>]  [<c010bf3a>]  =
[<c0205f4d>
Code: 0f 0b 78 01 1f c2 38 c0 eb d5 8d b4 26 00 00 00 00 8d bc 27
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Now, after rebooting:

Linux version 2.5.66.2-dell420 (root@milikk) (gcc versi=F3n 3.2.3 =
20030331 (Debian prerelease)) #1 SMP Wed Jun 18 21:01:28 PDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff9e000 (usable)
 BIOS-e820: 000000003ff9e000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 262046
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32670 pages, LIFO batch:7
ACPI: RSDP (v000 DELL                       ) @ 0x000fd730
ACPI: RSDT (v001 DELL    WS 420  00000.00008) @ 0x000fd744
ACPI: FADT (v001 DELL    WS 420  00000.00008) @ 0x000fd770
ACPI: MADT (v001 DELL    WS 420  00000.00008) @ 0x000fd7e4
ACPI: DSDT (v001   DELL    dt_ex 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] =
trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] =
trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=3Ddefault ro root=3D809 =
console=3DttyS1,115200n8 console=3Dtty0
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 797.869 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1576.96 BogoMIPS
Memory: 1033144k/1048184k available (2527k kernel code, 14132k =
reserved, 730k data, 140k init, 130680k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 732.06 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1593.34 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3170.30 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 797.0832 MHz.
..... host bus clock speed is 132.0972 MHz.
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
PCI: PCI BIOS revision 2.10 entry at 0xfc04e, last bus=3D3
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030228
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801AA PCI Bridge
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15, enabled =
at IRQ 14)
Linux Plug and Play Support v0.95 (c) Adam Belay
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or =
even 'acpi=3Doff'
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
hw_random hardware driver 0.9.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel i840 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 64M @ 0xd8000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin =
is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker =
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. =
Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet , 00:A0:C9:A0:73:42, IRQ 17.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 668081-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x3c15c8f1).
  Receiver lock-up workaround activated.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
ICH: IDE controller at PCI slot 00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: QUANTUM   Model: ATLAS10K2-TY184L  Rev: DA40
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: QUANTUM   Model: ATLAS10K2-TY367L  Rev: DDD6
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 8
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=3D7, 32/253 SCBs

scsi1: Unexpected busfree while idle
SEQADDR =3D=3D 0x31
scsi1:0:4:0: Attempting to queue an ABORT message
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State while idle, at SEQADDR 0x9
Card was paused
ACCUM =3D 0x2, SINDEX =3D 0x48, DINDEX =3D 0xe4, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x0
SCSIPHASE[0x0] SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0]=20
LASTPHASE[0x1] SCSISEQ[0x12] SBLKCTL[0x6] SCSIRATE[0x0]=20
SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] SSTAT1[0x0]=20
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xa4]=20
SXFRCTL0[0x80] DFCNTRL[0x0] DFSTATUS[0x89]=20
STACK: 0x0 0x0 0x180 0x3
SCB count =3D 4
Kernel NEXTQSCB =3D 3
Card NEXTQSCB =3D 3
QINFIFO entries:=20
Waiting Queue entries:=20
Disconnected Queue entries:=20
QOUTFIFO entries:=20
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 =
19 20 21 22 23 24 25 26 27 28 29 30 31=20
Sequencer SCB Info:=20
  0 SCB_CONTROL[0x40] SCB_SCSIID[0x47] SCB_LUN[0x0] SCB_TAG[0x2]=20
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 16 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 17 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 18 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 19 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 20 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 21 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 22 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 23 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 24 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 25 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 26 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 27 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 28 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 29 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 30 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 31 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
Pending list:=20
  2 SCB_CONTROL[0x40] SCB_SCSIID[0x47] SCB_LUN[0x0]=20
Kernel Free SCB list: 1 0=20
Untagged Q(4): 2=20
DevQ(0:4:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
(scsi1:A:4:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
scsi1:0:4:0: Attempting to queue a TARGET RESET message
scsi1:0:4:0: Is not an active device
aic7xxx_dev_reset returns 0x2002
scsi1: Unexpected busfree while idle
SEQADDR =3D=3D 0x31
scsi1:0:4:0: Attempting to queue an ABORT message
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State while idle, at SEQADDR 0x9
Card was paused
ACCUM =3D 0x3, SINDEX =3D 0x48, DINDEX =3D 0xe4, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x0
SCSIPHASE[0x0] SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0]=20
LASTPHASE[0x1] SCSISEQ[0x12] SBLKCTL[0x6] SCSIRATE[0x0]=20
SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] SSTAT1[0x0]=20
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xa4]=20
SXFRCTL0[0x80] DFCNTRL[0x0] DFSTATUS[0x89]=20
STACK: 0x0 0x0 0x180 0x3
SCB count =3D 4
Kernel NEXTQSCB =3D 2
Card NEXTQSCB =3D 2
QINFIFO entries:=20
Waiting Queue entries:=20
Disconnected Queue entries:=20
QOUTFIFO entries:=20
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 =
19 20 21 22 23 24 25 26 27 28 29 30 31=20
Sequencer SCB Info:=20
  0 SCB_CONTROL[0x40] SCB_SCSIID[0x47] SCB_LUN[0x0] SCB_TAG[0x3]=20
  1 SCB_CONTROL[0x0] SCB_SCSIID[0x47] SCB_LUN[0x0] SCB_TAG[0xff]=20
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 16 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 17 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 18 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 19 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 20 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 21 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 22 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 23 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 24 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 25 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 26 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 27 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 28 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 29 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 30 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 31 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
Pending list:=20
  3 SCB_CONTROL[0x40] SCB_SCSIID[0x47] SCB_LUN[0x0]=20
Kernel Free SCB list: 1 0=20
Untagged Q(4): 3=20
DevQ(0:4:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
(scsi1:A:4:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
scsi: Device offlined - not ready after error recovery: host 1 channel =
0 id 4 lun 0
SCSI device sda: 35566478 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71721820 512-byte hdwr sectors (36722 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface =
driver v2.0
uhci-hcd 00:1f.2: Intel Corp. 82801AA USB
uhci-hcd 00:1f.2: irq 19, io base 0000ff80
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is =
deprecated.
uhci-hcd 00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyrigh
------_=_NextPart_000_01C337AB.1C5E6730--
