Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSJDGrF>; Fri, 4 Oct 2002 02:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSJDGrF>; Fri, 4 Oct 2002 02:47:05 -0400
Received: from web40602.mail.yahoo.com ([66.218.78.139]:38752 "HELO
	web40602.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261456AbSJDGq4>; Fri, 4 Oct 2002 02:46:56 -0400
Message-ID: <20021004065223.24159.qmail@web40602.mail.yahoo.com>
Date: Fri, 4 Oct 2002 08:52:23 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Kernel 2.5.40 DMA and mm issues
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Desccription of the problems:
1.Problems at DMA initialization. See dmesg.
2.After doing a compilation or an updatedb the system
 become unresponsive for some periods of time while 
the cpu is 100% system. Also there is little free
 memory. If i kill the updatedb the system come back 
to normal. However the memory is not freed. The cache
 is too small to explain the "missing" memory. After
the updatedb (or big compilation) has been running
 for some time,if i issue a simple command on a
 terminal (like ps axuf) it takes a couple of 
seconds to complete, while the system is not 
loaded (the only running tasks are updatedb -- 
or big compilation -- and top).
Here are the top outputs. The last one is when i
killed
the updatedb script.

30 processes: 28 sleeping, 2 running, 0 zombie, 0
stopped
CPU states:  0.1% user, 99.8% system,  0.0% nice, 
0.0% idle
Mem:   125576K av,  121556K used,    4020K free,      
0K shrd,   20984K buff
Swap:  248968K av,    2988K used,  245980K free       
           25064K cached

  PID  NI  SIZE STAT %CPU %MEM COMMAND
 3454   0  1436 R    99.8  0.4 /usr/bin/find / (
-fstype nfs -o -fstype NFS -o -fstype proc -o -type d
-regex \(^/tmp$\)\|\(^/usr/t
    3   0     0 SW    0.1  0.0 keventd
    1   0   452 S     0.0  0.0 init
    2  19     0 SWN   0.0  0.0 ksoftirqd_CPU0
    4   0     0 SW    0.0  0.0 kswapd0
    5   0     0 SW    0.0  0.0 pdflush
    6   0     0 SW    0.0  0.0 pdflush
    7   0     0 SW    0.0  0.0 jfsIO
    8   0     0 SW    0.0  0.0 jfsCommit
    9   0     0 SW    0.0  0.0 jfsSync
   10   0     0 SW    0.0  0.0 kseriod
   14   0  1328 S     0.0  0.3 /sbin/devfsd /dev
   57   0  1852 S     0.0  0.4 /usr/sbin/syslogd
   62   0  1824 S     0.0  0.3 /usr/sbin/inetd
   68   0  1412 S     0.0  0.3 /usr/sbin/klogd -c 3
   69   0  1880 S     0.0  0.3 /usr/sbin/lpd
   74   0  1420 S     0.0  0.4 /usr/sbin/crond -l8
   80   0  2956 S     0.0  0.6 sendmail: accepting
connections
   87   0  1328 S     0.0  0.3 gpm -m /dev/psaux -t
ps2
   97   0  2568 S     0.0  0.9 -bash
   98   0  2560 S     0.0  0.8 -bash
   99   0  2564 S     0.0  0.7 -bash
  100   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty4
linux
  101   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty5
linux
  102   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty6
linux
 3443   0  1068 S     0.0  0.3 /bin/sh
/usr/bin/updatedb
 3451   0  1068 S     0.0  0.3 /bin/sh
/usr/bin/updatedb
 3452   0  2372 S     0.0  1.0 sort -f
 3453   0  1276 S     0.0  0.2 /usr/libexec/frcode
 3491   0  1800 R     0.0  0.7 top b n 5

30 processes: 28 sleeping, 2 running, 0 zombie, 0
stopped
CPU states:  0.0% user, 100.0% system,  0.0% nice, 
0.0% idle
Mem:   125576K av,  121564K used,    4012K free,      
0K shrd,   20984K buff
Swap:  248968K av,    2988K used,  245980K free       
           25064K cached

  PID  NI  SIZE STAT %CPU %MEM COMMAND
 3454   0  1436 R    99.8  0.4 /usr/bin/find / (
-fstype nfs -o -fstype NFS -o -fstype proc -o -type d
-regex \(^/tmp$\)\|\(^/usr/t
 3491   0  1800 R     0.3  0.7 top b n 5
    1   0   452 S     0.0  0.0 init
    2  19     0 SWN   0.0  0.0 ksoftirqd_CPU0
    3   0     0 SW    0.0  0.0 keventd
    4   0     0 SW    0.0  0.0 kswapd0
    5   0     0 SW    0.0  0.0 pdflush
    6   0     0 SW    0.0  0.0 pdflush
    7   0     0 SW    0.0  0.0 jfsIO
    8   0     0 SW    0.0  0.0 jfsCommit
    9   0     0 SW    0.0  0.0 jfsSync
   10   0     0 SW    0.0  0.0 kseriod
   14   0  1328 S     0.0  0.3 /sbin/devfsd /dev
   57   0  1852 S     0.0  0.4 /usr/sbin/syslogd
   62   0  1824 S     0.0  0.3 /usr/sbin/inetd
   68   0  1412 S     0.0  0.3 /usr/sbin/klogd -c 3
   69   0  1880 S     0.0  0.3 /usr/sbin/lpd
   74   0  1420 S     0.0  0.4 /usr/sbin/crond -l8
   80   0  2956 S     0.0  0.6 sendmail: accepting
connections
   87   0  1328 S     0.0  0.3 gpm -m /dev/psaux -t
ps2
   97   0  2568 S     0.0  0.9 -bash
   98   0  2560 S     0.0  0.8 -bash
   99   0  2564 S     0.0  0.7 -bash
  100   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty4
linux
  101   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty5
linux
  102   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty6
linux
 3443   0  1068 S     0.0  0.3 /bin/sh
/usr/bin/updatedb
 3451   0  1068 S     0.0  0.3 /bin/sh
/usr/bin/updatedb
 3452   0  2372 S     0.0  1.0 sort -f
 3453   0  1276 S     0.0  0.2 /usr/libexec/frcode

30 processes: 28 sleeping, 2 running, 0 zombie, 0
stopped
CPU states:  0.0% user, 100.0% system,  0.0% nice, 
0.0% idle
Mem:   125576K av,  121588K used,    3988K free,      
0K shrd,   20988K buff
Swap:  248968K av,    2988K used,  245980K free       
           25068K cached

  PID  NI  SIZE STAT %CPU %MEM COMMAND
 3454   0  1436 R    99.6  0.4 /usr/bin/find / (
-fstype nfs -o -fstype NFS -o -fstype proc -o -type d
-regex \(^/tmp$\)\|\(^/usr/t
    1   0   452 S     0.0  0.0 init
    2  19     0 SWN   0.0  0.0 ksoftirqd_CPU0
    3   0     0 SW    0.0  0.0 keventd
    4   0     0 SW    0.0  0.0 kswapd0
    5   0     0 SW    0.0  0.0 pdflush
    6   0     0 SW    0.0  0.0 pdflush
    7   0     0 SW    0.0  0.0 jfsIO
    8   0     0 SW    0.0  0.0 jfsCommit
    9   0     0 SW    0.0  0.0 jfsSync
   10   0     0 SW    0.0  0.0 kseriod
   14   0  1328 S     0.0  0.3 /sbin/devfsd /dev
   57   0  1852 S     0.0  0.4 /usr/sbin/syslogd
   62   0  1824 S     0.0  0.3 /usr/sbin/inetd
   68   0  1412 S     0.0  0.3 /usr/sbin/klogd -c 3
   69   0  1880 S     0.0  0.3 /usr/sbin/lpd
   74   0  1420 S     0.0  0.4 /usr/sbin/crond -l8
   80   0  2956 S     0.0  0.6 sendmail: accepting
connections
   87   0  1328 S     0.0  0.3 gpm -m /dev/psaux -t
ps2
   97   0  2576 S     0.0  0.9 -bash
   98   0  2560 S     0.0  0.8 -bash
   99   0  2564 S     0.0  0.7 -bash
  100   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty4
linux
  101   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty5
linux
  102   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty6
linux
 3443   0  1068 S     0.0  0.3 /bin/sh
/usr/bin/updatedb
 3451   0  1068 S     0.0  0.3 /bin/sh
/usr/bin/updatedb
 3452   0  2372 S     0.0  1.0 sort -f
 3453   0  1276 S     0.0  0.2 /usr/libexec/frcode
 3491   0  1800 R     0.0  0.7 top b n 5

30 processes: 28 sleeping, 2 running, 0 zombie, 0
stopped
CPU states:  0.1% user, 99.8% system,  0.0% nice, 
0.0% idle
Mem:   125576K av,  121596K used,    3980K free,      
0K shrd,   20988K buff
Swap:  248968K av,    2988K used,  245980K free       
           25068K cached

  PID  NI  SIZE STAT %CPU %MEM COMMAND
 3454   0  1436 R    99.8  0.4 /usr/bin/find / (
-fstype nfs -o -fstype NFS -o -fstype proc -o -type d
-regex \(^/tmp$\)\|\(^/usr/t
 3491   0  1800 R     0.1  0.7 top b n 5
    1   0   452 S     0.0  0.0 init
    2  19     0 SWN   0.0  0.0 ksoftirqd_CPU0
    3   0     0 SW    0.0  0.0 keventd
    4   0     0 SW    0.0  0.0 kswapd0
    5   0     0 SW    0.0  0.0 pdflush
    6   0     0 SW    0.0  0.0 pdflush
    7   0     0 SW    0.0  0.0 jfsIO
    8   0     0 SW    0.0  0.0 jfsCommit
    9   0     0 SW    0.0  0.0 jfsSync
   10   0     0 SW    0.0  0.0 kseriod
   14   0  1328 S     0.0  0.3 /sbin/devfsd /dev
   57   0  1852 S     0.0  0.4 /usr/sbin/syslogd
   62   0  1824 S     0.0  0.3 /usr/sbin/inetd
   68   0  1412 S     0.0  0.3 /usr/sbin/klogd -c 3
   69   0  1880 S     0.0  0.3 /usr/sbin/lpd
   74   0  1420 S     0.0  0.4 /usr/sbin/crond -l8
   80   0  2956 S     0.0  0.6 sendmail: accepting
connections
   87   0  1328 S     0.0  0.3 gpm -m /dev/psaux -t
ps2
   97   0  2576 S     0.0  0.9 -bash
   98   0  2560 S     0.0  0.8 -bash
   99   0  2564 S     0.0  0.7 -bash
  100   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty4
linux
  101   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty5
linux
  102   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty6
linux
 3443   0  1068 S     0.0  0.3 /bin/sh
/usr/bin/updatedb
 3451   0  1068 S     0.0  0.3 /bin/sh
/usr/bin/updatedb
 3452   0  2372 S     0.0  1.0 sort -f
 3453   0  1276 S     0.0  0.2 /usr/libexec/frcode


25 processes: 24 sleeping, 1 running, 0 zombie, 0
stopped
CPU states: 10.2% user, 22.3% system,  0.0% nice,
67.4% idle
Mem:   125576K av,  120080K used,    5496K free,      
0K shrd,   21044K buff
Swap:  248968K av,    2076K used,  246892K free       
           25096K cached

  PID  NI  SIZE STAT %CPU %MEM COMMAND
 3501   0  1796 R     0.9  0.7 top b n 1
    1   0   452 S     0.0  0.0 init
    2  19     0 SWN   0.0  0.0 ksoftirqd_CPU0
    3   0     0 SW    0.0  0.0 keventd
    4   0     0 SW    0.0  0.0 kswapd0
    5   0     0 SW    0.0  0.0 pdflush
    6   0     0 SW    0.0  0.0 pdflush
    7   0     0 SW    0.0  0.0 jfsIO
    8   0     0 SW    0.0  0.0 jfsCommit
    9   0     0 SW    0.0  0.0 jfsSync
   10   0     0 SW    0.0  0.0 kseriod
   14   0  1328 S     0.0  0.3 /sbin/devfsd /dev
   57   0  1852 S     0.0  0.4 /usr/sbin/syslogd
   62   0  1824 S     0.0  0.3 /usr/sbin/inetd
   68   0  1412 S     0.0  0.3 /usr/sbin/klogd -c 3
   69   0  1880 S     0.0  0.3 /usr/sbin/lpd
   74   0  1420 S     0.0  0.4 /usr/sbin/crond -l8
   80   0  2956 S     0.0  0.6 sendmail: accepting
connections
   87   0  1328 S     0.0  0.3 gpm -m /dev/psaux -t
ps2
   97   0  2576 S     0.0  0.9 -bash
   98   0  2560 S     0.0  0.8 -bash
   99   0  2564 S     0.0  0.8 -bash
  100   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty4
linux
  101   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty5
linux
  102   0  1288 S     0.0  0.3 /sbin/agetty 38400 tty6
linux

Here is /proc/meminfo after killing the updatedb:
MemTotal:       125576 kB
MemFree:          5540 kB
MemShared:           0 kB
Buffers:         21092 kB
Cached:          25124 kB
SwapCached:       1888 kB
Active:          15388 kB
Inactive:        33268 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       125576 kB
LowFree:          5540 kB
SwapTotal:      248968 kB
SwapFree:       246892 kB
Dirty:              64 kB
Writeback:           0 kB
Mapped:           2512 kB
Slab:            69712 kB
Committed_AS:     3348 kB
PageTables:        192 kB
ReverseMaps:      2314

Info about my system:

Glibc 2.2.4 
gcc --version
2.95.3
make --version
GNU Make version 3.79.1, by Richard Stallman and
Roland McGrath.
Built for i386-slackware-linux-gnu
ld -v
GNU ld version 2.11.93.0.2 20020207
fdformat --version
fdformat from util-linux-2.11u
insmod -V
insmod version 2.4.20
tune2fs
tune2fs 1.25 (20-Sep-2001)
/sbin/fsck.jfs -V
fsck.jfs version 1.0.21, 12-Aug-2002

Dmesg:

Linux version 2.5.40 (root@grinch) (gcc version 2.95.3
20010315 (release)) #3 Thu Oct 3 00:37:23 EEST 2002
Video mode to be used for restore is 309
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000
(usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI
NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI
data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000
(reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages
  Normal zone: 28656 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 VIA694                     ) @
0x000f7060
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @
0x07ff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @
0x07ff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @
0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=k2540 ro root=301
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 700.102 MHz processor.
Console: colour VGA+ 132x25
Calibrating delay loop... 1372.16 BogoMIPS
Memory: 125276k/131008k available (1948k kernel code,
5344k reserved, 720k data, 300k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 16384 (order: 5,
131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536
bytes)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff
00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64
bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU:     After generic, caps: 0183fbff c1c7fbff
00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff
00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0952 MHz.
..... host bus clock speed is 199.0986 MHz.
cpu: 0, clocks: 199986, slice: 99993
CPU0<T0:199984,T1:99984,D:7,S:99993,C:199986>
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb380, last
bus=1
adding '' to cpu class interfaces
ACPI: Subsystem revision 20020918
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables
successfully loaded
Parsing
Methods:.....................................................................
Table [DSDT] - 307 Objects with 30 Devices 69 Methods
21 Regions
ACPI Namespace successfully loaded at root c042139c
evxfevnt-0074 [04] Acpi_enable           : Transition
to ACPI mode successful
Executing all Device _STA and_INI
methods:..............................
30 Devices found containing: 30 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package
initialization:.........................................
Initialized 17/21 Regions 1/1 Fields 15/15 Buffers 8/8
Packages (307 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev
02): [55] 81 & 1f -> 01
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
pci_bind-0191 [04] acpi_pci_bind         : Device
00:00:07.06 not present in PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10
*11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10
11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10
11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10
11 12 14 15, disabled)
isapnp: Scanning for PnP cards...
isapnp: Card 'Crystal Codec'
isapnp: 1 Plug & Play card detected total
PnPBIOS: Found PnP BIOS installation structure at
0xc00fbdf0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbe20,
dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by
driver
PnPBIOS: PNP0c02: ioport range 0x208-0x20f has been
reserved
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option
'pci=noacpi' or even 'acpi=off'
spurious 8259A interrupt: IRQ7.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: overridden by ACPI.
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 242 entries (12 bytes)
biovec pool[1]:   4 bvecs: 242 entries (48 bytes)
biovec pool[2]:  16 bvecs: 242 entries (192 bytes)
biovec pool[3]:  64 bvecs: 242 entries (768 bytes)
biovec pool[4]: 128 bvecs: 121 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  60 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
devfs: v1.21 (20020820) Richard Gooch
(rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
Capability LSM initialized
PCI: Disabling Via external APIC routing
PCI: Via IRQ fixup for 00:07.2, from 0 to 11
PCI: Via IRQ fixup for 00:07.3, from 255 to 11
ACPI: Power Button (FF) [PWRF]
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ
sharing disabled
tts/%d0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/%d1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x3bc (0x7bc) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x3BC
pty: 512 Unix98 ptys configured
lp0: using parport0 (polling).
lp0: console ready
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory:
94M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 128M @ 0xd0000000
agpgart: Oops, don't init more than one agpgart
device.
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller
on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings:
hdc:DMA, hdd:pio
hda: ST36421A, ATA DISK drive
hda: DMA disabled
Debug: sleeping function called from illegal context
at slab.c:1374
c1167ea8 c0116674 c02f2b80 c02f7090 0000055e 00000000
c01312a6 c02f7090 
       0000055e c0440834 c04407fc c7f963a4 00000000
0000000e c03e9c80 c010b5ca 
       c0223477 c7f1c4f8 000001d0 c04407fc c04407ec
c7f963a4 00000000 00000000 
Call Trace:
 [<c0116674>]__might_sleep+0x54/0x60
 [<c01312a6>]kmem_cache_alloc+0x26/0x1e0
 [<c010b5ca>]startup_8259A_irq+0xa/0x10
 [<c0223477>]blk_init_free_list+0x47/0xd0
 [<c022350d>]blk_init_queue+0xd/0xf0
 [<c0230ec8>]ide_init_queue+0x28/0x70
 [<c0237560>]do_ide_request+0x0/0x20
 [<c023119d>]init_irq+0x28d/0x350
 [<c0231516>]hwif_init+0x106/0x250
 [<c0230dec>]probe_hwif_init+0x1c/0x70
 [<c02418ed>]ide_setup_pci_device+0x3d/0x70
 [<c010508f>]init+0x2f/0x180
 [<c0105060>]init+0x0/0x180
 [<c01054f5>]kernel_thread_helper+0x5/0x10

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY CDU4811, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
Debug: sleeping function called from illegal context
at slab.c:1374
c1167ea8 c0116674 c02f2b80 c02f7090 0000055e 00000000
c01312a6 c02f7090 
       0000055e c0440e0c c0440dd4 c7f9646c 00000000
0000000f c03e9cc0 c010b5ca 
       c0223477 c7f1c4f8 000001d0 c0440dd4 c0440dc4
c7f9646c 00000000 00000000 
Call Trace:
 [<c0116674>]__might_sleep+0x54/0x60
 [<c01312a6>]kmem_cache_alloc+0x26/0x1e0
 [<c010b5ca>]startup_8259A_irq+0xa/0x10
 [<c0223477>]blk_init_free_list+0x47/0xd0
 [<c022350d>]blk_init_queue+0xd/0xf0
 [<c0230ec8>]ide_init_queue+0x28/0x70
 [<c0237560>]do_ide_request+0x0/0x20
 [<c023119d>]init_irq+0x28d/0x350
 [<c0231516>]hwif_init+0x106/0x250
 [<c0230dec>]probe_hwif_init+0x1c/0x70
 [<c0241911>]ide_setup_pci_device+0x61/0x70
 [<c010508f>]init+0x2f/0x180
 [<c0105060>]init+0x0/0x180
 [<c01054f5>]kernel_thread_helper+0x5/0x10

ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 12596850 sectors (6450 MB) w/256KiB Cache,
CHS=784/255/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 > p4
 p4: <bsd: p6 p7 >
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
<Crystal audio controller (CS4239)> at 0x534 irq 9 dma
1,3
ad1848: Interrupt test failed (IRQ9)
ad1848/cs4248 codec driver Copyright (C) by Hannu
Savolainen 1993-1996
ad1848: No ISAPnP cards found, trying standard ones...
Via 686a audio driver 1.9.1
ac97_codec: AC97 Audio codec, id: 0x414c:0x4325
(Unknown)
via82cxxx: Codec rate locked at 48Khz
via82cxxx: board #1 at 0xDC00, IRQ 10
Advanced Linux Sound Architecture Driver Version
0.9.0rc2 (Mon Aug 05 14:24:05 2002 UTC).
can't register device seq
specify snd_port
isapnp detection failed and probing for CS4236+ is not
supported
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind
8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
You didn't specify the type of your ufs filesystem

mount -t ufs -o
ufstype=sun|sunx86|44bsd|old|hp|nextstep|netxstep-cd|openstep
...

>>>WARNING<<< Wrong ufstype may corrupt your
filesystem, default is ufstype=old
ufs_read_super: bad magic number
UDF-fs DEBUG lowlevel.c:65:udf_get_last_session:
CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG super.c:1476:udf_fill_super:
Multi-session=0
UDF-fs DEBUG super.c:461:udf_vrs: Starting at sector
16 (2048 byte sectors)
UDF-fs: No VRS found
VFS: Mounted root (jfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 300k freed
Adding 248968k swap on /dev/hda5.  Priority:-1
extents:1
mtrr: illegal type: "write-combining"

Kernel config:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_LOLAT=y
CONFIG_LOLAT_SYSCTL=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=512
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_REISERFS_FS=m
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_FS_INFLATE=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_VIA82CXXX=y
CONFIG_MIDI_VIA82CXXX=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_CS4232=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

Bye
Calin


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
