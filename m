Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268650AbTBZFh6>; Wed, 26 Feb 2003 00:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268653AbTBZFh6>; Wed, 26 Feb 2003 00:37:58 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:46086 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S268650AbTBZFhu>; Wed, 26 Feb 2003 00:37:50 -0500
Date: Wed, 26 Feb 2003 14:48:06 +0900 (JST)
Message-Id: <20030226.144806.06041481.yoshfuji@linux-ipv6.org>
To: tony@cantech.net.au, linux-kernel@vger.kernel.org
Subject: [PATCH] fix for "Too many arguments for pnp_activate_dev()" (Re:
 [PATCH] fix compile for drivers/pcmcia/i82365.c)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.44.0302261256510.1039-100000@thor.cantech.net.au>
References: <Pine.LNX.4.44.0302261256510.1039-100000@thor.cantech.net.au>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In article <Pine.LNX.4.44.0302261256510.1039-100000@thor.cantech.net.au> (at Wed, 26 Feb 2003 13:06:42 +0800 (WST)), "Anthony J. Breeds-Taurima" <tony@cantech.net.au> says:

> 	The 2.5.63 kernel contains changes to pnp.h that mean the template arg
> is nolonger there.  The object compiles with this patch.

Yes, I sent similar patch yesterday.
Here's the revised patch for other drivers, too.

Thanks in advance.

Index: drivers/isdn/hisax/asuscom.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/asuscom.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 asuscom.c
--- drivers/isdn/hisax/asuscom.c	14 Jan 2003 06:53:38 -0000	1.1.1.7
+++ drivers/isdn/hisax/asuscom.c	26 Feb 2003 05:34:48 -0000
@@ -283,7 +283,7 @@
 						printk(KERN_ERR "AsusPnP: attach failed\n");
 						return 0;
 					}
