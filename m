Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTE0JAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTE0JAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:00:49 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:10625 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S262861AbTE0I7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:59:20 -0400
Message-ID: <3ED32BA4.4040707@winischhofer.net>
Date: Tue, 27 May 2003 11:11:00 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030521 Debian/1.3.1-1
X-Accept-Language: en-us, en, de-at, de, de-de, sv
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sis650 irq router fix for 2.4.x
References: <3ED21CE3.9060400@winischhofer.net> <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>
Content-Type: multipart/mixed;
 boundary="------------070104040906030607000000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070104040906030607000000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


To Alan who is perhaps reading this: Who is an expert on this type of stuff?

Davide Libenzi wrote:
> On Mon, 26 May 2003, Thomas Winischhofer wrote:
> 
> 
>>and I had (and have) no problems with irqs or USB (or anything) on any
>>of these machines.

First, let me say that I know NIL about irq routing. But fact is, I had 
my machines running with webcams, floppy drives and mice (all via USB, 
that is) - and had no problem.

But you got me puzzled: As a matter of fact, it seems that ALL (!) my 
650 variants show different routing tables, mostly like yours.

dmesg with pci-debug enabled and lspci -vxxx printouts attached.

650 = "ISA bridge" revision 0
M650 = revision 4
651 = revision 0x25

Interestingly, as soon as pci-debugging was enabled, the log is full 
with error messages, and I suddenly actually _had_ problems with my 
network card and my wireless card (and assumingly the USB stuff, too, 
conclusing from the "failed" statements in the log)....

>>Are you sure that checking the revision number of the device is enough?
> 
> 
> It seems reasonble, at least without having the spec for the chipset. All
> my searches failed about docs. Previous cases are correctly handled like
> before, as you can see from the patch.

I myself doubt this now. If I am reading the dmesg output correctly, 
even the machine with revision 0 (plain 650) is routing _some_ of the 
interrupts with 0x6x requests...

> You happen to have the spec for the SIS650 ?

That's a good one :) I have been bugging SiS since 2001 for docs, all I 
got was nothing.

 > The reality is that the
> chipset issues 0x60..0x63 router request and the current kernel will not
> correctly initialize device under that spot. So either we have a too
> strict implementation in the current router (we should by default pass
> thru unknown requests) or we need to fix it according to the new requests.
> The "stdroute" thing is a way to keep the strict behaviour by default, and
> yet have the ability to pass thru w/out the need of patching the kernel.
> 
> 
> Below is reported the boot with PCI debug enabled and the content of my
> PCI devices configuration space. If you have a better idea on how to fix
> it, please submit a patch.

As said, I know nothing about this stuff. The last time I dealt with 
irqs was on the Amiga...



Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org

--------------070104040906030607000000
Content-Type: text/plain;
 name="dmesg_650"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_650"

