Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265788AbUBBS0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbUBBS0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:26:48 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:13925 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265788AbUBBS0d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:26:33 -0500
Date: Mon, 2 Feb 2004 19:26:32 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 5/42]
Message-ID: <20040202182632.GE6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


amd7930_fn.h:35: warning: `initAMD' defined but not used

There is a static array in a header file. I moved it in the c file.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/isdn/hisax/amd7930_fn.c linux-2.4/drivers/isdn/hisax/amd7930_fn.c
--- linux-2.4-vanilla/drivers/isdn/hisax/amd7930_fn.c	Fri Nov 29 00:53:13 2002
+++ linux-2.4/drivers/isdn/hisax/amd7930_fn.c	Sat Jan 31 16:38:54 2004
@@ -61,6 +61,40 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
+static WORD initAMD[] __devinit = {
+	0x0100,
+
+	0x00A5, 3, 0x01, 0x40, 0x58,				// LPR, LMR1, LMR2
+	0x0086, 1, 0x0B,					// DMR1 (D-Buffer TH-Interrupts on)
+	0x0087, 1, 0xFF,					// DMR2
+	0x0092, 1, 0x03,					// EFCR (extended mode d-channel-fifo on)
+	0x0090, 4, 0xFE, 0xFF, 0x02, 0x0F,			// FRAR4, SRAR4, DMR3, DMR4 (address recognition )
+	0x0084, 2, 0x80, 0x00,					// DRLR
+	0x00C0, 1, 0x47,					// PPCR1
+	0x00C8, 1, 0x01,					// PPCR2
+
+	0x0102,
+	0x0107,
+	0x01A1, 1,
+	0x0121, 1,
+	0x0189, 2,
+
+	0x0045, 4, 0x61, 0x72, 0x00, 0x00,			// MCR1, MCR2, MCR3, MCR4
+	0x0063, 2, 0x08, 0x08,					// GX
+	0x0064, 2, 0x08, 0x08,					// GR
+	0x0065, 2, 0x99, 0x00,					// GER
+	0x0066, 2, 0x7C, 0x8B,					// STG
+	0x0067, 2, 0x00, 0x00,					// FTGR1, FTGR2
+	0x0068, 2, 0x20, 0x20,					// ATGR1, ATGR2
+	0x0069, 1, 0x4F,					// MMR1
+	0x006A, 1, 0x00,					// MMR2
+	0x006C, 1, 0x40,					// MMR3
+	0x0021, 1, 0x02,					// INIT
+	0x00A3, 1, 0x40,					// LMR1
+
+	0xFFFF};
+
+
 static void Amd7930_new_ph(struct IsdnCardState *cs);
 
 
diff -Nru -X dontdiff linux-2.4-vanilla/drivers/isdn/hisax/amd7930_fn.h linux-2.4/drivers/isdn/hisax/amd7930_fn.h
--- linux-2.4-vanilla/drivers/isdn/hisax/amd7930_fn.h	Fri Nov 29 00:53:13 2002
+++ linux-2.4/drivers/isdn/hisax/amd7930_fn.h	Sat Jan 31 16:39:05 2004
@@ -32,38 +32,5 @@
 
 #define DBUSY_TIMER_VALUE 80
 
-static WORD initAMD[] = {
-	0x0100,
-
-	0x00A5, 3, 0x01, 0x40, 0x58,				// LPR, LMR1, LMR2
-	0x0086, 1, 0x0B,					// DMR1 (D-Buffer TH-Interrupts on)
-	0x0087, 1, 0xFF,					// DMR2
-	0x0092, 1, 0x03,					// EFCR (extended mode d-channel-fifo on)
-	0x0090, 4, 0xFE, 0xFF, 0x02, 0x0F,			// FRAR4, SRAR4, DMR3, DMR4 (address recognition )
-	0x0084, 2, 0x80, 0x00,					// DRLR
-	0x00C0, 1, 0x47,					// PPCR1
-	0x00C8, 1, 0x01,					// PPCR2
-
-	0x0102,
-	0x0107,
-	0x01A1, 1,
-	0x0121, 1,
-	0x0189, 2,
-
-	0x0045, 4, 0x61, 0x72, 0x00, 0x00,			// MCR1, MCR2, MCR3, MCR4
-	0x0063, 2, 0x08, 0x08,					// GX
-	0x0064, 2, 0x08, 0x08,					// GR
-	0x0065, 2, 0x99, 0x00,					// GER
-	0x0066, 2, 0x7C, 0x8B,					// STG
-	0x0067, 2, 0x00, 0x00,					// FTGR1, FTGR2
-	0x0068, 2, 0x20, 0x20,					// ATGR1, ATGR2
-	0x0069, 1, 0x4F,					// MMR1
-	0x006A, 1, 0x00,					// MMR2
-	0x006C, 1, 0x40,					// MMR3
-	0x0021, 1, 0x02,					// INIT
-	0x00A3, 1, 0x40,					// LMR1
-
-	0xFFFF};
-
 extern void Amd7930_interrupt(struct IsdnCardState *cs, unsigned char irflags);
 extern void Amd7930_init(struct IsdnCardState *cs);


-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Alcuni pensano che io sia una persona orribile, ma non vero. Ho il
cuore di un ragazzino - in un vaso sulla scrivania.
