Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbTCWHJT>; Sun, 23 Mar 2003 02:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbTCWHJN>; Sun, 23 Mar 2003 02:09:13 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:45696 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262908AbTCWHFg>; Sun, 23 Mar 2003 02:05:36 -0500
Date: Sun, 23 Mar 2003 16:15:46 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.65-ac3] Additionals for support PC-9800 (9/10) PCMCIA
Message-ID: <20030323071546.GI2951@yuzuki.cinet.co.jp>
References: <20030323065928.GF2851@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323065928.GF2851@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac3. (9/10)

Small change for PCMCIA (16bits) support.
For fix usable IRQ number.

Regards,
Osamu Tomita

diff -Nru linux-2.5.62-ac1/drivers/pcmcia/i82365.c linux98-2.5.62-ac1/drivers/pcmcia/i82365.c
--- linux-2.5.62-ac1/drivers/pcmcia/i82365.c	2003-02-18 07:56:55.000000000 +0900
+++ linux98-2.5.62-ac1/drivers/pcmcia/i82365.c	2003-02-21 11:14:30.000000000 +0900
@@ -188,7 +188,11 @@
 };
 
 /* Default ISA interrupt mask */
+#ifndef CONFIG_X86_PC9800
 #define I365_MASK	0xdeb8	/* irq 15,14,12,11,10,9,7,5,4,3 */
+#else
+#define I365_MASK	0xd668	/* irq 15,14,12,10,9,6,5,3 */
+#endif
 
 #ifdef CONFIG_ISA
 static int grab_irq;
