Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271989AbRIIO6f>; Sun, 9 Sep 2001 10:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271987AbRIIO6R>; Sun, 9 Sep 2001 10:58:17 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:46762 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S270280AbRIIO6J>; Sun, 9 Sep 2001 10:58:09 -0400
From: Stefan Hoffmeister <lkml.2001@econos.de>
To: linux-kernel@vger.kernel.org
Subject: hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
Date: Sun, 09 Sep 2001 16:58:25 +0200
Organization: Econos
Message-ID: <vd0npt0uvlo2kmicu14cs3culd8pck94eu@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

on an Omnibook 800CT (Pentium "Classic" 133, 48 MB) notebook with docking
station, running on AC power, I notice sporadic kernel log entries of the
form

    hda: read_intr: status=0x59 
          { DriveReady SeekComplete DataRequest Error }
    hda: read_intr: error=0x04 
          { DriveStatusError }

These entries, AFAIR, have only appeared since I started experimenting
with kernels 2.4.7.SuSE-1 and 2.2.19.SuSE-14 on that system - AFAIR, I
never saw that with a 2.2.16 kernel. (I figure the diagnostics were only
added post-2.2.16?)

Below is a little "timeline" of how this has shown up - I'd almost be
prepared to bet that the rexecd invocation triggered this. At the end of
my message is the complete output of dmesg.

>From staring a bit at the source code of drivers/ide/hd.c, it is not
evident whether this message is something I should worry about or not?
IBMs drive fitness test does not report any problems.

I figure that lack of IDE DMA support combined with APM (with the disk
running continuously and not sleeping) might be a problem?

FWIW, the kernel option CONFIG_IDEDISK_MULTI_MODE is selected - but it
seems to be meant to address a different set of issues ("set_multmode").

TIA!
Stefan

**************

Sep 10 10:25:03 xxxxx rpc.statd[572]: Version 0.3.1 Starting
Sep 10 10:25:03 xxxxx kernel: svc: unknown version (3)
Sep 10 10:30:00 xxxxx kernel: hda: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Sep 10 10:30:00 xxxxx kernel: hda: read_intr: error=0x04 {
DriveStatusError }
Sep 10 10:30:00 xxxxx kernel: hda: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Sep 10 10:30:00 xxxxx kernel: hda: read_intr: error=0x04 {
DriveStatusError }
Sep 10 10:30:01 xxxxx kernel: hda: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Sep 10 10:30:01 xxxxx kernel: hda: read_intr: error=0x04 {
DriveStatusError }
Sep 10 10:30:01 xxxxx kernel: hda: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Sep 10 10:30:01 xxxxx kernel: hda: read_intr: error=0x04 {
DriveStatusError }
Sep 10 10:30:01 xxxxx kernel: ide0: reset: success
Sep 10 10:32:03 xxxxx in.rexecd[717]: connect from yyy.yyy.yyy.yyy
(yyy.yyy.yyy.yyy)
Sep 10 10:32:52 xxxxx in.rexecd[718]: connect from yyy.yyy.yyy.yyy
(yyy.yyy.yyy.yyy)
Sep 10 10:32:57 xxxxx in.rexecd[719]: connect from yyy.yyy.yyy.yyy
(yyy.yyy.yyy.yyy)

***********************************************************

Linux version 2.4.7 (me@xxxxx) (gcc version 2.95.3 20010315 (SuSE)) #2 Mon
Sep 10 06:01:44 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
On node 0 totalpages: 12288
zone(0): 4096 pages.
zone(1): 8192 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=247 ro root=303 BOOT_FILE=/boot/bz247
Initializing CPU#0
Detected 131.729 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 262.14 BogoMIPS
Memory: 46168k/49152k available (1003k kernel code, 2596k reserved, 363k
data, 188k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xeef92, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VLSI 82C534 [1004/0102] at 00:01.0
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1130
  got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1130
(#2)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
block: queued sectors max/low 30557kB/10185kB, 128 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: IBM-DARA-206000, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 11733120 sectors (6007 MB) w/418KiB Cache, CHS=776/240/63
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 15 for device 01:06.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:08:C7:99:D9:94, IRQ 15.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 702536-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 5 for device 00:04.0
PCI: Assigned IRQ 9 for device 00:04.1
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0a98, PCI irq5
Socket status: 30000010
Yenta IRQ list 0898, PCI irq9
Socket status: 30000006
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 309952k swap-space (priority -1)
ip_conntrack (384 buckets, 3072 max)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x8e0-0x8e7
cs: IO port probe 0x0100-0x04ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth1: 3Com 3c589, io 0x300, irq 3, hw_addr 00:60:97:8A:C8:EB
  8K FIFO split 5:3 Rx:Tx, auto xcvr
svc: unknown version (3)
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x04 { DriveStatusError }
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x04 { DriveStatusError }
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x04 { DriveStatusError }
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x04 { DriveStatusError }
ide0: reset: success