Linux version 2.4.20 (root@stockholm) (gcc version 2.95.4 20011002 (Debian prerelease)) #7 Tue May 27 01:31:05 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ec000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001e000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff0ffff (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
480MB LOWMEM available.
On node 0 totalpages: 122880
zone(0): 4096 pages.
zone(1): 118784 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=LinuxOLD ro root=302
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1712.579 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3420.97 BogoMIPS
Memory: 483780k/491520k available (1202k kernel code, 7352k reserved, 524k data, 96k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 1.70GHz stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: BIOS32 Service Directory structure at 0xc00fdb00
PCI: BIOS32 Service Directory entry at 0xfdb10
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address trash cleared for 00:02.5
PCI: IDE base address fixup for 00:02.5
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f7ba0
00:01 slot=00 0:41/d898 1:42/d898 2:43/d898 3:44/d898
00:02 slot=00 0:63/d898 1:42/d898 2:61/d898 3:60/d898
00:03 slot=00 0:62/d898 1:00/0000 2:00/0000 3:00/0000
00:06 slot=01 0:42/d898 1:43/d898 2:44/d898 3:41/d898
00:07 slot=02 0:43/d898 1:44/d898 2:41/d898 3:42/d898
00:0c slot=00 0:44/d898 1:00/0000 2:00/0000 3:00/0000
00:0e slot=00 0:42/d898 1:43/d898 2:44/d898 3:41/d898
00:0f slot=00 0:42/d898 1:43/d898 2:44/d898 3:41/d898
PCI: Attempting to find IRQ router for 1039:0008
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
PCI: IRQ fixup
00:07.0: ignoring bogus IRQ 255
IRQ for 00:07.0:0 -> PIRQ 43, mask d898, excl 0000 -> newirq=0 ... failed
PCI: Allocating resources
PCI: Resource e0000000-e3ffffff (f=200, d=0, p=0)
PCI: Resource dfffa000-dfffafff (f=200, d=0, p=0)
PCI: Resource dfffb000-dfffbfff (f=200, d=0, p=0)
PCI: Resource 0000ff00-0000ff0f (f=101, d=0, p=0)
PCI: Resource 0000dc00-0000dcff (f=101, d=0, p=0)
PCI: Resource 0000d800-0000d87f (f=101, d=0, p=0)
PCI: Resource 0000d400-0000d4ff (f=101, d=0, p=0)
PCI: Resource dfff9f00-dfff9fff (f=200, d=0, p=0)
PCI: Resource dfff8000-dfff8fff (f=200, d=0, p=0)
PCI: Resource 0000d000-0000d0ff (f=101, d=0, p=0)
PCI: Resource dfff9e00-dfff9eff (f=200, d=0, p=0)
PCI: Resource d0000000-d7ffffff (f=1208, d=0, p=0)
PCI: Resource dfee0000-dfefffff (f=200, d=0, p=0)
PCI: Resource 0000ac00-0000ac7f (f=101, d=0, p=0)
PCI: Sorting device list...
...
usb.c: registered new driver hub
IRQ for 00:02.3:0 -> PIRQ 63, mask d898, excl 0000 -> newirq=11<6>SiS router pirq escape (99)
 -> assigning IRQ 11<6>SiS router pirq escape (99)
 ... failed
usb-ohci.c: USB OHCI at membase 0xde816000, IRQ 11
usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
IRQ for 00:02.2:3 -> PIRQ 60, mask d898, excl 0000 -> newirq=11<6>SiS router pirq escape (96)
 -> assigning IRQ 11<6>SiS router pirq escape (96)
 ... failed
usb-ohci.c: USB OHCI at membase 0xde818000, IRQ 11
usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
...
8139too Fast Ethernet driver 0.9.26
IRQ for 00:06.0:0 -> PIRQ 42, mask d898, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:06.0
PCI: Sharing IRQ 11 with 00:0f.0
eth0: RealTek RTL8139 Fast Ethernet at 0xde88bf00, 00:02:44:63:79:96, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
IRQ for 00:0f.0:0 -> PIRQ 42, mask d898, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0f.0
PCI: Sharing IRQ 11 with 00:06.0
eth1: RealTek RTL8139 Fast Ethernet at 0xde88de00, 00:10:dc:6b:b0:92, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139C'
...
IRQ for 00:02.7:2 -> PIRQ 61, mask d898, excl 0000 -> newirq=11<6>SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
 -> assigning IRQ 11<6>advanced SiS pirq mapping not yet implemented
 ... failed
...
Linux PCMCIA Card Services 3.2.4
  kernel build: 2.4.20 #6 Mon May 19 01:56:26 CEST 2003
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Enabling device 00:07.0 (0000 -> 0002)
IRQ for 00:07.0:0 -> PIRQ 43, mask d898, excl 0000 -> newirq=11 -> assigning IRQ 11 ... OK
PCI: Assigned IRQ 11 for device 00:07.0


--------------070104040906030607000000
Content-Type: text/plain;
 name="dmesg_651"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_651"

Linux version 2.4.20 (root@malmoe) (gcc version 3.3 (Debian)) #4 Tue May 27 03:19:33 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dff0000 (usable)
 BIOS-e820: 000000001dff0000 - 000000001dff8000 (ACPI data)
 BIOS-e820: 000000001dff8000 - 000000001e000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff0ffff (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
479MB LOWMEM available.
found SMP MP-table at 000fb9a0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 122864
zone(0): 4096 pages.
zone(1): 118768 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: SiS      Product ID: 645          APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
Kernel command line: BOOT_IMAGE=LinuxOLD ro root=305 hdc=ide-scsi
ide_setup: hdc=ide-scsi
...
PCI: BIOS32 Service Directory structure at 0xc00fdb00
PCI: BIOS32 Service Directory entry at 0xfdb10
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=02
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address trash cleared for 00:02.5
PCI: IDE base address fixup for 00:02.5
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f7600
00:01 slot=00 0:41/d898 1:42/d898 2:43/d898 3:44/d898
00:02 slot=00 0:41/d898 1:42/d898 2:43/d898 3:44/d898
00:03 slot=00 0:60/d898 1:61/d898 2:62/d898 3:63/d898
00:04 slot=00 0:44/d898 1:00/0000 2:00/0000 3:00/0000
00:06 slot=01 0:42/d898 1:43/d898 2:44/d898 3:41/d898
00:07 slot=02 0:43/d898 1:44/d898 2:41/d898 3:42/d898
00:0c slot=00 0:44/d898 1:41/d898 2:42/d898 3:43/d898
00:0e slot=00 0:42/d898 1:43/d898 2:44/d898 3:41/d898
00:0f slot=00 0:42/d898 1:43/d898 2:44/d898 3:41/d898
PCI: Attempting to find IRQ router for 1039:0008
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
PCI: IRQ fixup
IRQ for 00:0e.0:0 -> PIRQ 42, mask d898, excl 0000 -> newirq=0 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0e.0
PCI: Sharing IRQ 11 with 00:06.0
PCI: Sharing IRQ 11 with 00:0e.1
PCI: Sharing IRQ 11 with 00:0f.0
PCI: Allocating resources
PCI: Resource e0000000-e3ffffff (f=200, d=0, p=0)
PCI: Resource 0000ff00-0000ff0f (f=101, d=0, p=0)
PCI: Resource 0000d800-0000d8ff (f=101, d=0, p=0)
PCI: Resource 0000d400-0000d47f (f=101, d=0, p=0)
PCI: Resource dfff9000-dfff9fff (f=200, d=0, p=0)
PCI: Resource dfffa000-dfffafff (f=200, d=0, p=0)
PCI: Resource dfffb000-dfffbfff (f=200, d=0, p=0)
PCI: Resource 0000d000-0000d01f (f=101, d=0, p=0)
PCI: Resource 0000dc00-0000dc07 (f=101, d=0, p=0)
PCI: Resource dfff8000-dfff8fff (f=200, d=0, p=0)
PCI: Resource 0000cc00-0000ccff (f=101, d=0, p=0)
PCI: Resource dfff7f00-dfff7fff (f=200, d=0, p=0)
PCI: Resource d0000000-d7ffffff (f=1208, d=0, p=0)
PCI: Resource dfee0000-dfefffff (f=200, d=0, p=0)
PCI: Resource 0000ac00-0000ac7f (f=101, d=0, p=0)
PCI: Sorting device list...
...
8139too Fast Ethernet driver 0.9.26
IRQ for 00:0f.0:0 -> PIRQ 42, mask d898, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0f.0
PCI: Sharing IRQ 11 with 00:06.0
PCI: Sharing IRQ 11 with 00:0e.1
PCI: Sharing IRQ 11 with 00:0e.0
eth0: RealTek RTL8139 Fast Ethernet at 0xde800f00, 00:10:dc:f6:6e:56, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
...
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
IRQ for 00:03.3:3 -> PIRQ 63, mask d898, excl 0000 -> newirq=11<6>SiS router pirq escape (99)
 -> assigning IRQ 11<6>SiS router pirq escape (99)
 ... failed
hcd.c: ehci-hcd @ 00:03.3, PCI device 1039:7002 (Silicon Integrated Systems [SiS])
hcd.c: irq 11, pci mem de856000
usb.c: new USB bus registered, assigned bus number 1
ehci-hcd.c: USB 2.0 support enabled, EHCI rev 1. 0
hub.c: USB hub found
hub.c: 6 ports detected
IRQ for 00:03.1:1 -> PIRQ 61, mask d898, excl 0000 -> newirq=11<6>SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
 -> assigning IRQ 11<6>advanced SiS pirq mapping not yet implemented
 ... failed
usb-ohci.c: USB OHCI at membase 0xde85e000, IRQ 11
usb-ohci.c: usb-00:03.1, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
IRQ for 00:03.0:0 -> PIRQ 60, mask d898, excl 0000 -> newirq=11<6>SiS router pirq escape (96)
 -> assigning IRQ 11<6>SiS router pirq escape (96)
 ... failed
usb-ohci.c: USB OHCI at membase 0xde860000, IRQ 11
usb-ohci.c: usb-00:03.0, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 3 ports detected
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
IRQ for 00:06.0:0 -> PIRQ 42, mask d898, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:06.0
PCI: Sharing IRQ 11 with 00:0e.1
PCI: Sharing IRQ 11 with 00:0e.0
PCI: Sharing IRQ 11 with 00:0f.0
IRQ for 00:02.7:2 -> PIRQ 43, mask d898, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:02.7
intel8x0: clocking to 48000
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 00:0e.1 (0000 -> 0002)
IRQ for 00:0e.1:0 -> PIRQ 42, mask d898, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0e.1
PCI: Sharing IRQ 11 with 00:06.0
PCI: Sharing IRQ 11 with 00:0e.0
PCI: Sharing IRQ 11 with 00:0f.0
PCI: Enabling device 00:0e.0 (0000 -> 0002)
IRQ for 00:0e.0:0 -> PIRQ 42, mask d898, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0e.0
PCI: Sharing IRQ 11 with 00:06.0
PCI: Sharing IRQ 11 with 00:0e.1
PCI: Sharing IRQ 11 with 00:0f.0
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
Yenta IRQ list 0698, PCI irq11


--------------070104040906030607000000
Content-Type: text/plain;
 name="dmesg_M650"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_M650"

Linux version 2.4.20-xfs (root@oland) (gcc version 2.95.4 20011002 (Debian prerelease)) #8 Tue May 27 10:33:07 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dff0000 (usable)
 BIOS-e820: 000000001dff0000 - 000000001dff8000 (ACPI data)
 BIOS-e820: 000000001dff8000 - 000000001e000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff0ffff (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
479MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 122864
zone(0): 4096 pages.
zone(1): 118768 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000fa370
ACPI: RSDT (v001 AMIINT SiS645XX 00000.00016) @ 0x1dff0000
ACPI: FADT (v001 AMIINT SiS645XX 00000.00017) @ 0x1dff0030
ACPI: DSDT (v001     UW Elfin___ 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=TEST ro root=303 hdc=ide-scsi pci=noacpi
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
...
ACPI: Subsystem revision 20021212
PCI: BIOS32 Service Directory structure at 0xc00fda10
PCI: BIOS32 Service Directory entry at 0xfda20
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfda41, last bus=1
PCI: Using configuration type 1
    ACPI-0274: *** Info: Table [DSDT] replaced by host OS
 -> edge    ACPI-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0263: *** Info: GPE Block1 defined as GPE16 to GPE31
    ACPI-0323: *** Error: Handler for [System_memory] returned AE_NO_MEMORY
    ACPI-1103: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node c15369c0), AE_NO_MEMORY
    ACPI-0323: *** Error: Handler for [System_memory] returned AE_NO_MEMORY
    ACPI-1103: *** Error: Method execution failed [\_SB_.PCI0.BAT0._STA] (Node c1571980), AE_NO_MEMORY
    ACPI-0080: *** Error: Method execution failed [\_SB_.PCI0.BAT0._STA] (Node c1571980), AE_NO_MEMORY
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: IDE base address trash cleared for 00:02.5
PCI: IDE base address fixup for 00:02.5
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 2)
schedule_task(): keventd has not started
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 7 10 11 12 14 15)
PCI: Probing PCI hardware
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f7b80
00:01 slot=00 0:41/dcb8 1:42/dcb8 2:43/dcb8 3:44/dcb8
00:02 slot=00 0:41/dcb8 1:42/dcb8 2:43/dcb8 3:44/dcb8
00:03 slot=00 0:60/dcb8 1:61/dcb8 2:62/dcb8 3:63/dcb8
00:04 slot=00 0:44/dcb8 1:00/0000 2:00/0000 3:00/0000
00:0a slot=02 0:42/dcb8 1:00/0000 2:00/0000 3:00/0000
00:08 slot=01 0:43/dcb8 1:00/0000 2:00/0000 3:00/0000
PCI: Attempting to find IRQ router for 1039:0008
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
PCI: IRQ fixup
00:08.0: ignoring bogus IRQ 255
IRQ for 00:08.0:0 -> PIRQ 43, mask dcb8, excl 0000 -> newirq=0 -> got IRQ 10
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:02.6
PCI: Sharing IRQ 10 with 00:02.7
PCI: Allocating resources
PCI: Resource e0000000-e3ffffff (f=200, d=0, p=0)
PCI: Resource dfffb000-dfffbfff (f=200, d=0, p=0)
PCI: Resource 0000ff00-0000ff0f (f=101, d=0, p=0)
PCI: Resource 0000d400-0000d4ff (f=101, d=0, p=0)
PCI: Resource 0000d000-0000d07f (f=101, d=0, p=0)
PCI: Resource 0000dc00-0000dcff (f=101, d=0, p=0)
PCI: Resource 0000d800-0000d87f (f=101, d=0, p=0)
PCI: Resource dfff7000-dfff7fff (f=200, d=0, p=0)
PCI: Resource dfff8000-dfff8fff (f=200, d=0, p=0)
PCI: Resource dfff9000-dfff9fff (f=200, d=0, p=0)
PCI: Resource dfffa000-dfffafff (f=200, d=0, p=0)
PCI: Resource 0000cc00-0000ccff (f=101, d=0, p=0)
PCI: Resource dfff6000-dfff6fff (f=200, d=0, p=0)
PCI: Resource d0000000-d7ffffff (f=1208, d=0, p=0)
PCI: Resource dfee0000-dfefffff (f=200, d=0, p=0)
PCI: Resource 0000ac00-0000ac7f (f=101, d=0, p=0)
PCI: Sorting device list...
...
sis900.c: v1.08.06 9/24/2002
IRQ for 00:04.0:0 -> PIRQ 44, mask dcb8, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 00:04.0
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xcc00, IRQ 10, 00:a0:cc:d9:b5:7a.
..
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
IRQ for 00:08.0:0 -> PIRQ 43, mask dcb8, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:02.6
PCI: Sharing IRQ 10 with 00:02.7
...
Yenta IRQ list 0098, PCI irq10
Socket status: 30000007
...
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
IRQ for 00:03.2:2 -> PIRQ 62, mask dcb8, excl 0000 -> newirq=10 -> assigning IRQ 10 ... OK
PCI: Assigned IRQ 10 for device 00:03.2
usb-ohci.c: USB OHCI at membase 0xde853000, IRQ 10
usb-ohci.c: usb-00:03.2, Silicon Integrated Systems [SiS] 7001 (#3)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
IRQ for 00:03.1:1 -> PIRQ 61, mask dcb8, excl 0000 -> newirq=10<6>SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
 -> assigning IRQ 10<6>advanced SiS pirq mapping not yet implemented
 ... failed
usb-ohci.c: USB OHCI at membase 0xde855000, IRQ 10
usb-ohci.c: usb-00:03.1, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
IRQ for 00:03.0:0 -> PIRQ 60, mask dcb8, excl 0000 -> newirq=11<6>SiS router pirq escape (96)
 -> assigning IRQ 11<6>SiS router pirq escape (96)
 ... failed
usb-ohci.c: USB OHCI at membase 0xde857000, IRQ 11
usb-ohci.c: usb-00:03.0, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
...
IRQ for 00:03.3:3 -> PIRQ 63, mask dcb8, excl 0000 -> newirq=5<6>SiS router pirq escape (99)
 -> assigning IRQ 5<6>SiS router pirq escape (99)
 ... failed
hcd.c: ehci-hcd @ 00:03.3, PCI device 1039:7002 (Silicon Integrated Systems [SiS])
hcd.c: irq 5, pci mem de86c000
usb.c: new USB bus registered, assigned bus number 4
ehci-hcd.c: USB 2.0 support enabled, EHCI rev 1. 0
hub.c: USB hub found
hub.c: 6 ports detected
hub.c: new USB device 00:03.1-1, assigned address 2
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb2:2.0
eth0: Media Link On 100mbps full-duplex 
blk: queue c035b2a4, I/O limit 4095Mb (mask 0xffffffff)
cs: IO port probe 0x0c00-0x0cff: excluding 0xc00-0xc1f
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x837 0x840-0x877
cs: IO port probe 0x0100-0x04ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
mice: PS/2 mouse device common for all mice
IRQ for 00:02.7:2 -> PIRQ 43, mask dcb8, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 00:02.7
PCI: Sharing IRQ 10 with 00:02.6
PCI: Sharing IRQ 10 with 00:08.0
intel8x0: clocking to 48000
...
--------------070104040906030607000000
Content-Type: text/plain;
 name="lspci_650"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_650"

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
	Flags: bus master, medium devsel, latency 32
	Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
00: 39 10 50 06 07 00 10 22 01 00 00 06 00 20 80 00
10: 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fe 09 70 8b 03 03 b3 8e 02 16 00 00 12 d5 22 00
60: 4b 4b 40 40 b3 00 1f 80 01 08 e0 00 48 02 00 00
70: 1f 9f 00 08 02 00 00 00 00 00 00 00 02 00 11 00
80: 22 26 30 00 85 00 80 0b 20 0c 00 01 00 00 00 1e
90: 00 00 ee 1d 43 00 00 05 00 16 75 10 00 00 00 00
a0: c2 c3 44 c2 03 03 01 77 00 00 60 c2 42 09 e0 01
b0: 00 00 01 10 00 00 00 4f 7f 5e 27 2d 00 00 80 00
c0: 02 00 20 00 07 02 00 1f 00 00 00 00 00 00 00 00
d0: 22 02 33 02 49 ff ff 01 66 66 aa 09 00 81 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: cfc00000-dfcfffff
00: 39 10 01 00 07 01 00 00 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 a0 a0 00 00
20: e0 df e0 df c0 cf c0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Flags: bus master, medium devsel, latency 0
00: 39 10 08 00 0f 00 00 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 98 0b 0b 0b 0b 20 37 ad 10 00 00 00 11 20 04 01
50: 11 28 02 01 62 0b 66 0b 9c 2e 12 00 36 06 00 00
60: 0b 0b 80 0b 34 c1 0a 10 80 80 00 0f 00 66 03 00
70: 13 39 00 00 00 08 00 dc 00 00 00 00 06 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5350
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dfffa000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 07 10 03 0c 08 40 00 00
10: 00 a0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 50 53
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 50
40: 00 00 00 00 54 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.3 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5350
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dfffb000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 07 10 03 0c 08 40 00 00
10: 00 b0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 50 53
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 00 00 54 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5350
	Flags: bus master, fast devsel, latency 128
	I/O ports at ff00 [size=16]
00: 39 10 13 55 05 00 00 00 d0 80 01 01 00 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 62 14 50 53
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 31 81 00 00 31 85 00 00 a8 01 e6 55 00 02 00 02
50: 01 00 01 06 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5350
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at dc00 [size=256]
	I/O ports at d800 [size=128]
	Capabilities: [48] Power Management version 2
00: 39 10 12 70 05 01 90 02 a0 00 01 04 00 40 00 00
10: 01 dc 00 00 01 d8 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 50 53
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 03 34 0b
40: 04 00 00 00 00 00 00 00 01 00 42 c0 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Surecom Technology EP-320X-R
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at d400 [size=256]
	Memory at dfff9f00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 01 90 02 10 00 00 02 00 40 00 00
10: 01 d4 00 00 00 9f ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 bd 10 20 03
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 1e000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 a8 02 00
10: 00 00 00 1e a0 00 00 02 00 02 05 b0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 40 07
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 b0 44 00 00 00 00 00 00 00 00 00 22 00 00 00
90: c0 03 60 61 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 00 c0 00 01 08 00 00 1f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00f2 (rev 01) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dfff8000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
00: 33 10 f2 00 16 01 90 02 01 10 00 0c 08 40 00 00
10: 00 80 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 14 2c
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
70: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at d000 [size=256]
	Memory at dfff9e00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 01 90 02 10 00 00 02 00 40 00 00
10: 01 d0 00 00 00 9e ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5350
	Flags: 66Mhz, medium devsel, IRQ 11
	BIST result: 00
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at ac00 [size=128]
	Capabilities: [40] Power Management version 1
	Capabilities: [50] AGP version 2.0
00: 39 10 25 63 03 00 b0 02 00 00 00 03 00 00 00 80
10: 08 00 00 d0 00 00 ee df 01 ac 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 50 53
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 50 01 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 20 00 07 02 00 0f 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--------------070104040906030607000000
Content-Type: text/plain;
 name="lspci_651"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_651"

00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS651 Host (rev 02)
	Flags: bus master, medium devsel, latency 32
	Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
00: 39 10 51 06 07 00 10 22 02 00 00 06 00 20 80 00
10: 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fe 09 70 8b 03 13 b7 0e 42 25 c0 00 12 d5 f2 00
60: 6b 6b 40 40 b1 01 1c 80 01 08 e0 00 48 02 00 00
70: 0f 9f 00 00 02 00 61 00 00 00 00 00 82 00 11 00
80: 22 26 30 03 85 00 80 2b 20 0c 00 01 00 00 04 1e
90: 00 00 00 00 40 04 00 01 00 16 74 10 00 00 00 10
a0: c2 c3 33 c2 03 03 01 77 00 00 00 c2 42 09 e0 01
b0: 00 00 00 10 00 00 00 4f 06 5f 2a 32 00 0c 80 00
c0: 02 00 20 00 07 02 00 1f 00 00 00 00 00 00 00 00
d0: 22 02 33 02 49 ff ff 01 60 60 aa 00 00 81 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfd00000-dfefffff
	Prefetchable memory behind bridge: cfa00000-dfbfffff
00: 39 10 01 00 07 01 00 00 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 02 00 a0 a0 00 00
20: d0 df e0 df a0 cf b0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 25)
	Flags: bus master, medium devsel, latency 0
00: 39 10 08 00 0f 00 00 02 25 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 92 0b 0b 0b 0b 00 3d 8d 10 00 00 00 11 20 04 01
50: 11 28 02 01 62 0a 66 0a 9c 2e 12 00 36 06 00 00
60: 0b 0b 80 0b ff c1 0c 12 89 80 00 46 b7 00 02 11
70: 00 00 00 ff 00 08 00 1c 00 00 20 80 06 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 40 00 00 80 7c 00 04 00 27 63 00 00 00 00 00 00
f0: 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 88 [Master SecP])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Flags: bus master, medium devsel, latency 128
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ff00 [size=16]
00: 39 10 13 55 05 00 00 02 00 88 01 01 00 80 00 00
10: 00 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 39 10 13 55
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 20 00 06 00 00 00 00 00
50: f2 00 fb 80 2a 96 d5 c0 00 00 00 00 00 00 00 00
60: fb aa fb aa 00 00 00 00 00 00 00 00 00 00 00 00
70: 17 21 06 04 b0 66 20 1e 56 23 06 04 b0 66 20 1e
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5350
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at d800 [size=256]
	I/O ports at d400 [size=128]
	Capabilities: [48] Power Management version 2
