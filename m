Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbTCPBEQ>; Sat, 15 Mar 2003 20:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbTCPBEQ>; Sat, 15 Mar 2003 20:04:16 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:32128 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262207AbTCPBEG>; Sat, 15 Mar 2003 20:04:06 -0500
Date: Sun, 16 Mar 2003 10:14:11 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Complete support PC-9800 for 2.5.64-ac4 (10/11) PCMCIA
Message-ID: <20030316011411.GJ1592@yuzuki.cinet.co.jp>
References: <20030316001622.GA1061@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316001622.GA1061@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.64-ac4. (10/11)

Small change for PCMCIA (16bits) support.
For fix usable IRQ number.

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
