Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262427AbTCIESs>; Sat, 8 Mar 2003 23:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbTCIESr>; Sat, 8 Mar 2003 23:18:47 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:47232 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262427AbTCIESm>; Sat, 8 Mar 2003 23:18:42 -0500
Date: Sun, 9 Mar 2003 13:28:48 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (14/20) PCMCIA
Message-ID: <20030309042848.GO1231@yuzuki.cinet.co.jp>
References: <20030309035245.GA1231@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309035245.GA1231@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.64-ac3. (14/20)

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