00: 39 10 12 70 05 01 90 02 a0 00 01 04 00 40 00 00
10: 01 d8 00 00 01 d4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 50 53
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 03 34 0b
40: 04 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5350
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dfff9000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 0f 10 03 0c 08 40 80 00
10: 00 90 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 50 53
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 00 00 5c ac 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5350
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dfffa000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 0f 10 03 0c 08 40 00 00
10: 00 a0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 50 53
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 50
40: 00 00 00 00 5c ac 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0 (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5470
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dfffb000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2
00: 39 10 02 70 06 01 90 02 00 20 03 0c 08 40 00 00
10: 00 b0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 70 54
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 04 00 50
40: 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 0a 00 00 21 00 00 00 00
60: 20 20 7f 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 08 80 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs: Unknown device 8064
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at d000 [size=32]
	Capabilities: [dc] Power Management version 1
00: 02 11 02 00 05 01 90 02 07 00 01 04 00 40 80 00
10: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 64 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 02 14
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 64
	I/O ports at dc00 [size=8]
	Capabilities: [dc] Power Management version 1
00: 02 11 02 70 05 01 90 02 07 00 80 09 00 40 80 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00f2 (rev 01) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 535d
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dfff8000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
00: 33 10 f2 00 16 01 90 02 01 10 00 0c 08 40 00 00
10: 00 80 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 5d 53
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 14 2c
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
70: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0e.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: Unknown device 6933:0002
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
	Memory at 1e000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 1ec00000-1efff000 (prefetchable)
	Memory window 1: 1f000000-1f3ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001
00: 17 12 33 69 87 00 10 04 01 00 07 06 00 a8 82 00
10: 00 00 00 1e a0 00 00 02 00 02 05 b0 00 00 c0 1e
20: 00 f0 ff 1e 00 00 00 1f 00 f0 3f 1f 01 48 00 00
30: fd 48 00 00 01 4c 00 00 fd 4c 00 00 00 01 80 05
40: 33 69 02 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 0f 30 00 0c ca 0b 42 82 00 00 50 20 00 00 00 00
a0: 01 00 02 fe 00 40 c0 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0e.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: Unknown device 6933:0002
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
	Memory at 1e001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 1e400000-1e7ff000 (prefetchable)
	Memory window 1: 1e800000-1ebff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001
00: 17 12 33 69 87 00 10 04 01 00 07 06 00 a8 82 00
10: 00 10 00 1e a0 00 00 02 00 06 09 b0 00 00 40 1e
20: 00 f0 7f 1e 00 00 80 1e 00 f0 bf 1e 01 40 00 00
30: fd 40 00 00 01 44 00 00 fd 44 00 00 00 01 80 05
40: 33 69 02 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 0f 30 00 0c ca 0b 42 82 00 00 50 20 00 00 00 00
a0: 01 00 02 fe 00 40 c0 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 535c
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at cc00 [size=256]
	Memory at dfff7f00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at dffe0000 [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 01 90 02 10 00 00 02 00 40 00 00
10: 01 cc 00 00 00 7f ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 5c 53
30: 00 00 fe df 50 00 00 00 00 00 00 00 0b 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 5350
	Flags: 66Mhz, medium devsel, IRQ 11
	BIST result: 00
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at ac00 [size=128]
	Capabilities: [40] Power Management version 2
	Capabilities: [50] AGP version 2.0
00: 39 10 25 63 03 00 b0 02 00 00 00 03 00 00 00 80
10: 08 00 00 d0 00 00 ee df 01 ac 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 50 53
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 50 02 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 20 00 07 02 00 0f 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--------------070104040906030607000000
Content-Type: text/plain;
 name="lspci_M650"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_M650"

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 11)
	Flags: bus master, medium devsel, latency 32
	Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
00: 39 10 50 06 07 00 10 22 11 00 00 06 00 20 80 00
10: 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fe 09 70 8b 03 03 b7 0e 02 25 c0 00 12 c5 32 00
60: 67 67 6d 6d b3 00 17 80 01 08 e0 00 48 02 00 00
70: 2f 9f 00 08 02 00 00 00 00 00 00 00 02 00 15 00
80: 22 26 30 00 85 00 80 0b 20 0c 00 01 00 00 04 1e
90: 00 00 ec 1d 43 00 00 05 00 16 b6 10 00 00 00 00
a0: c2 d4 55 c2 03 03 01 77 00 50 40 c2 42 09 e0 01
b0: 00 00 00 10 00 00 00 4f 9b 23 2c 30 00 00 80 00
c0: 02 00 20 00 07 02 00 1f 00 00 00 00 00 00 00 00
d0: 22 02 33 02 49 ff ff 01 60 60 aa 00 00 81 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: cfc00000-dfcfffff
00: 39 10 01 00 07 01 00 00 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 a0 a0 00 20
20: e0 df e0 df c0 cf c0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 04)
	Flags: bus master, medium devsel, latency 0
