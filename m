Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbREHIUy>; Tue, 8 May 2001 04:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbREHIUr>; Tue, 8 May 2001 04:20:47 -0400
Received: from ns.tasking.nl ([195.193.207.2]:61451 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S131498AbREHIUa>;
	Tue, 8 May 2001 04:20:30 -0400
Date: Tue, 8 May 2001 10:19:45 +0200
From: Frank van Maarseveen <fvm@tasking.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.2.14/2.4.0 extreme sluggishness
Message-ID: <20010508101944.A30685@espoo.tasking.nl>
Reply-To: frank_van_maarseveen@tasking.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one has puzzled me for more than a year. Occasionally a machine
(This time a Compaq EPa PIII 665MHz running 2.4.0, inside XFree86 4.0.3
i810E) almost freezes for no appearent reason. Symptom: when hitting the
caps lock or num lock key the LED on the keyboard responds only after
a substancial delay (say 5..30 seconds).

The mouse pointer may take minutes to respond.

I managed to get a few alt-sysrq-p and ran them through ksymoops:
ksymoops 2.3.5 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /boot/System.map-2.4.0 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
May  8 09:01:05 posio kernel: EIP: 0010:[<c025d80a>] CPU: 0 EFLAGS: 00000246 
Using defaults from ksymoops -t elf32-i386 -a i386
May  8 09:01:05 posio kernel: EAX: 00000000 EBX: c025d57c ECX: ffffffff EDX: c034c000 
May  8 09:01:05 posio kernel: ESI: c034c000 EDI: c03b5cc0 EBP: 0008e000 DS: 0018 ES: 0018 
May  8 09:01:05 posio kernel: CR0: 8005003b CR2: 098815e4 CR3: 02e57000 CR4: 00000090 
May  8 09:01:05 posio kernel: Call Trace: [<c025d57c>] [<c01072ba>] [<c0105000>] [<c0100192>]  
May  8 09:01:07 posio kernel: EIP: 0010:[<c01cde06>] CPU: 0 EFLAGS: 00000282 
May  8 09:01:07 posio kernel: EAX: 00000000 EBX: c03b1f80 ECX: 00000001 EDX: c038c1f4 
May  8 09:01:07 posio kernel: ESI: c115f060 EDI: 00000282 EBP: c03b1f40 DS: 0018 ES: 0018 
May  8 09:01:09 posio kernel: CR0: 8005003b CR2: 08a7b6b0 CR3: 02e57000 CR4: 00000090 
May  8 09:01:11 posio kernel: Call Trace: [<c01d4020>] [<c010a0bd>] [<c010a227>] [<c025d57c>] [<c0108f50>] [<c025d57c>] [<c0250018>]  
May  8 09:01:11 posio kernel:        [<c025d80a>] [<c025d57c>] [<c01072ba>] [<c0105000>] [<c0100192>]  
May  8 09:01:12 posio kernel: EIP: 0010:[<c01cde06>] CPU: 0 EFLAGS: 00000282 
May  8 09:01:12 posio kernel: EAX: 00000000 EBX: c03b1f80 ECX: 00000001 EDX: c038c1f4 
May  8 09:01:13 posio kernel: ESI: c115f060 EDI: 00000282 EBP: c03b1f40 DS: 0018 ES: 0018 
May  8 09:01:13 posio kernel: CR0: 8005003b CR2: 09d0a7d8 CR3: 03361000 CR4: 00000090 
May  8 09:01:13 posio kernel: Call Trace: [<c01d4020>] [<c010a0bd>] [<c010a227>] [<c025d57c>] [<c0108f50>] [<c025d57c>] [<c0250018>]  
May  8 09:01:14 posio kernel:        [<c025d80a>] [<c025d57c>] [<c01072ba>] [<c0105000>] [<c0100192>]  
May  8 09:01:14 posio kernel: EIP: 0010:[<c025d80a>] CPU: 0 EFLAGS: 00000246 
May  8 09:01:14 posio kernel: EAX: 00000000 EBX: c025d57c ECX: ffffffff EDX: c034c000 
May  8 09:01:15 posio kernel: ESI: c034c000 EDI: c03b5cc0 EBP: 0008e000 DS: 0018 ES: 0018 
May  8 09:01:15 posio kernel: CR0: 8005003b CR2: 0988705c CR3: 03361000 CR4: 00000090 
May  8 09:01:15 posio kernel: Call Trace: [<c025d57c>] [<c01072ba>] [<c0105000>] [<c0100192>]  
May  8 09:01:15 posio kernel: EIP: 0010:[<c025d80a>] CPU: 0 EFLAGS: 00000246 
May  8 09:01:16 posio kernel: EAX: 00000000 EBX: c025d57c ECX: ffffffff EDX: c034c000 
May  8 09:01:16 posio kernel: ESI: c034c000 EDI: c03b5cc0 EBP: 0008e000 DS: 0018 ES: 0018 
May  8 09:01:17 posio kernel: CR0: 8005003b CR2: 08b455fc CR3: 03361000 CR4: 00000090 
May  8 09:01:17 posio kernel: Call Trace: [<c025d57c>] [<c01072ba>] [<c0105000>] [<c0100192>]  
May  8 09:01:17 posio kernel: EIP: 0010:[<c01cde06>] CPU: 0 EFLAGS: 00000286 
May  8 09:01:17 posio kernel: EAX: 00000000 EBX: c03b1f80 ECX: 00000001 EDX: c038c1f4 
May  8 09:01:23 posio kernel: ESI: c115f060 EDI: 00000286 EBP: c03b1f40 DS: 0018 ES: 0018 
May  8 09:01:23 posio kernel: CR0: 8005003b CR2: 09519124 CR3: 03361000 CR4: 00000090 
May  8 09:01:23 posio kernel: Call Trace: [<c01d4020>] [<c010a0bd>] [<c010a227>] [<c0108f50>] [<c0122245>] [<c012a4ef>] [<c012a630>]  
May  8 09:01:24 posio kernel:        [<c011fecc>] [<c0120215>] [<c0110d9f>] [<c0110c44>] [<c01cc4f4>] [<c01d4266>] [<c01d415c>] [<c01cddb7>]  
May  8 09:01:24 posio kernel:        [<c01d415c>] [<c010a0bd>] [<c010c2c8>] [<c010a243>] [<c0108fd4>]  
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c025d80a <acpi_idle+28e/29c>   <=====
Trace; c025d57c <acpi_idle+0/29c>
Trace; c01072ba <cpu_idle+32/48>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100192 <L6+0/2>
>>EIP; c01cde06 <ide_intr+14a/150>   <=====
Trace; c01d4020 <read_intr+0/13c>
Trace; c010a0bd <handle_IRQ_event+31/5c>
Trace; c010a227 <do_IRQ+6b/ac>
Trace; c025d57c <acpi_idle+0/29c>
Trace; c0108f50 <ret_from_intr+0/20>
Trace; c025d57c <acpi_idle+0/29c>
Trace; c0250018 <acpi_aml_exec_reconfiguration+78/c0>
Trace; c025d80a <acpi_idle+28e/29c>
Trace; c025d57c <acpi_idle+0/29c>
Trace; c01072ba <cpu_idle+32/48>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100192 <L6+0/2>
>>EIP; c01cde06 <ide_intr+14a/150>   <=====
Trace; c01d4020 <read_intr+0/13c>
Trace; c010a0bd <handle_IRQ_event+31/5c>
Trace; c010a227 <do_IRQ+6b/ac>
Trace; c025d57c <acpi_idle+0/29c>
Trace; c0108f50 <ret_from_intr+0/20>
Trace; c025d57c <acpi_idle+0/29c>
Trace; c0250018 <acpi_aml_exec_reconfiguration+78/c0>
Trace; c025d80a <acpi_idle+28e/29c>
Trace; c025d57c <acpi_idle+0/29c>
Trace; c01072ba <cpu_idle+32/48>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100192 <L6+0/2>
>>EIP; c025d80a <acpi_idle+28e/29c>   <=====
Trace; c025d57c <acpi_idle+0/29c>
Trace; c01072ba <cpu_idle+32/48>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100192 <L6+0/2>
>>EIP; c025d80a <acpi_idle+28e/29c>   <=====
Trace; c025d57c <acpi_idle+0/29c>
Trace; c01072ba <cpu_idle+32/48>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100192 <L6+0/2>
>>EIP; c01cde06 <ide_intr+14a/150>   <=====
Trace; c01d4020 <read_intr+0/13c>
Trace; c010a0bd <handle_IRQ_event+31/5c>
Trace; c010a227 <do_IRQ+6b/ac>
Trace; c0108f50 <ret_from_intr+0/20>
Trace; c0122245 <__find_lock_page+75/d8>
Trace; c012a4ef <lookup_swap_cache+4f/174>
Trace; c012a630 <read_swap_cache_async+1c/9c>
Trace; c011fecc <do_swap_page+28/108>
Trace; c0120215 <handle_mm_fault+fd/164>
Trace; c0110d9f <do_page_fault+15b/41c>
Trace; c0110c44 <do_page_fault+0/41c>
Trace; c01cc4f4 <ide_set_handler+54/60>
Trace; c01d4266 <write_intr+10a/12c>
Trace; c01d415c <write_intr+0/12c>
Trace; c01cddb7 <ide_intr+fb/150>
Trace; c01d415c <write_intr+0/12c>
Trace; c010a0bd <handle_IRQ_event+31/5c>
Trace; c010c2c8 <end_8259A_irq+18/1c>
Trace; c010a243 <do_IRQ+87/ac>
Trace; c0108fd4 <error_code+34/40>

Unfortunately my caffeine level was too low to obtain any other
data such as disk activity, memory and tasks. AFAIK previous
instances did not show any disk activity but I cannot rule
it out in this particular case. Remains the question if that
should ever result in the observed behaviour.

Boot messages:
May  8 09:03:55 posio syslogd 1.3-3: restart.
May  8 09:03:55 posio syslog: syslogd startup succeeded
May  8 09:03:56 posio kernel: klogd 1.3-3, log source = /proc/kmsg started.
May  8 09:03:56 posio kernel: Linux version 2.4.0 (dicks@kemi) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Jan 9 14:16:03 MET 2001 
May  8 09:03:56 posio kernel: BIOS-provided physical RAM map: 
May  8 09:03:56 posio kernel:  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable) 
May  8 09:03:56 posio kernel:  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved) 
May  8 09:03:56 posio kernel:  BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved) 
May  8 09:03:56 posio kernel:  BIOS-e820: 0000000003e00000 @ 0000000000100000 (usable) 
May  8 09:03:56 posio kernel:  BIOS-e820: 0000000001160000 @ 00000000feea0000 (reserved) 
May  8 09:03:56 posio kernel: On node 0 totalpages: 16128 
May  8 09:03:56 posio kernel: zone(0): 4096 pages. 
May  8 09:03:56 posio kernel: zone(1): 12032 pages. 
May  8 09:03:56 posio kernel: zone(2): 0 pages. 
May  8 09:03:56 posio syslog: klogd startup succeeded
May  8 09:03:56 posio kernel: Kernel command line: auto BOOT_IMAGE=linux-2.4.0 ro root=302 BOOT_FILE=/boot/linux-2.4.0 nomodules 
May  8 09:03:56 posio kernel: Initializing CPU#0 
May  8 09:03:56 posio kernel: Detected 664.528 MHz processor. 
May  8 09:03:56 posio kernel: Console: colour VGA+ 80x25 
May  8 09:03:56 posio kernel: Calibrating delay loop... 1327.10 BogoMIPS 
May  8 09:03:56 posio kernel: Memory: 60240k/64512k available (1705k kernel code, 3884k reserved, 642k data, 216k init, 0k highmem) 
May  8 09:03:56 posio kernel: Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes) 
May  8 09:03:56 posio atd: atd startup succeeded
May  8 09:03:56 posio kernel: Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes) 
May  8 09:03:56 posio kernel: Page-cache hash table entries: 16384 (order: 4, 65536 bytes) 
May  8 09:03:56 posio kernel: Inode-cache hash table entries: 4096 (order: 3, 32768 bytes) 
May  8 09:03:56 posio kernel: CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0 
May  8 09:03:56 posio kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
May  8 09:03:56 posio kernel: CPU: L2 cache: 256K 
May  8 09:03:56 posio kernel: Intel machine check architecture supported. 
May  8 09:03:56 posio kernel: Intel machine check reporting enabled on CPU#0. 
May  8 09:03:56 posio kernel: CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000 
May  8 09:03:56 posio kernel: CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000 
May  8 09:03:56 posio kernel: CPU: Common caps: 0383f9ff 00000000 00000000 00000000 
May  8 09:03:56 posio kernel: CPU: Intel Pentium III (Coppermine) stepping 03 
May  8 09:03:56 posio kernel: Checking 'hlt' instruction... OK. 
May  8 09:03:56 posio kernel: POSIX conformance testing by UNIFIX 
May  8 09:03:56 posio kernel: mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au) 
May  8 09:03:56 posio kernel: mtrr: detected mtrr type: Intel 
May  8 09:03:56 posio kernel: PCI: PCI BIOS revision 2.10 entry at 0xecb91, last bus=1 
May  8 09:03:56 posio kernel: PCI: Using configuration type 1 
May  8 09:03:56 posio kernel: PCI: Probing PCI hardware 
May  8 09:03:56 posio kernel: Unknown bridge resource 2: assuming transparent 
May  8 09:03:56 posio kernel: PCI: Using IRQ router default [8086/2410] at 00:1f.0 
May  8 09:03:56 posio kernel: isapnp: Scanning for Pnp cards... 
May  8 09:03:56 posio kernel: isapnp: No Plug & Play device found 
May  8 09:03:56 posio kernel: Linux NET4.0 for Linux 2.4 
May  8 09:03:56 posio kernel: Based upon Swansea University Computer Society NET3.039 
May  8 09:03:56 posio kernel: Initializing RT netlink socket 
May  8 09:03:56 posio kernel: DMI 2.3 present. 
May  8 09:03:56 posio kernel: 42 structures occupying 1358 bytes. 
May  8 09:03:56 posio kernel: DMI table at 0x000FD97B. 
May  8 09:03:56 posio kernel: BIOS Vendor: Compaq 
May  8 09:03:56 posio kernel: BIOS Version: 686J1 v3.08 
May  8 09:03:56 posio kernel: BIOS Release: 03/15/2000 
May  8 09:03:56 posio kernel: System Vendor: Compaq. 
May  8 09:03:56 posio kernel: Product Name: Deskpro EP Series. 
May  8 09:03:56 posio kernel: Version . 
May  8 09:03:56 posio kernel: Serial Number 8032FQX42171    . 
May  8 09:03:56 posio kernel: Board Vendor: Compaq. 
May  8 09:03:56 posio kernel: Board Name: 0664h. 
May  8 09:03:56 posio kernel: Board Version: . 
May  8 09:03:56 posio kernel: Asset Tag: 8032FQX42171    . 
May  8 09:03:56 posio kernel: Starting kswapd v1.8 
May  8 09:03:56 posio kernel: pty: 256 Unix98 ptys configured 
May  8 09:03:56 posio kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize 
May  8 09:03:56 posio kernel: loop: enabling 8 loop devices 
May  8 09:03:56 posio kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31 
May  8 09:03:56 posio kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
May  8 09:03:56 posio kernel: PIIX4: IDE controller on PCI bus 00 dev f9 
May  8 09:03:56 posio kernel: PIIX4: chipset revision 2 
May  8 09:03:56 posio kernel: PIIX4: not 100%% native mode: will probe irqs later 
May  8 09:03:56 posio kernel: hda: FUJITSU MPF3102AT, ATA DISK drive 
May  8 09:03:56 posio kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
May  8 09:03:56 posio kernel: hda: 19541088 sectors (10005 MB) w/512KiB Cache, CHS=1292/240/63 
May  8 09:03:56 posio kernel: Partition check: 
May  8 09:03:56 posio kernel:  hda: hda1 hda2 hda4 
May  8 09:03:56 posio kernel: Floppy drive(s): fd0 is 1.44M 
May  8 09:03:56 posio kernel: FDC 0 is a post-1991 82077 
May  8 09:03:56 posio kernel: LVM version 0.9  by Heinz Mauelshagen  (13/11/2000) 
May  8 09:03:56 posio kernel: lvm -- Driver successfully initialized 
May  8 09:03:56 posio kernel: Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled 
May  8 09:03:56 posio kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
May  8 09:03:56 posio kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
May  8 09:03:56 posio kernel: Non-volatile memory driver v1.1 
May  8 09:03:56 posio kernel: 3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $ 
May  8 09:03:56 posio kernel: See Documentation/networking/vortex.txt 
May  8 09:03:56 posio kernel: eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000,  00:a0:24:51:5f:92, IRQ 11 
May  8 09:03:56 posio kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface. 
May  8 09:03:56 posio kernel:   MII transceiver found at address 24, status 786d. 
May  8 09:03:56 posio kernel:   MII transceiver found at address 0, status 786d. 
May  8 09:03:56 posio kernel:   Enabling bus-master transmits and whole-frame receives. 
May  8 09:03:56 posio kernel: PPP generic driver version 2.4.1 
May  8 09:03:56 posio kernel: PPP Deflate Compression module registered 
May  8 09:03:56 posio kernel: PPP BSD Compression module registered 
May  8 09:03:56 posio kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann 
May  8 09:03:56 posio kernel: agpgart: Maximum main memory to use for agp memory: 27M 
May  8 09:03:56 posio kernel: agpgart: Detected an Intel i810 E Chipset. 
May  8 09:03:56 posio kernel: agpgart: detected 4MB dedicated video ram. 
May  8 09:03:56 posio kernel: agpgart: AGP aperture is 64M @ 0x44000000 
May  8 09:03:56 posio kernel: [drm] AGP 0.99 on Intel i810 @ 0x44000000 64MB 
May  8 09:03:56 posio kernel: [drm] Initialized i810 1.1.0 20000928 on minor 63 
May  8 09:03:56 posio kernel: SCSI subsystem driver Revision: 1.00 
May  8 09:03:56 posio kernel: Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996 
May  8 09:03:56 posio kernel: sb: No ISAPnP cards found, trying standard ones... 
May  8 09:03:56 posio kernel: sb: I/O, IRQ, and DMA are mandatory 
May  8 09:03:56 posio kernel: Intel 810 + AC97 Audio, version 0.01, 14:18:51 Jan  9 2001 
May  8 09:03:56 posio kernel: PCI: Setting latency timer of device 00:1f.5 to 64 
May  8 09:03:56 posio kernel: i810: Intel ICH 82801AA found at IO 0x2400 and 0x2000, IRQ 11 
May  8 09:03:56 posio kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5340 (Analog Devices AD1881) 
May  8 09:03:56 posio kernel: usb.c: registered new driver usbdevfs 
May  8 09:03:56 posio kernel: usb.c: registered new driver hub 
May  8 09:03:56 posio kernel: usb-uhci.c: $Revision: 1.251 $ time 14:19:04 Jan  9 2001 
May  8 09:03:56 posio kernel: usb-uhci.c: High bandwidth mode enabled 
May  8 09:03:56 posio kernel: PCI: Setting latency timer of device 00:1f.2 to 64 
May  8 09:03:56 posio kernel: usb-uhci.c: USB UHCI at I/O 0x2440, IRQ 11 
May  8 09:03:56 posio kernel: usb-uhci.c: Detected 2 ports 
May  8 09:03:56 posio kernel: usb.c: new USB bus registered, assigned bus number 1 
May  8 09:03:56 posio kernel: hub.c: USB hub found 
May  8 09:03:56 posio kernel: hub.c: 2 ports detected 
May  8 09:03:56 posio kernel: usb.c: registered new driver usbscanner 
May  8 09:03:56 posio kernel: scanner.c: USB Scanner support registered. 
May  8 09:03:56 posio kernel: usb.c: registered new driver usblp 
May  8 09:03:56 posio kernel: usb.c: registered new driver usb-storage 
May  8 09:03:56 posio kernel: USB Mass Storage support registered. 
May  8 09:03:56 posio kernel: ACPI: System description tables found 
May  8 09:03:56 posio kernel: ACPI: System description tables loaded 
May  8 09:03:56 posio kernel: ACPI: Subsystem enabled 
May  8 09:03:56 posio kernel: ACPI: System firmware supports: C2 
May  8 09:03:56 posio kernel: ACPI: System firmware supports: S0 S1 S4 S5 
May  8 09:03:56 posio kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
May  8 09:03:56 posio kernel: IP Protocols: ICMP, UDP, TCP, IGMP 
May  8 09:03:56 posio kernel: IP: routing cache hash table of 512 buckets, 4Kbytes 
May  8 09:03:56 posio kernel: TCP: Hash tables configured (established 4096 bind 4096) 
May  8 09:03:56 posio kernel: ip_tables: (c)2000 Netfilter core team 
May  8 09:03:56 posio kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0. 
May  8 09:03:56 posio kernel: VFS: Mounted root (ext2 filesystem) readonly. 
May  8 09:03:56 posio kernel: Freeing unused kernel memory: 216k freed 
May  8 09:03:56 posio kernel: Adding Swap: 264560k swap-space (priority -1) 
May  8 09:03:56 posio kernel: eth0: using NWAY autonegotiation 

.config:
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_M686FXSR is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
CONFIG_BLK_DEV_LVM=y
CONFIG_LVM_PROC_FS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
# CONFIG_IP_ROUTE_NAT is not set
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
# CONFIG_IP_NF_TARGET_MIRROR is not set
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
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
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_IDEDMA_PCI is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=y
# CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT is not set
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
# CONFIG_AIC7XXX_PROC_STATS is not set
CONFIG_AIC7XXX_RESET_DELAY=5
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=y
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139TOO is not set
# CONFIG_RTL8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_ASYNC=y
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
CONFIG_NVRAM=y
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_I810=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_I810=y
# CONFIG_DRM_MGA is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
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
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=y
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
CONFIG_SOUND_ICH=y
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=y
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMPCI is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
CONFIG_USB_UHCI=y
CONFIG_USB_OHCI=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=y
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_NET1080 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB misc drivers
#
# CONFIG_USB_RIO500 is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y


-- 
Frank
