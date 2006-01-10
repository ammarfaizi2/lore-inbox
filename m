Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWAJPGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWAJPGI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWAJPGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:06:08 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:63368 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751101AbWAJPGD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:06:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=krbtAwQ8urlKExcG5yVM//dPtCaBc3FmrkzEYFqHexAVTJM4x7uf8HR9+K7IRK5bdCkKn6u6iT4f31utgk2ADvgvUdOnBxPn7FntxTgv6QD0UbF4W1msMxfbc/y2gAlSj1to1og9nrCLgm1YueI4W87ybLtw3KNsBhd5fOEbT0E=
Message-ID: <5a2cf1f60601100706n5843b2ffg9b804760310f66bb@mail.gmail.com>
Date: Tue, 10 Jan 2006 16:06:02 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: ata errors -> read-only root partition. Hardware issue?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have this remote box running on 2.6.12.3 (planned tentative upgrade
to newer kernel was for this week) that went bad this morning...

I am not 100% sure of the hardware, but basically:
- AMD 64 processor
- Asus extreme AX 300 SE/t mainboard

The disk subsystem failed and the disks are now read-only. We've had
the same failure on the very same box 4 months ago. That time the
problem apparently converted itself into an issue that could be solved
by running fsck on the disks.

Today the problem appears as bad. On the one before the last boot we saw:

Feb  1 21:38:26 localhost kernel: powernow-k8: Found 1 AMD Athlon 64 /
Opteron processors (version 1.40.2)
Feb  1 21:38:26 localhost kernel: powernow-k8: BIOS error - no PSB or
ACPI _PSS objects
Feb  1 21:38:31 localhost Xprt_64: No matching visual for
__GLcontextMode with visual class = 0 (32775), nplanes = 8
Feb  1 21:38:35 localhost hal.hotplug[6170]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:38:38 localhost gconfd (mani-6656): démarrage (version
2.10.0), pid 6656 utilisateur « mani »
Feb  1 21:38:38 localhost gconfd (mani-6656): Adresse «
xml:readonly:/etc/gconf/gconf.xml.mandatory » résolue vers une source
de configuration en lectur
e seule à la position 0
Feb  1 21:38:38 localhost gconfd (mani-6656): Adresse «
xml:readwrite:/home/mani/.gconf » résolue vers une source de
configuration accessible en écritu
re à la position 1
Feb  1 21:38:38 localhost gconfd (mani-6656): Adresse «
xml:readonly:/etc/gconf/gconf.xml.defaults » résolue vers une source
de configuration en lecture
 seule à la position 2
Feb  1 21:38:50 localhost hal.hotplug[6663]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:38:56 localhost gconfd (mani-6656): Adresse «
xml:readwrite:/home/mani/.gconf » résolue vers une source de
configuration accessible en écritu
re à la position 0
Feb  1 21:39:06 localhost hal.hotplug[6733]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:39:21 localhost hal.hotplug[6801]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:39:36 localhost hal.hotplug[6847]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:39:51 localhost hal.hotplug[6874]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:40:07 localhost hal.hotplug[6901]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:40:22 localhost hal.hotplug[6926]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:40:37 localhost hal.hotplug[6951]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:40:53 localhost hal.hotplug[6976]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:41:08 localhost hal.hotplug[7005]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:41:23 localhost hal.hotplug[7030]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:41:39 localhost hal.hotplug[7055]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:41:54 localhost hal.hotplug[7080]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:42:09 localhost hal.hotplug[7104]: timout(10000 ms) waiting
for /block/dm-0
Feb  2 03:36:20 localhost kernel: ATA: abnormal status 0xD0 on port
0xFFFFC20000004087
Feb  2 03:36:20 localhost last message repeated 2 times

