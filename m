Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVGMGqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVGMGqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 02:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVGMGqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 02:46:50 -0400
Received: from totor.bouissou.net ([82.67.27.165]:57000 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261456AbVGMGqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 02:46:48 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Wed, 13 Jul 2005 08:46:40 +0200
User-Agent: KMail/1.7.2
Cc: "Alan Stern" <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C54@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C54@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507130846.41198@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mercredi 13 Juillet 2005 01:16, Protasevich, Natalie a écrit :
>
> At this point, you'll need to set the system back to its original state
> that you started with, and have both "apic=debug" and "pci=routeirq" as
> boot options. I'd say use the last kernel that you prepared with USB
> support there (and all usual devices enabled in BIOS).

OK. I used the kernel that had your 2 patches anyway, as I didn't have another 
APIC-capable kernel without Alan's test patch on hand. Booted with your 
options.

This time, the mouse was working OK after bootup, but unplugging and 
replugging it in cause the "irq 21: nobody cared" message and IRQ21 was 
disabled again.

/proc/interrupts said :
           CPU0       
  0:     114049    IO-APIC-edge  timer
  1:        140    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:        189    IO-APIC-edge  serial
  7:          3    IO-APIC-edge  parport0
 14:        547    IO-APIC-edge  ide4
 15:        556    IO-APIC-edge  ide5
 18:        460   IO-APIC-level  eth0, eth1
 19:       7442   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd:usb4
 21:      10464   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 22:          0   IO-APIC-level  VIA8233
NMI:          0 
LOC:     113962 
ERR:          0
MIS:          0


dmesg said :
0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Getting VERSION: 40010
Getting VERSION: 40010
Getting ID: 0
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-17, 2-20, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 24.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    79
 0d 001 01  0    0    0   0   0    1    1    81
 0e 001 01  0    0    0   0   0    1    1    89
 0f 001 01  0    0    0   0   0    1    1    91
 10 001 01  1    1    0   1   0    1    1    99
 11 000 00  1    0    0   0   0    0    0    00
 12 001 01  1    1    0   1   0    1    1    A1
 13 001 01  1    1    0   1   0    1    1    A9
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    B1
 16 001 01  1    1    0   1   0    1    1    B9
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ21 -> 0:21
IRQ22 -> 0:22
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1674.0154 MHz.
..... host bus clock speed is 267.0864 MHz.
[...]
PCI: PCI BIOS revision 2.10 entry at 0xf9ea0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Disabled
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router default [1106/3189] at 0000:00:00.0
querying PCI -> IRQ mapping bus:0, slot:10, pin:0.
PCI->APIC IRQ transform: 0000:00:0a.0[A] -> IRQ 18
querying PCI -> IRQ mapping bus:0, slot:11, pin:0.
PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 19
querying PCI -> IRQ mapping bus:0, slot:15, pin:0.
PCI->APIC IRQ transform: 0000:00:0f.0[A] -> IRQ 19
querying PCI -> IRQ mapping bus:0, slot:16, pin:0.
PCI->APIC IRQ transform: 0000:00:10.0[A] -> IRQ 21
querying PCI -> IRQ mapping bus:0, slot:16, pin:1.
PCI->APIC IRQ transform: 0000:00:10.1[B] -> IRQ 21
querying PCI -> IRQ mapping bus:0, slot:16, pin:2.
PCI->APIC IRQ transform: 0000:00:10.2[C] -> IRQ 21
querying PCI -> IRQ mapping bus:0, slot:16, pin:3.
PCI->APIC IRQ transform: 0000:00:10.3[D] -> IRQ 19
querying PCI -> IRQ mapping bus:0, slot:17, pin:0.
PCI->APIC IRQ transform: 0000:00:11.1[A] -> IRQ 22
querying PCI -> IRQ mapping bus:0, slot:17, pin:2.
PCI->APIC IRQ transform: 0000:00:11.5[C] -> IRQ 22
querying PCI -> IRQ mapping bus:0, slot:19, pin:0.
PCI->APIC IRQ transform: 0000:00:13.0[A] -> IRQ 18
querying PCI -> IRQ mapping bus:1, slot:0, pin:0.
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[...]
Freeing unused kernel memory: 200k freed
Generic RTC Driver v1.07
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 5
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000cc00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000d000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#3)
usb 1-1: new low speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000d400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 3
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: irq 19, io mem 0xe3009000
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 1-1: USB disconnect, address 2
EXT3 FS on dm-5, internal journal
usb 1-1: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-1
[...]

(When I unplugged the mouse:)

usb 1-1: USB disconnect, address 3

(Then plugged it back in:)

usb 1-1: new low speed USB device using uhci_hcd and address 4
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-1
irq 21: nobody cared!
 [<c013cb5a>] __report_bad_irq+0x2a/0x90
 [<c013c449>] handle_IRQ_event+0x39/0x70
 [<c013cc83>] note_interrupt+0xa3/0xd0
 [<c013c5c0>] __do_IRQ+0x140/0x160
 [<c01054f2>] do_IRQ+0x32/0x70
 [<c0103812>] common_interrupt+0x1a/0x20
handlers:
[<f8b3f2a0>] (usb_hcd_irq+0x0/0x90 [usbcore])
[<f8b3f2a0>] (usb_hcd_irq+0x0/0x90 [usbcore])
[<f8b3f2a0>] (usb_hcd_irq+0x0/0x90 [usbcore])
Disabling IRQ #21


Hope this helps...

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
