Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVF0JiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVF0JiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVF0JiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:38:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3533 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261655AbVF0JhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:37:21 -0400
Date: Mon, 27 Jun 2005 11:37:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2
Message-ID: <20050627093708.GA23150@elte.hu>
References: <fa.h6rvsi4.j68fhk@ifi.uio.no> <42BFA05B.1090208@reub.net> <20050627002429.40231fdf.akpm@osdl.org> <42BFAF1F.8050201@reub.net> <20050627012226.450bc86d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050627012226.450bc86d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


is the fput()/sysfs_release() crash below known?

	Ingo 

Linux version 2.6.12-mm2 (mingo@jupiter) (gcc version 3.4.1 20040831 (Red Hat 3.4.1-10)) #11 SMP Mon Jun 27 11:19:41 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
256MB LOWMEM available.
found SMP MP-table at 000f5b30
On node 0 totalpages: 65536
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61440 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
early console enabled
DMI 2.2 present.
ABIT i440BX-W83977 detected: force use of acpi=ht
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:6 APIC version 17
Processor #1 6:6 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 10000000 (gap: 10000000:eec00000)
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
Kernel command line: root=/dev/hda1 debug earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 console=tty0 3 maxcpus=2 nmi_watchdog=1 debug profile=0
kernel profiling enabled (shift: 0)
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 467.796 MHz processor.
Using tsc for high-res timesource
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 244664k/262144k available (2592k kernel code, 17052k reserved, 1061k data, 224k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 937.21 BogoMIPS (lpj=1874423)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps: 0183fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Celeron (Mendocino) stepping 05
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 935.62 BogoMIPS (lpj=1871246)
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps: 0183fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Celeron (Mendocino) stepping 05
Total of 2 processors activated (1872.83 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
checking TSC synchronization across 2 CPUs: passed.
softlockup thread 0 started up.
Brought up 2 CPUs
softlockup thread 1 started up.
-> [0][1][  65536]   0.3 [  0.3] (0): (  357620   178810)
-> [0][1][  68985]   0.3 [  0.3] (0): (  354253    91088)
-> [0][1][  72615]   0.3 [  0.3] (0): (  390935    63885)
-> [0][1][  76436]   0.4 [  0.4] (0): (  415617    44283)
-> [0][1][  80458]   0.4 [  0.4] (0): (  428850    28758)
-> [0][1][  84692]   0.4 [  0.4] (0): (  460558    30233)
-> [0][1][  89149]   0.5 [  0.5] (0): (  501929    35802)
-> [0][1][  93841]   0.5 [  0.5] (0): (  543036    38454)
-> [0][1][  98780]   0.6 [  0.6] (0): (  609270    52344)
-> [0][1][ 103978]   0.5 [  0.6] (0): (  596005    32804)
-> [0][1][ 109450]   0.6 [  0.6] (0): (  607209    22004)
-> [0][1][ 115210]   0.6 [  0.6] (0): (  643212    29003)
-> [0][1][ 121273]   0.7 [  0.7] (0): (  716535    51163)
-> [0][1][ 127655]   0.7 [  0.7] (0): (  795865    65246)
-> [0][1][ 134373]   0.7 [  0.7] (0): (  745335    57888)
-> [0][1][ 141445]   0.7 [  0.7] (0): (  796304    54428)
-> [0][1][ 148889]   0.8 [  0.8] (0): (  820203    39163)
-> [0][1][ 156725]   0.7 [  0.8] (0): (  716504    71431)
-> [0][1][ 164973]   0.6 [  0.8] (0): (  679884    54025)
-> [0][1][ 173655]   0.6 [  0.8] (0): (  662305    35802)
-> [0][1][ 182794]   0.5 [  0.8] (0): (  598857    49625)
-> [0][1][ 192414]   0.6 [  0.8] (0): (  628063    39415)
-> [0][1][ 202541]   0.5 [  0.8] (0): (  577476    45001)
-> found max.
[0][1] working set size found: 148889, cost: 820203
---------------------
| migration cost matrix (max_cache_size: 131072, cpu: 467 MHz):
---------------------
          [00]    [01]
[00]:     -     1.6(0)
[01]:   1.6(0)    -   
--------------------------------
| cacheflush times [1]: 1.6 (1640406)
| calibration delay: 0 seconds
--------------------------------
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050309
ACPI: Interpreter disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
PCI->APIC IRQ transform: 0000:00:07.2[D] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:0d.0[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:0f.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:13.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:13.1[B] -> IRQ 18
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
Machine check exception polling timer started.
inotify device minor=63
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
Real Time Clock Driver v1.12
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
cn_fork is registered
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Intel(R) PRO/1000 Network Driver - version 6.0.54-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
e100: eth1: e100_probe: addr 0xef140000, irq 16, MAC addr 00:90:27:8C:A0:50
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: QUANTUM FIREBALLP LM20.5, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QUANTUM FIREBALL SE4.3A, ATA DISK drive
hdd: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 40132503 sectors (20547 MB) w/1900KiB Cache, CHS=39813/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1
hdc: max request size: 128KiB
hdc: 8418816 sectors (4310 MB) w/80KiB Cache, CHS=14848/9/63, UDMA(33)
hdc: cache flushes not supported
 hdc: hdc1 hdc2
libata version 1.11 loaded.
USB Universal Host Controller Interface driver v2.3
uhci_hcd 0000:00:07.2: Intel Corporation 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 19, io base 0x0000b000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
md: raid1 personality registered as nr 3
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP: routing cache hash table of 512 buckets, 12Kbytes
TCP established hash table entries: 16384 (order: 6, 393216 bytes)
TCP bind hash table entries: 16384 (order: 6, 327680 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (2048 buckets, 16384 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
Starting balanced_irq
Using IPI Shortcut mode
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Unable to handle kernel paging request at virtual address 6b6b6ceb
 printing eip:
c018b51c
*pde = 00000000
Oops: 0002 [#1]
SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c018b51c>]    Not tainted VLI
EFLAGS: 00010206   (2.6.12-mm2) 
EIP is at sysfs_release+0x3f/0x79
eax: 6b6b6beb   ebx: 6b6b6b6b   ecx: ce5b5e64   edx: 00000000
esi: cf266ca4   edi: cfa3a544   ebp: ce635f50   esp: ce635f44
ds: 007b   es: 007b   ss: 0068
Process udev (pid: 1286, threadinfo=ce634000 task=c1fe6040)
Stack: 00000010 c1ca8b78 c1d4656c ce635f74 c01580b2 00000000 cf399e10 cf399e10 
       ce5b5e64 c1d4656c c1cb275c 00000000 ce635f84 c0157f36 c1cb275c c1d4656c 
       ce635f9c c0156873 00000004 00000004 c1cb275c c1cb2760 ce635fb4 c015690a 
Call Trace:
 [<c0103a18>] show_stack+0x7c/0x92
 [<c0103b99>] show_registers+0x152/0x1ca
 [<c0103d96>] die+0xf4/0x16f
 [<c011433f>] do_page_fault+0x466/0x684
 [<c0103683>] error_code+0x4f/0x54
 [<c01580b2>] __fput+0x176/0x1a9
 [<c0157f36>] fput+0x3b/0x41
 [<c0156873>] filp_close+0x36/0x65
 [<c015690a>] sys_close+0x68/0x83
 [<c0102b13>] sysenter_past_esp+0x54/0x75
Code: 58 8b 70 14 8b 41 58 8b 40 14 85 f6 8b 58 04 74 07 89 f0 e8 8b 22 05 00 85 db 74 1a b8 00 e0 ff ff 21 e0 8b 40 10 c1 e0 07 01 d8 <ff> 88 00 01 00 00 83 3b 02 74 22 85 ff 74 0e 8b 47 0c 85 c0 75 
 
