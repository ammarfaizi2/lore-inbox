Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWB1KWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWB1KWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWB1KWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:22:19 -0500
Received: from lug-owl.de ([195.71.106.12]:42472 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751406AbWB1KWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:22:18 -0500
Date: Tue, 28 Feb 2006 11:22:12 +0100
From: Michael Westermann <michael@dvmwest.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] Problem with netmos 9835 chip in IBM POS-Hardware 
Message-ID: <20060228102212.GA13375@dvmwest.dvmwest.de>
Mail-Followup-To: Michael Westermann <michael@dvmwest.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've a problem with a ibm sure pos with two Netmos 9835 chip's.
the chips have the follow pci-config

0000:00:09.0 Serial controller: NetMos Technology PCI 9835 Multi-I/O Controller (rev 01) (prog-if 02 [16550])
        Subsystem: IBM: Unknown device 0299
 	I/O ports at 1898
        I/O ports at 1890
        I/O ports at 1888
        I/O ports at 1880
        I/O ports at 1878
        I/O ports at 1850
and

0000:00:0b.0 Serial controller: NetMos Technology PCI 9835 Mult
(rev 01) (prog-if 02 [16550])
        Subsystem: LSI Logic / Symbios Logic 2S (16C550 UART)
        Flags: medium devsel, IRQ 11
        I/O ports at 18c0
        I/O ports at 18b8
        I/O ports at 18b0
        I/O ports at 18a8
        I/O ports at 18a0
        I/O ports at 1860
	
with dmesg can I see:

PCI: Netmos 9835 (9 parallel, 9 serial); changing class SERIAL to OTHER (use parport_serial) 

but the chip have only 1 parallel and 2 serial.

A insmod parport_serial.ko produces a OOps, 

ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ
 11
PCI parallel port detected: 9710:9735, I/O at 0x1888(0x0)
parport1: PC-style at 0x1888 [PCSPP,TRISTATE,EPP]
PCI parallel port detected: 9710:9735, I/O at 0x1898(0x1898)
PCI parallel port detected: 9710:9735, I/O at 0x1898(0x1898)
PCI parallel port detected: 9710:9735, I/O at 0x1898(0x1898)
Unable to handle kernel paging request at virtual address 9f8ba554
 printing eip:
d09160d3
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: parport_serial 8250_pnp rtc natsemi crc32 8250_pci 8250 seria
l_core snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc 
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via686a hwmon i2c_isa i
2c_core uhci_hcd usbcore parport_pc parport via_agp agpgart dm_mod
CPU:    0
EIP:    0060:[<d09160d3>]    Not tainted VLI
EFLAGS: 00010a83   (2.6.15.4) 
EIP is at parport_register+0x9f/0x146 [parport_serial]
eax: cfe683d4   ebx: cee400e0   ecx: 00000009   edx: 00000000
esi: 00001898   edi: cee40128   ebp: cfa52000   esp: cdec9eec
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 2816, threadinfo=cdec8000 task=ce9800f0)
Stack: cee400e0 00000002 00000004 00000001 cee40148 cee400e0 cfa52000 00000000 
       cfa52044 d09161de d09171b0 d09176a0 d09176a0 d09176c8 c01d5379 c019bc65 
       cfa52000 c019bc94 d09176a0 cfa52000 c019bcbe cfa52044 cfa52044 c01d52d5 
Call Trace:
 [<d09161de>] parport_serial_pci_probe+0x64/0xab [parport_serial]
 [<c01d5379>] __driver_attach+0x0/0x3a
 [<c019bc65>] pci_call_probe+0xa/0xc
 [<c019bc94>] __pci_device_probe+0x2d/0x39
 [<c019bcbe>] pci_device_probe+0x1e/0x30
 [<c01d52d5>] driver_probe_device+0x2f/0x78
 [<c01d53a2>] __driver_attach+0x29/0x3a
 [<c01d4c92>] bus_for_each_dev+0x37/0x59
 [<c01d53c4>] driver_attach+0x11/0x13
 [<c01d5379>] __driver_attach+0x0/0x3a
 [<c01d4fa9>] bus_add_driver+0x54/0x94
 [<c019be62>] __pci_register_driver+0x70/0x80
 [<c01259c9>] sys_init_module+0xbe/0x186
 [<c0102a69>] syscall_call+0x7/0xb
Code: c7 44 24 0c 00 00 00 00 c7 44 24 08 00 00 00 00 e9 88 00 00 00 8b 54 24 10
 8b 42 04 8b 52 08 8b 1c 24 83 7b 04 10 74 b8 6b c0 1c <8b> b4 28 80 01 00 00 83
 fa 06 77 0c 6b c2 1c 8b 9c 28 80 01 00

OK, this problem is the subsystem_device entry 0x299 from IBM.
This is not conform to the netmos-chips and the parport_serial driver.

We have in the struct acrport_pc_pci array addr[4] and
get the index with 

78:	card->numports = (dev->subsystem_device & 0xf0) >> 4;

dev->subsystem_device is 0x299 	(pci entry from IBM)
card->numports is 9 	

