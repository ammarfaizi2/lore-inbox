Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRIGLnp>; Fri, 7 Sep 2001 07:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271742AbRIGLnZ>; Fri, 7 Sep 2001 07:43:25 -0400
Received: from mx3.port.ru ([194.67.57.13]:36620 "EHLO smtp3.port.ru")
	by vger.kernel.org with ESMTP id <S271741AbRIGLnY>;
	Fri, 7 Sep 2001 07:43:24 -0400
Date: Fri, 7 Sep 2001 15:46:38 +0400
From: Nick Kurshev <nickols_k@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: ajoshi@unixbox.com
Subject: [linux-2.4.9-ac9 PATCH] ATI Radeon VE framebuffer support
Message-Id: <20010907154638.53f86f92.nickols_k@mail.ru>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've found that linux doesn't support ATI Radeon VE frame buffer.
Bellow is patch for latest Alan's linux distribution to enable support of subj
This patch works (at least for me) and I get graphic screen with 640x480x256
on my Radeon VE chip.

Best regards! Nick


--- linux/drivers/video/radeonfb.c.old	Fri Sep  7 12:10:49 2001
+++ linux/drivers/video/radeonfb.c	Fri Sep  7 15:36:10 2001
@@ -12,13 +12,14 @@
  *	2001-07-05	fixed scrolling issues, engine initialization,
  *			and minor mode tweaking, 0.0.9
  *
+ *	2001-09-07	Radeon VE support
  *
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
  */
 
 
-#define RADEON_VERSION	"0.0.9"
+#define RADEON_VERSION	"0.0.10"
 
 
 #include <linux/config.h>
@@ -62,7 +63,8 @@
 	RADEON_QD,
 	RADEON_QE,
 	RADEON_QF,
-	RADEON_QG
+	RADEON_QG,
+	RADEON_VE
 };
 
 
@@ -71,6 +73,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_QE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QE},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_QF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QF},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_QG, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QG},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_VE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_VE},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
@@ -639,6 +642,9 @@
 		case PCI_DEVICE_ID_RADEON_QG:
 			strcpy(rinfo->name, "Radeon QG ");
 			break;
+		case PCI_DEVICE_ID_RADEON_VE:
+			strcpy(rinfo->name, "Radeon VE ");
+			break;
 		default:
 			return -ENODEV;
 	}
@@ -754,7 +760,7 @@
 		radeon_engine_init (rinfo);
 	}
 
-	printk ("radeonfb: ATI Radeon %s %d MB\n", rinfo->ram_type,
+	printk ("radeonfb: ATI %s %d MB\n",rinfo->name,
 		(rinfo->video_ram/(1024*1024)));
 
 	return 0;

--- linux/drivers/video/radeon.h.old	Fri Sep  7 12:10:49 2001
+++ linux/drivers/video/radeon.h	Fri Sep  7 14:09:54 2001
@@ -7,6 +7,7 @@
 #define PCI_DEVICE_ID_RADEON_QE		0x5145
 #define PCI_DEVICE_ID_RADEON_QF		0x5146
 #define PCI_DEVICE_ID_RADEON_QG		0x5147
+#define PCI_DEVICE_ID_RADEON_VE		0x5159
 
 #define RADEON_REGSIZE			0x4000
 