00: 39 10 08 00 0f 00 00 02 04 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 99 0b 05 0a 0a 24 36 80 10 00 00 00 11 20 04 01
50: 11 28 02 01 61 00 66 0a 9c 2e 12 00 0c e9 00 00
60: 0b 0a 0a 05 0f c1 0c 12 09 80 00 4f 80 66 03 00
70: 00 00 ff ff 00 08 00 dc 00 00 00 80 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 40 00 00 80 7c 00 04 00 01 00 00 00 00 00 00 00
f0: 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
	Subsystem: Unknown device 1734:101f
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at dfffb000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dffc0000 [disabled] [size=128K]
	Capabilities: [64] Power Management version 2
00: 39 10 07 70 06 01 10 02 00 10 00 0c 00 40 00 00
10: 00 b0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 1f 10
30: 00 00 fc df 64 00 00 00 00 00 00 00 05 02 04 0c
40: 00 00 00 00 11 00 01 00 02 00 04 04 00 00 08 00
50: 00 00 10 00 00 00 00 00 ff 00 88 88 00 04 00 00
60: 00 00 00 00 01 00 42 fe 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 88 [Master SecP])
	Subsystem: Uniwill Computer Corp: Unknown device 5513
	Flags: bus master, medium devsel, latency 128
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ff00 [size=16]
00: 39 10 13 55 05 00 00 02 00 88 01 01 00 80 00 00
10: 00 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 84 15 13 55
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
50: f2 00 fa 00 2a 96 d5 c0 00 00 00 00 00 00 00 00
60: ff aa ff aa 00 00 00 00 00 00 00 00 00 00 00 00
70: 17 21 06 04 00 00 00 00 56 23 06 04 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev a0) (prog-if 00 [Generic])
	Subsystem: Unknown device 1734:101f
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at d400 [size=256]
	I/O ports at d000 [size=128]
	Capabilities: [48] Power Management version 2
