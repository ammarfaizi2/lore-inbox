Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVAJRxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVAJRxO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVAJRwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:52:43 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:58757 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S262371AbVAJReB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:34:01 -0500
Date: Mon, 10 Jan 2005 11:33:43 -0600
From: DHollenbeck <dick@softplc.com>
Subject: yenta_socket rapid fires interrupts
To: linux-kernel@vger.kernel.org
Message-id: <41E2BC77.2090509@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please help me troubleshoot a problem with 2.6.10-ac5 i386 on embedded 
pentium 266MHz problem.  The same problem exists with a 2.6.7 and 2.6.9 
kernel.  I am currently testing against 2.6.10-ac5.

The problem I think is in the yenta_socket driver, which in my case is 
configured as a module.

I have two CARDBUS slots.  If the slots are empty when loading 
yenta_socket, then no problem loading the module.

However, when I have a "CARDBUS to USB 2.0 Hi-Speed Adapter" installed 
at the time of modprobe yenta_socket, I get a problem, shown below.  The 
same problem occurs if the Adapter is inserted after the yenta module is 
loaded.  That is, load the yenta_socket module: no problem, then 
physically insert the Adapter: same problem.

This same Adapter card works fine in a different pentium shoebox 
computer using the same kernel and root file system as the "problem 
embedded pentium" system, but with a different CARDBUS chipset.  So I do 
not suspect the card.  Wild guess:  perhaps the Adapter card is powering 
up in a mode to rapid fire interrupts because this CARDBUS chipset is 
not initialized correctly?

Sequence of states and actions:

root@EMBEDDED[~]# uname -a
Linux EMBEDDED 2.6.10-ac5 #12 Fri Jan 7 15:41:15 CST 2005 i586 unknown

root@EMBEDDED[~]# lsmod
Module                  Size  Used by
md5                     2944  1
ipv6                  184704  6
natsemi                17760  0

root@EMBEDDED[~]# cat /proc/interrupts
           CPU0
  0:      84342          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:        162          XT-PIC  serial
  8:          0          XT-PIC  rtc
  9:        329          XT-PIC  eth0
 14:       8245          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0

root@EMBEDDED[~]# modprobe yenta_socket

