Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267195AbRGKESI>; Wed, 11 Jul 2001 00:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbRGKER7>; Wed, 11 Jul 2001 00:17:59 -0400
Received: from ns1.crl.go.jp ([133.243.3.1]:4825 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S267195AbRGKERr>;
	Wed, 11 Jul 2001 00:17:47 -0400
Date: Wed, 11 Jul 2001 13:17:45 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: irq problem with OHCI USB
Message-ID: <Pine.LNX.4.30.0107111256280.2424-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha DP264 (UP), kernel 2.4.6 (gcc 3.0).

1. usbcore didn't work as a module, complaining
that it needed hotplug_path (hotplug _is_ enabled).

2. relinked usbcore static, everything else still
a module, but now during boot:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
...
usb-ohci.c: USB OHCI at membase 0xfffffd000a090000, IRQ 234
usb-ohci.c: usb-00:05.3, Contaq Microsystems 82c693 (#4)
usb.c: new USB bus registered, assigned bus number 1
usb-ohci.c: request interrupt 234 failed
usb.c: USB bus 1 deregistered

lspci -xvv says:

00:05.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10 [OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 234
        Region 0: Memory at 000000000a090000 (32-bit, non-prefetchable)
[size=4K]
00: 80 10 93 c6 06 00 80 02 00 10 03 0c 00 20 80 00
10: 00 00 09 0a 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ea 01 00 00

Further attempts to insmod usb-ohci report
/lib/modules/2.4.6/kernel/drivers/usb/usb-ohci.o: init_module: No such device


