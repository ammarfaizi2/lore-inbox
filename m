Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130612AbQLIJjc>; Sat, 9 Dec 2000 04:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130650AbQLIJjX>; Sat, 9 Dec 2000 04:39:23 -0500
Received: from p3E9E13C0.dip.t-dialin.net ([62.158.19.192]:2821 "EHLO
	intranator.local.net") by vger.kernel.org with ESMTP
	id <S130612AbQLIJjF>; Sat, 9 Dec 2000 04:39:05 -0500
Message-ID: <005801c061bf$96740e90$020110ac@local.net>
From: "Thomas Jarosch" <thomas.jarosch@styletec.de>
To: <linux-kernel@vger.kernel.org>
Subject: e100 patch for kernel 2.2.18
Date: Sat, 9 Dec 2000 10:08:25 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0055_01C061C7.F8262710"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0055_01C061C7.F8262710
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I've seen the e100 udelay/compile problem twice and now I think,
I should release my patch.

I've already send it to Intel but the are not responding.

Please CC: any comments.

cheers, Thomas.


------=_NextPart_000_0055_01C061C7.F8262710
Content-Type: application/octet-stream;
	name="e100-type.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="e100-type.patch"

diff -r -u e100-1.3.14.orig/src/e100.h e100-1.3.14/src/e100.h=0A=
--- e100-1.3.14.orig/src/e100.h	Tue Sep 26 17:15:05 2000=0A=
+++ e100-1.3.14/src/e100.h	Fri Nov 24 19:33:09 2000=0A=
@@ -254,7 +254,7 @@=0A=
 #include <linux/slab.h>=0A=
 #include <asm/io.h>=0A=
 =0A=
-typedef unsigned long dma_addr_t;=0A=
+// typedef unsigned long dma_addr_t;=0A=
 =0A=
 extern inline void *pci_alloc_consistent (struct pci_dev *dev,=0A=
     size_t size,=0A=

------=_NextPart_000_0055_01C061C7.F8262710
Content-Type: application/octet-stream;
	name="e100-mdelay.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="e100-mdelay.patch"

diff -r -u e100-1.3.20/src/e100.c e100-1.3.20.working/src/e100.c=0A=
--- e100-1.3.20/src/e100.c	Wed Nov  1 15:32:53 2000=0A=
+++ e100-1.3.20.working/src/e100.c	Sat Dec  9 10:04:46 2000=0A=
@@ -1423,7 +1423,7 @@=0A=
 	e100_retry =3D E100_CMD_WAIT;=0A=
 	while (((bddp->scbp->scb_status & SCB_CUS_MASK) =3D=3D SCB_CUS_ACTIVE)=0A=
             && (e100_retry)) {=0A=
-	    udelay(mstous(20));=0A=
+	    mdelay(20);=0A=
 	    e100_retry--;=0A=
 	}=0A=
     }=0A=
@@ -1683,7 +1683,7 @@=0A=
 	    printk(KERN_WARNING "e100[%d]: Did not load ucode\n", =
bdp->bd_number);=0A=
 	} else {=0A=
 	    bddp->ucode_loaded =3D 1;=0A=
-	    drv_usecwait(mstous(1000));   /* 1 sec wait */=0A=
+	    mdelay(1000);=0A=
 	}=0A=
     }=0A=
 =0A=
@@ -3182,7 +3182,7 @@=0A=
     bddp->scbp->scb_port =3D SelfTestCommandCode;=0A=
 =0A=
     /* Wait 5 milliseconds for the self-test to complete */=0A=
-    drv_usecwait(mstous(50));=0A=
+    mdelay(5);=0A=
 =0A=
     /* if The First Self Test DWORD Still Zero, We've timed out. * If =
the=0A=
      * second DWORD is not zero then we have an error. */=0A=
