Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423784AbWKHVJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423784AbWKHVJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423786AbWKHVJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:09:20 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:39008 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1423784AbWKHVJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:09:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=EMEQVCWUbbyWDrbFjgBobtkWVpfUXMqJzxOFb4EvmrsUieroxf6EUuYv96R8IY7drqguLPPL4GpwWrP/Xd14abYw5e0DV9MAc67HHsUzYvU/goI3iGKknuL5+ncOkY0n0k1alNwmH8fSdAZoLZ97jnbqk9YaNe6jjKXSCLf/XEY=
Message-ID: <d9a083460611081309r680a5420sbb6156f5d4240797@mail.gmail.com>
Date: Wed, 8 Nov 2006 22:09:17 +0100
From: Jano <jano@90-mo3-3.acn.waw.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 6955711459e22ed2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Lis, 19:00, Jiri Slaby <jirisl...@gmail.com> wrote:
> Jano wrote:
> > Hi everyone,
>
> > Recently I've downloaded and compiled kernel 2.6.18.1. After installing
> > modules and kernel and updating Grub I rebooted my box and tried to
> > launch new kernel. Everything was launching nicely, but while loading
> > GDM the screen went black and I was unable to switch console (using
> > ctrl+alt+Fn). I've rebooted using single user mode and logged in as
> > root. What I've discovered is the fact that I cannot mount any
> > filesystem from /dev/hdb. All filesystems from /dev/hda work as they
> > ought to, but when I try to mount something from the second hard disk I
> > get:
>
> > # mount -t ext3 /dev/hdb1 /home
> > /dev/hdb1 already mounted or /home is busy
> > # umount /home
> > /home not mounted
>
> > Here you've got my /etc/fstab:
>
> > proc            /proc           proc    defaults        0       0
> > /dev/hda3       /               ext3    defaults,errors=remount-ro 0
> >   1
> > /dev/hda1       /boot           ext3    defaults        0       2
> > /dev/hdb1       /home           ext3    defaults        0       2
> > /dev/hda5       /usr            ext3    defaults        0       2
> > /dev/hda7       none            swap    sw              0       0
> > /dev/hdc        /media/cdrom0   udf,iso9660 user,noauto 0       0
> > /dev/sda1       /media/usbdisk  vfat    user,auto       0       0
>
> > Currently I am using kernel 2.6.15 from Ubuntu repositories. All
> > filesystems work perfectly. Have you got any ideas what might be going
> > on?dmesg >2.6.15
> reboot
> dmesg >2.6.18
> diff -u 2.6.15 2.6.18 >post_this_to_lkml
> might help us. Also attach /proc/mounts.
>
> regards,

Thank you for your feedback. Here you've got my /proc/mount on 2.6.18.1

rootfs / rootfs rw 0 0
/dev/root / ext3 rw,data=ordered 0 0
proc /proc proc rw 0 0
sysfs /sys sysfs rw 0 0
tmpfs /var/run tmpfs rw 0 0
tmpfs /var/lock tmpfs rw 0 0
/dev/root /dev/.static/dev ext3 rw,data=ordered 0 0
udev /dev tmpfs rw 0 0
devpts /dev/pts devpts rw 0 0
tmpfs /dev/shm tmpfs rw 0 0
tmpfs /var/run tmpfs rw 0 0
tmpfs /var/lock tmpfs rw 0 0
/dev/hda1 /boot ext3 rw,data=ordered 0 0
/dev/hda5 /usr ext3 rw,data=ordered 0 0

And dmesg diff, exactly as you suggested:

