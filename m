Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUJLTmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUJLTmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUJLTmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:42:21 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:65423 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S267648AbUJLTlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:41:11 -0400
Message-ID: <416C3340.5070707@free.fr>
Date: Tue, 12 Oct 2004 21:40:48 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040115
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2 : oops...]
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA27029377CAE56ED356098E7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA27029377CAE56ED356098E7
Content-Type: multipart/mixed;
 boundary="------------030806010602000408050308"

This is a multi-part message in MIME format.
--------------030806010602000408050308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I posted the following bug to linux-usb-devel, and I did not receive 
any reply.

As the problem still occurs with 2.6.9-rc4-mm1 
(optimize-profile-path-slightly.patch reverted), I decided to post 
it again.

I cc Greg KH because he provides a fix for pci_register_driver and 
this oops is (indirectly) triggered by pci_unregister_driver (maybe 
these two things are related, just a guess...).

regards
~~
laurent

-------- Original Message --------
Subject: 2.6.9-rc3-mm2 : oops when rmmod uhci_hcd
Date: Wed, 06 Oct 2004 23:30:16 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
To: linux-usb-devel@lists.sourceforge.net

Hello

I've got a oops when I rmmod uhci_hcd module :

Unable to handle kernel paging request at virtual address 6b6b6b6b
    printing eip:
c0186959
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: ne2k_pci 8390 crc32 ohci1394 ieee1394
nls_iso8859_1 nls_cp850
    vfat fat reiser4 reiserfs via_agp agpgart dm_mod joydev uhci_hcd
usbcore rtc
CPU:    0
EIP:    0060:[<c0186959>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc3-mm2)
EIP is at remove_proc_entry+0x29/0x140
eax: 00000000   ebx: 6b6b6b6b   ecx: ffffffff   edx: cffa0770
esi: c037ab40   edi: 6b6b6b6b   ebp: cc0a7ea0   esp: cc0a7e7c
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1514, threadinfo=cc0a6000 task=cfbd8680)
Stack: c1301938 cc0a7e90 c022b9ed c034fa14 cffa0770 6b6b6b6b f58c7d8
c037ab40
          c13e593c cc0a7ec8 c013813e 00000286 00000003 cc0a6000
0000212 00000005
          c13e593c c13018f4 c1301938 cc0a7eec d083d3ff d084286a
0821af4 c1301990
Call Trace:
    [<c0105dd6>] show_stack+0xa6/0xb0
    [<c0105f4d>] show_registers+0x14d/0x1c0
    [<c0106134>] die+0xe4/0x170
    [<c0115822>] do_page_fault+0x4c2/0x5f7
    [<c01059a9>] error_code+0x2d/0x38
    [<c013813e>] free_irq+0x8e/0xf0
    [<d083d3ff>] usb_hcd_pci_remove+0xaf/0x180 [usbcore]
    [<c01c27b6>] pci_device_remove+0x66/0x70
    [<c022cbf7>] device_release_driver+0x57/0x60
    [<c022cc19>] driver_detach+0x19/0x30
    [<c022d0bc>] bus_remove_driver+0x5c/0xa0
    [<c022d5a7>] driver_unregister+0x17/0x40
    [<c01c29ae>] pci_unregister_driver+0xe/0x20
    [<d08219e0>] uhci_hcd_cleanup+0x10/0x56 [uhci_hcd]
    [<c0132b17>] sys_delete_module+0x177/0x1a0
    [<c0104f4d>] sysenter_past_esp+0x52/0x71
Code: 00 00 55 89 e5 83 ec 24 85 d2 89 5d f4 89 75 f8 89 7d fc 89 55
ec 89 45 f0
    0f 84 96 00 00 00 8b 5d f0 31 c0 b9 ff ff ff ff 89 df <f2> ae f7
d1 49 8b 42 34
    8d 7a 34 89 ce 85 c0 74 6e 8b 0f 89 da


I'm running kernel 2.6.9-rc3-mm2 with patches :
- pci_register_driver fix from greg KH
http://marc.theaimsgroup.com/?l=linux-kernel&m=109692915116202
- compilation fix for arch/i386/kernel/irq.c
http://marc.theaimsgroup.com/?l=linux-kernel&m=109688635818749
- preempt fix from Andrew Morton
http://marc.theaimsgroup.com/?l=linux-kernel&m=109692695515504

