Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUIWVDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUIWVDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUIWVB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:01:56 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:57323 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S267186AbUIWU5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:57:39 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Roman Weissgaerber <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: 2.6.9-rc2-mm2 ohci_hcd doesn't work
Date: Thu, 23 Sep 2004 14:57:16 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231457.16979.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on an HP DL360.  This device works fine with the current
2.6.9-rc2 BK tree, but fails with -mm2.  Here's the USB stuff:

 ACPI: PCI interrupt 0000:00:0f.2[A] -> GSI 10 (level, low) -> IRQ 10
 ohci_hcd 0000:00:0f.2: ServerWorks OSB4/CSB5 OHCI USB Controller
 ohci_hcd 0000:00:0f.2: irq 10, pci mem 0xf5e70000
 ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
 ohci_hcd 0000:00:0f.2: init err (00002edf 0000)
 ohci_hcd 0000:00:0f.2: can't start
 ohci_hcd 0000:00:0f.2: init error -75
 ohci_hcd 0000:00:0f.2: remove, state 0
 ohci_hcd 0000:00:0f.2: USB bus 1 deregistered
 ohci_hcd: probe of 0000:00:0f.2 failed with error -75
 USB Universal Host Controller Interface driver v2.2
 usbcore: registered new driver usbhid
 drivers/usb/input/hid-core.c: v2.0:USB HID core driver

The corresponding output from the working (2.6.9-rc2) boot:

 ACPI: PCI interrupt 0000:00:0f.2[A] -> GSI 10 (level, low) -> IRQ 10
 ohci_hcd 0000:00:0f.2: ServerWorks OSB4/CSB5 OHCI USB Controller
 ohci_hcd 0000:00:0f.2: irq 10, pci mem f8806000
 ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 4 ports detected
 USB Universal Host Controller Interface driver v2.2
 usbcore: registered new driver usbhid
 drivers/usb/input/hid-core.c: v2.0:USB HID core driver

Here's the complete console output from the failing boot.
Let me know if there's more information I can collect.