--- 2.6.15	2006-11-08 18:06:16.000000000 +0100
+++ 2.6.18.1	2006-11-08 22:07:53.000000000 +0100
@@ -1,317 +1,254 @@
-[17179569.184000] Linux version 2.6.15-27-386 (buildd@terranova) (gcc
version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 PREEMPT Sat Sep 16 01:51:59
UTC 2006
-[17179569.184000] BIOS-provided physical RAM map:
-[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
-[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
-[17179569.184000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
-[17179569.184000]  BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
-[17179569.184000]  BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
-[17179569.184000]  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
-[17179569.184000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
-[17179569.184000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
-[17179569.184000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
-[17179569.184000] 127MB HIGHMEM available.
-[17179569.184000] 896MB LOWMEM available.
-[17179569.184000] On node 0 totalpages: 262140
-[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
-[17179569.184000]   DMA32 zone: 0 pages, LIFO batch:0
-[17179569.184000]   Normal zone: 225280 pages, LIFO batch:31
-[17179569.184000]   HighMem zone: 32764 pages, LIFO batch:7
-[17179569.184000] DMI 2.3 present.
-[17179569.184000] ACPI: RSDP (v000 ASUS
   ) @ 0x000f5e20
-[17179569.184000] ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT
0x31313031) @ 0x3fffc000
-[17179569.184000] ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT
0x31313031) @ 0x3fffc0b2
-[17179569.184000] ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT
0x31313031) @ 0x3fffc030
-[17179569.184000] ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT
0x31313031) @ 0x3fffc058
-[17179569.184000] ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT
0x0100000b) @ 0x00000000
-[17179569.184000] ACPI: PM-Timer IO Port: 0xe408
-[17179569.184000] ACPI: Local APIC address 0xfee00000
-[17179569.184000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
-[17179569.184000] Processor #0 6:10 APIC version 16
-[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
-[17179569.184000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
-[17179569.184000] IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
-[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
-[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
-[17179569.184000] ACPI: IRQ0 used by override.
-[17179569.184000] ACPI: IRQ2 used by override.
-[17179569.184000] ACPI: IRQ9 used by override.
-[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
-[17179569.184000] Using ACPI (MADT) for SMP configuration information
-[17179569.184000] Allocating PCI resources starting at 50000000 (gap:
40000000:bec00000)
-[17179569.184000] Built 1 zonelists
-[17179569.184000] Kernel command line: root=/dev/hda3 ro quiet splash
-[17179569.184000] mapped APIC to ffffd000 (fee00000)
-[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
-[17179569.184000] Initializing CPU#0
-[17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
-[17179569.184000] Detected 1840.206 MHz processor.
-[17179569.184000] Using pmtmr for high-res timesource
-[17179569.184000] Console: colour VGA+ 80x25
-[17179571.060000] Dentry cache hash table entries: 131072 (order: 7,
524288 bytes)
-[17179571.060000] Inode-cache hash table entries: 65536 (order: 6,
262144 bytes)
-[17179571.100000] Memory: 1028872k/1048560k available (1976k kernel
code, 18936k reserved, 606k data, 288k init, 131056k highmem)
-[17179571.100000] Checking if this processor honours the WP bit even
in supervisor mode... Ok.
-[17179571.180000] Calibrating delay using timer specific routine..
3683.37 BogoMIPS (lpj=7366740)
-[17179571.180000] Security Framework v1.0.0 initialized
-[17179571.180000] SELinux:  Disabled at boot.
-[17179571.180000] Mount-cache hash table entries: 512
-[17179571.180000] CPU: After generic identify, caps: 0383fbff
c1c3fbff 00000000 00000000 00000000 00000000 00000000
-[17179571.180000] CPU: After vendor identify, caps: 0383fbff c1c3fbff
00000000 00000000 00000000 00000000 00000000
-[17179571.180000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K
(64 bytes/line)
-[17179571.180000] CPU: L2 Cache: 512K (64 bytes/line)
-[17179571.180000] CPU: After all inits, caps: 0383fbff c1c3fbff
00000000 00000420 00000000 00000000 00000000
-[17179571.180000] mtrr: v2.0 (20020519)
-[17179571.180000] CPU: AMD Athlon(TM) XP 3000+ stepping 00
-[17179571.180000] Enabling fast FPU save and restore... done.
-[17179571.180000] Enabling unmasked SIMD FPU exception support... done.
-[17179571.180000] Checking 'hlt' instruction... OK.
-[17179571.196000] checking if image is initramfs... it is
-[17179571.776000] Freeing initrd memory: 6616k freed
-[17179571.792000] ACPI: Looking for DSDT ... not found!
-[17179571.796000] ENABLING IO-APIC IRQs
-[17179571.796000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
-[17179571.940000] NET: Registered protocol family 16
-[17179571.940000] EISA bus registered
-[17179571.940000] ACPI: bus type pci registered
-[17179571.940000] PCI: PCI BIOS revision 2.10 entry at 0xf1960, last bus=1
-[17179571.940000] PCI: Using configuration type 1
-[17179571.940000] ACPI: Subsystem revision 20051216
-[17179571.944000] ACPI: Interpreter enabled
-[17179571.944000] ACPI: Using IOAPIC for interrupt routing
-[17179571.944000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
-[17179571.944000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9
10 11 12) *0, disabled.
-[17179571.944000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12)
-[17179571.944000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9
10 11 12) *0, disabled.
-[17179571.948000] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12)
-[17179571.948000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
-[17179571.948000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10
*11 12 14 15)
-[17179571.948000] ACPI: PCI Root Bridge [PCI0] (0000:00)
-[17179571.948000] PCI: Probing PCI hardware (bus 00)
-[17179571.948000] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
-[17179571.948000] PCI quirk: region e400-e47f claimed by vt8235 PM
-[17179571.948000] PCI quirk: region e800-e80f claimed by vt8235 SMB
-[17179571.952000] Boot video device is 0000:01:00.0
-[17179571.952000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-[17179571.952000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
-[17179571.956000] Linux Plug and Play Support v0.97 (c) Adam Belay
-[17179571.956000] pnp: PnP ACPI init
-[17179571.960000] pnp: PnP ACPI: found 14 devices
-[17179571.960000] PnPBIOS: Disabled by ACPI PNP
-[17179571.960000] PCI: Using ACPI for IRQ routing
-[17179571.960000] PCI: If a device doesn't work, try "pci=routeirq".
If it helps, post a report
-[17179571.972000] pnp: 00:01: ioport range 0xe400-0xe47f could not be reserved
-[17179571.972000] pnp: 00:01: ioport range 0xe800-0xe81f could not be reserved
-[17179571.972000] pnp: 00:0d: ioport range 0x290-0x297 has been reserved
-[17179571.972000] pnp: 00:0d: ioport range 0x370-0x375 has been reserved
-[17179571.972000] PCI: Bridge: 0000:00:01.0
-[17179571.972000]   IO window: d000-dfff
-[17179571.972000]   MEM window: bf000000-bfffffff
-[17179571.972000]   PREFETCH window: c0000000-f7ffffff
-[17179571.972000] PCI: Setting latency timer of device 0000:00:01.0 to 64
-[17179571.972000] Simple Boot Flag at 0x3a set to 0x1
-[17179571.972000] audit: initializing netlink socket (disabled)
-[17179571.972000] audit(1163006904.972:1): initialized
-[17179571.972000] highmem bounce pool size: 64 pages
-[17179571.972000] VFS: Disk quotas dquot_6.5.1
-[17179571.972000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
-[17179571.972000] Initializing Cryptographic API
-[17179571.972000] io scheduler noop registered
-[17179571.972000] io scheduler anticipatory registered
-[17179571.972000] io scheduler deadline registered
-[17179571.972000] io scheduler cfq registered
-[17179571.972000] isapnp: Scanning for PnP cards...
-[17179572.324000] isapnp: No Plug & Play device found
-[17179572.340000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at
0x60,0x64 irq 1,12
-[17179572.340000] serio: i8042 AUX port at 0x60,0x64 irq 12
-[17179572.340000] serio: i8042 KBD port at 0x60,0x64 irq 1
-[17179572.340000] Serial: 8250/16550 driver $Revision: 1.90 $ 48
ports, IRQ sharing enabled
-[17179572.340000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
-[17179572.344000] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
-[17179572.344000] ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16
(level, low) -> IRQ 169
-[17179572.344000] ACPI: PCI interrupt for device 0000:00:0d.0 disabled
-[17179572.344000] RAMDISK driver initialized: 16 RAM disks of 65536K
size 1024 blocksize
-[17179572.344000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
-[17179572.344000] ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
-[17179572.344000] mice: PS/2 mouse device common for all mice
-[17179572.344000] EISA: Probing bus 0 at eisa.0
-[17179572.344000] EISA: Detected 0 cards.
-[17179572.344000] NET: Registered protocol family 2
-[17179572.368000] input: AT Translated Set 2 keyboard as /class/input/input0
-[17179572.388000] IP route cache hash table entries: 65536 (order: 6,
262144 bytes)
-[17179572.388000] TCP established hash table entries: 262144 (order:
8, 1048576 bytes)
-[17179572.388000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
-[17179572.388000] TCP: Hash tables configured (established 262144 bind 65536)
-[17179572.388000] TCP reno registered
-[17179572.388000] TCP bic registered
-[17179572.388000] NET: Registered protocol family 1
-[17179572.388000] NET: Registered protocol family 8
-[17179572.388000] NET: Registered protocol family 20
-[17179572.392000] Using IPI Shortcut mode
-[17179572.392000] ACPI wakeup devices:
-[17179572.392000] PCI0 PCI1 USB0 USB1 USB2 SU20 SLAN
-[17179572.392000] ACPI: (supports S0 S1 S4 S5)
-[17179572.392000] Freeing unused kernel memory: 288k freed
-[17179572.440000] vga16fb: initializing
-[17179572.440000] vga16fb: mapped to 0xc00a0000
-[17179572.536000] Console: switching to colour frame buffer device 80x25
-[17179572.536000] fb0: VGA16 VGA frame buffer device
-[17179573.640000] Capability LSM initialized
-[17179574.088000] VP_IDE: IDE controller at PCI slot 0000:00:11.1
-[17179574.088000] ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
-[17179574.088000] PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 15
-[17179574.088000] VP_IDE: chipset revision 6
-[17179574.088000] VP_IDE: not 100% native mode: will probe irqs later
-[17179574.088000] VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller
on pci0000:00:11.1
-[17179574.088000]     ide0: BM-DMA at 0xa800-0xa807, BIOS settings:
hda:DMA, hdb:DMA
-[17179574.088000]     ide1: BM-DMA at 0xa808-0xa80f, BIOS settings:
hdc:DMA, hdd:DMA
-[17179574.088000] Probing IDE interface ide0...
-[17179574.504000] hda: MAXTOR 6L040J2, ATA DISK drive
-[17179574.784000] hdb: SAMSUNG SP0802N, ATA DISK drive
-[17179574.840000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
-[17179574.844000] Probing IDE interface ide1...
-[17179575.712000] hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
-[17179576.496000] hdd: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
-[17179576.556000] ide1 at 0x170-0x177,0x376 on irq 15
-[17179576.568000] hda: max request size: 128KiB
-[17179576.584000] hda: 78177792 sectors (40027 MB) w/1819KiB Cache,
CHS=65535/16/63, UDMA(33)
-[17179576.584000] hda: cache flushes supported
-[17179576.584000]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
-[17179576.632000] hdb: max request size: 1024KiB
-[17179576.632000] hdb: 156368016 sectors (80060 MB) w/2048KiB Cache,
CHS=16383/255/63, UDMA(33)
-[17179576.632000] hdb: cache flushes supported
-[17179576.632000]  hdb: hdb1 hdb2 < hdb5 hdb6 >
-[17179576.676000] hdc: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33)
-[17179576.676000] Uniform CD-ROM driver Revision: 3.20
-[17179576.728000] hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
-[17179577.416000] usbcore: registered new driver usbfs
-[17179577.416000] usbcore: registered new driver hub
-[17179577.416000] USB Universal Host Controller Interface driver v2.3
-[17179577.416000] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21
(level, low) -> IRQ 177
-[17179577.416000] PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 1
-[17179577.416000] uhci_hcd 0000:00:10.0: UHCI Host Controller
-[17179577.416000] uhci_hcd 0000:00:10.0: new USB bus registered,
assigned bus number 1
-[17179577.416000] uhci_hcd 0000:00:10.0: irq 177, io base 0x0000b800
-[17179577.416000] hub 1-0:1.0: USB hub found
-[17179577.416000] hub 1-0:1.0: 2 ports detected
-[17179577.520000] ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21
(level, low) -> IRQ 177
-[17179577.520000] PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 1
-[17179577.520000] uhci_hcd 0000:00:10.1: UHCI Host Controller
-[17179577.520000] uhci_hcd 0000:00:10.1: new USB bus registered,
assigned bus number 2
-[17179577.520000] uhci_hcd 0000:00:10.1: irq 177, io base 0x0000b400
-[17179577.520000] hub 2-0:1.0: USB hub found
-[17179577.520000] hub 2-0:1.0: 2 ports detected
-[17179577.624000] ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21
(level, low) -> IRQ 177
-[17179577.624000] PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 1
-[17179577.624000] uhci_hcd 0000:00:10.2: UHCI Host Controller
-[17179577.624000] uhci_hcd 0000:00:10.2: new USB bus registered,
assigned bus number 3
-[17179577.624000] uhci_hcd 0000:00:10.2: irq 177, io base 0x0000b000
-[17179577.624000] hub 3-0:1.0: USB hub found
-[17179577.624000] hub 3-0:1.0: 2 ports detected
-[17179577.728000] ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21
(level, low) -> IRQ 177
-[17179577.728000] PCI: Via IRQ fixup for 0000:00:10.3, from 0 to 1
-[17179577.728000] ehci_hcd 0000:00:10.3: EHCI Host Controller
-[17179577.728000] ehci_hcd 0000:00:10.3: new USB bus registered,
assigned bus number 4
-[17179577.728000] ehci_hcd 0000:00:10.3: irq 177, io mem 0xbe000000
-[17179577.728000] ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00,
driver 10 Dec 2004
-[17179577.728000] hub 4-0:1.0: USB hub found
-[17179577.728000] hub 4-0:1.0: 6 ports detected
-[17179577.760000] usb 1-1: new full speed USB device using uhci_hcd
and address 2
-[17179578.020000] Attempting manual resume
-[17179578.076000] EXT3-fs: mounted filesystem with ordered data mode.
-[17179578.088000] kjournald starting.  Commit interval 5 seconds
-[17179578.704000] usb 4-1: new high speed USB device using ehci_hcd
and address 2
-[17179579.376000] usb 2-2: new full speed USB device using uhci_hcd
and address 2
-[17179579.496000] usb 2-2: device descriptor read/64, error -71
-[17179579.720000] usb 2-2: device descriptor read/64, error -71
-[17179579.936000] usb 2-2: new full speed USB device using uhci_hcd
and address 3
-[17179580.056000] usb 2-2: device descriptor read/64, error -71
-[17179580.280000] usb 2-2: device descriptor read/64, error -71
-[17179580.496000] usb 2-2: new full speed USB device using uhci_hcd
and address 4
-[17179580.904000] usb 2-2: device not accepting address 4, error -71
-[17179581.016000] usb 2-2: new full speed USB device using uhci_hcd
and address 5
-[17179581.424000] usb 2-2: device not accepting address 5, error -71
-[17179585.188000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
-[17179585.200000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
-[17179585.356000] Linux agpgart interface v0.101 (c) Dave Jones
-[17179585.392000] agpgart: Detected VIA KT400/KT400A/KT600 chipset
-[17179585.400000] agpgart: AGP aperture is 64M @ 0xf8000000
-[17179585.416000] irda_init()
-[17179585.416000] NET: Registered protocol family 23
-[17179585.472000] via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written
by Donald Becker
-[17179585.472000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23
(level, low) -> IRQ 185
-[17179585.472000] PCI: Via IRQ fixup for 0000:00:12.0, from 0 to 9
-[17179585.476000] eth0: VIA Rhine II at 0x1a400, 00:0e:a6:8a:a6:36, IRQ 185.
-[17179585.476000] eth0: MII PHY found at address 1, status 0x786d
advertising 01e1 Link 45e1.
-[17179585.792000] gameport: EMU10K1 is pci0000:00:13.1/gameport0, io
0x9800, speed 1217kHz
-[17179585.828000] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18
(level, low) -> IRQ 193
-[17179585.948000] Real Time Clock Driver v1.12
-[17179586.324000] input: PC Speaker as /class/input/input1
-[17179586.440000] drivers/usb/class/usblp.c: usblp0: USB
Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x2B17
-[17179586.440000] usbcore: registered new driver usblp
-[17179586.440000] drivers/usb/class/usblp.c: v0.13: USB Printer
Device Class driver
-[17179586.592000] Floppy drive(s): fd0 is 1.44M
-[17179586.604000] parport: PnPBIOS parport detected.
-[17179586.604000] parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
-[17179586.608000] FDC 0 is a post-1991 82077
-[17179586.832000] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
-[17179587.044000] input: ImExPS/2 Logitech Wheel Mouse as /class/input/input2
-[17179587.068000] ts: Compaq touchscreen protocol output
-[17179587.432000] lp0: using parport0 (interrupt-driven).
-[17179587.480000] fuse init (API version 7.3)
-[17179587.528000] fglrx: module license 'Proprietary. (C) 2002 - ATI
Technologies, Starnberg, GERMANY' taints kernel.
-[17179587.532000] [fglrx] Maximum main memory to use for locked dma
buffers: 929 MBytes.
-[17179587.532000] [fglrx] module loaded - fglrx 8.29.6 [Sep 19 2006] on minor 0
-[17179587.580000] Adding 1028120k swap on /dev/hda7.  Priority:-1
extents:1 across:1028120k
-[17179587.688000] EXT3 FS on hda3, internal journal
-[17179587.892000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
-[17179587.892000] md: bitmap version 4.39
-[17179587.896000] NET: Registered protocol family 17
-[17179588.456000] device-mapper: 4.4.0-ioctl (2005-01-12)
initialised: dm-devel@redhat.com
-[17179589.808000] cdrom: open failed.
-[17179590.580000] kjournald starting.  Commit interval 5 seconds
-[17179590.580000] EXT3 FS on hda1, internal journal
-[17179590.580000] EXT3-fs: mounted filesystem with ordered data mode.
-[17179590.584000] kjournald starting.  Commit interval 5 seconds
-[17179590.584000] EXT3 FS on hdb1, internal journal
-[17179590.584000] EXT3-fs: mounted filesystem with ordered data mode.
-[17179590.592000] kjournald starting.  Commit interval 5 seconds
-[17179590.592000] EXT3 FS on hda5, internal journal
-[17179590.592000] EXT3-fs: mounted filesystem with ordered data mode.
-[17179599.284000] ACPI: Power Button (FF) [PWRF]
-[17179599.284000] ACPI: Power Button (CM) [PWRB]
-[17179599.400000] ibm_acpi: ec object not found
-[17179599.436000] pcc_acpi: loading...
-[17179604.128000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16
(level, low) -> IRQ 169
-[17179604.676000] ppdev: user-space parallel port driver
-[17179606.668000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
-[17179606.668000] apm: overridden by ACPI.
-[17179606.752000] [fglrx] AGP detected, AgpState   = 0x1f000a0b
(hardware caps of chipset)
-[17179606.752000] agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
-[17179606.752000] agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
-[17179606.752000] agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
-[17179606.752000] [fglrx] AGP enabled,  AgpCommand = 0x1f000302 (selected caps)
-[17179606.768000] [fglrx] total      GART = 67108864
-[17179606.768000] [fglrx] free       GART = 51113984
-[17179606.768000] [fglrx] max single GART = 51113984
-[17179606.768000] [fglrx] total      LFB  = 126873600
-[17179606.768000] [fglrx] free       LFB  = 116387840
-[17179606.768000] [fglrx] max single LFB  = 116387840
-[17179606.768000] [fglrx] total      Inv  = 134217728
-[17179606.768000] [fglrx] free       Inv  = 134217728
-[17179606.768000] [fglrx] max single Inv  = 134217728
-[17179606.768000] [fglrx] total      TIM  = 0
-[17179613.756000] NET: Registered protocol family 10
-[17179613.756000] lo: Disabled Privacy Extensions
-[17179613.756000] IPv6 over IPv4 tunneling driver
-[17179624.132000] eth0: no IPv6 routers present
-[17179630.484000] ISO 9660 Extensions: Microsoft Joliet Level 3
-[17179630.696000] ISOFS: changing to secondary root
-[17179679.316000] Bluetooth: Core ver 2.8
-[17179679.316000] NET: Registered protocol family 31
-[17179679.316000] Bluetooth: HCI device and connection manager initialized
-[17179679.316000] Bluetooth: HCI socket layer initialized
-[17179679.392000] Bluetooth: L2CAP ver 2.8
-[17179679.392000] Bluetooth: L2CAP socket layer initialized
-[17179679.540000] Bluetooth: RFCOMM socket layer initialized
-[17179679.540000] Bluetooth: RFCOMM TTY layer initialized
-[17179679.540000] Bluetooth: RFCOMM ver 1.7
+Linux version 2.6.18.1 (root@jano-desktop) (gcc version 4.0.3 (Ubuntu
4.0.3-1ubuntu5)) #1 Mon Nov 6 16:14:01 CET 2006
+BIOS-provided physical RAM map:
+ BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
+ BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
+ BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
+ BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
+ BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
+ BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
+ BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
+ BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
+ BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
+Warning only 896MB will be used.
+Use a HIGHMEM enabled kernel.
+896MB LOWMEM available.
+On node 0 totalpages: 229376
+  DMA zone: 4096 pages, LIFO batch:0
+  Normal zone: 225280 pages, LIFO batch:31
+DMI 2.3 present.
+ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5e20
+ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc000
+ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc0b2
+ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc030
+ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc058
+ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT 0x0100000b) @ 0x00000000
+ACPI: PM-Timer IO Port: 0xe408
+ACPI: Local APIC address 0xfee00000
+ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
+Processor #0 6:10 APIC version 16
+ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
+ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
+IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
+ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
+ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
+ACPI: IRQ0 used by override.
+ACPI: IRQ2 used by override.
+ACPI: IRQ9 used by override.
+Enabling APIC mode:  Flat.  Using 1 I/O APICs
+Using ACPI (MADT) for SMP configuration information
+Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
+Detected 1839.975 MHz processor.
+Built 1 zonelists.  Total pages: 229376
+Kernel command line: root=/dev/hda3 ro single
+mapped APIC to ffffd000 (fee00000)
+mapped IOAPIC to ffffc000 (fec00000)
+Enabling fast FPU save and restore... done.
+Enabling unmasked SIMD FPU exception support... done.
+Initializing CPU#0
+PID hash table entries: 4096 (order: 12, 16384 bytes)
+Console: colour VGA+ 80x25
+Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
+Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
+Memory: 906300k/917504k available (1813k kernel code, 10728k
reserved, 571k data, 172k init, 0k highmem)
+Checking if this processor honours the WP bit even in supervisor mode... Ok.
+Calibrating delay using timer specific routine.. 3682.73 BogoMIPS (lpj=7365468)
+Mount-cache hash table entries: 512
+CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000
00000000 00000000 00000000 00000000
+CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
+CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
+CPU: L2 Cache: 512K (64 bytes/line)
+CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420
00000000 00000000 00000000
+Intel machine check architecture supported.
+Intel machine check reporting enabled on CPU#0.
+Compat vDSO mapped to ffffe000.
+CPU: AMD Athlon(TM) XP 3000+ stepping 00
+Checking 'hlt' instruction... OK.
+ACPI: Core revision 20060707
+ENABLING IO-APIC IRQs
+..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
+NET: Registered protocol family 16
+ACPI: bus type pci registered
+PCI: PCI BIOS revision 2.10 entry at 0xf1960, last bus=1
+PCI: Using configuration type 1
+Setting up standard PCI resources
+ACPI: Interpreter enabled
+ACPI: Using IOAPIC for interrupt routing
+ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
+ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
+ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12)
+ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
+ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12)
+ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
+ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
+ACPI: PCI Root Bridge [PCI0] (0000:00)
+PCI: Probing PCI hardware (bus 00)
+ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
+PCI quirk: region e400-e47f claimed by vt8235 PM
+PCI quirk: region e800-e80f claimed by vt8235 SMB
+Boot video device is 0000:01:00.0
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
+PCI: Using ACPI for IRQ routing
+PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
+PCI: Bridge: 0000:00:01.0
+  IO window: d000-dfff
+  MEM window: bf000000-bfffffff
+  PREFETCH window: c0000000-f7ffffff
+PCI: Setting latency timer of device 0000:00:01.0 to 64
+NET: Registered protocol family 2
+IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
+TCP established hash table entries: 131072 (order: 7, 524288 bytes)
+TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
+TCP: Hash tables configured (established 131072 bind 65536)
+TCP reno registered
+Simple Boot Flag at 0x3a set to 0x1
+VFS: Disk quotas dquot_6.5.1
+Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
+Initializing Cryptographic API
+io scheduler noop registered
+io scheduler anticipatory registered (default)
+io scheduler deadline registered
+io scheduler cfq registered
+ACPI: Power Button (FF) [PWRF]
+ACPI: Power Button (CM) [PWRB]
+Floppy drive(s): fd0 is 1.44M
+FDC 0 is a post-1991 82077
+via-rhine.c:v1.10-LK1.4.1 July-24-2006 Written by Donald Becker
+ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 16
+eth0: VIA Rhine II at 0xbd800000, 00:0e:a6:8a:a6:36, IRQ 16.
+eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
+Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
+ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
+Probing IDE interface ide0...
+hda: MAXTOR 6L040J2, ATA DISK drive
+hdb: SAMSUNG SP0802N, ATA DISK drive
+Probing IDE interface ide1...
+hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
+hdd: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
+ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
+ide1 at 0x170-0x177,0x376 on irq 15
+hda: max request size: 128KiB
+hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=65535/16/63
+hda: cache flushes supported
+ hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
+hdb: max request size: 512KiB
+hdb: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63
+hdb: cache flushes supported
+ hdb: hdb1 hdb2 < hdb5 hdb6 >
+serio: i8042 AUX port at 0x60,0x64 irq 12
+serio: i8042 KBD port at 0x60,0x64 irq 1
+mice: PS/2 mouse device common for all mice
+IPv4 over IPv4 tunneling driver
+TCP bic registered
+Using IPI Shortcut mode
+ACPI: (supports S0 S1 S4 S5)
+Time: tsc clocksource has been installed.
+input: AT Translated Set 2 keyboard as /class/input/input0
+kjournald starting.  Commit interval 5 seconds
+EXT3-fs: mounted filesystem with ordered data mode.
+VFS: Mounted root (ext3 filesystem) readonly.
+Freeing unused kernel memory: 172k freed
+input: ImExPS/2 Logitech Wheel Mouse as /class/input/input1
+NET: Registered protocol family 1
+hdc: ATAPI 52X DVD-ROM drive, 256kB Cache
+Uniform CD-ROM driver Revision: 3.20
+eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
+Linux agpgart interface v0.101 (c) Dave Jones
+agpgart: Detected VIA KT400/KT400A/KT600 chipset
+agpgart: AGP aperture is 64M @ 0xf8000000
+usbcore: registered new driver usbfs
+usbcore: registered new driver hub
+ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 17
+PCI: VIA IRQ fixup for 0000:00:10.3, from 0 to 1
+ehci_hcd 0000:00:10.3: EHCI Host Controller
+ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
+ehci_hcd 0000:00:10.3: irq 17, io mem 0xbe000000
+ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
+usb usb1: configuration #1 chosen from 1 choice
+hub 1-0:1.0: USB hub found
+hub 1-0:1.0: 6 ports detected
+Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
+serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
+hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache
+ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 18
+ACPI: PCI interrupt for device 0000:00:0d.0 disabled
+usb 1-1: new high speed USB device using ehci_hcd and address 2
+usb 1-1: configuration #1 chosen from 1 choice
+ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 19
+VP_IDE: IDE controller at PCI slot 0000:00:11.1
+ACPI: Unable to derive IRQ for device 0000:00:11.1
+ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
+PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 15
+VP_IDE: chipset revision 6
+VP_IDE: not 100% native mode: will probe irqs later
+VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
+VP_IDE: port 0x01f0 already claimed by ide0
+VP_IDE: port 0x0170 already claimed by ide1
+VP_IDE: neither IDE port enabled (BIOS)
+NET: Registered protocol family 17
+drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if
0 alt 0 proto 2 vid 0x03F0 pid 0x2B17
+usbcore: registered new driver usblp
+drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
+parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
+parport0: irq 7 detected
+lp0: using parport0 (polling).
+fuse init (API version 7.7)
+Adding 1028120k swap on /dev/hda7.  Priority:-1 extents:1 across:1028120k
+EXT3 FS on hda3, internal journal
+md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
+md: bitmap version 4.39
+device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+device-mapper: table: 253:3: linear: dm-linear: Device lookup failed
+device-mapper: ioctl: error adding target to table
+kjournald starting.  Commit interval 5 seconds
+EXT3 FS on hda1, internal journal
+EXT3-fs: mounted filesystem with ordered data mode.
+kjournald starting.  Commit interval 5 seconds
+EXT3 FS on hda5, internal journal
+EXT3-fs: mounted filesystem with ordered data mode.

I hope it will be helpful.

Best regards,
Jano

-- 
Mail 	jano at stepien com pl
Jabber 	jano at jabber aster pl
GG 	1894343
Web	stepien.com.pl
