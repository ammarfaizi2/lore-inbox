Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131547AbRCUPbv>; Wed, 21 Mar 2001 10:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131557AbRCUPbm>; Wed, 21 Mar 2001 10:31:42 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:48137 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S131547AbRCUPb3>;
	Wed, 21 Mar 2001 10:31:29 -0500
Date: Wed, 21 Mar 2001 16:30:31 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, khc@pm.waw.pl
Subject: [PATCH] 2.4.3-pre6 - hdlc/dscc4 missing bits
Message-ID: <20010321163031.A28981@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- hdlc.c requires ARPHRD_CISCO (Cisco HDLC) to compile. This should* 
be ARPHRD_HDLC
- the PCI_VENDOR/DEVICE_xxx for drivers/net/wan/dscc4.c haven't been
included in the pci_ids db
- drivers/net/wan/dscc4.c relies on ARPHRD_RAWHDLC (it's initialized 
as a transparent hdlc driver and I know no ARPHRD_xxx for this)

*the name is misleading as it's only used for Cisco-HDLC (!= HDLC) :o(

diff -u -N --recursive linux-2.4.3-pre6.orig/drivers/net/wan/hdlc.c linux-2.4.3-pre6/drivers/net/wan/hdlc.c
--- linux-2.4.3-pre6.orig/drivers/net/wan/hdlc.c	Wed Mar 21 10:56:18 2001
+++ linux-2.4.3-pre6/drivers/net/wan/hdlc.c	Wed Mar 21 15:11:50 2001
@@ -1230,7 +1230,7 @@
 	case MODE_X25:   dev->type = ARPHRD_X25;   break;
 #endif
 	case MODE_FR:    dev->type = ARPHRD_FRAD;  break;
-	case MODE_CISCO: dev->type = ARPHRD_CISCO; break;
+	case MODE_CISCO: dev->type = ARPHRD_HDLC; break;
 	default:         dev->type = ARPHRD_RAWHDLC;
 	}
 
diff -u -N --recursive linux-2.4.3-pre6.orig/include/linux/if_arp.h linux-2.4.3-pre6/include/linux/if_arp.h
--- linux-2.4.3-pre6.orig/include/linux/if_arp.h	Thu Jan  4 22:51:20 2001
+++ linux-2.4.3-pre6/include/linux/if_arp.h	Wed Mar 21 15:12:23 2001
@@ -53,6 +53,7 @@
 #define ARPHRD_HDLC	513		/* (Cisco) HDLC 		*/
 #define ARPHRD_LAPB	516		/* LAPB				*/
 #define ARPHRD_DDCMP    517		/* Digital's DDCMP protocol     */
+#define ARPHRD_RAWHDLC  518             /* Raw HDLC                     */
 
 #define ARPHRD_TUNNEL	768		/* IPIP tunnel			*/
 #define ARPHRD_TUNNEL6	769		/* IPIP6 tunnel			*/
diff -u -N --recursive linux-2.4.3-pre6.orig/include/linux/pci_ids.h linux-2.4.3-pre6/include/linux/pci_ids.h
--- linux-2.4.3-pre6.orig/include/linux/pci_ids.h	Wed Mar 21 10:56:28 2001
+++ linux-2.4.3-pre6/include/linux/pci_ids.h	Wed Mar 21 14:07:28 2001
@@ -804,6 +804,9 @@
 #define PCI_DEVICE_ID_VIA_8633_1	0xB091
 #define PCI_DEVICE_ID_VIA_8367_1	0xB099
 
+#define PCI_VENDOR_ID_SIEMENS           0x110A
+#define PCI_DEVICE_ID_SIEMENS_DSCC4     0x2102
+
 #define PCI_VENDOR_ID_SMC2		0x1113
 #define PCI_DEVICE_ID_SMC2_1211TX	0x1211
 
-- 
Ueimor
