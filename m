Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWEaKhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWEaKhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 06:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWEaKhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 06:37:38 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:64748 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964956AbWEaKhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 06:37:37 -0400
Date: Wed, 31 May 2006 12:37:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: parport and irq question
Message-ID: <Pine.LNX.4.61.0605311235060.4321@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

standard parport probing gives:

# modprobe parport_pc
pnp: Device 00:0a activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 185
PCI parallel port detected: 9710:9805, I/O at 0xc800(0xc400)
parport1: PC-style at 0xc800 (0xc400) [PCSPP,TRISTATE]
PCI parallel port detected: 9710:9805, I/O at 0xc000(0xbc00)
parport2: PC-style at 0xc000 (0xbc00) [PCSPP,TRISTATE]

Since I do not use parport0 but parport2 for regular work, I wanted to make 
parport2 have the DMA channel, so I tried

# rmmod parport_pc
pnp: Device 00:0a disabled.

# modprobe parport_pc io=0x378,0xc800,0xc000 irq=100,101,7
parport 0x378 (WARNING): CTR: wrote 0x0c, read 0xff
parport 0x378 (WARNING): DATA: wrote 0xaa, read 0xff
parport 0x378: You gave this address, but there is probably no parallel 
port there!
parport0: PC-style at 0x378, irq 100 [PCSPP,TRISTATE]
parport0: irq 100 in use, resorting to polled operation
parport1: PC-style at 0xc800, irq 101 [PCSPP,TRISTATE,EPP]
parport1: irq 101 in use, resorting to polled operation
parport2: PC-style at 0xc000 (0xc400), irq 7, dma 7 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]


Looks good so far, but what irq am I supposed to hand to the irq= parameter 
for parport0 and parport1? Giving irq=-1,-1,7 is rejected. And what about 
the "You gave this address, but there is probably no parallel port there?" 
- there is one. It also appears when I try 0x778 instead of 0x378.



Jan Engelhardt
-- 
