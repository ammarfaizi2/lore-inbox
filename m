Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTKKPpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbTKKPpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:45:45 -0500
Received: from reptilian.maxnet.nu ([212.209.142.131]:5124 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S263574AbTKKPp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:45:27 -0500
From: Thomas Habets <thomas@habets.pp.se>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Memory leak in -test9?
Date: Tue, 11 Nov 2003 16:36:57 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_L1277H11VHILYKVMBJ4W"
Message-Id: <E1AJahk-00011D-00@reptilian.maxnet.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_L1277H11VHILYKVMBJ4W
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

(I'm not on the list. CC any replies)

[2.]
There seems to be a memory leak in 2.6.0-test9. Before I go on I'll mention 
that the box is running Debian sarge (testing), and the compiler is gcc 3.3.1.

A lot of memory is used (and eventually it will crash), but very little is in 
cache or buffers. After shutting down zebra, postgresql, snmp and apache this 
is what the system looked like. Notice the Slab-size in /proc/meminfo. I 
don't know what slab is, but it's getting bigger... I think. It's not that 
big after reboot anyway.
The memory gets used up after a few days of uptime, and when all memory is 
used, the box eventually becomes unresponsive due to excessive swap use. Note 
that this box doesn't do anything (almost). It's a workstation that's not in 
use. It has the above mentioned daemons running (but unused) and also sshs 
every 5 minutes to another box for mrtg graph stats. (rsa keys)

/proc/config.gz attached.

/proc/sysvipc/{sem,shm,msg} are empty.

I'll leave it running in case you want more info, but it will fill up all mem 
and crash in a few days if it does what some other -test? did.

Sorry if it just looks like it will do the same, and this is all just normal 
behavior.

[3.] 
Memory leak, slab

[4.]
Linux version 2.6.0-test9 (andy@rex) (gcc version 3.3.1 20030626 (Debian 
prerelease)) #4 Tue Oct 28 15:12:18 CET 2003


[7.1]
$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux rex 2.6.0-test9 #4 Tue Oct 28 15:12:18 CET 2003 i686 GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.13-pre
e2fsprogs              1.34-WIP
nfs-utils              1.0.3
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         twofish serpent aes blowfish sha256 dummy 8139too mii 
crc32

[7.2.] Processor information (from /proc/cpuinfo):
$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 467.898
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 923.64

[7.3.] Module information (from /proc/modules):
$ cat /proc/modules
twofish 38752 0 - Live 0xcc89d000
serpent 13600 0 - Live 0xcc880000
aes 31616 0 - Live 0xcc886000
blowfish 9824 0 - Live 0xcc87c000
sha256 13888 0 - Live 0xcc877000
dummy 1924 0 - Live 0xcc869000
8139too 24320 0 - Live 0xcc870000
mii 5152 1 8139too, Live 0xcc864000
crc32 4320 1 8139too, Live 0xcc861000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
$ cat /proc/ioports /proc/iomem 
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : ISAPnP
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : 0000:00:07.3
5000-501f : 0000:00:07.3
d000-dfff : PCI Bus #01
e000-e01f : 0000:00:07.2
  e000-e01f : uhci_hcd
e400-e4ff : 0000:00:08.0
e800-e8ff : 0000:00:0b.0
  e800-e8ff : 8139too
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0bfeffff : System RAM
  00100000-00490e26 : Kernel code
  00490e27-005a08bf : Kernel data
0bff0000-0bff2fff : ACPI Non-volatile Storage
0bff3000-0bffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e5ffffff : PCI Bus #01
  e4000000-e4ffffff : 0000:01:00.0
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : 0000:01:00.0
e7000000-e7ffffff : 0000:00:08.0
ea000000-ea0000ff : 0000:00:0b.0
  ea000000-ea0000ff : 8139too
ea001000-ea001fff : 0000:00:08.0
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
That's a lot, and I doubt it would help. Ask if you need it.

[7.6.] SCSI information (from /proc/scsi/scsi)
No SCSI

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

$ uptime
 00:51:38 up 6 days, 11:54,  5 users,  load average: 0.02, 0.02, 0.00


$ free -m
             total       used       free     shared    buffers     cached
Mem:           184        168         15          0          7         12
 -/+ buffers/cache:        148         35
Swap:          243         74        168

(these two commands were run a day after the above mentioned daemons were shut 
off:
       RSS
   $ ps uax | awk '{ foo+= $6 } END{print foo}'
   36380
   $ free -m
                total       used       free     shared    buffers     cached
Mem:           184        168         16          0          3         11
- -/+ buffers/cache:        153         31
Swap:          243         87        155
now back to yesterdays /proc/meminfo)


$ cat /proc/meminfo 
MemTotal:       189240 kB
MemFree:         16208 kB
Buffers:          7536 kB
Cached:          12940 kB
SwapCached:      18400 kB
Active:          22316 kB
Inactive:        27176 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       189240 kB
LowFree:         16208 kB
SwapTotal:      248996 kB
SwapFree:       172572 kB
Dirty:             380 kB
Writeback:           0 kB
Mapped:          24460 kB
Slab:           121272 kB
Committed_AS:    89412 kB
PageTables:        744 kB
VmallocTotal:   843720 kB
VmallocUsed:       604 kB
VmallocChunk:   843048 kB

$ ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.2  1212  428 ?        S    Nov04   0:04 init [2]  
root         2  0.0  0.0     0    0 ?        SWN  Nov04   0:00 [ksoftirqd/0]
root         3  0.0  0.0     0    0 ?        SW<  Nov04   0:01 [events/0]
root         4  0.0  0.0     0    0 ?        SW<  Nov04   0:04 [kblockd/0]
root         5  0.0  0.0     0    0 ?        SW   Nov04   0:00 [khubd]
root         6  0.0  0.0     0    0 ?        SW   Nov04   0:00 [kapmd]
root         8  0.0  0.0     0    0 ?        SW   Nov04   0:01 [pdflush]
root         9  0.0  0.0     0    0 ?        SW   Nov04   0:09 [kswapd0]
root        10  0.0  0.0     0    0 ?        SW<  Nov04   0:00 [aio/0]
root        11  0.0  0.0     0    0 ?        SW<  Nov04   0:00 [xfslogd/0]
root        12  0.0  0.0     0    0 ?        SW<  Nov04   0:00 [xfsdatad/0]
root        13  0.0  0.0     0    0 ?        SW   Nov04   0:00 [pagebufd]
root        15  0.0  0.0     0    0 ?        SW   Nov04   0:00 [kseriod]
root        16  0.0  0.0     0    0 ?        SW   Nov04   0:30 [kjournald]
root        30  0.0  0.5  2568  964 ?        S    Nov04   0:00 /sbin/devfsd 
/dev
root       178  0.0  0.2  1408  424 ?        S    Nov04   0:00 dhclient -pf 
/var/run/dhclient.eth0.pid eth0
daemon     189  0.0  0.1  1316  288 ?        S    Nov04   0:00 /sbin/portmap
root       273  0.0  0.2  1296  508 ?        S    Nov04   0:28 /sbin/syslogd
root       279  0.0  0.2  2456  396 ?        S    Nov04   0:00 /sbin/klogd
root       293  0.0  0.2  1240  392 ?        S    Nov04   0:00 /usr/sbin/inetd
root       397  0.0  0.2  2684  492 ?        S    Nov04   0:00 /usr/sbin/sshd
root       400  0.0  0.2  1208  456 ?        S    Nov04   0:00 
/usr/sbin/uptimed
root       407  0.0  0.2  4128  488 ?        S    Nov04   0:00 
/usr/bin/X11/xfs -daemon
root       467  0.0  0.2  2476  428 ?        S    Nov04   0:00 /bin/bash 
/etc/rc2.d/S20xprint posix_sh_forced start
root       469  0.0  0.2  4020  464 ?        S    Nov04   0:00 
/usr/X11R6/bin/Xprt -ac -pn -nolisten tcp -audit 4 -fp 
/usr/X11R6/lib/X11/fonts/Type1,/usr/X11R6/lib/X11/fonts/100dpi,/usr/X11R6/lib
root       470  0.0  0.1  1196  308 ?        S    Nov04   0:00 tee -a 
/dev/null
root       471  0.0  0.1  1200  376 ?        S    Nov04   0:00 logger -p 
lpr.notice -t Xprt_64
root       489  0.0  0.2  1372  464 ?        S    Nov04   0:00 /sbin/rpc.statd
root       493  0.0  1.0  1908 1900 ?        SL   Nov04   0:00 /usr/sbin/ntpd
root       498  0.0  0.1  2952  340 ?        S    Nov04   0:03 
/usr/sbin/arpwatch -N -p
daemon     501  0.0  0.1  1320  220 ?        S    Nov04   0:00 /usr/sbin/atd
root       504  0.0  0.1  1396  324 ?        S    Nov04   0:00 /usr/sbin/cron
root       516  0.0  0.2  2936  432 ?        S    Nov04   0:00 
/usr/bin/X11/xdm
root       517  0.0  0.0  1200  176 tty1     S    Nov04   0:00 /sbin/getty 
38400 tty1
root       518  0.0  0.0  1200  176 tty2     S    Nov04   0:00 /sbin/getty 
38400 tty2
root       519  0.0  0.0  1200  176 tty3     S    Nov04   0:00 /sbin/getty 
38400 tty3
root       520  0.0  0.0  1200  176 tty4     S    Nov04   0:00 /sbin/getty 
38400 tty4
root       521  0.0  0.0  1200  176 tty5     S    Nov04   0:00 /sbin/getty 
38400 tty5
root       522  0.0  0.0  1200  176 tty6     S    Nov04   0:00 /sbin/getty 
38400 tty6
root       529  0.0  0.6 47508 1276 ?        S    Nov04   1:38 
/usr/X11R6/bin/X vt7 -dpi 100 -nolisten tcp -auth 
/var/lib/xdm/authdir/authfiles/A:0-8vgmon
root       531  0.0  0.1  3388  316 ?        S    Nov04   0:00 -:0            
 
root       544  0.7  8.9 51300 16980 ?       S    Nov04  67:24 xconsole 
- -geometry 480x130-0-0 -notify -verbose -fn fixed -exitOnFail -file 
/dev/xconsole
andy     563  0.0  0.2  3472  392 ?        S    Nov04   0:01 
x-window-manager
andy     624  0.0  0.0  2372  156 ?        S    Nov04   0:00 
/usr/bin/ssh-agent x-window-manager
andy     626  0.0  0.1  3472  256 ?        S    Nov04   0:00 
x-window-manager -d :0.1 -s
andy     628  0.0  0.1  2332  220 ?        S    Nov04   0:00 
/usr/bin/Animate --window 0 --context 8
andy     629  0.0  0.1  3048  256 ?        S    Nov04   0:00 /usr/bin/Wharf 
- --window 0 --context 8
andy     631  0.0  0.0  2332  188 ?        S    Nov04   0:00 
/usr/bin/Animate --window 0 --context 8
andy     632  0.0  0.1  3048  228 ?        S    Nov04   0:00 /usr/bin/Wharf 
- --window 0 --context 8
andy     635  0.0  0.1  3048  280 ?        S    Nov04   0:00 /usr/bin/Pager 
- --window 0 --context 8 0 0
andy     639  0.0  0.1  3048  204 ?        S    Nov04   0:00 /usr/bin/Pager 
- --window 0 --context 8 0 0
root     22089  0.0  0.1  1684  244 ?        S    Nov08   0:00 /USR/SBIN/CRON
root     22090  0.0  0.0  2156  176 ?        S    Nov08   0:00 /bin/sh -c if 
[ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then /usr/bin/mrtg 
/etc/mrtg.cfg >> /var/log/mrtg/mrtg.log 2>&1; fi
root     22091  0.0  0.1  8572  192 ?        S    Nov08   0:01 /usr/bin/perl 
- -w /usr/bin/mrtg /etc/mrtg.cfg
andy   22093  0.0  0.1  2752  216 ?        S    Nov08   0:00 ssh 
xxxxxxx /home/andy/mrtg/linux_stats.pl eth0
root     25679  0.0  0.0     0    0 ?        SW   Nov09   0:00 [pdflush]
andy    2463  0.0  0.3  4728  576 ?        S    Nov10   0:00 
x-terminal-emulator -T XTerminal@rex
andy    2467  0.0  0.3  4736  700 ?        S    Nov10   0:00 
x-terminal-emulator -T XTerminal@rex
andy    2470  0.0  0.8  3344 1548 pts/0    S    Nov10   0:00 bash
andy    2474  0.0  0.4  4728  912 ?        S    Nov10   0:00 
x-terminal-emulator -T XTerminal@rex
andy    2477  0.0  0.5  3368  968 pts/1    S    Nov10   0:00 bash
andy    2490  0.0  0.4  3344  800 pts/2    S    Nov10   0:00 bash
root      2518  0.0  0.3  5760  704 ?        S    00:01   0:00 sshd: andy 
[priv]
andy    2520  0.0  0.5  5780  948 ?        S    00:01   0:00 sshd: 
andy@pts/3
andy    2521  0.0  0.9  3380 1868 pts/3    S    00:01   0:00 -bash
andy    2763  0.0  0.4  2500  760 pts/3    R    00:27   0:00 ps aux

dmesg
- --
Linux version 2.6.0-test9 (thomas@rex) (gcc version 3.3.1 20030626 (Debian 
prerelease)) #4 Tue Oct 28 15:12:18 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bff3000 (ACPI NVS)
 BIOS-e820: 000000000bff3000 - 000000000c000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
191MB LOWMEM available.
On node 0 totalpages: 49136
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45040 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Building zonelist for node : 0
Kernel command line: root=/dev/hda3 ro
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 467.898 MHz processor.
Console: colour VGA+ 80x25
Memory: 188808k/196544k available (3651k kernel code, 7100k reserved, 1086k 
data, 184k init, 0k highmem)
Calibrating delay loop... 923.64 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0183fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 467.0661 MHz.
..... host bus clock speed is 66.0808 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb2d0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbed0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbef8, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
SGI XFS for Linux with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: Card 'OPL3-SAX Sound Board'
isapnp: 1 Plug & Play card detected total
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized r128 2.5.0 20030725 on minor 1
[drm] Initialized radeon 1.9.0 20020828 on minor 2
[drm] Initialized mga 3.1.0 20021029 on minor 3
[drm] Initialized i810 1.4.0 20030605 on minor 4
[drm] Initialized i830 1.3.2 20021108 on minor 5
[drm] Initialized sis 1.1.0 20030826 on minor 6
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC AC28400R, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-ROM CDU701-Q, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 14X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
PCI: Found IRQ 10 for device 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:0b.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0000e000
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver tiglusb
drivers/usb/misc/tiglusb.c: TI-GRAPH LINK USB (aka SilverLink) driver, 
version 1.06
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 
2003 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (1535 buckets, 12280 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 184k freed
Adding 248996k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:07.2
eth0: RealTek RTL8139 at 0xcc867000, 00:50:22:8d:44:97, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Disabled Privacy Extensions on device c0553260(lo)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1


- ---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux 2.4" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/sQIaKGrpCq1I6FQRAiqcAKCXEAsg8CzjJcH/a30ISKXCNjb26gCcDqYP
9Tl1quW84TP1nHemixUylJE=
=abMW
-----END PGP SIGNATURE-----

--------------Boundary-00=_L1277H11VHILYKVMBJ4W
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
l2UAAA==

--------------Boundary-00=_L1277H11VHILYKVMBJ4W--
