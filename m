Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbTBQO3r>; Mon, 17 Feb 2003 09:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBQOMJ>; Mon, 17 Feb 2003 09:12:09 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:31104 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267221AbTBQOKT>; Mon, 17 Feb 2003 09:10:19 -0500
Date: Mon, 17 Feb 2003 23:18:55 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (20/26) PCMCIA
Message-ID: <20030217141855.GT4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (20/26).

Small change for PCMCIA (16bits) support.
For fix usable IRQ number.

diff -Nru linux-2.5.50-ac1/drivers/pcmcia/i82365.c linux98-2.5.50-ac1/drivers/pcmcia/i82365.c
--- linux-2.5.50-ac1/drivers/pcmcia/i82365.c	2002-11-28 07:36:18.000000000 +0900
+++ linux98-2.5.50-ac1/drivers/pcmcia/i82365.c	2002-12-12 16:40:13.000000000 +0900
@@ -187,7 +187,11 @@
 };
 
 /* Default ISA interrupt mask */
+#ifndef CONFIG_X86_PC9800
 #define I365_MASK	0xdeb8	/* irq 15,14,12,11,10,9,7,5,4,3 */
+#else
+#define I365_MASK	0xd668	/* irq 15,14,12,10,9,6,5,3 */
+#endif
 
 #ifdef CONFIG_ISA
 static int grab_irq;
