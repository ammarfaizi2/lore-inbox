Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263658AbTCUQyr>; Fri, 21 Mar 2003 11:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263660AbTCUQyr>; Fri, 21 Mar 2003 11:54:47 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:45479 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S263658AbTCUQyq>; Fri, 21 Mar 2003 11:54:46 -0500
Message-Id: <200303211705.h2LH5BGi002669@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][ATM] s/uni driver overwrites 8-/16-bit mode
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 21 Mar 2003 12:05:10 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on the s/uni 622 chip, the uppermost bit of the Master Test register
controls the width of the data bus.  this is unused in the older s/uni
chips.

Index: linux/drivers/atm/suni.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/suni.c,v
retrieving revision 1.4
diff -b -B -u -r1.4 suni.c
--- linux/drivers/atm/suni.c	5 Mar 2003 16:39:56 -0000	1.4
+++ linux/drivers/atm/suni.c	21 Mar 2003 16:53:04 -0000
@@ -297,7 +297,7 @@
 	mri = GET(MRI); /* reset SUNI */
 	PUT(mri | SUNI_MRI_RESET,MRI);
 	PUT(mri,MRI);
-	PUT(0,MT); /* disable all tests */
+	PUT((GET(MT) & SUNI_MT_DS27_53),MT); /* disable all tests */
 	REG_CHANGE(SUNI_TPOP_APM_S,SUNI_TPOP_APM_S_SHIFT,SUNI_TPOP_S_SONET,
 	    TPOP_APM); /* use SONET */
 	REG_CHANGE(SUNI_TACP_IUCHP_CLP,0,SUNI_TACP_IUCHP_CLP,
Index: linux/drivers/atm/suni.h
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/suni.h,v
retrieving revision 1.1.1.1
diff -b -B -u -r1.1.1.1 suni.h
--- linux/drivers/atm/suni.h	20 Feb 2003 13:45:03 -0000	1.1.1.1
+++ linux/drivers/atm/suni.h	21 Mar 2003 16:55:46 -0000
@@ -198,6 +198,7 @@
 #define SUNI_MT_IOTST		0x04	/* RW, enable test mode */
 #define SUNI_MT_DBCTRL		0x08	/* W, control data bus by CSB pin */
 #define SUNI_MT_PMCTST		0x10	/* W, PMC test mode */
+#define SUNI_MT_DS27_53		0x80	/* RW, select between 8- or 16- bit */
 
 
 #define SUNI_IDLE_PATTERN       0x6a    /* idle pattern */
