Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSGNKQN>; Sun, 14 Jul 2002 06:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315754AbSGNKQM>; Sun, 14 Jul 2002 06:16:12 -0400
Received: from surf.viawest.net ([216.87.64.26]:51855 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S315734AbSGNKQI>;
	Sun, 14 Jul 2002 06:16:08 -0400
Date: Sun, 14 Jul 2002 03:18:54 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714101854.GA1068@wizard.com>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com> <20020714100509.B25887@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020714100509.B25887@ucw.cz>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.25 (i686)
X-uptime: 3:03am  up 3 min,  2 users,  load average: 0.14, 0.16, 0.06
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 10:05:09AM +0200, Vojtech Pavlik wrote:
> 
> Unfortunately this doesn't list interrupts, which happened, but are no
> longer claimed by any driver - and the i8042 driver frees the interrupt
> when it detects no device.

        Interesting.. it detects it, as per dmesg below, but then it frees 
it.. really interesting..

> >         From the above part of .config, IRQ1 should be set for the keyboard, 
> > while IRQ 12 for the AUX port. 12 is set, 1 is not. dmesg shows:
> > 
> > mice: PS/2 mouse device common for all mice
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> 
> So it detected both the KBD and AUX ports properly, but for some reason
> it couldn't identify the attached keyboard.
> 
> Can you #define ATKBD_DEBUG in drivers/input/keyboard/atkbd.c? 
> Then you'll see what happened in' dmesg'.

        Just did. dmesg follows:

Linux version 2.5.25-dj2 (root@bellicha) (gcc version 2.95.3 20010315 (release)) #1 Sun Jul 14 01:50:09 PDT 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000001fff0000 (usable)
 user: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 user: 000000001fff3000 - 0000000020000000 (ACPI data)
 user: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=unix ro root=301 ether=0,0,0,eth0 ether=0,0,0,eth1 mem=512m devfs=mount video=aty128fb:mode:1280x1024,font:SUN12x22
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1133.510 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2228.22 BogoMIPS
Memory: 516620k/524224k available (1183k kernel code, 7216k reserved, 345k data, 244k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1133.0164 MHz.
..... host bus clock speed is 266.0626 MHz.
cpu: 0, clocks: 266626, slice: 133313
CPU0<T0:266624,T1:133296,D:15,S:133313,C:266626>
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb440, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
spurious 8259A interrupt: IRQ7.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
devfs: v1.17 (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
aty128fb: Rage128 BIOS located at segment C00C0000
aty128fb: Rage128 Pro TF (AGP) [chip rev 0x4] 32M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 80x30
fb0: ATY Rage128 frame buffer device on PCI
aty128fb: Rage128 MTRR set to ON
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xd0000000 64MB
[drm] Initialized r128 2.2.0 20010917 on minor 0
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xd0000000 64MB
[drm] Initialized radeon 1.3.1 20020611 on minor 1
block: 256 slots per queue, batch=32
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: VIA Technologies, Inc. Bus Master IDE, PCI slot 00:07.1
ATA: chipset rev.: 6
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c686b (rev 40) ATA UDMA100 controller on PCI 00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 91531U3, DISK drive
hdb: WDC WD200AB-00BVA0, DISK drive
hdc: CD-W54E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 30015216 sectors w/512KiB Cache, CHS=29777/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [1868/255/63] p1 p2 p3 p4 < p5 p6 p7 p8 >
 hdb: 39102336 sectors w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
 /dev/ide/host0/bus0/target1/lun0: [PTBL] [2434/255/63] p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 >
mice: PS/2 mouse device common for all mice
atkbd.c: Sent: f5
atkbd.c: Received fe
serio: i8042 KBD port at 0x60,0x64 irq 1
input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
.
.
.
.
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 00:08.0
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:90:27:10:08:1C, IRQ 10.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 689661-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
parport0: PC-style at 0x278, irq 5 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).

> Most likely you have a somewhat unusual keyboard - it may be responding
> too slow perhaps, so that the driver times out - or doesn't support some
> of the commands the driver expects to use.
> 
> Or the mouse kills the keyboard. This also can happen - they share
> common resources. This would need more debugging then.
> 
> So, what's the keyboard, what's the mouse, and what's the mainboard
> exactly? 

        I've tried this with 3 different keyboards, 3 different mice, and 3 
combinations of each: wireless 104-key ps/2 keyboard. PS/2 cord from the box 
to the keyboard base, actual keyboard is wireless. bought it 4 years ago; 
104-key keybord (w/power, sleep, and wake keys) bought 3 weeks ago, 104-key 
acer keyboard from a P100 from 7 years ago. all 3 mice are PS/2 mice; Acer 
mouse to go along with the Acer box and Acer keyboard, Microsoft PS/2 mouse, 
and MS Optical wheel mouse. The Acer and MS PS/2 mouse are straight PS/2. The 
optical is IMPS/2. motherboard is a Tyan S2390B, VIA82c686b chipset. 

        All 9 different combinations gave the same result. Mouse working, 
keyboard not working.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

