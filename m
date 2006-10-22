Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWJVWfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWJVWfM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWJVWfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:35:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:36701 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750826AbWJVWfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:35:06 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type;
	b=KTisFGl9TeO/74BWxDa2SWfgUE4/RfJvwWvyJFcBgM/pDsPbHAONU1B0wobmWuCI/
	aihZqq+3/X8T2sTrvuxjw==
Message-ID: <453BF19A.5020703@google.com>
Date: Sun, 22 Oct 2006 15:32:58 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Strange errors from e1000 driver (2.6.18)
References: <453BBC9E.4040300@google.com> <453BC0E7.1060308@mbligh.org>	 <4807377b0610221321i62455faende025f88142dd087@mail.gmail.com>	 <453BD41B.4010007@google.com> <4807377b0610221515m42e638c3pfb461fbb7133845e@mail.gmail.com>
In-Reply-To: <4807377b0610221515m42e638c3pfb461fbb7133845e@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070507090905040704040507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507090905040704040507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jesse Brandeburg wrote:
> Analysis follows, but I wanted to ask you to bisect back if you can to
> find the apparent patch to make the difference.  Basically at this
> point I'd say its not likely to be an e1000 issue, but I'd like to
> follow up and make sure.

That's going to be ugly, since I can't reproduce it at will. Maybe if
I netperf it to the other box I can push it over.

> Nothing seems out of order, but the latency may be low, I'd be curious
> what these looked like before with the old kernel.  Some of the other
> things to compare would have been the lspci -vv output from your
> chipset with old/new kernel, in case the bridge/system configuration
> changed.  There are no known problems right now with this chipset
> 82546EB

OK. will try later when I have more time. For now I switched to the
onboard via rhine controller.

> shared int, fine, but whats with the ERR: ?

Hmm. Having rebooted they look rather lower. but might be a time thing.

            CPU0
   0:    1405995          XT-PIC  timer
   1:       5910          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:          0          XT-PIC  uhci_hcd:usb3
   7:      27135          XT-PIC  ehci_hcd:usb2, VIA8237, eth0
  10:          0          XT-PIC  uhci_hcd:usb4, uhci_hcd:usb5, 
uhci_hcd:usb6
  11:          0          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb7, 
uhci_hcd:usb8
  12:     157547          XT-PIC  i8042
  14:      36296          XT-PIC  ide0
  15:     196690          XT-PIC  ide1
NMI:          0
LOC:    1406006
ERR:         26

> except you didn't include any of the e1000 load information nor the
> system's boot information as it came up.

OK, it had gone since reboot, but I rebooted just now .... new info
attached.

> This chipset is one of the most frequent common elements in problem
> reports of TX hangs for e1000.  My current theory (we've bought a
> bunch of these systems and never reproduced the issue) is that there
> is something either design specific or BIOS specific that causes this
> chipset to interact very badly with e1000 hardware.  Some systems have
> the issue and some don't.  If you could bisect back to a working point
> it would be interesting to see where that pointed.

OK, is going to be hard to bisect, since the other one was an Ubuntu
kernel, but I guess I can give 2.6.15 virgin a shot, at least.

> doesn't seem you're overclocked.  Good.

Nah, I'm pretty conservative with hardware, get enough problems when
it's all running within specs ;-)

Thanks for looking at all this.

M.