Linux version 2.6.9-rc2-mm2 (helgaas@dl360) (gcc version 3.3.3 (Debian 20040422)) #1 SMP Thu Sep 23 14:17:33 MDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fffa000 (usable)
 BIOS-e820: 000000007fffa000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f4fd0
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x03] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, GSI 16-31
ACPI: IOAPIC (id[0x04] address[0xfec02000] gsi_base[32])
IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, GSI 32-47
ACPI: IOAPIC (id[0x05] address[0xfec03000] gsi_base[48])
IOAPIC[3]: apic_id 5, version 17, address 0xfec03000, GSI 48-63
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Enabling APIC mode:  Flat.  Using 4 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: console=ttyS0,115200n8 root=/dev/cciss/c0d0p1 pci=routeirq BOOT_IMAGE=bzImage 
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2800.967 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 903516k/917504k available (3509k kernel code, 13564k reserved, 1135k data, 492k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1463.19 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 3000
Initializing CPU#1
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 2/6 eip 3000
Initializing CPU#2
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 3/7 eip 3000
Initializing CPU#3
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Total of 4 processors activated (22282.24 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0094, last bus=6
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Root Bridge [PCI1] (00:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Root Bridge [PCI2] (00:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Link [IUSB] (IRQs 4 5 7 *10 11 15)
ACPI: PCI Interrupt Link [IN16] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN17] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN18] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN19] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN20] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN21] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN22] (IRQs 4 5 *7 10 11 15)
ACPI: PCI Interrupt Link [IN23] (IRQs 4 *5 7 10 11 15)
ACPI: PCI Interrupt Link [IN24] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN25] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN26] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN27] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN28] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN29] (IRQs 4 5 7 10 11 *15)
ACPI: PCI Interrupt Link [IN30] (IRQs 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [IN31] (IRQs 4 5 7 10 11 15) *3
ACPI: PCI Interrupt Link [IN32] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN33] (IRQs 4 5 7 10 11 15) *0, disabled.
ACPI: PCI Interrupt Link [IN34] (IRQs 4 5 7 10 11 15) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** Routing PCI interrupts for all devices because "pci=routeirq"
** was specified.  If this was required to make a driver work,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 31 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 23 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:05.2[B] -> GSI 22 (level, low) -> IRQ 185
ACPI: PCI Interrupt Link [IUSB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0f.2[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:02.0[A] -> GSI 30 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:04:02.0[A] -> GSI 29 (level, low) -> IRQ 201
PCI: Device 00:00 not found by BIOS
PCI: Device 00:01 not found by BIOS
PCI: Device 00:02 not found by BIOS
PCI: Device 00:78 not found by BIOS
PCI: Device 00:7b not found by BIOS
PCI: Device 00:88 not found by BIOS
PCI: Device 00:8a not found by BIOS
Starting balanced_irq
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.18-WIP [Flags: R/O].
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
ACPI: PS/2 Keyboard Controller [KBD] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: Floppy Controller [FDC0] at I/O 0x3f2-0x3f5 irq 6 dma channel 2
ACPI: [FDC0] doesn't declare FD_DCR; also claiming 0x3f7
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
HP CISS Driver (v 2.6.2)
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 31 (level, low) -> IRQ 169
cciss: using DAC cycles
      blocks= 35553120 block_size= 512
      heads= 255, sectors= 32, cylinders= 4357

 cciss/c0d0: p1 p2
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2
Copyright (c) 1999-2004 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.1.4-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
tg3.c:v3.10 (September 14, 2004)
ACPI: PCI interrupt 0000:01:02.0[A] -> GSI 30 (level, low) -> IRQ 193
eth0: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0e:7f:b4:69:94
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
ACPI: PCI interrupt 0000:04:02.0[A] -> GSI 29 (level, low) -> IRQ 201
eth1: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0e:7f:b4:89:9f
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB5: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:pio, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:pio, hdd:pio
hda: CRN-8245B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:00:0f.2[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:0f.2: ServerWorks OSB4/CSB5 OHCI USB Controller
ohci_hcd 0000:00:0f.2: irq 10, pci mem 0xf5e70000
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0f.2: init err (00002edf 0000)
ohci_hcd 0000:00:0f.2: can't start
ohci_hcd 0000:00:0f.2: init error -75
ohci_hcd 0000:00:0f.2: remove, state 0
ohci_hcd 0000:00:0f.2: USB bus 1 deregistered
ohci_hcd: probe of 0000:00:0f.2 failed with error -75
USB Universal Host Controller Interface driver v2.2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S4 S5)
ACPI wakeup devices: 

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 492k freed
INIT: version 2.85 booting
Activating swap.
Adding 2097136k swap on /dev/cciss/c0d0p2.  Priority:-1 extents:1
Checking root file system...
fsck 1.35 (28-Feb-2004)
/dev/cciss/c0d0p1: clean, 481857/1954560 files, 2207300/3906596 blocks
EXT3 FS on cciss/c0d0p1, internal journal
rm: cannot remove `/dev/shm/root': Not a directory
System time was Thu Sep 23 20:22:18 UTC 2004.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Thu Sep 23 20:22:20 UTC 2004.
Creating device-mapper devices...done.
Checking all file systems...
fsck 1.35 (28-Feb-2004)
Setting kernel variables ...
... done.
Mounting local filesystems...
Cleaning /tmp /var/run /var/lock.
Running 0dns-down to make sure resolv.conf is ok...done.
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...Internet Software Consortium DHCP Client 2.0pl5
Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
All rights reserved.

Please contribute if you find this software useful.
For info, please visit http://www.isc.org/dhcp-contrib.html

Listening on LPF/eth0/00:0e:7f:b4:69:94
Sending on   LPF/eth0/00:0e:7f:b4:69:94
Sending on   Socket/fallback/fallback-net
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 8
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 10
DHCPOFFER from 10.0.0.1
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPACK from 10.0.0.1
bound to 10.36.62.114 -- renewal in 129600 seconds.
done.
Loading the saved-state of the serial devices... 
/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A

Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Thu Sep 23 14:22:32 MDT 2004

Running ntpdate to synchronize clock.
Initializing random number generator...done.
Recovering nvi editor sessions... done.
Setting up X server socket directory /tmp/.X11-unix...done.
Setting up ICE socket directory /tmp/.ICE-unix...done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting MTA: 2004-09-23 14:22:36 Failed to open configuration file /etc/exim/exim.conf
Starting internet superserver: inetd.
Starting OpenBSD Secure Shell server: sshd/etc/ssh/sshd_config line 19: Deprecated option PAMAuthenticationViaKbdInt
/etc/ssh/sshd_config line 38: Deprecated option RhostsAuthentication
.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.

Debian GNU/Linux testing/unstable dl360 ttyS0

dl360 login: 
