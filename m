Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTFPAVP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFPAVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:21:15 -0400
Received: from RJ089180.user.veloxzone.com.br ([200.141.89.180]:9088 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S263077AbTFPAVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:21:12 -0400
Date: Sun, 15 Jun 2003 21:34:49 -0300 (BRT)
From: =?UTF-8?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released
Message-ID: <Pine.LNX.4.56.0306152053160.160@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:

>> with module via-rhine on ECS_L7VTA works for you or not..?

> Nope, it doesn't work, but the problem is the IOAPIC not
> ACPI....
> It works if I disable the IOAPIC in the BIOS.

I don't use ACPI (should I ?) but have the same problem with my
ECS K7VTA3 5.0C and the onboard Realtek or a 3Com 3C905CX-TXNM,
although I had and still have other problems without IO-APIC,
like modprobe bttv instant freezes when USB 2.0 shared the same
IRQ. To "solve" I moved the card to another slot.

The problem is that loading USB without IO-APIC still gives
instant freezes. I first experienced it with bare.i from
Slackware 9.0 and SuperRescue 2.1.1, which stop at

hcd.c:ehci-hcd@00:10:3,VIA Technologies, Inc. USB 2.0

, and later doing the usual modprobe with 2.4.2{0,1}.

I just tested with 2.4.21. With IO-APIC everything worked
except the ethernet. Testing USB:

# modprobe usbcore
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub

# modprobe usb-uhci
usb-uhci.c: $Revision: 1.275 $ time 01:28:00 Jun 14 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:10.0-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc20a) is not claimed by any active driver.

# modprobe ehci-hcd
ehci-hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci-hcd 00:10.3: irq 19, pci mem e2865000
usb.c: new USB bus registered, assigned bus number 4
PCI: 00:10.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:10.3 PCI cache line size corrected to 64.
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
usb.c: USB disconnect on device 00:10.0-1 address 2
hub.c: USB hub found
hub.c: 6 ports detected
hub.c: new USB device 00:10.0-1, assigned address 3
usb.c: USB device 3 (vend/prod 0x46d/0xc20a) is not claimed by any active driver.

Without IO-APIC (noapic boot option) modprobe usbcore worked,
but modprobe usb-uhci freezed after printing

usb-uhci.c: $Revision: 1.275 $ time 01:28:00 Jun 14 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:10:0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1

I'm starting to think there's something wrong with the
motherboard as the BIOS couldn't locate my Sound Blaster Live!
5.1 in any slot. I think I tried everything, also disabling all
onboard options, RAID, and FireWire. At the end I just sold it
and am now using the onboard sound.

USB works on Windows XP Professional SP1 (I could only test a
game pad) along with the ethernet, and I didn't have to move
the capture card to get it working there. I moved it to get it
working on Linux.

I uploaded my 2.4.21 .config, /proc/{ioports,interrupts,pci},
and the last 4 dmesg just in case someone is interested.

http://www.fredlwm.hpg.com.br/tmp/.config-2.4.21.txt
http://www.fredlwm.hpg.com.br/tmp/2.4.21-IO-APIC.txt
http://www.fredlwm.hpg.com.br/tmp/2.4.21-noapic.txt

http://www.fredlwm.hpg.com.br/tmp/dmesg-2003-06-15_17:13:09.txt
http://www.fredlwm.hpg.com.br/tmp/dmesg-2003-06-15_17:33:45.txt
http://www.fredlwm.hpg.com.br/tmp/dmesg-2003-06-15_17:44:53.txt
http://www.fredlwm.hpg.com.br/tmp/dmesg-2003-06-15_17:51:51.txt

BTW, what does noapic do when you enable all APIC options and
when you don't enable IO-APIC ?
