Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWHZVUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWHZVUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 17:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWHZVUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 17:20:19 -0400
Received: from mxsf18.cluster1.charter.net ([209.225.28.218]:20702 "EHLO
	mxsf18.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750742AbWHZVUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 17:20:14 -0400
X-IronPort-AV: i="4.08,172,1154923200"; 
   d="scan'208"; a="607380798:sNHT35936552"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17648.47873.675155.821074@stoffel.org>
Date: Sat, 26 Aug 2006 17:20:01 -0400
From: "John Stoffel" <john@stoffel.org>
To: linux-kernel@vger.kernel.org
CC: jeff@garzik.org, alan@redhat.com
Subject: 2.6.18-rc4-mm1 ATA oops on HPT302 controller
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeff & Alan,

I decided to try out the new ATA drivers on my system.  I've got a
DELL Precision 610MT, dual 550mhz Xeons, 768mb RAM, boots of SCSI
(aic7xxx) 9gb disk.  I've got an HPT302 controller with a pair of
100gb IDE drives hooked up.  I tried using 2.6.18-rc4-mm1 as the
kernel.   Here's my lspci output:

    > lspci
    00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
    00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
    00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
    00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
    00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
    00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
    00:0d.0 RAID bus controller: Triones Technologies, Inc. HPT302/302N (rev 01)
    00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
    00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
    00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
    01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400/G450 (rev 82)
    02:06.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 13)
    02:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
    02:0e.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
    03:08.0 USB Controller: NEC Corporation USB (rev 41)
    03:08.1 USB Controller: NEC Corporation USB (rev 41)
    03:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
    03:0b.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)


The bootup bombs out with a bunch of oops and errors like this.

  irq 16: nobody cared (try booting with the "irqpoll" option)
   [<c013e3e4>] __report_bad_irq+0x24/0x90
   [<c013e668>] note_interrupt+0x218/0x250
   [<c013d8f3>] handle_IRQ_event+0x33/0x70
   [<c013ef9a>] handle_fasteoi_irq+0xca/0xe0
   [<c013eed0>] handle_fasteoi_irq+0x0/0xe0
   [<c010591d>] do_IRQ+0x8d/0xf0
   [<c054e250>] unknown_bootoption+0x0/0x270
   [<c010399a>] common_interrupt+0x1a/0x20
   [<c0101bc0>] default_idle+0x0/0x60
   [<c054e250>] unknown_bootoption+0x0/0x270
   [<c0101bf1>] default_idle+0x31/0x60
   [<c0101c8c>] cpu_idle+0x6c/0x90
   [<c054e7b9>] start_kernel+0x2f9/0x400
   [<c054e250>] unknown_bootoption+0x0/0x270
   =======================
  handlers:
  [<c0301a10>] (ata_interrupt+0x0/0x190)
  [<c030f6c0>] (usb_hcd_irq+0x0/0x60)
  Disabling IRQ #16
  ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
  ata4.00: (BMDMA stat 0x4)
  ata4.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
  ata4: soft resetting port
  ata4.00: qc timeout (cmd 0xec)
  ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata4.00: revalidation failed (errno=-5)
  ata4: failed to recover some devices, retrying in 5 secs
  ata4: soft resetting port
  ata4.00: qc timeout (cmd 0xec)
  ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)


I included the full bootup logs, as well as my config.  Hopefully this
will be useful.  Let me know if you need me to make changes and try
other boot options.

John
john"at"stoffel"dot"org

======================== boot log ==================================
Linux version 2.6.18-rc4-mm1-ATA (john@jfsnew) (gcc version 4.1.2 20060814 (prerelease) (Debian 4.1.1-11)) #9 SMP Fri Aug 25 19:06:44 EDT 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end: 00000000000a0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000002fefe000 end: 000000002fffe000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000002fffe000 size: 0000000000002000 end: 0000000030000000 type: 2
copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end: 00000000fec10000 type: 2
copy_e820_map() start: 00000000fee00000 size: 0000000000010000 end: 00000000fee10000 type: 2
copy_e820_map() start: 00000000ffe00000 size: 0000000000200000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
 BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.2 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x4])
