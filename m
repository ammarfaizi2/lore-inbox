Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUEQQgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUEQQgY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbUEQQgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:36:23 -0400
Received: from wasp.conceptual.net.au ([203.190.192.17]:35718 "EHLO
	wasp.net.au") by vger.kernel.org with ESMTP id S261897AbUEQQer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:34:47 -0400
Message-ID: <40A8E9A8.3080100@wasp.net.au>
Date: Mon, 17 May 2004 20:34:48 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_wasp.net.au-22852-1084811684-0001-2"
To: linux-kernel@vger.kernel.org
Subject: libata 2.6.5->2.6.6 regression -part II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_wasp.net.au-22852-1084811684-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

G'day all,
I caught the suggestion on my last post in the archives, but because I'm not subscribed and wasn't 
cc'd I can't keep it threaded.

I tried backing out the suggested acpi patch (No difference at all), and I managed to get apic to 
work but it still hangs solid in the same place.

dmesg attached.

I managed to figure out that the VIA ATA driver captures my sata drives on the via ports, explaining 
why sata_via misses them, but writing data to those drives (hde & hdg) causes dma timeouts and locks 
the machine. No useful debug info produced. The machine becomes non-responsive, throws a couple of 
dma timeouts to the console and then loses all interactivity (keyboard, serial, network) forcing a 
reset push.

Is there any way I can prevent the VIA ATA driver capturing this device? Unfortunately my boot drive 
is on hda on the on-board VIA ATA interface so I need it compiled in.

Please CC: me on any replies.

Regards,
Brad

--=_wasp.net.au-22852-1084811684-0001-2
Content-Type: text/plain; name="2.6.6.dmesg.2"; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="2.6.6.dmesg.2"

nfsd: last server has exited
nfsd: unexporting all filesystems
rpciod: active tasks at shutdown?!
RPC: error 5 connecting to server localhost
RPC: failed to contact portmap (errno -5).
eth1: network connection down
md: stopping all md devices.
md: md0 switched to read-only mode.
Restarting system.
Press any key to continue.
Press any key to continue.
Press any key to continue.

    GNU GRUB  version 0.94  (625K lower / 523248K upper memory)

+------------------------------------------------------------------------=
-+||||||||||||||||||||||||+----------------------------------------------=
---------------------------+
      Use the ^ and v keys to select which entry is highlighted.
      Press enter to boot the selected OS, 'e' to edit the
      commands before booting, or 'c' for a command-line.  Debian GNU/Lin=
ux, kernel 2.4.18-bf2.4                                    Debian GNU/Lin=
ux, kernel 2.4.18-bf2.4 (recovery mode)                    2.4.25        =
                                                           2.4.27-pre1   =
                                                           Linux-2.6.5   =
                                                           Linux-2.6.6   =
                                                           Windows       =
                                                           Redhat 2.4.7-1=
0                                                                        =
                                                                         =
                                                                         =
                                                                         =
                                                           The highlighte=
d entry will be booted automatically in 5 seconds.                       =
                                                  Linux-2.6.5            =
                                                  Linux-2.6.6            =
                                                   Booting 'Linux-2.6.6'

root  (hd0,0)
 Filesystem type is ext2fs, partition type 0x83
kernel  /usr/src/linux-2.6.6/arch/i386/boot/bzImage vga=3D1 console=3Dtty=
S0,38400 c
onsole=3Dtty0 root=3D/dev/hda1
   [Linux-bzImage, setup=3D0x1200, size=3D0x177b2d]
savedefault

Linux version 2.6.6-bk3 (brad@srv) (gcc version 3.3.3 (Debian 20040401)) =
#4 Mon May 17 20:08:40 GST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c400 (usable)
 BIOS-e820: 000000000009c400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f62a0=

ACPI: RSDT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc000=

ACPI: FADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc0b2=

ACPI: BOOT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc030=

ACPI: MADT (v001 ASUS   A7V600   0x42302e31 MSFT 0x31313031) @ 0x1fffc058=

ACPI: DSDT (v001   ASUS A7V600   0x00001000 MSFT 0x0100000b) @ 0x00000000=

ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: vga=3D1 console=3DttyS0,38400 console=3Dtty0 root=3D=
/dev/hda1
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1916.546 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x50
Memory: 516068k/524272k available (1988k kernel code, 7448k reserved, 912=
k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay loop... 3776.51 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 2600+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1916.0157 MHz.
=2E.... host bus clock speed is 333.0244 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=3D1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *15, disabled=
=2E
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
SCSI subsystem initialized
testing the IO APIC.......................
=2E................................... done.
PCI: Using ACPI for IRQ routing
Simple Boot Flag at 0x3a set to 0x80
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
PCI: Via IRQ fixup for 0000:00:10.0, from 6 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 6 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 9 to 5
PCI: Via IRQ fixup for 0000:00:10.3, from 9 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled=

ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 20
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD2000JB-00DUA3, ATA DISK drive
Using anticipatory io scheduler
ide2 at 0x8800-0x8807,0x8402 on irq 20
hdg: WDC WD2000JB-00FUA0, ATA DISK drive
ide3 at 0x8000-0x8007,0x7802 on irq 20
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x6800-0x6807, BIOS settings: hda:DMA, hdb:pio
hda: WDC WD400EB-00CPF0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hde: max request size: 1024KiB
hde: 390625000 sectors (200000 MB) w/8192KiB Cache, CHS=3D24315/255/63
 /dev/ide/host2/bus0/target0/lun0: p1
hdg: max request size: 1024KiB
hdg: Host Protected Area detected.
	current capacity is 390719855 sectors (200048 MB)
	native  capacity is 390721968 sectors (200049 MB)
hdg: 390719855 sectors (200048 MB) w/8192KiB Cache, CHS=3D24321/255/63
 /dev/ide/host2/bus1/target0/lun0: p1
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 78159151 sectors (40017 MB)
	native  capacity is 78165360 sectors (40020 MB)
hda: 78159151 sectors (40017 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA=
(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
ata1: SATA max UDMA/133 cmd 0xE080A200 ctl 0xE080A238 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xE080A280 ctl 0xE080A2B8 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xE080A300 ctl 0xE080A338 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xE080A380 ctl 0xE080A3B8 bmdma 0x0 irq 19
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_promise
ata3: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_promise
ata4: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_promise
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata5: SATA max UDMA/133 cmd 0xE080C200 ctl 0xE080C238 bmdma 0x0 irq 17
ata6: SATA max UDMA/133 cmd 0xE080C280 ctl 0xE080C2B8 bmdma 0x0 irq 17
ata7: SATA max UDMA/133 cmd 0xE080C300 ctl 0xE080C338 bmdma 0x0 irq 17
ata8: SATA max UDMA/133 cmd 0xE080C380 ctl 0xE080C3B8 bmdma 0x0 irq 17
ata5: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata5: dev 0 configured for UDMA/133
scsi4 : sata_promise
ata6: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata6: dev 0 configured for UDMA/133
scsi5 : sata_promise
ata7: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata7: dev 0 configured for UDMA/133
scsi6 : sata_promise
ata8: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata8: dev 0 configured for UDMA/133
scsi7 : sata_promise
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata9: SATA max UDMA/133 cmd 0xE080E200 ctl 0xE080E238 bmdma 0x0 irq 18
ata10: SATA max UDMA/133 cmd 0xE080E280 ctl 0xE080E2B8 bmdma 0x0 irq 18
ata11: SATA max UDMA/133 cmd 0xE080E300 ctl 0xE080E338 bmdma 0x0 irq 18
ata12: SATA max UDMA/133 cmd 0xE080E380 ctl 0xE080E3B8 bmdma 0x0 irq 18
ata9: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata9: dev 0 configured for UDMA/133
scsi8 : sata_promise
ata10: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata10: dev 0 configured for UDMA/133
scsi9 : sata_promise
ata11: no device found (phy stat 00000000)
scsi10 : sata_promise
ata12: no device found (phy stat 00000000)
scsi11 : sata_promise
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write through
 /dev/scsi/host1/bus0/target0/lun0: p1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdc: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdc: drive cache: write through
 /dev/scsi/host2/bus0/target0/lun0: p1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdd: drive cache: write through
 /dev/scsi/host3/bus0/target0/lun0: p1
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
SCSI device sde: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sde: drive cache: write through
 /dev/scsi/host4/bus0/target0/lun0: p1
Attached scsi disk sde at scsi4, channel 0, id 0, lun 0
SCSI device sdf: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdf: drive cache: write through
 /dev/scsi/host5/bus0/target0/lun0: p1
Attached scsi disk sdf at scsi5, channel 0, id 0, lun 0
SCSI device sdg: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdg: drive cache: write through
 /dev/scsi/host6/bus0/target0/lun0: p1
Attached scsi disk sdg at scsi6, channel 0, id 0, lun 0
SCSI device sdh: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdh: drive cache: write through
 /dev/scsi/host7/bus0/target0/lun0: p1
Attached scsi disk sdh at scsi7, channel 0, id 0, lun 0
SCSI device sdi: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdi: drive cache: write through
 /dev/scsi/host8/bus0/target0/lun0:
--=_wasp.net.au-22852-1084811684-0001-2--
