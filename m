Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSLAAFW>; Sat, 30 Nov 2002 19:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSLAAFW>; Sat, 30 Nov 2002 19:05:22 -0500
Received: from mtl.slowbone.net ([213.237.73.175]:9603 "EHLO
	leeloo.slowbone.net") by vger.kernel.org with ESMTP
	id <S261339AbSLAAFU>; Sat, 30 Nov 2002 19:05:20 -0500
Message-ID: <018501c298ce$6e4e10d0$0201a8c0@mtl>
From: =?iso-8859-1?Q?Thorbj=F8rn_Lind?= <mtl@slowbone.net>
To: <linux-kernel@vger.kernel.org>
Subject: quirk_via_ioapic
Date: Sun, 1 Dec 2002 01:13:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Performs the following code when io_apic is enabled.

tmp = 0x1f;
pci_write_config_byte (dev, 0x58, tmp);

Which happens to be a bad idea(tm) on my Tyan Tiger 230T (Via 691+686 chipset) because it will cause
one of the upper IRQ lines (>15) to trigger about 10M times / minute. In this case it's the ide
controller, but is seen on other devices too.

Things sortof work w/o the quirk.
What is going on here ? :)

leeloo:~# cat /proc/interrupts...
 17:          0   IO-APIC-level  Ensoniq AudioPCI
 19:         12   IO-APIC-level  ide2
...

Pretending to use the quirk....
leeloo:~# pcitweak -w 0:7:0 -b 0x58 0x1f

And just a few seconds later...
leeloo:~# cat /proc/interrupts
...
 17:          0   IO-APIC-level  Ensoniq AudioPCI
 19:    2007685   IO-APIC-level  ide2



