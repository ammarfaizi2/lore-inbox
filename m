Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTDNLKW (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 07:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbTDNLKW (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 07:10:22 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:46731
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262960AbTDNLKV 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 07:10:21 -0400
Subject: 2.5.67 pcmcia - insmod ds.ko hangs
From: Sean Estabrooks <seanlkml@rogers.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1050319324.31740.13.camel@linux1.classroom.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 14 Apr 2003 07:22:04 -0400
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.102.213.170] using ID <seanlkml@rogers.com> at Mon, 14 Apr 2003 07:22:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# insmod pcmcia_core.ko
# insmod yenta_socket.ko
    PCI: Found IRQ 11 for device 00:0b.0
    PCI: Sharing IRQ 11 with 01:00.0
    Yenta IRQ list 04b0, PCI irq11
    Socket status: 30000020
    PCI: Found IRQ 11 for device 00:0b.1
    PCI: Sharing IRQ 11 with 00:0c.0
    Yenta IRQ list 04b0, PCI irq11
    Socket status: 30000007
# insmod ds.ko  
    PCI: Enabling device 02:00.0 (0000 -> 0003)
    [hang]

  And hangs here permanently, and i should mention it hangs 
the same way when compiled into the kernel.  Changing to
another virtual console and bringing up the network works
without a hitch, but the insmod above never returns.

  One interesting thing is that when ds.c is replaced with the 
version prior to "Driver Services: socket add/remove abstraction" 
patch, everything works fine.

  Some printk's showed that pcmcia_bus_add_socket() in ds.c
makes a call to pcmcia_register_client() that never returns.  

  I've tried compiling the kernel turning off power management,
preempt, etc with no change.  Thought i'd ask if anyone can 
offer a bit of guidance.

Cheers,
Sean

PS. Toshiba Satellite laptop with Xircom Cardbus Ethernet card.

# lspci
    00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
    00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03)
    00:05.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
    00:05.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
    00:05.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
    00:05.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
    00:07.0 Communication controller: Lucent Microelectronics 56k
WinModem (rev 01)
    00:09.0 IRDA controller: Toshiba America Info Systems FIR Port
Type-DO
    00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (rev 20)
    00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (rev 20)
    00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-744B
[DS-1S Audio Controller] (rev 02)
    01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV
(rev 11)
    14:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)