00: 39 10 13 70 05 01 90 02 a0 00 03 07 00 40 00 00
10: 01 d4 00 00 01 d0 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 1f 10
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 03 34 0b
40: 02 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
	Subsystem: Unknown device 1734:101f
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at dc00 [size=256]
	I/O ports at d800 [size=128]
	Capabilities: [48] Power Management version 2
00: 39 10 12 70 05 01 90 02 a0 00 01 04 00 40 00 00
10: 01 dc 00 00 01 d8 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 1f 10
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 03 34 0b
40: 04 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1734:101f
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at dfff7000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 0f 10 03 0c 08 40 80 00
10: 00 70 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 1f 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50
40: 00 00 00 00 5c ac 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1734:101f
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at dfff8000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 0f 10 03 0c 08 40 00 00
10: 00 80 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 1f 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 50
40: 00 00 00 00 5c ac 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1734:101f
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at dfff9000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 0f 10 03 0c 08 40 00 00
10: 00 90 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 1f 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 50
40: 00 00 00 00 5c ac 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0 (prog-if 20 [EHCI])
	Subsystem: Unknown device 1734:101f
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at dfffa000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2
00: 39 10 02 70 06 01 90 02 00 20 03 0c 08 40 00 00
10: 00 a0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 1f 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 00 50
40: 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 0a 00 00 21 00 00 00 00
60: 20 20 7f 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 0c c0 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 91)
	Subsystem: Unknown device 1734:101f
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at cc00 [size=256]
	Memory at dfff6000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dffa0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
