Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136607AbREAKww>; Tue, 1 May 2001 06:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136608AbREAKwm>; Tue, 1 May 2001 06:52:42 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:49830 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136607AbREAKwX>; Tue, 1 May 2001 06:52:23 -0400
Message-ID: <3AEE9491.D0C4C366@home.com>
Date: Tue, 01 May 2001 03:48:49 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DISCOVERED! Cause of Athlon/VIA KX133 Instability
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so the subject is an attention-getter :).

Peep this, homies:

Hi,

  I've been doing some research, trying to figure out why the VIA/Athlon
is exhibiting weird behavior under K7 optimizations.  The jist of my 
research is that compiling a kernel for ANY CPU with the Athlon MMX
optimization
*AND* 3DNOW results in massive amounts of oops'es and total system
instability.  The following is what I've tried:

  [1] Selected Athlon as CPU in .config, then commenting out (#if 0) 
      the mmx code optimized for the athlon (as was stated is the only
      main k7 opt).  The resulting kernel is stable.  enabling/disabling
      other options have no effect on stability.

  [2] Experimented with choosing K6-(III) optimized kernel, but
modifying
      the arch/i386/config.in to sequentially add to the K6 section all
the
      options in the K7 section (i.e. GOOD_APIC, USE_3DNOW,
L1_CACHE_SHIFT
      difference, and PGE).  So far, the only anomolay I've found is
that
      when I add USE_3DNOW to the K6 section and reboot, KDE hangs when
      I click on any button in my launch bar (vanilla KDE 2.0).  It
      does NOT hang the system, though.  Restarting Xwindows does not
help,
      but changing the WM to TWM allows me to run netscape (which was
one
      of the buttons that hund X in KDE in the launch bar). Weird,
right?
      Enabling paging extensions (CONFIG_X86_PGE) appears to have
      no effect on stability.

  [3] When I add 3DNOW to any option in [2] w/ the Athlon MMX opt,
      the instability is evident after root is mounted and startup
      scripts begin executing.  Sometimes the system can make it through
      other times it cannot.

Athlon 900 (990) Thunderbird
IWILL KK-266 M/B
256MB PC100 RAM
Promise Ultra66 IDE
SB Live
GeForce 256 (AGP)

My info (dmesg):
================
Linux version 2.4.4 (root@c1162825-a) (gcc version 2.95.3 20010315
(release)) #6 SMP Sun Apr 29 04:31:06 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01444000)
Kernel command line: BOOT_IMAGE=LInux ro root=302
Initializing CPU#0
Detected 993.350 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1979.18 BogoMIPS
Memory: 255644k/262080k available (846k kernel code, 6048k reserved,
334k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU0: AMD Athlon(tm) Processor stepping 02
per-CPU timeslice cutoff: 731.63 usecs.
SMP motherboard not detected. Using dummy APIC emulation.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA PCI latency patch.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169848kB/56616kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20262: IDE controller on PCI bus 00 dev 68
PCI: Found IRQ 10 for device 00:0d.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:DMA, hdh:DMA
hda: WDC WD400BB-00AUA1, ATA DISK drive
hdb: WDC WD400BB-32AUA1, ATA DISK drive
hdc: CREATIVE DVD-ROM DVD6240E, ATAPI CD/DVD-ROM drive
hdd: KENWOOD CD-ROM UCR-421 V212G, ATAPI CD/DVD-ROM drive
hde: Maxtor 91024U4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd400-0xd407,0xd802 on irq 10
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
UDMA(100)
hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
UDMA(100)
hde: 19999728 sectors (10240 MB) w/2048KiB Cache, CHS=19841/16/63,
UDMA(66)
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 68X CD-ROM drive, 512kB Cache, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 >
 hdb: hdb1
 hde: [PTBL] [1244/255/63] hde1 < hde5 hde6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:0e.0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:C8:E4:E9, IRQ
11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 668081-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x3c15c8f1).
  Receiver lock-up workaround activated.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,64)
 

/proc/cpuinfo
=============
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 993.350
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1979.18

==================

  Please let me know if you have any other insights.  I was planning on
now investigating WHY MMX/K7 + 3DNOW is causing this.

  Thanks,
  Seth
