Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263968AbUDQM45 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 08:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbUDQM45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 08:56:57 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:10254 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id S263968AbUDQM4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 08:56:46 -0400
From: Kimmo Sundqvist <musher@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: modprobe 3c509 segfaults
Date: Sat, 17 Apr 2004 15:54:29 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404171554.29419.musher@mbnet.fi>
X-OriginalArrivalTime: 17 Apr 2004 12:56:44.0734 (UTC) FILETIME=[6FBB4DE0:01C4247B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some googling, and found that this problem has existed since 
2.6.0-test10.  To reawaken interest, and to possibly help in solving it, I 
decided to load my generous 2 cents into this message and see what happens.

I'm using kernel 2.6.4.  The machine has a flawlessly working and configured 
HFC-PCI ISDN (hisax type=35), and a Adaptec AHA152x SCSI card.

My problem is with a Gentoo system.  The same machine has a Debian system with 
vanilla kernel 2.4.22 that works flawlessly.

uname -a says:

Linux shadowgate 2.6.4 #3 Fri Apr 16 18:12:54 EEST 2004 i586 Pentium 75 - 200 
GenuineIntel GNU/Linux

I have reserved IRQs 5, 9 and 11 for Legacy ISA.  The Adaptec card uses IRQ 
11, IO 0x340, SCSI ID 7.

The machine has two 3c509 NICs, one with BNC and AUI, at IRQ 9, 0x210, and 
another with only RJ-45, at IRQ 5 and 0x300.

Apr 17 01:38:02 shadowgate eth0: 3c5x9 found at 0x210, BNC port, address  00 
20 af 49 a3 61, IRQ 12.
Apr 17 01:38:02 shadowgate 3c509.c:1.19b 08Nov2002 becker@scyld.com
Apr 17 01:38:02 shadowgate http://www.scyld.com/network/3c509.html
Apr 17 01:38:02 shadowgate Unable to handle kernel NULL pointer dereference at 
virtual address 0000001c
Apr 17 01:38:02 shadowgate printing eip:
Apr 17 01:38:02 shadowgate c58c2789
Apr 17 01:38:02 shadowgate *pde = 00000000
Apr 17 01:38:02 shadowgate Oops: 0002 [#1]
Apr 17 01:38:02 shadowgate PREEMPT 
Apr 17 01:38:02 shadowgate CPU:    0
Apr 17 01:38:02 shadowgate EIP:    0060:[<c58c2789>]    Not tainted
Apr 17 01:38:02 shadowgate EFLAGS: 00010202
Apr 17 01:38:02 shadowgate EIP is at el3_init_module+0x49/0x8c [3c509]
Apr 17 01:38:02 shadowgate eax: 00000000   ebx: c0297d30   ecx: c0297e9c   
edx: 00000005
Apr 17 01:38:02 shadowgate esi: c3c8e000   edi: c58ec980   ebp: c0297d18   
esp: c3c8ffac
Apr 17 01:38:02 shadowgate ds: 007b   es: 007b   ss: 0068
Apr 17 01:38:02 shadowgate Process modprobe (pid: 2503, threadinfo=c3c8e000 
task=c1124080)
Apr 17 01:38:02 shadowgate Stack: c012ed98 0806a5c0 00004487 08057100 c3c8e000 
c0108d37 0806a5c0 00004487 
Apr 17 01:38:02 shadowgate 08057110 00004487 08057100 bffffa08 00000080 
0000007b 0000007b 00000080 
Apr 17 01:38:02 shadowgate 400e328e 00000073 00000246 bffff9dc 0000007b 
Apr 17 01:38:02 shadowgate Call Trace:
Apr 17 01:38:02 shadowgate [<c012ed98>] sys_init_module+0xf8/0x220
Apr 17 01:38:02 shadowgate [<c0108d37>] syscall_call+0x7/0xb
Apr 17 01:38:02 shadowgate 
Apr 17 01:38:02 shadowgate Code: 89 50 1c a1 00 cd 8e c5 8b 14 85 40 c9 8e c5 
85 d2 78 14 8a 

The above listing is when I tried to load the 3c509 driver at boot-up and 
force one card to use IRQ 9 with "3c509 irq=9" in 
Gentoo's /etc/modules.autoload.d/kernel-2.6

The listing below is after I removed 3c509 from autoload.

Apr 17 14:30:57 shadowgate login(pam_unix)[3126]: session opened for user root 
by (uid=0)
Apr 17 14:32:10 shadowgate found reiserfs format "3.6" with standard journal
Apr 17 14:32:11 shadowgate Reiserfs journal params: device hda7, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
Apr 17 14:32:11 shadowgate reiserfs: checking transaction log (hda7) for 
(hda7)
Apr 17 14:32:11 shadowgate Using r5 hash to sort names
Apr 17 14:32:29 shadowgate init: Switching to runlevel: 6
Apr 17 14:33:04 shadowgate syslog-ng[2947]: syslog-ng version 1.6.0rc3 going 
down
Apr 17 19:57:43 shadowgate syslog-ng[2947]: syslog-ng version 1.6.0rc3 
starting
Apr 17 19:57:43 shadowgate syslog-ng[2947]: Changing permissions on special 
file /dev/tty12
Apr 17 19:57:44 shadowgate Linux version 2.6.4 (root@miau) (gcc version 3.3.2 
20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #3 Fri Apr 16 18:12:54 
EEST 2004
Apr 17 19:57:44 shadowgate BIOS-provided physical RAM map:
Apr 17 19:57:44 shadowgate BIOS-e820: 0000000000000000 - 00000000000a0000 
(usable)
Apr 17 19:57:44 shadowgate BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Apr 17 19:57:44 shadowgate BIOS-e820: 0000000000100000 - 0000000004000000 
(usable)
Apr 17 19:57:44 shadowgate BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Apr 17 19:57:44 shadowgate 64MB LOWMEM available.
Apr 17 19:57:44 shadowgate On node 0 totalpages: 16384
Apr 17 19:57:44 shadowgate DMA zone: 4096 pages, LIFO batch:1
Apr 17 19:57:44 shadowgate Normal zone: 12288 pages, LIFO batch:3
Apr 17 19:57:44 shadowgate HighMem zone: 0 pages, LIFO batch:1
Apr 17 19:57:44 shadowgate DMI 2.1 present.
Apr 17 19:57:44 shadowgate ACPI disabled because your bios is from 98 and too 
old
Apr 17 19:57:44 shadowgate You can enable it with acpi=force
Apr 17 19:57:44 shadowgate Built 1 zonelists
Apr 17 19:57:44 shadowgate Kernel command line: auto BOOT_IMAGE=Gentoo rw 
root=301
Apr 17 19:57:44 shadowgate No local APIC present or hardware disabled
Apr 17 19:57:44 shadowgate Initializing CPU#0
Apr 17 19:57:44 shadowgate PID hash table entries: 512 (order 9: 4096 bytes)
Apr 17 19:57:44 shadowgate Detected 132.958 MHz processor.
Apr 17 19:57:44 shadowgate Using tsc for high-res timesource
Apr 17 19:57:44 shadowgate Console: colour VGA+ 80x25
Apr 17 19:57:44 shadowgate Memory: 62088k/65536k available (1409k kernel code, 
2968k reserved, 424k data, 320k init, 0k highmem)
Apr 17 19:57:44 shadowgate Checking if this processor honours the WP bit even 
in supervisor mode... Ok.
Apr 17 19:57:44 shadowgate Calibrating delay loop... 261.63 BogoMIPS
Apr 17 19:57:44 shadowgate Dentry cache hash table entries: 8192 (order: 3, 
32768 bytes)
Apr 17 19:57:44 shadowgate Inode-cache hash table entries: 4096 (order: 2, 
16384 bytes)
Apr 17 19:57:44 shadowgate Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Apr 17 19:57:44 shadowgate CPU:     After generic identify, caps: 000001bf 
00000000 00000000 00000000
Apr 17 19:57:44 shadowgate CPU:     After vendor identify, caps: 000001bf 
00000000 00000000 00000000
Apr 17 19:57:44 shadowgate Intel Pentium with F0 0F bug - workaround enabled.
Apr 17 19:57:44 shadowgate CPU:     After all inits, caps: 000001bf 00000000 
00000000 00000000
Apr 17 19:57:44 shadowgate CPU: Intel Pentium 75 - 200 stepping 0b
Apr 17 19:57:44 shadowgate Checking 'hlt' instruction... OK.
Apr 17 19:57:44 shadowgate POSIX conformance testing by UNIFIX
Apr 17 19:57:44 shadowgate NET: Registered protocol family 16
Apr 17 19:57:44 shadowgate PCI: PCI BIOS revision 2.10 entry at 0xfb150, last 
bus=0
Apr 17 19:57:44 shadowgate PCI: Using configuration type 1
Apr 17 19:57:44 shadowgate Linux Plug and Play Support v0.97 (c) Adam Belay
Apr 17 19:57:44 shadowgate pnp: the driver 'system' has been registered
Apr 17 19:57:44 shadowgate PnPBIOS: Scanning system for PnP BIOS support...
Apr 17 19:57:44 shadowgate PnPBIOS: Found PnP BIOS installation structure at 
0xc00fbca0
Apr 17 19:57:44 shadowgate PnPBIOS: PnP BIOS version 1.0, entry 
0xf0000:0xbcc8, dseg 0xf0000
Apr 17 19:57:44 shadowgate pnp: match found with the PnP device '00:07' and 
the driver 'system'
Apr 17 19:57:44 shadowgate pnp: match found with the PnP device '00:08' and 
the driver 'system'
Apr 17 19:57:44 shadowgate pnp: match found with the PnP device '00:0a' and 
the driver 'system'
Apr 17 19:57:44 shadowgate pnp: 00:0a: ioport range 0x26e-0x26f has been 
reserved
Apr 17 19:57:44 shadowgate PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded 
by driver
Apr 17 19:57:44 shadowgate PCI: Probing PCI hardware
Apr 17 19:57:44 shadowgate PCI: Probing PCI hardware (bus 00)
Apr 17 19:57:44 shadowgate PCI: Using IRQ router PIIX/ICH [8086/7000] at 
0000:00:07.0
Apr 17 19:57:44 shadowgate PCI: Found IRQ 10 for device 0000:00:0b.0
Apr 17 19:57:44 shadowgate matroxfb: Matrox Millennium II (PCI) detected
Apr 17 19:57:44 shadowgate matroxfb: 640x480x8bpp (virtual: 640x65536)
Apr 17 19:57:44 shadowgate matroxfb: framebuffer at 0xE0000000, mapped to 
0xc4805000, size 4194304
Apr 17 19:57:44 shadowgate fb0: MATROX frame buffer device
Apr 17 19:57:44 shadowgate fb0: initializing hardware
Apr 17 19:57:44 shadowgate devfs: 2004-01-31 Richard Gooch 
(rgooch@atnf.csiro.au)
Apr 17 19:57:44 shadowgate devfs: boot_options: 0x1
Apr 17 19:57:44 shadowgate Initializing Cryptographic API
Apr 17 19:57:44 shadowgate Limiting direct PCI/PCI transfers.
Apr 17 19:57:44 shadowgate Activating ISA DMA hang workarounds.
Apr 17 19:57:44 shadowgate isapnp: Scanning for PnP cards...
Apr 17 19:57:44 shadowgate isapnp: No Plug & Play device found
Apr 17 19:57:44 shadowgate Console: switching to colour frame buffer device 
80x30
Apr 17 19:57:44 shadowgate Real Time Clock Driver v1.12
Apr 17 19:57:44 shadowgate Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Apr 17 19:57:44 shadowgate ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Apr 17 19:57:44 shadowgate PIIX3: IDE controller at PCI slot 0000:00:07.1
Apr 17 19:57:44 shadowgate PIIX3: chipset revision 0
Apr 17 19:57:44 shadowgate PIIX3: not 100% native mode: will probe irqs later
Apr 17 19:57:44 shadowgate ide0: BM-DMA at 0xf000-0xf007, BIOS settings: 
hda:pio, hdb:pio
Apr 17 19:57:44 shadowgate ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: 
hdc:pio, hdd:pio
Apr 17 19:57:44 shadowgate hda: QUANTUM FIREBALL EX3.2A, ATA DISK drive
Apr 17 19:57:44 shadowgate Using anticipatory io scheduler
Apr 17 19:57:44 shadowgate ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 17 19:57:44 shadowgate hda: max request size: 128KiB
Apr 17 19:57:44 shadowgate hda: 6306048 sectors (3228 MB) w/418KiB Cache, 
CHS=6256/16/63, (U)DMA
Apr 17 19:57:44 shadowgate /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 
>
Apr 17 19:57:44 shadowgate Console: switching to colour frame buffer device 
80x30
Apr 17 19:57:44 shadowgate serio: i8042 AUX port at 0x60,0x64 irq 12
Apr 17 19:57:44 shadowgate serio: i8042 KBD port at 0x60,0x64 irq 1
Apr 17 19:57:44 shadowgate input: AT Translated Set 2 keyboard on 
isa0060/serio0
Apr 17 19:57:44 shadowgate NET: Registered protocol family 2
Apr 17 19:57:44 shadowgate IP: routing cache hash table of 512 buckets, 
4Kbytes
Apr 17 19:57:44 shadowgate TCP: Hash tables configured (established 4096 bind 
8192)
Apr 17 19:57:44 shadowgate NET: Registered protocol family 1
Apr 17 19:57:44 shadowgate NET: Registered protocol family 17
Apr 17 19:57:44 shadowgate found reiserfs format "3.6" with standard journal
Apr 17 19:57:44 shadowgate Reiserfs journal params: device hda1, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
Apr 17 19:57:44 shadowgate reiserfs: checking transaction log (hda1) for 
(hda1)
Apr 17 19:57:44 shadowgate Using r5 hash to sort names
Apr 17 19:57:44 shadowgate VFS: Mounted root (reiserfs filesystem).
Apr 17 19:57:44 shadowgate Mounted devfs on /dev
Apr 17 19:57:44 shadowgate Freeing unused kernel memory: 320k freed
Apr 17 19:57:44 shadowgate version 0 swap is no longer supported. Use mkswap 
-v1 /dev/hda6
Apr 17 19:57:44 shadowgate SCSI subsystem initialized
Apr 17 19:57:44 shadowgate aha152x: BIOS test: passed, 1 controller(s) 
configured
Apr 17 19:57:44 shadowgate aha152x: resetting bus...
Apr 17 19:57:44 shadowgate aha152x0: vital data: rev=1, io=0x340 
(0x340/0x340), irq=11, scsiid=7, reconnect=enabled, parity=enabled, 
synchronous=enabled, delay=1000, extended translation=disabled
Apr 17 19:57:44 shadowgate aha152x0: trying software interrupt, ok.
Apr 17 19:57:44 shadowgate scsi0 : Adaptec 152x SCSI driver; $Revision: 2.7 $
Apr 17 19:57:44 shadowgate (scsi0:2:0) Synchronous Data Transfer Request 
period = 236 ns, offset = 8
Apr 17 19:57:44 shadowgate Vendor: TOSHIBA   Model: CD-ROM XM-5301TA  Rev: 
0925
Apr 17 19:57:44 shadowgate Type:   CD-ROM                             ANSI 
SCSI revision: 02
Apr 17 19:57:44 shadowgate sr0: scsi3-mmc drive: 0x/0x caddy
Apr 17 19:57:44 shadowgate Uniform CD-ROM driver Revision: 3.20
Apr 17 19:57:44 shadowgate Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, 
lun 0
Apr 17 19:57:44 shadowgate (scsi0:3:0) Synchronous Data Transfer Request 
period = 236 ns, offset = 8
Apr 17 19:57:44 shadowgate Vendor: TOSHIBA   Model: CD-ROM XM-5301TA  Rev: 
0925
Apr 17 19:57:44 shadowgate Type:   CD-ROM                             ANSI 
SCSI revision: 02
Apr 17 19:57:44 shadowgate sr1: scsi3-mmc drive: 0x/0x caddy
Apr 17 19:57:44 shadowgate Attached scsi CD-ROM sr1 at scsi0, channel 0, id 3, 
lun 0
Apr 17 19:57:44 shadowgate CSLIP: code copyright 1989 Regents of the 
University of California
Apr 17 19:57:44 shadowgate ISDN subsystem Rev: 
1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/none/1.1.2.2 loaded
Apr 17 19:57:44 shadowgate HiSax: Linux Driver for passive ISDN cards
Apr 17 19:57:44 shadowgate HiSax: Version 3.5 (module)
Apr 17 19:57:44 shadowgate HiSax: Layer1 Revision 2.46.2.5
Apr 17 19:57:44 shadowgate HiSax: Layer2 Revision 2.30.2.4
Apr 17 19:57:44 shadowgate HiSax: TeiMgr Revision 2.20.2.3
Apr 17 19:57:44 shadowgate HiSax: Layer3 Revision 2.22.2.3
Apr 17 19:57:44 shadowgate HiSax: LinkLayer Revision 2.59.2.4
Apr 17 19:57:44 shadowgate HiSax: Warning - no protocol specified
Apr 17 19:57:44 shadowgate HiSax: using protocol EURO
Apr 17 19:57:44 shadowgate HiSax: Total 1 card defined
Apr 17 19:57:44 shadowgate HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
Apr 17 19:57:44 shadowgate HiSax: HFC-PCI driver Rev. 1.48.2.4
Apr 17 19:57:44 shadowgate PCI: Found IRQ 12 for device 0000:00:0d.0
Apr 17 19:57:44 shadowgate HiSax: HFC-PCI card manufacturer: Asuscom/Askey 
card name: 675
Apr 17 19:57:44 shadowgate HFC-PCI: defined at mem 0xc58b8000 fifo 0xc3338000
(0x3338000) IRQ 12 HZ 1000
Apr 17 19:57:44 shadowgate HFC 2BDS0 PCI: IRQ 12 count 0
Apr 17 19:57:44 shadowgate HFC_PCI: resetting card
Apr 17 19:57:44 shadowgate HFC 2BDS0 PCI: IRQ 12 count 34
Apr 17 19:57:44 shadowgate HiSax: DSS1 Rev. 2.32.2.3
Apr 17 19:57:44 shadowgate HiSax: 2 channels added
Apr 17 19:57:44 shadowgate HiSax: MAX_WAITING_CALLS added
Apr 17 19:57:44 shadowgate version 0 swap is no longer supported. Use mkswap 
-v1 /dev/hda6
Apr 17 19:57:46 shadowgate rc-scripts: Failed to bring eth0 up
Apr 17 19:57:47 shadowgate rc-scripts: ERROR:  Problem starting needed 
services.
Apr 17 19:57:47 shadowgate rc-scripts:         "netmount" was not started.
Apr 17 19:58:04 shadowgate login(pam_unix)[3125]: session opened for user root 
by (uid=0)
Apr 17 19:58:40 shadowgate eth0: 3c5x9 found at 0x210, BNC port, address  00 
20 af 49 a3 61, IRQ 12.
Apr 17 19:58:40 shadowgate 3c509.c:1.19b 08Nov2002 becker@scyld.com
Apr 17 19:58:40 shadowgate http://www.scyld.com/network/3c509.html

Here I logged in and loaded the module manually.  "modprobe 3c509 irq=9" and 
"modprobe 3c509 irq=9,5" have the same effect.  I left out eth1, which it 
finds correctly at 0x300 and IRQ 5.  If I boot to Debian, kernel 2.4.22, eth0 
is found at IRQ9, 0x210, and functions flawlessly.

The final question is, then, why doesn't the driver accept the irq=9 switch in 
2.6.4 (Gentoo) when it does in 2.4.22 (Debian)?

-Kimmo S.

