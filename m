Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWAQNfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWAQNfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWAQNfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:35:39 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:24633 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932361AbWAQNfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:35:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:subject:x-enigmail-version:content-type;
        b=qA3kgXGjdJOykWdoeQyPi6beJT9CGZajP0qz5MlNEVLyGwWmSYu8QPBAo7hSl7HFvgOEfmt7982D+IR3Rw/ZYRgvvJVTIm/hL905ln4tyVOvf/Ep5iI+/ZzsYJeqjrbehEJBBPteRGjfKOZWSQsm4r2DivU+o43xRXXNo1ACPDM=
Message-ID: <43CCF2A4.6020704@gmail.com>
Date: Tue, 17 Jan 2006 14:35:32 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: [2.6.16-rc1 bug] alsa suspend/resume continues to fail for ens1370
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/mixed;
 boundary="------------090209020205030703010808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090209020205030703010808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

upgrading from 2.6.15-git5 to 2.6.16-rc1

anche compiling my ens1370 driver statically in kernel i still have
issues on saving/resuming
mixer volumes.

even applying this patch (inclused in lastest alsa-cvs snapshot)


--- a/sound/pci/ens1370.c       7 Dec 2005 11:13:55 -0000       1.91
+++ b/sound/pci/ens1370.c       10 Jan 2006 16:41:08 -0000
@@ -2061,6 +2061,13 @@
 #ifdef CHIP1371
        snd_ac97_suspend(ensoniq->u.es1371.ac97);
 #else
+       /* try to reset AK4531 */
+       outw(ES_1370_CODEC_WRITE(AK4531_RESET, 0x02), ES_REG(ensoniq,
1370_CODEC));
+       inw(ES_REG(ensoniq, 1370_CODEC));
+       udelay(100);
+       outw(ES_1370_CODEC_WRITE(AK4531_RESET, 0x03), ES_REG(ensoniq,
1370_CODEC));
+       inw(ES_REG(ensoniq, 1370_CODEC));
+       udelay(100);
        snd_ak4531_suspend(ensoniq->u.es1370.ak4531);
 #endif
        pci_set_power_state(pci, PCI_D3hot);



it fails with 0x660 errors.
i attach my dmesg.

Ready to test, as usual :)

--
Patrizio Bassi
www.patriziobassi.it



--------------090209020205030703010808
Content-Type: text/plain;
 name="rc_blight"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rc_blight"

Linux version 2.6.16-rc1 (root@blight) (gcc version 3.4.5 (Gentoo 3.4.5)) #117 Tue Jan 17 13:02:37 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffd000 (usable)
 BIOS-e820: 000000001fffd000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131069
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126973 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.0 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f8030
ACPI: RSDT (v001 ASUS   P2B-F    0x58582e32 MSFT 0x31313031) @ 0x1fffd000
ACPI: FADT (v001 ASUS   P2B-F    0x58582e32 MSFT 0x31313031) @ 0x1fffd080
ACPI: BOOT (v001 ASUS   P2B-F    0x58582e32 MSFT 0x31313031) @ 0x1fffd040
ACPI: DSDT (v001   ASUS P2B-F    0x00001000 MSFT 0x01000001) @ 0x00000000
Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Gentoo ro root=306 quiet snd_ens1370.joystick=1 video=aty128fb:mtrr,ywrap,pmipal,accel,1024x768-16@85 splash=verbose,theme:livecd-2005.1,tty:11
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01402000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 501.193 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514560k/524276k available (1880k kernel code, 9136k reserved, 703k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1003.37 BogoMIPS (lpj=501688)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
mtrr: v2.0 (20020519)
CPU: Intel Pentium III (Katmai) stepping 02
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e20)
checking if image is initramfs... it is
Freeing initrd memory: 1234k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region e400-e43f claimed by PIIX4 ACPI
PCI quirk: region e800-e80f claimed by PIIX4 SMB
PIIX4 devres B PIO at 0290-0297
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: BIOS reporting unknown device 00:50
PCI: Device 0000:00:0a.1 not found by BIOS
pnp: 00:01: ioport range 0xe400-0xe43f could not be reserved
pnp: 00:01: ioport range 0xe800-0xe80f has been reserved
pnp: 00:01: ioport range 0x294-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: db000000-dbdfffff
  PREFETCH window: dbf00000-dfffffff
Simple Boot Flag at 0x46 set to 0x1
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
io scheduler noop registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
aty128fb: Found Intel x86 BIOS ROM Image
aty128fb: Rage128 BIOS located
aty128fb: Rage128 RF AGP [chip rev 0x2] 32M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 128x48
fb0: ATY Rage128 frame buffer device on Rage128 RF AGP
aty128fb: Rage128 MTRR set to ON
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized r128 2.5.0 20030725 on minor 0
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
lp0: console ready
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 1 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:09.0: 3Com PCI 3c905C Tornado at e0814000. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IBM-DTLA-307030, ATA DISK drive
hdb: STORM52/1, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC35L060AVV207-0, ATA DISK drive
hdd: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(33)
hda: cache flushes notsupported
 hda: hda1 hda2 < hda5 hda6 >
hdc: max request size: 512KiB
hdc: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(33)
hdc: cache flushes supported
 hdc: hdc1 hdc2 < hdc5 hdc6 >
hdb: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 35X CD-ROM drive, 128kB Cache, UDMA(33)
ACPI: PCI Interrupt 0000:00:0a.2[C] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:0a.2: EHCI Host Controller
ehci_hcd 0000:00:0a.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0a.2: irq 11, io mem 0xda000000
ehci_hcd 0000:00:0a.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:04.2: irq 9, io base 0x0000b400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:0a.0: UHCI Host Controller
uhci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:0a.0: irq 5, io base 0x0000a800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:0a.1: UHCI Host Controller
uhci_hcd 0000:00:0a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:0a.1: irq 9, io base 0x0000a400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
gameport: ES137x is pci0000:00:0b.0/gameport0, io 0x200, speed 932kHz
ALSA device list:
  #0: Ensoniq AudioPCI ENS1370 at 0xa000, irq 10
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 192 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
input: ImPS/2 Generic Wheel Mouse as /class/input/input2
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 168k freed
Adding 441748k swap on /dev/hdc6.  Priority:-1 extents:1 across:441748k
ReiserFS: hdc5: found reiserfs format "3.6" with standard journal
ReiserFS: hdc5: using ordered data mode
ReiserFS: hdc5: journal params: device hdc5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc5: checking transaction log (hdc5)
ReiserFS: hdc5: Using r5 hash to sort names
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
Stopping tasks: ===================|
Shrinking memory...  -\|done (41371 pages freed)
pnp: Device 00:0b disabled.
pnp: Device 00:07 disabled.
ACPI: PCI interrupt for device 0000:00:0b.0 disabled
ACPI: PCI interrupt for device 0000:00:0a.2 disabled
ACPI: PCI interrupt for device 0000:00:0a.1 disabled
ACPI: PCI interrupt for device 0000:00:0a.0 disabled
ACPI: PCI interrupt for device 0000:00:09.0 disabled
ACPI: PCI interrupt for device 0000:00:04.2 disabled
swsusp: Need to copy 7839 pages
ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt 0000:00:0a.2[C] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
usb usb1: root hub lost power or was reset
ehci_hcd 0000:00:0a.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
pnp: Device 00:07 activated.
pnp: Failed to activate device 00:0a.
pnp: Device 00:0b activated.
Restarting tasks... done
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660
codec write timeout, status = 0x660

--------------090209020205030703010808--
