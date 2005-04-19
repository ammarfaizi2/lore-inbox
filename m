Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVDSJdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVDSJdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVDSJdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:33:35 -0400
Received: from mail.dif.dk ([193.138.115.101]:45202 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261427AbVDSJaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:30:16 -0400
Date: Tue, 19 Apr 2005 11:33:09 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc2-mm3 regression - certain applications get SIGSEGV but
 are fine with 2.6.12-rc2-mm2
Message-ID: <Pine.LNX.4.62.0504191122060.2238@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Everything is fine with 2.6.12-rc2, 2.6.12-rc2-mm1, 2.6.12-rc2-mm2 & 
earlier kernels as well, but 2.6.12-rc2-mm3 seems to have a problem.
I don't know what's causing this, all I can do at the moment is describe 
the symptoms.

Certain applications (krootimage and ksplash from KDE 3.4 are 100% 
reproducible test cases) that used to run fine have started crashing with 
SIGSEGV on 2.6.12-rc2-mm3. I see nothing suspicious in dmesg.
I'm including dmesg output as well as strace output from krootimage and 
ksplash below.
If someone could give me a hint as to what the cause of this could be or 
what to try in order to track it down I'd appreciate it.
This is 100% reproducible.

dmesg :

[4294667.296000] Linux version 2.6.12-rc2-mm3 (juhl@dragon) (gcc version 3.4.3) #1 PREEMPT Sun Apr 17 22:46:25 CEST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[4294667.296000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
[4294667.296000]  BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
[4294667.296000]  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[4294667.296000] 511MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 131052
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 126956 pages, LIFO batch:16
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 ASUS                                  ) @ 0x000f69e0
[4294667.296000] ACPI: RSDT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec000
[4294667.296000] ACPI: FADT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec080
[4294667.296000] ACPI: BOOT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec040
[4294667.296000] ACPI: DSDT (v001   ASUS A7M266   0x00001000 MSFT 0x0100000b) @ 0x00000000
[4294667.296000] Allocating PCI resources starting at 20000000 (gap: 20000000:dfff0000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Initializing CPU#0
[4294667.296000] Kernel command line: BOOT_IMAGE=2.6.12-rc2-mm3 ro root=801 pci=usepirqmask
[4294667.296000] CPU 0 irqstacks, hard=c04f5000 soft=c04f4000
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 1400.282 MHz processor.
[   31.035373] Using tsc for high-res timesource
[   31.035413] Console: colour dummy device 80x25
[   31.036630] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   31.039130] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   31.064195] Memory: 514504k/524208k available (2926k kernel code, 9176k reserved, 936k data, 160k init, 0k highmem)
[   31.064211] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   31.064319] Calibrating delay loop... 2760.70 BogoMIPS (lpj=1380352)
[   31.087818] Mount-cache hash table entries: 512
[   31.087981] CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
[   31.087991] CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
[   31.088002] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   31.088010] CPU: L2 Cache: 256K (64 bytes/line)
[   31.088015] CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020 00000000 00000000 00000000
[   31.088023] Intel machine check architecture supported.
[   31.088029] Intel machine check reporting enabled on CPU#0.
[   31.088034] CPU: AMD Athlon(tm) Processor stepping 04
[   31.088041] Enabling fast FPU save and restore... done.
[   31.088049] Checking 'hlt' instruction... OK.
[   31.100361] ACPI: setting ELCR to 0200 (from 0838)
[   31.100711] softlockup thread 0 started up.
[   31.101092] NET: Registered protocol family 16
[   31.102139] PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
[   31.102152] PCI: Using configuration type 1
[   31.102159] mtrr: v2.0 (20020519)
[   31.102686] ACPI: Subsystem revision 20050309
[   31.109047] ACPI: Interpreter enabled
[   31.109055] ACPI: Using PIC for interrupt routing
[   31.109787] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
[   31.110110] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[   31.110432] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   31.110767] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
[   31.112652] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   31.112661] PCI: Probing PCI hardware (bus 00)
[   31.112993] ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
[   31.113003] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   31.115511] Boot video device is 0000:01:05.0
[   31.115551] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   31.170507] ACPI: Can't get handler for 0000:00:05.0
[   31.177417] ACPI: Can't get handler for 0000:00:09.0
[   31.184173] ACPI: Can't get handler for 0000:00:0a.0
[   31.191052] ACPI: Can't get handler for 0000:00:0b.0
[   31.197834] ACPI: Can't get handler for 0000:00:0d.0
[   31.204701] ACPI: Can't get handler for 0000:00:0d.1
[   31.204751] ACPI: Can't get handler for 0000:01:05.0
[   31.205039] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[   31.212404] SCSI subsystem initialized
[   31.212419] PCI: Using ACPI for IRQ routing
[   31.212426] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   31.224952] Simple Boot Flag at 0x3a set to 0x1
[   31.224969] Machine check exception polling timer started.
[   31.225101] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[   31.225108] apm: overridden by ACPI.
[   31.226122] inotify device minor=63
[   31.226242] Initializing Cryptographic API
[   31.226402] vesafb: framebuffer at 0xf0000000, mapped to 0xe0880000, using 3072k, total 65536k
[   31.226413] vesafb: mode is 1024x768x16, linelength=2048, pages=0
[   31.226420] vesafb: protected mode interface info at c000:b5b0
[   31.226425] vesafb: scrolling: redraw
[   31.226432] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   31.239994] Console: switching to colour frame buffer device 128x48
[   31.240087] fb0: VESA VGA frame buffer device
[   31.240162] ACPI: No ACPI bus support for vesafb.0
[   31.242236] Real Time Clock Driver v1.12
[   31.242405] ACPI: No ACPI bus support for i8042
[   31.242582] serio: i8042 AUX port at 0x60,0x64 irq 12
[   31.242680] serio: i8042 KBD port at 0x60,0x64 irq 1
[   31.242751] Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing disabled
[   31.242872] ACPI: No ACPI bus support for serial8250
[   31.243298] io scheduler noop registered
[   31.243383] io scheduler anticipatory registered
[   31.243451] io scheduler deadline registered
[   31.243520] io scheduler cfq registered
[   31.243868] ACPI: Floppy Controller [FDC0] at I/O 0x3f2-0x3f5, 0x3f7 irq 6 dma channel 2
[   31.244044] Floppy drive(s): fd0 is 1.44M
[   31.244171] ACPI: No ACPI bus support for serio0
[   31.244293] ACPI: No ACPI bus support for serio1
[   31.258320] FDC 0 is a post-1991 82077
[   31.259237] ACPI: No ACPI bus support for floppy.0
[   31.261987] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
[   31.264066] PCI: setting IRQ 5 as level-triggered
[   31.266172] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[   31.478325] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
[   31.478327]         <Adaptec 29160N Ultra160 SCSI adapter>
[   31.478330]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   31.478332] 
[   47.501754] (scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
[   47.511534] (scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 16)
[   47.518524] (scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
[   50.598821]   Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
[   50.601355]   Type:   CD-ROM                             ANSI SCSI revision: 02
[   50.603820] ACPI: No ACPI bus support for 0:0:4:0
[   50.607123]   Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
[   50.609676]   Type:   CD-ROM                             ANSI SCSI revision: 02
[   50.612164] ACPI: No ACPI bus support for 0:0:5:0
[   50.615754]   Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
[   50.618361]   Type:   Direct-Access                      ANSI SCSI revision: 03
[   50.620871] scsi0:A:6:0: Tagged Queuing enabled.  Depth 250
[   50.623348] ACPI: No ACPI bus support for 0:0:6:0
[   52.676523] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   52.680259] SCSI device sda: drive cache: write back
[   52.683692] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   52.687474] SCSI device sda: drive cache: write back
[   52.689930]  sda: sda1 sda2 sda3 sda4
[   52.708786] Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
[   52.712175] sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
[   52.714672] Uniform CD-ROM driver Revision: 3.20
[   52.717223] Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
[   52.722119] sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   52.724697] Attached scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
[   52.724770] mice: PS/2 mouse device common for all mice
[   52.727385] Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
[   52.730414] PCI: Enabling device 0000:00:0d.0 (0004 -> 0005)
[   52.733479] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
[   52.736101] PCI: setting IRQ 3 as level-triggered
[   52.738743] ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
[   52.755914] ALSA device list:
[   52.758724]   #0: SB Live [Unknown] (rev.10, serial:0x80671102) at 0x9400, irq 3
[   52.761573] NET: Registered protocol family 2
[   52.772596] IP: routing cache hash table of 1024 buckets, 32Kbytes
[   52.775626] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[   52.779025] TCP bind hash table entries: 32768 (order: 7, 917504 bytes)
[   52.784034] TCP: Hash tables configured (established 32768 bind 32768)
[   52.787120] NET: Registered protocol family 1
[   52.789999] NET: Registered protocol family 17
[   52.792826] NET: Registered protocol family 15
[   52.809285] EXT3-fs: mounted filesystem with ordered data mode.
[   52.812087] VFS: Mounted root (ext3 filesystem) readonly.
[   52.815151] Freeing unused kernel memory: 160k freed
[   52.818000] kjournald starting.  Commit interval 5 seconds
[   52.918756] input: AT Translated Set 2 keyboard on isa0060/serio0
[   53.503236] input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
[   54.889225] Adding 763076k swap on /dev/sda3.  Priority:-1 extents:1
[   54.967996] EXT3 FS on sda1, internal journal
[   56.248331] Linux agpgart interface v0.101 (c) Dave Jones
[   60.166994] ReiserFS: sda2: found reiserfs format "3.6" with standard journal
[   60.427030] ReiserFS: sda2: using ordered data mode
[   60.437551] ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   60.445397] ReiserFS: sda2: checking transaction log (sda2)
[   60.464239] ReiserFS: sda2: Using r5 hash to sort names
[   60.507814] ReiserFS: sda4: found reiserfs format "3.6" with standard journal
[   61.246180] ReiserFS: sda4: using ordered data mode
[   61.270428] ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   61.278574] ReiserFS: sda4: checking transaction log (sda4)
[   61.336931] ReiserFS: sda4: Using r5 hash to sort names
[   63.536170] via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
[   63.546138] PCI: Enabling device 0000:00:09.0 (0094 -> 0097)
[   63.546338] ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
[   63.546426] PCI: Via PIC IRQ fixup for 0000:00:09.0, from 255 to 3
[   63.554152] eth0: VIA Rhine II at 0xeb800000, 00:50:ba:f2:a3:1d, IRQ 3.
[   63.555091] eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
[   63.651052] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   63.881484] parport_pc: VIA 686A/8231 detected
[   63.881498] parport_pc: probing current configuration
[   63.881517] parport_pc: Current parallel port base: 0x0
[   63.881523] parport_pc: VIA parallel port disabled in BIOS


