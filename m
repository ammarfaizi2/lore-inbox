Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLOV3V>; Fri, 15 Dec 2000 16:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLOV3L>; Fri, 15 Dec 2000 16:29:11 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:18516 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S129383AbQLOV3D>; Fri, 15 Dec 2000 16:29:03 -0500
Date: Fri, 15 Dec 2000 21:57:42 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>, <tytso@valinux.com>
Subject: [patch] 2.2.18 PCI_DEVICE_ID_OXSEMI_16PCI954
Message-ID: <Pine.LNX.4.30.0012152140350.3740-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm tring to use serial driver 5.05 with kernel in version
2.2.18. There is a little problem with vendor definition in kernel source.

In serial dirver from Theodore Ts'o we have:

        {       PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_OXSEMI_16PCI954,
                PCI_VENDOR_ID_SPECIALIX,
PCI_SUBDEVICE_ID_SPECIALIX_SPEED4,
                SPCI_FL_BASE0 , 4, 921600 },
        {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
                PCI_ANY_ID, PCI_ANY_ID,
                SPCI_FL_BASE0 , 4, 115200 },


In kernel 2.4.0-test11 we have:

[lukasz@lt linux]$ grep PCI_DEVICE_ID_OXSEMI_16PCI954  * -r
drivers/char/serial.c:  {       PCI_VENDOR_ID_SPECIALIX,
PCI_DEVICE_ID_OXSEMI_16PCI954,
drivers/char/serial.c:  {       PCI_VENDOR_ID_OXSEMI,
PCI_DEVICE_ID_OXSEMI_16PCI954,
include/linux/pci_ids.h:#define PCI_DEVICE_ID_OXSEMI_16PCI954   0x9501

(IMHO that is correct), but in kernel 2.2.18 we have:
(include/kernel/pci.h)
#define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
                                     ^^

Please correct, if I'm wrong, but IMHO it shuld be:
(include/kernel/pci.h)
#define PCI_DEVICE_ID_OXSEMI_16PCI954  0x9513

There is a simple patch to fix that:

diff -r -u linux.org/include/linux/pci.h linux/include/linux/pci.h
--- linux.org/include/linux/pci.h       Mon Dec 11 01:49:44 2000
+++ linux/include/linux/pci.h   Fri Dec 15 21:38:14 2000
@@ -1097,7 +1097,7 @@

 #define PCI_VENDOR_ID_OXSEMI           0x1415
 #define PCI_DEVICE_ID_OXSEMI_12PCI840  0x8403
-#define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
+#define PCI_DEVICE_ID_OXSEMI_16PCI954  0x9513

 #define PCI_VENDOR_ID_AFAVLAB          0x14db
 #define PCI_DEVICE_ID_AFAVLAB_TK9902   0x2120




-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