root@EMBEDDED[~]# dmesg
Linux version 2.6.10-ac5 (dick@DicksAMD) (gcc version 3.4.1) #12 Fri Jan 
7 15:41:15 CST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 0000000000100000 - 0000000002000000 (usable)
32MB LOWMEM available.
On node 0 totalpages: 8192
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 4096 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Built 1 zonelists
Kernel command line: ro irqpoll root=/dev/hda1 console=ttyS0,38400 
TERM=vt100 platform=routerboard mem=32768K
Misrouted IRQ fixup and polling support enabled.
This may significantly impact system performance.
No local APIC present or hardware disabled
mapped APIC to ffffd000 (01041000)
Initializing CPU#0
PID hash table entries: 256 (order: 8, 4096 bytes)
Detected 266.771 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29376k/32768k available (1635k kernel code, 2956k reserved, 603k 
data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 491.52 BogoMIPS (lpj=245760)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 00808131 01818131 00000000 00000000
CPU: After vendor identify, caps:  00808131 01818131 00000000 00000000
CPU: After all inits, caps:        00808131 00818131 00000000 00000001
CPU: NSC Unknown stepping 01
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf7870, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router NatSemi [100b/0510] at 0000:00:12.0
Initializing Cryptographic API
Real Time Clock Driver v1.12
i8042.c: Can't read CTR while initializing i8042.
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
io scheduler noop registered
elevator: using noop as default io scheduler
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: SAMSUNG CF/ATA, CFA DISK drive
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 126976 sectors (65 MB) w/1KiB Cache, CHS=496/8/32
hda: cache flushes not supported
 hda: hda1
NFTL driver: nftlcore.c $Revision: 1.97 $, nftlmount.c $Revision: 1.39 $
No valid DiskOnChip devices found
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
 hda: hda1
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
EXT3 FS on hda1, internal journal
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
PCI: Found IRQ 9 for device 0000:00:0b.0
natsemi eth0: NatSemi DP8381[56] at 0xfebf7000 (0000:00:0b.0), 
00:0c:42:03:1b:59, IRQ 9, port TP.
PCI: Found IRQ 10 for device 0000:00:0c.0
natsemi eth1: NatSemi DP8381[56] at 0xfebf8000 (0000:00:0c.0), 
00:0c:42:03:1b:5a, IRQ 10, port TP.
eth0: DSPCFG accepted after 0 usec.
eth0: link up.
eth0: Setting full-duplex based on negotiated link capability.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c031bd60(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
Linux Kernel Card Services
  options:  [pci] [cardbus]
PCI: Found IRQ 11 for device 0000:00:0d.0
PCI: Sharing IRQ 11 with 0000:00:0d.1
Yenta: CardBus bridge found at 0000:00:0d.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0d.0, mfunc 0x00001022, devctl 0x64
Yenta: ISA IRQ mask 0x00a8, PCI irq 11
Socket status: 30000020
PCI: Found IRQ 11 for device 0000:00:0d.1
PCI: Sharing IRQ 11 with 0000:00:0d.0
Yenta: CardBus bridge found at 0000:00:0d.1 [0000:0000]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0d.1, mfunc 0x00001022, devctl 0x64
Yenta: ISA IRQ mask 0x00a8, PCI irq 11
Socket status: 30000006
irq 11: nobody cared (try booting with the "irqpoll" option.
 [<c0127362>]
 [<c0127468>]
 [<c0126e89>]
 [<c010481a>]
 [<c01031ea>]
 [<c012007b>]
 [<c0126d59>]
 [<c0126e55>]
 [<c010481a>]
 [<c01031ea>]
 [<c012007b>]
 [<c0115d70>]
 [<c0120060>]
 [<c0115e15>]
 [<c010481f>]
 [<c01031ea>]
 [<c01005f0>]
 [<c0100613>]
 [<c010068c>]
 [<c0332737>]
handlers:
[<c2837930>]
[<c2837930>]
Disabling IRQ #11    
<------------------------------------------------------- !!@@ OUCH @@!!

 
root@EMBEDDED[~]# lspci -vnn
00:00.0 Class 0600: 1078:0001
        Flags: bus master, medium devsel, latency 0

00:0b.0 Class 0200: 100b:0020
        Subsystem: 100b:0020
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 1000 [size=256]
        Memory at febf7000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 2

00:0c.0 Class 0200: 100b:0020
        Subsystem: 100b:0020
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at 1400 [size=256]
        Memory at febf8000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 2

00:0d.0 Class 0607: 104c:ac55 (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at febf9000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 10000000-103ff000 (prefetchable)
        Memory window 1: 10400000-107ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

00:0d.1 Class 0607: 104c:ac55 (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at febfa000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
        Memory window 0: 10800000-10bff000 (prefetchable)
        Memory window 1: 10c00000-10fff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

00:12.0 Class 0601: 100b:0510
        Subsystem: 100b:0500
        Flags: bus master, medium devsel, latency 4
        I/O ports at 1c00 [size=64]
        I/O ports at 1c40 [size=64]

00:12.1 Class 0680: 100b:0511
        Subsystem: 100b:0501
        Flags: medium devsel
        I/O ports at 1800 [size=256]

00:12.2 Class 0101: 100b:0502 (rev 01) (prog-if 80 [Master])
        Subsystem: 100b:0502
        Flags: bus master, medium devsel, latency 0
        I/O ports at 1cc0 [size=16]

00:12.3 Class 0401: 100b:0503
        Subsystem: 100b:0503
        Flags: bus master, medium devsel, latency 0
        Memory at febfb000 (32-bit, non-prefetchable) [size=4K]

00:12.4 Class 0300: 100b:0514 (rev 01)
        Subsystem: 100b:0504
        Flags: medium devsel
        Memory at febfc000 (32-bit, non-prefetchable) [size=4K]
        Memory at febfd000 (32-bit, non-prefetchable) [size=4K]
        Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled]

00:12.5 Class 0680: 100b:0515
        Subsystem: 100b:0505
        Flags: medium devsel
        I/O ports at 1c80 [size=64]

00:13.0 Class 0c03: 0e11:a0f8 (rev 08) (prog-if 10)
        Subsystem: 0e11:a0f8
        Flags: medium devsel, IRQ 12
        Memory at febff000 (32-bit, non-prefetchable) [size=4K]

01:00.0 Class 0c03: 10b9:5237 (rev 03) (prog-if 10)
        Subsystem: 10b9:5237
        Flags: 66Mhz, medium devsel, IRQ 11
        Memory at 10400000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Capabilities: [60] Power Management version 2

01:00.3 Class 0c03: 10b9:5239 (rev 01) (prog-if 20)
        Subsystem: 10b9:5272
        Flags: 66Mhz, medium devsel, IRQ 11
        Memory at 10401000 (32-bit, non-prefetchable) [disabled] [size=256]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2090]


root@EMBEDDED[~]# cat /proc/interrupts
           CPU0
  0:     541666          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:        162          XT-PIC  serial
  8:          0          XT-PIC  rtc
  9:       1133          XT-PIC  eth0
 11:      98681          XT-PIC  yenta, yenta
 14:       8443          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
root@EMBEDDED[~]#

---------------

kernel paramters irqpoll and apic options had no effect.

Bitte, was ist?

Dick Hollenbeck


-- 
Please help fix the U.S. software industry before it is too late.
Contact your U.S. representatives with this information:
http://lpf.ai.mit.edu/Patents/industry-at-risk.html
http://www.groklaw.net/article.php?story=20041003041632172


