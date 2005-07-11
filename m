Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVGKJGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVGKJGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVGKJGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:06:53 -0400
Received: from totor.bouissou.net ([82.67.27.165]:63710 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261467AbVGKJG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:06:28 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 11:06:22 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, mingo@redhat.com
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C45@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C45@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507111106.22951@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Dimanche 10 Juillet 2005 20:50, Protasevich, Natalie a écrit :
>
> Michel,
> Symptoms that you describe resemble several IRQ problems with VIA
> chipset reported by others (but not quite...) Could you check on
> bugzilla #4843 please
> http://bugzilla.kernel.org/show_bug.cgi?id=4843 and see if the patch
> fixes your problem.

Hi Nathalie,

Thanks for your answer and pointer. Unfortunately it doesn't help.

The patch you mention won't apply on my kernel alone, I need first to apply 
the patch from 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c434b7a6aedfe428ad17cd61b21b125a7b7a29ce , 
then your patch applies OK.

Unfortunately, it doesn't solve my issue. Booting this kernel still results in 
an interrupt issue with uhci_hcd.

After boot, "cat /proc/interrupts" shows:
           CPU0
  0:     188066    IO-APIC-edge  timer
  1:        308    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:        413    IO-APIC-edge  serial
  7:          3    IO-APIC-edge  parport0
 14:       1177    IO-APIC-edge  ide4
 15:       1186    IO-APIC-edge  ide5
 18:       1028   IO-APIC-level  eth0, eth1
 19:       8513   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd:usb4
 21:     100000   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 22:          0   IO-APIC-level  VIA8233
NMI:          0
LOC:     187967
ERR:          0
MIS:          0

(The problem is with IRQ 21 for uhci_hcd)

(It is to note that without those patches, I didn't see any IRQ managed by 
"XT-PIC", all were managed by the IO-APIC...)


The errors I get in /var/log/messages are :

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
usb 1-1: USB disconnect, address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.0-1
usb 3-2: new full speed USB device using uhci_hcd and address 3

irq 21: nobody cared!
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [<c013cb5a>] __report_bad_irq+0x2a/0x90
 [handle_IRQ_event+57/112] handle_IRQ_event+0x39/0x70
 [<c013c449>] handle_IRQ_event+0x39/0x70
 [note_interrupt+163/208] note_interrupt+0xa3/0xd0
 [<c013cc83>] note_interrupt+0xa3/0xd0
 [__do_IRQ+320/352] __do_IRQ+0x140/0x160
 [<c013c5c0>] __do_IRQ+0x140/0x160
 [do_IRQ+50/112] do_IRQ+0x32/0x70
 [<c01054f2>] do_IRQ+0x32/0x70
 [common_interrupt+26/32] common_interrupt+0x1a/0x20
 [<c0103812>] common_interrupt+0x1a/0x20
 [path_lookup+197/448] path_lookup+0xc5/0x1c0
 [<c016f935>] path_lookup+0xc5/0x1c0
 [do_page_fault+457/1427] do_page_fault+0x1c9/0x593
 [<c0113a09>] do_page_fault+0x1c9/0x593
 [open_exec+50/272] open_exec+0x32/0x110
 [<c016a9e2>] open_exec+0x32/0x110
 [pg0+947004132/1069421568] usb_hcd_irq+0x44/0x90 [usbcore]
 [<f8b3f2e4>] usb_hcd_irq+0x44/0x90 [usbcore]
 [handle_IRQ_event+57/112] handle_IRQ_event+0x39/0x70
 [<c013c449>] handle_IRQ_event+0x39/0x70
 [do_execve+66/592] do_execve+0x42/0x250
 [<c016bc82>] do_execve+0x42/0x250
 [sys_execve+70/176] sys_execve+0x46/0xb0
 [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
 [<c0102dfb>] sysenter_past_esp+0x54/0x75
handlers:
[pg0+947004064/1069421568] (usb_hcd_irq+0x0/0x90 [usbcore])
[<f8b3f2a0>] (usb_hcd_irq+0x0/0x90 [usbcore])
[pg0+947004064/1069421568] (usb_hcd_irq+0x0/0x90 [usbcore])
[<f8b3f2a0>] (usb_hcd_irq+0x0/0x90 [usbcore])
[pg0+947004064/1069421568] (usb_hcd_irq+0x0/0x90 [usbcore])
[<f8b3f2a0>] (usb_hcd_irq+0x0/0x90 [usbcore])
Disabling IRQ #21


At boot, IRQs seem to be distributed this way:

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3189] at 0000:00:00.0
PCI->APIC IRQ transform: 0000:00:0a.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:0f.0[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:10.0[A] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:10.1[B] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:10.2[C] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:10.3[D] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:11.1[A] -> IRQ 22
PCI->APIC IRQ transform: 0000:00:11.5[C] -> IRQ 22
PCI->APIC IRQ transform: 0000:00:13.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
Machine check exception polling timer started.


Hope this may help...

(Please copy me on answers, I'm not subscribed to the linux-kernel ML)

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
