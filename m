Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUDMPyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 11:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUDMPyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 11:54:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:16287 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263612AbUDMPy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 11:54:26 -0400
Message-ID: <20040413155317.61413.qmail@web41203.mail.yahoo.com>
Date: Tue, 13 Apr 2004 08:53:17 -0700 (PDT)
From: Jin Suh <jinssuh@yahoo.com>
Subject: [PATCH 2.4] fix IRQ routing on Acer TravelMate 360
To: daniel.ritz@qmx.ch, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Could you take a look at my pcmcia problems?
I have a very similar problem enabling a pcmcia firewire card on my Gateway
600YG2 laptop. I am using a Gateway 600YG2 laptop (Intel P4-M, PCMCIA TI
PCI1520 controller)
on 2.4.25. I have 3 different pcmcia firewire cards. When I insert module
yenta_socket with any of those cards, I get "Yenta ISA IRQ mask 0x0a98, PCI irq
0" and "PCI: No IRQ for interrupt pin A of device 03:00.0 please try using
pci=biosirq". After this error, when I run the modprobe ieee1394 and ohci1394,
I get "ohci1394: failed to allocate shared interrupt 10". The same pcmcia
firewire cards work on old Gateway 9300, 9500 laptop and IBM T22 laptop. 
BTW, my Netgear pcmcia 10/100mb ethernet card works on the Gateway 600YG2
laptop. Also my USB pen drives are not working too. The bootparameter
pci=biosirq doesn't seem to work. 
It worked fine with 2.4.20 without any problems. Could someone help me to fix
this problem on 2.4.25? I have buillt both of 2.4.20 and 2.4.25 without ACPI.

Thanks,
Jin

DMESG output
-------------------------------------------------------------------------
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6620
ACPI: RSDT (v001 GATEWA 602      0x20021104  LTP 0x00000000) @ 0x1fef8313
ACPI: FADT (v001 GATEWA 602      0x20021104 PTL  0x0000001e) @ 0x1fefef64
ACPI: BOOT (v001 GATEWA 602      0x20021104  LTP 0x00000001) @ 0x1fefefd8
ACPI: DSDT (v001 GATEWA 602      0x20021104 MSFT 0x0100000e) @ 0x00000000
Kernel command line: initrd=ramdisk.img root=/dev/ram0 bickrootfs=tmpfs vga=791
BOOT_IMAGE=linux 
No local APIC present or hardware disabled
.........
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 10 for device 02:02.0
PCI: Sharing IRQ 10 with 00:1f.1
PCI: Sharing IRQ 10 with 02:02.1
PCI: Found IRQ 10 for device 02:02.1
PCI: Sharing IRQ 10 with 00:1f.1
PCI: Sharing IRQ 10 with 02:02.0
Yenta ISA IRQ mask 0x0a98, PCI irq 0
Socket status: 30000011
Yenta ISA IRQ mask 0x0a98, PCI irq 0
Socket status: 30000020
cs: cb_alloc(bus 7): vendor 0x104c, device 0x8024
PCI: Enabling device 07:00.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 07:00.0. Please try using
pci=biosirq.
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 02:05.0
PCI: Sharing IRQ 10 with 00:1f.3
PCI: Sharing IRQ 10 with 00:1f.6
ohci1394: Failed to allocate shared interrupt 10
PCI: No IRQ known for interrupt pin A of device 07:00.0. Please try using
pci=biosirq.
ohci1394: Failed to allocate shared interrupt 0
sbp2: $Rev: 1074 $ Ben Collins <bcollins@debian.org>

==============================================================

hi marcelo

the same thing as been included in 2.6.5-mm4. here's the 2.4 version.

rgds
-daniel


---snip---

acer travelmate 360 has a broken interrupt routing. there's an interrupt storm
on irq 10 w/o this patch  as soon as yenta_socket is loaded. the problem
has been seen on different machines (reported on l-k and on pcmcia-cs
list). there's also an USB controller on the same interrupt line as the CB
which also works fine after the patch. and routing via ACPI fails too.





	
		
__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