@@ -3451,7 +3451,7 @@=0A=
 	e100_retry =3D E100_CMD_WAIT;=0A=
 	while (((bddp->scbp->scb_status & SCB_CUS_MASK) =3D=3D SCB_CUS_ACTIVE)=0A=
             && (e100_retry)) {=0A=
-	    drv_usecwait(mstous(20));=0A=
+	    mdelay(20);=0A=
 	    e100_retry--;=0A=
 	}=0A=
     }=0A=
@@ -3531,7 +3531,7 @@=0A=
 	i =3D 0;=0A=
 	while (((bddp->scbp->scb_status & SCB_CUS_MASK) =3D=3D SCB_CUS_ACTIVE)=0A=
             && (i < 5)) {=0A=
-	    drv_usecwait(mstous(20));=0A=
+	    mdelay(20);=0A=
 	    i++;=0A=
 	}=0A=
     }=0A=
@@ -3688,7 +3688,7 @@=0A=
     e100_retry =3D E100_CMD_WAIT;=0A=
     while (((uint16_t) bddp->pstats_counters->cmd_complete !=3D 0xA007)=0A=
 	&& (e100_retry)) {=0A=
-	drv_usecwait(mstous(20));=0A=
+	mdelay(20);=0A=
 	e100_retry--;=0A=
     }=0A=
 =0A=