strace of krootimage : 

execve("/opt/kde/bin/krootimage", ["krootimage"], [/* 43 vars */]) = 0
brk(0)                                  = 0x805e000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/./i686/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/./i686", 0xbfd0f118)   = -1 ENOENT (No such file or directory)
open("/usr/lib/./libgcc_s.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\25\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=32596, ...}) = 0
old_mmap(NULL, 34304, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40017000
old_mmap(0x4001f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x4001f000
close(3)                                = 0
open("/usr/lib/./libkio.so.4", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/i686/libkio.so.4", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/kde/lib/i686", 0xbfd0f0fc) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libkio.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\315"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=3387116, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40020000
old_mmap(NULL, 3390364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40021000
old_mmap(0x4033e000, 122880, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x31c000) = 0x4033e000
old_mmap(0x4035c000, 2972, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4035c000
close(3)                                = 0
open("/usr/lib/./libkdeui.so.4", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libkdeui.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260n\20"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2982532, ...}) = 0
old_mmap(NULL, 2985940, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4035d000
old_mmap(0x4060a000, 180224, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2ac000) = 0x4060a000
close(3)                                = 0
open("/usr/lib/./libkdesu.so.4", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libkdesu.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 I\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=105260, ...}) = 0
old_mmap(NULL, 103928, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40636000
old_mmap(0x4064f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19000) = 0x4064f000
close(3)                                = 0
open("/usr/lib/./libkwalletclient.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libkwalletclient.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360O\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=72764, ...}) = 0
old_mmap(NULL, 71476, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40650000
old_mmap(0x40661000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x40661000
close(3)                                = 0
open("/usr/lib/./libkdecore.so.4", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libkdecore.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\250\n"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2320032, ...}) = 0
old_mmap(NULL, 2329900, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40662000
old_mmap(0x40888000, 69632, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x225000) = 0x40888000
old_mmap(0x40899000, 7468, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40899000
close(3)                                = 0
open("/usr/lib/./libDCOP.so.4", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libDCOP.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\353"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=206504, ...}) = 0
old_mmap(NULL, 212256, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4089b000
old_mmap(0x408cc000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x31000) = 0x408cc000
old_mmap(0x408ce000, 3360, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x408ce000
close(3)                                = 0
open("/usr/lib/./libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/i686/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/qt/lib/i686", 0xbfd0f054) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/qt/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/usr/X11R6/lib/i686/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/X11R6/lib/i686", 0xbfd0f054) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/X11R6/lib", {st_mode=S_IFDIR|0755, st_size=8192, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=105181, ...}) = 0
old_mmap(NULL, 105181, PROT_READ, MAP_PRIVATE, 3, 0) = 0x408cf000
close(3)                                = 0
open("/lib/libresolv.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200$\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=73805, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x408e9000
old_mmap(NULL, 75976, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x408ea000
mprotect(0x408f8000, 18632, PROT_NONE)  = 0
old_mmap(0x408f9000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0x408f9000
old_mmap(0x408fb000, 6344, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x408fb000
close(3)                                = 0
open("/usr/lib/./libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libutil.so.1", O_RDONLY)     = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\f\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=12420, ...}) = 0
old_mmap(NULL, 12424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x408fd000
old_mmap(0x408ff000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x408ff000
close(3)                                = 0
open("/usr/lib/./libart_lgpl_2.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0#\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=86772, ...}) = 0
old_mmap(NULL, 88892, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40901000
old_mmap(0x40916000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0x40916000
close(3)                                = 0
open("/usr/lib/./libidn.so.11", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\37\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=195828, ...}) = 0
old_mmap(NULL, 194364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40917000
old_mmap(0x40945000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e000) = 0x40945000
close(3)                                = 0
open("/usr/lib/./libkdefx.so.4", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libkdefx.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\252\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=175552, ...}) = 0
old_mmap(NULL, 179580, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40947000
old_mmap(0x40971000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x29000) = 0x40971000
close(3)                                = 0
open("/usr/lib/./libqt-mt.so.3", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libqt-mt.so.3", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libqt-mt.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\337\31"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=7097180, ...}) = 0
old_mmap(NULL, 7104048, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40973000
old_mmap(0x40ff6000, 262144, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x683000) = 0x40ff6000
old_mmap(0x41036000, 13872, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41036000
close(3)                                = 0
open("/usr/lib/./libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libfontconfig.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\201"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=183910, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4103a000
old_mmap(NULL, 158264, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4103b000
old_mmap(0x4105e000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x4105e000
old_mmap(0x41061000, 2616, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41061000
close(3)                                = 0
open("/usr/lib/./libmng.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\373"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=364036, ...}) = 0
old_mmap(NULL, 366652, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41062000
old_mmap(0x410b9000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x56000) = 0x410b9000
mprotect(0xbfd0f000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC|0x1000000) = 0
close(3)                                = 0
open("/usr/lib/./libjpeg.so.62", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`$\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=114152, ...}) = 0
old_mmap(NULL, 116268, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x410bc000
old_mmap(0x410d8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b000) = 0x410d8000
close(3)                                = 0
open("/usr/lib/./libGL.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320A\2"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=423832, ...}) = 0
old_mmap(NULL, 425024, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x410d9000
old_mmap(0x41131000, 61440, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x58000) = 0x41131000
old_mmap(0x41140000, 3136, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41140000
close(3)                                = 0
open("/usr/lib/./libXmu.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libXmu.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXmu.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXmu.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340I\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=106882, ...}) = 0
old_mmap(NULL, 89388, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41141000
old_mmap(0x41156000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15000) = 0x41156000
close(3)                                = 0
open("/usr/lib/./libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXrandr.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\f\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=12481, ...}) = 0
old_mmap(NULL, 8668, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41157000
old_mmap(0x41159000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x41159000
close(3)                                = 0
open("/usr/lib/./libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXcursor.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\"\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=40363, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4115a000
old_mmap(NULL, 35816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4115b000
old_mmap(0x41163000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x41163000
close(3)                                = 0
open("/usr/lib/./libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXinerama.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\10"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=8882, ...}) = 0
old_mmap(NULL, 9660, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41164000
old_mmap(0x41166000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x41166000
close(3)                                = 0
open("/usr/lib/./libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXft.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260:\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=83759, ...}) = 0
old_mmap(NULL, 70960, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41167000
old_mmap(0x41178000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x41178000
close(3)                                = 0
open("/usr/lib/./libfreetype.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\352"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=486641, ...}) = 0
old_mmap(NULL, 433840, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41179000
old_mmap(0x411dc000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x63000) = 0x411dc000
close(3)                                = 0
open("/usr/lib/./libexpat.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360 \0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=130364, ...}) = 0
old_mmap(NULL, 128996, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x411e3000
old_mmap(0x41201000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e000) = 0x41201000
close(3)                                = 0
open("/usr/lib/./libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\v\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=13120, ...}) = 0
old_mmap(NULL, 12392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41203000
old_mmap(0x41205000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x41205000
close(3)                                = 0
open("/usr/lib/./libpng.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@Z\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=197288, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41207000
old_mmap(NULL, 199908, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41208000
old_mmap(0x41238000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2f000) = 0x41238000
close(3)                                = 0
open("/usr/lib/./libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXext.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340&\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=63316, ...}) = 0
old_mmap(NULL, 55860, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41239000
old_mmap(0x41246000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc000) = 0x41246000
close(3)                                = 0
open("/usr/lib/./libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libX11.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\24\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=910537, ...}) = 0
old_mmap(NULL, 825592, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41247000
old_mmap(0x4130d000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc6000) = 0x4130d000
close(3)                                = 0
open("/usr/lib/./libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libSM.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P \0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=36860, ...}) = 0
old_mmap(NULL, 30296, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41311000
old_mmap(0x41318000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x41318000
close(3)                                = 0
open("/usr/lib/./libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libICE.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2606\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=99757, ...}) = 0
old_mmap(NULL, 97168, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41319000
old_mmap(0x4132e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0x4132e000
old_mmap(0x4132f000, 7056, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4132f000
close(3)                                = 0
open("/usr/lib/./libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0@\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=85581, ...}) = 0
old_mmap(NULL, 335044, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41331000
old_mmap(0x4133f000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd000) = 0x4133f000
old_mmap(0x41341000, 269508, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41341000
close(3)                                = 0
open("/usr/lib/./libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXrender.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\23"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=33306, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41383000
old_mmap(NULL, 31464, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41384000
old_mmap(0x4138b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x4138b000
close(3)                                = 0
open("/usr/lib/./libz.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\27\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=66908, ...}) = 0
old_mmap(NULL, 69632, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4138c000
old_mmap(0x4139c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xf000) = 0x4139c000
close(3)                                = 0
open("/usr/lib/./libstdc++.so.5", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\261"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=730400, ...}) = 0
old_mmap(NULL, 748768, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4139d000
old_mmap(0x41438000, 94208, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9b000) = 0x41438000
old_mmap(0x4144f000, 19680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4144f000
close(3)                                = 0
open("/usr/lib/./libm.so.6", O_RDONLY)  = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P3\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=176352, ...}) = 0
old_mmap(NULL, 139424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41454000
old_mmap(0x41475000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x20000) = 0x41475000
close(3)                                = 0
open("/usr/lib/./libc.so.6", O_RDONLY)  = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 U\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1357414, ...}) = 0
old_mmap(NULL, 1166612, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41477000
mprotect(0x4158d000, 27924, PROT_NONE)  = 0
old_mmap(0x4158e000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x116000) = 0x4158e000
old_mmap(0x41592000, 7444, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41592000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41594000
open("/usr/lib/./libGLcore.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\351\n"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=7132152, ...}) = 0
old_mmap(NULL, 7174120, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41595000
old_mmap(0x41c3e000, 110592, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6a9000) = 0x41c3e000
old_mmap(0x41c59000, 79848, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41c59000
close(3)                                = 0
open("/usr/lib/./libnvidia-tls.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\3\0\000"..., 512) = 512
lseek(3, 1304, SEEK_SET)                = 1304
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\2\0\0\0"..., 32) = 32
fstat64(3, {st_mode=S_IFREG|0755, st_size=2352, ...}) = 0
old_mmap(NULL, 5588, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41c6d000
old_mmap(0x41c6e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0x41c6e000
close(3)                                = 0
open("/usr/lib/./libXt.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libXt.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXt.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXt.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\276"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=373599, ...}) = 0
old_mmap(NULL, 329308, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41c6f000
old_mmap(0x41cbc000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4d000) = 0x41cbc000
old_mmap(0x41cbf000, 1628, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41cbf000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41cc0000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41cc1000
mprotect(0x41c6d000, 4096, PROT_READ|PROT_WRITE) = 0
mprotect(0x41c6d000, 4096, PROT_READ|PROT_EXEC) = 0
mprotect(0x41595000, 6983680, PROT_READ|PROT_WRITE) = 0
mprotect(0x41595000, 6983680, PROT_READ|PROT_EXEC) = 0
mprotect(0x4158e000, 4096, PROT_READ)   = 0
mprotect(0x410d9000, 360448, PROT_READ|PROT_WRITE) = 0
mprotect(0x410d9000, 360448, PROT_READ|PROT_EXEC) = 0
munmap(0x408cf000, 105181)              = 0
getrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY, rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
getpid()                                = 2288
uname({sys="Linux", node="dragon", ...}) = 0
rt_sigaction(SIGRTMIN, {0x413398d0, [], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x41338c10, [RTMIN], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x41339920, [], 0}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfd0f604, 40, (nil), 0}) = 0
brk(0)                                  = 0x805e000
brk(0x807f000)                          = 0x807f000
open("/dev/zero", O_RDWR)               = 3
old_mmap(NULL, 1024, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x408cf000
close(3)                                = 0
getpid()                                = 2288
old_mmap(NULL, 671744, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41cc2000
getpid()                                = 2288
modify_ldt(17, {entry_number:0, base_addr:0x805e3b8, limit:512, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:0, seg_not_present:0, useable:1}, 16) = 0
getcwd("/home/juhl", 4096)              = 11
access("/usr/lib/qt/plugins", F_OK)     = 0
access("/usr/lib/qt/plugins/codecs/.", F_OK) = -1 ENOENT (No such file or directory)
readlink("/proc/self/exe", "/opt/kde/bin/krootimage", 4096) = 23
getuid32()                              = 1000
lstat64("/home", {st_mode=S_IFDIR|0755, st_size=176, ...}) = 0
lstat64("/home/juhl", {st_mode=S_IFDIR|0711, st_size=12856, ...}) = 0
lstat64("/home/juhl/.kde", {st_mode=S_IFDIR|0700, st_size=200, ...}) = 0
lstat64("/home/juhl/.kde/share", {st_mode=S_IFDIR|0700, st_size=200, ...}) = 0
lstat64("/home/juhl/.kde/share/config", {st_mode=S_IFDIR|0700, st_size=2832, ...}) = 0
stat64("/home/juhl/.kde/share/config/", {st_mode=S_IFDIR|0700, st_size=2832, ...}) = 0
stat64("/home/juhl/.kde/share/config/", {st_mode=S_IFDIR|0700, st_size=2832, ...}) = 0
access("/home/juhl/.kde/share/config/krootimagerc", W_OK) = -1 ENOENT (No such file or directory)
access("/home/juhl/.kde/share/config/krootimagerc", F_OK) = -1 ENOENT (No such file or directory)
access("/home/juhl/.kde/share/config", W_OK) = 0
lstat64("/home/juhl/.kde/share/config/krootimagerc", 0x8069cd0) = -1 ENOENT (No such file or directory)
stat64("/home/juhl/.kde/share/config/krootimagerc", 0x8069cd0) = -1 ENOENT (No such file or directory)
lstat64("/home/juhl/.kde/share/config/krootimagerc", 0x8068948) = -1 ENOENT (No such file or directory)
stat64("/home/juhl/.kde/share/config/krootimagerc", 0x8068948) = -1 ENOENT (No such file or directory)
lstat64("/home", {st_mode=S_IFDIR|0755, st_size=176, ...}) = 0
lstat64("/home/juhl", {st_mode=S_IFDIR|0711, st_size=12856, ...}) = 0
lstat64("/home/juhl/.kde", {st_mode=S_IFDIR|0700, st_size=200, ...}) = 0
lstat64("/home/juhl/.kde/share", {st_mode=S_IFDIR|0700, st_size=200, ...}) = 0
lstat64("/home/juhl/.kde/share/config", {st_mode=S_IFDIR|0700, st_size=2832, ...}) = 0
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/kde", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/kde/share", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/kde/share/config", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
access("/opt/kde/share/config", F_OK)   = 0
lstat64("/opt/kde/share/config", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/home/juhl/.kde/share/config/kdeglobals", {st_mode=S_IFREG|0600, st_size=5374, ...}) = 0
stat64("/opt/kde/share/config/kdeglobals", 0xbfd0ebf0) = -1 ENOENT (No such file or directory)
access("/etc/kderc", R_OK)              = -1 ENOENT (No such file or directory)
stat64("/home/juhl/.kde/share/config/system.kdeglobals", 0xbfd0ebf0) = -1 ENOENT (No such file or directory)
stat64("/opt/kde/share/config/system.kdeglobals", 0xbfd0ebf0) = -1 ENOENT (No such file or directory)
open("/home/juhl/.kde/share/config/kdeglobals", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0600, st_size=5374, ...}) = 0
fstat64(3, {st_mode=S_IFREG|0600, st_size=5374, ...}) = 0
old_mmap(NULL, 5374, PROT_READ, MAP_PRIVATE, 3, 0) = 0x41d66000
fstat64(3, {st_mode=S_IFREG|0600, st_size=5374, ...}) = 0
rt_sigaction(SIGBUS, {0x4133cc00, [], SA_ONESHOT}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
fstat64(3, {st_mode=S_IFREG|0600, st_size=5374, ...}) = 0
munmap(0x41d66000, 5374)                = 0
rt_sigaction(SIGBUS, {SIG_DFL}, NULL, 8) = 0
close(3)                                = 0
stat64("/home/juhl/.kde/share/config/krootimagerc", 0xbfd0ebf0) = -1 ENOENT (No such file or directory)
stat64("/opt/kde/share/config/krootimagerc", 0xbfd0ebf0) = -1 ENOENT (No such file or directory)
lstat64("/home", {st_mode=S_IFDIR|0755, st_size=176, ...}) = 0
lstat64("/home/juhl", {st_mode=S_IFDIR|0711, st_size=12856, ...}) = 0
lstat64("/home/juhl/.kde", {st_mode=S_IFDIR|0700, st_size=200, ...}) = 0
lstat64("/home/juhl/.kde/share", {st_mode=S_IFDIR|0700, st_size=200, ...}) = 0
lstat64("/home/juhl/.kde/share/locale", 0xbfd0dd6c) = -1 ENOENT (No such file or directory)
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/kde", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/kde/share", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/kde/share/locale", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
access("/opt/kde/share/locale", F_OK)   = 0
lstat64("/opt/kde/share/locale", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
access("/home/juhl/.kde/share/locale/en/LC_MESSAGES/kdesktop.mo", R_OK) = -1 ENOENT (No such file or directory)
access("/opt/kde/share/locale/en/LC_MESSAGES/kdesktop.mo", R_OK) = -1 ENOENT (No such file or directory)
access("/home/juhl/.kde/share/locale/en_US/LC_MESSAGES/kdesktop.mo", R_OK) = -1 ENOENT (No such file or directory)
access("/opt/kde/share/locale/en_US/LC_MESSAGES/kdesktop.mo", R_OK) = -1 ENOENT (No such file or directory)
access("/home/juhl/.kde/share/locale/en_US/LC_MESSAGES/kdelibs.mo", R_OK) = -1 ENOENT (No such file or directory)
access("/opt/kde/share/locale/en_US/LC_MESSAGES/kdelibs.mo", R_OK) = -1 ENOENT (No such file or directory)
access("/home/juhl/.kde/share/locale/en_US/LC_MESSAGES/kio.mo", R_OK) = -1 ENOENT (No such file or directory)
access("/opt/kde/share/locale/en_US/LC_MESSAGES/kio.mo", R_OK) = -1 ENOENT (No such file or directory)
fstat64(1, {st_mode=S_IFCHR|0700, st_rdev=makedev(136, 2), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41d66000
write(1, "Usage: krootimage [Qt-options] ["..., 53) = 53
write(1, "\nFancy desktop background for kd"..., 34) = 34
write(1, "\nGeneric options:\n", 18)    = 18
write(1, "  --help                    Show"..., 52) = 52
write(1, "  --help-qt                 Show"..., 53) = 53
write(1, "  --help-kde                Show"..., 54) = 54
write(1, "  --help-all                Show"..., 45) = 45
write(1, "  --author                  Show"..., 52) = 52
write(1, "  -v, --version             Show"..., 53) = 53
write(1, "  --license                 Show"..., 53) = 53
write(1, "  --                        End "..., 43) = 43
write(1, "\nArguments:\n", 12)          = 12
write(1, "  config                    Name"..., 59) = 59
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++


strace of ksplash :

execve("/opt/kde/bin/ksplash", ["ksplash"], [/* 43 vars */]) = 0
brk(0)                                  = 0x8058000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/i686/libksplashthemes.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/kde/lib/i686", 0xbfb6f888) = -1 ENOENT (No such file or directory)
open("/opt/kde/lib/libksplashthemes.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0^\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=48828, ...}) = 0
old_mmap(NULL, 51652, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40017000
old_mmap(0x40023000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb000) = 0x40023000
close(3)                                = 0
open("/opt/kde/lib/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./i686/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/./i686", 0xbfb6f86c)   = -1 ENOENT (No such file or directory)
open("/usr/lib/./libgcc_s.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\25\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=32596, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40024000
old_mmap(NULL, 34304, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40025000
old_mmap(0x4002d000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x4002d000
close(3)                                = 0
open("/opt/kde/lib/libkio.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\315"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=3387116, ...}) = 0
old_mmap(NULL, 3390364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4002e000
old_mmap(0x4034b000, 122880, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x31c000) = 0x4034b000
old_mmap(0x40369000, 2972, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40369000
close(3)                                = 0
open("/opt/kde/lib/libkdeui.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260n\20"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2982532, ...}) = 0
old_mmap(NULL, 2985940, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4036a000
old_mmap(0x40617000, 180224, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2ac000) = 0x40617000
close(3)                                = 0
open("/opt/kde/lib/libkdesu.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 I\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=105260, ...}) = 0
old_mmap(NULL, 103928, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40643000
old_mmap(0x4065c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19000) = 0x4065c000
close(3)                                = 0
open("/opt/kde/lib/libkwalletclient.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360O\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=72764, ...}) = 0
old_mmap(NULL, 71476, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4065d000
old_mmap(0x4066e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x4066e000
close(3)                                = 0
open("/opt/kde/lib/libkdecore.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\250\n"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2320032, ...}) = 0
old_mmap(NULL, 2329900, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4066f000
old_mmap(0x40895000, 69632, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x225000) = 0x40895000
old_mmap(0x408a6000, 7468, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x408a6000
close(3)                                = 0
open("/opt/kde/lib/libDCOP.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\353"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=206504, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x408a8000
old_mmap(NULL, 212256, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x408a9000
old_mmap(0x408da000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x31000) = 0x408da000
old_mmap(0x408dc000, 3360, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x408dc000
close(3)                                = 0
open("/opt/kde/lib/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/i686/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/qt/lib/i686", 0xbfb6f7a8) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/qt/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/usr/X11R6/lib/i686/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/X11R6/lib/i686", 0xbfb6f7a8) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libresolv.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/X11R6/lib", {st_mode=S_IFDIR|0755, st_size=8192, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=105181, ...}) = 0
old_mmap(NULL, 105181, PROT_READ, MAP_PRIVATE, 3, 0) = 0x408dd000
close(3)                                = 0
open("/lib/libresolv.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200$\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=73805, ...}) = 0
old_mmap(NULL, 75976, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x408f7000
mprotect(0x40905000, 18632, PROT_NONE)  = 0
old_mmap(0x40906000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0x40906000
old_mmap(0x40908000, 6344, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40908000
close(3)                                = 0
open("/opt/kde/lib/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libutil.so.1", O_RDONLY)     = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\f\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=12420, ...}) = 0
old_mmap(NULL, 12424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4090a000
old_mmap(0x4090c000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x4090c000
close(3)                                = 0
open("/opt/kde/lib/libart_lgpl_2.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libart_lgpl_2.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0#\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=86772, ...}) = 0
old_mmap(NULL, 88892, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4090e000
old_mmap(0x40923000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0x40923000
close(3)                                = 0
open("/opt/kde/lib/libidn.so.11", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libidn.so.11", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\37\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=195828, ...}) = 0
old_mmap(NULL, 194364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40924000
old_mmap(0x40952000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e000) = 0x40952000
close(3)                                = 0
open("/opt/kde/lib/libkdefx.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\252\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=175552, ...}) = 0
old_mmap(NULL, 179580, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40954000
old_mmap(0x4097e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x29000) = 0x4097e000
close(3)                                = 0
open("/opt/kde/lib/libqt-mt.so.3", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libqt-mt.so.3", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libqt-mt.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\337\31"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=7097180, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40980000
old_mmap(NULL, 7104048, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40981000
old_mmap(0x41004000, 262144, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x683000) = 0x41004000
old_mmap(0x41044000, 13872, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41044000
close(3)                                = 0
open("/opt/kde/lib/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libfontconfig.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\201"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=183910, ...}) = 0
old_mmap(NULL, 158264, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41048000
old_mmap(0x4106b000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x4106b000
old_mmap(0x4106e000, 2616, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4106e000
close(3)                                = 0
open("/opt/kde/lib/libmng.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libmng.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\373"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=364036, ...}) = 0
old_mmap(NULL, 366652, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4106f000
old_mmap(0x410c6000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x56000) = 0x410c6000
mprotect(0xbfb70000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC|0x1000000) = 0
close(3)                                = 0
open("/opt/kde/lib/libjpeg.so.62", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libjpeg.so.62", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`$\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=114152, ...}) = 0
old_mmap(NULL, 116268, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x410c9000
old_mmap(0x410e5000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b000) = 0x410e5000
close(3)                                = 0
open("/opt/kde/lib/libGL.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libGL.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320A\2"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=423832, ...}) = 0
old_mmap(NULL, 425024, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x410e6000
old_mmap(0x4113e000, 61440, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x58000) = 0x4113e000
old_mmap(0x4114d000, 3136, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4114d000
close(3)                                = 0
open("/opt/kde/lib/libXmu.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libXmu.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXmu.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXmu.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340I\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=106882, ...}) = 0
old_mmap(NULL, 89388, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4114e000
old_mmap(0x41163000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15000) = 0x41163000
close(3)                                = 0
open("/opt/kde/lib/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXrandr.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\f\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=12481, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41164000
old_mmap(NULL, 8668, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41165000
old_mmap(0x41167000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x41167000
close(3)                                = 0
open("/opt/kde/lib/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXcursor.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\"\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=40363, ...}) = 0
old_mmap(NULL, 35816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41168000
old_mmap(0x41170000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x41170000
close(3)                                = 0
open("/opt/kde/lib/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXinerama.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\10"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=8882, ...}) = 0
old_mmap(NULL, 9660, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41171000
old_mmap(0x41173000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x41173000
close(3)                                = 0
open("/opt/kde/lib/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXft.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260:\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=83759, ...}) = 0
old_mmap(NULL, 70960, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41174000
old_mmap(0x41185000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x41185000
close(3)                                = 0
open("/opt/kde/lib/libfreetype.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libfreetype.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\352"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=486641, ...}) = 0
old_mmap(NULL, 433840, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41186000
old_mmap(0x411e9000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x63000) = 0x411e9000
close(3)                                = 0
open("/opt/kde/lib/libexpat.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libexpat.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360 \0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=130364, ...}) = 0
old_mmap(NULL, 128996, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x411f0000
old_mmap(0x4120e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e000) = 0x4120e000
close(3)                                = 0
open("/opt/kde/lib/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\v\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=13120, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41210000
old_mmap(NULL, 12392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41211000
old_mmap(0x41213000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x41213000
close(3)                                = 0
open("/opt/kde/lib/libpng.so.3", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libpng.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@Z\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=197288, ...}) = 0
old_mmap(NULL, 199908, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41215000
old_mmap(0x41245000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2f000) = 0x41245000
close(3)                                = 0
open("/opt/kde/lib/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXext.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340&\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=63316, ...}) = 0
old_mmap(NULL, 55860, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41246000
old_mmap(0x41253000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc000) = 0x41253000
close(3)                                = 0
open("/opt/kde/lib/libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libX11.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\24\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=910537, ...}) = 0
old_mmap(NULL, 825592, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41254000
old_mmap(0x4131a000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc6000) = 0x4131a000
close(3)                                = 0
open("/opt/kde/lib/libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libSM.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P \0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=36860, ...}) = 0
old_mmap(NULL, 30296, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4131e000
old_mmap(0x41325000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x41325000
close(3)                                = 0
open("/opt/kde/lib/libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libICE.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2606\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=99757, ...}) = 0
old_mmap(NULL, 97168, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41326000
old_mmap(0x4133b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0x4133b000
old_mmap(0x4133c000, 7056, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4133c000
close(3)                                = 0
open("/opt/kde/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0@\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=85581, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4133e000
old_mmap(NULL, 335044, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4133f000
old_mmap(0x4134d000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd000) = 0x4134d000
old_mmap(0x4134f000, 269508, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4134f000
close(3)                                = 0
open("/opt/kde/lib/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXrender.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\23"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=33306, ...}) = 0
old_mmap(NULL, 31464, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41391000
old_mmap(0x41398000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x41398000
close(3)                                = 0
open("/opt/kde/lib/libz.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libz.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\27\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=66908, ...}) = 0
old_mmap(NULL, 69632, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41399000
old_mmap(0x413a9000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xf000) = 0x413a9000
close(3)                                = 0
open("/opt/kde/lib/libstdc++.so.5", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libstdc++.so.5", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\261"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=730400, ...}) = 0
old_mmap(NULL, 748768, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x413aa000
old_mmap(0x41445000, 94208, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9b000) = 0x41445000
old_mmap(0x4145c000, 19680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4145c000
close(3)                                = 0
open("/opt/kde/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libm.so.6", O_RDONLY)  = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P3\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=176352, ...}) = 0
old_mmap(NULL, 139424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41461000
old_mmap(0x41482000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x20000) = 0x41482000
close(3)                                = 0
open("/opt/kde/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libc.so.6", O_RDONLY)  = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 U\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1357414, ...}) = 0
old_mmap(NULL, 1166612, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41484000
mprotect(0x4159a000, 27924, PROT_NONE)  = 0
old_mmap(0x4159b000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x116000) = 0x4159b000
old_mmap(0x4159f000, 7444, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4159f000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x415a1000
open("/opt/kde/lib/libGLcore.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libGLcore.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\351\n"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=7132152, ...}) = 0
old_mmap(NULL, 7174120, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x415a2000
old_mmap(0x41c4b000, 110592, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6a9000) = 0x41c4b000
old_mmap(0x41c66000, 79848, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41c66000
close(3)                                = 0
open("/opt/kde/lib/libnvidia-tls.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libnvidia-tls.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\3\0\000"..., 512) = 512
lseek(3, 1304, SEEK_SET)                = 1304
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\2\0\0\0"..., 32) = 32
fstat64(3, {st_mode=S_IFREG|0755, st_size=2352, ...}) = 0
old_mmap(NULL, 5588, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41c7a000
old_mmap(0x41c7b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0x41c7b000
close(3)                                = 0
open("/opt/kde/lib/libXt.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/./libXt.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/qt/lib/libXt.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXt.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\276"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=373599, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41c7c000
old_mmap(NULL, 329308, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x41c7d000
old_mmap(0x41cca000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4d000) = 0x41cca000
old_mmap(0x41ccd000, 1628, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x41ccd000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41cce000
mprotect(0x41c7a000, 4096, PROT_READ|PROT_WRITE) = 0
mprotect(0x41c7a000, 4096, PROT_READ|PROT_EXEC) = 0
mprotect(0x415a2000, 6983680, PROT_READ|PROT_WRITE) = 0
mprotect(0x415a2000, 6983680, PROT_READ|PROT_EXEC) = 0
mprotect(0x4159b000, 4096, PROT_READ)   = 0
mprotect(0x410e6000, 360448, PROT_READ|PROT_WRITE) = 0
mprotect(0x410e6000, 360448, PROT_READ|PROT_EXEC) = 0
munmap(0x408dd000, 105181)              = 0
getrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY, rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
getpid()                                = 2290
uname({sys="Linux", node="dragon", ...}) = 0
rt_sigaction(SIGRTMIN, {0x413478d0, [], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x41346c10, [RTMIN], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x41347920, [], 0}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfb6fd74, 40, (nil), 0}) = 0
brk(0)                                  = 0x8058000
brk(0x8079000)                          = 0x8079000
open("/dev/zero", O_RDWR)               = 3
old_mmap(NULL, 1024, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x408dd000
close(3)                                = 0
getpid()                                = 2290
old_mmap(NULL, 671744, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41ccf000
getpid()                                = 2290
modify_ldt(17, {entry_number:0, base_addr:0x80583b8, limit:512, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:0, seg_not_present:0, useable:1}, 16) = 0
getcwd("/home/juhl", 4096)              = 11
fork()                                  = 2291
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++



-- 
Jesper Juhl


