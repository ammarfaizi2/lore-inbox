Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbVCELyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbVCELyH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 06:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVCELyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 06:54:07 -0500
Received: from mail-gw0.york.ac.uk ([144.32.128.245]:39848 "EHLO
	mail-gw0.york.ac.uk") by vger.kernel.org with ESMTP id S263063AbVCELxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 06:53:41 -0500
Subject: RivaFB and GeForce FX
From: Alan Jenkins <aj504@student.cs.york.ac.uk>
To: ajoshi@shell.unixbox.com
Cc: ods5926@gmail.com, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-c8brUmkKj5njJYd38IGh"
Date: Sat, 05 Mar 2005 11:53:22 +0000
Message-Id: <1110023602.7572.24.camel@host-172-19-5-120.sns.york.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@student.cs.york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c8brUmkKj5njJYd38IGh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I asked on LKML about extending the list of supported cards for the
rivafb driver to include GeForce/Quadro FX boards.  I suspect the lack
of response was down to two factors:

a) Not addressing the maintainer
b) Lack of a patch

Hence this email!

Without this patch, the only supported FX board is the GeForce FX GO
5200.  However, I am able to use rivafb on my GeForce FX 5200 by simply
adding it to the list of supported cards.

Part of the code suggests that more FX boards will work:

switch (pd->device & 0x0ff0) {

...

	case 0x0300:   /* GeForceFX 5800 */
	case 0x0310:   /* GeForceFX 5600 */
	case 0x0320:   /* GeForceFX 5200 */
	case 0x0330:   /* GeForceFX 5900 */
	case 0x0340:   /* GeForceFX 5700 */
	     arch =  NV_ARCH_30;
	     break;

...

}

IMHO we should allow people to test this suggestion :).  I therefore
attach patches which enables rivafb to be used on all cards with PCI ids
in the above range.  I considered adding an experimental configuration
option, but I didn't think that would be welcome.  

More selective alternatives are possible, and a warning of some sort may
be in order.  I am happy to revise the patch in any way.

Alan



--=-c8brUmkKj5njJYd38IGh
Content-Disposition: attachment; filename=fbdev.c.diff
Content-Type: text/x-patch; name=fbdev.c.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/drivers/video/riva/fbdev.c	2005-03-04 10:46:21.000000000 +0000
+++ linux-2.6.11-rivafb/drivers/video/riva/fbdev.c	2005-03-05 11:04:29.000000000 +0000
@@ -195,8 +195,84 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_FX_2000,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1000,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600_XT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5600,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5650,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_FX_GO_700,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_XT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5250,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5500,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200_1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200_MAC,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_FX_GO_500_600,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5300,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_XT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5950_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_ZT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_FX_3000,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_FX_700,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700_LE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700_VE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5700,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5700_1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_FX_GO_1000,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_FX_GO_1100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);

--=-c8brUmkKj5njJYd38IGh
Content-Disposition: attachment; filename=pci_ids.c.diff
Content-Type: text/x-patch; name=pci_ids.c.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/include/linux/pci_ids.h	2005-03-04 10:46:45.000000000 +0000
+++ linux-2.6.11-rivafb/include/linux/pci_ids.h	2005-03-05 10:48:05.000000000 +0000
@@ -1166,7 +1166,44 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
-#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200	0x0329
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800_ULTRA	0x0301
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800		0x0302
+#define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_2000		0x0308
+#define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1000		0x0309
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600_ULTRA	0x0311
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600		0x0312
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600_XT		0x0314
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5600		0x031A
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5650		0x031B
+#define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_GO_700		0x031C
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200		0x0320
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_ULTRA	0x0321
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_1		0x0322
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_XT		0x0323
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200		0x0324
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5250		0x0325
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5500		0x0326
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5100		0x0327
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200_1	0x0328
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200_MAC	0x0329
+#define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_500_600		0x032B
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5300		0x032C
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5100		0x032D
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_ULTRA	0x0330
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900		0x0331
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_XT		0x0332
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5950_ULTRA	0x0333
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5900_ZT		0x0334
+#define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_3000		0x0338
+#define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_700		0x033F
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700_ULTRA	0x0341
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700		0x0342
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700_LE		0x0343
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5700_VE		0x0344
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5700		0x0347
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5700_1	0x0348
+#define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_GO_1000		0x034C
+#define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_GO_1100		0x034E
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_8849		0x8849

--=-c8brUmkKj5njJYd38IGh--