ACPI: NMI not connected to LINT 1!
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 30000000:cec00000)
Detected 547.184 MHz processor.
Built 1 zonelists.  Total pages: 196606
Kernel command line: root=/dev/sda2 ro console=tty0  console=ttyS0,9600n8 earlyprintk=serial
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c058f000 soft=c058d000
PID hash table entries: 4096 (order: 12, 16384 bytes)
disabling early console
Linux version 2.6.18-rc4-mm1-ATA (john@jfsnew) (gcc version 4.1.2 20060814 (prerelease) (Debian 4.1.1-11)) #9 SMP Fri Aug 25 19:06:44 EDT 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end: 00000000000a0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000002fefe000 end: 000000002fffe000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000002fffe000 size: 0000000000002000 end: 0000000030000000 type: 2
copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end: 00000000fec10000 type: 2
copy_e820_map() start: 00000000fee00000 size: 0000000000010000 end: 00000000fee10000 type: 2
copy_e820_map() start: 00000000ffe00000 size: 0000000000200000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
 BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.2 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x4])
ACPI: NMI not connected to LINT 1!
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 30000000:cec00000)
Detected 547.184 MHz processor.
Built 1 zonelists.  Total pages: 196606
Kernel command line: root=/dev/sda2 ro console=tty0  console=ttyS0,9600n8 earlyprintk=serial
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c058f000 soft=c058d000
PID hash table entries: 4096 (order: 12, 16384 bytes)
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 773904k/786424k available (2965k kernel code, 11996k reserved, 1418k data, 232k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xf0800000 - 0xfffb5000   ( 247 MB)
    lowmem  : 0xc0000000 - 0xefffe000   ( 767 MB)
      .init : 0xc054e000 - 0xc0588000   ( 232 kB)
      .data : 0xc03e555f - 0xc0547df0   (1418 kB)
      .text : 0xc0100000 - 0xc03e555f   (2965 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1094.94 BogoMIPS (lpj=547471)
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 20k freed
ACPI: Core revision 20060707
CPU0: Intel Pentium III (Katmai) stepping 03
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c0590000 soft=c058e000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1094.25 BogoMIPS (lpj=547128)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2189.19 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=3624
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfca1e, last bus=3
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
PCI quirk: region 0800-083f claimed by PIIX4 ACPI
PCI quirk: region 0850-085f claimed by PIIX4 SMB
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0c: ioport range 0x800-0x85f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc000000-fdffffff
  PREFETCH window: f2000000-f5ffffff
PCI: Bridge: 0000:02:06.0
  IO window: disabled.
  MEM window: fa000000-fbffffff
  PREFETCH window: f1000000-f1ffffff
PCI: Bridge: 0000:00:13.0
  IO window: e000-efff
  MEM window: f8000000-fbffffff
  PREFETCH window: f0000000-f1ffffff
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Cyclades driver 2.3.2.20 2004/02/25 18:14:16
        built Aug 20 2006 20:47:28
Cyclom-Y/ISA #1: 0xc00de000-0xc00dffff, IRQ11, 8 channels starting from port 0.
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440GX Chipset.
agpgart: AGP aperture is 64M @ 0xec000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized mga 3.2.1 20051102 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> IRQ 17
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:11.0: 3Com PCI 3c905B Cyclone 100baseTx at f0802000.
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi 0:0:0:0: Direct access     COMPAQ   HC01841729       3208 PQ: 0 ANSI: 2
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
scsi0: PCI error Interrupt at seqaddr = 0x9
scsi0: Signaled a Target Abort
 target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
scsi 0:0:1:0: Direct access     COMPAQ   BD018222CA       B016 PQ: 0 ANSI: 2
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
 target0:0:1: Beginning Domain Validation
 target0:0:1: wide asynchronous
scsi0: PCI error Interrupt at seqaddr = 0x9
scsi0: Signaled a Target Abort
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 63)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

scsi 1:0:5:0: Sequential access SUN      DLT7000          245F PQ: 0 ANSI: 2
 target1:0:5: Beginning Domain Validation
 target1:0:5: wide asynchronous
 target1:0:5: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
 target1:0:5: Domain Validation skipping write tests
 target1:0:5: Ending Domain Validation
st: Version 20050830, fixed bufsize 32768, s/g segs 256
st 1:0:5:0: Attached scsi tape st0
st0: try direct i/o: yes (alignment 512 B)
 target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through w/ FUA
SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through w/ FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 63)
SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through w/ FUA
SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through w/ FUA
 sdb:
sd 0:0:1:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0
st 1:0:5:0: Attached scsi generic sg2 type 1
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi2 : ata_piix
ata1.00: ATAPI, max UDMA/33
ata1.00: configured for UDMA/33
scsi3 : ata_piix
ata2: port disabled. ignoring.
ATA: abnormal status 0xFF on port 0x177
scsi 2:0:0:0: CD/DVD            SAMSUNG  CDRW/DVD SM-352B T806 PQ: 0 ANSI: 5
scsi 2:0:0:0: Attached scsi generic sg3 type 5
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: HPT302: Bus clock 33MHz.
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
ata3: PATA max UDMA/133 cmd 0xDCD8 ctl 0xDCD2 bmdma 0xD800 irq 16
ata4: PATA max UDMA/133 cmd 0xDCC0 ctl 0xDCBA bmdma 0xD808 irq 16
scsi4 : pata_hpt37x
ata3.00: ATA-5, max UDMA/100, 234441648 sectors: LBA 
ata3.00: ata3: dev 0 multi count 16
Find mode for 12 reports C829C62
Find mode for DMA 69 reports 1C6DDC62
ata3.00: configured for UDMA/100
scsi5 : pata_hpt37x
ata4.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48 
ata4.00: ata4: dev 0 multi count 16
Find mode for 12 reports C829C62
Find mode for DMA 69 reports 1C6DDC62
ata4.00: configured for UDMA/100
scsi 4:0:0:0: Direct access     ATA      WDC WD1200JB-00C 17.0 PQ: 0 ANSI: 5
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 4:0:0:0: Attached scsi disk sdc
sd 4:0:0:0: Attached scsi generic sg4 type 0
scsi 5:0:0:0: Direct access     ATA      WDC WD1200JB-00E 15.0 PQ: 0 ANSI: 5
SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 5:0:0:0: Attached scsi disk sdd
sd 5:0:0:0: Attached scsi generic sg5 type 0
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:03:08.2[C] -> GSI 16 (level, low) -> IRQ 16
ehci_hcd 0000:03:08.2: EHCI Host Controller
ehci_hcd 0000:03:08.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:03:08.2: irq 16, io mem 0xfaffdc00
ehci_hcd 0000:03:08.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc4-mm1-ATA ehci_hcd
usb usb1: SerialNumber: 0000:03:08.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
input: AT Translated Set 2 keyboard as /class/input/input0
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    144 MB/s
raid6: int32x2    128 MB/s
raid6: int32x4    140 MB/s
raid6: int32x8    140 MB/s
raid6: mmxx1      371 MB/s
raid6: mmxx2      429 MB/s
raid6: sse1x1     300 MB/s
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
raid6: sse1x2     371 MB/s
raid6: using algorithm sse1x2 (371 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  1104.000 MB/sec
raid5: using function: pIII_sse (1104.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: ioctl: 4.8.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
EDAC MC: Ver: 2.0.1 Aug 20 2006
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Starting balanced_irq
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
md: Autodetecting RAID arrays.
md: invalid raid superblock magic on sda1
md: sda1 has invalid sb, not importing!
md: invalid raid superblock magic on sda2
md: sda2 has invalid sb, not importing!
md: invalid raid superblock magic on sda5
md: sda5 has invalid sb, not importing!
md: invalid raid superblock magic on sda6
md: sda6 has invalid sb, not importing!
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md: created md0
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 15/15 pages, set 0 bits, status: 0
created bitmap (224 pages) for device md0
irq 16: nobody cared (try booting with the "irqpoll" option)
 [<c013e3e4>] __report_bad_irq+0x24/0x90
 [<c013e668>] note_interrupt+0x218/0x250
 [<c013d8f3>] handle_IRQ_event+0x33/0x70
 [<c013ef9a>] handle_fasteoi_irq+0xca/0xe0
 [<c013eed0>] handle_fasteoi_irq+0x0/0xe0
 [<c010591d>] do_IRQ+0x8d/0xf0
 [<c054e250>] unknown_bootoption+0x0/0x270
 [<c010399a>] common_interrupt+0x1a/0x20
 [<c0101bc0>] default_idle+0x0/0x60
 [<c054e250>] unknown_bootoption+0x0/0x270
 [<c0101bf1>] default_idle+0x31/0x60
 [<c0101c8c>] cpu_idle+0x6c/0x90
 [<c054e7b9>] start_kernel+0x2f9/0x400
 [<c054e250>] unknown_bootoption+0x0/0x270
 =======================
handlers:
[<c0301a10>] (ata_interrupt+0x0/0x190)
[<c030f6c0>] (usb_hcd_irq+0x0/0x60)
Disabling IRQ #16
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: (BMDMA stat 0x4)
ata4.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: soft resetting port
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4.00: revalidation failed (errno=-5)
ata4: failed to recover some devices, retrying in 5 secs
ata4: soft resetting port
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4.00: revalidation failed (errno=-5)
ata4: failed to recover some devices, retrying in 5 secs
ata4: soft resetting port
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4.00: revalidation failed (errno=-5)
ata4.00: disabled
ata4: EH complete
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436423
raid1: Disk failure on sdd1, disabling device. 
        Operation continuing on 1 devices
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xe7 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: soft resetting port
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata3.00: revalidation failed (errno=-5)
ata3: failed to recover some devices, retrying in 5 secs
ata3: soft resetting port
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata3.00: revalidation failed (errno=-5)
ata3: failed to recover some devices, retrying in 5 secs
ata3: soft resetting port
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata3.00: revalidation failed (errno=-5)
ata3.00: disabled
ata3: EH complete
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436423
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436415
md: ... autorun DONE.
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sdc1
 disk 1, wo:1, o:0, dev:sdd1
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:sdc1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 232k freed
INIT: version 2.86 booting
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...ACPI: PCI Interrupt 0000:03:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[faffd000-faffd7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:03:08.0[A] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:03:08.0: OHCI Host Controller
ohci_hcd 0000:03:08.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:03:08.0: irq 18, io mem 0xfafff000
USB Universal Host Controller Interface driver v3.0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436287
Buffer I/O error on device md0, logical block 29304528
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436287
Buffer I/O error on device md0, logical block 29304528
Reducing readahead size to 256K
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436407
Buffer I/O error on device md0, logical block 29304543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436407
Buffer I/O error on device md0, logical block 29304543
Reducing readahead size to 64K
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436407
Buffer I/O error on device md0, logical block 29304543
Reducing readahead size to 16K
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436407
Buffer I/O error on device md0, logical block 29304543
Reducing readahead size to 4K
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436407
Buffer I/O error on device md0, logical block 29304543
Reducing readahead size to 0K
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436407
Buffer I/O error on device md0, logical block 29304543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436351
Buffer I/O error on device md0, logical block 29304536
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436351
Buffer I/O error on device md0, logical block 29304536
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436399
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436399
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436407
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436407
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
ohci1394: fw-host0: Running dma failed because Node ID is not valid
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ACPI: PCI Interrupt 0000:00:07.2[D] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:07.2: irq 19, io base 0x0000dce0
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-rc4-mm1-ATA uhci_hcd
usb usb3: SerialNumber: 0000:00:07.2
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb usb2: new device found, idVendor=0000, idProduct=0000
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441472
printk: 33 messages suppressed.
Buffer I/O error on device sdd, logical block 29305184
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441472
Reducing readahead size to 256K
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441640
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441640
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441640
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441640
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441640
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441640
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441584
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441584
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441632
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441632
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441640
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234441640
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441472
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441472
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441640
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441640
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441640
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441640
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441640
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441640
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441584
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441584
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441632
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441632
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441640
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234441640
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc4-mm1-ATA ohci_hcd
usb usb2: SerialNumber: 0000:03:08.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436415
sd 5:0:0:0: SCSI error: return code = 0x00040000
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436415
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436479
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436479
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436527
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436527
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 234436543
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 63
end_request: I/O error, dev sdd, sector 234436415
printk: 233 messages suppressed.
Buffer I/O error on device sdd1, logical block 117218176
hub 2-0:1.0: 3 ports detected
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436415
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436543
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436543
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436543
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436543
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436543
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436543
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436479
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436479
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436527
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436527
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436543
ACPI: PCI Interrupt 0000:03:08.1[B] -> <6>sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 234436543
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
sd 5:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdd, sector 63
GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:03:08.1: OHCI Host Controller
ohci_hcd 0000:03:08.1: new USB bus registered, assigned bus number 4
ohci_hcd 0000:03:08.1: irq 19, io mem 0xfaffe000
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: OHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.18-rc4-mm1-ATA ohci_hcd
usb usb4: SerialNumber: 0000:03:08.1
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
done.
loadkeys: /etc/console/boottime.kmap.gz:407: addkey called with bad index 256
Setting parameters of disc: (none).
Will now activate swap.
swapon Adding 996020k swap on /dev/sda3.  Priority:-1 extents:1 across:996020k
on /dev/sda3
Done activating swap.
Will now check root file system.
fsck 1.39 (29-May-2006)
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a -C0 /dev/sda2EXT3 FS on sda2,  
/dev/sda2: clinternal journal
ean, 28019/500960 files, 161488/1000046 blocks
Done checking root file system. 
A log will be saved in /var/log/fsck/checkroot if that location is writable.
Setting the system clock..
System Clock set. Local time: Sat Aug 26 20:51:57 UTC 2006.
Cleaning up ifupdown...done.
Loading modules...
All modules loaded.
Setting the system clock again..
System Clock set. Local time: Sat Aug 26 20:51:58 UTC 2006.
Creating device-mapper devices....
Loading device-mapper support.
Assembling MD array md0...done (already running).
Setting up LVM Volume Groups...
  Reading all phsd 4:0:0:0: SCSI error: return code = 0x00040000
ysical volumes. end_request: I/O error, dev sdc, sector 234436287
 This may take asd 4:0:0:0: SCSI error: return code = 0x00040000
 while...
  /deend_request: I/O error, dev sdc, sector 63
v/md0: read failed after 0 of 4096 at 120031346688: Input/output error
  /dev/md0: read failed after 0 of 4096 at 0: Input/output error
sd 4:0:0:0: SCSI error: return code = 0x00040000
end_request: I/O error, dev sdc, sector 0
printk: 147 messages suppressed.
Buffer I/O error on device sdc, logical block 0
  sd 4:0:0:0: SCSI error: return code = 0x00040000
/dev/sdc: read fend_request: I/O error, dev sdc, sector 234441472
ailed after 0 ofsd 4:0:0:0: SCSI error: return code = 0x00040000
 4096 at 0: Inpuend_request: I/O error, dev sdc, sector 0
t/output error
sd 4:0:0:0: SCSI error: return code = 0x00040000
  /dev/sdc: readend_request: I/O error, dev sdc, sector 234436415
 failed after 0 sd 4:0:0:0: SCSI error: return code = 0x00040000
of 4096 at 12003end_request: I/O error, dev sdc, sector 63
4033664: Input/osd 5:0:0:0: SCSI error: return code = 0x00040000
utput error
  /end_request: I/O error, dev sdd, sector 0
dev/sdc: read faBuffer I/O error on device sdd, logical block 0
iled after 0 of sd 5:0:0:0: SCSI error: return code = 0x00040000
4096 at 0: Inputend_request: I/O error, dev sdd, sector 234441472
/output error
 sd 5:0:0:0: SCSI error: return code = 0x00040000
 /dev/sdc1: readend_request: I/O error, dev sdd, sector 0
 failed after 0 sd 5:0:0:0: SCSI error: return code = 0x00040000
of 1024 at 12003end_request: I/O error, dev sdd, sector 234436415
1412224: Input/osd 5:0:0:0: SCSI error: return code = 0x00040000
utput error
  /end_request: I/O error, dev sdd, sector 63
dev/sdc1: read failed after 0 ofsd 4:0:0:0: SCSI error: return code = 0x00040000
 2048 at 0: Inpuend_request: I/O error, dev sdc, sector 63
t/output error
  /dev/sdd: read failed after 0 of 4096 at 0: Input/output error
  /dev/sdd: read failed after 0 of 4096 at 120034033664: Input/output error
  /dev/sdd: read failed after 0 of 4096 at 0: Input/output error
  /dev/sdd1: read failed after sd 4:0:0:0: SCSI error: return code = 0x00040000
0 of 1024 at 120end_request: I/O error, dev sdc, sector 0
031412224: Inputsd 4:0:0:0: SCSI error: return code = 0x00040000
/output error
 end_request: I/O error, dev sdc, sector 63
 /dev/sdd1: readsd 5:0:0:0: SCSI error: return code = 0x00040000
 failed after 0 end_request: I/O error, dev sdd, sector 0
of 2048 at 0: Insd 5:0:0:0: SCSI error: return code = 0x00040000
put/output errorend_request: I/O error, dev sdd, sector 63

  No volume groups found
  No volume groups found
  /dev/md0: read failed after 0 of 4096 at 0: Input/output error
  /dev/sdc: read failed after 0 of 4096 at 0: Input/output error
  /dev/sdc1: read failed after 0 of 2048 at 0: Input/output error
  /dev/sdd: read failed after 0 of 4096 at 0: Input/output error
  /dev/sdd1: read failed after 0 of 2048 at 0: Input/output error
  No volume groups found
Will now check all file systems.
fsck 1.39 (29-May-2006)
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /var] fsck.ext3 -a -C0 /dev/sda5 
/dev/sda5: clean, 14859/500960 files, 157287/1000038 blocks
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a -C0 /dev/sda1 
/dev/sda1: clean, 202/62248 files, 130316/248976 blocks
[/sbin/fsck.ext3 (1) -- /usr] fsck.ext3 -a -C0 /dev/sda6 
/dev/sda6: clean, 308862/1001920 files, 1459619/2000084 blocks
[/sbin/fsck.ext3 (1) -- /home] fsck.ext3 -a -C0 /dev/data_vg/home_lv 
fsck.ext3: No such file or directory while trying to open /dev/data_vg/home_lv
/dev/data_vg/home_lv: 
The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>

[/sbin/fsck.ext3 (1) -- /local] fsck.ext3 -a -C0 /dev/data_vg/local_lv 
fsck.ext3: No such file or directory while trying to open /dev/data_vg/local_lv
/dev/data_vg/local_lv: 
The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>

[/sbin/fsck.ext3 (1) -- /dv] fsck.ext3 -a -C0 /dev/data_vg/dv_lv 
fsck.ext3: No such file or directory while trying to open /dev/data_vg/dv_lv
/dev/data_vg/dv_lv: 
The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>

fsck died with exit status 8
File system check failed. 
A log is being saved in /var/log/fsck/checkfs if that location is writable. 
Please repair the file system manually.
A maintenance shell will now be started. 
CONTROL-D will terminate this shell and resume system boot.
Give root password for maintenance
(or type Control-D to continue): SysRq : Emergency Sync
Emergency Sync complete
SysRq : Resetting


========================== .config =================================
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SWAP_PREFETCH=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_KALLSYMS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
CONFIG_DEFAULT_IOSCHED="anticipatory"
CONFIG_SMP=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_MC=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_VM86=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_DCDBAS=m
CONFIG_NOHIGHMEM=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ADAPTIVE_READAHEAD=y
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_PHYSICAL_START=0x100000
CONFIG_COMPAT_VDSO=y
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_ASUS=y
CONFIG_ACPI_IBM=y
CONFIG_ACPI_TOSHIBA=y
CONFIG_ACPI_SONY=m
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_FIB_HASH=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRTTY_SIR=m
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_MA600_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_MCP2120_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_ACT200L_DONGLE=m
CONFIG_USB_IRDA=m
CONFIG_SIGMATEL_FIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m
CONFIG_VIA_FIR=m
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_ATA=y
CONFIG_ATA_PIIX=y
CONFIG_PATA_HPT37X=y
CONFIG_PATA_HPT3X2N=y
CONFIG_PATA_MPIIX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_RAID5_RESHAPE=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_I2O=m
CONFIG_I2O_LCT_NOTIFY_ON_CHANGES=y
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_CONFIG=m
CONFIG_I2O_CONFIG_OLD_IOCTL=y
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m
CONFIG_NETDEVICES=y
CONFIG_PHYLIB=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_CYCLADES=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_STUB=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_PCA_ISA=m
CONFIG_SENSORS_DS1374=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCA9539=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_MAX6875=m
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=y
CONFIG_FIRMWARE_EDID=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1371=m
CONFIG_SND_USB_USX2Y=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_ACECAD=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m
CONFIG_USB_KEYSPAN_REMOTE=m
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_MON=y
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_AIRPRIME=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP2101=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_HP4X=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_SELECTED=y
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=m
CONFIG_USB_GADGET_DUALSPEED=y
CONFIG_USB_ZERO=m
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_GADGETFS=m
CONFIG_USB_FILE_STORAGE=m
CONFIG_USB_G_SERIAL=m
CONFIG_EDAC=y
CONFIG_EDAC_MM_EDAC=y
CONFIG_EDAC_POLL=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_DNOTIFY=y
CONFIG_FUSE_FS=m
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
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m
CONFIG_CRAMFS=m
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SMB_FS=y
CONFIG_CIFS=y
CONFIG_9P_FS=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_UNWIND_INFO=y
CONFIG_EARLY_PRINTK=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_LOWAPI=y
CONFIG_CRYPTO_MANAGER=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y
