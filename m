Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUFXQVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUFXQVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUFXQVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:21:03 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:5830 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265973AbUFXQSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:18:47 -0400
Message-ID: <40DAFEC4.3020900@yomoco.com>
Date: Thu, 24 Jun 2004 18:18:12 +0200
From: Jens Kubieziel <kubieziel@yomoco.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031201 Thunderbird/0.4RC1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [BUG/2.6.6] Bug at slab.c while logging in at console
Content-Type: multipart/mixed;
 boundary="------------080004090605050908070202"
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:3d71f0dcba0c6e89dd9ba464eb8f4f0e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080004090605050908070202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a IBM Thinkpad 600X which is running a 2.6.6 kernel without any 
other patches on a gentoo distro. Nearly every time when I log in at a 
tty as normal user I get this message

Jun 24 16:54:33 paradise login(pam_unix)[8502]: session opened for user 
jens by (uid=0)
Jun 24 16:54:33 paradise kmem_cache_create: duplicate cache sgpool-8
Jun 24 16:54:33 paradise ------------[ cut here ]------------
Jun 24 16:54:33 paradise kernel BUG at mm/slab.c:1372!
Jun 24 16:54:33 paradise invalid operand: 0000 [#1]
Jun 24 16:54:33 paradise PREEMPT
Jun 24 16:54:33 paradise CPU:    0
Jun 24 16:54:33 paradise EIP:    0060:[<c012dc0a>]    Not tainted
Jun 24 16:54:33 paradise EFLAGS: 00010202   (2.6.6)
Jun 24 16:54:33 paradise EIP is at kmem_cache_create+0x3b0/0x40c
Jun 24 16:54:33 paradise eax: dcf56a2f   ebx: dbbbc820   ecx: c0383af4 
edx: d409c000
Jun 24 16:54:33 paradise esi: c02b5ab4   edi: c02a79c0   ebp: c13aed50 
esp: d409df68
Jun 24 16:54:33 paradise ds: 007b   es: 007b   ss: 0068
Jun 24 16:54:33 paradise Process modprobe (pid: 8694, 
threadinfo=d409c000 task=db4a66b0)
Jun 24 16:54:33 paradise Stack: c0000000 00000060 00000000 00000000 
c02e503c c02e503c dce6c0d6 dcf56a2f
Jun 24 16:54:33 paradise 00000080 00000020 00002000 00000000 00000000 
c02e5054 dcf60ce0 dce6c006
Jun 24 16:54:33 paradise c02e5054 c0124cd8 0806df58 0805ac30 4012c4e0 
d409c000 c0103ac7 0806df58
Jun 24 16:54:33 paradise Call Trace:
Jun 24 16:54:33 paradise [<dce6c0d6>] scsi_init_queue+0x26/0x90 [scsi_mod]
Jun 24 16:54:33 paradise [<dce6c006>] init_scsi+0x6/0xb0 [scsi_mod]
Jun 24 16:54:33 paradise [<c0124cd8>] sys_init_module+0x10e/0x1c8
Jun 24 16:54:33 paradise [<c0103ac7>] syscall_call+0x7/0xb
Jun 24 16:54:33 paradise
Jun 24 16:54:33 paradise Code: 0f 0b 5c 05 8c 71 2a c0 8b 6d 00 8b 45 00 
0f 18 00 90 81 fd

If I log in as root, all seems normal. The only remarkable difference 
between a user and root account is, that root uses bash as login shell 
while users use zsh.

What could be the reason for that?

While looking for a solution I did some grepping in /var/log/messages 
and found another call trace:
Jun 24 16:50:53 paradise Linux agpgart interface v0.100 (c) Dave Jones
Jun 24 16:50:53 paradise kobject_register failed for agpgart-intel (-17)
Jun 24 16:50:53 paradise Call Trace:
Jun 24 16:50:53 paradise [<c018ed62>] kobject_register+0x35/0x3d
Jun 24 16:50:53 paradise [<c01d9a12>] bus_add_driver+0x30/0x83
Jun 24 16:50:53 paradise [<c01d9d7f>] driver_register+0x2d/0x31
Jun 24 16:50:53 paradise [<c01945af>] pci_register_driver+0x4e/0x6a
Jun 24 16:50:53 paradise [<dce3a021>] init_module+0x21/0x2c [intel_agp]
Jun 24 16:50:53 paradise [<c0124cd8>] sys_init_module+0x10e/0x1c8
Jun 24 16:50:53 paradise [<c0103ac7>] syscall_call+0x7/0xb
Jun 24 16:50:53 paradise

--------------080004090605050908070202
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Jun 24 16:50:51 paradise Linux version 2.6.6 (root@paradise) (gcc version 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #7 Thu Jun 10 10:48:20 CEST 2004
Jun 24 16:50:51 paradise BIOS-provided physical RAM map:
Jun 24 16:50:51 paradise BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jun 24 16:50:51 paradise BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jun 24 16:50:51 paradise BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jun 24 16:50:51 paradise BIOS-e820: 0000000000100000 - 000000001bfd0000 (usable)
Jun 24 16:50:51 paradise BIOS-e820: 000000001bfd0000 - 000000001bfdf000 (ACPI data)
Jun 24 16:50:51 paradise BIOS-e820: 000000001bfdf000 - 000000001bfe0000 (ACPI NVS)
Jun 24 16:50:51 paradise BIOS-e820: 000000001bfe0000 - 000000001c000000 (reserved)
Jun 24 16:50:51 paradise BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Jun 24 16:50:51 paradise 447MB LOWMEM available.
Jun 24 16:50:51 paradise On node 0 totalpages: 114640
Jun 24 16:50:51 paradise DMA zone: 4096 pages, LIFO batch:1
Jun 24 16:50:51 paradise Normal zone: 110544 pages, LIFO batch:16
Jun 24 16:50:51 paradise HighMem zone: 0 pages, LIFO batch:1
Jun 24 16:50:51 paradise DMI 2.2 present.
Jun 24 16:50:51 paradise ACPI disabled because your bios is from 1999 and too old
Jun 24 16:50:51 paradise You can enable it with acpi=force
Jun 24 16:50:51 paradise IBM machine detected. Enabling interrupts during APM calls.
Jun 24 16:50:51 paradise IBM machine detected. Disabling SMBus accesses.
Jun 24 16:50:51 paradise Built 1 zonelists
Jun 24 16:50:51 paradise Kernel command line: root=/dev/hda4
Jun 24 16:50:51 paradise Initializing CPU#0
Jun 24 16:50:51 paradise PID hash table entries: 2048 (order 11: 16384 bytes)
Jun 24 16:50:51 paradise Detected 498.295 MHz processor.
Jun 24 16:50:51 paradise Using tsc for high-res timesource
Jun 24 16:50:51 paradise Console: colour VGA+ 80x25
Jun 24 16:50:51 paradise Memory: 451424k/458560k available (1593k kernel code, 6368k reserved, 789k data, 136k init, 0k highmem)
Jun 24 16:50:51 paradise Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jun 24 16:50:51 paradise Calibrating delay loop... 985.08 BogoMIPS
Jun 24 16:50:51 paradise Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Jun 24 16:50:51 paradise Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jun 24 16:50:51 paradise Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jun 24 16:50:51 paradise CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
Jun 24 16:50:51 paradise CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
Jun 24 16:50:51 paradise CPU: L1 I cache: 16K, L1 D cache: 16K
Jun 24 16:50:51 paradise CPU: L2 cache: 256K
Jun 24 16:50:51 paradise CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Jun 24 16:50:51 paradise Intel machine check architecture supported.
Jun 24 16:50:51 paradise Intel machine check reporting enabled on CPU#0.
Jun 24 16:50:51 paradise CPU: Intel Pentium III (Coppermine) stepping 01
Jun 24 16:50:51 paradise Enabling fast FPU save and restore... done.
Jun 24 16:50:51 paradise Enabling unmasked SIMD FPU exception support... done.
Jun 24 16:50:51 paradise Checking 'hlt' instruction... OK.
Jun 24 16:50:51 paradise POSIX conformance testing by UNIFIX
Jun 24 16:50:51 paradise NET: Registered protocol family 16
Jun 24 16:50:51 paradise PCI: PCI BIOS revision 2.10 entry at 0xfd880, last bus=7
Jun 24 16:50:51 paradise PCI: Using configuration type 1
Jun 24 16:50:51 paradise mtrr: v2.0 (20020519)
Jun 24 16:50:51 paradise ACPI: Subsystem revision 20040326
Jun 24 16:50:51 paradise ACPI: Interpreter disabled.
Jun 24 16:50:51 paradise SCSI subsystem initialized
Jun 24 16:50:51 paradise PCI: Probing PCI hardware
Jun 24 16:50:51 paradise PCI: Probing PCI hardware (bus 00)
Jun 24 16:50:51 paradise PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
Jun 24 16:50:51 paradise PCI: Found IRQ 11 for device 0000:01:00.0
Jun 24 16:50:51 paradise PCI: Sharing IRQ 11 with 0000:00:02.0
Jun 24 16:50:51 paradise PCI: Sharing IRQ 11 with 0000:00:06.0
Jun 24 16:50:51 paradise neofb: mapped io at dc800000
Jun 24 16:50:51 paradise Autodetected internal display
Jun 24 16:50:51 paradise Panel is a 1024x768 color TFT display
Jun 24 16:50:51 paradise neofb: mapped framebuffer at dca01000
Jun 24 16:50:51 paradise neofb v0.4.1: 4096kB VRAM, using 1024x768, 48.361kHz, 60Hz
Jun 24 16:50:51 paradise fb0: MagicGraph 256ZX frame buffer device
Jun 24 16:50:51 paradise devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
Jun 24 16:50:51 paradise devfs: devfs_debug: 0x0
Jun 24 16:50:51 paradise devfs: boot_options: 0x1
Jun 24 16:50:51 paradise Initializing Cryptographic API
Jun 24 16:50:51 paradise Limiting direct PCI/PCI transfers.
Jun 24 16:50:51 paradise Console: switching to colour frame buffer device 128x48
Jun 24 16:50:51 paradise Linux agpgart interface v0.100 (c) Dave Jones
Jun 24 16:50:51 paradise agpgart: Detected an Intel 440BX Chipset.
Jun 24 16:50:51 paradise agpgart: Maximum main memory to use for agp memory: 380M
Jun 24 16:50:51 paradise agpgart: AGP aperture is 64M @ 0x40000000
Jun 24 16:50:51 paradise [drm] Initialized i830 1.3.2 20021108 on minor 0
Jun 24 16:50:51 paradise [drm] Initialized sis 1.1.0 20030826 on minor 1
Jun 24 16:50:51 paradise Using anticipatory io scheduler
Jun 24 16:50:51 paradise Floppy drive(s): fd0 is 1.44M
Jun 24 16:50:51 paradise FDC 0 is a National Semiconductor PC87306
Jun 24 16:50:51 paradise loop: loaded (max 8 devices)
Jun 24 16:50:51 paradise nbd: registered device at major 43
Jun 24 16:50:51 paradise Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun 24 16:50:51 paradise ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 24 16:50:51 paradise PIIX4: IDE controller at PCI slot 0000:00:07.1
Jun 24 16:50:51 paradise PIIX4: chipset revision 1
Jun 24 16:50:51 paradise PIIX4: not 100% native mode: will probe irqs later
Jun 24 16:50:51 paradise ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:DMA
Jun 24 16:50:51 paradise hda: IBM-DARA-212000, ATA DISK drive
Jun 24 16:50:51 paradise hdb: CRN-8241B, ATAPI CD/DVD-ROM drive
Jun 24 16:50:51 paradise ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 24 16:50:51 paradise hda: max request size: 128KiB
Jun 24 16:50:51 paradise hda: 23572080 sectors (12068 MB) w/418KiB Cache, CHS=24944/15/63, UDMA(33)
Jun 24 16:50:51 paradise /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 > p3 p4
Jun 24 16:50:51 paradise hdb: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Jun 24 16:50:51 paradise Uniform CD-ROM driver Revision: 3.20
Jun 24 16:50:51 paradise mice: PS/2 mouse device common for all mice
Jun 24 16:50:51 paradise input: PC Speaker
Jun 24 16:50:51 paradise serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 24 16:50:51 paradise input: PS/2 Generic Mouse on isa0060/serio1
Jun 24 16:50:51 paradise serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 24 16:50:51 paradise input: AT Translated Set 2 keyboard on isa0060/serio0
Jun 24 16:50:51 paradise Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
Jun 24 16:50:51 paradise ALSA device list:
Jun 24 16:50:51 paradise No soundcards found.
Jun 24 16:50:51 paradise NET: Registered protocol family 2
Jun 24 16:50:51 paradise IP: routing cache hash table of 4096 buckets, 32Kbytes
Jun 24 16:50:51 paradise TCP: Hash tables configured (established 32768 bind 65536)
Jun 24 16:50:51 paradise NET: Registered protocol family 1
Jun 24 16:50:51 paradise NET: Registered protocol family 17
Jun 24 16:50:51 paradise kjournald starting.  Commit interval 5 seconds
Jun 24 16:50:51 paradise EXT3-fs: mounted filesystem with ordered data mode.
Jun 24 16:50:51 paradise VFS: Mounted root (ext3 filesystem) readonly.
Jun 24 16:50:51 paradise Mounted devfs on /dev
Jun 24 16:50:51 paradise Freeing unused kernel memory: 136k freed
Jun 24 16:50:51 paradise Adding 128480k swap on /dev/hda6.  Priority:-1 extents:1
Jun 24 16:50:51 paradise EXT3 FS on hda4, internal journal
Jun 24 16:50:51 paradise usbcore: registered new driver usbfs
Jun 24 16:50:51 paradise usbcore: registered new driver hub
Jun 24 16:50:53 paradise Linux agpgart interface v0.100 (c) Dave Jones
Jun 24 16:50:53 paradise kobject_register failed for agpgart-intel (-17)
Jun 24 16:50:53 paradise Call Trace:
Jun 24 16:50:53 paradise [<c018ed62>] kobject_register+0x35/0x3d
Jun 24 16:50:53 paradise [<c01d9a12>] bus_add_driver+0x30/0x83
Jun 24 16:50:53 paradise [<c01d9d7f>] driver_register+0x2d/0x31
Jun 24 16:50:53 paradise [<c01945af>] pci_register_driver+0x4e/0x6a
Jun 24 16:50:53 paradise [<dce3a021>] init_module+0x21/0x2c [intel_agp]
Jun 24 16:50:53 paradise [<c0124cd8>] sys_init_module+0x10e/0x1c8
Jun 24 16:50:53 paradise [<c0103ac7>] syscall_call+0x7/0xb
Jun 24 16:50:53 paradise 
Jun 24 16:50:54 paradise Linux Kernel Card Services
Jun 24 16:50:54 paradise options:  [pci] [cardbus] [pm]
Jun 24 16:50:54 paradise PCI: Found IRQ 11 for device 0000:00:02.0
Jun 24 16:50:54 paradise PCI: Sharing IRQ 11 with 0000:00:06.0
Jun 24 16:50:54 paradise PCI: Sharing IRQ 11 with 0000:01:00.0
Jun 24 16:50:54 paradise Yenta: CardBus bridge found at 0000:00:02.0 [1014:0130]
Jun 24 16:50:54 paradise Yenta: Enabling burst memory read transactions
Jun 24 16:50:54 paradise Yenta: Using INTVAL to route CSC interrupts to PCI
Jun 24 16:50:54 paradise Yenta: Routing CardBus interrupts to PCI
Jun 24 16:50:54 paradise Yenta TI: socket 0000:00:02.0, mfunc 0x00001000, devctl 0x66
Jun 24 16:50:54 paradise Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Jun 24 16:50:54 paradise Socket status: 30000006
Jun 24 16:50:54 paradise PCI: Found IRQ 11 for device 0000:00:02.1
Jun 24 16:50:54 paradise Yenta: CardBus bridge found at 0000:00:02.1 [1014:0130]
Jun 24 16:50:54 paradise Yenta: Using INTVAL to route CSC interrupts to PCI
Jun 24 16:50:54 paradise Yenta: Routing CardBus interrupts to PCI
Jun 24 16:50:54 paradise Yenta TI: socket 0000:00:02.1, mfunc 0x00001000, devctl 0x66
Jun 24 16:50:54 paradise spurious 8259A interrupt: IRQ7.
Jun 24 16:50:54 paradise Yenta: ISA IRQ mask 0x06b8, PCI irq 11
Jun 24 16:50:54 paradise Socket status: 30000020
Jun 24 16:50:55 paradise PCI: Enabling device 0000:06:00.0 (0000 -> 0003)
Jun 24 16:50:55 paradise PCI: Setting latency timer of device 0000:06:00.0 to 64
Jun 24 16:50:55 paradise eth0: Xircom cardbus revision 3 at irq 11 
Jun 24 16:50:55 paradise unable to register native major device number 116
Jun 24 16:50:55 paradise modprobe: WARNING: Error inserting snd (/lib/modules/2.6.6/kernel/sound/core/snd.ko): Input/output error
Jun 24 16:50:55 paradise unable to register timer device (-16)
Jun 24 16:50:56 paradise PCI: Found IRQ 11 for device 0000:00:06.0
Jun 24 16:50:56 paradise PCI: Sharing IRQ 11 with 0000:00:02.0
Jun 24 16:50:56 paradise PCI: Sharing IRQ 11 with 0000:01:00.0
Jun 24 16:50:57 paradise cardmgr[8101]: watching 2 sockets
Jun 24 16:50:57 paradise cardmgr[8101]: starting, version is 3.2.5
Jun 24 16:50:57 paradise xircom cardbus adaptor found, registering as eth0, using irq 11 
Jun 24 16:50:57 paradise xircom_cb: Link status has changed 
Jun 24 16:50:57 paradise xircom_cb: Link is 100 mbit 
Jun 24 16:50:57 paradise USB Universal Host Controller Interface driver v2.2
Jun 24 16:50:57 paradise PCI: Found IRQ 11 for device 0000:00:07.2
Jun 24 16:50:57 paradise uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
Jun 24 16:50:57 paradise uhci_hcd 0000:00:07.2: irq 11, io base 00004000
Jun 24 16:50:57 paradise uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
Jun 24 16:50:57 paradise uhci_hcd 0000:00:07.2: detected 2 ports
Jun 24 16:50:57 paradise uhci_hcd 0000:00:07.2: root hub device address 1
Jun 24 16:50:57 paradise usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Jun 24 16:50:57 paradise usb usb1: default language 0x0409
Jun 24 16:50:57 paradise usb usb1: Product: Intel Corp. 82371AB/EB/MB PIIX4 USB
Jun 24 16:50:57 paradise usb usb1: Manufacturer: Linux 2.6.6 uhci_hcd
Jun 24 16:50:57 paradise usb usb1: SerialNumber: 0000:00:07.2
Jun 24 16:50:57 paradise usb usb1: hotplug
Jun 24 16:50:57 paradise usb usb1: adding 1-0:1.0 (config #1, interface 0)
Jun 24 16:50:57 paradise usb 1-0:1.0: hotplug
Jun 24 16:50:57 paradise hub 1-0:1.0: usb_probe_interface
Jun 24 16:50:57 paradise hub 1-0:1.0: usb_probe_interface - got id
Jun 24 16:50:57 paradise hub 1-0:1.0: USB hub found
Jun 24 16:50:57 paradise hub 1-0:1.0: 2 ports detected
Jun 24 16:50:57 paradise hub 1-0:1.0: standalone hub
Jun 24 16:50:57 paradise hub 1-0:1.0: no power switching (usb 1.0)
Jun 24 16:50:57 paradise hub 1-0:1.0: individual port over-current protection
Jun 24 16:50:57 paradise hub 1-0:1.0: power on to power good time: 2ms
Jun 24 16:50:57 paradise hub 1-0:1.0: hub controller current requirement: 0mA
Jun 24 16:50:57 paradise hub 1-0:1.0: local power source is good
Jun 24 16:50:57 paradise hub 1-0:1.0: enabling power on all ports
Jun 24 16:50:58 paradise ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
Jun 24 16:51:00 paradise uhci_hcd 0000:00:07.2: suspend_hc
Jun 24 16:51:00 paradise init: Activating demand-procedures for 'A'
Jun 24 16:51:08 paradise atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Jun 24 16:51:08 paradise atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Jun 24 16:51:08 paradise atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Jun 24 16:51:08 paradise atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Jun 24 16:54:33 paradise login(pam_unix)[8502]: session opened for user jens by (uid=0)
Jun 24 16:54:33 paradise kmem_cache_create: duplicate cache sgpool-8
Jun 24 16:54:33 paradise ------------[ cut here ]------------
Jun 24 16:54:33 paradise kernel BUG at mm/slab.c:1372!
Jun 24 16:54:33 paradise invalid operand: 0000 [#1]
Jun 24 16:54:33 paradise PREEMPT 
Jun 24 16:54:33 paradise CPU:    0
Jun 24 16:54:33 paradise EIP:    0060:[<c012dc0a>]    Not tainted
Jun 24 16:54:33 paradise EFLAGS: 00010202   (2.6.6) 
Jun 24 16:54:33 paradise EIP is at kmem_cache_create+0x3b0/0x40c
Jun 24 16:54:33 paradise eax: dcf56a2f   ebx: dbbbc820   ecx: c0383af4   edx: d409c000
Jun 24 16:54:33 paradise esi: c02b5ab4   edi: c02a79c0   ebp: c13aed50   esp: d409df68
Jun 24 16:54:33 paradise ds: 007b   es: 007b   ss: 0068
Jun 24 16:54:33 paradise Process modprobe (pid: 8694, threadinfo=d409c000 task=db4a66b0)
Jun 24 16:54:33 paradise Stack: c0000000 00000060 00000000 00000000 c02e503c c02e503c dce6c0d6 dcf56a2f 
Jun 24 16:54:33 paradise 00000080 00000020 00002000 00000000 00000000 c02e5054 dcf60ce0 dce6c006 
Jun 24 16:54:33 paradise c02e5054 c0124cd8 0806df58 0805ac30 4012c4e0 d409c000 c0103ac7 0806df58 
Jun 24 16:54:33 paradise Call Trace:
Jun 24 16:54:33 paradise [<dce6c0d6>] scsi_init_queue+0x26/0x90 [scsi_mod]
Jun 24 16:54:33 paradise [<dce6c006>] init_scsi+0x6/0xb0 [scsi_mod]
Jun 24 16:54:33 paradise [<c0124cd8>] sys_init_module+0x10e/0x1c8
Jun 24 16:54:33 paradise [<c0103ac7>] syscall_call+0x7/0xb
Jun 24 16:54:33 paradise 
Jun 24 16:54:33 paradise Code: 0f 0b 5c 05 8c 71 2a c0 8b 6d 00 8b 45 00 0f 18 00 90 81 fd 

--------------080004090605050908070202
Content-Type: text/plain;
 name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_PCMCIA_DEBUG=y
CONFIG_YENTA=m
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_CARMEL is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_REPORT_LUNS=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
CONFIG_SCTP_DBG_MSG=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_HMAC_NONE is not set
CONFIG_SCTP_HMAC_SHA1=y
# CONFIG_SCTP_HMAC_MD5 is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
CONFIG_PCMCIA_XIRC2PS=m
# CONFIG_PCMCIA_AXNET is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_I830=y
# CONFIG_DRM_MGA is not set
CONFIG_DRM_SIS=y

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
# CONFIG_VIDEO_SELECT is not set
CONFIG_FB_HGA=m
# CONFIG_FB_RIVA is not set
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=y
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_TRIDENT=m
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# PCMCIA devices
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_FRAME_POINTER is not set
# CONFIG_4KSTACKS is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=m
# CONFIG_LIBCRC32C is not set
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_STD_RESOURCES=y

--------------080004090605050908070202--

