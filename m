Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131815AbQLQCVe>; Sat, 16 Dec 2000 21:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131863AbQLQCVZ>; Sat, 16 Dec 2000 21:21:25 -0500
Received: from mail.bendnet.com ([199.2.205.68]:16396 "EHLO mail.bendnet.com")
	by vger.kernel.org with ESMTP id <S131815AbQLQCVM>;
	Sat, 16 Dec 2000 21:21:12 -0500
Message-ID: <007101c067cc$0500c620$0b31a3ce@g1e7m6>
From: "Miles Lane" <miles@megapathdsl.net>
To: <linux-kernel@vger.kernel.org>, "David Hinds" <dhinds@valinux.com>
Subject: PCMCIA modem (v.90 X2) not working with 2.4.0-test12 PCMCIA services
Date: Sat, 16 Dec 2000 17:52:30 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-Mimeole: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have built my test12 kernel with the following options:

CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_I82365=y

CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PCMCIA_SERIAL=y
CONFIG_PCMCIA_SERIAL_CS=m
CONFIG_PCMCIA_SERIAL_CB=m

I have the 3.1.22 version of David Hinds' PCMCIA installed.
It didn't build the drivers, since the package is configured to
use the kernel's drivers.

dmesg shows:

Linux PCMCIA Card Services 3.1.22
   options: [pci] [cardbus] [pm]
PCI: Enabling device 00:04.0 (0000 -> 0002)
PCI: Assigned IRQ 11 for device 00:04.0
PCI: Enabling device 00:04.1 (0000 -> 0002)
PCI: Assigned IRQ 11 for device 00:04.1
Intel PCIC probe: not found
Yenta IRQ list 0698, PCI irq11
Socket status: 30000020
Yenta IRQ list 0698, PCI irq11
Socket status: 30000010
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x378-0x37f
0x388-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: warning: no high memory space available!
cs: memory probe 0x0d0000-0x0dffff: clean.
register_serial(): autoconfig failed
serial_cs: register_serial() at 0x03e8, irq 3 failed.

"cardctl ident" shows:

Socket 1:
    product info: "PCMCIA", "V.90 Communications Device ", "", ""
    manfid: 0x018a, 0x0001

My modem is not one of the default supported devices,
so I added a device entry in /etc/pcmcia/config:

    card "V90"
    manfid 0x018a, 0x0001
    bind "serial_cs"

The modem is model PN610-X2 (a 56K V.90 PCMCIA Fax-Modem)
made by Hawking Technology.  It's a 16-bit, PCMCIA 2.1-compliant,
Type II PC Card.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