--------------070507090905040704040507
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.18 (mbligh@titus) (gcc version 3.4.6 (Ubuntu 3.4.6-1ubuntu2)) #2 Sun Oct 22 13:45:39 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f52b0
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
DMI 2.2 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:10 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 1098.980 MHz processor.
Built 1 zonelists.  Total pages: 229376
Kernel command line: root=/dev/hda1 ro lapic profile=2
kernel profiling enabled (shift: 2)
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c04e4000 soft=c04e3000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 902328k/917504k available (2647k kernel code, 14784k reserved, 1144k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2200.00 BogoMIPS (lpj=4400011)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000
Compat vDSO mapped to ffffe000.
CPU: AMD Athlon(tm)  stepping 00
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb360, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:09.0
PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
spurious 8259A interrupt: IRQ7.
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler cfq registered (default)
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.1.9-k4
Copyright (c) 1999-2006 Intel Corporation.
PCI: setting IRQ 7 as level-triggered
PCI: Found IRQ 7 for device 0000:00:0a.0
PCI: Sharing IRQ 7 with 0000:00:10.4
PCI: Sharing IRQ 7 with 0000:00:11.5
e1000: 0000:00:0a.0: e1000_probe: (PCI:33MHz:32-bit) 00:07:e9:09:0b:08
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
PCI: setting IRQ 5 as level-triggered
PCI: Found IRQ 5 for device 0000:00:0a.1
PCI: Sharing IRQ 5 with 0000:00:0b.0
e1000: 0000:00:0a.1: e1000_probe: (PCI:33MHz:32-bit) 00:07:e9:09:0b:09
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
via-rhine.c:v1.10-LK1.4.1 July-24-2006 Written by Donald Becker
PCI: setting IRQ 10 as level-triggered
PCI: Found IRQ 10 for device 0000:00:12.0
PCI: Sharing IRQ 10 with 0000:00:0b.1
PCI: Sharing IRQ 10 with 0000:00:10.0
PCI: Sharing IRQ 10 with 0000:00:10.1
PCI: Sharing IRQ 10 with 0000:00:0c.0
eth2: VIA Rhine II at 0x1e000, 00:11:5b:a4:70:4d, IRQ 10.
eth2: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
Linux video capture interface: v2.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xc800-0xc807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc808-0xc80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST3200822A, ATA DISK drive
hdb: ST3400832A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3550A, ATAPI CD/DVD-ROM drive
hdd: DVD-ROM BDV316B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdb: max request size: 512KiB
hdb: 781422768 sectors (400088 MB) w/8192KiB Cache, CHS=48641/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
usbmon: debugfs is not available
PCI: setting IRQ 11 as level-triggered
PCI: Found IRQ 11 for device 0000:00:0b.2
PCI: Sharing IRQ 11 with 0000:00:09.0
PCI: Sharing IRQ 11 with 0000:00:10.2
PCI: Sharing IRQ 11 with 0000:00:10.3
ehci_hcd 0000:00:0b.2: EHCI Host Controller
ehci_hcd 0000:00:0b.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0b.2: irq 11, io mem 0xef040000
ehci_hcd 0000:00:0b.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
PCI: Found IRQ 7 for device 0000:00:10.4
PCI: Sharing IRQ 7 with 0000:00:0a.0
PCI: Sharing IRQ 7 with 0000:00:11.5
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:10.4: irq 7, io mem 0xef041000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
PCI: Found IRQ 5 for device 0000:00:0b.0
PCI: Sharing IRQ 5 with 0000:00:0a.1
uhci_hcd 0000:00:0b.0: UHCI Host Controller
uhci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:0b.0: irq 5, io base 0x0000a800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:0b.1
PCI: Sharing IRQ 10 with 0000:00:10.0
PCI: Sharing IRQ 10 with 0000:00:10.1
PCI: Sharing IRQ 10 with 0000:00:0c.0
PCI: Sharing IRQ 10 with 0000:00:12.0
uhci_hcd 0000:00:0b.1: UHCI Host Controller
uhci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:0b.1: irq 10, io base 0x0000ac00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:10.0
PCI: Sharing IRQ 10 with 0000:00:0b.1
PCI: Sharing IRQ 10 with 0000:00:10.1
PCI: Sharing IRQ 10 with 0000:00:0c.0
PCI: Sharing IRQ 10 with 0000:00:12.0
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.0: irq 10, io base 0x0000cc00
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:10.1
PCI: Sharing IRQ 10 with 0000:00:0b.1
PCI: Sharing IRQ 10 with 0000:00:10.0
PCI: Sharing IRQ 10 with 0000:00:0c.0
PCI: Sharing IRQ 10 with 0000:00:12.0
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:10.1: irq 10, io base 0x0000d000
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:10.2
PCI: Sharing IRQ 11 with 0000:00:09.0
PCI: Sharing IRQ 11 with 0000:00:10.3
PCI: Sharing IRQ 11 with 0000:00:0b.2
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:10.2: irq 11, io base 0x0000d400
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:10.3
PCI: Sharing IRQ 11 with 0000:00:09.0
PCI: Sharing IRQ 11 with 0000:00:10.2
PCI: Sharing IRQ 11 with 0000:00:0b.2
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:10.3: irq 11, io base 0x0000d800
usb usb8: configuration #1 chosen from 1 choice
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13:55:50 2006 UTC).
PCI: Found IRQ 7 for device 0000:00:11.5
PCI: Sharing IRQ 7 with 0000:00:0a.0
PCI: Sharing IRQ 7 with 0000:00:10.4
PCI: Setting latency timer of device 0000:00:11.5 to 64
input: AT Translated Set 2 keyboard as /class/input/input0
logips2pp: Detected unknown logitech mouse model 11
ALSA device list:
  #0: VIA 8237 with ALC655 at 0xdc00, irq 7
oprofile: using NMI interrupt.
ip_conntrack version 2.4 (7168 buckets, 57344 max) - 172 bytes per conntrack
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
input: PS/2 Logitech Mouse as /class/input/input1
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
Unable to find swap-space signature
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Unable to find swap-space signature
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  Tx Queue             <0>
  TDH                  <26>
  TDT                  <26>
  next_to_use          <26>
  next_to_clean        <39>
buffer_info[next_to_clean]
  time_stamp           <77145>
  next_to_watch        <3b>
  jiffies              <7734f>
  next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  Tx Queue             <0>
  TDH                  <26>
  TDT                  <26>
  next_to_use          <26>
  next_to_clean        <39>
buffer_info[next_to_clean]
  time_stamp           <77145>
  next_to_watch        <3b>
  jiffies              <77543>
  next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  Tx Queue             <0>
  TDH                  <26>
  TDT                  <26>
  next_to_use          <26>
  next_to_clean        <39>
buffer_info[next_to_clean]
  time_stamp           <77145>
  next_to_watch        <3b>
  jiffies              <77737>
  next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  Tx Queue             <0>
  TDH                  <26>
  TDT                  <26>
  next_to_use          <26>
  next_to_clean        <39>
buffer_info[next_to_clean]
  time_stamp           <77145>
  next_to_watch        <3b>
  jiffies              <7792b>
  next_to_watch.status <0>
NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex

--------------070507090905040704040507--