Attached below :
- full dmesg
- ksymoops output

For "lspci -v" output and .config, please see
http://marc.theaimsgroup.com/?l=linux-kernel&m=109680811022527&q=p7 and
http://marc.theaimsgroup.com/?l=linux-kernel&m=109680811022527&q=p8

regards
-- 
laurent



--------------030806010602000408050308
Content-Type: text/plain;
 name="dmesg-2.6.9-rc3-mm2-rmmod_uhci_hcd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.9-rc3-mm2-rmmod_uhci_hcd"

Linux version 2.6.9-rc3-mm2 (laurent@antares.localdomain) (gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #12 Tue Oct 5 21:50:25 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65516
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61420 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a80
ACPI: RSDT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x0ffec000
ACPI: FADT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x0ffec080
ACPI: BOOT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x0ffec040
ACPI: DSDT (v001   ASUS A7V133-C 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
Initializing CPU#0
Kernel command line: resume=/dev/hdb6 root=/dev/hda6 init S
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1410.673 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256136k/262064k available (1755k kernel code, 5376k reserved, 796k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2793.47 BogoMIPS (lpj=1396736)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
spurious 8259A interrupt: IRQ7.
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
vesafb: probe of vesafb0 failed with error -6
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST340016A, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CD-950E/AKU, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-48125S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 > hda4
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
PWRB PCI0 UAR1 UAR2 USB0 USB1 
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
mount_block_root : name=/dev/root p=ext3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Real Time Clock Driver v1.12
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:04.2[D] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:04.2: irq 5, io base 0xd400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:04.3[D] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:04.3: irq 5, io base 0xd000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using address 2
input: USB HID v1.10 Gamepad [THRUSTMASTER FireStorm Dual Analog 2] on usb-0000:00:04.2-2
usbcore: registered new driver usbhid
/home/laurent/kernel/linux-2.6/drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda6, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Adding 64220k swap on /dev/hda5.  Priority:-1 extents:1
Adding 1052216k swap on /dev/hdb6.  Priority:-2 extents:1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xe4000000
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[d5800000-d58007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00308d0120e085ca]
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: RealTek RTL-8029 found at 0xa000, IRQ 5, 00:40:95:46:6E:2D.
usbcore: deregistering driver usbhid
uhci_hcd 0000:00:04.2: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-2: USB disconnect, address 2
uhci_hcd 0000:00:04.2: USB bus 1 deregistered
uhci_hcd 0000:00:04.3: remove, state 1
usb usb2: USB disconnect, address 1
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c0186959
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: ne2k_pci 8390 crc32 ohci1394 ieee1394 nls_iso8859_1 nls_cp850 vfat fat reiser4 reiserfs via_agp agpgart dm_mod joydev uhci_hcd usbcore rtc
CPU:    0
EIP:    0060:[<c0186959>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc3-mm2) 
EIP is at remove_proc_entry+0x29/0x140
eax: 00000000   ebx: 6b6b6b6b   ecx: ffffffff   edx: cffa0770
esi: c037ab40   edi: 6b6b6b6b   ebp: cc0a7ea0   esp: cc0a7e7c
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1514, threadinfo=cc0a6000 task=cfbd8680)
Stack: c1301938 cc0a7e90 c022b9ed c034fa14 cffa0770 6b6b6b6b cf58c7d8 c037ab40 
       c13e593c cc0a7ec8 c013813e 00000286 00000003 cc0a6000 00000212 00000005 
       c13e593c c13018f4 c1301938 cc0a7eec d083d3ff d084286a d0821af4 c1301990 
Call Trace:
 [<c0105dd6>] show_stack+0xa6/0xb0
 [<c0105f4d>] show_registers+0x14d/0x1c0
 [<c0106134>] die+0xe4/0x170
 [<c0115822>] do_page_fault+0x4c2/0x5f7
 [<c01059a9>] error_code+0x2d/0x38
 [<c013813e>] free_irq+0x8e/0xf0
 [<d083d3ff>] usb_hcd_pci_remove+0xaf/0x180 [usbcore]
 [<c01c27b6>] pci_device_remove+0x66/0x70
 [<c022cbf7>] device_release_driver+0x57/0x60
 [<c022cc19>] driver_detach+0x19/0x30
 [<c022d0bc>] bus_remove_driver+0x5c/0xa0
 [<c022d5a7>] driver_unregister+0x17/0x40
 [<c01c29ae>] pci_unregister_driver+0xe/0x20
 [<d08219e0>] uhci_hcd_cleanup+0x10/0x56 [uhci_hcd]
 [<c0132b17>] sys_delete_module+0x177/0x1a0
 [<c0104f4d>] sysenter_past_esp+0x52/0x71
Code: 00 00 55 89 e5 83 ec 24 85 d2 89 5d f4 89 75 f8 89 7d fc 89 55 ec 89 45 f0 0f 84 96 00 00 00 8b 5d f0 31 c0 b9 ff ff ff ff 89 df <f2> ae f7 d1 49 8b 42 34 8d 7a 34 89 ce 85 c0 74 6e 8b 0f 89 da 
 



--------------030806010602000408050308
Content-Type: text/plain;
 name="ksymoops1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops1"

ksymoops 2.4.9 on i686 2.6.9-rc3-mm2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9-rc3-mm2/ (default)
     -m /boot/System.map-2.6.9-rc3-mm2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
Unable to handle kernel paging request at virtual address 6b6b6b6b
c0186959
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0186959>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.9-rc3-mm2) 
eax: 00000000   ebx: 6b6b6b6b   ecx: ffffffff   edx: cffa0770
esi: c037ab40   edi: 6b6b6b6b   ebp: cc0a7ea0   esp: cc0a7e7c
ds: 007b   es: 007b   ss: 0068
Stack: c1301938 cc0a7e90 c022b9ed c034fa14 cffa0770 6b6b6b6b cf58c7d8 c037ab40 
       c13e593c cc0a7ec8 c013813e 00000286 00000003 cc0a6000 00000212 00000005 
       c13e593c c13018f4 c1301938 cc0a7eec d083d3ff d084286a d0821af4 c1301990 
Call Trace:
 [<c0105dd6>] show_stack+0xa6/0xb0
 [<c0105f4d>] show_registers+0x14d/0x1c0
 [<c0106134>] die+0xe4/0x170
 [<c0115822>] do_page_fault+0x4c2/0x5f7
 [<c01059a9>] error_code+0x2d/0x38
 [<c013813e>] free_irq+0x8e/0xf0
 [<d083d3ff>] usb_hcd_pci_remove+0xaf/0x180 [usbcore]
 [<c01c27b6>] pci_device_remove+0x66/0x70
 [<c022cbf7>] device_release_driver+0x57/0x60
 [<c022cc19>] driver_detach+0x19/0x30
 [<c022d0bc>] bus_remove_driver+0x5c/0xa0
 [<c022d5a7>] driver_unregister+0x17/0x40
 [<c01c29ae>] pci_unregister_driver+0xe/0x20
 [<d08219e0>] uhci_hcd_cleanup+0x10/0x56 [uhci_hcd]
 [<c0132b17>] sys_delete_module+0x177/0x1a0
 [<c0104f4d>] sysenter_past_esp+0x52/0x71
Code: 00 00 55 89 e5 83 ec 24 85 d2 89 5d f4 89 75 f8 89 7d fc 89 55 ec 89 45 f0 0f 84 96 00 00 00 8b 5d f0 31 c0 b9 ff ff ff ff 89 df <f2> ae f7 d1 49 8b 42 34 8d 7a 34 89 ce 85 c0 74 6e 8b 0f 89 da 


>>EIP; c0186959 <remove_proc_entry+29/140>   <=====

>>ecx; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>edx; cffa0770 <pg0+fbcf770/3fc2d400>
>>esi; c037ab40 <tasklist_lock+140/3800>
>>ebp; cc0a7ea0 <pg0+bcd6ea0/3fc2d400>
>>esp; cc0a7e7c <pg0+bcd6e7c/3fc2d400>

Trace; c0105dd6 <show_stack+a6/b0>
Trace; c0105f4d <show_registers+14d/1c0>
Trace; c0106134 <die+e4/170>
Trace; c0115822 <do_page_fault+4c2/5f7>
Trace; c01059a9 <error_code+2d/38>
Trace; c013813e <free_irq+8e/f0>
Trace; d083d3ff <pg0+1046c3ff/3fc2d400>
Trace; c01c27b6 <pci_device_remove+66/70>
Trace; c022cbf7 <device_release_driver+57/60>
Trace; c022cc19 <driver_detach+19/30>
Trace; c022d0bc <bus_remove_driver+5c/a0>
Trace; c022d5a7 <driver_unregister+17/40>
Trace; c01c29ae <pci_unregister_driver+e/20>
Trace; d08219e0 <pg0+104509e0/3fc2d400>
Trace; c0132b17 <sys_delete_module+177/1a0>
Trace; c0104f4d <sysenter_past_esp+52/71>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c018692e <free_proc_entry+4e/50>
00000000 <_EIP>:
Code;  c018692e <free_proc_entry+4e/50>
   0:   00 00                     add    %al,(%eax)
Code;  c0186930 <remove_proc_entry+0/140>
   2:   55                        push   %ebp
Code;  c0186931 <remove_proc_entry+1/140>
   3:   89 e5                     mov    %esp,%ebp
Code;  c0186933 <remove_proc_entry+3/140>
   5:   83 ec 24                  sub    $0x24,%esp
Code;  c0186936 <remove_proc_entry+6/140>
   8:   85 d2                     test   %edx,%edx
Code;  c0186938 <remove_proc_entry+8/140>
   a:   89 5d f4                  mov    %ebx,0xfffffff4(%ebp)
Code;  c018693b <remove_proc_entry+b/140>
   d:   89 75 f8                  mov    %esi,0xfffffff8(%ebp)
Code;  c018693e <remove_proc_entry+e/140>
  10:   89 7d fc                  mov    %edi,0xfffffffc(%ebp)
Code;  c0186941 <remove_proc_entry+11/140>
  13:   89 55 ec                  mov    %edx,0xffffffec(%ebp)
Code;  c0186944 <remove_proc_entry+14/140>
  16:   89 45 f0                  mov    %eax,0xfffffff0(%ebp)
Code;  c0186947 <remove_proc_entry+17/140>
  19:   0f 84 96 00 00 00         je     b5 <_EIP+0xb5>
Code;  c018694d <remove_proc_entry+1d/140>
  1f:   8b 5d f0                  mov    0xfffffff0(%ebp),%ebx
Code;  c0186950 <remove_proc_entry+20/140>
  22:   31 c0                     xor    %eax,%eax
Code;  c0186952 <remove_proc_entry+22/140>
  24:   b9 ff ff ff ff            mov    $0xffffffff,%ecx
Code;  c0186957 <remove_proc_entry+27/140>
  29:   89 df                     mov    %ebx,%edi

This decode from eip onwards should be reliable

Code;  c0186959 <remove_proc_entry+29/140>
00000000 <_EIP>:
Code;  c0186959 <remove_proc_entry+29/140>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c018695b <remove_proc_entry+2b/140>
   2:   f7 d1                     not    %ecx
Code;  c018695d <remove_proc_entry+2d/140>
   4:   49                        dec    %ecx
Code;  c018695e <remove_proc_entry+2e/140>
   5:   8b 42 34                  mov    0x34(%edx),%eax
Code;  c0186961 <remove_proc_entry+31/140>
   8:   8d 7a 34                  lea    0x34(%edx),%edi
Code;  c0186964 <remove_proc_entry+34/140>
   b:   89 ce                     mov    %ecx,%esi
Code;  c0186966 <remove_proc_entry+36/140>
   d:   85 c0                     test   %eax,%eax
Code;  c0186968 <remove_proc_entry+38/140>
   f:   74 6e                     je     7f <_EIP+0x7f>
Code;  c018696a <remove_proc_entry+3a/140>
  11:   8b 0f                     mov    (%edi),%ecx
Code;  c018696c <remove_proc_entry+3c/140>
  13:   89 da                     mov    %ebx,%edx


1 warning and 1 error issued.  Results may not be reliable.



--------------030806010602000408050308--

--------------enigA27029377CAE56ED356098E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBbDNLUqUFrirTu6IRAqW3AJoCmlnIu/ywQ8urpjRjjnjpnVkVSgCglOnF
KRk4c+BrwMM6kCH7Sb0f2Rc=
=GotY
-----END PGP SIGNATURE-----

--------------enigA27029377CAE56ED356098E7--
