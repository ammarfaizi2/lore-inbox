Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTBTM0g>; Thu, 20 Feb 2003 07:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTBTM0C>; Thu, 20 Feb 2003 07:26:02 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:26240 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265339AbTBTMZk>; Thu, 20 Feb 2003 07:25:40 -0500
Date: Thu, 20 Feb 2003 21:34:18 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 additional for 2.5.61-ac1 (13/21) PCMCIA
Message-ID: <20030220123418.GM1657@yuzuki.cinet.co.jp>
References: <20030220121620.GA1618@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220121620.GA1618@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional patch to support NEC PC-9800 subarchitecture
against 2.5.61-ac1. (13/21)

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
