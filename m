Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264190AbTCXNDY>; Mon, 24 Mar 2003 08:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264191AbTCXNDX>; Mon, 24 Mar 2003 08:03:23 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:19840 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S264190AbTCXNDU>; Mon, 24 Mar 2003 08:03:20 -0500
Date: Mon, 24 Mar 2003 22:13:31 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.65-ac4] Complete support for PC-9800 sub-arch (8/9) PCMCIA
Message-ID: <20030324131331.GH2508@yuzuki.cinet.co.jp>
References: <20030324130025.GA2465@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324130025.GA2465@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac4. (8/9)

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
