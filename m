Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUJDHLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUJDHLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 03:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268487AbUJDHLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 03:11:47 -0400
Received: from vs-kg003.ocn.ad.jp ([210.232.239.81]:34754 "EHLO
	vs-kg003.ocn.ad.jp") by vger.kernel.org with ESMTP id S268490AbUJDHKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 03:10:48 -0400
From: Jason Stubbs <jstubbs@work-at.co.jp>
Organization: Work@ Inc
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Consistent lock up on >=2.6.8
Date: Mon, 4 Oct 2004 16:11:16 +0900
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041611.17000.jstubbs@work-at.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting consistent hangs under heavy load on 2.6.8.1, 2.6.9-rc2 and 
2.6.9-rc3. I have tested on 2.6.7 and have no problems at all. I can 
reproduce the problem in less than 10 minutes by repeatedly running a cpu 
intensive process such as openssl while the system performs its regular 
tasks.

SysRq works and I was able to pull the registers (which are always very 
similar) and the last 50 lines of the task list. If more of the task list is 
necessary, I'll go out and buy a serial cable to get it. All information 
provided is from 2.6.9-rc3.

Regards,
Jason Stubbs


========================================

Pid: 22433, comm:              openssl
EIP: 0060:[<c02d5082>] CPU: 0
EIP is at _spin_lock+0xa/0x13
 EFLAGS: 00000286    Not tainted  (2.6.9-rc3)
EAX: c03b2500 EBX: 00000000 ECX: x031ca80 EDX: 00000000
ESI: f8b9c926 EDI: ffffffff EBP: c03e1f44 DS: 007b ES: 007b
CR0: 8005003b CR2: b7df91df CR3: 3705c000 CR4: 000006d0
Stack pointer is garbage, not printing trace


========================================

 [<c0103f9d>] sysenter_past_esp+0x52/0x71
snmpget       S C16BBBE0     0 21951  21949                     (NOTLB)
f77beea0 00000086 c031d300 c16bbbe0 00000000 c031cf80 f71c3e80 00000000
       f77beea0 c01347f5 f75e65b8 f7733000 00000000 f7056550 00000000 c180f980
       c180f020 00000000 00000a88 1c644845 000001cc f7733000 f7733158 00000000
Call Trace:
 [<c02d4c8d>] schedule_timeout+0x62/0xb2
 [<c015c1e9>] do_select+0x15b/0x268
 [<c015c585>] sys_select+0x272/0x44e
 [<c0103f9d>] sysenter_past_esp+0x52/0x71
snmpget       S C16835E0     0 22135  16187                     (NOTLB)
f70d5ea0 00000082 c031d300 c16835e0 00000000 c031cf80 f7176a80 00000000
       f70d5ea0 c01347f5 f75e65b8 f70d4aa0 00000000 f7056550 00000000 c180f980
       c180f020 00000000 00000930 13e1f69b 000001cc f70d4aa0 f70d4bf8 00000000
Call Trace:
 [<c02d4c8d>] schedule_timeout+0x62/0xb2
 [<c02d4c8d>] schedule_timeout+0x62/0xb2
 [<c015c1e9>] do_select+0x15b/0x268
 [<c015c585>] sys_select+0x272/0x44e
 [<c0103f9d>] sysenter_past_esp+0x52/0x71
php           S F7098E80     0 22260  25252 22262               (NOTLB)
f7098ed0 00000086 00000000 f7098e80 c013053a c0112066 00000000 00000001
       f7098ebc e1146440 000001cb c013ce75 00000fe4 f70d4550 00000000 c180f980
       c180f020 00000000 0001d32f e5d96f7e 000001cb f7094aa0 f7094bf8 00000000
Call Trace:
 [<c0155fd7>] pipe_wait+0x73/0x94
 [<c0156167>] pipe_readv+0x16f/0x24e
 [<c0156265>] pipe_read+0x1f/0x23
 [<c014b5f8>] vfs_read+0x9d/0xeb
 [<c014b836>] sys_read+0x41/0x6b
 [<c0103f9d>] sysenter_past_esp+0x52/0x71
snmpget       S C1687140     0 22262  22260                     (NOTLB)
c193fea0 00000086 c031d300 c1987140 00000000 c031cf80 f70c4680 00000000
       c193fea0 c01347f5 f75e65b8 f78bcaa0 00000000 f6bf0000 00000000 c180f980
       c180f020 00000000 000009e2 28d13b27 000001cc f89bcaa0 f78bcbf8 00000000
Call Trace:
 [<c02d4c8d>] schedule_timeout+0x62/0xb2
 [<c015c1e9>] do_select+0x15b/0x268
 [<c015c585>] sys_select+0x272/0x44e
 [<c0103f9d>] sysenter_past_esp+0x52/0x71
snmpget       S C1682F80     0 22374  19389                     (NOTLB)
f6586ea0 00000086 c031d300 c1682f80 00000000 c031cf80 f7173580 00000000
       f6586ea0 c01347f5 c03a9118 f78739a0 c03a9100 f7056550 00000000 c180f980
       c180f020 00000000 0018823e 28e9bd65 000001cc f6bf0000 f6bf0158 00000000
Call Trace:
 [<c02d4c8d>] schedule_timeout+0x62/0xb2
 [<c015c1e9>] do_select+0x15b/0x268
 [<c015c585>] sys_select+0x272/0x44e
 [<c0103f9d>] sysenter_past_esp+0x52/0x71
openssl       R running     0 22433  9913                      (NOTLB)


========================================

root@mail linux # sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mail 2.6.9-rc3 #2 SMP Mon Oct 4 15:14:39 JST 2004 i686 Intel(R) Xeon(TM) 
CPU 2.40GHz GenuineIntel GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.17
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ip_vs_nq ip_vs


========================================


root@mail linux # dmesg
Linux version 2.6.9-rc3 (root@mail) (gcc version 3.3.3 20040412 (Gentoo Linux 
3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #2 SMP Mon Oct 4 15:14:39 JST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec03000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f6620
ACPI: RSDT (v001 A M I  OEMRSDT  0x03000425 MSFT 0x00000097) @ 0x3fff0000
ACPI: FADT (v002 A M I  OEMFACP  0x03000425 MSFT 0x00000097) @ 0x3fff0200
ACPI: SSDT (v001 OEM_ID OEMTBLID 0x00000001 MSFT 0x0100000d) @ 0x3fff6590
ACPI: MADT (v001 A M I  OEMAPIC  0x03000425 MSFT 0x00000097) @ 0x3fff0300
ACPI: SPCR (v001 A M I  OEMSPCR  0x03000425 MSFT 0x00000097) @ 0x3fff0400
ACPI: DSDT (v001    RCC     GCSL 0x00000100 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: DL140        APIC at: 0xFEE00000
I/O APIC #1 Version 17 at 0xFEC00000.
I/O APIC #2 Version 17 at 0xFEC01000.
I/O APIC #3 Version 17 at 0xFEC02000.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: root=/dev/hda2 vga=1 pci=noacpi
Initializing CPU#0
CPU 0 irqstacks, hard=c03e5000 soft=c03e3000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2400.182 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035516k/1048512k available (1885k kernel code, 12360k reserved, 885k 
data, 160k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4718.59 BogoMIPS (lpj=2359296)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
per-CPU timeslice cutoff: 1462.38 usecs.
task migration cache decay timeout: 2 msecs.
Total of 1 processors activated (4718.59 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
PCI: Discovered peer bus 02
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0203] at 0000:00:0f.0
PCI->APIC IRQ transform: (B0,I15,P0) -> 26
PCI->APIC IRQ transform: (B2,I0,P0) -> 19
PCI->APIC IRQ transform: (B2,I0,P1) -> 18
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
loop: loaded (max 8 devices)
tg3.c:v3.10 (September 14, 2004)
eth0: Tigon3 [partno(BCM95704A6) rev 2002 PHY(5704)] (PCIX:133MHz:64-bit) 
10/100/1000BaseT Ethernet 00:0f:20:7a:3d:a1
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0]
eth1: Tigon3 [partno(BCM95704A6) rev 2002 PHY(5704)] (PCIX:133MHz:64-bit) 
10/100/1000BaseT Ethernet 00:0f:20:7a:3d:a2
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST380011A, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CD-224E, ATAPI CD/DVD-ROM drive
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
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: max request size: 128KiB
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 /dev/ide/host0/bus0/target1/lun0: p1 p2
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:0f.2: ServerWorks CSB6 OHCI USB Controller
ohci_hcd 0000:00:0f.2: irq 26, pci mem f8812000
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 
18,max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: replayed 6 transactions in 0 seconds
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
Adding 1092380k swap on /dev/hdb1.  Priority:-1 extents:1
md: raidstart(pid 4458) used deprecated START_ARRAY ioctl. This will not be 
supported beyond 2.6
md: autorun ...
md: considering hdb2 ...
md:  adding hdb2 ...
md:  adding hda3 ...
md: created md0
md: bind<hda3>
md: bind<hdb2>
md: running: <hdb2><hda3>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdb2
raid0:   comparing hdb2(77055680) with hdb2(77055680)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hda3
raid0:   comparing hda3(77055680) with hdb2(77055680)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 154111360 blocks.
raid0 : conf->hash_spacing is 154111360 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: ... autorun DONE.
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 
18,max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: replayed 1 transactions in 0 seconds
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using ordered data mode
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first block 
18,max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
ReiserFS: dm-2: replayed 16 transactions in 0 seconds
ReiserFS: dm-2: Using r5 hash to sort names
ReiserFS: dm-2: Removing [7729 178057 0x0 SD]..done
ReiserFS: dm-2: There were 1 uncompleted unlinks/truncates. Completed
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 
18,max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: replayed 75 transactions in 0 seconds
ReiserFS: dm-1: Using r5 hash to sort names
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
process `named' is using obsolete setsockopt SO_BSDCOMPAT
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
tg3: eth1: Link is up at 100 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.
IPVS: Registered protocols (TCP, UDP, AH, ESP)
IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
IPVS: ipvs loaded.
IPVS: [nq] scheduler registered.
process `snmpd' is using obsolete setsockopt SO_BSDCOMPAT
process `snmpget' is using obsolete setsockopt SO_BSDCOMPAT


========================================

root@mail linux # cat /proc/modules
ip_vs_nq 1920 2 - Live 0xf8b8d000
ip_vs 78400 4 ip_vs_nq, Live 0xf8b9a000


========================================

root@mail proc # ps ax
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:00 init [3]
    2 ?        SW     0:00 [migration/0]
    3 ?        SWN    0:00 [ksoftirqd/0]
    4 ?        SW<    0:00 [events/0]
    5 ?        SW<    0:00 [khelper]
    6 ?        SW<    0:00 [kblockd/0]
    7 ?        SW     0:00 [khubd]
   31 ?        SW     0:00 [pdflush]
   32 ?        SW     0:00 [pdflush]
   34 ?        SW<    0:00 [aio/0]
   33 ?        SW     0:00 [kswapd0]
  104 ?        SW     0:00 [kseriod]
  138 ?        SW<    0:00 [reiserfs/0]
  267 ?        S      0:00 /sbin/devfsd /dev
 5978 ?        S      0:00 /usr/sbin/syslog-ng
 6519 ?        S      0:00 /usr/sbin/named -u named -n 2
 6537 ?        S      0:00 /bin/sh /usr/bin/mysqld_safe
 6669 ?        S      0:00 /usr/sbin/mysqld --basedir=/usr 
--datadir=/var/lib/mysql --user=mysql --pid-file=/var/run/mysqld/mysqld.pid 
--skip-locking --port=3306 --socket=/var/ru
 6673 ?        S      0:00 /usr/sbin/sshd
 6688 ?        S      0:00 /usr/sbin/apache2 -k start -D PHP4 -D SSL
 6785 ?        S      0:00 /usr/sbin/keepalived -d
 6786 ?        S      0:00 /usr/sbin/keepalived -d
 6788 ?        S      0:00 /usr/sbin/keepalived -d
 6956 ?        S      0:00 /usr/sbin/apache2 -k start -D PHP4 -D SSL
 6989 ?        S      0:00 /sbin/portmap
 6992 ?        S      0:00 /usr/sbin/apache2 -k start -D PHP4 -D SSL
 6993 ?        S      0:00 /usr/sbin/apache2 -k start -D PHP4 -D SSL
 6994 ?        S      0:00 /usr/sbin/apache2 -k start -D PHP4 -D SSL
 6995 ?        S      0:00 /usr/sbin/apache2 -k start -D PHP4 -D SSL
 6996 ?        S      0:00 /usr/sbin/apache2 -k start -D PHP4 -D SSL
 7006 ?        S      0:00 /sbin/rpc.statd
 7014 ?        SW     0:00 [nfsd]
 7015 ?        SW     0:00 [nfsd]
 7016 ?        SW     0:00 [nfsd]
 7017 ?        SW     0:00 [nfsd]
 7018 ?        SW     0:00 [nfsd]
 7019 ?        SW     0:00 [nfsd]
 7020 ?        SW     0:00 [nfsd]
 7021 ?        SW     0:00 [nfsd]
 7022 ?        SW     0:00 [lockd]
 7023 ?        SW     0:00 [rpciod]
 7027 ?        S      0:00 /usr/sbin/rpc.mountd
 7081 ?        SL     0:00 /usr/bin/ntpd -p /var/run/ntpd.pid -u ntp:ntp
 7178 ?        S      0:00 /usr/lib/postfix/master
 7193 ?        S      0:00 pickup -l -t fifo -u
 7194 ?        S      0:00 qmgr -l -t fifo -u
 7236 ?        S      0:00 /usr/sbin/snmpd -p /var/run/snmpd.pid
 7316 ?        S      0:00 /usr/sbin/cron
 7372 ?        S      0:00 /usr/sbin/xinetd -pidfile /var/run/xinetd.pid 
-stayalive -reuse
 7393 tty1     S      0:00 /sbin/agetty 38400 tty1 linux
 7394 tty2     S      0:00 /sbin/agetty 38400 tty2 linux
 7395 tty3     S      0:00 /sbin/agetty 38400 tty3 linux
 7396 tty4     S      0:00 /sbin/agetty 38400 tty4 linux
 7397 tty5     S      0:00 /sbin/agetty 38400 tty5 linux
 7398 tty6     S      0:00 /sbin/agetty 38400 tty6 linux
 7443 ?        S      0:00 /usr/bin/ntpd -p /var/run/ntpd.pid -u ntp:ntp
 7483 ?        S      0:00 /USR/SBIN/CRON
 7484 ?        S      0:00 /bin/bash -c 
php /var/www/localhost/htdocs/cacti/cmd.php > /dev/null 2>&1
 7487 ?        S      0:00 php /var/www/localhost/htdocs/cacti/cmd.php
 7547 ?        S      0:00 sshd: kanri [priv]
 7555 ?        S      0:00 sshd: kanri@pts/0
 7556 pts/0    S      0:00 -bash
 7564 pts/0    S      0:00 su
 7566 pts/0    S      0:00 bash
 7998 ?        S      0:00 /USR/SBIN/CRON
 7999 ?        S      0:00 /bin/bash -c 
php /var/www/localhost/htdocs/cacti/cmd.php > /dev/null 2>&1
 8000 ?        S      0:00 php /var/www/localhost/htdocs/cacti/cmd.php
 8262 ?        S      0:00 /USR/SBIN/CRON
 8263 ?        S      0:00 /bin/bash -c 
php /var/www/localhost/htdocs/cacti/cmd.php > /dev/null 2>&1
 8276 ?        S      0:00 php /var/www/localhost/htdocs/cacti/cmd.php
 8632 ?        S      0:00 /USR/SBIN/CRON
 8633 ?        S      0:00 /bin/bash -c 
php /var/www/localhost/htdocs/cacti/cmd.php > /dev/null 2>&1
 8634 ?        S      0:00 php /var/www/localhost/htdocs/cacti/cmd.php
 9973 ?        S      0:00 /USR/SBIN/CRON
 9974 ?        S      0:00 /bin/bash -c 
php /var/www/localhost/htdocs/cacti/cmd.php > /dev/null 2>&1
 9981 ?        S      0:00 php /var/www/localhost/htdocs/cacti/cmd.php
10041 ?        S      0:00 /usr/bin/snmpget -O vt -c        -v 2c -t 1 
172.16.1.14:161 .1.3.6.1.4.1.2021.10.1.3.3
10042 ?        S      0:00 /usr/bin/snmpget -O vt -c        -v 2c -t 1 
172.16.1.21:161 .1.3.6.1.4.1.2021.10.1.3.1
10043 ?        S      0:00 /usr/bin/php 
-q /var/www/localhost/htdocs/cacti/scripts/query_host_partitions.php 
172.16.1.19 public 2 get used 3
10044 ?        S      0:00 /usr/bin/php 
-q /var/www/localhost/htdocs/cacti/scripts/query_host_partitions.php 
172.16.1.11 public 2 get used 4
10046 ?        S      0:00 /usr/bin/snmpget -O vt -c        -v 2c -t 1 
172.16.1.11:161 .1.3.6.1.2.1.25.2.3.1.6.4
10048 ?        S      0:00 /usr/bin/snmpget -O vt -c        -v 2c -t 1 
172.16.1.19:161 .1.3.6.1.2.1.25.2.3.1.6.3
10049 ?        S      0:00 /usr/bin/snmpget -O vt -c        -v 2c -t 1 
172.16.1.19:161 .1.3.6.1.4.1.2021.11.50.0
10050 pts/0    R      0:00 ps ax


========================================

root@mail linux # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 9
cpu MHz         : 2400.182
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmovpat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4718.59


========================================

root@mail linux # lspci -vvv
0000:00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort-<MAbort- >SERR- <PERR-

0000:00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort-<MAbort- >SERR- <PERR-

0000:00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
(prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 001e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 10
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) 
[size=fe9c0000]
        Region 1: I/O ports at e800 [size=256]
        Region 2: Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 ISA bridge: ServerWorks CSB6 South Bridge (rev a0)
        Subsystem: ServerWorks: Unknown device 0201
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

0000:00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0) 
(prog-if 8a [Master SecP PriP])
        Subsystem: ServerWorks: Unknown device 0212
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ffa0 [size=16]

0000:00:0f.2 USB Controller: ServerWorks CSB6 OHCI USB Controller (rev 05) 
(prog-if 10 [OHCI])
        Subsystem: ServerWorks: Unknown device 0220
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 26
        Region 0: Memory at fe9fe000 (32-bit, non-prefetchable)

0000:00:0f.3 Host bridge: ServerWorks GCLE-2 Host Bridge
        Subsystem: ServerWorks: Unknown device 0230
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:10.0 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit Ethernet 
(rev 12)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
0000:00:10.2 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit Ethernet 
(rev 12)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 
Gigabit Ethernet (rev 02)
        Subsystem: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at febc0000 (64-bit, non-prefetchable)
        Region 2: Memory at febb0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 
Enable-
                Address: 0400002019000000  Data: 0000

0000:02:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 
Gigabit Ethernet (rev 02)
        Subsystem: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin B routed to IRQ 18
        Region 0: Memory at febf0000 (64-bit, non-prefetchable)
        Region 2: Memory at febe0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 
Enable-
                Address: 0104110000000000  Data: 0004


========================================

root@mail linux # cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
e800-e8ff : 0000:00:03.0
ffa0-ffaf : 0000:00:0f.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1


========================================

root@mail linux # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002d741a : Kernel code
  002d741b-003b48ff : Kernel data
3fff0000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
fd000000-fdffffff : 0000:00:03.0
fe9fe000-fe9fefff : 0000:00:0f.2
  fe9fe000-fe9fefff : ohci_hcd
fe9ff000-fe9fffff : 0000:00:03.0
febb0000-febbffff : 0000:02:00.0
  febb0000-febbffff : tg3
febc0000-febcffff : 0000:02:00.0
  febc0000-febcffff : tg3
febe0000-febeffff : 0000:02:00.1
  febe0000-febeffff : tg3
febf0000-febfffff : 0000:02:00.1
  febf0000-febfffff : tg3
fec00000-fec02fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved


========================================

root@mail proc # zcat /proc/config.gz | grep '^CONFIG'
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_SHMEM=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y
CONFIG_PM=y
CONFIG_ACPI_BOOT=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_TABLE=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_STANDALONE=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_VS=m
CONFIG_IP_VS_TAB_BITS=12
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
CONFIG_IP_VS_FTP=m
CONFIG_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NETDEVICES=y
CONFIG_TIGON3=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_EXT2_FS=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_UTF8=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y