-					if (pnp_activate_dev(pd, NULL) < 0) {
+					if (pnp_activate_dev(pd) < 0) {
 						printk(KERN_ERR "AsusPnP: activate failed\n");
 						pnp_device_detach(pd);
 						return 0;
Index: drivers/isdn/hisax/avm_pci.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/avm_pci.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 avm_pci.c
--- drivers/isdn/hisax/avm_pci.c	14 Jan 2003 06:53:37 -0000	1.1.1.9
+++ drivers/isdn/hisax/avm_pci.c	26 Feb 2003 05:34:48 -0000
@@ -632,7 +632,7 @@
 						printk(KERN_ERR "FritzPnP: attach failed\n");
 						return 0;
 					}
-					if (pnp_activate_dev(pnp_avm, NULL) < 0) {
+					if (pnp_activate_dev(pnp_avm) < 0) {
 						printk(KERN_ERR "FritzPnP: activate failed\n");
 						pnp_device_detach(pnp_avm);
 						return 0;
Index: drivers/isdn/hisax/diva.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/diva.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 diva.c
--- drivers/isdn/hisax/diva.c	14 Jan 2003 06:53:38 -0000	1.1.1.7
+++ drivers/isdn/hisax/diva.c	26 Feb 2003 05:34:48 -0000
@@ -600,7 +600,7 @@
 							printk(KERN_ERR "Diva PnP: attach failed\n");
 							return 0;
 						}
-						if (pnp_activate_dev(pd, NULL) < 0) {
+						if (pnp_activate_dev(pd) < 0) {
 							printk(KERN_ERR "Diva PnP: activate failed\n");
 							pnp_device_detach(pd);
 							return 0;
Index: drivers/isdn/hisax/elsa.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/elsa.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 elsa.c
--- drivers/isdn/hisax/elsa.c	14 Jan 2003 06:53:37 -0000	1.1.1.9
+++ drivers/isdn/hisax/elsa.c	26 Feb 2003 05:34:49 -0000
@@ -864,7 +864,7 @@
 							printk(KERN_ERR "Elsa PnP: attach failed\n");
 							return 0;
 						}
-						if (pnp_activate_dev(pd, NULL) < 0) {
+						if (pnp_activate_dev(pd) < 0) {
 							pnp_device_detach(pd);
 							printk(KERN_ERR "Elsa PnP: activate failed\n");
 							return 0;
Index: drivers/isdn/hisax/hfc_sx.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/hfc_sx.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 hfc_sx.c
--- drivers/isdn/hisax/hfc_sx.c	14 Jan 2003 06:53:37 -0000	1.1.1.9
+++ drivers/isdn/hisax/hfc_sx.c	26 Feb 2003 05:34:49 -0000
@@ -1200,7 +1200,7 @@
 						printk(KERN_ERR "HFC PnP: attach failed\n");
 						return 0;
 					}
-					if (pnp_activate_dev(pd, NULL) < 0) {
+					if (pnp_activate_dev(pd) < 0) {
 						printk(KERN_ERR "HFC PnP: activate failed\n");
 						pnp_device_detach(pd);
 						return 0;
Index: drivers/isdn/hisax/hfcscard.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/hfcscard.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 hfcscard.c
--- drivers/isdn/hisax/hfcscard.c	14 Jan 2003 06:53:38 -0000	1.1.1.6
+++ drivers/isdn/hisax/hfcscard.c	26 Feb 2003 05:34:49 -0000
@@ -193,7 +193,7 @@
 						printk(KERN_ERR "HFC PnP: attach failed\n");
 						return 0;
 					}
-					if (pnp_activate_dev(pd, NULL) < 0) {
+					if (pnp_activate_dev(pd) < 0) {
 						printk(KERN_ERR "HFC PnP: activate failed\n");
 						pnp_device_detach(pd);
 						return 0;
Index: drivers/isdn/hisax/isurf.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/isurf.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 isurf.c
--- drivers/isdn/hisax/isurf.c	14 Jan 2003 06:53:38 -0000	1.1.1.8
+++ drivers/isdn/hisax/isurf.c	26 Feb 2003 05:34:49 -0000
@@ -223,7 +223,7 @@
 					printk(KERN_ERR "ISurfPnP: attach failed\n");
 					return 0;
 				}
-				if (pnp_activate_dev(pd, NULL) < 0) {
+				if (pnp_activate_dev(pd) < 0) {
 					printk(KERN_ERR "ISurfPnP: activate failed\n");
 					pnp_device_detach(pd);
 					return 0;
Index: drivers/isdn/hisax/ix1_micro.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/ix1_micro.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 ix1_micro.c
--- drivers/isdn/hisax/ix1_micro.c	14 Jan 2003 06:53:38 -0000	1.1.1.7
+++ drivers/isdn/hisax/ix1_micro.c	26 Feb 2003 05:34:49 -0000
@@ -208,7 +208,7 @@
 						printk(KERN_ERR "ITK PnP: attach failed\n");
 						return 0;
 					}
-					if (pnp_activate_dev(pd, NULL) < 0) {
+					if (pnp_activate_dev(pd) < 0) {
 						printk(KERN_ERR "ITK PnP: activate failed\n");
 						pnp_device_detach(pd);
 						return 0;
Index: drivers/isdn/hisax/niccy.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/niccy.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 niccy.c
--- drivers/isdn/hisax/niccy.c	14 Jan 2003 06:53:37 -0000	1.1.1.8
+++ drivers/isdn/hisax/niccy.c	26 Feb 2003 05:34:49 -0000
@@ -232,7 +232,7 @@
 				printk(KERN_ERR "NiccyPnP: attach failed\n");
 				return 0;
 			}
-			if (pnp_activate_dev(pd, NULL) < 0) {
+			if (pnp_activate_dev(pd) < 0) {
 				printk(KERN_ERR "NiccyPnP: activate failed\n");
 				pnp_device_detach(pd);
 				return 0;
Index: drivers/isdn/hisax/sedlbauer.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/sedlbauer.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 sedlbauer.c
--- drivers/isdn/hisax/sedlbauer.c	14 Jan 2003 06:53:38 -0000	1.1.1.7
+++ drivers/isdn/hisax/sedlbauer.c	26 Feb 2003 05:34:49 -0000
@@ -524,7 +524,7 @@
 							printk(KERN_ERR "Sedlbauer PnP: attach failed\n");
 							return 0;
 						}
-						if (pnp_activate_dev(pd, NULL) < 0) {
+						if (pnp_activate_dev(pd) < 0) {
 							printk(KERN_ERR "Sedlbauer PnP: activate failed\n");
 							pnp_device_detach(pd);
 							return 0;
Index: drivers/isdn/hisax/teles3.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/isdn/hisax/teles3.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 teles3.c
--- drivers/isdn/hisax/teles3.c	14 Jan 2003 06:53:38 -0000	1.1.1.8
+++ drivers/isdn/hisax/teles3.c	26 Feb 2003 05:34:49 -0000
@@ -227,7 +227,7 @@
 						printk(KERN_ERR "Teles PnP: attach failed\n");
 						return 0;
 					}
-					if (pnp_activate_dev(pnp_dev, NULL) < 0) {
+					if (pnp_activate_dev(pnp_dev) < 0) {
 						printk(KERN_ERR "Teles PnP: activate failed\n");
 						pnp_device_detach(pnp_dev);
 						return 0;
Index: drivers/media/radio/radio-sf16fmi.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/media/radio/radio-sf16fmi.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 radio-sf16fmi.c
--- drivers/media/radio/radio-sf16fmi.c	14 Jan 2003 06:53:35 -0000	1.1.1.10
+++ drivers/media/radio/radio-sf16fmi.c	26 Feb 2003 05:34:49 -0000
@@ -262,7 +262,7 @@
 		return -ENODEV;
 	if (pnp_device_attach(dev) < 0)
 		return -EAGAIN;
-	if (pnp_activate_dev(dev, NULL) < 0) {
+	if (pnp_activate_dev(dev) < 0) {
 		printk ("radio-sf16fmi: PnP configure failed (out of resources?)\n");
 		pnp_device_detach(dev);
 		return -ENOMEM;
Index: drivers/net/3c509.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/net/3c509.c,v
retrieving revision 1.1.1.19
diff -u -r1.1.1.19 3c509.c
--- drivers/net/3c509.c	16 Feb 2003 04:04:48 -0000	1.1.1.19
+++ drivers/net/3c509.c	26 Feb 2003 05:34:49 -0000
@@ -385,7 +385,7 @@
 					    idev))) {
 			if (pnp_device_attach(idev) < 0)
 				continue;
-			if (pnp_activate_dev(idev, NULL) < 0) {
+			if (pnp_activate_dev(idev) < 0) {
 			      __again:
 			      	pnp_device_detach(idev);
 			      	continue;
Index: drivers/net/3c515.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/net/3c515.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 3c515.c
--- drivers/net/3c515.c	17 Jan 2003 02:42:49 -0000	1.1.1.9
+++ drivers/net/3c515.c	26 Feb 2003 05:34:49 -0000
@@ -469,7 +469,7 @@
 
 			if (pnp_device_attach(idev) < 0)
 				continue;
-			if (pnp_activate_dev(idev, NULL) < 0) {
+			if (pnp_activate_dev(idev) < 0) {
 				printk("pnp activate failed (out of resources?)\n");
 				pnp_device_detach(idev);
 				return -ENOMEM;
Index: drivers/net/ne.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/net/ne.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 ne.c
--- drivers/net/ne.c	14 Jan 2003 07:17:36 -0000	1.1.1.6
+++ drivers/net/ne.c	26 Feb 2003 05:34:49 -0000
@@ -205,7 +205,7 @@
 			/* Avoid already found cards from previous calls */
 			if (pnp_device_attach(idev) < 0)
 				continue;
-			if (pnp_activate_dev(idev, NULL) < 0) {
+			if (pnp_activate_dev(idev) < 0) {
 			      	pnp_device_detach(idev);
 			      	continue;
 			}
Index: drivers/net/sb1000.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/net/sb1000.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 sb1000.c
--- drivers/net/sb1000.c	14 Jan 2003 06:53:22 -0000	1.1.1.7
+++ drivers/net/sb1000.c	26 Feb 2003 05:34:49 -0000
@@ -170,7 +170,7 @@
 		 
 		if (pnp_device_attach(idev) < 0)
 			continue;
-		if (pnp_activate_dev(idev, NULL) < 0) {
+		if (pnp_activate_dev(idev) < 0) {
 		      __again:
 			pnp_device_detach(idev);
 			continue;
Index: drivers/net/smc-ultra.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/net/smc-ultra.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 smc-ultra.c
--- drivers/net/smc-ultra.c	14 Jan 2003 07:17:35 -0000	1.1.1.9
+++ drivers/net/smc-ultra.c	26 Feb 2003 05:34:49 -0000
@@ -293,7 +293,7 @@
                         /* Avoid already found cards from previous calls */
                         if (pnp_device_attach(idev) < 0)
                         	continue;
-                        if (pnp_activate_dev(idev, NULL) < 0) {
+                        if (pnp_activate_dev(idev) < 0) {
                               __again:
                         	pnp_device_detach(idev);
                         	continue;
Index: drivers/pcmcia/i82365.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/pcmcia/i82365.c,v
retrieving revision 1.1.1.12
retrieving revision 1.2
diff -u -r1.1.1.12 -r1.2
--- drivers/pcmcia/i82365.c	25 Feb 2003 05:29:17 -0000	1.1.1.12
+++ drivers/pcmcia/i82365.c	25 Feb 2003 07:05:37 -0000	1.2
@@ -846,7 +846,7 @@
 	
 	    printk("PNP ");
 	    
-	    if (pnp_activate_dev(dev, NULL) < 0) {
+	    if (pnp_activate_dev(dev) < 0) {
 		printk("activate failed\n");
 		pnp_device_detach(dev);
 		break;
Index: drivers/scsi/aha152x.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/scsi/aha152x.c,v
retrieving revision 1.1.1.12
diff -u -r1.1.1.12 aha152x.c
--- drivers/scsi/aha152x.c	25 Feb 2003 05:29:00 -0000	1.1.1.12
+++ drivers/scsi/aha152x.c	26 Feb 2003 05:34:49 -0000
@@ -1131,7 +1131,7 @@
 	while ( setup_count<ARRAY_SIZE(setup) && (dev=pnp_find_dev(NULL, ISAPNP_VENDOR('A','D','P'), ISAPNP_FUNCTION(0x1505), dev)) ) {
 		if (pnp_device_attach(dev) < 0)
 			continue;
-		if (pnp_activate_dev(dev, NULL) < 0) {
+		if (pnp_activate_dev(dev) < 0) {
 			pnp_device_detach(dev);
 			continue;
 		}
Index: drivers/scsi/aha1542.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/scsi/aha1542.c,v
retrieving revision 1.1.1.13
diff -u -r1.1.1.13 aha1542.c
--- drivers/scsi/aha1542.c	18 Feb 2003 01:19:54 -0000	1.1.1.13
+++ drivers/scsi/aha1542.c	26 Feb 2003 05:34:50 -0000
@@ -1161,7 +1161,7 @@
 			if(pnp_device_attach(pdev)<0)
 				continue;
 			
-			if(pnp_activate_dev(pdev, NULL)<0) {
+			if(pnp_activate_dev(pdev)<0) {
 				pnp_device_detach(pdev);
 				continue;
 			}
Index: drivers/scsi/g_NCR5380.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/scsi/g_NCR5380.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 g_NCR5380.c
--- drivers/scsi/g_NCR5380.c	10 Feb 2003 19:31:44 -0000	1.1.1.9
+++ drivers/scsi/g_NCR5380.c	26 Feb 2003 05:34:50 -0000
@@ -323,7 +323,7 @@
 				printk(KERN_ERR "dtc436e probe: attach failed\n");
 				continue;
 			}
-			if (pnp_activate_dev(dev, NULL) < 0) {
+			if (pnp_activate_dev(dev) < 0) {
 				printk(KERN_ERR "dtc436e probe: activate failed\n");
 				pnp_device_detach(dev);
 				continue;
Index: drivers/scsi/sym53c416.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/scsi/sym53c416.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 sym53c416.c
--- drivers/scsi/sym53c416.c	16 Feb 2003 04:05:02 -0000	1.1.1.7
+++ drivers/scsi/sym53c416.c	26 Feb 2003 05:34:50 -0000
@@ -679,7 +679,7 @@
 				printk(KERN_WARNING "sym53c416: unable to attach PnP device.\n");
 				continue;
 			}
-			if(pnp_activate_dev(idev, NULL)<0)
+			if(pnp_activate_dev(idev)<0)
 			{
 				printk(KERN_WARNING "sym53c416: unable to activate PnP device.\n");
 				pnp_device_detach(idev);
Index: drivers/telephony/ixj.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/telephony/ixj.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 ixj.c
--- drivers/telephony/ixj.c	14 Jan 2003 06:54:04 -0000	1.1.1.8
+++ drivers/telephony/ixj.c	26 Feb 2003 05:34:50 -0000
@@ -7717,7 +7717,7 @@
 				printk("pnp attach failed %d \n", result);
 				break;
 			}
-			if (pnp_activate_dev(dev, NULL) < 0) {
+			if (pnp_activate_dev(dev) < 0) {
 				printk("pnp activate failed (out of resources?)\n");
 				pnp_device_detach(dev);
 				return -ENOMEM;
Index: drivers/usb/Makefile.lib
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/usb/Makefile.lib,v
retrieving revision 1.1.1.3
retrieving revision 1.3
diff -u -r1.1.1.3 -r1.3
Index: sound/oss/ad1848.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/sound/oss/ad1848.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 ad1848.c
--- sound/oss/ad1848.c	16 Feb 2003 04:06:51 -0000	1.1.1.9
+++ sound/oss/ad1848.c	26 Feb 2003 05:34:51 -0000
@@ -2987,7 +2987,7 @@
 	if (err < 0)
 		return(NULL);
 
-	if((err = pnp_activate_dev(dev,NULL)) < 0) {
+	if((err = pnp_activate_dev(dev)) < 0) {
 		printk(KERN_ERR "ad1848: %s %s config failed (out of resources?)[%d]\n", devname, resname, err);
 
 		pnp_device_detach(dev);

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
