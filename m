Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVBTBit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVBTBit (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 20:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVBTBid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 20:38:33 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:48364 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261627AbVBTBgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 20:36:23 -0500
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
	interrupts. Fish. Please report.]
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
In-Reply-To: <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
Content-Type: multipart/mixed; boundary="=-pfOtsUIOu75Wr0258udu"
Organization: Kihon Technologies
Date: Sat, 19 Feb 2005 20:36:12 -0500
Message-Id: <1108863372.8413.158.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pfOtsUIOu75Wr0258udu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-02-19 at 16:59 -0800, Linus Torvalds wrote:

> The parent bridge has IO port mappings at 00003000-00006fff, and IO memory 
> mappings at c2000000-cfffffff and f0000000-f7ffffff. The cardbus stuff 
> _should_ all be behind those regions, but instead they are at 3fefb000 and 
> 40000000-40fff000 (memory-mapped) and 00004000-00004cff (IO mapped).
> 

Damn, I should have noticed that too, but I was so convinced that the
PCMCIA was broken (since that's usually what is) that I didn't look
elsewhere.

> So something is seriously broken.
> 
> That's a PCI layer brokenness, btw, not a PCMCIA brokenness. 
> 

> Can you enable debugging in arch/i386/pci/pci.h and post the whole bootup 
> dmesg. Also, can you show what /proc/iomem looks like, and what 

> 	ls -R /sys/devices/pci*
> 

Here's the scoop:

cat /proc/iomem:

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cfbff : Video ROM
000d0000-000d17ff : Adapter ROM
000d1800-000d27ff : Adapter ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0f6effff : System RAM
  00100000-00300976 : Kernel code
  00300977-003d72ff : Kernel data
0f6f0000-0f6fffff : reserved
0f700000-3feeffff : System RAM
3fef0000-3fef7fff : ACPI Tables
3fef8000-3fef9fff : ACPI Non-volatile Storage
3fefa000-3fefa3ff : 0000:00:1f.1
3fefb000-3fefbfff : 0000:02:01.0
  3fefb000-3fefbfff : yenta_socket
3fefc000-3fefcfff : 0000:02:01.1
  3fefc000-3fefcfff : yenta_socket
3ff00000-3fffffff : reserved
40000000-403fffff : PCI CardBus #03
40400000-407fffff : PCI CardBus #03
40800000-40bfffff : PCI CardBus #07
40c00000-40ffffff : PCI CardBus #07
c0000000-c00003ff : 0000:00:1d.7
  c0000000-c00003ff : ehci_hcd
c0000800-c00008ff : 0000:00:1f.5
  c0000800-c00008ff : Intel 82801DB-ICH4
c0000c00-c0000dff : 0000:00:1f.5
  c0000c00-c0000dff : Intel 82801DB-ICH4
c1000000-c1ffffff : PCI Bus #01
  c1000000-c1ffffff : 0000:01:00.0
    c1000000-c1ffffff : nvidia
c2000000-c200ffff : 0000:02:00.0
  c2000000-c200ffff : tg3
c2010000-c201ffff : 0000:02:02.0
  c2010000-c201ffff : ath
d0000000-dfffffff : 0000:00:00.0
e0000000-efffffff : PCI Bus #01
  e0000000-efffffff : 0000:01:00.0
    e0000000-e7ffffff : vesafb
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
ff800000-ffffffff : reserved

============================================================
cat /proc/ioports

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
03bc-03be : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : PM1a_EVT_BLK
    1004-1005 : PM1a_CNT_BLK
    1008-100b : PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : PM2_CNT_BLK
    1028-102f : GPE0_BLK
1180-11bf : 0000:00:1f.0
  1180-11bf : motherboard
1800-181f : 0000:00:1d.0
  1800-181f : uhci_hcd
1820-183f : 0000:00:1d.1
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.2
  1840-185f : uhci_hcd
1860-186f : 0000:00:1f.1
1880-189f : 0000:00:1f.3
  1880-188f : i801-smbus
18c0-18ff : 0000:00:1f.5
  18c0-18ff : Intel 82801DB-ICH4
1c00-1cff : 0000:00:1f.5
  1c00-1cff : Intel 82801DB-ICH4
2000-207f : 0000:00:1f.6
  2000-207f : Intel 82801DB-ICH4 Modem
2400-24ff : 0000:00:1f.6
  2400-24ff : Intel 82801DB-ICH4 Modem
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
4800-48ff : PCI CardBus #07
4c00-4cff : PCI CardBus #07

=======================================================

ls -R /sys/devices/pci*

/sys/devices/pci0000:00/:
0000:00:00.0
0000:00:00.1
0000:00:00.3
0000:00:01.0
0000:00:1d.0
0000:00:1d.1
0000:00:1d.2
0000:00:1d.7
0000:00:1e.0
0000:00:1f.0
0000:00:1f.1
0000:00:1f.3
0000:00:1f.5
0000:00:1f.6
detach_state
power

/sys/devices/pci0000:00/0000:00:00.0:
class
config
detach_state
device
driver
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:00.0/power:
state

/sys/devices/pci0000:00/0000:00:00.1:
class
config
detach_state
device
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:00.1/power:
state

/sys/devices/pci0000:00/0000:00:00.3:
class
config
detach_state
device
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:00.3/power:
state

/sys/devices/pci0000:00/0000:00:01.0:
0000:01:00.0
class
config
detach_state
device
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0:
class
config
detach_state
device
driver
irq
local_cpus
power
resource
rom
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/power:
state

/sys/devices/pci0000:00/0000:00:01.0/power:
state

/sys/devices/pci0000:00/0000:00:1d.0:
class
config
detach_state
device
driver
irq
local_cpus
pools
power
resource
subsystem_device
subsystem_vendor
usb1
vendor

/sys/devices/pci0000:00/0000:00:1d.0/power:
state

/sys/devices/pci0000:00/0000:00:1d.0/usb1:
1-0:1.0
1-2
bcdDevice
bConfigurationValue
bDeviceClass
bDeviceProtocol
bDeviceSubClass
bmAttributes
bMaxPower
bNumConfigurations
bNumInterfaces
configuration
detach_state
devnum
driver
idProduct
idVendor
manufacturer
maxchild
power
product
serial
speed
version

/sys/devices/pci0000:00/0000:00:1d.0/usb1/1-0:1.0:
bAlternateSetting
bInterfaceClass
bInterfaceNumber
bInterfaceProtocol
bInterfaceSubClass
bNumEndpoints
detach_state
driver
power

/sys/devices/pci0000:00/0000:00:1d.0/usb1/1-0:1.0/power:
state

/sys/devices/pci0000:00/0000:00:1d.0/usb1/1-2:
1-2:1.0
bcdDevice
bConfigurationValue
bDeviceClass
bDeviceProtocol
bDeviceSubClass
bmAttributes
bMaxPower
bNumConfigurations
bNumInterfaces
configuration
detach_state
devnum
driver
idProduct
idVendor
manufacturer
maxchild
power
product
serial
speed
version

/sys/devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0:
bAlternateSetting
bInterfaceClass
bInterfaceNumber
bInterfaceProtocol
bInterfaceSubClass
bNumEndpoints
detach_state
driver
power
ttyUSB0

/sys/devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0/power:
state

/sys/devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0/ttyUSB0:
detach_state
driver
power

/sys/devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0/ttyUSB0/power:
state

/sys/devices/pci0000:00/0000:00:1d.0/usb1/1-2/power:
state

/sys/devices/pci0000:00/0000:00:1d.0/usb1/power:
state

/sys/devices/pci0000:00/0000:00:1d.1:
class
config
detach_state
device
driver
irq
local_cpus
pools
power
resource
subsystem_device
subsystem_vendor
usb2
vendor

/sys/devices/pci0000:00/0000:00:1d.1/power:
state

/sys/devices/pci0000:00/0000:00:1d.1/usb2:
2-0:1.0
bcdDevice
bConfigurationValue
bDeviceClass
bDeviceProtocol
bDeviceSubClass
bmAttributes
bMaxPower
bNumConfigurations
bNumInterfaces
configuration
detach_state
devnum
driver
idProduct
idVendor
manufacturer
maxchild
power
product
serial
speed
version

/sys/devices/pci0000:00/0000:00:1d.1/usb2/2-0:1.0:
bAlternateSetting
bInterfaceClass
bInterfaceNumber
bInterfaceProtocol
bInterfaceSubClass
bNumEndpoints
detach_state
driver
power

/sys/devices/pci0000:00/0000:00:1d.1/usb2/2-0:1.0/power:
state

/sys/devices/pci0000:00/0000:00:1d.1/usb2/power:
state

/sys/devices/pci0000:00/0000:00:1d.2:
class
config
detach_state
device
driver
irq
local_cpus
pools
power
resource
subsystem_device
subsystem_vendor
usb3
vendor

/sys/devices/pci0000:00/0000:00:1d.2/power:
state

/sys/devices/pci0000:00/0000:00:1d.2/usb3:
3-0:1.0
bcdDevice
bConfigurationValue
bDeviceClass
bDeviceProtocol
bDeviceSubClass
bmAttributes
bMaxPower
bNumConfigurations
bNumInterfaces
configuration
detach_state
devnum
driver
idProduct
idVendor
manufacturer
maxchild
power
product
serial
speed
version

/sys/devices/pci0000:00/0000:00:1d.2/usb3/3-0:1.0:
bAlternateSetting
bInterfaceClass
bInterfaceNumber
bInterfaceProtocol
bInterfaceSubClass
bNumEndpoints
detach_state
driver
power

/sys/devices/pci0000:00/0000:00:1d.2/usb3/3-0:1.0/power:
state

/sys/devices/pci0000:00/0000:00:1d.2/usb3/power:
state

/sys/devices/pci0000:00/0000:00:1d.7:
class
config
detach_state
device
driver
irq
local_cpus
pools
power
resource
subsystem_device
subsystem_vendor
usb4
vendor

/sys/devices/pci0000:00/0000:00:1d.7/power:
state

/sys/devices/pci0000:00/0000:00:1d.7/usb4:
4-0:1.0
bcdDevice
bConfigurationValue
bDeviceClass
bDeviceProtocol
bDeviceSubClass
bmAttributes
bMaxPower
bNumConfigurations
bNumInterfaces
configuration
detach_state
devnum
driver
idProduct
idVendor
manufacturer
maxchild
power
product
serial
speed
version

/sys/devices/pci0000:00/0000:00:1d.7/usb4/4-0:1.0:
bAlternateSetting
bInterfaceClass
bInterfaceNumber
bInterfaceProtocol
bInterfaceSubClass
bNumEndpoints
detach_state
driver
power

/sys/devices/pci0000:00/0000:00:1d.7/usb4/4-0:1.0/power:
state

/sys/devices/pci0000:00/0000:00:1d.7/usb4/power:
state

/sys/devices/pci0000:00/0000:00:1e.0:
0000:02:00.0
0000:02:01.0
0000:02:01.1
0000:02:02.0
class
config
detach_state
device
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1e.0/0000:02:00.0:
class
config
detach_state
device
driver
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1e.0/0000:02:00.0/power:
state

/sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.0:
class
config
detach_state
device
driver
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.0/power:
state

/sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.1:
class
config
detach_state
device
driver
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.1/power:
state

/sys/devices/pci0000:00/0000:00:1e.0/0000:02:02.0:
class
config
detach_state
device
driver
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1e.0/0000:02:02.0/power:
state

/sys/devices/pci0000:00/0000:00:1e.0/power:
state

/sys/devices/pci0000:00/0000:00:1f.0:
class
config
detach_state
device
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1f.0/power:
state

/sys/devices/pci0000:00/0000:00:1f.1:
class
config
detach_state
device
driver
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1f.1/power:
state

/sys/devices/pci0000:00/0000:00:1f.3:
class
config
detach_state
device
driver
i2c-0
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1f.3/i2c-0:
detach_state
name
power

/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/power:
state

/sys/devices/pci0000:00/0000:00:1f.3/power:
state

/sys/devices/pci0000:00/0000:00:1f.5:
class
config
detach_state
device
driver
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1f.5/power:
state

/sys/devices/pci0000:00/0000:00:1f.6:
class
config
detach_state
device
driver
irq
local_cpus
power
resource
subsystem_device
subsystem_vendor
vendor

/sys/devices/pci0000:00/0000:00:1f.6/power:
state

/sys/devices/pci0000:00/power:
state

==============================================================


dmesg is attached.

Thanks,

-- Steve


--=-pfOtsUIOu75Wr0258udu
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.10 (root@bilbo) (gcc version 3.3.5 (Debian 1:3.3.5-8)) #13 SMP Sat Feb 19 20:12:19 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
 BIOS-e820: 000000000f6f0000 - 000000000f700000 (reserved)
 BIOS-e820: 000000000f700000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003fef8000 (ACPI data)
 BIOS-e820: 000000003fef8000 - 000000003fefa000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6db0
On node 0 totalpages: 261872
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32496 pages, LIFO batch:7
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6d80
ACPI: XSDT (v001 IBM    TP-1X    0x00001030  LTP 0x00000000) @ 0x3fef1ace
ACPI: FADT (v002 IBM    TP-1X    0x00001030 IBM  0x00000001) @ 0x3fef1b2a
ACPI: SSDT (v001 IBM    TP-1X    0x00001030 MSFT 0x0100000d) @ 0x3fef1bde
ACPI: ECDT (v001 IBM    TP-1X    0x00001030 IBM  0x00000001) @ 0x3fef7eb5
ACPI: MADT (v001 IBM    TP-1X    0x00001030 LOHR 0x00000064) @ 0x3fef7f06
ACPI: HPET (v001 IBM    TP-1X    0x00001030 PTL  0x00000064) @ 0x3fef7f6e
ACPI: TCPA (v001 IBM    TP-1X    0x00001030 PTL  0x00000001) @ 0x3fef7fa6
ACPI: BOOT (v001 IBM    TP-1X    0x00001030  LTP 0x00000001) @ 0x3fef7fd8
ACPI: DSDT (v001 IBM    TP-1X    0x00001030 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1 already used, trying 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0x0
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro vga=0x305 3
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3320.885 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034040k/1047488k available (2050k kernel code, 12748k reserved, 858k data, 220k init, 129984k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6586.36 BogoMIPS (lpj=3293184)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:................................................................................................................................................................................................................................................
Table [DSDT](id F005) - 884 Objects with 52 Devices 240 Methods 15 Regions
Parsing all Control Methods:.
Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI Namespace successfully loaded at root c043a0e0
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
CPU0: Intel Mobile Intel(R) Pentium(R) 4 CPU 3.33GHz stepping 01
per-CPU timeslice cutoff: 2926.44 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 6619.13 BogoMIPS (lpj=3309568)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel Mobile Intel(R) Pentium(R) 4 CPU 3.33GHz stepping 01
Total of 2 processors activated (13205.50 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: 
CPU#0 had 0 usecs TSC skew, fixed it up.
CPU#1 had 0 usecs TSC skew, fixed it up.
Brought up 2 CPUs
CPU0:
 domain 0: span 03
  groups: 01 02
  domain 1: span 03
   groups: 03
CPU1:
 domain 0: span 03
  groups: 02 01
  domain 1: span 03
   groups: 03
NET: Registered protocol family 16
PCI: BIOS32 Service Directory structure at 0xc00f6d40
PCI: BIOS32 Service Directory entry at 0xfd700
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=08
PCI: PCI BIOS revision 2.10 entry at 0xfd960, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 6 Wake, Enabled 0 Runtime GPEs in this block
ACPI: Found ECDT
ACPI: Could not use ECDT
Completing Region/Field/Buffer/Package initialization:.....................................................................................................................................................
Initialized 15/15 Regions 73/73 Fields 50/50 Buffers 11/19 Packages (894 nodes)
Executing all Device _STA and_INI methods:........................................................
56 Devices found containing: 56 _STA, 4 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: IDE base address fixup for 0000:00:1f.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: Scanning for ghost devices on bus 2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
PCI: IRQ init
PCI: Allocating resources
PCI: Resource d0000000-dfffffff (f=1208, d=0, p=0)
PCI: Resource 00001800-0000181f (f=101, d=0, p=0)
PCI: Resource 00001820-0000183f (f=101, d=0, p=0)
PCI: Resource 00001840-0000185f (f=101, d=0, p=0)
PCI: Resource c0000000-c00003ff (f=200, d=0, p=0)
PCI: Resource 00001860-0000186f (f=101, d=0, p=0)
PCI: Resource 00001880-0000189f (f=101, d=0, p=0)
PCI: Resource 00001c00-00001cff (f=101, d=0, p=0)
PCI: Resource 000018c0-000018ff (f=101, d=0, p=0)
PCI: Resource c0000c00-c0000dff (f=200, d=0, p=0)
PCI: Resource c0000800-c00008ff (f=200, d=0, p=0)
PCI: Resource 00002400-000024ff (f=101, d=0, p=0)
PCI: Resource 00002000-0000207f (f=101, d=0, p=0)
PCI: Resource c1000000-c1ffffff (f=200, d=0, p=0)
PCI: Resource e0000000-efffffff (f=1208, d=0, p=0)
PCI: Resource c2000000-c200ffff (f=204, d=0, p=0)
PCI: Resource c2010000-c201ffff (f=200, d=0, p=0)
PCI: Sorting device list...
Simple Boot Flag at 0x35 set to 0x1
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
vesafb: framebuffer at 0xe0000000, mapped to 0xf8880000, using 1536k, total 131072k
vesafb: mode is 1024x768x8, linelength=1024, pages=3
vesafb: protected mode interface info at c000:e600
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 169
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: HTS548080M9AT00, ATA DISK drive
Probing IDE interface ide1...
hdc: MATSHITADVD-RAM UJ-811, ATAPI CD/DVD-ROM drive
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/7877KiB Cache, CHS=65535/16/63
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices: 
 LID SLPB PCI0 BLAN CBS0 CBS1 USB0 USB1 USB2 AC97 
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
NET: Registered protocol family 1
hdc: ATAPI 63X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
Adding 2736680k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Generic RTC Driver v1.07
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
ts: Compaq touchscreen protocol output
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 20 (level, low) -> IRQ 177
Yenta: CardBus bridge found at 0000:02:01.0 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.0, mfunc 0x01001c22, devctl 0x64
Yenta TI: socket 0000:02:01.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:02:01.0 no PCI interrupts. Fish. Please report.
Yenta: ISA IRQ mask 0x0000, PCI irq 0
Socket status: ffffffff
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 21 (level, low) -> IRQ 185
Yenta: CardBus bridge found at 0000:02:01.1 [1014:0512]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:01.1, mfunc 0x01001c22, devctl 0x64
Yenta TI: socket 0000:02:01.1 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:02:01.1 no PCI interrupts. Fish. Please report.
Yenta: ISA IRQ mask 0x0000, PCI irq 0
Socket status: 4410080c
tg3.c:v3.14 (November 15, 2004)
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 193
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:06:1b:c6:7c:03
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.14.9 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413)
wlan: 0.8.4.5 (EXPERIMENTAL)
ath_rate_onoe: 1.0
ath_pci: 0.9.4.12 (EXPERIMENTAL)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 18 (level, low) -> IRQ 201
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: mac 5.9 phy 4.3 radio 4.6
ath0: 802.11 address: 00:0e:9b:85:92:61
ath0: Use hw queue 0 for WME_AC_BE traffic
ath0: Use hw queue 1 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Atheros 5212: mem=0xc2010000, irq=201
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
ICH4: port 0x01f0 already claimed by ide0
ICH4: port 0x0170 already claimed by ide1
ICH4: neither IDE port enabled (BIOS)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 193
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 193, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 209
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 209, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 201
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
usb 1-2: new full speed USB device using uhci_hcd and address 2
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 201, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adapter
belkin 1-2:1.0: Belkin / Peracom / GoHubs USB Serial Adapter converter detected
drivers/usb/serial/belkin_sa.c: bcdDevice: 0205, bfc: 1
usb 1-2: Belkin / Peracom / GoHubs USB Serial Adapter converter now attached to ttyUSB0
usbcore: registered new driver belkin
drivers/usb/serial/belkin_sa.c: USB Belkin Serial converter driver v1.2
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 217
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 217, pci mem 0xc0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 1-2: USB disconnect, address 2
belkin ttyUSB0: Belkin / Peracom / GoHubs USB Serial Adapter converter now disconnected from ttyUSB0
belkin 1-2:1.0: device disconnected
usb 1-2: new full speed USB device using uhci_hcd and address 3
belkin 1-2:1.0: Belkin / Peracom / GoHubs USB Serial Adapter converter detected
drivers/usb/serial/belkin_sa.c: bcdDevice: 0205, bfc: 1
usb 1-2: Belkin / Peracom / GoHubs USB Serial Adapter converter now attached to ttyUSB0
input: PC Speaker
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x3bc, irq 7 [PCSPP,TRISTATE]
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855GM Chipset.
agpgart: Maximum main memory to use for agp memory: 940M
agpgart: AGP aperture is 256M @ 0xd0000000
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
hw_random: RNG not detected
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 50391 usecs
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1f.6 to 64
MC'97 1 converters and GPIO not ready (0xff00)
NET: Registered protocol family 17
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03a0aa0(lo)
IPv6 over IPv4 tunneling driver
ACPI: Battery Slot [BAT1] (battery present)
ACPI: AC Adapter [AC] (on-line)
ACPI: Processor [CPU0] (supports 4 throttling states)
ACPI: Processor [CPU1] (supports 4 throttling states)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Thermal Zone [THRM] (53 C)
lp0: using parport0 (interrupt-driven).
eth0: no IPv6 routers present
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x80f
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.6
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS not found.
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 17 (level, low) -> IRQ 169
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov  3 13:12:51 PST 2004
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
inserting floppy driver for 2.6.10
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found

--=-pfOtsUIOu75Wr0258udu--