In the function parport_register  

324:	for (n = 0; n < card->numports; n++) {
325:		struct parport *port;
326:		int lo = card->addr[n].lo;
327:		int hi = card->addr[n].hi;

n > 3 is invalid the follow is a OOps.

I've wrote the follow patch for this problem:

------------------------------------------

diff -Nur linux-2.6.15.4/drivers/parport/parport_serial.c linux-2.6.15.4.new/drivers/parport/parport_serial.c
--- linux-2.6.15.4/drivers/parport/parport_serial.c	2006-02-10 08:22:48.000000000 +0100
+++ linux-2.6.15.4.new/drivers/parport/parport_serial.c	2006-02-28 10:24:59.000000000 +0100
@@ -75,7 +75,11 @@
 	 * and serial ports.  The form is 0x00PS, where <P> is the number of
 	 * parallel ports and <S> is the number of serial ports.
 	 */
-	card->numports = (dev->subsystem_device & 0xf0) >> 4;
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM && dev->subsystem_device == PCI_DEVICE_ID_IBM_SP300_32H) {
+		card->numports = 1;
+	} else {
+		card->numports = (dev->subsystem_device & 0xf0) >> 4;
+	}
 	return 0;
 }
 
@@ -321,6 +325,11 @@
 	    card->preinit_hook (dev, card, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
 		return -ENODEV;
 
+
+	if (card->numports > 4) {
+		card->numports = 4;
+	}
+	
 	for (n = 0; n < card->numports; n++) {
 		struct parport *port;
 		int lo = card->addr[n].lo;
diff -Nur linux-2.6.15.4/drivers/pci/quirks.c linux-2.6.15.4.new/drivers/pci/quirks.c
--- linux-2.6.15.4/drivers/pci/quirks.c	2006-02-10 08:22:48.000000000 +0100
+++ linux-2.6.15.4.new/drivers/pci/quirks.c	2006-02-28 10:17:09.000000000 +0100
@@ -1211,8 +1211,15 @@
 
 static void __devinit quirk_netmos(struct pci_dev *dev)
 {
-	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
-	unsigned int num_serial = dev->subsystem_device & 0xf;
+	unsigned int num_parallel; 
+	unsigned int num_serial;
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM && dev->subsystem_device == PCI_DEVICE_ID_IBM_SP300_32H) {
+		num_parallel = 1;
+		num_serial = 2;
+	} else {
+		num_parallel = (dev->subsystem_device & 0xf0) >> 4;
+		num_serial = dev->subsystem_device & 0xf;
+	}
 
 	/*
 	 * These Netmos parts are multiport serial devices with optional
diff -Nur linux-2.6.15.4/drivers/serial/8250_pci.c linux-2.6.15.4.new/drivers/serial/8250_pci.c
--- linux-2.6.15.4/drivers/serial/8250_pci.c	2006-02-10 08:22:48.000000000 +0100
+++ linux-2.6.15.4.new/drivers/serial/8250_pci.c	2006-02-28 10:20:01.000000000 +0100
@@ -561,7 +561,12 @@
 static int __devinit pci_netmos_init(struct pci_dev *dev)
 {
 	/* subdevice 0x00PS means <P> parallel, <S> serial */
-	unsigned int num_serial = dev->subsystem_device & 0xf;
+	unsigned int num_serial; 
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM && dev->subsystem_device == PCI_DEVICE_ID_IBM_SP300_32H) {
+		num_serial = 2;
+	} else {
+		num_serial = dev->subsystem_device & 0xf;
+	}
 
 	if (num_serial == 0)
 		return -ENODEV;
diff -Nur linux-2.6.15.4/include/linux/pci_ids.h linux-2.6.15.4.new/include/linux/pci_ids.h
--- linux-2.6.15.4/include/linux/pci_ids.h	2006-02-10 08:22:48.000000000 +0100
+++ linux-2.6.15.4.new/include/linux/pci_ids.h	2006-02-28 10:17:58.000000000 +0100
@@ -448,6 +448,7 @@
 #define PCI_DEVICE_ID_IBM_ICOM_V2_TWO_PORTS_RVX		0x021A
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
 #define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252
+#define PCI_DEVICE_ID_IBM_SP300_32H		0x0299
 
 #define PCI_VENDOR_ID_COMPEX2		0x101a /* pci.ids says "AT&T GIS (NCR)" */
 #define PCI_DEVICE_ID_COMPEX2_100VG	0x0005

------------------------------------------

This work with my hardware. 

I've a other problen with the port order.

The assignment between port and device are different to linux 2.4.
I've two netmos in my box:

PCI 0:9	 with 1 parport and 2 serial ports
PCI 0:b	 without parports and 2 serial ports

The netmos chip without a parport are initialized by the 8250*
The netmos chip with parport by the parport_serial driver; the
Ports are in a wrong order:

PCI 0:9 -> /dev/ttyS[67] 
PCI 0:b -> /dev/ttyS[45] 

My problem is, I can't replace the Kernel without changing the userland
config files.

Michael Westermann





