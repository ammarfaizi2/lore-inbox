Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145183AbRA2HME>; Mon, 29 Jan 2001 02:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S159777AbRA2HL7>; Mon, 29 Jan 2001 02:11:59 -0500
Received: from mail.mojomofo.com ([208.248.233.19]:64783 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S145183AbRA2HLk>;
	Mon, 29 Jan 2001 02:11:40 -0500
Message-ID: <005501c089c2$b688e720$0300a8c0@methusela>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10101282143570.5509-100000@penguin.transmeta.com>
Subject: Re: PCI IRQ routing problem in 2.4.0 (SiS results part 2)
Date: Mon, 29 Jan 2001 02:11:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| Which one was it you got a PIRQ conflict for before? as it te device at
| 00:01.00 with the strange "0x62" entry?

Yes.

| How about you try adding the line
| pirq = (pirq-1) & 3;
| at the top of both pirq_sis_get() and pirq_sis_set() (with my "alternate"
| SiS routines). What happens then?

Done.

Linux version 2.4.0-ac12 (root@usr1-ip012-cs.wmis.net) (gcc version 2.95.3
20010125 (prerelease)) #4 Mon Jan 29 01:53:12 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000003efd000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000002000 @ 0000000003ffd000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 0000000003fff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 16381
zone(0): 4096 pages.
zone(1): 12285 pages.
zone(2): 0 pages.
APIC turned off by hardware.
mapped APIC to ffffe000 (01112000)
Kernel command line: auto BOOT_IMAGE=lnew ro root=341
BOOT_FILE=/home/kernel/kernel/linux/arch/i386/boot/bzImage
Initializing CPU#0
Detected 374.227 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 747.11 BogoMIPS
Memory: 62368k/65524k available (940k kernel code, 2772k reserved, 327k
data, 188k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: BIOS32 Service Directory structure at 0xc00f9b50
PCI: BIOS32 Service Directory entry at 0xf04d0
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=00
PCI: PCI BIOS revision 2.10 entry at 0xf0500, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Setting max latency to 32
PCI: IDE base address trash cleared for 00:01.1
PCI: IDE base address fixup for 00:01.1
PCI: Scanning for ghost devices on bus 0
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f0af0
00:0c slot=01 0:41/1eb8 1:42/1eb8 2:43/1eb8 3:44/1eb8
00:0b slot=02 0:42/1eb8 1:43/1eb8 2:44/1eb8 3:41/1eb8
00:0a slot=03 0:43/1eb8 1:44/1eb8 2:41/1eb8 3:42/1eb8
00:09 slot=04 0:44/1eb8 1:41/1eb8 2:42/1eb8 3:43/1eb8
00:01 slot=00 0:62/1eb8 1:00/0000 2:00/0000 3:00/0000
00:13 slot=00 0:41/1eb8 1:42/1eb8 2:43/1eb8 3:44/1eb8
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
PCI: IRQ fixup
PCI: Allocating resources
PCI: Resource 0000d000-0000d00f (f=101, d=0, p=0)
PCI: Resource dd000000-dd000fff (f=200, d=0, p=0)
PCI: Resource 0000b800-0000b807 (f=101, d=0, p=0)
PCI: Resource dc800000-dc87ffff (f=200, d=0, p=0)
PCI: Resource e0000000-e7ffffff (f=1208, d=0, p=0)
PCI: Resource df000000-df000fff (f=1208, d=0, p=0)
PCI: Resource 0000b400-0000b41f (f=101, d=0, p=0)
PCI: Resource dc000000-dc0fffff (f=200, d=0, p=0)
PCI: Resource de000000-de3fffff (f=1208, d=1, p=1)
PCI: Resource db800000-db80ffff (f=200, d=1, p=1)
PCI: Resource 0000b000-0000b07f (f=101, d=1, p=1)
PCI: Sorting device list...
Disabling direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41341kB/31006kB, 128 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
IRQ for 00:01.1:0 -> PIRQ 62, mask 1eb8, excl 0000 -> newirq=10 -> got IRQ
10
PCI: Found IRQ 10 for device 00:01.1
PCI: The same IRQ used for device 00:01.2
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5597
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
hda: ST5660A, ATA DISK drive
hdb: IBM-DJAA-31700, ATA DISK drive
hdc: Maxtor 72700 AP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 1066184 sectors (546 MB) w/256KiB Cache, CHS=528/32/63, DMA
hdb: 3334464 sectors (1707 MB) w/96KiB Cache, CHS=827/64/63, DMA
hdc: 5290320 sectors (2709 MB) w/128KiB Cache, CHS=5248/16/63, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
 /dev/ide/host0/bus0/target1/lun0: p1
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [656/128/63] p1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ DETECT_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
IRQ for 00:0a.0:0 -> PIRQ 43, mask 1eb8, excl 0000 -> newirq=5 -> got IRQ 11
IRQ routing conflict in pirq table! Try 'pci=autoirq'
ttyS02 at port 0xb800 (irq = 5) is a 16550A
Real Time Clock Driver v1.10d
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
IRQ for 00:0c.0:0 -> PIRQ 41, mask 1eb8, excl 0000 -> newirq=10 -> assigning
IRQ 10 ... OK
PCI: Assigned IRQ 10 for device 00:0c.0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:0D:A6:1F, IRQ 10.
  Board assembly 352509-003, Physical connectors present: RJ45
  Primary interface chip DP83840 PHY #1.
  DP83840 specific setup, setting register 23 to 8462.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
reiserfs: checking transaction log (device 03:41) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 188k freed
Adding Swap: 18136k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
IRQ for 00:01.2:0 -> PIRQ 62, mask 1eb8, excl 0000 -> newirq=10 -> got IRQ
10
PCI: Found IRQ 10 for device 00:01.2
PCI: The same IRQ used for device 00:01.1
usb-ohci.c: USB OHCI at membase 0xc48c6000, IRQ 10
usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Adding Swap: 65528k swap-space (priority -2)
Adding Swap: 131064k swap-space (priority -3)

I also attached my dmesg from the original pre-modded SiS after this.

Linux version 2.4.0-ac12 (root@lucretia.wmis.net) (gcc version 2.95.3
20010125 (prerelease)) #5 Mon Jan 29 01:59:59 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000003efd000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000002000 @ 0000000003ffd000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 0000000003fff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 16381
zone(0): 4096 pages.
zone(1): 12285 pages.
zone(2): 0 pages.
APIC turned off by hardware.
mapped APIC to ffffe000 (01112000)
Kernel command line: auto BOOT_IMAGE=lnew ro root=341
BOOT_FILE=/home/kernel/kernel/linux/arch/i386/boot/bzImage
Initializing CPU#0
Detected 374.224 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 747.11 BogoMIPS
Memory: 62368k/65524k available (940k kernel code, 2772k reserved, 327k
data, 188k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: BIOS32 Service Directory structure at 0xc00f9b50
PCI: BIOS32 Service Directory entry at 0xf04d0
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=00
PCI: PCI BIOS revision 2.10 entry at 0xf0500, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Setting max latency to 32
PCI: IDE base address trash cleared for 00:01.1
PCI: IDE base address fixup for 00:01.1
PCI: Scanning for ghost devices on bus 0
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f0af0
00:0c slot=01 0:41/1eb8 1:42/1eb8 2:43/1eb8 3:44/1eb8
00:0b slot=02 0:42/1eb8 1:43/1eb8 2:44/1eb8 3:41/1eb8
00:0a slot=03 0:43/1eb8 1:44/1eb8 2:41/1eb8 3:42/1eb8
00:09 slot=04 0:44/1eb8 1:41/1eb8 2:42/1eb8 3:43/1eb8
00:01 slot=00 0:62/1eb8 1:00/0000 2:00/0000 3:00/0000
00:13 slot=00 0:41/1eb8 1:42/1eb8 2:43/1eb8 3:44/1eb8
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
PCI: IRQ fixup
PCI: Allocating resources
PCI: Resource 0000d000-0000d00f (f=101, d=0, p=0)
PCI: Resource dd000000-dd000fff (f=200, d=0, p=0)
PCI: Resource 0000b800-0000b807 (f=101, d=0, p=0)
PCI: Resource dc800000-dc87ffff (f=200, d=0, p=0)
PCI: Resource e0000000-e7ffffff (f=1208, d=0, p=0)
PCI: Resource df000000-df000fff (f=1208, d=0, p=0)
PCI: Resource 0000b400-0000b41f (f=101, d=0, p=0)
PCI: Resource dc000000-dc0fffff (f=200, d=0, p=0)
PCI: Resource de000000-de3fffff (f=1208, d=1, p=1)
PCI: Resource db800000-db80ffff (f=200, d=1, p=1)
PCI: Resource 0000b000-0000b07f (f=101, d=1, p=1)
PCI: Sorting device list...
Disabling direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41341kB/31006kB, 128 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
IRQ for 00:01.1:0 -> PIRQ 62, mask 1eb8, excl 0000 -> newirq=10 -> got IRQ 7
IRQ routing conflict in pirq table! Try 'pci=autoirq'
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5597
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
hda: ST5660A, ATA DISK drive
hdb: IBM-DJAA-31700, ATA DISK drive
hdc: Maxtor 72700 AP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 1066184 sectors (546 MB) w/256KiB Cache, CHS=528/32/63, DMA
hdb: 3334464 sectors (1707 MB) w/96KiB Cache, CHS=827/64/63, DMA
hdc: 5290320 sectors (2709 MB) w/128KiB Cache, CHS=5248/16/63, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
 /dev/ide/host0/bus0/target1/lun0: p1
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [656/128/63] p1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ DETECT_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
IRQ for 00:0a.0:0 -> PIRQ 43, mask 1eb8, excl 0000 -> newirq=5 -> got IRQ 5
PCI: Found IRQ 5 for device 00:0a.0
ttyS02 at port 0xb800 (irq = 5) is a 16550A
Real Time Clock Driver v1.10d
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
IRQ for 00:0c.0:0 -> PIRQ 41, mask 1eb8, excl 0000 -> newirq=10 -> got IRQ
10
PCI: Found IRQ 10 for device 00:0c.0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:0D:A6:1F, IRQ 10.
  Board assembly 352509-003, Physical connectors present: RJ45
  Primary interface chip DP83840 PHY #1.
  DP83840 specific setup, setting register 23 to 8462.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
reiserfs: checking transaction log (device 03:41) ...
Warning, log replay starting on readonly filesystem
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 188k freed
Adding Swap: 18136k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
IRQ for 00:01.2:0 -> PIRQ 62, mask 1eb8, excl 0000 -> newirq=7 -> got IRQ 7
PCI: Found IRQ 7 for device 00:01.2
PCI: The same IRQ used for device 00:01.1
usb-ohci.c: USB OHCI at membase 0xc48c6000, IRQ 7
usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Adding Swap: 65528k swap-space (priority -2)
Adding Swap: 131064k swap-space (priority -3)
ip_tables: (c)2000 Netfilter core team
ip_conntrack (511 buckets, 4088 max)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
