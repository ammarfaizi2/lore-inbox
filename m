Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbTLYXlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 18:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbTLYXlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 18:41:10 -0500
Received: from fep02.swip.net ([130.244.199.130]:13751 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S264405AbTLYXlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 18:41:05 -0500
Message-ID: <3FEB758F.2000103@wind.it>
Date: Fri, 26 Dec 2003 00:41:03 +0100
From: Matteo Croce <3297627799@wind.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Radeon IGP345M
Content-Type: multipart/mixed;
 boundary="------------080608040402030501030201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080608040402030501030201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I have sent this mail to jhartmann@precisioninsight.com that should be 
the mantainer of agpgart, but this email address don't exist.

I have a Compaq Presario 2510EA with an ATI Radeon IGP345M graphic card.
I compiled a 2.4.23 kernel with CONFIG_AGP_ATI and I get a module named
agpgart.o
I tryed to load it whit insmod (or with 'insmod agpgart
agp_try_unsupported=1'),
but I get the following error:

----------------------------------------------------------------------
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: Unsupported ATI chipset (device id: cbb2), you might want to
try agp_try_unsupported=1.
agpgart: no supported devices found.
----------------------------------------------------------------------

I am sure that my graphics card is a RadeonIGP bacause the Ati utilities
under windows say that.

So I tryed this: I changed the following line in agp.h (I also attach a
diff):

#define PCI_DEVICE_ID_ATI_RS200		0xcab2

with:

#define PCI_DEVICE_ID_ATI_RS200		0xcbb2

and now when I load the drivers with insmod it says:

----------------------------------------------------------------------
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: Detected ATI IGP330/340/345/350/M chipset
agpgart: AGP aperture is 64M @ 0xd4000000
----------------------------------------------------------------------

and if I do lsmod I have agpgart in the list of loaded modules

Now I want to know:
1) Is the driver working?
2) Is my chipset the same of a 'cab2' with a different device id?
3) How I can know if the driver is working?
4) Maybe a radeon IGP345M has two device ids?

Thanks,
Matteo Croce





--------------080608040402030501030201
Content-Type: text/plain;
 name="agp.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="agp.h.diff"

--- drivers/char/agp/agp.h.orig	2003-12-25 20:47:29.000000000 +0100
+++ drivers/char/agp/agp.h	2003-12-25 19:59:08.000000000 +0100
@@ -314,7 +314,7 @@
 #define PCI_DEVICE_ID_ATI_RS100		0xcab0
 #endif
 #ifndef PCI_DEVICE_ID_ATI_RS200
-#define PCI_DEVICE_ID_ATI_RS200		0xcab2
+#define PCI_DEVICE_ID_ATI_RS200		0xcbb2
 #endif
 #ifndef PCI_DEVICE_ID_ATI_RS250
 #define PCI_DEVICE_ID_ATI_RS250		0xcab3




--------------080608040402030501030201--

