Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317787AbSGaGQb>; Wed, 31 Jul 2002 02:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317793AbSGaGQb>; Wed, 31 Jul 2002 02:16:31 -0400
Received: from [196.26.86.1] ([196.26.86.1]:34983 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317787AbSGaGQa>; Wed, 31 Jul 2002 02:16:30 -0400
Date: Wed, 31 Jul 2002 08:37:23 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5.29] parport_serial/serial init dependencies (fwd)
Message-ID: <Pine.LNX.4.44.0207310837050.2454-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	This looks to be somewhat botched up init dependencies. This 
patch takes into consideration paride as well as fixing the parport_serial case.

Linus please apply.

Index: linux-2.5.29/drivers/Makefile
===================================================================
RCS file: /build/cvsroot/linux-2.5.29/drivers/Makefile,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Makefile
--- linux-2.5.29/drivers/Makefile	27 Jul 2002 18:02:33 -0000	1.1.1.1
+++ linux-2.5.29/drivers/Makefile	30 Jul 2002 22:45:59 -0000
@@ -7,8 +7,9 @@
 
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_ACPI)		+= acpi/
+obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
-obj-y				+= base/ serial/ char/ block/ misc/ net/ media/
+obj-y				+= base/ char/ block/ misc/ net/ media/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_IDE)		+= ide/

Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c020d334
*pde = 00104001
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c020d334>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c039a280   edx: cf76deb0
esi: 00000000   edi: cf76de10   ebp: c039a7e0   esp: cf76ddc8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, threadinfo=cf76c000 task=cf76a000)
Stack: cf76de10 0000002c 00000001 00000000 00000000 ffffffff cf76de10 c039a7e0 
       c0399f90 c020d424 c039a7e0 cf76de10 ffffffff cf76deb0 00000000 c020fea2
       c039a7e0 cf76de10 000003fd c0445440 0000d600 00000000 00000005 001c2000 
Call Trace: [<c020d424>] [<c020fea2>] [<c020d79f>] [<c020fdaf>] [<c01d73b2>]
   [<c020febc>] [<c0207f86>] [<c0208209>] [<c01de288>] [<c02082ee>] [<c0208535>]  [<c0209667>] [<c0208553>] [<c0208500>] [<c0209d59>] [<c0105000>] [<c01de386>] [<c01050ef>] [<c0105000>] [<c0105826>] [<c0105080>] 

Code: 8b 44 18 14 50 e8 62 ff ff ff 5a 85 c0 59 74 0c 8b 4d 1c 01
 <0>Kernel panic: Attempted to kill init!

>>EIP; c020d334 <uart_find_match_or_unused+24/f0>   <=====
Trace; c020d424 <uart_register_port+24/e0>
Trace; c020fea2 <__register_serial+72/80>
Trace; c020d79f <serial_in+5f/70>
Trace; c020fdaf <serial8250_console_write+1af/210>
Trace; c01d73b2 <vsnprintf+2a2/420>
Trace; c020febc <register_serial+c/10>
Trace; c0207f86 <serial_register+a6/110>
Trace; c0208209 <parport_serial_pci_probe+89/d0>
Trace; c01de288 <pci_device_probe+38/50>
Trace; c02082ee <found_match+2e/b0>
Trace; c0208535 <do_driver_attach+35/40>
Trace; c0209667 <bus_for_each_dev+a7/120>
Trace; c0208553 <driver_attach+13/20>
Trace; c0208500 <do_driver_attach+0/40>
Trace; c0209d59 <driver_register+b9/d0>
Trace; c0105000 <_stext+0/0>
Trace; c01de386 <pci_register_driver+36/50>
Trace; c01050ef <init+6f/220>
Trace; c0105000 <_stext+0/0>
Trace; c0105826 <kernel_thread+26/30>
Trace; c0105080 <init+0/220>

here is the working boot messages
Serial: 8250/16550 driver $Revision: 1.1.1.1 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[... parport stuff ....]
ttyS14 at I/O 0xd600 (irq = 5) is a 16550A
ttyS15 at I/O 0xd400 (irq = 5) is a 16550A


-- 
function.linuxpower.ca