(The date in the future issue is
http://bugzilla.kernel.org/show_bug.cgi?id=3927).

and now we see that now in the logs (machine still on):

ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
SCSI error : <2 0 0 0> return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 67801511


So I can ask the user to boot a live CD and fsck the root partition.
But I don't feel like asking her to do that all often.

Upgrading the box to a newer kernel might help, but I fear the mess
that will be caused by the  user space tools incompatibilities. The
plan was to first update the distrib (to ubuntu 5.10, w/ kernel
2.6.12.9). I don't have physical access to the box, nor do I know any
Pinguin lover in the area.

That sounds to me like a hardware issue, but would gladly accept some
external input.

Below some more info.

Cheers,

Jerome


-- boot before last boot - /var/log/messages --


Feb  1 21:38:14 localhost syslogd 1.4.1#16ubuntu6: restart.
Feb  1 21:38:15 localhost kernel: Inspecting /boot/System.map-2.6.12.3
Feb  1 21:38:15 localhost kernel: Loaded 29641 symbols from
/boot/System.map-2.6.12.3.
Feb  1 21:38:15 localhost kernel: Symbols match kernel version 2.6.12.
Feb  1 21:38:15 localhost kernel: No module symbols loaded - kernel
modules not enabled.
Feb  1 21:38:15 localhost kernel: Bootdata ok (command line is
root=/dev/sda5 ro console=tty0 quiet splash)
Feb  1 21:38:15 localhost kernel: Linux version 2.6.12.3 (root@manies)
(version gcc 3.3.5 (Debian 1:3.3.5-8ubuntu2)) #1 Thu Jul 28 12:49:15
CEST 2005
Feb  1 21:38:15 localhost kernel: BIOS-provided physical RAM map:
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 0000000000000000 -
000000000009f400 (usable)
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 000000000009f400 -
00000000000a0000 (reserved)
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 0000000000100000 -
000000003fef0000 (usable)
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 000000003fef0000 -
000000003fef3000 (ACPI NVS)
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 000000003fef3000 -
000000003ff00000 (ACPI data)
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 00000000e0000000 -
00000000f0000000 (reserved)
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 00000000fec00000 -
00000000fec01000 (reserved)
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Feb  1 21:38:15 localhost kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Feb  1 21:38:15 localhost kernel: ACPI: PM-Timer IO Port: 0x4008
Feb  1 21:38:15 localhost kernel: ACPI: LAPIC (acpi_id[0x00]
lapic_id[0x00] enabled)
Feb  1 21:38:15 localhost kernel: Processor #0 15:15 APIC version 16
Feb  1 21:38:15 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high
edge lint[0x1])
Feb  1 21:38:15 localhost kernel: ACPI: IOAPIC (id[0x02]
address[0xfec00000] gsi_base[0])
Feb  1 21:38:15 localhost kernel: IOAPIC[0]: apic_id 2, version 33,
address 0xfec00000, GSI 0-23
Feb  1 21:38:15 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
Feb  1 21:38:15 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 21 low level)
Feb  1 21:38:15 localhost kernel: Setting APIC routing to flat
Feb  1 21:38:15 localhost kernel: Using ACPI (MADT) for SMP
configuration information
Feb  1 21:38:15 localhost kernel: Allocating PCI resources starting at
3ff00000 (gap: 3ff00000:a0100000)
Feb  1 21:38:15 localhost kernel: Checking aperture...
Feb  1 21:38:15 localhost kernel: CPU 0: aperture @ 25e000000 size 32 MB
Feb  1 21:38:15 localhost kernel: Aperture from northbridge cpu 0 too
small (32 MB)
Feb  1 21:38:15 localhost kernel: No AGP bridge found
Feb  1 21:38:15 localhost kernel: Built 1 zonelists
Feb  1 21:38:15 localhost kernel: Kernel command line: root=/dev/sda5
ro console=tty0 quiet splash
Feb  1 21:38:15 localhost kernel: Initializing CPU#0
Feb  1 21:38:15 localhost kernel: PID hash table entries: 4096 (order:
12, 131072 bytes)
Feb  1 21:38:15 localhost kernel: time.c: Using 3.579545 MHz PM timer.
Feb  1 21:38:15 localhost kernel: time.c: Detected 1800.110 MHz processor.
Feb  1 21:38:15 localhost kernel: time.c: Using PIT/TSC based timekeeping.
Feb  1 21:38:15 localhost kernel: Console: colour VGA+ 80x25
Feb  1 21:38:15 localhost kernel: Dentry cache hash table entries:
131072 (order: 8, 1048576 bytes)
Feb  1 21:38:15 localhost kernel: Inode-cache hash table entries:
65536 (order: 7, 524288 bytes)
Feb  1 21:38:15 localhost kernel: Memory: 1023468k/1047488k available
(1619k kernel code, 23204k reserved, 1065k data, 140k init)
Feb  1 21:38:15 localhost kernel: Security Framework v1.0.0 initialized
Feb  1 21:38:15 localhost kernel: SELinux:  Disabled at boot.
Feb  1 21:38:15 localhost kernel: Mount-cache hash table entries: 256
Feb  1 21:38:15 localhost kernel: CPU: L1 I Cache: 64K (64
bytes/line), D cache 64K (64 bytes/line)
Feb  1 21:38:15 localhost kernel: CPU: L2 Cache: 512K (64 bytes/line)
Feb  1 21:38:15 localhost kernel: CPU: AMD Athlon(tm) 64 Processor
3000+ stepping 00
Feb  1 21:38:15 localhost kernel: Using local APIC timer interrupts.
Feb  1 21:38:15 localhost kernel: Detected 12.500 MHz APIC timer.
Feb  1 21:38:15 localhost kernel: testing NMI watchdog ... OK.
Feb  1 21:38:15 localhost kernel: checking if image is initramfs...it
isn't (bad gzip magic numbers); looks like an initrd
Feb  1 21:38:15 localhost kernel: NET: Registered protocol family 16
Feb  1 21:38:15 localhost kernel: PCI: Using configuration type 1
Feb  1 21:38:15 localhost kernel: mtrr: v2.0 (20020519)
Feb  1 21:38:15 localhost kernel: ACPI: Subsystem revision 20050309
Feb  1 21:38:15 localhost kernel:     ACPI-0352: *** Error: Looking up
[\_SB_.PCI0.LPC0.LNK0] in namespace, AE_NOT_FOUND
Feb  1 21:38:15 localhost kernel: search_node ffff81003fae2ac0
start_node ffff81003fae2ac0 return_node 0000000000000000
Feb  1 21:38:15 localhost kernel: ACPI: Interpreter enabled
Feb  1 21:38:15 localhost kernel: ACPI: Using IOAPIC for interrupt routing
Feb  1 21:38:15 localhost kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb  1 21:38:15 localhost kernel: PCI: Probing PCI hardware (bus 00)
Feb  1 21:38:15 localhost kernel: PCI: Ignoring BAR0-3 of IDE
controller 0000:00:14.1
Feb  1 21:38:15 localhost kernel: PCI: Transparent bridge - 0000:00:14.4
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt Link [LNKA]
(IRQs 3 4 5 6 7 10 11) *0, disabled.
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt Link [LNKB]
(IRQs 3 4 5 6 7 10 11) *0, disabled.
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt Link [LNKC]
(IRQs 3 4 5 6 7 10 11) *0, disabled.
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt Link [LNKD]
(IRQs 3 4 5 6 7 10 11) *0, disabled.
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt Link [LNKE]
(IRQs 3 4 *5 6 7 10 11)
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt Link [LNKF]
(IRQs 3 4 5 6 7 10 11) *0, disabled.
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt Link [LNKG]
(IRQs 3 4 5 6 7 *10 11), disabled.
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt Link [LNKH]
(IRQs 3 4 5 6 7 10 *11)
Feb  1 21:38:15 localhost kernel: Linux Plug and Play Support v0.97
(c) Adam Belay
Feb  1 21:38:15 localhost kernel: pnp: PnP ACPI init
Feb  1 21:38:15 localhost kernel: pnp: PnP ACPI: found 13 devices
Feb  1 21:38:15 localhost kernel: usbcore: registered new driver usbfs
Feb  1 21:38:15 localhost kernel: usbcore: registered new driver hub
Feb  1 21:38:15 localhost kernel: PCI: Using ACPI for IRQ routing
Feb  1 21:38:15 localhost kernel: PCI: If a device doesn't work, try
"pci=routeirq".  If it helps, post a report
Feb  1 21:38:15 localhost kernel: PCI-DMA: Disabling IOMMU.
Feb  1 21:38:15 localhost kernel: pnp: 00:00: ioport range 0x228-0x22f
has been reserved
Feb  1 21:38:15 localhost kernel: pnp: 00:00: ioport range 0x40b-0x40b
has been reserved
Feb  1 21:38:15 localhost kernel: pnp: 00:00: ioport range 0x4d6-0x4d6
has been reserved
Feb  1 21:38:15 localhost kernel: pnp: 00:00: ioport range 0xc00-0xc01
has been reserved
Feb  1 21:38:15 localhost kernel: pnp: 00:00: ioport range 0xc14-0xc14
has been reserved
Feb  1 21:38:15 localhost kernel: pnp: 00:00: ioport range 0xc50-0xc52
has been reserved
Feb  1 21:38:15 localhost kernel: pnp: 00:00: ioport range 0xc6c-0xc6d
has been reserved
Feb  1 21:38:15 localhost kernel: pnp: 00:00: ioport range 0xc6f-0xc6f
has been reserved
Feb  1 21:38:15 localhost kernel: IA32 emulation $Id: sys_ia32.c,v
1.32 2002/03/24 13:02:28 ak Exp $
Feb  1 21:38:15 localhost kernel: audit: initializing netlink socket (disabled)
Feb  1 21:38:15 localhost kernel: VFS: Disk quotas dquot_6.5.1
Feb  1 21:38:15 localhost kernel: Dquot-cache hash table entries: 512
(order 0, 4096 bytes)
Feb  1 21:38:15 localhost kernel: devfs: 2004-01-31 Richard Gooch
(rgooch@atnf.csiro.au)
Feb  1 21:38:15 localhost kernel: devfs: boot_options: 0x0
Feb  1 21:38:15 localhost kernel: Initializing Cryptographic API
Feb  1 21:38:15 localhost kernel: Linux agpgart interface v0.101 (c) Dave Jones
Feb  1 21:38:15 localhost kernel: PNP: PS/2 Controller
[PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Feb  1 21:38:15 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  1 21:38:15 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  1 21:38:15 localhost kernel: Serial: 8250/16550 driver $Revision:
1.90 $ 48 ports, IRQ sharing enabled
Feb  1 21:38:15 localhost kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  1 21:38:15 localhost kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  1 21:38:15 localhost kernel: io scheduler noop registered
Feb  1 21:38:15 localhost kernel: io scheduler anticipatory registered
Feb  1 21:38:15 localhost kernel: io scheduler deadline registered
Feb  1 21:38:15 localhost kernel: io scheduler cfq registered
Feb  1 21:38:15 localhost kernel: RAMDISK driver initialized: 16 RAM
disks of 65536K size 1024 blocksize
Feb  1 21:38:15 localhost kernel: usbmon: debugs is not available
Feb  1 21:38:15 localhost kernel: NET: Registered protocol family 2
Feb  1 21:38:15 localhost kernel: IP: routing cache hash table of 8192
buckets, 64Kbytes
Feb  1 21:38:15 localhost kernel: TCP established hash table entries:
131072 (order: 8, 1048576 bytes)
Feb  1 21:38:15 localhost kernel: TCP bind hash table entries: 65536
(order: 7, 524288 bytes)
Feb  1 21:38:15 localhost kernel: TCP: Hash tables configured
(established 131072 bind 65536)
Feb  1 21:38:15 localhost kernel: NET: Registered protocol family 8
Feb  1 21:38:15 localhost kernel: NET: Registered protocol family 20
Feb  1 21:38:15 localhost kernel: ACPI wakeup devices:
Feb  1 21:38:15 localhost kernel: PCI0 USB0 USB1 USB2 AUDO  P2P PS2M PS2K
Feb  1 21:38:15 localhost kernel: ACPI: (supports S0 S1 S4 S5)
Feb  1 21:38:15 localhost kernel: RAMDISK: cramfs filesystem found at block 0
Feb  1 21:38:15 localhost kernel: RAMDISK: Loading 3992KiB [1 disk]
into ram disk...
|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^Hdone.
Feb  1 21:38:15 localhost kernel: VFS: Mounted root (cramfs
filesystem) readonly.
Feb  1 21:38:15 localhost kernel: input: AT Translated Set 2 keyboard
on isa0060/serio0
Feb  1 21:38:15 localhost kernel: Freeing unused kernel memory: 140k freed
Feb  1 21:38:15 localhost kernel: SCSI subsystem initialized
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt 0000:00:11.0[A]
-> GSI 23 (level, low) -> IRQ 23
Feb  1 21:38:15 localhost kernel: ata1: SATA max UDMA/100 cmd
0xFFFFC20000002080 ctl 0xFFFFC2000000208A bmdma 0xFFFFC20000002000 irq
23
Feb  1 21:38:15 localhost kernel: ata2: SATA max UDMA/100 cmd
0xFFFFC200000020C0 ctl 0xFFFFC200000020CA bmdma 0xFFFFC20000002008 irq
23
Feb  1 21:38:15 localhost kernel: ata1: no device found (phy stat 00000000)
Feb  1 21:38:15 localhost kernel: scsi0 : sata_sil
Feb  1 21:38:15 localhost kernel: ata2: no device found (phy stat 00000000)
Feb  1 21:38:15 localhost kernel: scsi1 : sata_sil
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt 0000:00:12.0[A]
-> GSI 22 (level, low) -> IRQ 22
Feb  1 21:38:15 localhost kernel: ata3: SATA max UDMA/100 cmd
0xFFFFC20000004080 ctl 0xFFFFC2000000408A bmdma 0xFFFFC20000004000 irq
22
Feb  1 21:38:15 localhost kernel: ata4: SATA max UDMA/100 cmd
0xFFFFC200000040C0 ctl 0xFFFFC200000040CA bmdma 0xFFFFC20000004008 irq
22
Feb  1 21:38:15 localhost kernel: ata3: dev 0 ATA, max UDMA/133,
398297088 sectors: lba48
Feb  1 21:38:15 localhost kernel: ata3: dev 0 configured for UDMA/100
Feb  1 21:38:15 localhost kernel: scsi2 : sata_sil
Feb  1 21:38:15 localhost kernel: ata4: no device found (phy stat 00000000)
Feb  1 21:38:15 localhost kernel: scsi3 : sata_sil
Feb  1 21:38:15 localhost kernel:   Vendor: ATA       Model: Maxtor
6L200M0    Rev: BANC
Feb  1 21:38:15 localhost kernel:   Type:   Direct-Access             
        ANSI SCSI revision: 05
Feb  1 21:38:15 localhost kernel: SCSI device sda: 398297088 512-byte
hdwr sectors (203928 MB)
Feb  1 21:38:15 localhost kernel: SCSI device sda: drive cache: write back
Feb  1 21:38:15 localhost kernel: SCSI device sda: 398297088 512-byte
hdwr sectors (203928 MB)
Feb  1 21:38:15 localhost kernel: SCSI device sda: drive cache: write back
Feb  1 21:38:15 localhost kernel:  /dev/scsi/host2/bus0/target0/lun0:
p1 p2 < p5 p6 p7 >
Feb  1 21:38:15 localhost kernel: Attached scsi disk sda at scsi2,
channel 0, id 0, lun 0
Feb  1 21:38:15 localhost kernel: ACPI: Fan [FAN] (on)
Feb  1 21:38:15 localhost kernel: ACPI: Thermal Zone [THRM] (-127 C)
Feb  1 21:38:15 localhost kernel: NET: Registered protocol family 1
Feb  1 21:38:15 localhost kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Feb  1 21:38:15 localhost kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Feb  1 21:38:15 localhost kernel: ATIIXP: IDE controller at PCI slot
0000:00:14.1
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt 0000:00:14.1[A]
-> GSI 16 (level, low) -> IRQ 16
Feb  1 21:38:15 localhost kernel: ATIIXP: chipset revision 0
Feb  1 21:38:15 localhost kernel: ATIIXP: not 100%% native mode: will
probe irqs later
Feb  1 21:38:15 localhost kernel:     ide0: BM-DMA at 0xf300-0xf307,
BIOS settings: hda:pio, hdb:pio
Feb  1 21:38:15 localhost kernel:     ide1: BM-DMA at 0xf308-0xf30f,
BIOS settings: hdc:pio, hdd:pio
Feb  1 21:38:15 localhost kernel: hda: HL-DT-ST DVDRAM GSA-4163B,
ATAPI CD/DVD-ROM drive
Feb  1 21:38:15 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  1 21:38:15 localhost kernel: Attempting manual resume
Feb  1 21:38:15 localhost kernel: kjournald starting.  Commit interval 5 seconds
Feb  1 21:38:15 localhost kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Feb  1 21:38:15 localhost kernel: Adding 1951856k swap on /dev/sda6. 
Priority:-1 extents:1
Feb  1 21:38:15 localhost kernel: EXT3 FS on sda5, internal journal
Feb  1 21:38:15 localhost kernel: hda: ATAPI 40X DVD-ROM DVD-R-RAM
CD-R/RW drive, 2048kB Cache
Feb  1 21:38:15 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Feb  1 21:38:15 localhost kernel: parport: PnPBIOS parport detected.
Feb  1 21:38:15 localhost kernel: parport0: PC-style at 0x378, irq 7
[PCSPP,TRISTATE]
Feb  1 21:38:15 localhost kernel: lp0: using parport0 (interrupt-driven).
Feb  1 21:38:15 localhost kernel: mice: PS/2 mouse device common for all mice
Feb  1 21:38:15 localhost kernel: Real Time Clock Driver v1.12
Feb  1 21:38:15 localhost kernel: device-mapper: 4.4.0-ioctl
(2005-01-12) initialised: dm-devel@redhat.com
Feb  1 21:38:15 localhost kernel: md: md driver 0.90.1
MAX_MD_DEVS=256, MD_SB_DISKS=27
Feb  1 21:38:15 localhost kernel: input: ImExPS/2 Generic Explorer
Mouse on isa0060/serio1
Feb  1 21:38:15 localhost kernel: ts: Compaq touchscreen protocol output
Feb  1 21:38:15 localhost kernel: cdrom: open failed.
Feb  1 21:38:15 localhost kernel: device-mapper: error adding target to table
Feb  1 21:38:15 localhost last message repeated 15 times
Feb  1 21:38:15 localhost kernel: kjournald starting.  Commit interval 5 seconds
Feb  1 21:38:15 localhost kernel: EXT3 FS on sda7, internal journal
Feb  1 21:38:15 localhost kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Feb  1 21:38:15 localhost kernel: input: PC Speaker
Feb  1 21:38:15 localhost kernel: FDC 0 is a post-1991 82077
Feb  1 21:38:15 localhost kernel: pci_hotplug: PCI Hot Plug PCI Core
version: 0.5
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt 0000:00:13.0[A]
-> GSI 19 (level, low) -> IRQ 19
Feb  1 21:38:15 localhost kernel: ohci_hcd 0000:00:13.0: PCI device
1002:4374 (ATI Technologies Inc)
Feb  1 21:38:15 localhost kernel: ohci_hcd 0000:00:13.0: new USB bus
registered, assigned bus number 1
Feb  1 21:38:15 localhost kernel: ohci_hcd 0000:00:13.0: irq 19, io
mem 0xfe02d000
Feb  1 21:38:15 localhost kernel: hub 1-0:1.0: USB hub found
Feb  1 21:38:15 localhost kernel: hub 1-0:1.0: 4 ports detected
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt 0000:00:13.1[A]
-> GSI 19 (level, low) -> IRQ 19
Feb  1 21:38:15 localhost kernel: ohci_hcd 0000:00:13.1: PCI device
1002:4375 (ATI Technologies Inc)
Feb  1 21:38:15 localhost kernel: ohci_hcd 0000:00:13.1: new USB bus
registered, assigned bus number 2
Feb  1 21:38:15 localhost kernel: ohci_hcd 0000:00:13.1: irq 19, io
mem 0xfe02c000
Feb  1 21:38:15 localhost kernel: hub 2-0:1.0: USB hub found
Feb  1 21:38:15 localhost kernel: hub 2-0:1.0: 4 ports detected
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt 0000:00:13.2[A]
-> GSI 19 (level, low) -> IRQ 19
Feb  1 21:38:15 localhost kernel: ehci_hcd 0000:00:13.2: PCI device
1002:4373 (ATI Technologies Inc)
Feb  1 21:38:15 localhost kernel: ehci_hcd 0000:00:13.2: new USB bus
registered, assigned bus number 3
Feb  1 21:38:15 localhost kernel: ehci_hcd 0000:00:13.2: irq 19, io
mem 0xfe02b000
Feb  1 21:38:15 localhost kernel: ehci_hcd 0000:00:13.2: USB 2.0
initialized, EHCI 1.00, driver 10 Dec 2004
Feb  1 21:38:15 localhost kernel: hub 3-0:1.0: USB hub found
Feb  1 21:38:15 localhost kernel: hub 3-0:1.0: 8 ports detected
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt 0000:00:14.5[B]
-> GSI 17 (level, low) -> IRQ 17
Feb  1 21:38:15 localhost kernel: Linux video capture interface: v1.00
Feb  1 21:38:15 localhost kernel: bttv: driver version 0.9.15 loaded
Feb  1 21:38:15 localhost kernel: bttv: using 8 buffers with 2080k
(520 pages) each for capture
Feb  1 21:38:15 localhost kernel: bttv: Bt8xx card found (0).
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt 0000:02:05.0[A]
-> GSI 16 (level, low) -> IRQ 16
Feb  1 21:38:15 localhost kernel: bttv0: Bt878 (rev 17) at
0000:02:05.0, irq: 16, latency: 64, mmio: 0xfdeff000
Feb  1 21:38:15 localhost kernel: bttv0: detected: Pinnacle PCTV
[card=39], PCI subsystem ID is 11bd:0012
Feb  1 21:38:15 localhost kernel: bttv0: using: Pinnacle PCTV
Studio/Rave [card=39,autodetected]
Feb  1 21:38:15 localhost kernel: bttv0: i2c: checking for MSP34xx @
0x80... not found
Feb  1 21:38:15 localhost kernel: bttv0: pinnacle/mt: id=4
info="PAL+SECAM / mono" radio=no
Feb  1 21:38:15 localhost kernel: bttv0: i2c: checking for MSP34xx @
0x80... not found
Feb  1 21:38:15 localhost kernel: bttv0: i2c: checking for TDA9875 @
0xb0... not found
Feb  1 21:38:15 localhost kernel: bttv0: i2c: checking for TDA7432 @
0x8a... not found
Feb  1 21:38:15 localhost kernel: tuner 0-0060: chip found @ 0xc0
(bt878 #0 [sw])
Feb  1 21:38:15 localhost kernel: tuner 0-0060: microtune:
companycode=4d54 part=04 rev=04
Feb  1 21:38:15 localhost kernel: tuner 0-0060: microtune MT2032 found, OK
Feb  1 21:38:15 localhost kernel: bttv0: registered device video0
Feb  1 21:38:15 localhost kernel: bttv0: registered device vbi0
Feb  1 21:38:15 localhost kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Feb  1 21:38:15 localhost kernel: 8139too Fast Ethernet driver 0.9.27
Feb  1 21:38:15 localhost kernel: ACPI: PCI Interrupt 0000:02:0b.0[A]
-> GSI 20 (level, low) -> IRQ 20
Feb  1 21:38:15 localhost kernel: eth0: RealTek RTL8139 at
0xffffc20000118000, 00:01:2e:0b:ad:c8, IRQ 20
Feb  1 21:38:15 localhost kernel: 8139cp: 10/100 PCI Ethernet driver
v1.2 (Mar 22, 2004)
Feb  1 21:38:15 localhost kernel: CSLIP: code copyright 1989 Regents
of the University of California
Feb  1 21:38:15 localhost kernel: PPP generic driver version 2.4.2
Feb  1 21:38:16 localhost kernel: NET: Registered protocol family 24
Feb  1 21:38:16 localhost pppd[4928]: Plugin rp-pppoe.so loaded.
Feb  1 21:38:16 localhost pppd[4928]: RP-PPPoE plugin version 3.3
compiled against pppd 2.4.2
Feb  1 21:38:16 localhost kernel: NET: Registered protocol family 17
Feb  1 21:38:16 localhost kernel: NET: Registered protocol family 10
Feb  1 21:38:16 localhost kernel: Disabled Privacy Extensions on
device ffffffff803659e0(lo)
Feb  1 21:38:16 localhost kernel: IPv6 over IPv4 tunneling driver
Feb  1 21:38:16 localhost pppd[5195]: pppd 2.4.2 started by root, uid 0
Feb  1 21:38:16 localhost kernel: eth0: link up, 100Mbps, full-duplex,
lpa 0x45E1
Feb  1 21:38:17 localhost pppd[5195]: PPP session is 61829
Feb  1 21:38:17 localhost pppd[5195]: Using interface ppp0
Feb  1 21:38:17 localhost pppd[5195]: Connect: ppp0 <--> eth0
Feb  1 21:38:17 localhost pppd[5195]: Couldn't increase MTU to 1500
Feb  1 21:38:17 localhost pppd[5195]: Couldn't increase MRU to 1500
Feb  1 21:38:17 localhost pppd[5195]: Couldn't increase MRU to 1500
Feb  1 21:38:18 localhost kernel: ACPI: Power Button (FF) [PWRF]
Feb  1 21:38:20 localhost hal.hotplug[4415]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:38:21 localhost pppd[5195]: Couldn't increase MTU to 1500
Feb  1 21:38:21 localhost pppd[5195]: Couldn't increase MRU to 1500
Feb  1 21:38:21 localhost dhcpd: Internet Systems Consortium DHCP Server V3.0.1
Feb  1 21:38:21 localhost dhcpd: Copyright 2004 Internet Systems Consortium.
Feb  1 21:38:21 localhost dhcpd: All rights reserved.
Feb  1 21:38:21 localhost dhcpd: For info, please visit
http://www.isc.org/sw/dhcp/
Feb  1 21:38:21 localhost pppd[5195]: Couldn't increase MRU to 1500
Feb  1 21:38:21 localhost dhcpd: Wrote 0 leases to leases file.
Feb  1 21:38:21 localhost dhcpd:
Feb  1 21:38:22 localhost pppd[5195]: CHAP authentication succeeded:
CHAP authentication success, unit 5215
Feb  1 21:38:22 localhost pppd[5195]: peer from calling number
00:02:3B:02:83:69 authorized
Feb  1 21:38:22 localhost pppd[5195]: local  IP address 80.170.16.16
Feb  1 21:38:22 localhost pppd[5195]: remote IP address 80.170.0.1
Feb  1 21:38:22 localhost pppd[5195]: primary   DNS address 212.151.136.246
Feb  1 21:38:22 localhost pppd[5195]: secondary DNS address 212.151.136.242
Feb  1 21:38:22 localhost kernel: ip_tables: (C) 2000-2002 Netfilter core team
Feb  1 21:38:23 localhost kernel: ip_conntrack version 2.1 (4091
buckets, 32728 max) - 336 bytes per conntrack
Feb  1 21:38:26 localhost kernel: powernow-k8: Found 1 AMD Athlon 64 /
Opteron processors (version 1.40.2)
Feb  1 21:38:26 localhost kernel: powernow-k8: BIOS error - no PSB or
ACPI _PSS objects
Feb  1 21:38:31 localhost Xprt_64: No matching visual for
__GLcontextMode with visual class = 0 (32775), nplanes = 8
Feb  1 21:38:35 localhost hal.hotplug[6170]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:38:38 localhost gconfd (mani-6656): démarrage (version
2.10.0), pid 6656 utilisateur « mani »
Feb  1 21:38:38 localhost gconfd (mani-6656): Adresse «
xml:readonly:/etc/gconf/gconf.xml.mandatory » résolue vers une source
de configuration en lectur
e seule à la position 0
Feb  1 21:38:38 localhost gconfd (mani-6656): Adresse «
xml:readwrite:/home/mani/.gconf » résolue vers une source de
configuration accessible en écritu
re à la position 1
Feb  1 21:38:38 localhost gconfd (mani-6656): Adresse «
xml:readonly:/etc/gconf/gconf.xml.defaults » résolue vers une source
de configuration en lecture
 seule à la position 2
Feb  1 21:38:50 localhost hal.hotplug[6663]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:38:56 localhost gconfd (mani-6656): Adresse «
xml:readwrite:/home/mani/.gconf » résolue vers une source de
configuration accessible en écritu
re à la position 0
Feb  1 21:39:06 localhost hal.hotplug[6733]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:39:21 localhost hal.hotplug[6801]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:39:36 localhost hal.hotplug[6847]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:39:51 localhost hal.hotplug[6874]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:40:07 localhost hal.hotplug[6901]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:40:22 localhost hal.hotplug[6926]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:40:37 localhost hal.hotplug[6951]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:40:53 localhost hal.hotplug[6976]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:41:08 localhost hal.hotplug[7005]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:41:23 localhost hal.hotplug[7030]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:41:39 localhost hal.hotplug[7055]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:41:54 localhost hal.hotplug[7080]: timout(10000 ms) waiting
for /block/dm-0
Feb  1 21:42:09 localhost hal.hotplug[7104]: timout(10000 ms) waiting
for /block/dm-0
Feb  2 03:36:20 localhost kernel: ATA: abnormal status 0xD0 on port
0xFFFFC20000004087
Feb  2 03:36:20 localhost last message repeated 2 times
Feb  2 03:40:20 localhost kernel: ATA: abnormal status 0xD0 on port
0xFFFFC20000004087
Feb  2 03:40:20 localhost last message repeated 2 times
Feb  2 04:26:35 localhost kernel: ATA: abnormal status 0xD0 on port
0xFFFFC20000004087
Feb  2 04:26:35 localhost last message repeated 2 times
Feb  2 04:27:50 localhost kernel: ATA: abnormal status 0xD0 on port
0xFFFFC20000004087
Feb  2 04:27:50 localhost last message repeated 2 times
Feb  2 04:28:25 localhost kernel: ATA: abnormal status 0xD0 on port
0xFFFFC20000004087
Feb  2 04:28:25 localhost last message repeated 2 times
Feb  2 04:29:25 localhost kernel: ATA: abnormal status 0xD0 on port
0xFFFFC20000004087
Feb  2 04:29:25 localhost last message repeated 2 times
Feb  2 04:30:00 localhost kernel: ATA: abnormal status 0xD0 on port
0xFFFFC20000004087

-- last boot - dmesg --

 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 3ff00000 (gap: 3ff00000:a0100000)
Checking aperture...
CPU 0: aperture @ 256000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Kernel command line: root=/dev/sda5 ro console=tty0 quiet splash
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1800.153 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 1023468k/1047488k available (1619k kernel code, 23204k
reserved, 1065k data, 140k init)
Calibrating delay loop... 3538.94 BogoMIPS (lpj=1769472)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Using local APIC timer interrupts.
Detected 12.501 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs...it isn't (bad gzip magic numbers);
looks like an initrd
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LPC0.LNK0] in
namespace, AE_NOT_FOUND
search_node ffff81003fae2ac0 start_node ffff81003fae2ac0 return_node
0000000000000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 11), disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 3 of device 0000:00:00.0
PCI-DMA: Disabling IOMMU.
pnp: 00:00: ioport range 0x228-0x22f has been reserved
pnp: 00:00: ioport range 0x40b-0x40b has been reserved
pnp: 00:00: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:00: ioport range 0xc00-0xc01 has been reserved
pnp: 00:00: ioport range 0xc14-0xc14 has been reserved
pnp: 00:00: ioport range 0xc50-0xc52 has been reserved
pnp: 00:00: ioport range 0xc6c-0xc6d has been reserved
pnp: 00:00: ioport range 0xc6f-0xc6f has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1138874976.241:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
usbmon: debugs is not available
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices:
PCI0 USB0 USB1 USB2 AUDO  P2P PS2M PS2K
ACPI: (supports S0 S1 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 3992KiB [1 disk] into ram disk...
|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/done.
VFS: Mounted root (cramfs filesystem) readonly.
input: AT Translated Set 2 keyboard on isa0060/serio0
Freeing unused kernel memory: 140k freed
SCSI subsystem initialized
libata version 1.11 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 23 (level, low) -> IRQ 23
ata1: SATA max UDMA/100 cmd 0xFFFFC20000002080 ctl 0xFFFFC2000000208A
bmdma 0xFFFFC20000002000 irq 23
ata2: SATA max UDMA/100 cmd 0xFFFFC200000020C0 ctl 0xFFFFC200000020CA
bmdma 0xFFFFC20000002008 irq 23
ata1: no device found (phy stat 00000000)
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ata3: SATA max UDMA/100 cmd 0xFFFFC20000004080 ctl 0xFFFFC2000000408A
bmdma 0xFFFFC20000004000 irq 22
ata4: SATA max UDMA/100 cmd 0xFFFFC200000040C0 ctl 0xFFFFC200000040CA
bmdma 0xFFFFC20000004008 irq 22
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:207f
ata3: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6L200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host2/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (-127 C)
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf300-0xf307, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf308-0xf30f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
Attempting manual resume
swsusp: Suspend partition has wrong signature?
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1951856k swap on /dev/sda6.  Priority:-1 extents:1
EXT3 FS on sda5, internal journal
hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
mice: PS/2 mouse device common for all mice
Real Time Clock Driver v1.12
Losing some ticks... checking if CPU frequency changed.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
ts: Compaq touchscreen protocol output
cdrom: open failed.
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
device-mapper: dm-linear: Device lookup failed
device-mapper: error adding target to table
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
input: PC Speaker
FDC 0 is a post-1991 82077
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:13.0: PCI device 1002:4374 (ATI Technologies Inc)
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 19, io mem 0xfe02d000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:13.1: PCI device 1002:4375 (ATI Technologies Inc)
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 19, io mem 0xfe02c000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.2: PCI device 1002:4373 (ATI Technologies Inc)
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:13.2: irq 19, io mem 0xfe02b000
ehci_hcd 0000:00:13.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 17
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 16 (level, low) -> IRQ 16
bttv0: Bt878 (rev 17) at 0000:03:05.0, irq: 16, latency: 64, mmio: 0xfdcff000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00fff3ff [init]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: pinnacle/mt: id=4 info="PAL+SECAM / mono" radio=no
bttv0: using tuner=33
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tda9885/6/7: chip found @ 0x86
tuner 0-0060: chip found @ 0xc0 (bt878 #0 [sw])
tuner 0-0060: microtune: companycode=4d54 part=04 rev=04
tuner 0-0060: microtune MT2032 found, OK
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:03:0b.0[A] -> GSI 20 (level, low) -> IRQ 20
eth0: RealTek RTL8139 at 0xffffc20000118000, 00:01:2e:0b:ad:c8, IRQ 20
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
SCSI error : <2 0 0 0> return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 67801511
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
SCSI error : <2 0 0 0> return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 67801511
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
NET: Registered protocol family 24
NET: Registered protocol family 17
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff803659e0(lo)
IPv6 over IPv4 tunneling driver
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
ACPI: Power Button (FF) [PWRF]
ibm_acpi: acpi_evalf(DHKC, d, ...) failed: 4097
ibm_acpi: `enable,0xffff' invalid for parameter `hotkey'
EXT3-fs error (device sda5): ext3_free_blocks_sb: bit already cleared
for block 3426307
Remounting filesystem read-only
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 336 bytes per conntrack
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
eth0: no IPv6 routers present


-- lsmod --

Module                  Size  Used by
cpufreq_userspace       5584  0
cpufreq_powersave       2432  0
cpufreq_ondemand        7212  0
ipt_limit               3072  10
iptable_mangle          3584  0
ipt_LOG                 7808  10
ipt_MASQUERADE          4224  0
iptable_nat            25588  1 ipt_MASQUERADE
ipt_TOS                 3072  0
ipt_REJECT              6016  1
ip_conntrack_irc       73136  0
ip_conntrack_ftp       73648  0
ipt_state               2688  8
ip_conntrack           49060  5
ipt_MASQUERADE,iptable_nat,ip_conntrack_irc,ip_conntrack_ftp,ipt_state
ipt_TCPMSS              4992  0
ipt_tcpmss              3072  0
iptable_filter          3840  1
ip_tables              20480  11
ipt_limit,iptable_mangle,ipt_LOG,ipt_MASQUERADE,iptable_nat,ipt_TOS,ipt_REJECT,ipt_state,ipt_TCPMSS,ipt_tcpmss,iptable_filter
video                  18952  0
container               5376  0
button                  7968  0
battery                11656  0
ac                      5896  0
ipv6                  256128  12
af_packet              22924  2
pppoe                  15360  2
pppox                   4368  1 pppoe
ppp_generic            30112  6 pppoe,pppox
slhc                    7424  1 ppp_generic
8139cp                 21888  0
8139too                27392  0
mii                     6144  2 8139cp,8139too
tuner                  30248  0
tda9887                16408  0
bttv                  176848  0
video_buf              24452  1 bttv
firmware_class         11392  1 bttv
i2c_algo_bit           10248  1 bttv
v4l2_common             7808  1 bttv
btcx_risc               5640  1 bttv
tveeprom               16024  1 bttv
i2c_core               23448  5 tuner,tda9887,bttv,i2c_algo_bit,tveeprom
videodev               12032  1 bttv
snd_atiixp             22304  0
snd_ac97_codec         85200  1 snd_atiixp
snd_pcm_oss            52512  0
snd_mixer_oss          18432  1 snd_pcm_oss
snd_pcm                95884  3 snd_atiixp,snd_ac97_codec,snd_pcm_oss
snd_timer              25736  1 snd_pcm
snd                    58088  6
snd_atiixp,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              11296  1 snd
snd_page_alloc         11016  2 snd_atiixp,snd_pcm
ehci_hcd               33416  0
ohci_hcd               20868  0
pci_hotplug            29672  0
floppy                 62456  0
pcspkr                  4176  0
vfat                   14080  0
fat                    52144  1 vfat
evdev                  10496  0
tsdev                   8960  0
md                     46464  0
dm_mod                 58360  0
rtc                    13704  0
psmouse                29060  0
mousedev               13284  0
parport_pc             38344  1
lp                     13704  0
parport                39564  2 parport_pc,lp
ide_cd                 43784  0
cdrom                  41256  1 ide_cd
ide_disk               17664  0
ide_generic             1792  0 [permanent]
via82cxxx              12720  0 [permanent]
trm290                  4996  0 [permanent]
triflex                 4608  0 [permanent]
slc90e66                6656  0 [permanent]
sis5513                16784  0 [permanent]
siimage                12672  0 [permanent]
serverworks             9360  0 [permanent]
sc1200                  7936  0 [permanent]
rz1000                  3328  0 [permanent]
piix                   12420  0 [permanent]
pdc202xx_old           12032  0 [permanent]
pdc202xx_new            9984  0 [permanent]
opti621                 4996  0 [permanent]
ns87415                 4552  0 [permanent]
hpt366                 20096  0 [permanent]
hpt34x                  5888  0 [permanent]
generic                 5376  0 [permanent]
cy82c693                5120  0 [permanent]
cs5530                  5632  0 [permanent]
cs5520                  5504  0 [permanent]
cmd64x                 12492  0 [permanent]
atiixp                  6928  0 [permanent]
amd74xx                14512  0 [permanent]
alim15x3               11160  0 [permanent]
aec62xx                 8064  0 [permanent]
ide_core              137252  28
ide_cd,ide_disk,ide_generic,via82cxxx,trm290,triflex,slc90e66,sis5513,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,pdc202xx_new,opti621,ns87415,hpt366,hpt34x,generic,cy82c693,cs5530,cs5520,cmd64x,atiixp,amd74xx,alim15x3,aec62xx
unix                   28984  38
thermal                16016  0
processor              26824  1 thermal
fan                     5512  0
sata_sil               10884  3
libata                 50440  1 sata_sil
sd_mod                 18968  4
scsi_mod              155120  2 libata,sd_mod
ext3                  137360  2
jbd                    58416  1 ext3


-- lspci --

0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5951
	Subsystem: ATI Technologies Inc: Unknown device 5951
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 2: I/O ports at 4100 [disabled] [size=32]
	Region 3: Memory at <ignored> (64-bit, non-prefetchable)

0000:00:02.0 PCI bridge: ATI Technologies Inc: Unknown device 5a34
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fdb00000-fdbfffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:06.0 PCI bridge: ATI Technologies Inc: Unknown device 5a38
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fda00000-fdafffff
	Prefetchable memory behind bridge: fde00000-fdefffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:11.0 RAID bus controller: ATI Technologies Inc: Unknown device 437a
	Subsystem: ATI Technologies Inc: Unknown device 437a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at fe00 [size=8]
	Region 1: I/O ports at fd00 [size=4]
	Region 2: I/O ports at fc00 [size=8]
	Region 3: I/O ports at fb00 [size=4]
	Region 4: I/O ports at fa00 [size=16]
	Region 5: Memory at fe02f000 (32-bit, non-prefetchable) [size=512]
	Capabilities: <available only to root>

0000:00:12.0 RAID bus controller: ATI Technologies Inc: Unknown device 4379
	Subsystem: ATI Technologies Inc: Unknown device 4379
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at f900 [size=8]
	Region 1: I/O ports at f800 [size=4]
	Region 2: I/O ports at f700 [size=8]
	Region 3: I/O ports at f600 [size=4]
	Region 4: I/O ports at f500 [size=16]
	Region 5: Memory at fe02e000 (32-bit, non-prefetchable) [size=512]
	Capabilities: <available only to root>

0000:00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4374
(prog-if 10 [OHCI])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4375
(prog-if 10 [OHCI])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4373
(prog-if 20 [EHCI])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:00:14.0 SMBus: ATI Technologies Inc: Unknown device 4372 (rev 04)
	Subsystem: PC Partner Limited: Unknown device 0a56
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Region 0: I/O ports at 0400 [size=16]
	Region 1: Memory at fe02a000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4376
(prog-if 8a [Master SecP PriP])
	Subsystem: PC Partner Limited: Unknown device 0a56
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort+
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f300 [size=16]
	Capabilities: <available only to root>

0000:00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 4377
	Subsystem: PC Partner Limited: Unknown device 0a56
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4371
(prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fdd00000-fddfffff
	Prefetchable memory behind bridge: fdc00000-fdcfffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:14.5 Multimedia audio controller: ATI Technologies Inc:
Unknown device 4370
	Subsystem: PC Partner Limited: Unknown device 5215
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at fe029000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: <available only to root>

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown
device 5b60 (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 002a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at ee00 [size=256]
	Region 2: Memory at fdbf0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:01:00.1 Display controller: ATI Technologies Inc: Unknown device 5b70
	Subsystem: Asustek Computer, Inc.: Unknown device 002b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at fdbe0000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: <available only to root>

0000:03:05.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11)
	Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fdcff000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:03:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
	Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver,
audio section)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fdcfe000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:03:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: PC Partner Limited: Unknown device 8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at ce00 [size=256]
	Region 1: Memory at fddff000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>