@@ -3730,7 +3730,7 @@=0A=
 =0A=
     while (((bddp->scbp->scb_status & SCB_CUS_MASK) =3D=3D =
SCB_CUS_ACTIVE)=0A=
 	&& (retry)) {=0A=
-	drv_usecwait(mstous(20));=0A=
+	mdelay(20);=0A=
 	retry--;=0A=
     }=0A=
     if (!retry) {=0A=
@@ -3887,7 +3887,7 @@=0A=
 =0A=
     /* Wait 100ms for some status */=0A=
     for (delay =3D 0; delay < 100; delay++) {=0A=
-	drv_usecwait(mstous(1));=0A=
+	mdelay (1);=0A=
 =0A=
 	/* need to check the pmc_buff status in case it's from the *=0A=
 	 *    set_multicast cmd */=0A=
@@ -3964,7 +3964,7 @@=0A=
     bddp->scbp->scb_port =3D reset_cmd;=0A=
 =0A=
     /* wait 5 milliseconds for the reset to take effect */=0A=
-    drv_usecwait(mstous(5));=0A=
+    mdelay(5);=0A=
 =0A=
     /* Mask off our interrupt line -- its unmasked after reset */=0A=
     e100_dis_intr(bdp);=0A=
@@ -4097,7 +4097,7 @@=0A=
 	i =3D 0;=0A=
 	while (((bddp->scbp->scb_status & SCB_CUS_MASK) =3D=3D SCB_CUS_ACTIVE)=0A=
             && (i < 5)) {=0A=
-	    drv_usecwait(mstous(20));=0A=
+	    mdelay(20);=0A=
 	    i++;=0A=
 	}=0A=
 	if (i =3D=3D 5) {=0A=
@@ -4894,7 +4894,7 @@=0A=
 	    e100_MdiWrite(bdp, MDI_CONTROL_REG, Phy1, MDI_CR_ISOLATE);=0A=
 =0A=
 	    /* wait 100 milliseconds for the phy to isolate. */=0A=
-	    drv_usecwait(mstous(100));=0A=
+	    mdelay(100);=0A=
 	}=0A=
 =0A=
 	/* Since this Phy is at address 0, we must enable it.  So clear */=0A=
@@ -4902,7 +4902,7 @@=0A=
 	e100_MdiWrite(bdp, MDI_CONTROL_REG, 0, MDI_CR_AUTO_SELECT);=0A=
 =0A=
 	/* wait 100 milliseconds for the phy to be enabled. */=0A=
-	drv_usecwait(mstous(100));=0A=
+	mdelay(100);=0A=
 =0A=
 	/* restart the auto-negotion process */=0A=
 	e100_MdiWrite(bdp, MDI_CONTROL_REG, 0,=0A=
@@ -4917,7 +4917,7 @@=0A=
 	    if (MdiStatusReg & MDI_SR_AUTO_NEG_COMPLETE)=0A=
 		break;=0A=
 =0A=
-	    drv_usecwait(mstous(10));=0A=
+	    mdelay(10);=0A=
 	    ReNegotiateTime--;=0A=
 	}=0A=
 =0A=
@@ -4945,14 +4945,14 @@=0A=
 		e100_MdiWrite(bdp, MDI_CONTROL_REG, 0, MDI_CR_ISOLATE);=0A=
 =0A=
 		/* wait 100 milliseconds for the phy to isolate. */=0A=
-		drv_usecwait(mstous(100));=0A=
+		mdelay(100);=0A=
 =0A=
 		/* Now re-enable PHY 1 */=0A=
 		e100_MdiWrite(bdp, MDI_CONTROL_REG, Phy1,=0A=
 		    MDI_CR_AUTO_SELECT);=0A=
 =0A=
 		/* wait 100 milliseconds for the phy to be enabled. */=0A=
-		drv_usecwait(mstous(100));=0A=
+		mdelay(100);=0A=
 =0A=
 		/* restart the auto-negotion process */=0A=
 		e100_MdiWrite(bdp, MDI_CONTROL_REG, bddp->phy_addr,=0A=
@@ -5146,7 +5146,7 @@=0A=
 =0A=
 		    /* if non-zero, wait for 100 ms before reading again */=0A=
 		    if (errors) {=0A=
-			udelay(mstous(100));=0A=
+			mdelay(100);=0A=
 			e100_MdiRead(bdp, PHY_82555_EOF_COUNTER, PhyAdd, &errors);=0A=
 =0A=
 			/* if non-zero again, we disable polarity */=0A=
@@ -5217,7 +5217,7 @@=0A=
 	for (i =3D 0; (!(mdi_status_reg & MDI_SR_AUTO_NEG_COMPLETE)) &&=0A=
 		 (i < 300); i++) {=0A=
 	    /* delay 10 milliseconds */=0A=
-	    udelay(TEN_MILLI_SEC);=0A=
+	    mdelay (10);=0A=
 =0A=
 	    /* now re-read the value. Sticky so read twice */=0A=
 	    e100_MdiRead(bdp, MDI_STATUS_REG, bddp->phy_addr,=0A=
@@ -5491,7 +5491,7 @@=0A=
 =0A=
     e100_MdiWrite(bdp, MDI_CONTROL_REG, bddp->phy_addr, control);=0A=
 =0A=
-    drv_usecwait(mstous(2000));=0A=
+    mdelay(2000);=0A=
 }=0A=
 =0A=
 =0A=
diff -r -u e100-1.3.20/src/e100.h e100-1.3.20.working/src/e100.h=0A=
--- e100-1.3.20/src/e100.h	Wed Nov  1 15:32:53 2000=0A=
+++ e100-1.3.20.working/src/e100.h	Sat Dec  9 10:04:46 2000=0A=
@@ -1367,9 +1367,9 @@=0A=
 #define IS_VALID_MULTICAST(x)  ((x)->bytes[0] & 0x1 )=0A=
 =0A=
 /* Macros for e100_delay */=0A=
-#define   mstous(X)   ((X)*1000) /* millisecs to microsecs */=0A=
-#define  ONE_MILLI_SEC 1000=0A=
-#define  TEN_MILLI_SEC ONE_MILLI_SEC * 10=0A=
+// #define   mstous(X)   ((X)*1000) /* millisecs to microsecs */=0A=
+// #define  ONE_MILLI_SEC 1000=0A=
+// #define  TEN_MILLI_SEC ONE_MILLI_SEC * 10=0A=
 =0A=
 /* Device ID macros */=0A=
 #define get_pci_dev(X)          ((X)&PCI_DEV_NO)=0A=

------=_NextPart_000_0055_01C061C7.F8262710--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
