Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131417AbQLQBWK>; Sat, 16 Dec 2000 20:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbQLQBWA>; Sat, 16 Dec 2000 20:22:00 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:23125 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S131417AbQLQBVt>; Sat, 16 Dec 2000 20:21:49 -0500
Date: Sun, 17 Dec 2000 01:51:15 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: Tim Waugh <twaugh@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>,
        <tytso@valinux.com>
Subject: Re: [patch] 2.2.18 PCI_DEVICE_ID_OXSEMI_16PCI954
In-Reply-To: <20001216232113.B12112@redhat.com>
Message-ID: <Pine.LNX.4.30.0012170143360.4003-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000, Tim Waugh wrote:
> > -#define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
> > +#define PCI_DEVICE_ID_OXSEMI_16PCI954  0x9513
>
> Alan, do not apply, this will break the parport code.
>
> If the OXSEMI_16PCI954 is _missing_, it probably ought to be _added_,
> but it does not have 0x9513 as its ID and so the existing name should
> not be changed.

OK, You have right, I'm not a driver programmer, but it probably should
look like this:

diff -ur linux.org2/include/linux/pci.h linux/include/linux/pci.h
--- linux.org2/include/linux/pci.h      Mon Dec 11 01:49:44 2000
+++ linux/include/linux/pci.h   Sun Dec 17 01:30:21 2000
@@ -1098,6 +1098,7 @@
 #define PCI_VENDOR_ID_OXSEMI           0x1415
 #define PCI_DEVICE_ID_OXSEMI_12PCI840  0x8403
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
+#define PCI_DEVICE_ID_OXSEMI_16PCI954   0x9501

 #define PCI_VENDOR_ID_AFAVLAB          0x14db
 #define PCI_DEVICE_ID_AFAVLAB_TK9902   0x2120

I think that can be "safely" added to the kernel source. :-)

Anyway nn kernel 2.4.0-test12 we have line:

include/linux/pci_ids.h:#define PCI_DEVICE_ID_OXSEMI_16PCI954   0x9501


Why serial.c from the 2.2.18 not support 921600 speed? We have to patch
it...

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
