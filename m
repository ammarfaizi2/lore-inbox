Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVGJILa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVGJILa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 04:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVGJILa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 04:11:30 -0400
Received: from totor.bouissou.net ([82.67.27.165]:31967 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261870AbVGJIL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 04:11:28 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Sun, 10 Jul 2005 10:11:22 +0200
User-Agent: KMail/1.7.2
Cc: stern@rowland.harvard.edu, mingo@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507101011.23318@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I use a Gigabyte GA7-VAXP motherboard that has been fine for more than 2 years 
with 2.4 series kernels, and that gives trouble with 2.6.12 (and previous) 
kernels.

The problem seems to sit between the UP IO-APIC and USB uhci_hcd driver.

The GA7-VAXP MB is equipped with an Athlon 2000+ XP and a VIA KT400 chipset.

Using 2.4 series kernel the IO-APIC is used just fine.  Was never source of 
any kind of problem.

Using 2.6.12 kernel, if the IO-APIC is enabled in the kernel configuration, 
then the interrupt controlling the uhci_hcd USB controller gets disabled as 
soon as uhci_hcd is initialized.

This however doesn't happen all the times. I would say that it happens at 
bootup about 50% of the times. However, if the uhci_hcd happened to 
initialize OK, then it will work just good until the machine is rebooted.

When it fails, I get the following messages in syslog:

Jul  9 12:28:06 totor kernel: usbcore: registered new driver usbfs
Jul  9 12:28:06 totor kernel: usbcore: registered new driver hub
Jul  9 12:28:06 totor kernel: USB Universal Host Controller Interface driver 
v2.2
Jul  9 12:28:06 totor kernel: PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 
5
Jul  9 12:28:06 totor kernel: uhci_hcd 0000:00:10.0: VIA Technologies, Inc. 
VT82xxxxx UHCI USB 1.1 Controller
Jul  9 12:28:06 totor kernel: uhci_hcd 0000:00:10.0: new USB bus registered, 
assigned bus number 1
Jul  9 12:28:06 totor kernel: uhci_hcd 0000:00:10.0: irq 21, io base 
0x0000ac00
Jul  9 12:28:06 totor kernel: hub 1-0:1.0: USB hub found
Jul  9 12:28:06 totor kernel: hub 1-0:1.0: 2 ports detected
Jul  9 12:28:06 totor kernel: PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 
5
Jul  9 12:28:06 totor kernel: uhci_hcd 0000:00:10.1: VIA Technologies, Inc. 
VT82xxxxx UHCI USB 1.1 Controller (#2)
Jul  9 12:28:06 totor kernel: uhci_hcd 0000:00:10.1: new USB bus registered, 
assigned bus number 2
Jul  9 12:28:06 totor kernel: uhci_hcd 0000:00:10.1: irq 21, io base 
0x0000b000
Jul  9 12:28:06 totor kernel: hub 2-0:1.0: USB hub found
Jul  9 12:28:06 totor kernel: hub 2-0:1.0: 2 ports detected
Jul  9 12:28:06 totor kernel: PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 
5
Jul  9 12:28:06 totor kernel: uhci_hcd 0000:00:10.2: VIA Technologies, Inc. 
VT82xxxxx UHCI USB 1.1 Controller (#3)
Jul  9 12:28:06 totor kernel: usb 1-1: new low speed USB device using uhci_hcd 
and address 2
Jul  9 12:28:06 totor kernel: uhci_hcd 0000:00:10.2: new USB bus registered, 
assigned bus number 3
Jul  9 12:28:06 totor kernel: uhci_hcd 0000:00:10.2: irq 21, io base 
0x0000b400
Jul  9 12:28:06 totor kernel: hub 3-0:1.0: USB hub found
Jul  9 12:28:06 totor kernel: hub 3-0:1.0: 2 ports detected
Jul  9 12:28:06 totor kernel: PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 
3
Jul  9 12:28:06 totor kernel: ehci_hcd 0000:00:10.3: VIA Technologies, Inc. 
USB 2.0
Jul  9 12:28:06 totor kernel: ehci_hcd 0000:00:10.3: new USB bus registered, 
assigned bus number 4
Jul  9 12:28:06 totor kernel: ehci_hcd 0000:00:10.3: irq 19, io mem 0xe3006000
Jul  9 12:28:06 totor kernel: ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 
1.00, driver 10 Dec 2004
Jul  9 12:28:06 totor kernel: usbcore: registered new driver hiddev
Jul  9 12:28:06 totor kernel: hub 4-0:1.0: USB hub found
Jul  9 12:28:06 totor kernel: hub 4-0:1.0: 6 ports detected
Jul  9 12:28:06 totor kernel: usbhid: probe of 1-1:1.0 failed with error -5
Jul  9 12:28:06 totor kernel: usbcore: registered new driver usbhid
Jul  9 12:28:06 totor kernel: drivers/usb/input/hid-core.c: v2.01:USB HID core 
driver
Jul  9 12:28:06 totor kernel: usb 1-1: USB disconnect, address 2
Jul  9 12:28:06 totor kernel: irq 21: nobody cared!
Jul  9 12:28:06 totor kernel:  [__report_bad_irq+42/144] 
__report_bad_irq+0x2a/0x90
Jul  9 12:28:06 totor kernel:  [<c0136e5a>] __report_bad_irq+0x2a/0x90
Jul  9 12:28:06 totor kernel:  [handle_IRQ_event+57/112] 
handle_IRQ_event+0x39/0x70
Jul  9 12:28:06 totor kernel:  [<c01368f9>] handle_IRQ_event+0x39/0x70
Jul  9 12:28:06 totor kernel:  [note_interrupt+163/208] 
note_interrupt+0xa3/0xd0
Jul  9 12:28:06 totor kernel:  [<c0136f83>] note_interrupt+0xa3/0xd0
Jul  9 12:28:06 totor kernel:  [__do_IRQ+240/256] __do_IRQ+0xf0/0x100
Jul  9 12:28:06 totor kernel:  [<c0136a20>] __do_IRQ+0xf0/0x100
Jul  9 12:28:06 totor kernel:  [do_IRQ+54/112] do_IRQ+0x36/0x70
Jul  9 12:28:06 totor kernel:  [<c01050e6>] do_IRQ+0x36/0x70
Jul  9 12:28:06 totor kernel:  [common_interrupt+26/32] 
common_interrupt+0x1a/0x20
Jul  9 12:28:06 totor kernel:  [<c0103526>] common_interrupt+0x1a/0x20
Jul  9 12:28:06 totor kernel: handlers:
Jul  9 12:28:06 totor kernel: [pg0+947137696/1069564928] (usb_hcd_irq+0x0/0x90 
[usbcore])
Jul  9 12:28:06 totor kernel: [<f8b3cca0>] (usb_hcd_irq+0x0/0x90 [usbcore])
Jul  9 12:28:06 totor kernel: [pg0+947137696/1069564928] (usb_hcd_irq+0x0/0x90 
[usbcore])
Jul  9 12:28:06 totor kernel: [<f8b3cca0>] (usb_hcd_irq+0x0/0x90 [usbcore])
Jul  9 12:28:06 totor kernel: [pg0+947137696/1069564928] (usb_hcd_irq+0x0/0x90 
[usbcore])
Jul  9 12:28:06 totor kernel: [<f8b3cca0>] (usb_hcd_irq+0x0/0x90 [usbcore])
Jul  9 12:28:06 totor kernel: Disabling IRQ #21
Jul  9 12:28:06 totor kernel: usb 1-1: new low speed USB device using uhci_hcd 
and address 3
Jul  9 12:28:06 totor kernel: input: USB HID v1.10 Mouse [Logitech USB 
Receiver] on usb-0000:00:10.0-1
Jul  9 12:28:06 totor kernel: usb 3-2: new full speed USB device using 
uhci_hcd and address 2


Starting there, USB devices cause trouble --  including my mouse that responds 
very slowly and erratically, probably because its interrupt got disabled ?


If the kernel is compiled without support for UP IO-APIC 
(CONFIG_X86_UP_IOAPIC), or booted with the "noapic" option, then this trouble 
doesn't happen -- but the system doesn't use its IO-APIC, which is annoying.

Here follows other syslog boot messages that may be relevant to this IRQ 
problem.  Any clue ?

N.B.: I'm not subscribed to the Linux-kernel ML. Please copy me on answers.

TIA, cheers.


Jul  9 12:28:06 totor kernel: Linux version 2.6.12-3mib4v 
(root@totor.bouissou.net) (gcc version 3.4.3 (Mandrakelinux 10.2 3.4.3-7mdk)) 
#6 Sat Jul 9 12:16:43 CEST 2005
Jul  9 12:28:06 totor kernel: BIOS-provided physical RAM map:
Jul  9 12:28:06 totor kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Jul  9 12:28:06 totor kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Jul  9 12:28:06 totor kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Jul  9 12:28:06 totor kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 
(usable)
Jul  9 12:28:06 totor kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 
(ACPI NVS)
Jul  9 12:28:06 totor kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 
(ACPI data)
Jul  9 12:28:06 totor kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 
(reserved)
Jul  9 12:28:06 totor kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 
(reserved)
Jul  9 12:28:06 totor kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Jul  9 12:28:06 totor kernel: 127MB HIGHMEM available.
Jul  9 12:28:06 totor kernel: 896MB LOWMEM available.
Jul  9 12:28:06 totor kernel: found SMP MP-table at 000f4c50
Jul  9 12:28:06 totor kernel: DMI 2.3 present.
Jul  9 12:28:06 totor kernel: Intel MultiProcessor Specification v1.4
Jul  9 12:28:06 totor kernel:     Virtual Wire compatibility mode.
Jul  9 12:28:06 totor kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC 
at: 0xFEE00000
Jul  9 12:28:06 totor kernel: Processor #0 6:6 APIC version 17
Jul  9 12:28:06 totor kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Jul  9 12:28:06 totor kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jul  9 12:28:06 totor kernel: Processors: 1
Jul  9 12:28:06 totor kernel: Allocating PCI resources starting at 40000000 
(gap: 40000000:bec00000)
Jul  9 12:28:06 totor kernel: Built 1 zonelists
Jul  9 12:28:06 totor kernel: Initializing CPU#0
Jul  9 12:28:06 totor kernel: Kernel command line: root=/dev/evms/lv_racine ro 
devfs=nomount noquiet vga=791
Jul  9 12:28:06 totor kernel: PID hash table entries: 4096 (order: 12, 65536 
bytes)
Jul  9 12:28:06 totor kernel: Detected 1674.892 MHz processor.
Jul  9 12:28:06 totor kernel: Using tsc for high-res timesource
Jul  9 12:28:06 totor kernel: Console: colour dummy device 80x25
Jul  9 12:28:06 totor kernel: Dentry cache hash table entries: 131072 (order: 
7, 524288 bytes)
Jul  9 12:28:06 totor kernel: Inode-cache hash table entries: 65536 (order: 6, 
262144 bytes)
Jul  9 12:28:06 totor kernel: Memory: 1032408k/1048512k available (1820k 
kernel code, 15220k reserved, 740k data, 196k init, 131008k highmem,
 0k BadRAM)
Jul  9 12:28:06 totor kernel: Checking if this processor honours the WP bit 
even in supervisor mode... Ok.
Jul  9 12:28:06 totor kernel: Security Framework v1.0.0 initialized
Jul  9 12:28:06 totor kernel: Capability LSM initialized
Jul  9 12:28:06 totor kernel: Mount-cache hash table entries: 512
Jul  9 12:28:06 totor kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 
64K (64 bytes/line)
Jul  9 12:28:06 totor kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jul  9 12:28:06 totor kernel: Intel machine check architecture supported.
Jul  9 12:28:06 totor kernel: Intel machine check reporting enabled on CPU#0.
Jul  9 12:28:06 totor kernel: CPU: AMD Athlon(tm) XP 2000+ stepping 02
Jul  9 12:28:06 totor kernel: Enabling fast FPU save and restore... done.
Jul  9 12:28:06 totor kernel: Enabling unmasked SIMD FPU exception support... 
done.
Jul  9 12:28:06 totor kernel: Checking 'hlt' instruction... OK.
Jul  9 12:28:06 totor kernel: ENABLING IO-APIC IRQs
Jul  9 12:28:06 totor kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Jul  9 12:28:06 totor kernel: checking if image is initramfs...it isn't (no 
cpio magic); looks like an initrd
Jul  9 12:28:06 totor kernel: Freeing initrd memory: 3097k freed
Jul  9 12:28:06 totor kernel: NET: Registered protocol family 16
Jul  9 12:28:06 totor kernel: PCI: PCI BIOS revision 2.10 entry at 0xf9ea0, 
last bus=1
Jul  9 12:28:06 totor kernel: PCI: Using configuration type 1
Jul  9 12:28:06 totor kernel: mtrr: v2.0 (20020519)
Jul  9 12:28:06 totor kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul  9 12:28:06 totor kernel: PnPBIOS: Disabled
Jul  9 12:28:06 totor kernel: PCI: Probing PCI hardware
Jul  9 12:28:06 totor kernel: PCI: Probing PCI hardware (bus 00)
Jul  9 12:28:06 totor kernel: PCI: Using IRQ router default [1106/3189] at 
0000:00:00.0
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:0a.0[A] -> IRQ 
18
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 
19
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:0f.0[A] -> IRQ 
19
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:10.0[A] -> IRQ 
21
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:10.1[B] -> IRQ 
21
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:10.2[C] -> IRQ 
21
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:10.3[D] -> IRQ 
19
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:11.1[A] -> IRQ 
22
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:11.5[C] -> IRQ 
22
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:00:13.0[A] -> IRQ 
18
Jul  9 12:28:06 totor kernel: PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 
16
Jul  9 12:28:06 totor kernel: Machine check exception polling timer started.
Jul  9 12:28:06 totor kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 
1.16ac)
Jul  9 12:28:06 totor kernel: audit: initializing netlink socket (disabled)
Jul  9 12:28:06 totor kernel: audit(1120904798.619:0): initialized
Jul  9 12:28:06 totor kernel: highmem bounce pool size: 64 pages
Jul  9 12:28:06 totor kernel: inotify device minor=63
[...]


-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
