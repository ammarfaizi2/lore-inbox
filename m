Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbTBTM3N>; Thu, 20 Feb 2003 07:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbTBTM3I>; Thu, 20 Feb 2003 07:29:08 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:27008 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265361AbTBTM0S>; Thu, 20 Feb 2003 07:26:18 -0500
Date: Thu, 20 Feb 2003 21:34:56 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 additional for 2.5.61-ac1 (14/21) PNP
Message-ID: <20030220123456.GN1657@yuzuki.cinet.co.jp>
References: <20030220121620.GA1618@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220121620.GA1618@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional patch to support NEC PC-9800 subarchitecture
against 2.5.61-ac1. (14/21)

Small change for Legacy bus PNP support.
For fix IO port address.

diff -Nru linux/drivers/pnp/isapnp/core.c linux98/drivers/pnp/isapnp/core.c
--- linux/drivers/pnp/isapnp/core.c	2003-01-02 12:22:18.000000000 +0900
+++ linux98/drivers/pnp/isapnp/core.c	2003-01-04 16:40:40.000000000 +0900
@@ -72,8 +72,13 @@
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");
 
+#ifdef CONFIG_X86_PC9800
+#define _PIDXR		0x259
+#define _PNPWRP		0xa59
+#else
 #define _PIDXR		0x279
 #define _PNPWRP		0xa79
+#endif
 
 /* short tags */
 #define _STAG_PNPVERNO		0x01
