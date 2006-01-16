Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWAPJ1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWAPJ1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWAPJ1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:27:07 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:24255 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932279AbWAPJ0o (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:26:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:subject:content-type;
        b=Dh2yfxOQKpMYPVfO+WkyQeL6fI5WRZpUB5Nnta0UUQJWK8uQo1HAkvBZoaH7+dSHqgtFRyjjf92ZzWZgH7uW1ijjyJAPSvLFxRtjN7reusYE1v89riytR/s+TXzi4/SesGv3c6SJPukzAy0T9SakzLgXSdLRW4/KfPY1O2b5DFI=
Message-ID: <43CB6694.1040704@gmail.com>
Date: Mon, 16 Jan 2006 11:25:40 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060112)
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [serial] [adddevice] Serial controller: Decision Computer International
 Co. PCCOM2 (rev 02)
Content-Type: multipart/mixed;
 boundary="------------030109070005070106020304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030109070005070106020304
Content-Type: text/plain; charset=ISO-8859-8-I; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

There is a new device which is look like:

Serial controller: Decision Computer International Co. 
PCCOM2 (rev 02) (prog-if 02 [16550])
0700: 6666:0004 (rev 02) (prog-if 02)
Flags: medium devsel, IRQ 177
Memory at fe000000 (32-bit, non-prefetchable) [size=128]
I/O ports at e880 [size=128]
I/O ports at e400 [size=256]

It has two 16550A, and is not listed in kernel, although the 
manufacturer clams that it is supported...

I've created the following patch, it only add the new PCI id 
and the card to the repository, it seems to work.

Please consider adding support to this device.

Best Regards,
Alon Bar-Lev.


--------------030109070005070106020304
Content-Type: text/plain;
 name="2.6-decesion-pccom2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6-decesion-pccom2.patch"

diff -urNp linux-2.6.14-gentoo-r5/drivers/serial/8250_pci.c linux-2.6.14-gentoo-r5.new/drivers/serial/8250_pci.c
--- linux-2.6.14-gentoo-r5/drivers/serial/8250_pci.c	2006-01-16 10:10:37.000000000 +0200
+++ linux-2.6.14-gentoo-r5.new/drivers/serial/8250_pci.c	2006-01-15 19:06:10.000000000 +0200
@@ -930,6 +930,7 @@ enum pci_board_num_t {
 	pbn_b2_bt_2_921600,
 	pbn_b2_bt_4_921600,
 
+	pbn_b3_2_115200,
 	pbn_b3_4_115200,
 	pbn_b3_8_115200,
 
@@ -1263,6 +1264,12 @@ static struct pciserial_board pci_boards
 		.uart_offset	= 8,
 	},
 
+	[pbn_b3_2_115200] = {
+		.flags		= FL_BASE3,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
 	[pbn_b3_4_115200] = {
 		.flags		= FL_BASE3,
 		.num_ports	= 4,
@@ -2164,6 +2171,9 @@ static struct pci_device_id serial_pci_t
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_nec_nile4 },
 
+	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b3_2_115200 },
 	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM4,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b3_4_115200 },
diff -urNp linux-2.6.14-gentoo-r5/include/linux/pci_ids.h linux-2.6.14-gentoo-r5.new/include/linux/pci_ids.h
--- linux-2.6.14-gentoo-r5/include/linux/pci_ids.h	2006-01-16 10:10:37.000000000 +0200
+++ linux-2.6.14-gentoo-r5.new/include/linux/pci_ids.h	2006-01-15 19:03:13.000000000 +0200
@@ -2348,6 +2348,7 @@
 #define PCI_VENDOR_ID_DCI		0x6666
 #define PCI_DEVICE_ID_DCI_PCCOM4	0x0001
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
+#define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
 #define PCI_VENDOR_ID_DUNORD		0x5544
 #define PCI_DEVICE_ID_DUNORD_I3000	0x0001

--------------030109070005070106020304--