00: 39 10 00 09 07 01 90 02 91 00 00 02 00 40 00 00
10: 01 cc 00 00 00 60 ff df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 1f 10
30: 00 00 fa df 40 00 00 00 00 00 00 00 0a 01 34 0b
40: 01 00 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 91 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Unknown device 1734:101f
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 10
	Memory at 1e000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 1e400000-1e7ff000 (prefetchable)
	Memory window 1: 1e800000-1ebff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001
00: 17 12 72 69 87 00 10 04 00 00 07 06 00 a8 02 00
10: 00 00 00 1e a0 00 00 02 00 02 05 b0 00 00 40 1e
20: 00 f0 7f 1e 00 00 80 1e 00 f0 bf 1e 01 40 00 00
30: fd 40 00 00 01 44 00 00 fd 44 00 00 ff 01 80 05
40: 34 17 1f 10 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 02 1c 00 00
90: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 02 fe 00 40 c0 00 00 00 00 00 0d 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 40 00 08 ea 03 82 02 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Unknown device 1734:101f
	Flags: 66Mhz, medium devsel, IRQ 11
	BIST result: 00
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at ac00 [size=128]
	Capabilities: [40] Power Management version 2
	Capabilities: [50] AGP version 2.0
00: 39 10 25 63 03 00 b0 02 00 00 00 03 00 00 00 80
10: 08 00 00 d0 00 00 ee df 01 ac 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 34 17 1f 10
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 50 02 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 20 00 07 02 00 0f 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--------------070104040906030607000000--

