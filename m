Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbTDASVx>; Tue, 1 Apr 2003 13:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262723AbTDASVx>; Tue, 1 Apr 2003 13:21:53 -0500
Received: from smtp01.web.de ([217.72.192.180]:15366 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S262722AbTDASVk>;
	Tue, 1 Apr 2003 13:21:40 -0500
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.66 oops
Date: Tue, 1 Apr 2003 20:32:43 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304012032.43228.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I got an oops on linux-2.5.66:

Unable to handle kernel NULL pointer dereference at virtual address 00000068
c020ca48
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c020ca48>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c1292000   ebx: 00000058   ecx: ffffffff   edx: c042ed58
esi: c042ed34   edi: c042ed84   ebp: c1293f38   esp: c1293f34
ds: 007b   es: 007b   ss: 0068
Stack: c042ed74 c1293f48 c020c7eb 00000058 c042ed74 c1293f64 c020c9a5 c042ed74 
       c042ed24 c1293f64 c0274c93 c042ed74 c1293f84 c0274ae0 c042ed74 00000042 
       fffffffc c042ed24 c042ed20 00000000 c1293fa0 c0274f83 c042ed58 00008086 
Call Trace:
 [<c020c7eb>] kobject_init+0x2e/0x48
 [<c020c9a5>] kobject_register+0x18/0x61
 [<c0274c93>] get_bus+0x1f/0x38
 [<c0274ae0>] bus_add_driver+0x57/0xeb
 [<c0274f83>] driver_register+0x31/0x35
 [<c02e63b8>] i2c_add_driver+0xa3/0x106
 [<c02a0842>] msp3400_init_module+0x12/0x18
 [<c01050a3>] init+0x39/0x196
 [<c010506a>] init+0x0/0x196
 [<c0107289>] kernel_thread_helper+0x5/0xb
Code: 8b 43 10 85 c0 7e 22 ff 43 10 b8 00 e0 ff ff 21 e0 83 68 14 


>>EIP; c020ca48 <kobject_get+16/43>   <=====

>>eax; c1292000 <_end+d767c8/3fae45cc>
>>ecx; ffffffff <TSS_ESP0_OFFSET+1fb/????>
>>edx; c042ed58 <driver+38/c0>
>>esi; c042ed34 <driver+14/c0>
>>edi; c042ed84 <driver+64/c0>
>>ebp; c1293f38 <_end+d78700/3fae45cc>
>>esp; c1293f34 <_end+d786fc/3fae45cc>

Trace; c020c7eb <kobject_init+2e/48>
Trace; c020c9a5 <kobject_register+18/61>
Trace; c0274c93 <get_bus+1f/38>
Trace; c0274ae0 <bus_add_driver+57/eb>
Trace; c0274f83 <driver_register+31/35>
Trace; c02e63b8 <i2c_add_driver+a3/106>
Trace; c02a0842 <msp3400_init_module+12/18>
Trace; c01050a3 <init+39/196>
Trace; c010506a <init+0/196>
Trace; c0107289 <kernel_thread_helper+5/b>

Code;  c020ca48 <kobject_get+16/43>
00000000 <_EIP>:
Code;  c020ca48 <kobject_get+16/43>   <=====
   0:   8b 43 10                  mov    0x10(%ebx),%eax   <=====
Code;  c020ca4b <kobject_get+19/43>
   3:   85 c0                     test   %eax,%eax
Code;  c020ca4d <kobject_get+1b/43>
   5:   7e 22                     jle    29 <_EIP+0x29>
Code;  c020ca4f <kobject_get+1d/43>
   7:   ff 43 10                  incl   0x10(%ebx)
Code;  c020ca52 <kobject_get+20/43>
   a:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c020ca57 <kobject_get+25/43>
   f:   21 e0                     and    %esp,%eax
Code;  c020ca59 <kobject_get+27/43>
  11:   83 68 14 00               subl   $0x0,0x14(%eax)



I have captured console-log via serial-line:

Linux version 2.5.66 (mb@lfs) (gcc version 3.2.2) #2 Die Apr 1 20:10:41 CEST 2003
user-defined physical RAM map:
found SMP MP-table at 000fb800
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 16
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/md0 hdd=ide-scsi hdb=ide-scsi mce vga=779 mem=262080K
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Console: colour VGA+ 132x50
Calibrating delay loop... 4423.68 BogoMIPS
Memory: 254508k/262080k available (2618k kernel code, 6852k reserved, 911k data, 340k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev/console
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=3
PCI: Using configuration type 1
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030228
Parsing all Control Methods:....................................................................................................................................................
Table [DSDT] - 495 Objects with 44 Devices 148 Methods 15 Regions
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to GPE31
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L0B is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L03 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L04 is not valid
   evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
Executing all Device _STA and_INI methods:............................................
44 Devices found containing: 44 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:..................................................................................
Initialized 10/15 Regions 10/10 Fields 50/50 Buffers 12/12 Packages (495 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
 exfldio-0140 [25] ex_setup_region       : Field [TOMR] Base+Offset+Width 0+2+1 is beyond end of region [TMEM] (length 2)
 dswexec-0421 [17] ds_exec_end_op        : [ShiftLeft]: Could not resolve operands, AE_AML_REGION_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.MDET] (Node c12c88a8), AE_AML_REGION_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node c12c8e28), AE_AML_REGION_LIMIT
  uteval-0098: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node c12c8e28), AE_AML_REGION_LIMIT
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.95 (c) Adam Belay
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7520
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x65ab, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
pty: 256 Unix98 ptys configured
lp: driver loaded but no devices found
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel i845 chipset
agpgart: Maximum main memory to use for agp memory: 203M
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
lp0: using parport0 (polling).
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xb400, IRQ 17, 52:54:05:FF:F5:EA.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
bttv: driver version 0.9.4 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is Intel Corp. 82845 845 (Brookdale
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 03:02.0, irq: 18, latency: 32, mmio: 0xddafe000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=44354, tuner=Philips FM1216 (5), radio=yes
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Unable to handle kernel NULL pointer dereference at virtual address 00000068
 printing eip:
EIP:    0060:[<c020ca48>]    Not tainted
Process swapper (pid: 1, threadinfo=c1292000 task=c12fe080)
 [<c020c7eb>] kobject_init+0x2e/0x48
 [<c02a0842>] msp3400_init_module+0x12/0x18
 [<c01050a3>] init+0x39/0x196
 [<c010506a>] init+0x0/0x196
 [<c0107289>] kernel_thread_helper+0x5/0xb
 <0>Kernel panic: Attempted to kill init!


Regards Michael Buesch.

