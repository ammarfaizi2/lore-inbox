Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131669AbQK2Qq7>; Wed, 29 Nov 2000 11:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131672AbQK2Qqt>; Wed, 29 Nov 2000 11:46:49 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:6842 "EHLO
        xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
        id <S131669AbQK2Qqg>; Wed, 29 Nov 2000 11:46:36 -0500
Date: Wed, 29 Nov 2000 17:16:04 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre2
In-Reply-To: <20001129153526.W13759@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.10.10011291713160.5798-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Nov 2000, Ingo Oeser wrote:

> IIRC variables marked as "__initdata" need to be explicitly set
> even to zero, because gcc won't put them into the right section
> otherwise. One of Tigran's patches has been reverted because of
> this.

I checked the archives, you're right, of course.

Fix is appended, Linus please apply.

--Kai

diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/avm_pci.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/avm_pci.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/avm_pci.c	Wed Nov 29 11:38:12 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/avm_pci.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-/* $Id: avm_pci.c,v 1.22.6.1 2000/11/28 12:02:46 kai Exp $
+/* $Id: avm_pci.c,v 1.22.6.2 2000/11/29 16:00:14 kai Exp $
  *
  * avm_pci.c    low level stuff for AVM Fritz!PCI and ISA PnP isdn cards
  *              Thanks to AVM, Berlin for informations
@@ -18,7 +18,7 @@
 #include <linux/interrupt.h>
 
 extern const char *CardType[];
-static const char *avm_pci_rev = "$Revision: 1.22.6.1 $";
+static const char *avm_pci_rev = "$Revision: 1.22.6.2 $";
 
 #define  AVM_FRITZ_PCI		1
 #define  AVM_FRITZ_PNP		2
@@ -758,7 +758,7 @@
 	return(0);
 }
 
-static struct pci_dev *dev_avm __initdata;
+static struct pci_dev *dev_avm __initdata = NULL;
 
 int __init
 setup_avm_pcipnp(struct IsdnCard *card)
diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/bkm_a4t.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/bkm_a4t.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/bkm_a4t.c	Wed Nov 29 11:38:13 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/bkm_a4t.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-/* $Id: bkm_a4t.c,v 1.13.6.1 2000/11/28 12:02:46 kai Exp $
+/* $Id: bkm_a4t.c,v 1.13.6.2 2000/11/29 16:00:14 kai Exp $
  * bkm_a4t.c    low level stuff for T-Berkom A4T
  *              derived from the original file sedlbauer.c
  *              derived from the original file niccy.c
@@ -24,7 +24,7 @@
 
 extern const char *CardType[];
 
-const char *bkm_a4t_revision = "$Revision: 1.13.6.1 $";
+const char *bkm_a4t_revision = "$Revision: 1.13.6.2 $";
 
 
 static inline u_char
@@ -264,7 +264,7 @@
 	return (0);
 }
 
-static struct pci_dev *dev_a4t __initdata;
+static struct pci_dev *dev_a4t __initdata = NULL;
 
 int __init
 setup_bkm_a4t(struct IsdnCard *card)
diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/bkm_a8.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/bkm_a8.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/bkm_a8.c	Wed Nov 29 11:38:13 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/bkm_a8.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-/* $Id: bkm_a8.c,v 1.14.6.1 2000/11/28 12:02:46 kai Exp $
+/* $Id: bkm_a8.c,v 1.14.6.2 2000/11/29 16:00:14 kai Exp $
  * bkm_a8.c     low level stuff for Scitel Quadro (4*S0, passive)
  *              derived from the original file sedlbauer.c
  *              derived from the original file niccy.c
@@ -27,7 +27,7 @@
 
 extern const char *CardType[];
 
-const char sct_quadro_revision[] = "$Revision: 1.14.6.1 $";
+const char sct_quadro_revision[] = "$Revision: 1.14.6.2 $";
 
 static const char *sct_quadro_subtypes[] =
 {
@@ -283,12 +283,12 @@
 	return(0);
 }
 
-static struct pci_dev *dev_a8 __initdata;
-static u16  sub_vendor_id __initdata;
-static u16  sub_sys_id __initdata;
-static u_char pci_bus __initdata;
-static u_char pci_device_fn __initdata;
-static u_char pci_irq __initdata;
+static struct pci_dev *dev_a8 __initdata = NULL;
+static u16  sub_vendor_id __initdata = 0;
+static u16  sub_sys_id __initdata = 0;
+static u_char pci_bus __initdata = 0;
+static u_char pci_device_fn __initdata = 0;
+static u_char pci_irq __initdata = 0;
 
 #endif /* CONFIG_PCI */
 
diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/diva.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/diva.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/diva.c	Wed Nov 29 11:38:13 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/diva.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-/* $Id: diva.c,v 1.25.6.1 2000/11/28 12:02:46 kai Exp $
+/* $Id: diva.c,v 1.25.6.2 2000/11/29 16:00:14 kai Exp $
  *
  * diva.c     low level stuff for Eicon.Diehl Diva Family ISDN cards
  *
@@ -24,7 +24,7 @@
 
 extern const char *CardType[];
 
-const char *Diva_revision = "$Revision: 1.25.6.1 $";
+const char *Diva_revision = "$Revision: 1.25.6.2 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -820,9 +820,9 @@
 	return(0);
 }
 
-static 	struct pci_dev *dev_diva __initdata;
-static 	struct pci_dev *dev_diva_u __initdata;
-static 	struct pci_dev *dev_diva201 __initdata;
+static struct pci_dev *dev_diva __initdata = NULL;
+static struct pci_dev *dev_diva_u __initdata = NULL;
+static struct pci_dev *dev_diva201 __initdata = NULL;
 
 int __init
 setup_diva(struct IsdnCard *card)
diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/gazel.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/gazel.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/gazel.c	Wed Nov 29 11:38:13 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/gazel.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-/* $Id: gazel.c,v 2.11.6.1 2000/11/28 12:02:46 kai Exp $
+/* $Id: gazel.c,v 2.11.6.2 2000/11/29 16:00:14 kai Exp $
  *
  * gazel.c     low level stuff for Gazel isdn cards
  *
@@ -19,7 +19,7 @@
 #include <linux/pci.h>
 
 extern const char *CardType[];
-const char *gazel_revision = "$Revision: 2.11.6.1 $";
+const char *gazel_revision = "$Revision: 2.11.6.2 $";
 
 #define R647      1
 #define R685      2
@@ -544,7 +544,7 @@
 	return (0);
 }
 
-static struct pci_dev *dev_tel __initdata;
+static struct pci_dev *dev_tel __initdata = NULL;
 
 static int
 setup_gazelpci(struct IsdnCardState *cs)
diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/niccy.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/niccy.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/niccy.c	Wed Nov 29 11:38:14 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/niccy.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-/* $Id: niccy.c,v 1.15.6.1 2000/11/28 12:02:46 kai Exp $
+/* $Id: niccy.c,v 1.15.6.2 2000/11/29 16:00:14 kai Exp $
  *
  * niccy.c  low level stuff for Dr. Neuhaus NICCY PnP and NICCY PCI and
  *          compatible (SAGEM cybermodem)
@@ -22,7 +22,7 @@
 #include <linux/pci.h>
 
 extern const char *CardType[];
-const char *niccy_revision = "$Revision: 1.15.6.1 $";
+const char *niccy_revision = "$Revision: 1.15.6.2 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -235,7 +235,7 @@
 	return(0);
 }
 
-static struct pci_dev *niccy_dev __initdata;
+static struct pci_dev *niccy_dev __initdata = NULL;
 
 int __init
 setup_niccy(struct IsdnCard *card)
diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/nj_s.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/nj_s.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/nj_s.c	Wed Nov 29 11:38:14 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/nj_s.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-// $Id: nj_s.c,v 2.7 2000/11/24 17:05:38 kai Exp $
+// $Id: nj_s.c,v 2.7.6.1 2000/11/29 16:00:14 kai Exp $
 //
 // This file is (c) under GNU PUBLIC LICENSE
 //
@@ -14,7 +14,7 @@
 #include <linux/ppp_defs.h>
 #include "netjet.h"
 
-const char *NETjet_S_revision = "$Revision: 2.7 $";
+const char *NETjet_S_revision = "$Revision: 2.7.6.1 $";
 
 static u_char dummyrr(struct IsdnCardState *cs, int chan, u_char off)
 {
@@ -140,7 +140,7 @@
 	return(0);
 }
 
-static struct pci_dev *dev_netjet __initdata;
+static struct pci_dev *dev_netjet __initdata = NULL;
 
 int __init
 setup_netjet_s(struct IsdnCard *card)
diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/nj_u.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/nj_u.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/nj_u.c	Wed Nov 29 11:38:14 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/nj_u.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-/* $Id: nj_u.c,v 2.8 2000/11/24 17:05:38 kai Exp $ 
+/* $Id: nj_u.c,v 2.8.6.1 2000/11/29 16:00:14 kai Exp $ 
  *
  * This file is (c) under GNU PUBLIC LICENSE
  *
@@ -15,7 +15,7 @@
 #include <linux/ppp_defs.h>
 #include "netjet.h"
 
-const char *NETjet_U_revision = "$Revision: 2.8 $";
+const char *NETjet_U_revision = "$Revision: 2.8.6.1 $";
 
 static u_char dummyrr(struct IsdnCardState *cs, int chan, u_char off)
 {
@@ -142,7 +142,7 @@
 	return(0);
 }
 
-static struct pci_dev *dev_netjet __initdata;
+static struct pci_dev *dev_netjet __initdata = NULL;
 
 int __init
 setup_netjet_u(struct IsdnCard *card)
diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/telespci.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/telespci.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/telespci.c	Wed Nov 29 11:38:14 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/telespci.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-/* $Id: telespci.c,v 2.16.6.1 2000/11/28 12:02:46 kai Exp $
+/* $Id: telespci.c,v 2.16.6.2 2000/11/29 16:00:14 kai Exp $
  *
  * telespci.c     low level stuff for Teles PCI isdn cards
  *
@@ -18,7 +18,7 @@
 #include <linux/pci.h>
 
 extern const char *CardType[];
-const char *telespci_revision = "$Revision: 2.16.6.1 $";
+const char *telespci_revision = "$Revision: 2.16.6.2 $";
 
 #define ZORAN_PO_RQ_PEN	0x02000000
 #define ZORAN_PO_WR	0x00800000
@@ -275,7 +275,7 @@
 	return(0);
 }
 
-static struct pci_dev *dev_tel __initdata;
+static struct pci_dev *dev_tel __initdata = NULL;
 
 int __init
 setup_telespci(struct IsdnCard *card)
diff -ur linux-2.4.0-test12-pre3/drivers/isdn/hisax/w6692.c linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/w6692.c
--- linux-2.4.0-test12-pre3/drivers/isdn/hisax/w6692.c	Wed Nov 29 11:38:15 2000
+++ linux-2.4.0-test12-pre3.w/drivers/isdn/hisax/w6692.c	Wed Nov 29 17:04:19 2000
@@ -1,4 +1,4 @@
-/* $Id: w6692.c,v 1.12.6.1 2000/11/28 12:02:46 kai Exp $
+/* $Id: w6692.c,v 1.12.6.2 2000/11/29 16:00:14 kai Exp $
  *
  * w6692.c   Winbond W6692 specific routines
  *
@@ -35,7 +35,7 @@
 
 extern const char *CardType[];
 
-const char *w6692_revision = "$Revision: 1.12.6.1 $";
+const char *w6692_revision = "$Revision: 1.12.6.2 $";
 
 #define DBUSY_TIMER_VALUE 80
 
@@ -957,7 +957,7 @@
 
 static int id_idx ;
 
-static struct pci_dev *dev_w6692 __initdata;
+static struct pci_dev *dev_w6692 __initdata = NULL;
 
 int __init 
 setup_w6692(struct IsdnCard *card)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
